Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FD642F716
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442444; cv=none; b=LaH9nfAIqEyq4122HvDnIhs0H5qKH9vEc5/PgfEoiRN4SZJr+8NjuaTETaizeqhIBvy4RajtYkTnizr0sLb7eK2IJ+RW0301tR5aMnSdcZg4XSpC7Q3wZsMP3szM6U8nKb9n1Noc8ADBa0ls+ezH+IVK/4Lg9LeIftme0lI/+GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442444; c=relaxed/simple;
	bh=XunOdvshSL2anlbYev3DNdM5FhGKTEcY2SPDyhbPJi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKmFdhKVWzoVlBdhFjrPUJO1Ms47FRADbcpvUScAu92/+BNPNXb1huVnHBzGpv9T5m7McOaA0b5zUa0zisFJBBvvdOYOVzr80sgSje0xnqykBWQ6MT/IV2rOwKXtxoW4jKWi5KWjxgZLFZu8Gum6AH50jpqmGL3siVkFtKrRD38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=MtF2NQkC; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="MtF2NQkC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1786442388;
	bh=Uwg2KuAyR60FhEPL3ViQJi6QGRCJ+gmNWcLhl6NquIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=MtF2NQkC3SddxuaDgY9v7WtKKPRR3LYg6uPwBr4+Z/VrFJUMwI02u2V3NnfAS/6WG
	 0k9+sb1617hMLknsPJl8TN1kDZdRysp0Kax3XYN2HTVlRaNkFFIn7Z3Q/s47iXRj29
	 DdnkA7vh3idqdgOUUniIQTYvOrW7RqHDrHkePtow=
