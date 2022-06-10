Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E42C43334
	for <iommu@archiver.kernel.org>; Fri, 10 Jun 2022 09:07:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D73B541163;
	Fri, 10 Jun 2022 09:07:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wXHullNDJkmg; Fri, 10 Jun 2022 09:07:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 99575400A4;
	Fri, 10 Jun 2022 09:07:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FED6C0032;
	Fri, 10 Jun 2022 09:07:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA617C002D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 09:07:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C2108419EF
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 09:07:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MHErpP1w8TRR for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 09:07:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C9FA419D0
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 09:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654852036; x=1686388036;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=KWBbBv0fNbkt9AOdrz/gHPWthaP0yG+qgfQ5rAjHmCE=;
 b=VaRRoc+cWdFVOvMRfY/Ozb7S/cKSOR0lM17qOKtjB1KtwatyOMAiWMTC
 iDMUb9FacXfrmYUp+7r9HZJQku5TXMu83TD5j5zLmLGEAnouDMFf6I0UF
 hQNEZD4a5yGOkGA1OHgTOUdzN4YCXqpW5mPknnPRzelMd1Dj+S2wdXGC3
 U5sMnSORy8CZkFlT7LtAmsURd6hrYVpEd71LaSQpSRsOlG9znJiqcHxZy
 Bg5Xq/i2MFwwsSSVvmXCJy8jXav9wfJfOsHG7W3mjWt+Y9hHU8Pp3zac7
 If1OiRko/38JEwmfqo5rxi/NoMWeocskV/wL4fR7GG7+cB1cu4bQkTlwH A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="276343865"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; d="scan'208";a="276343865"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2022 02:07:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; d="scan'208";a="638032467"
Received: from chengxu1-mobl2.ccr.corp.intel.com (HELO [10.249.169.148])
 ([10.249.169.148])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2022 02:07:12 -0700
Message-ID: <79c41aab-ec9c-3f5e-65d1-ff857f57816e@linux.intel.com>
Date: Fri, 10 Jun 2022 17:07:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 02/11] iommu: Add max_pasids field in struct dev_iommu
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-3-baolu.lu@linux.intel.com>
 <20220609190102.GC33363@araj-dh-work>
 <f92629ef-8c9a-b89a-ef0b-32e71617bd51@linux.intel.com>
 <BN9PR11MB5276C7B4FAC55C58A5466EFC8CA69@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276C7B4FAC55C58A5466EFC8CA69@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, Will Deacon <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
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

On 2022/6/10 17:01, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Friday, June 10, 2022 2:47 PM
>>
>> On 2022/6/10 03:01, Raj, Ashok wrote:
>>> On Tue, Jun 07, 2022 at 09:49:33AM +0800, Lu Baolu wrote:
>>>> @@ -218,6 +219,30 @@ static void dev_iommu_free(struct device *dev)
>>>>    	kfree(param);
>>>>    }
>>>>
>>>> +static u32 dev_iommu_get_max_pasids(struct device *dev)
>>>> +{
>>>> +	u32 max_pasids = dev->iommu->iommu_dev->max_pasids;
>>>> +	u32 num_bits;
>>>> +	int ret;
>>>> +
>>>> +	if (!max_pasids)
>>>> +		return 0;
>>>> +
>>>> +	if (dev_is_pci(dev)) {
>>>> +		ret = pci_max_pasids(to_pci_dev(dev));
>>>> +		if (ret < 0)
>>>> +			return 0;
>>>> +
>>>> +		return min_t(u32, max_pasids, ret);
>>>
>>> Ah.. that answers my other question to consider device pasid-max. I guess
>>> if we need any enforcement of restricting devices that aren't supporting
>>> the full PASID, that will be done by some higher layer?
>>
>> The mm->pasid style of SVA is explicitly enabled through
>> iommu_dev_enable_feature(IOMMU_DEV_FEAT_SVA). The IOMMU driver
>> specific
>> restriction might be put there?
>>
>>>
>>> too many returns in this function, maybe setup all returns to the end of
>>> the function might be elegant?
>>
>> I didn't find cleanup room after a quick scan of the code. But sure, let
>> me go through code again offline.
>>
> 
> If we do care:
> 
> +static u32 dev_iommu_get_max_pasids(struct device *dev)
> +{
> +	u32 max_pasids = 0,
> +	u32 num_bits = 0;
> +	int ret;
> +
> +	if (dev_is_pci(dev)) {
> +		ret = pci_max_pasids(to_pci_dev(dev));
> +		if (ret > 0)
> +			max_pasids = ret;
> +	} else {
> +		ret = device_property_read_u32(dev, "pasid-num-bits", &num_bits);
> +		if (!ret)
> +			max_pasids = 1UL << num_bits;
> +	}
> +
> +	return min_t(u32, max_pasids, dev->iommu->iommu_dev->max_pasids);
> +}

Great! Cleaner and more compact than mine. Thank you!

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
