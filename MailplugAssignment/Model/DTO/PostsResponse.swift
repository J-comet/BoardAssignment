//
//  PostsResponse.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/21.
//

import Foundation


struct PostsResponse: Decodable, CreatEntityProtocol {
    let value: [PostsResponseValue]?
    let count: Int?
    let offset: Int?
    let limit: Int?
    let total: Int?
    
    func toEntity() -> PostsEntity {
        return PostsEntity(
            value: value?.map { $0.toEntity() } ?? [],
            count: count ?? 0,
            offset: offset ?? 0,
            limit: limit ?? 0,
            total: total ?? 0
        )
    }
}

struct PostsResponseValue: Decodable, CreatEntityProtocol {
    let postID: Int?
    let title: String?
    let boardID: Int?
    let boardDisplayName: String?
    let writer: PostsResponseWriter?
    let contents: String?
    let createdDateTime: String?     // 게시글 작성 시간
    let viewCount: Int?
    let postType: String?        // 작성 type
    let isNewPost: Bool?
    let hasInlineImage: Bool?    // 인라인 이미지 유무
    let commentsCount: Int?      // 댓글 수
    let attachmentsCount: Int?       // 첨부파일 수
    let isAnonymous: Bool?           // 익명 여부
    let isOwner: Bool?               // 글 소유자
    let hasReply: Bool?              // 답글 유무
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case title
        case boardID = "boardId"
        case boardDisplayName
        case writer
        case contents
        case createdDateTime
        case viewCount
        case postType
        case isNewPost
        case hasInlineImage
        case commentsCount
        case attachmentsCount
        case isAnonymous
        case isOwner
        case hasReply
    }
    
    
    func toEntity() -> PostsEntityValue {
        return PostsEntityValue(
            postId: postID ?? 0,
            title: title ?? "",
            boardId: boardID ?? 0,
            boardDisplayName: boardDisplayName ?? "",
            writer: writer?.toEntity() ?? PostsEntityWriter(displayName: "", emailAddress: ""),
            contents: contents ?? "",
            createdDateTime: createdDateTime ?? "",
            viewCount: viewCount ?? 0,
            postType: postType ?? "",
            isNewPost: isNewPost ?? false,
            hasInlineImage: hasInlineImage ?? false,
            commentsCount: commentsCount ?? 0,
            attachmentsCount: attachmentsCount ?? 0,
            isAnonymous: isAnonymous ?? false,
            isOwner: isOwner ?? false,
            hasReply: hasReply ?? false
        )
    }
}

struct PostsResponseWriter: Decodable, CreatEntityProtocol {
    let displayName: String?
    let emailAddress: String?
    
    func toEntity() -> PostsEntityWriter {
        return PostsEntityWriter(displayName: displayName ?? "", emailAddress: emailAddress ?? "")
    }
}

