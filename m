Return-Path: <SRS0=W6tT=TF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE1DC04AAA
	for <iommu@archiver.kernel.org>; Sun,  5 May 2019 01:27:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95D9206DF
	for <iommu@archiver.kernel.org>; Sun,  5 May 2019 01:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95D9206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 46ACE42AD;
	Sun,  5 May 2019 01:27:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BA5AC42A9
	for <iommu@lists.linux-foundation.org>;
	Sun,  5 May 2019 01:26:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5ABD287
	for <iommu@lists.linux-foundation.org>;
	Sun,  5 May 2019 01:26:19 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 May 2019 18:26:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,431,1549958400"; d="scan'208";a="146319205"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga008.fm.intel.com with ESMTP; 04 May 2019 18:26:14 -0700
Subject: Re: [RFC 2/7] iommu/vt-d: Remove iova handling code from non-dma ops
	path
To: Tom Murphy <tmurphy@arista.com>, iommu@lists.linux-foundation.org
References: <20190504132327.27041-1-tmurphy@arista.com>
	<20190504132327.27041-3-tmurphy@arista.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bf35694d-3ff4-0df7-0802-b0e87a9a0d47@linux.intel.com>
Date: Sun, 5 May 2019 09:19:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504132327.27041-3-tmurphy@arista.com>
Content-Language: en-US
Cc: Heiko Stuebner <heiko@sntech.de>, kvm@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>, linux-tegra@vger.kernel.org,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
	Kukjin Kim <kgene@kernel.org>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	Andy Gross <andy.gross@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
	linux-arm-msm@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	David Brown <david.brown@linaro.org>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org, murphyt7@tcd.ie,
	Robin Murphy <robin.murphy@arm.com>
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

On 5/4/19 9:23 PM, Tom Murphy via iommu wrote:
> @@ -4181,58 +4168,37 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
>   				       unsigned long val, void *v)
>   {
>   	struct memory_notify *mhp = v;
> -	unsigned long long start, end;
> -	unsigned long start_vpfn, last_vpfn;
> +	unsigned long start_vpfn = mm_to_dma_pfn(mhp->start_pfn);
> +	unsigned long last_vpfn = mm_to_dma_pfn(mhp->start_pfn +
> +			mhp->nr_pages - 1);
>   
>   	switch (val) {
>   	case MEM_GOING_ONLINE:
> -		start = mhp->start_pfn << PAGE_SHIFT;
> -		end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
> -		if (iommu_domain_identity_map(si_domain, start, end)) {
> -			pr_warn("Failed to build identity map for [%llx-%llx]\n",
> -				start, end);
> +		if (iommu_domain_identity_map(si_domain, start_vpfn,
> +					last_vpfn)) {
> +			pr_warn("Failed to build identity map for [%lx-%lx]\n",
> +				start_vpfn, last_vpfn);
>   			return NOTIFY_BAD;
>   		}
>   		break;

Actually we don't need to update the si_domain if iommu hardware
supports pass-through mode. This should be made in a separated patch
anyway.

Best regards,
Lu Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
