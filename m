Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B810C433F5
	for <iommu@archiver.kernel.org>; Thu, 19 May 2022 16:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5064640183;
	Thu, 19 May 2022 16:51:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZyV3i_I1Zuif; Thu, 19 May 2022 16:51:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 380434012A;
	Thu, 19 May 2022 16:51:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB96EC0039;
	Thu, 19 May 2022 16:51:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 219B2C002D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 16:51:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D4D341D53
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 16:51:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IvZmeGZSLfE4 for <iommu@lists.linux-foundation.org>;
 Thu, 19 May 2022 16:51:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 267A141D3E
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 16:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652979113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SVNHgd637yFpnVRT/VPb10eNRsNLwvsz89UkGK5psWo=;
 b=ClwqTjOTKvnYF28F57CHMg/Z/v3a27BjPZMXufYrta+2Hhqjj2/yPbt4gM0ND2rkwgbF3X
 MWvVfgnG6eyipydG90YI2TtumJ4N8Uf9RXmm8WqiT+9ibw8ze7ZuZwpKiCsQ1RDMH/giKp
 WGu1iKKT7UpXqTshOcl2P/+vkfykIlc=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347-xo48VfbhP8CPGKK4s8CEHA-1; Thu, 19 May 2022 12:51:50 -0400
X-MC-Unique: xo48VfbhP8CPGKK4s8CEHA-1
Received: by mail-il1-f197.google.com with SMTP id
 e3-20020a056e020b2300b002d10200d90fso3511217ilu.2
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 09:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=SVNHgd637yFpnVRT/VPb10eNRsNLwvsz89UkGK5psWo=;
 b=ZI15ux5zaG/54oodBAJKxyhPo4HjZl/OcDAKCH8bt7vkj0H+v6nf00j5Am3SEsW2bo
 eMvLuHbfoqBvr17YATc92Mnlz5ZKHbM1c1e3VYfK9GMejLTvBJR2J39vNHNUrpj9mslN
 GTDE9x/h6YQxLydkz2ERJqwFbfJ4e2biEuqg7j/RtfH3UG1GbxDK2hsvxRq+akSTOhYo
 mbqTA3m9vipQQHkcYRZGEX/T1QS8Or+9Rjb/nzytFaZK+YMeZJgUBe9n81+XuVxOAnNE
 zQphzYHijM51XZQQzYiuWe/d1Ni+RQpMY8cgaXi9AuQZD/rWJ4xRd50d12BWUrlRCD07
 K65w==
X-Gm-Message-State: AOAM532xba73KE4CkGo8q2B63UawON1WT/ma+YyQRQxzIBETimhQeFGm
 4VpoW4c9d9dQbJ2OCV/ASdparP3AHO5SUW6yc+76oe/E8ChYUA86BzF7n4cyocLR+jz4Cmg0YsI
 JCzTSqoiFGkXi1DcEOVN3svdxSJg0GA==
X-Received: by 2002:a05:6e02:2146:b0:2d1:261a:6578 with SMTP id
 d6-20020a056e02214600b002d1261a6578mr3154737ilv.55.1652979110105; 
 Thu, 19 May 2022 09:51:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPxrK41snAZpOnHSIt2ln4PxSw+yu+/DVrArgkww6zRA8KdES02+WHVjrf22iy7+Q2+zaIFQ==
X-Received: by 2002:a05:6e02:2146:b0:2d1:261a:6578 with SMTP id
 d6-20020a056e02214600b002d1261a6578mr3154722ilv.55.1652979109912; 
 Thu, 19 May 2022 09:51:49 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 r5-20020a056638130500b0032e33767166sm34496jad.9.2022.05.19.09.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 May 2022 09:51:49 -0700 (PDT)
Date: Thu, 19 May 2022 10:51:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Message-ID: <20220519105147.21b0b9d0.alex.williamson@redhat.com>
In-Reply-To: <YoXydUP7TCb2YmOW@suse.de>
References: <0-v3-db7f0785022b+149-iommu_dma_block_jgg@nvidia.com>
 <183e155eae268c32e7d02f68846250702fe99065.camel@linux.ibm.com>
 <20220518191446.GU1343366@nvidia.com> <YoXydUP7TCb2YmOW@suse.de>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Qian Cai <quic_qiancai@quicinc.com>, Eric Farman <farman@linux.ibm.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

On Thu, 19 May 2022 09:32:05 +0200
Joerg Roedel <jroedel@suse.de> wrote:

> On Wed, May 18, 2022 at 04:14:46PM -0300, Jason Gunthorpe wrote:
> > Fixes: 0286300e6045 ("iommu: iommu_group_claim_dma_owner() must always assign a domain")
> > Reported-by: Eric Farman <farman@linux.ibm.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/vfio/vfio.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)  
> 
> That fix will be taken care of by Alex? Or does it need to go through
> the IOMMU tree?

The comment suggested my tree.  Jason, were you planning to post this
on its own instead of buried in a reply or shall we take it from here?
Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
