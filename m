Return-Path: <SRS0=6oxg=MB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3419C07E9E
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 14:17:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83325613BD
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 14:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83325613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46B1E60B38;
	Fri,  9 Jul 2021 14:17:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id adaTCS7qdlaH; Fri,  9 Jul 2021 14:17:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1582F6065A;
	Fri,  9 Jul 2021 14:17:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E53F2C0010;
	Fri,  9 Jul 2021 14:17:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD453C000E;
 Fri,  9 Jul 2021 14:17:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 94A79423D1;
 Fri,  9 Jul 2021 14:17:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K71P7IHkmBAQ; Fri,  9 Jul 2021 14:17:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 472C5423B9;
 Fri,  9 Jul 2021 14:17:35 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="209521815"
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; d="scan'208";a="209521815"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2021 07:17:32 -0700
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; d="scan'208";a="488060340"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.213])
 ([10.254.208.213])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2021 07:17:28 -0700
Subject: Re: [RFC v1 4/8] intel/vt-d: export intel_iommu_get_resv_regions
To: Wei Liu <wei.liu@kernel.org>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-5-wei.liu@kernel.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f32e17d4-e435-cd50-8afc-68f6133fd1a0@linux.intel.com>
Date: Fri, 9 Jul 2021 22:17:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210709114339.3467637-5-wei.liu@kernel.org>
Content-Language: en-US
Cc: pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>,
 kumarpraveen@linux.microsoft.com, David Woodhouse <dwmw2@infradead.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 "open list:INTEL IOMMU \(VT-d\)" <iommu@lists.linux-foundation.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Michael Kelley <mikelley@microsoft.com>,
 Vineeth Pillai <viremana@linux.microsoft.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021/7/9 19:43, Wei Liu wrote:
> When Microsoft Hypervisor runs on Intel platforms it needs to know the
> reserved regions to program devices correctly. There is no reason to
> duplicate intel_iommu_get_resv_regions. Export it.

Why not using iommu_get_resv_regions()?

Best regards,
baolu

> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>   drivers/iommu/intel/iommu.c | 5 +++--
>   include/linux/intel-iommu.h | 4 ++++
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index a4294d310b93..01973bc20080 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5176,8 +5176,8 @@ static void intel_iommu_probe_finalize(struct device *dev)
>   		set_dma_ops(dev, NULL);
>   }
>   
> -static void intel_iommu_get_resv_regions(struct device *device,
> -					 struct list_head *head)
> +void intel_iommu_get_resv_regions(struct device *device,
> +				 struct list_head *head)
>   {
>   	int prot = DMA_PTE_READ | DMA_PTE_WRITE;
>   	struct iommu_resv_region *reg;
> @@ -5232,6 +5232,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
>   		return;
>   	list_add_tail(&reg->list, head);
>   }
> +EXPORT_SYMBOL_GPL(intel_iommu_get_resv_regions);
>   
>   int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
>   {
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 03faf20a6817..f91869f765bc 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -814,6 +814,8 @@ extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
>   extern int dmar_disabled;
>   extern int intel_iommu_enabled;
>   extern int intel_iommu_gfx_mapped;
> +extern void intel_iommu_get_resv_regions(struct device *device,
> +				 struct list_head *head);
>   #else
>   static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
>   {
> @@ -825,6 +827,8 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
>   }
>   #define dmar_disabled	(1)
>   #define intel_iommu_enabled (0)
> +static inline void intel_iommu_get_resv_regions(struct device *device,
> +				 struct list_head *head) {}
>   #endif
>   
>   #endif
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
