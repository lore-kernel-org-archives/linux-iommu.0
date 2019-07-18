Return-Path: <SRS0=oZX7=VP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD280C7618F
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 20:45:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89DC6208C0
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 20:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anastas.io header.i=@anastas.io header.b="Selwz7QA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DC6208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4CDCD1DA6;
	Thu, 18 Jul 2019 20:45:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 81D7D1C80
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 19:51:47 +0000 (UTC)
X-Greylist: delayed 00:05:41 by SQLgrey-1.7.6
Received: from alpha.anastas.io (alpha.anastas.io [104.248.188.109])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 91E73891
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 19:51:45 +0000 (UTC)
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by alpha.anastas.io (Postfix) with ESMTPSA id 4CFC57F92F;
	Thu, 18 Jul 2019 14:46:03 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
	t=1563479164; bh=tL0lLp+yfKoF5lqdV9tpr77mugeehISgo5OFacFo7c8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=Selwz7QA7Bh7o1ZtCAbS6oaiKTyiycgO/O7JWUaLgDYNJf1foc+6cbNbPdsvjMBzC
	DYukHtYtJKzYE550WmtYULpA7TkRABAiHf1M6fCZWEPafzGzKjYq1urRhDknZYBxY4
	75tW2p7NDplo09JWYSx3VPf3zVfe5J/znLrZDpd8HGtt95icTijr8IYyEUQDpQDgf2
	mal11yvyjGZNts1CIcETP3vzoSR37G30ac/4xoCbozmdhMIpu7uoWmj5MvH4lMP8fO
	GvPqsPXgYAX2Z8C+BuDeQs6CF/Up7Jjwspj37Vaew0EOKqr1Y59YWmblATBjM33zuS
	Fx5khXqdICfDQ==
Subject: Re: [PATCH] powerpc/dma: Fix invalid DMA mmap behavior
To: Christoph Hellwig <hch@lst.de>, Oliver O'Halloran <oohall@gmail.com>
References: <20190717235437.12908-1-shawn@anastas.io>
	<8b6963ac-521a-5752-2cfb-bcd87cad9dc4@ozlabs.ru>
	<f9753335-b62c-67b4-84d7-7b67fe1b64ca@anastas.io>
	<CAOSf1CGA_fDH7aAqRkc4maJUByaX7adGcjyt3cj4KFsMJNnocA@mail.gmail.com>
	<20190718084934.GF24562@lst.de> <20190718095200.GA25744@lst.de>
Message-ID: <2da4fafe-93f2-4bf1-62e1-180a3ac800fa@anastas.io>
Date: Thu, 18 Jul 2019 14:46:00 -0500
MIME-Version: 1.0
In-Reply-To: <20190718095200.GA25744@lst.de>
Content-Language: en-US
X-Mailman-Approved-At: Thu, 18 Jul 2019 20:45:08 +0000
Cc: Sam Bobroff <sbobroff@linux.ibm.com>, iommu@lists.linux-foundation.org,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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
From: Shawn Anastasio via iommu <iommu@lists.linux-foundation.org>
Reply-To: Shawn Anastasio <shawn@anastas.io>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 7/18/19 4:52 AM, Christoph Hellwig wrote:
> On Thu, Jul 18, 2019 at 10:49:34AM +0200, Christoph Hellwig wrote:
>> On Thu, Jul 18, 2019 at 01:45:16PM +1000, Oliver O'Halloran wrote:
>>>> Other than m68k, mips, and arm64, everybody else that doesn't have
>>>> ARCH_NO_COHERENT_DMA_MMAP set uses this default implementation, so
>>>> I assume this behavior is acceptable on those architectures.
>>>
>>> It might be acceptable, but there's no reason to use pgport_noncached
>>> if the platform supports cache-coherent DMA.
>>>
>>> Christoph (+cc) made the change so maybe he saw something we're missing.
>>
>> I always found the forcing of noncached access even for coherent
>> devices a little odd, but this was inherited from the previous
>> implementation, which surprised me a bit as the different attributes
>> are usually problematic even on x86.  Let me dig into the history a
>> bit more, but I suspect the righ fix is to default to cached mappings
>> for coherent devices.
> 
> Ok, some history:
> 
> The generic dma mmap implementation, which we are effectively still
> using today was added by:
> 
> commit 64ccc9c033c6089b2d426dad3c56477ab066c999
> Author: Marek Szyprowski <m.szyprowski@samsung.com>
> Date:   Thu Jun 14 13:03:04 2012 +0200
> 
>      common: dma-mapping: add support for generic dma_mmap_* calls
> 
> and unconditionally uses pgprot_noncached in dma_common_mmap, which is
> then used as the fallback by dma_mmap_attrs if no ->mmap method is
> present.  At that point we already had the powerpc implementation
> that only uses pgprot_noncached for non-coherent mappings, and
> the arm one, which uses pgprot_writecombine if DMA_ATTR_WRITE_COMBINE
> is set and otherwise pgprot_dmacoherent, which seems to be uncached.
> Arm did support coherent platforms at that time, but they might have
> been an afterthought and not handled properly.
> 
> So it migt have been that we were all wrong for that time and might
> have to fix it up.

Personally, I'm not a huge fan of an implicit default for something
inherently architecture-dependent like this at all. What I'd like to
see is a mechanism that forces architecture code to explicitly
opt in to the default pgprot settings if they don't provide an
implementation of arch_dma_mmap_pgprot. This could perhaps be done
by reversing ARCH_HAS_DMA_MMAP_PGPROT to something like
ARCH_USE_DEFAULT_DMA_MMAP_PGPROT.

This way as more systems are moved to use the common mmap code instead
of their ops->mmap, the people doing the refactoring have to make an
explicit decision about the pgprot settings to use. Such a configuration
would have likely prevented this situation with powerpc from happening.

That being said, if the default behavior doesn't make sense in the
general case it should probably be fixed as well.

Curious to hear some thoughts on this.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
