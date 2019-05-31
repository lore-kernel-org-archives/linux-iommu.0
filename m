Return-Path: <SRS0=mJb0=T7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1293DC04AB6
	for <iommu@archiver.kernel.org>; Fri, 31 May 2019 17:45:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E66B326D52
	for <iommu@archiver.kernel.org>; Fri, 31 May 2019 17:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66B326D52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A6AFB185C;
	Fri, 31 May 2019 17:45:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 487F91804
	for <iommu@lists.linux-foundation.org>;
	Fri, 31 May 2019 17:45:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 308055F4
	for <iommu@lists.linux-foundation.org>;
	Fri, 31 May 2019 17:45:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4D53A78;
	Fri, 31 May 2019 10:45:04 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEB233F59C;
	Fri, 31 May 2019 10:45:01 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] Prerequisites for NXP LS104xA SMMU enablement
To: Christoph Hellwig <hch@infradead.org>
References: <20190530141951.6704-1-laurentiu.tudor@nxp.com>
	<20190530.150844.1826796344374758568.davem@davemloft.net>
	<20190531163350.GB8708@infradead.org>
	<37406608-df48-c7a0-6975-4b4ad408ba36@arm.com>
	<20190531170804.GA12211@infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1b81c168-f5e0-f86a-f90e-22e8c3f2a602@arm.com>
Date: Fri, 31 May 2019 18:45:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531170804.GA12211@infradead.org>
Content-Language: en-GB
Cc: madalin.bucur@nxp.com, netdev@vger.kernel.org, roy.pledge@nxp.com,
	linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
	Joakim.Tjernlund@infinera.com, iommu@lists.linux-foundation.org,
	camelia.groza@nxp.com, linuxppc-dev@lists.ozlabs.org,
	David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
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

On 31/05/2019 18:08, Christoph Hellwig wrote:
> On Fri, May 31, 2019 at 06:03:30PM +0100, Robin Murphy wrote:
>>> The thing needs to be completely redone as it abuses parts of the
>>> iommu API in a completely unacceptable way.
>>
>> `git grep iommu_iova_to_phys drivers/{crypto,gpu,net}`
>>
>> :(
>>
>> I guess one alternative is for the offending drivers to maintain their own
>> lookup tables of mapped DMA addresses - I think at least some of these
>> things allow storing some kind of token in a descriptor, which even if it's
>> not big enough for a virtual address might be sufficient for an index.
> 
> Well, we'll at least need DMA API wrappers that work on the dma addr
> only and hide this madness underneath.  And then tell if an given device
> supports this and fail the probe otherwise.

Bleh, I'm certainly not keen on formalising any kind of 
dma_to_phys()/dma_to_virt() interface for this. Or are you just 
proposing something like dma_unmap_sorry_sir_the_dog_ate_my_homework() 
for drivers which have 'lost' the original VA they mapped?

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
