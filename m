Return-Path: <SRS0=zRLl=YR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD230CA9EAF
	for <iommu@archiver.kernel.org>; Thu, 24 Oct 2019 11:04:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FE420856
	for <iommu@archiver.kernel.org>; Thu, 24 Oct 2019 11:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FE420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 85FBC1420;
	Thu, 24 Oct 2019 11:04:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F0C3DBA9
	for <iommu@lists.linux-foundation.org>;
	Thu, 24 Oct 2019 11:04:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (unknown [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 7CB9E8AD
	for <iommu@lists.linux-foundation.org>;
	Thu, 24 Oct 2019 11:04:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0830695D;
	Thu, 24 Oct 2019 04:04:13 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07EA83F71A;
	Thu, 24 Oct 2019 04:04:10 -0700 (PDT)
Subject: Re: [RFC PATCH 1/3] dma-mapping: introduce a new dma api
	dma_addr_to_phys_addr()
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>, "hch@lst.de" <hch@lst.de>
References: <20191022125502.12495-1-laurentiu.tudor@nxp.com>
	<20191022125502.12495-2-laurentiu.tudor@nxp.com>
	<62561dca-cdd7-fe01-a0c3-7b5971c96e7e@arm.com>
	<50a42575-02b2-c558-0609-90e2ad3f515b@nxp.com>
	<20191024020140.GA6057@lst.de>
	<ebbf742e-4d1f-ba90-0ed8-93ea445d0200@nxp.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2b75c349-0ca1-ea7e-6571-28db9f1a8c46@arm.com>
Date: Thu, 24 Oct 2019 12:04:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
	Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <ebbf742e-4d1f-ba90-0ed8-93ea445d0200@nxp.com>
Content-Language: en-GB
Cc: Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Leo Li <leoyang.li@nxp.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	"davem@davemloft.net" <davem@davemloft.net>
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

On 2019-10-24 8:49 am, Laurentiu Tudor wrote:
> 
> 
> On 24.10.2019 05:01, hch@lst.de wrote:
>> On Wed, Oct 23, 2019 at 11:53:41AM +0000, Laurentiu Tudor wrote:
>>> We had an internal discussion over these points you are raising and
>>> Madalin (cc-ed) came up with another idea: instead of adding this prone
>>> to misuse api how about experimenting with a new dma unmap and dma sync
>>> variants that would return the physical address by calling the newly
>>> introduced dma map op. Something along these lines:
>>>     * phys_addr_t dma_unmap_page_ret_phys(...)
>>>     * phys_addr_t dma_unmap_single_ret_phys(...)
>>>     * phys_addr_t dma_sync_single_for_cpu_ret_phys(...)
>>> I'm thinking that this proposal should reduce the risks opened by the
>>> initial variant.
>>> Please let me know what you think.
>>
>> I'm not sure what the ret is supposed to mean, but I generally like
>> that idea better.
> 
> It was supposed to be short for "return" but given that I'm not good at
> naming stuff I'll just drop it.

Hmm, how about something like "dma_unmap_*_desc" for the context of the 
mapped DMA address also being used as a descriptor token?

>> We also need to make sure there is an easy way
>> to figure out if these APIs are available, as they generally aren't
>> for any non-IOMMU API IOMMU drivers.
> 
> I was really hoping to manage making them as generic as possible but
> anyway, I'll start working on a PoC and see how it turns out. This will
> probably happen sometime next next week as the following week I'll be
> traveling to a conference.

AFAICS, even a full implementation of these APIs would have to be 
capable of returning an indication that there is no valid physical 
address - e.g. if unmap is called with a bogus DMA address that was 
never mapped. At that point there'sseemingly no problem just 
implementing the trivial case on top of any existing unmap/sync 
callbacks for everyone. I'd imagine that drivers which want this aren't 
likely to run on the older architectures where the weird IOMMUs live, so 
they could probably just always treat failure as unexpected and fatal 
either way.

In fact, I'm now wondering whether it's likely to be common that users 
want the physical address specifically, or whether it would make sense 
to return the original VA/page, both for symmetry with the corresponding 
map calls and for the ease of being able to return NULL when necessary.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
