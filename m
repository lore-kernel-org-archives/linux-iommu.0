Return-Path: <SRS0=eXB1=N3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CCCC433EF
	for <iommu@archiver.kernel.org>; Sun,  5 Sep 2021 15:57:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B7D60F51
	for <iommu@archiver.kernel.org>; Sun,  5 Sep 2021 15:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69B7D60F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3199D80FC1;
	Sun,  5 Sep 2021 15:57:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MdXIjqGZFhUq; Sun,  5 Sep 2021 15:57:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 032A980FA6;
	Sun,  5 Sep 2021 15:57:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA34EC0010;
	Sun,  5 Sep 2021 15:57:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59DE7C000E
 for <iommu@lists.linux-foundation.org>; Sun,  5 Sep 2021 15:57:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 42B7F40212
 for <iommu@lists.linux-foundation.org>; Sun,  5 Sep 2021 15:57:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8D4bU6zytFw4 for <iommu@lists.linux-foundation.org>;
 Sun,  5 Sep 2021 15:57:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 59CC7401BF
 for <iommu@lists.linux-foundation.org>; Sun,  5 Sep 2021 15:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630857451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ALsSmxCI7zZzOlsgFfP2jF6WBrBi9RCCJjNwkZ0c/3s=;
 b=HbmKQ/IY83JWXQ2DlBSppysfTXKSMD3e2idIk2mKFyq+Xe8xewoN+qjVIZ2C8g/DxrckGM
 2JPUb73aS6w8VgecNi0pBytxrtnXUuZJarNKPsa3fpEAWFWaatgBt4DttWMntWyB3SYBtq
 m59x43kKbOTo0Jd9asV5jYCvNnk/7Ro=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-S_pt208TOauP0B5fZWJN0g-1; Sun, 05 Sep 2021 11:57:30 -0400
X-MC-Unique: S_pt208TOauP0B5fZWJN0g-1
Received: by mail-wr1-f72.google.com with SMTP id
 d10-20020adffbca000000b00157bc86d94eso611959wrs.20
 for <iommu@lists.linux-foundation.org>; Sun, 05 Sep 2021 08:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ALsSmxCI7zZzOlsgFfP2jF6WBrBi9RCCJjNwkZ0c/3s=;
 b=Ou1aFYcMod96LKZGEISmk+TWYnf+VX2Hp2FJZSIqrA4EHl5MRBjtcj3VbZZ4eQRtc8
 l0Tvcl/SAGA46Wx0en3Blu0+pKAWyaj1cxKPvGtlDrWopOmTFAIHoTKvexptBAvpXjh9
 4LKxcnXJlqn1qFRPwnEeXfGTNcZ2lXM2qimuT0q16tRPyU7oRl7CHf4oXYWltuvAcvxK
 1ReX+2rq+ajYHXNtFNa0+oYWmQCfa1blrrXbEOH0eqbu2C3L0zXR0XSGUPRHxp+sWPI2
 HF6JOHv4XBRdllJIhmD06S6OzWhsF09XRm7jkNMisKJLovGKPKMnWS33QwAUgY94n4he
 ko5w==
X-Gm-Message-State: AOAM533g311hbUTj93zT46hbZn2D0ZBm3Z/LSqjomkoMvXeftXe4M2UD
 bosp39yYATJJesdEFkM7003pzSitllEddBg7E5DHanmbcNEjmVro8sRj0kHutvttPjzxKbPsoPX
 jheKAq0bbE22jSvnoiNdaSD9HEnfrqw==
X-Received: by 2002:adf:f991:: with SMTP id f17mr9015616wrr.56.1630857449029; 
 Sun, 05 Sep 2021 08:57:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwnpG4c6ej4zR69bwXXhKihUsDCsR3fnY/KHrXw5h/ma0hALUo9/kK5Sd32+gteCqNYbS8Og==
X-Received: by 2002:adf:f991:: with SMTP id f17mr9015590wrr.56.1630857448836; 
 Sun, 05 Sep 2021 08:57:28 -0700 (PDT)
Received: from redhat.com ([2.55.131.183])
 by smtp.gmail.com with ESMTPSA id u16sm5501569wmc.41.2021.09.05.08.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Sep 2021 08:57:28 -0700 (PDT)
Date: Sun, 5 Sep 2021 11:57:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v13 03/13] file: Export receive_fd() to modules
Message-ID: <20210905115642-mutt-send-email-mst@kernel.org>
References: <20210831103634.33-1-xieyongji@bytedance.com>
 <20210831103634.33-4-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210831103634.33-4-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, christian.brauner@canonical.com,
 will@kernel.org, corbet@lwn.net, willy@infradead.org, hch@infradead.org,
 dan.carpenter@oracle.com, sgarzare@redhat.com, xiaodong.liu@intel.com,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, stefanha@redhat.com,
 songmuchun@bytedance.com, axboe@kernel.dk, zhe.he@windriver.com,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, bcrl@kvack.org,
 netdev@vger.kernel.org, joe@perches.com, robin.murphy@arm.com,
 mika.penttila@nextfour.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Aug 31, 2021 at 06:36:24PM +0800, Xie Yongji wrote:
> Export receive_fd() so that some modules can use
> it to pass file descriptor between processes without
> missing any security stuffs.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

This needs some acks from fs devels.
Viro?


> ---
>  fs/file.c            | 6 ++++++
>  include/linux/file.h | 7 +++----
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 86dc9956af32..210e540672aa 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1134,6 +1134,12 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
>  	return new_fd;
>  }
>  
> +int receive_fd(struct file *file, unsigned int o_flags)
> +{
> +	return __receive_fd(file, NULL, o_flags);
> +}
> +EXPORT_SYMBOL_GPL(receive_fd);
> +
>  static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags)
>  {
>  	int err = -EBADF;
> diff --git a/include/linux/file.h b/include/linux/file.h
> index 2de2e4613d7b..51e830b4fe3a 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -94,6 +94,9 @@ extern void fd_install(unsigned int fd, struct file *file);
>  
>  extern int __receive_fd(struct file *file, int __user *ufd,
>  			unsigned int o_flags);
> +
> +extern int receive_fd(struct file *file, unsigned int o_flags);
> +
>  static inline int receive_fd_user(struct file *file, int __user *ufd,
>  				  unsigned int o_flags)
>  {
> @@ -101,10 +104,6 @@ static inline int receive_fd_user(struct file *file, int __user *ufd,
>  		return -EFAULT;
>  	return __receive_fd(file, ufd, o_flags);
>  }
> -static inline int receive_fd(struct file *file, unsigned int o_flags)
> -{
> -	return __receive_fd(file, NULL, o_flags);
> -}
>  int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags);
>  
>  extern void flush_delayed_fput(void);
> -- 
> 2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
