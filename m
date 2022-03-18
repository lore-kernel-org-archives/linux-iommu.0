Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AF6C433EF
	for <iommu@archiver.kernel.org>; Fri, 18 Mar 2022 12:01:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BABF419BD;
	Fri, 18 Mar 2022 12:01:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WGzoFt4XiVl1; Fri, 18 Mar 2022 12:01:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 416DC4154D;
	Fri, 18 Mar 2022 12:01:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DD93C0033;
	Fri, 18 Mar 2022 12:01:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C850C0012
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 12:01:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 28D9C40545
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 12:01:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K4M-eTkaM--V for <iommu@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 12:01:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ADED840474
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 12:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647604871; x=1679140871;
 h=message-id:date:mime-version:cc:to:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=pBffoB48lXGmhcQ4bn5CKS0U9vBbO6aigybptR2nzow=;
 b=TuRdTD+9U1TK32wJgGzkaqBHciLNBmxpEOq7JzqOasM+TZ3VnkCytSvw
 t/KPKX9SQZhh7IshhzsQiVpOBP0eEqfDav5EoFIokxRtaLE9CoastDzNb
 QtprtiNprGT3K8d0DC/228kQN9PPCBkZOej37siBbdd2GZKoBx35U3gZ7
 JzazhzCiD+ZRuBuMKT3rr8bEq85fdnI/SEvAGBpy68J21rNVmTEgv0i3r
 OdRCuEvK/Iz0ODYSfzbhMjfRiy3d8nUyQ4jfaMnzCI7Rbj0ARXvb8bXzm
 DnCy0R6fvuniq4jUjSmeNGHwSKn6BSxunpvw+CmwDOejUaQDkmE64L/tT g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="254676596"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; d="scan'208";a="254676596"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 05:01:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; d="scan'208";a="558405336"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.248])
 ([10.254.215.248])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 05:01:06 -0700
Message-ID: <a10f3fcc-9e31-913d-853e-b6da5fcb36a0@linux.intel.com>
Date: Fri, 18 Mar 2022 20:01:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-3-jacob.jun.pan@linux.intel.com>
 <YjB4AyrgsnbUrlLe@myrica>
 <BN9PR11MB5276D5B88C05B509C2C790A98C109@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 2/8] iommu: Add attach/detach_dev_pasid domain ops
In-Reply-To: <BN9PR11MB5276D5B88C05B509C2C790A98C109@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On 2022/3/15 19:49, Tian, Kevin wrote:
>> From: Jean-Philippe Brucker<jean-philippe@linaro.org>
>> Sent: Tuesday, March 15, 2022 7:27 PM
>>
>> On Mon, Mar 14, 2022 at 10:07:06PM -0700, Jacob Pan wrote:
>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>
>>> An IOMMU domain represents an address space which can be attached by
>>> devices that perform DMA within a domain. However, for platforms with
>>> PASID capability the domain attachment needs be handled at device+PASID
>>> level. There can be multiple PASIDs within a device and multiple devices
>>> attached to a given domain.
>>> This patch introduces a new IOMMU op which support device, PASID, and
>>> IOMMU domain attachment. The immediate use case is for PASID capable
>>> devices to perform DMA under DMA APIs.
>>>
>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>> ---
>>>   include/linux/iommu.h | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>> index 369f05c2a4e2..fde5b933dbe3 100644
>>> --- a/include/linux/iommu.h
>>> +++ b/include/linux/iommu.h
>>> @@ -227,6 +227,8 @@ struct iommu_iotlb_gather {
>>>    * @aux_get_pasid: get the pasid given an aux-domain
>>>    * @sva_bind: Bind process address space to device
>>>    * @sva_unbind: Unbind process address space from device
>>> + * @attach_dev_pasid: attach an iommu domain to a pasid of device
>>> + * @detach_dev_pasid: detach an iommu domain from a pasid of device
>> Isn't that operation "assign a PASID to a domain" instead?  In patch 5,
>> the domain is already attached to the device, so set_domain_pasid() might
>> be clearer and to the point. If the IOMMU driver did the allocation we
>> could also avoid patch 1.
> iiuc this API can also work for future SIOV usage where each mdev attached
> to the domain has its own pasid. "assigning a PASID to a domain" sounds
> like going back to the previous aux domain approach which has one PASID
> per domain and that PASID is used on all devices attached to the aux domain...
> 

This also works for SVA as far as I can see. The sva_bind essentially is
to  attach an SVA domain to the PASID of a device. The sva_bind/unbind
ops could be removed with these two new callbacks.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
