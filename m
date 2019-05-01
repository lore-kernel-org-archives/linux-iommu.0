Return-Path: <SRS0=GORt=TB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBE4C43219
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 13:22:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19469206DF
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 13:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19469206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F1F5C27B0;
	Wed,  1 May 2019 13:22:16 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 356A027A6
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 13:21:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id B736C189
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 13:21:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C3BB80D;
	Wed,  1 May 2019 06:21:36 -0700 (PDT)
Received: from [10.1.30.200] (unknown [10.1.30.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 408373F5C1;
	Wed,  1 May 2019 06:21:34 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] PCIe Host request to reserve IOVA
To: Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
	<20190501113038.GA7961@e121166-lin.cambridge.arm.com>
	<20190501125530.GA15590@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <119be78f-34f5-c19b-d41b-f7279e968b46@arm.com>
Date: Wed, 1 May 2019 14:20:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501125530.GA15590@google.com>
Content-Language: en-GB
Cc: poza@codeaurora.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
	Srinath Mannam <srinath.mannam@broadcom.com>
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
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190501132056.vj40gksMg3DVd3Dpp5QScJ0X5oRKsq3sUla7NfxzaLg@z>

On 2019-05-01 1:55 pm, Bjorn Helgaas wrote:
> On Wed, May 01, 2019 at 12:30:38PM +0100, Lorenzo Pieralisi wrote:
>> On Fri, Apr 12, 2019 at 08:43:32AM +0530, Srinath Mannam wrote:
>>> Few SOCs have limitation that their PCIe host can't allow few inbound
>>> address ranges. Allowed inbound address ranges are listed in dma-ranges
>>> DT property and this address ranges are required to do IOVA mapping.
>>> Remaining address ranges have to be reserved in IOVA mapping.
>>>
>>> PCIe Host driver of those SOCs has to list resource entries of allowed
>>> address ranges given in dma-ranges DT property in sorted order. This
>>> sorted list of resources will be processed and reserve IOVA address for
>>> inaccessible address holes while initializing IOMMU domain.
>>>
>>> This patch set is based on Linux-5.0-rc2.
>>>
>>> Changes from v3:
>>>    - Addressed Robin Murphy review comments.
>>>      - pcie-iproc: parse dma-ranges and make sorted resource list.
>>>      - dma-iommu: process list and reserve gaps between entries
>>>
>>> Changes from v2:
>>>    - Patch set rebased to Linux-5.0-rc2
>>>
>>> Changes from v1:
>>>    - Addressed Oza review comments.
>>>
>>> Srinath Mannam (3):
>>>    PCI: Add dma_ranges window list
>>>    iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
>>>    PCI: iproc: Add sorted dma ranges resource entries to host bridge
>>>
>>>   drivers/iommu/dma-iommu.c           | 19 ++++++++++++++++
>>>   drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
>>>   drivers/pci/probe.c                 |  3 +++
>>>   include/linux/pci.h                 |  1 +
>>>   4 files changed, 66 insertions(+), 1 deletion(-)
>>
>> Bjorn, Joerg,
>>
>> this series should not affect anything in the mainline other than its
>> consumer (ie patch 3); if that's the case should we consider it for v5.2
>> and if yes how are we going to merge it ?
> 
> I acked the first one
> 
> Robin reviewed the second
> (https://lore.kernel.org/lkml/e6c812d6-0cad-4cfd-defd-d7ec427a6538@arm.com)
> (though I do agree with his comment about DMA_BIT_MASK()), Joerg was OK
> with it if Robin was
> (https://lore.kernel.org/lkml/20190423145721.GH29810@8bytes.org).
> 
> Eric reviewed the third (and pointed out a typo).
> 
> My Kconfiggery never got fully answered -- it looks to me as though it's
> possible to build pcie-iproc without the DMA hole support, and I thought
> the whole point of this series was to deal with those holes
> (https://lore.kernel.org/lkml/20190418234241.GF126710@google.com).  I would
> have expected something like making pcie-iproc depend on IOMMU_SUPPORT.
> But Srinath didn't respond to that, so maybe it's not an issue and it
> should only affect pcie-iproc anyway.

Hmm, I'm sure I had at least half-written a reply on that point, but I 
can't seem to find it now... anyway, the gist is that these inbound 
windows are generally set up to cover the physical address ranges of 
DRAM and anything else that devices might need to DMA to. Thus if you're 
not using an IOMMU, the fact that devices can't access the gaps in 
between doesn't matter because there won't be anything there anyway; it 
only needs mitigating if you do use an IOMMU and start giving arbitrary 
non-physical addresses to the endpoint.

> So bottom line, I'm fine with merging it for v5.2.  Do you want to merge
> it, Lorenzo, or ...?

This doesn't look like it will conflict with the other DMA ops and MSI 
mapping changes currently in-flight for iommu-dma, so I have no 
objection to it going through the PCI tree for 5.2.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
