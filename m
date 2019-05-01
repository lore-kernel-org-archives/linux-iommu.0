Return-Path: <SRS0=GORt=TB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEBCC43219
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 17:41:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 751DA208E4
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 17:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751DA208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8E5622B51;
	Wed,  1 May 2019 17:41:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B6E272AF0
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 17:40:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 6B13F711
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 17:40:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CAEE80D;
	Wed,  1 May 2019 10:40:55 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50A513F719;
	Wed,  1 May 2019 10:40:53 -0700 (PDT)
Subject: Re: [PATCH v2 06/19] drivers core: Add I/O ASID allocator
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1556062279-64135-7-git-send-email-jacob.jun.pan@linux.intel.com>
	<4550408f-39ff-7bf9-0072-a0898c6c2f60@redhat.com>
	<fd5b8c6c-05f0-307b-aaa2-0938337014a8@arm.com>
	<20190430132405.62902350@jacob-builder>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <e3f1d619-1421-fd19-72ce-dadb56b07aaa@arm.com>
Date: Wed, 1 May 2019 18:40:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430132405.62902350@jacob-builder>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190501174034.7XVA4zQNiycSDxZGOib9kn_2YQ7cZI9577F0p1fivdk@z>

On 30/04/2019 21:24, Jacob Pan wrote:
> On Thu, 25 Apr 2019 11:41:05 +0100
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> On 25/04/2019 11:17, Auger Eric wrote:
>>>> +/**
>>>> + * ioasid_alloc - Allocate an IOASID
>>>> + * @set: the IOASID set
>>>> + * @min: the minimum ID (inclusive)
>>>> + * @max: the maximum ID (exclusive)
>>>> + * @private: data private to the caller
>>>> + *
>>>> + * Allocate an ID between @min and @max (or %0 and %INT_MAX).
>>>> Return the  
>>> I would remove "(or %0 and %INT_MAX)".  
>>
>> Agreed, those where the default values of idr, but the xarray doesn't
>> define a default max value. By the way, I do think squashing patches 6
>> and 7 would be better (keeping my SOB but you can change the author).
>>
> I will squash 6 and 7 in v3. I will just add my SOB but keep the
> author if that is OK.

Sure, that works

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