X-QQ-mid: zesmtpgz9t1786442380t6c389721
X-QQ-Originating-IP: la2vGRCpXhxdEehKItNiTN1s6CmU1DaztmT+WNk8tkM=
Received: from [127.0.0.1] ( [36.152.24.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Aug 2026 17:59:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14416905697755533587
Message-ID: <A627C24D3788B4DA+97c5821e-1dad-4c61-9565-0aee0ed0ed18@smail.nju.edu.cn>
Date: Tue, 11 Aug 2026 17:59:38 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] iommufd/selftest: KASAN slab-use-after-free in
 iommu_report_device_fault
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
References: <D5E3AA41600B2056+f4e15662-bd2b-43ea-91cb-518de429e72c@smail.nju.edu.cn>
 <CO1PR11MB48353016C02FDA31BEEB274D8CCC2@CO1PR11MB4835.namprd11.prod.outlook.com>
 <ACFE02E91C9C4025+1b43727a-2964-4c96-8a6b-bf732a7c5620@smail.nju.edu.cn>
 <20260810200215.GA518032@ziepe.ca>
Content-Language: en-US
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
In-Reply-To: <20260810200215.GA518032@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OWtQnHCUpsEzTtr6BV8au4Swka544RfhnzD5ldwU/WmXp5E5K+sYfQ1M
	peE1L/Rceqor9VWo+sZrAhiE8VNVpRS9Z6Ofm9qtxPZnGt/J9qRaBhcs8KhSx2pCdqzKGJf
	6zcZVGDT0EzHuLf8MMZqD631eIwb/bZMYtw09NlBM4ixgae5RK9BUu4UFX6ghg+flTlPnri
	l6xcykfVNi5Gc1aY7b+JJanhPSGF8gcl5lkXpQewPA3OPUebOo8P9MgQOGmjfZiykjQCQtE
	FAfUWSFdbHP14Ecu4335OE96xW+XAw1jyApDgf2eYcDAdPU2GYZEQUHcLrUo2zBFPpI2b4E
	r49HlTMDRsSgXrv6yMO3IiO8gClOAbnPHJoci0AN9hbUipgPeT+ZiwbNtb/4Kxud+EPIQiG
	rgxigO1a6vvUbw1+qBbSkFMUwsdDHwuIcsVXI2nkWo1RBNpJtIa2QdTbcDok2GOT/SmrNDp
	FGQx2cCyKpXOtOm5lcS//xJ2Q9mGTviILC+SgyAN6b/lI2/LIDot8bLybjUf7FlSgpU1fbC
	KQfLiRG35wGSocglDW7HjsS6UHfg42hk89/48pX41ei52tLO6vP3jWSpS01ha0uT0wPYxUT
	i8f+kofyac7aQ1r4SzQy7BkVyRK+gd3kAJn15xc7YvUwF7rgAxL5qunQQR2dFcAyYryR8/5
	+JQl6NXtXbNHumPhX3NLWiQisINpRtd3PmIL30vHTBIF4dxM+CmmNdl1269i+RdXjg+rSfJ
	NKRmB42K6+0x1eYH//eva2J/mzUwtkGpImt2gewo1mHdMjCTHTZ2/sBozqeupAzpnMVFusQ
	x1PNOdueYS6wkVKH1WT86WoAbEEqY5nIrM5lvFyWH3IbtBdxka9eksq1qLXMF4u33GSDx18
	nIDY62I5YbALOv7Bfh1R2+n5svydRclzvxMrJSKp9IP99WHnQpUGTeih1TwUDh8FchJnQhO
	xrKhilmcvnmg1YnwxuJTZ2QQow46r2pMKlEzAqGPSR+ymbDOtOvL+eez0wHgeF3DdaswXZ8
	FBT/IKv0MHMpkEFSa7W8xPSN4z/H4ehmvUBkgsMn8Gss6RhsZRVWM2mgP6UlEgpcwyEFRFO
	AVbWkkBoRfmOXDtQFz9llP6BfDj2xrdCX5IOJjXxMl+fKKFsQb5IY1DnWBTPLb9rA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

On 2026/8/11 04:02, Jason Gunthorpe wrote:
> On Tue, Jul 28, 2026 at 01:32:09PM +0800, Peiyang He wrote:
>> On 2026/7/27 17:41, Tian, Kevin wrote:
>>>> From: Peiyang He <peiyang_he@smail.nju.edu.cn>
>>>> Sent: Wednesday, July 22, 2026 5:52 PM
>>>>
>>> [...]
>>>  > Since iommu_attach_handle_get() explicitly says that the caller should be
>>>> responsible for "synchronize the call of iommu_attach_handle_get()
>>>> with domain attachment and detachment", maybe we shouldn't add extra
>>>> lifetime
>>>> management mechanism around iommu_attach_handle, instead we should
>>>> fix this at the caller side.
>>>>
>>>> Fault report can run concurrently with PASID detach and replacement, but
>>>> before the old attach handle is removed and freed, mockdev must block new
>>>> reports
>>>> for that PASID and wait for in-flight iommu_report_device_fault() calls to
>>>> finish.
>>>>
>>>
>>> yes the mock driver should drain in-flight fault requests before the
>>> actual detachment, just like other iommu drivers do.
>>
>> Hi Kevin,
>>
>> Thanks for your reply. I looked into the code in more detail. Would this
>> approach make sense?
>>
>> In iommufd_test_trigger_iopf(), call iommu_report_device_fault() under the protection
>> of idev->igroup->lock. Since detach and replace also require the same lock, they can
>> be serialized with fault reporting. This would ensure that a mock fault report either
>> completes before detach/replace starts, or starts only after the old handle has been removed.
>> Thus it should prevent the UAF.
>>
>> Would this simple serialization meet the design intention of mock dev? Or would you prefer
>> an explicit quiesce/drain mechanism instead?
> 
> The mock driver should follow the expected design of a real driver, so
> I'd put an internal rwsem or something like that to protect this
> 
> Jason
> 

Thanks for this suggestion! PTAL at https://lore.kernel.org/all/38C8DF0A118B7176+20260811095551.2756745-1-peiyang_he@smail.nju.edu.cn/

Best regards,
Peiyang

