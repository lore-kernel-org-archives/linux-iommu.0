Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DD8C55178
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 15:30:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD1E2078E
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 15:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD1E2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1DAE486418;
	Thu,  5 Nov 2020 15:30:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tC-O0U5gowds; Thu,  5 Nov 2020 15:30:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EBD6286151;
	Thu,  5 Nov 2020 15:30:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDAA3C088B;
	Thu,  5 Nov 2020 15:30:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 539F7C0889
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 15:30:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 480A58718E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 15:30:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xc3JbNjPsfhS for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 15:30:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 104A787186
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 15:30:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EB0514BF;
 Thu,  5 Nov 2020 07:30:01 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 593BA3F718;
 Thu,  5 Nov 2020 07:29:59 -0800 (PST)
Subject: Re: [PATCH 1/6] RMDA/sw: don't allow drivers using dma_virt_ops on
 highmem configs
To: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>
References: <20201105074205.1690638-1-hch@lst.de>
 <20201105074205.1690638-2-hch@lst.de> <20201105144123.GB4142106@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <74729b8d-146f-803a-98a3-e8149bd97e34@arm.com>
Date: Thu, 5 Nov 2020 15:29:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201105144123.GB4142106@ziepe.ca>
Content-Language: en-GB
Cc: Zhu Yanjun <yanjunz@nvidia.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Logan Gunthorpe <logang@deltatee.com>
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

On 2020-11-05 14:41, Jason Gunthorpe wrote:
> On Thu, Nov 05, 2020 at 08:42:00AM +0100, Christoph Hellwig wrote:
>> dma_virt_ops requires that all pages have a kernel virtual address.
>> Introduce a INFINIBAND_VIRT_DMA Kconfig symbol that depends on !HIGHMEM
>> and a large enough dma_addr_t, and make all three driver depend on the
>> new symbol.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>   drivers/infiniband/Kconfig           | 6 ++++++
>>   drivers/infiniband/sw/rdmavt/Kconfig | 3 ++-
>>   drivers/infiniband/sw/rxe/Kconfig    | 2 +-
>>   drivers/infiniband/sw/siw/Kconfig    | 1 +
>>   4 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
>> index 32a51432ec4f73..81acaf5fb5be67 100644
>> +++ b/drivers/infiniband/Kconfig
>> @@ -73,6 +73,12 @@ config INFINIBAND_ADDR_TRANS_CONFIGFS
>>   	  This allows the user to config the default GID type that the CM
>>   	  uses for each device, when initiaing new connections.
>>   
>> +config INFINIBAND_VIRT_DMA
>> +	bool
>> +	default y
> 
> Oh, I haven't seen this kconfig trick with default before..

It's commonly done using the "def_bool" shorthand. I fact, I think 
simply "def_bool !HIGHMEM" would suffice for the fundamental definition 
here.

>> +	depends on !HIGHMEM
>> +	depends on !64BIT || ARCH_DMA_ADDR_T_64BIT
>> +
>>   if INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
>>   source "drivers/infiniband/hw/mthca/Kconfig"
>>   source "drivers/infiniband/hw/qib/Kconfig"
>> diff --git a/drivers/infiniband/sw/rdmavt/Kconfig b/drivers/infiniband/sw/rdmavt/Kconfig
>> index 9ef5f5ce1ff6b0..c8e268082952b0 100644
>> +++ b/drivers/infiniband/sw/rdmavt/Kconfig
>> @@ -1,7 +1,8 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   config INFINIBAND_RDMAVT
>>   	tristate "RDMA verbs transport library"
>> -	depends on X86_64 && ARCH_DMA_ADDR_T_64BIT
>> +	depends on INFINIBAND_VIRT_DMA
> 
> Usually I would expect a non-menu item to be used with select not
> 'depends on' - is the use of default avoiding that?

A select wouldn't make any sense here - if the user chooses to enable 
the subsystem it can't automatically pull in "the absence of highmem" 
from the arch code; there's still a literal dependency on certain 
conditions being met for the option to be available. The intermediate 
config symbol just abstracts that set of conditions.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
