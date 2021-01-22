Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81782C433E0
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 13:30:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03DF1239D1
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 13:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DF1239D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A14BC1FEF0;
	Fri, 22 Jan 2021 13:30:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SZRd60hNq4Hr; Fri, 22 Jan 2021 13:30:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3E618204D9;
	Fri, 22 Jan 2021 13:30:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D2C0C08A1;
	Fri, 22 Jan 2021 13:30:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C711FC013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:30:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B4953872A2
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:30:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D6nQcb4Jn1zh for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 13:30:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 497F7872A3
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:30:41 +0000 (UTC)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DMg3d0S36z67d8S;
 Fri, 22 Jan 2021 21:25:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 22 Jan 2021 14:30:37 +0100
Received: from localhost (10.47.73.222) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 22 Jan
 2021 13:30:36 +0000
Date: Fri, 22 Jan 2021 13:29:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 0/3] iommu/arm-smmu-v3: TLB invalidation for SVA
Message-ID: <20210122132955.00000d4f@Huawei.com>
In-Reply-To: <20210122115257.2502526-1-jean-philippe@linaro.org>
References: <20210122115257.2502526-1-jean-philippe@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.47.73.222]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: vivek.gautam@arm.com, will@kernel.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, robin.murphy@arm.com,
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

On Fri, 22 Jan 2021 12:52:55 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> To support sharing page tables with the CPU, the SMMU can participate in
> Broadcast TLB Maintenance (BTM), where TLB invalidate instructions from
> the CPU are received by the SMMU. For platforms that do no implement BTM
> [1], it is still possible to use SVA, by sending all TLB invalidations
> through the command queue. Patch 2 implements this.
> 
> This series also enables SVA for platforms that do support BTM, as an
> intermediate step because properly supporting BTM requires cooperating
> with KVM to allocate VMIDs [2]. With BTM enabled, the SMMU applies
> broadcast invalidations by VMID to any matching TLB entry, because there
> is no distinction between private and shared VMIDs like there is for
> ASIDs. Therefore a stage-2 domain will need a VMID that doesn't conflict
> with one allocated by KVM (or use the one from the corresponding VM,
> pinned).
> 
> These patches, along with the IOPF series [3] and the quirks [4], enable
> SVA for the hisi accelerator that's already supported upstream. My quick
> performance comparison between BTM and !BTM on that platform were
> inconclusive. Doing invalidations via cmdq seemed to slightly reduce
> performance of some heavy compression jobs, but there was too much noise
> and not enough invalidations in my tests.
> 
> This series does not depend on the IOPF one [3].
> 
> [1] https://lore.kernel.org/linux-iommu/BY5PR12MB37641E84D516054387FEE330B3CC0@BY5PR12MB3764.namprd12.prod.outlook.com/
> [2] https://lore.kernel.org/linux-iommu/20200522101755.GA3453945@myrica/
> [3] https://lore.kernel.org/linux-iommu/20210121123623.2060416-1-jean-philippe@linaro.org/
> [4] https://lore.kernel.org/linux-pci/1610960316-28935-1-git-send-email-zhangfei.gao@linaro.org/

Whole series looks good to me so FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Will be very nice to have mainline support for SVA with those accelerators :)

> 
> Jean-Philippe Brucker (3):
>   iommu/arm-smmu-v3: Split arm_smmu_tlb_inv_range()
>   iommu/arm-smmu-v3: Make BTM optional for SVA
>   iommu/arm-smmu-v3: Add support for VHE
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   6 +
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  14 ++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 104 ++++++++++++------
>  3 files changed, 89 insertions(+), 35 deletions(-)
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
