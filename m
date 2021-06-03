Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B2DC47096
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 05:50:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB34613E6
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 05:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB34613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E22DC40596;
	Thu,  3 Jun 2021 05:50:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 19picNe5f6JW; Thu,  3 Jun 2021 05:50:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70E0140597;
	Thu,  3 Jun 2021 05:50:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48249C000D;
	Thu,  3 Jun 2021 05:50:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2686AC0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 05:50:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F26B1404F0
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 05:50:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6rsmklmnm4mk for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 05:50:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 98B34404ED
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 05:50:47 +0000 (UTC)
IronPort-SDR: sMdG6elgYwBFabfJ4A+YtV0+pJeEC6geGBj7oPpyu/Q2dSV/uR5A0KyyEKY2GopAY6A0qAjl6C
 sM/qxgOP2p2Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="183649863"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="183649863"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 22:50:46 -0700
IronPort-SDR: HIqFoQnlwW9zRcmmcw2Vz1vlTxvHTTqq5JQyMeaA5VZWXz7UfIb649x3ydCt2HHdiRP+/Rerd3
 8oMaEjJ7xg+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="633581002"
Received: from allen-box.sh.intel.com (HELO [10.239.159.105])
 ([10.239.159.105])
 by fmsmga006.fm.intel.com with ESMTP; 02 Jun 2021 22:50:41 -0700
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Jason Gunthorpe <jgg@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528233649.GB3816344@nvidia.com>
 <786295f7-b154-cf28-3f4c-434426e897d3@linux.intel.com>
 <20210601172652.GK1002214@nvidia.com>
 <99c765d2-5fd3-002c-7c7a-408a17433068@linux.intel.com>
 <20210602232352.GL1002214@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6113bf72-5419-4dc3-3b03-d11e4812a772@linux.intel.com>
Date: Thu, 3 Jun 2021 13:49:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210602232352.GL1002214@nvidia.com>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>
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

On 6/3/21 7:23 AM, Jason Gunthorpe wrote:
> On Wed, Jun 02, 2021 at 12:01:57PM +0800, Lu Baolu wrote:
>> On 6/2/21 1:26 AM, Jason Gunthorpe wrote:
>>> On Tue, Jun 01, 2021 at 07:09:21PM +0800, Lu Baolu wrote:
>>>
>>>> This version only covers 1) and 4). Do you think we need to support 2),
>>>> 3) and beyond?
>>>
>>> Yes aboslutely. The API should be flexable enough to specify the
>>> creation of all future page table formats we'd want to have and all HW
>>> specific details on those formats.
>>
>> OK, stay in the same line.
>>
>>>> If so, it seems that we need some in-kernel helpers and uAPIs to
>>>> support pre-installing a page table to IOASID.
>>>
>>> Not sure what this means..
>>
>> Sorry that I didn't make this clear.
>>
>> Let me bring back the page table types in my eyes.
>>
>>   1) IOMMU format page table (a.k.a. iommu_domain)
>>   2) user application CPU page table (SVA for example)
>>   3) KVM EPT (future option)
>>   4) VM guest managed page table (nesting mode)
>>
>> Each type of page table should be able to be associated with its IOASID.
>> We have BIND protocol for 4); We explicitly allocate an iommu_domain for
>> 1). But we don't have a clear definition for 2) 3) and others. I think
>> it's necessary to clearly define a time point and kAPI name between
>> IOASID_ALLOC and IOASID_ATTACH, so that other modules have the
>> opportunity to associate their page table with the allocated IOASID
>> before attaching the page table to the real IOMMU hardware.
> 
> In my mind these are all actions of creation..
> 
> #1 is ALLOC_IOASID 'to be compatible with thes devices attached to
>     this FD'
> #2 is ALLOC_IOASID_SVA
> #3 is some ALLOC_IOASID_KVM (and maybe the kvm fd has to issue this ioctl)
> #4 is ALLOC_IOASID_USER_PAGE_TABLE w/ user VA address or
>        ALLOC_IOASID_NESTED_PAGE_TABLE w/ IOVA address
> 
> Each allocation should have a set of operations that are allows
> map/unmap is only legal on #1. invalidate is only legal on #4, etc.

This sounds reasonable. The corresponding page table types and required
callbacks are also part of it.

> 
> How you want to split this up in the ioctl interface is a more
> interesting question. I generally like more calls than giant unwieldly
> multiplexer structs, but some things are naturally flags and optional
> modifications of a single ioctl.
> 
> In any event they should have a similar naming 'ALLOC_IOASID_XXX' and
> then a single 'DESTROY_IOASID' that works on all of them.
> 
>> I/O page fault handling is similar. The provider of the page table
>> should take the responsibility to handle the possible page faults.
> 
> For the faultable types, yes #3 and #4 should hook in the fault
> handler and deal with it.

Agreed.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
