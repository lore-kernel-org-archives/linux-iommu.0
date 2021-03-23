Return-Path: <SRS0=ZOt4=IV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A870EC433DB
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 02:06:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 176FB6196C
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 02:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176FB6196C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C995E4045A;
	Tue, 23 Mar 2021 02:06:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h61-InIRQCRc; Tue, 23 Mar 2021 02:06:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6635840423;
	Tue, 23 Mar 2021 02:06:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 259B8C000B;
	Tue, 23 Mar 2021 02:06:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A936DC0001
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 02:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 899F583D83
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 02:06:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jyQR0ZhoTtuG for <iommu@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 02:06:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB64E83D81
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 02:06:34 +0000 (UTC)
IronPort-SDR: 3baKE71soQOTtB/aV1zLCssXet5J4rurDmYXEan5d5kZn4vrOgFzHJmV7O1XdhVjGlBSgr0OKE
 FdzDy7lcq59Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="169719068"
X-IronPort-AV: E=Sophos;i="5.81,270,1610438400"; d="scan'208";a="169719068"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 19:06:34 -0700
IronPort-SDR: 0SGTCZ4RM8Nt9ZUPWX8VYrhcTHoRFl085zSc6JqB12wAOvXBtNF8uSmc5l0c5W+X8lgwVoVlmC
 wSR2ZODFfi1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,270,1610438400"; d="scan'208";a="435375555"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2021 19:06:31 -0700
Subject: Re: [PATCH 2/3] iommu/vt-d: Remove IOVA domain rcache flushing for
 CPU offlining
To: John Garry <john.garry@huawei.com>, dwmw2@infradead.org, joro@8bytes.org, 
 will@kernel.org
References: <1614600741-15696-1-git-send-email-john.garry@huawei.com>
 <1614600741-15696-3-git-send-email-john.garry@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f1743fc8-3968-2977-27fe-19b4a3babef9@linux.intel.com>
Date: Tue, 23 Mar 2021 09:57:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614600741-15696-3-git-send-email-john.garry@huawei.com>
Content-Language: en-US
Cc: robin.murphy@arm.com, iommu@lists.linux-foundation.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org
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

On 3/1/21 8:12 PM, John Garry wrote:
> Now that the core code handles flushing per-IOVA domain CPU rcaches,
> remove the handling here.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/intel/iommu.c | 31 -------------------------------
>   include/linux/cpuhotplug.h  |  1 -
>   2 files changed, 32 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index ee0932307d64..d1e66e1b07b8 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4065,35 +4065,6 @@ static struct notifier_block intel_iommu_memory_nb = {
>   	.priority = 0
>   };
>   
> -static void free_all_cpu_cached_iovas(unsigned int cpu)
> -{
> -	int i;
> -
> -	for (i = 0; i < g_num_of_iommus; i++) {
> -		struct intel_iommu *iommu = g_iommus[i];
> -		struct dmar_domain *domain;
> -		int did;
> -
> -		if (!iommu)
> -			continue;
> -
> -		for (did = 0; did < cap_ndoms(iommu->cap); did++) {
> -			domain = get_iommu_domain(iommu, (u16)did);
> -
> -			if (!domain || domain->domain.type != IOMMU_DOMAIN_DMA)
> -				continue;
> -
> -			iommu_dma_free_cpu_cached_iovas(cpu, &domain->domain);
> -		}
> -	}
> -}
> -
> -static int intel_iommu_cpu_dead(unsigned int cpu)
> -{
> -	free_all_cpu_cached_iovas(cpu);
> -	return 0;
> -}
> -
>   static void intel_disable_iommus(void)
>   {
>   	struct intel_iommu *iommu = NULL;
> @@ -4388,8 +4359,6 @@ int __init intel_iommu_init(void)
>   	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
>   	if (si_domain && !hw_pass_through)
>   		register_memory_notifier(&intel_iommu_memory_nb);
> -	cpuhp_setup_state(CPUHP_IOMMU_INTEL_DEAD, "iommu/intel:dead", NULL,
> -			  intel_iommu_cpu_dead);
>   
>   	down_read(&dmar_global_lock);
>   	if (probe_acpi_namespace_devices())
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index cedac9986557..85996494bec1 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -57,7 +57,6 @@ enum cpuhp_state {
>   	CPUHP_PAGE_ALLOC_DEAD,
>   	CPUHP_NET_DEV_DEAD,
>   	CPUHP_PCI_XGENE_DEAD,
> -	CPUHP_IOMMU_INTEL_DEAD,
>   	CPUHP_IOMMU_IOVA_DEAD,
>   	CPUHP_LUSTRE_CFS_DEAD,
>   	CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
