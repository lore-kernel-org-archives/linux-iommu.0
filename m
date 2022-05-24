Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236F6C433F5
	for <iommu@archiver.kernel.org>; Tue, 24 May 2022 16:07:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D5EB2401B1;
	Tue, 24 May 2022 16:07:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JZ1tNk0BluMk; Tue, 24 May 2022 16:07:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A428F400A6;
	Tue, 24 May 2022 16:07:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E845C0032;
	Tue, 24 May 2022 16:07:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 320AEC002D
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 16:07:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2EBFE83EF7
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 16:07:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VYBI8gongxub for <iommu@lists.linux-foundation.org>;
 Tue, 24 May 2022 16:07:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D838182E29
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 16:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653408465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4LwcXrIKv9x0Mf2x0EaHmSXiWcvTYj/VJq4XvycqoUs=;
 b=SFsl8kIfmrH3SnsXLrF/EObsdfwrifYUwyepwzw4Q/7ZN+Ch78ria2SPPlp2eCZhjROy5l
 3iS8JDujHMyoheIaiJ41y1i9Za09G+K+wW0weY5Ks9PFt4CszwXElBESahc1aU1l55no6z
 r578BrFy0KHFUgjXupsASnKxuBi4SqU=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-240I3F1HNx2a6GOWIt23mQ-1; Tue, 24 May 2022 12:07:43 -0400
X-MC-Unique: 240I3F1HNx2a6GOWIt23mQ-1
Received: by mail-il1-f200.google.com with SMTP id
 b13-20020a92670d000000b002d1a5d6b795so4380048ilc.16
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 09:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=4LwcXrIKv9x0Mf2x0EaHmSXiWcvTYj/VJq4XvycqoUs=;
 b=3A3FGiUadV3w6d0LLSw9fbKZ7dhBCh2ADw4vl6BfgfeCJIWUj7Rde+Ifo4MavH2yPx
 f0lyFmNfh8KVk8Ht6HRxNB3t7whnNF6eg6fe2Dar6JA5Xqa8DIxzrqRhVUCk2JSXkF1Y
 0UR1gHLPtHF+oIvLd2qLhAcHyk3IgpW9gPZBSnHL0ISeUFFKPRjbDd9j3UmyehfguYIA
 mqmsksNb9tCxsrtFMWRrPqAu/iWuQb/GhwZKJEacKqnmei1PiKARgX8UhApj1uSfwk3C
 IhPzy/SjwmhMPs5rXPrwlU6a1DwFk7eJF8sS81dUeCfjr9NNJz/68B4SMvNcdU/eCRrA
 pU3Q==
X-Gm-Message-State: AOAM532XLpHm+gFWSGNRBvq4cRZH15LGCrevHjjv4EMRrYKVF1mY6OPh
 0a0fgQb7QBciB8Ov5N18KwybbQjpfe+9r8gzbVN4L4lcQ71Hp1x0dfhUke++flmgd5felq2ESEu
 mtWrP8N//Kfc/FwoPm5jLTyhJ8RegSQ==
X-Received: by 2002:a02:9582:0:b0:32e:98ba:75e4 with SMTP id
 b2-20020a029582000000b0032e98ba75e4mr10429506jai.305.1653408460393; 
 Tue, 24 May 2022 09:07:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrvqWk8ngiJV3Knc6VMVBwVD0PeuAK67QqhdEBmUAwKPRdwCD+sBPuLMVAGTutZeXhMBorEQ==
X-Received: by 2002:a02:9582:0:b0:32e:98ba:75e4 with SMTP id
 b2-20020a029582000000b0032e98ba75e4mr10429493jai.305.1653408460126; 
 Tue, 24 May 2022 09:07:40 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 o26-20020a02741a000000b0032e85741287sm3509843jac.141.2022.05.24.09.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 May 2022 09:07:39 -0700 (PDT)
Date: Tue, 24 May 2022 10:07:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] vfio: Do not manipulate iommu dma_owner for fake iommu
 groups
Message-ID: <20220524100737.24420c3f.alex.williamson@redhat.com>
In-Reply-To: <0-v1-9cfc47edbcd4+13546-vfio_dma_owner_fix_jgg@nvidia.com>
References: <0-v1-9cfc47edbcd4+13546-vfio_dma_owner_fix_jgg@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eric Farman <farman@linux.ibm.com>, Joerg Roedel <jroedel@suse.de>,
 kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>
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

On Thu, 19 May 2022 14:03:48 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> Since asserting dma ownership now causes the group to have its DMA blocked
> the iommu layer requires a working iommu. This means the dma_owner APIs
> cannot be used on the fake groups that VFIO creates. Test for this and
> avoid calling them.
> 
> Otherwise asserting dma ownership will fail for VFIO mdev devices as a
> BLOCKING iommu_domain cannot be allocated due to the NULL iommu ops.
> 
> Fixes: 0286300e6045 ("iommu: iommu_group_claim_dma_owner() must always assign a domain")
> Reported-by: Eric Farman <farman@linux.ibm.com>
> Tested-by: Eric Farman <farman@linux.ibm.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/vfio.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Applied to vfio next branch for v5.19.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
