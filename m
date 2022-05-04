Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC13C433F5
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 16:30:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 940154017E;
	Wed,  4 May 2022 16:30:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3P6oJboFeqqA; Wed,  4 May 2022 16:30:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6B63F402F6;
	Wed,  4 May 2022 16:30:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C068C0039;
	Wed,  4 May 2022 16:30:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3B94C0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 16:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C8E69418E7
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 16:30:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XJi0ynkOAC_G for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 16:30:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF824418DF
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651681800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NfP/UR6OPnC+oXgVhupwYcLyZYqW5PBXZPnFnfatuk=;
 b=ZnUgYYzcykOk6fBzwVCuAtOMKJ1g57xP8heHjIZvHtjJdvLVPV0RQHJN0P5LclpQ6NZSZF
 3CtqilZEHP8ReCQeqsi06WCs/GU3sc2VYCHPMpDWHSwyJ/0Z6uqFj0cqRhYcBjUI6V8wXg
 UmZ4bVNFiWpwHLrZwDT7Y1TVuE9Cw5c=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-LdnsmhlWOc6N7Tf05dGBcw-1; Wed, 04 May 2022 12:29:59 -0400
X-MC-Unique: LdnsmhlWOc6N7Tf05dGBcw-1
Received: by mail-il1-f199.google.com with SMTP id
 i24-20020a056e021d1800b002cf0541f514so947146ila.13
 for <iommu@lists.linux-foundation.org>; Wed, 04 May 2022 09:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=9NfP/UR6OPnC+oXgVhupwYcLyZYqW5PBXZPnFnfatuk=;
 b=bC8/8OV5l++TtJqJQEp/86+/LFkjVn6Ufmp4ulclCoDrTs7ybPPiMaZXE0FME85UmS
 W4rRp5T0QwGVr8GbfaSeJO/QDCFGaoJi6uR5Gai3XsQ7ZYRJOQPChdK0EWi4oLn25bjQ
 PvD1vDo7DIytUEu7aV+0tB38uYrn0h1PCY5flTqOp2wkPHKAuMex4A9cmE0tfUCIlK/5
 B+wg1oaIrr9NffIjM8vgf4yO7NYZ0AlDZuRWORrWal9n77FiZHu4nhe8rBu6jDZYMetw
 iZGT59IEcOVgpVmJ/iaky43X0Sw9TSeJLdLJIVnYtsS1bE1sU5rerw2WUvO1OwX9Rw+S
 +Ppg==
X-Gm-Message-State: AOAM532KhEdmUyR17X0AubEfBGpVx4CIg8wt3Dal6ZwCJHKuuRkD9PpX
 CUxQBqGT6nz5Ntq8lAHcHkUwOuCWrWSFBE7pVIcEaBSa6cwRnvt5TJyljYueGQ8sXGltDN7E7Dl
 +423q0WzmXkaZAtGWN9P3t1AENI7emw==
X-Received: by 2002:a05:6638:d0a:b0:328:73fb:b1d1 with SMTP id
 q10-20020a0566380d0a00b0032873fbb1d1mr9317799jaj.132.1651681798496; 
 Wed, 04 May 2022 09:29:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyR6bryE40k5D++tCeFIB0474lSTQMcR229H0fNBSGuVad/VwNuHzUMzmxnfKY82WXLYiKgzQ==
X-Received: by 2002:a05:6638:d0a:b0:328:73fb:b1d1 with SMTP id
 q10-20020a0566380d0a00b0032873fbb1d1mr9317776jaj.132.1651681797984; 
 Wed, 04 May 2022 09:29:57 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 z9-20020a056638214900b0032b3a781793sm4812788jaj.87.2022.05.04.09.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 May 2022 09:29:57 -0700 (PDT)
Date: Wed, 4 May 2022 10:29:56 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <20220504102956.0f5b5302.alex.williamson@redhat.com>
In-Reply-To: <YnI8Xy54M3XQpS0T@8bytes.org>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
 <20220502161204.GA22@qian> <YnI8Xy54M3XQpS0T@8bytes.org>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Kevin Tian <kevin.tian@intel.com>, Qian Cai <quic_qiancai@quicinc.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>
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

On Wed, 4 May 2022 10:42:07 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> On Mon, May 02, 2022 at 12:12:04PM -0400, Qian Cai wrote:
> > Reverting this series fixed an user-after-free while doing SR-IOV.
> > 
> >  BUG: KASAN: use-after-free in __lock_acquire  
> 
> Hrm, okay. I am going exclude this series from my next branch for now
> until this has been sorted out.
> 
> Alex, I suggest you do the same.

Done, and thanks for the heads-up.  Please try to cc me when the
vfio-notifier-fix branch is merged back into your next branch.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
