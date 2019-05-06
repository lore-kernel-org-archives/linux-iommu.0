Return-Path: <SRS0=Zlue=TG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169BDC004C9
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 01:49:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE51620675
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 01:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE51620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ABEC0449B;
	Mon,  6 May 2019 01:49:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B3EE44498
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 01:48:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4A4057DB
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 01:48:45 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 May 2019 18:48:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,435,1549958400"; d="scan'208";a="146640656"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga008.fm.intel.com with ESMTP; 05 May 2019 18:48:39 -0700
Subject: Re: [RFC 1/7] iommu/vt-d: Set the dma_ops per device so we can remove
	the iommu_no_mapping code
To: Tom Murphy <tmurphy@arista.com>, iommu@lists.linux-foundation.org
References: <20190504132327.27041-1-tmurphy@arista.com>
	<20190504132327.27041-2-tmurphy@arista.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8fef18f5-773c-e1c9-2537-c9dff5bfd35e@linux.intel.com>
Date: Mon, 6 May 2019 09:42:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504132327.27041-2-tmurphy@arista.com>
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
> Set the dma_ops per device so we can remove the iommu_no_mapping code.
> 
> Signed-off-by: Tom Murphy<tmurphy@arista.com>
> ---
>   drivers/iommu/intel-iommu.c | 85 +++----------------------------------
>   1 file changed, 6 insertions(+), 79 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index eace915602f0..2db1dc47e7e4 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2622,17 +2622,6 @@ static int __init si_domain_init(int hw)
>   	return 0;
>   }
>   
> -static int identity_mapping(struct device *dev)
> -{
> -	struct device_domain_info *info;
> -
> -	info = dev->archdata.iommu;
> -	if (info && info != DUMMY_DEVICE_DOMAIN_INFO)
> -		return (info->domain == si_domain);
> -
> -	return 0;
> -}
> -
>   static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
>   {
>   	struct dmar_domain *ndomain;
> @@ -3270,43 +3259,6 @@ static unsigned long intel_alloc_iova(struct device *dev,
>   	return iova_pfn;
>   }
>   
> -/* Check if the dev needs to go through non-identity map and unmap process.*/
> -static int iommu_no_mapping(struct device *dev)
> -{
> -	int found;
> -
> -	if (iommu_dummy(dev))
> -		return 1;
> -
> -	found = identity_mapping(dev);
> -	if (found) {
> -		/*
> -		 * If the device's dma_mask is less than the system's memory
> -		 * size then this is not a candidate for identity mapping.
> -		 */
> -		u64 dma_mask = *dev->dma_mask;
> -
> -		if (dev->coherent_dma_mask &&
> -		    dev->coherent_dma_mask < dma_mask)
> -			dma_mask = dev->coherent_dma_mask;
> -
> -		if (dma_mask < dma_get_required_mask(dev)) {
> -			/*
> -			 * 32 bit DMA is removed from si_domain and fall back
> -			 * to non-identity mapping.
> -			 */
> -			dmar_remove_one_dev_info(dev);
> -			dev_warn(dev, "32bit DMA uses non-identity mapping\n");
> -
> -			return 0;
> -		}

The iommu_no_mapping() also checks whether any 32bit DMA device uses
identity mapping. The device might not work if the system memory space
is bigger than 4G.

Will you add this to other place, or it's unnecessary?

Best regards,
Lu Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
