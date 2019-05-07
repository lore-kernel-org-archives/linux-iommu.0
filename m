Return-Path: <SRS0=4fho=TH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74A2C04AAD
	for <iommu@archiver.kernel.org>; Tue,  7 May 2019 11:45:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB41206BF
	for <iommu@archiver.kernel.org>; Tue,  7 May 2019 11:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB41206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6C5B21352;
	Tue,  7 May 2019 11:45:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3F8D41351
	for <iommu@lists.linux-foundation.org>;
	Tue,  7 May 2019 11:45:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id E25477DB
	for <iommu@lists.linux-foundation.org>;
	Tue,  7 May 2019 11:45:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0C8980D;
	Tue,  7 May 2019 04:45:45 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 409F63F5AF;
	Tue,  7 May 2019 04:45:43 -0700 (PDT)
Subject: Re: [PATCH v7 05/23] iommu: Introduce cache_invalidate API
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20190408121911.24103-1-eric.auger@redhat.com>
	<20190408121911.24103-6-eric.auger@redhat.com>
	<a9745aef-8686-c761-e3d0-dd0e98a1f5b2@arm.com>
	<e5d2fdd6-4ce1-863e-5198-0b05d727a5b6@redhat.com>
	<6af5ddb7-75ad-7d3f-b303-f6f06adb1bf0@arm.com>
	<20190502094624.43924be8@jacob-builder>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <5cbc5c09-8a34-5c47-981b-35c682d7f699@arm.com>
Date: Tue, 7 May 2019 12:45:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502094624.43924be8@jacob-builder>
Content-Language: en-US
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	Vincent Stehle <Vincent.Stehle@arm.com>,
	"ashok.raj@intel.com" <ashok.raj@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Marc Zyngier <Marc.Zyngier@arm.com>, Will Deacon <Will.Deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Christoffer Dall <Christoffer.Dall@arm.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	Robin Murphy <Robin.Murphy@arm.com>,
	"kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
	"eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 02/05/2019 17:46, Jacob Pan wrote:
> On Thu, 2 May 2019 11:53:34 +0100
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> On 02/05/2019 07:58, Auger Eric wrote:
>>> Hi Jean-Philippe,
>>>
>>> On 5/1/19 12:38 PM, Jean-Philippe Brucker wrote:  
>>>> On 08/04/2019 13:18, Eric Auger wrote:  
>>>>> +int iommu_cache_invalidate(struct iommu_domain *domain, struct
>>>>> device *dev,
>>>>> +			   struct iommu_cache_invalidate_info
>>>>> *inv_info) +{
>>>>> +	int ret = 0;
>>>>> +
>>>>> +	if (unlikely(!domain->ops->cache_invalidate))
>>>>> +		return -ENODEV;
>>>>> +
>>>>> +	ret = domain->ops->cache_invalidate(domain, dev,
>>>>> inv_info); +
>>>>> +	return ret;  
>>>>
>>>> Nit: you don't really need ret
>>>>
>>>> The UAPI looks good to me, so
>>>>
>>>> Reviewed-by: Jean-Philippe Brucker
>>>> <jean-philippe.brucker@arm.com>  
>>> Just to make sure, do you accept changes proposed by Jacob in
>>> https://lkml.org/lkml/2019/4/29/659 ie.
>>> - the addition of NR_IOMMU_INVAL_GRANU in enum
>>> iommu_inv_granularity and
>>> - the addition of NR_IOMMU_CACHE_TYPE  
>>
>> Ah sorry, I forgot about that, I'll review the next version. Yes they
>> can be useful (maybe call them IOMMU_INV_GRANU_NR and
>> IOMMU_CACHE_INV_TYPE_NR?). I guess it's legal to export in UAPI values
>> that will change over time, as VFIO also does it in its enums.
>>
> I am fine with the names. Maybe you can put this patch in your sva/api
> branch once you reviewed it? Having a common branch for common code
> makes life so much easier.

Done, with minor whitespace and name fixes

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
