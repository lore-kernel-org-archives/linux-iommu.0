Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B9AC433EF
	for <iommu@archiver.kernel.org>; Tue, 19 Apr 2022 20:02:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0959416EB;
	Tue, 19 Apr 2022 20:02:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rQwB2nSomC5L; Tue, 19 Apr 2022 20:02:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4FBAC4187B;
	Tue, 19 Apr 2022 20:02:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12816C0033;
	Tue, 19 Apr 2022 20:02:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E4F1C002C
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 20:02:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 34A53410A6
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 20:02:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KMWcai-kxD_9 for <iommu@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 20:02:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C6C44109F
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 20:02:36 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id z19so13113134qtw.2
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 13:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=6CDFEYPwind4oeNceo60bPcQaOBxmMPkcuZbyCW2XIc=;
 b=H6yzMlPIaCOW2L5SHT3adB0uN2T9slwU5Iqe4dM8H4xTO8eaGW8mmBPQNO5u/dxvkl
 j4K/dCwo+7rJK16wapkl8JEq7Xup/2+ubrRlqIiM8CisNBTobQHCV18/Azq18CqJEvu2
 U/DXOVkogz+Erij+giIZb55ed9LnluaEj7E8Kc/0kLJ04uuKsy3Iks0wkbeZdX7R+AY6
 eBD4dr5Ne1ez/yfVqghpn2MQ1N9CwbfOFYNXi2oh/cN4rbw9Iw+6As3dCXS3zOvMDZnD
 xhNAP56KX3JKYi5ggqpejQ8fFPVseY4nHQ2AzyNsIU/8GVggvLB4JKnezC1XK0f+ddBE
 Nd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6CDFEYPwind4oeNceo60bPcQaOBxmMPkcuZbyCW2XIc=;
 b=gwdcml8uH6sN0qj60KJVz2kmcTEDjZLe6I43oIzWZCNP92aw0Kuw3u/hj0kCgu8M4y
 IdTDN1tFMXEn5dH6vxeM/I3GID8Y4eCDYp3SNU7vPx7yJbBJwIim4A2dMpVu/eCE+Poh
 DJzPhX5oiE/svmnKZY9XuvxKBS8VMOAk/cR1w/90DAeohA/yAXuam7bgLfJF6T0i+pi4
 ciy91DlJxWd8L0JltphUq1HCzVOtU09mI7tTMi73umfwyZ7hp3ja1HX2owHeX5pL9zL5
 vGJWvf/MIhgs5O55cB0l951aKU4Qm4QjKqUbPV16RY7OW5sOOTDtn4CxRmOtm2sjT8Wr
 wrlA==
X-Gm-Message-State: AOAM532n9sePHpvscdeXtYMJRq/t/UsN9Syih9YAZWlfvCq6dVpxdhiu
 mFwgP+s1p91JPfdOpblJyVud8g==
X-Google-Smtp-Source: ABdhPJxDoOZBm5NJUNt0Lmrkf9wvSWVfT2Aj29QkkmYznu4GEo/xOWzCwWugY9BzCInq4cE1rBPXWA==
X-Received: by 2002:ac8:5c8a:0:b0:2e1:a65f:5122 with SMTP id
 r10-20020ac85c8a000000b002e1a65f5122mr11583018qta.239.1650398555129; 
 Tue, 19 Apr 2022 13:02:35 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129]) by smtp.gmail.com with ESMTPSA id
 a28-20020a05620a02fc00b0069e8e766a0csm457007qko.94.2022.04.19.13.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Apr 2022 13:02:34 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1ngu3V-005KB2-HU; Tue, 19 Apr 2022 17:02:33 -0300
Date: Tue, 19 Apr 2022 17:02:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Align size in __arm_smmu_tlb_inv_range
Message-ID: <20220419200233.GN64706@ziepe.ca>
References: <20220413041745.35174-1-nicolinc@nvidia.com>
 <37c02fc4-d793-b003-f612-206c987a8a42@arm.com>
 <YlcwPG5RXmJ6U7YS@Asurada-Nvidia>
 <13c91dfb-c540-ed8d-daa7-eab7207df221@arm.com>
 <Yloj6GM+yykImKvp@Asurada-Nvidia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yloj6GM+yykImKvp@Asurada-Nvidia>
Cc: jean-philippe@linaro.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 christophe.jaillet@wanadoo.fr, tglx@linutronix.de, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On Fri, Apr 15, 2022 at 07:03:20PM -0700, Nicolin Chen wrote:

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index d816759a6bcf..e280568bb513 100644
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -183,7 +183,7 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
>  {
>         struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
>         struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
> -       size_t size = end - start + 1;
> +       size_t size = end - start;

+1 to this bug fix. You should send a formal patch for stable with a fixes/etc

mmu notifiers uses 'end' not 'last' in alignment with how VMA's work:

include/linux/mm_types.h:       unsigned long vm_end;           /* The first byte after our end address

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
