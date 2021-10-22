Return-Path: <SRS0=cgap=PK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A834C433F5
	for <iommu@archiver.kernel.org>; Fri, 22 Oct 2021 02:57:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1056052B
	for <iommu@archiver.kernel.org>; Fri, 22 Oct 2021 02:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD1056052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DD804083C;
	Fri, 22 Oct 2021 02:57:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ta7GwXE9FGDC; Fri, 22 Oct 2021 02:57:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1D46F40833;
	Fri, 22 Oct 2021 02:57:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD707C001F;
	Fri, 22 Oct 2021 02:57:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87745C001E
 for <iommu@lists.linux-foundation.org>; Fri, 22 Oct 2021 02:57:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6EF8840833
 for <iommu@lists.linux-foundation.org>; Fri, 22 Oct 2021 02:57:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hh_V_VygaX5D for <iommu@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 02:56:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4516B40832
 for <iommu@lists.linux-foundation.org>; Fri, 22 Oct 2021 02:56:50 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="229476828"
X-IronPort-AV: E=Sophos;i="5.87,171,1631602800"; d="scan'208";a="229476828"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2021 19:56:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,171,1631602800"; d="scan'208";a="484494597"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 21 Oct 2021 19:56:46 -0700
Subject: Re: [PATCH v3 4/6] iommu: Move IOMMU pagesize check to attach_device
To: Marc Zyngier <maz@kernel.org>
References: <20211019163737.46269-1-sven@svenpeter.dev>
 <20211019163737.46269-5-sven@svenpeter.dev>
 <9e25f2c0-d9d3-475d-e973-63be1891f9a5@linux.intel.com>
 <8735ovdbcv.wl-maz@kernel.org>
 <6a886030-cbc6-9e92-bf79-77b659da2915@linux.intel.com>
 <87wnm6bxx2.wl-maz@kernel.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <106088e3-2928-dace-e1b6-e1e74ffec366@linux.intel.com>
Date: Fri, 22 Oct 2021 10:52:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87wnm6bxx2.wl-maz@kernel.org>
Content-Language: en-US
Cc: Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Alexander Graf <graf@amazon.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Robin Murphy <robin.murphy@arm.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
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

On 10/21/21 4:10 PM, Marc Zyngier wrote:
> On Thu, 21 Oct 2021 03:22:30 +0100,
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> On 10/20/21 10:22 PM, Marc Zyngier wrote:
>>> On Wed, 20 Oct 2021 06:21:44 +0100,
>>> Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>>
>>>> On 2021/10/20 0:37, Sven Peter via iommu wrote:
>>>>> +	/*
>>>>> +	 * Check that CPU pages can be represented by the IOVA granularity.
>>>>> +	 * This has to be done after ops->attach_dev since many IOMMU drivers
>>>>> +	 * only limit domain->pgsize_bitmap after having attached the first
>>>>> +	 * device.
>>>>> +	 */
>>>>> +	ret = iommu_check_page_size(domain);
>>>>> +	if (ret) {
>>>>> +		__iommu_detach_device(domain, dev);
>>>>> +		return ret;
>>>>> +	}
>>>>
>>>> It looks odd. __iommu_attach_device() attaches an I/O page table for a
>>>> device. How does it relate to CPU pages? Why is it a failure case if CPU
>>>> page size is not covered?
>>>
>>> If you allocate a CPU PAGE_SIZE'd region, and point it at a device
>>> that now can DMA to more than what you have allocated because the
>>> IOMMU's own page size is larger, the device has now access to data it
>>> shouldn't see. In my book, that's a pretty bad thing.
>>
>> But even you enforce the CPU page size check here, this problem still
>> exists unless all DMA buffers are PAGE_SIZE aligned and sized, right?
> 
> Let me take a CPU analogy: you have a page that contains some user
> data *and* a kernel secret. How do you map this page into userspace
> without leaking the kernel secret?
> 
> PAGE_SIZE allocations are the unit of isolation, and this applies to
> both CPU and IOMMU. If you have allocated a DMA buffer that is less
> than a page, you then have to resort to bounce buffering, or accept
> that your data isn't safe.

I can understand the problems when IOMMU page sizes is larger than CPU
page size. But the code itself is not clean. The vendor iommu drivers
know more hardware details than the iommu core. It looks odd that the
vendor iommu says "okay, I can attach this I/O page table to the
device", but the iommu core says "no, you can't" and rolls everything
back.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
