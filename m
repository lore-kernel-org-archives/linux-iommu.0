Return-Path: <SRS0=V6zV=XV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A65BC4360C
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 13:04:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64DFB222BE
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 13:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64DFB222BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AC56DC6C;
	Thu, 26 Sep 2019 13:04:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 32338C64
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 13:04:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id C29308D
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 13:04:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2826142F;
	Thu, 26 Sep 2019 06:04:19 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D7E53F763;
	Thu, 26 Sep 2019 06:04:18 -0700 (PDT)
Subject: Re: [RFC PATCH 1/3] dma-mapping: make overriding GFP_* flags arch
	customizable
To: Halil Pasic <pasic@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
References: <20190923123418.22695-1-pasic@linux.ibm.com>
	<20190923123418.22695-2-pasic@linux.ibm.com>
	<20190923152117.GA2767@lst.de>
	<20190926143745.68bdd082.pasic@linux.ibm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <6c62da57-c94c-8078-957c-b6832ed7fd1b@arm.com>
Date: Thu, 26 Sep 2019 14:04:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190926143745.68bdd082.pasic@linux.ibm.com>
Content-Language: en-GB
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>, linux-kernel@vger.kernel.org,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	iommu@lists.linux-foundation.org,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>
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
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 26/09/2019 13:37, Halil Pasic wrote:
> On Mon, 23 Sep 2019 17:21:17 +0200
> Christoph Hellwig <hch@lst.de> wrote:
> 
>> On Mon, Sep 23, 2019 at 02:34:16PM +0200, Halil Pasic wrote:
>>> Before commit 57bf5a8963f8 ("dma-mapping: clear harmful GFP_* flags in
>>> common code") tweaking the client code supplied GFP_* flags used to be
>>> an issue handled in the architecture specific code. The commit message
>>> suggests, that fixing the client code would actually be a better way
>>> of dealing with this.
>>>
>>> On s390 common I/O devices are generally capable of using the full 64
>>> bit address space for DMA I/O, but some chunks of the DMA memory need to
>>> be 31 bit addressable (in physical address space) because the
>>> instructions involved mandate it. Before switching to DMA API this used
>>> to be a non-issue, we used to allocate those chunks from ZONE_DMA.
>>> Currently our only option with the DMA API is to restrict the devices to
>>> (via dma_mask and dma_mask_coherent) to 31 bit, which is sub-optimal.
>>>
>>> Thus s390 we would benefit form having control over what flags are
>>> dropped.
>>
>> No way, sorry.  You need to express that using a dma mask instead of
>> overloading the GFP flags.
> 
> Thanks for your feedback and sorry for the delay. Can you help me figure
> out how can I express that using a dma mask?
> 
> IMHO what you ask from me is frankly impossible.
> 
> What I need is the ability to ask for  (considering the physical
> address) 31 bit addressable DMA memory if the chunk is supposed to host
> control-type data that needs to be 31 bit addressable because that is
> how the architecture is, without affecting the normal data-path. So
> normally 64 bit mask is fine but occasionally (control) we would need
> a 31 bit mask.

If it's possible to rework the "data" path to use streaming mappings 
instead of coherent allocations, you could potentially mimic what virtio 
does for a similar situation - see commit a0be1db4304f.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
