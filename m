Return-Path: <SRS0=48ym=4V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16D9C3F2CD
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 12:17:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9134C20848
	for <iommu@archiver.kernel.org>; Wed,  4 Mar 2020 12:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9134C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6104E84F2E;
	Wed,  4 Mar 2020 12:17:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UPCtClzb1rn7; Wed,  4 Mar 2020 12:17:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E995584E77;
	Wed,  4 Mar 2020 12:17:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEBF3C089F;
	Wed,  4 Mar 2020 12:17:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE981C013E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 12:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id ABDEB8622A
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 12:17:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PrhD+JwOEoIB for <iommu@lists.linux-foundation.org>;
 Wed,  4 Mar 2020 12:17:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B496486230
 for <iommu@lists.linux-foundation.org>; Wed,  4 Mar 2020 12:17:09 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Mar 2020 04:17:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,514,1574150400"; d="scan'208";a="413131884"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.93])
 ([10.254.211.93])
 by orsmga005.jf.intel.com with ESMTP; 04 Mar 2020 04:17:05 -0800
Subject: Re: [PATCH V2 3/5] iommu: Add support to change default domain of an
 iommu_group
To: Joerg Roedel <joro@8bytes.org>
References: <cover.1581619464.git.sai.praneeth.prakhya@intel.com>
 <5aa5ef20ff81f706aafa9a6af68cef98fe60ad0f.1581619464.git.sai.praneeth.prakhya@intel.com>
 <20200302150833.GA6540@8bytes.org>
 <7fcadd2a-76cd-2114-bb5f-c916fd14e1cb@linux.intel.com>
 <20200303131326.GB13185@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <64f24e39-2abb-992d-d7ca-8e47c927aff3@linux.intel.com>
Date: Wed, 4 Mar 2020 20:17:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303131326.GB13185@8bytes.org>
Content-Language: en-US
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

Hi Joerg,

On 2020/3/3 21:13, Joerg Roedel wrote:
> Hi Baolu,
> 
> On Tue, Mar 03, 2020 at 02:47:02PM +0800, Lu Baolu wrote:
>> Theoretically speaking, per-device default domain is impractical. PCI
>> aliased devices (PCI bridge and all devices beneath it, VMD devices and
>> various devices quirked with pci_add_dma_alias()) must use the same
>> domain. It's likely that we have to introduce something like a sub-group
>> with all PCI aliased devices staying in it. Current private-domain
>> implementation in the vt-d driver was introduced for compatible purpose
>> and I wanted to abandon it from the first day. :-)
> 
> What hinders you from removing it now? I looked a bit closer into
> these private default domain implementation and it is very fragile. If
> it can be removed, then better do so sooner than later.
>

I will soon send out the patches for review.

>> Probably, we are able to configure per-group default domain type with
>> below two interfaces.
>>
>> - (ops->)dev_def_domain_type: Return the required default domain type
>>    for a device. It returns
>>    - IOMMU_DOMAIN_DMA (device must use a DMA domain), unlikely
>>    - IOMMU_DOMAIN_IDENTITY (device must use an Identity domain), unlikely
>>    - 0 (both are okay), likely
> 
> If we stay at the group level, this interface should work on the group
> level too, and not on the device level.
> 
>> - iommu_group_change_def_domain: Change the default domain of a group
>>    Works only when all devices have no driver bond.
> 
> Btw, I have no objections about the concept of private default domains
> for devices, but the implementation should be moved to generic IOMMU
> code so that the behavior is consistent accross differnet IOMMU
> platforms, and of course be robust.
>

Yes. I agree with you.

> 
> Regards,
> 
> 	Joerg
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
