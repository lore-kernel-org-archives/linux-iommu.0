Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EB0C433F5
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 20:27:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 50504400FB;
	Tue, 17 May 2022 20:27:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HotY5oZ8K5MR; Tue, 17 May 2022 20:27:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3536C40143;
	Tue, 17 May 2022 20:27:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EEA5C0039;
	Tue, 17 May 2022 20:27:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40285C002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 20:27:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F4F640143
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 20:27:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rg7-NK_q5Pg4 for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 20:27:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 35FD1400FB
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 20:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652819221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RX9upDrgl+JlhubOZECKMiNUlSGALkg7zYaH+YeMTbs=;
 b=azQNIK+azywAg00boRt0qruoX7s2s07b46i1VIZJ48AiKn5xma/Zm0VQDghPnb/T29v5+S
 UfZEiwItpb1bc2/EC/YbOAI3iSfaOzzoldxYKtPi7ThO8K0sgaxwW1MuSB/eDarvYzK1i/
 EBmngRbrkDwV1N3ucw1aJL952Bx3jdo=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-Vh4DUzYcPS2fQMylvMUF1Q-1; Tue, 17 May 2022 16:27:00 -0400
X-MC-Unique: Vh4DUzYcPS2fQMylvMUF1Q-1
Received: by mail-il1-f197.google.com with SMTP id
 g11-20020a056e021a2b00b002cf48b48824so70086ile.21
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 13:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=RX9upDrgl+JlhubOZECKMiNUlSGALkg7zYaH+YeMTbs=;
 b=QAAso38mA1m7n4ztVqXAxZ1ZBOXWsGF4s9zSeIVWLbdGxKUsiamD3m5k56Dy+OK9gl
 Wrx0tQ9JiUfLaaYj2w+qqHHRgGID8AmNiDysThogxMGXYwteCSYbrMdLzQvmMxJ0k9sK
 kU3dTH7NLsCewA5NveBUVgvSSaz7E4EyfEMEJxgWNE3gFnlgWgYsxtEDWfwSbPQxFCY0
 hnF2+IOS9V+jyzW+Aei+0g46HZw86LBDjRubawUUJ4RA5lCLUmI/jdvEpR5ohdpc3pT4
 8FKw+CZBK1OAhxQrB8FTNMhyuWF8p3ze0viuHWvCeOcRP4nzczgsKC4+YB8bqn23Cl/H
 fy4A==
X-Gm-Message-State: AOAM530W86J3YJ+0JZxk858d/dF3i2cwrjunxVfsgRElRAgl63vF6o9G
 u+DEGpcdM56wNGYDV1Fms9GoK9jn/WW9D22VpcS9m2B8Z3WO/LhxoNjqqNCZf+IJeFHAKlkhZju
 ydFDtSskLsQGEPPbClVi4o7AVjz8eKg==
X-Received: by 2002:a92:cac4:0:b0:2c8:1095:b352 with SMTP id
 m4-20020a92cac4000000b002c81095b352mr11988154ilq.103.1652819218956; 
 Tue, 17 May 2022 13:26:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeEI0mf6y/nWlK0I2cVK0c81aFILPDB/atAD9zcPbSBdqjQTCdzs8m0yRuQ4ofsMRcU9qzYw==
X-Received: by 2002:a92:cac4:0:b0:2c8:1095:b352 with SMTP id
 m4-20020a92cac4000000b002c81095b352mr11988133ilq.103.1652819218343; 
 Tue, 17 May 2022 13:26:58 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 j12-20020a02cc6c000000b0032e0720e2ffsm19301jaq.86.2022.05.17.13.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 May 2022 13:26:57 -0700 (PDT)
Date: Tue, 17 May 2022 14:26:56 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] vfio: Remove VFIO_TYPE1_NESTING_IOMMU
Message-ID: <20220517142656.140deb10.alex.williamson@redhat.com>
In-Reply-To: <0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com>
References: <0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Tue, 10 May 2022 13:55:24 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> This control causes the ARM SMMU drivers to choose a stage 2
> implementation for the IO pagetable (vs the stage 1 usual default),
> however this choice has no visible impact to the VFIO user. Further qemu
> never implemented this and no other userspace user is known.
> 
> The original description in commit f5c9ecebaf2a ("vfio/iommu_type1: add
> new VFIO_TYPE1_NESTING_IOMMU IOMMU type") suggested this was to "provide
> SMMU translation services to the guest operating system" however the rest
> of the API to set the guest table pointer for the stage 1 was never
> completed, or at least never upstreamed, rendering this part useless dead
> code.
> 
> Since the current patches to enable nested translation, aka userspace page
> tables, rely on iommufd and will not use the enable_nesting()
> iommu_domain_op, remove this infrastructure. However, don't cut too deep
> into the SMMU drivers for now expecting the iommufd work to pick it up -
> we still need to create S2 IO page tables.
> 
> Remove VFIO_TYPE1_NESTING_IOMMU and everything under it including the
> enable_nesting iommu_domain_op.
> 
> Just in-case there is some userspace using this continue to treat
> requesting it as a NOP, but do not advertise support any more.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ----------------
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 16 ----------------
>  drivers/iommu/iommu.c                       | 10 ----------
>  drivers/vfio/vfio_iommu_type1.c             | 12 +-----------
>  include/linux/iommu.h                       |  3 ---
>  include/uapi/linux/vfio.h                   |  2 +-
>  6 files changed, 2 insertions(+), 57 deletions(-)
> 
> It would probably make sense for this to go through the VFIO tree with Robin's
> ack for the SMMU changes.

I'd be in favor of applying this, but it seems Robin and Eric are
looking for a stay of execution and I'd also be looking for an ack from
Joerg.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
