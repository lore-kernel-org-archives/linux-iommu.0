Return-Path: <SRS0=Zlue=TG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37862C004C9
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 01:42:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1033020675
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 01:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1033020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A8EA04499;
	Mon,  6 May 2019 01:42:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 63D304498
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 01:41:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B42F1196
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 01:41:30 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 May 2019 18:41:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,435,1549958400"; d="scan'208";a="146639249"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga008.fm.intel.com with ESMTP; 05 May 2019 18:41:24 -0700
Subject: Re: [RFC 6/7] iommu/vt-d: convert the intel iommu driver to the
	dma-iommu ops api
To: Tom Murphy <tmurphy@arista.com>
References: <20190504132327.27041-1-tmurphy@arista.com>
	<20190504132327.27041-7-tmurphy@arista.com>
	<602b77a2-9c68-ad14-b64f-904a7ff27a15@linux.intel.com>
	<CAPL0++57nyLYP1fq=-6zvNS0z_iCqjWLbQ1MsG5F60ODkmRCQQ@mail.gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2419e94d-bfdb-e70d-bbfd-425671886e99@linux.intel.com>
Date: Mon, 6 May 2019 09:34:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAPL0++57nyLYP1fq=-6zvNS0z_iCqjWLbQ1MsG5F60ODkmRCQQ@mail.gmail.com>
Content-Language: en-US
Cc: Heiko Stuebner <heiko@sntech.de>, kvm@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>, David Brown <david.brown@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	iommu@lists.linux-foundation.org, Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
	Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Andy Gross <andy.gross@linaro.org>, linux-tegra@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>, linux-arm-msm@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
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

On 5/6/19 1:03 AM, Tom Murphy wrote:
> On Sun, May 5, 2019 at 3:44 AM Lu Baolu<baolu.lu@linux.intel.com>  wrote:
>> Hi,
>>
>> On 5/4/19 9:23 PM, Tom Murphy wrote:
>>> static int intel_iommu_add_device(struct device *dev)
>>>    {
>>> +     struct dmar_domain *dmar_domain;
>>> +     struct iommu_domain *domain;
>>>        struct intel_iommu *iommu;
>>>        struct iommu_group *group;
>>> -     struct iommu_domain *domain;
>>> +     dma_addr_t base;
>>>        u8 bus, devfn;
>>>
>>>        iommu = device_to_iommu(dev, &bus, &devfn);
>>> @@ -4871,9 +4514,12 @@ static int intel_iommu_add_device(struct device *dev)
>>>        if (IS_ERR(group))
>>>                return PTR_ERR(group);
>>>
>>> +     base = IOVA_START_PFN << VTD_PAGE_SHIFT;
>>>        domain = iommu_get_domain_for_dev(dev);
>>> +     dmar_domain = to_dmar_domain(domain);
>>>        if (domain->type == IOMMU_DOMAIN_DMA)
>>> -             dev->dma_ops = &intel_dma_ops;
>>> +             iommu_setup_dma_ops(dev, base,
>>> +                             __DOMAIN_MAX_ADDR(dmar_domain->gaw) - base);
>> I didn't find the implementation of iommu_setup_dma_ops() in this
>> series. Will the iova resource be initialized in this function?
> Ah sorry, I should've mentioned this is based on the
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-iommu-ops.3
> branch with the "iommu/vt-d: Delegate DMA domain to generic iommu" and
> "iommu/amd: Convert the AMD iommu driver to the dma-iommu api" patch
> sets applied.
> 
>> If so, will this block iommu_group_create_direct_mappings() which
>> reserves and maps the reserved iova ranges.
> The reserved regions will be reserved by the
> iova_reserve_iommu_regions function instead:
> (https://github.com/torvalds/linux/blob/6203838dec05352bc357625b1e9ba0a10d3bca35/drivers/iommu/dma-iommu.c#L238
> )
> iommu_setup_dma_ops calls iommu_dma_init_domain which calls
> iova_reserve_iommu_regions.
> iommu_group_create_direct_mappings will still execute normally but it
> won't be able to call the intel_iommu_apply_resv_region function
> because it's been removed in this patchset.
> This shouldn't change any behavior and the same regions should be reserved.
> 

Okay, I understand it now. Thanks for the explanation.

Best regards,
Lu Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
