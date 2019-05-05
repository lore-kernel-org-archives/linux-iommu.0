Return-Path: <SRS0=W6tT=TF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40897C04AAA
	for <iommu@archiver.kernel.org>; Sun,  5 May 2019 02:44:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19CB420675
	for <iommu@archiver.kernel.org>; Sun,  5 May 2019 02:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CB420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C6E1042C6;
	Sun,  5 May 2019 02:44:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7B41B3E34
	for <iommu@lists.linux-foundation.org>;
	Sun,  5 May 2019 02:44:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4333587
	for <iommu@lists.linux-foundation.org>;
	Sun,  5 May 2019 02:44:02 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 May 2019 19:44:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,431,1549958400"; d="scan'208";a="146346574"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga008.fm.intel.com with ESMTP; 04 May 2019 19:43:55 -0700
Subject: Re: [RFC 6/7] iommu/vt-d: convert the intel iommu driver to the
	dma-iommu ops api
To: Tom Murphy <tmurphy@arista.com>, iommu@lists.linux-foundation.org
References: <20190504132327.27041-1-tmurphy@arista.com>
	<20190504132327.27041-7-tmurphy@arista.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <602b77a2-9c68-ad14-b64f-904a7ff27a15@linux.intel.com>
Date: Sun, 5 May 2019 10:37:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504132327.27041-7-tmurphy@arista.com>
Content-Language: en-US
Cc: Heiko Stuebner <heiko@sntech.de>, kvm@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>, David Brown <david.brown@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
	Kukjin Kim <kgene@kernel.org>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	Andy Gross <andy.gross@linaro.org>, linux-tegra@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, murphyt7@tcd.ie,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi,

On 5/4/19 9:23 PM, Tom Murphy wrote:
> static int intel_iommu_add_device(struct device *dev)
>   {
> +	struct dmar_domain *dmar_domain;
> +	struct iommu_domain *domain;
>   	struct intel_iommu *iommu;
>   	struct iommu_group *group;
> -	struct iommu_domain *domain;
> +	dma_addr_t base;
>   	u8 bus, devfn;
>   
>   	iommu = device_to_iommu(dev, &bus, &devfn);
> @@ -4871,9 +4514,12 @@ static int intel_iommu_add_device(struct device *dev)
>   	if (IS_ERR(group))
>   		return PTR_ERR(group);
>   
> +	base = IOVA_START_PFN << VTD_PAGE_SHIFT;
>   	domain = iommu_get_domain_for_dev(dev);
> +	dmar_domain = to_dmar_domain(domain);
>   	if (domain->type == IOMMU_DOMAIN_DMA)
> -		dev->dma_ops = &intel_dma_ops;
> +		iommu_setup_dma_ops(dev, base,
> +				__DOMAIN_MAX_ADDR(dmar_domain->gaw) - base);

I didn't find the implementation of iommu_setup_dma_ops() in this
series. Will the iova resource be initialized in this function?

If so, will this block iommu_group_create_direct_mappings() which
reserves and maps the reserved iova ranges.

>   
>   	iommu_group_put(group);
>   	return 0;
> @@ -5002,19 +4648,6 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
>   	return ret;
>   }
>   
> -static void intel_iommu_apply_resv_region(struct device *dev,
> -					  struct iommu_domain *domain,
> -					  struct iommu_resv_region *region)
> -{
> -	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> -	unsigned long start, end;
> -
> -	start = IOVA_PFN(region->start);
> -	end   = IOVA_PFN(region->start + region->length - 1);
> -
> -	WARN_ON_ONCE(!reserve_iova(&dmar_domain->iovad, start, end));
> -}
> -
>   struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
>   {
>   	struct intel_iommu *iommu;
> @@ -5050,13 +4683,13 @@ const struct iommu_ops intel_iommu_ops = {
>   	.detach_dev		= intel_iommu_detach_device,
>   	.map			= intel_iommu_map,
>   	.unmap			= intel_iommu_unmap,
> +	.flush_iotlb_all	= iommu_flush_iova,
>   	.flush_iotlb_range	= intel_iommu_flush_iotlb_range,
>   	.iova_to_phys		= intel_iommu_iova_to_phys,
>   	.add_device		= intel_iommu_add_device,
>   	.remove_device		= intel_iommu_remove_device,
>   	.get_resv_regions	= intel_iommu_get_resv_regions,
>   	.put_resv_regions	= intel_iommu_put_resv_regions,
> -	.apply_resv_region	= intel_iommu_apply_resv_region,

With this removed, how will iommu_group_create_direct_mappings() work?

Best regards,
Lu Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
