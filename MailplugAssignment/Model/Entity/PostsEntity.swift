//
//  PostsEntity.swift
//  MailplugAssignment
//
//  Created by 장혜성 on 2023/11/21.
//

import Foundation


struct PostsEntity {
    let value: [PostsEntityValue]
    let count: Int
    let offset: Int
    let limit: Int
    let total: Int
}

struct PostsEntityValue {
    let postId: Int
    let title: String
    let boardId: Int
    let boardDisplayName: String
    let writer: PostsEntityWriter
    let contents: String
    let createdDateTime: String     // 게시글 작성 시간
    let viewCount: Int
    let postType: String        // 작성 type
    let isNewPost: Bool
    let hasInlineImage: Bool    // 인라인 이미지 유무
    let commentsCount: Int      // 댓글 수
    let attachmentsCount: Int       // 첨부파일 수
    let isAnonymous: Bool           // 익명 여부
    let isOwner: Bool               // 글 소유자
    let hasReply: Bool              // 답글 유무
}

struct PostsEntityWriter {
    let displayName: String         // 게시글 작성자 이름
    let emailAddress: String        // 게시글 작성자 이메일
}
