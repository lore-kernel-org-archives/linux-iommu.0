Return-Path: <SRS0=E6XH=VT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D80C76190
	for <iommu@archiver.kernel.org>; Mon, 22 Jul 2019 23:09:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3D921985
	for <iommu@archiver.kernel.org>; Mon, 22 Jul 2019 23:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3D921985
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8D695B65;
	Mon, 22 Jul 2019 23:09:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D375DAD1
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Jul 2019 23:09:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D6704F8
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Jul 2019 23:09:11 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
	server-digest SHA256) (No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 45sy3P6Gzrz9s8m;
	Tue, 23 Jul 2019 09:09:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shawn Anastasio <shawn@anastas.io>, Arnd Bergmann <arnd@arndb.de>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] powerpc/dma: Fix invalid DMA mmap behavior
In-Reply-To: <ff0c5578-1cb4-af29-ca40-ef2c6b246d2f@anastas.io>
References: <20190717235437.12908-1-shawn@anastas.io>
	<8b6963ac-521a-5752-2cfb-bcd87cad9dc4@ozlabs.ru>
	<f9753335-b62c-67b4-84d7-7b67fe1b64ca@anastas.io>
	<CAOSf1CGA_fDH7aAqRkc4maJUByaX7adGcjyt3cj4KFsMJNnocA@mail.gmail.com>
	<20190718084934.GF24562@lst.de> <20190718095200.GA25744@lst.de>
	<CAK8P3a1ChtE10D=enp_a+isBCGgRW1nX6-0jChuAvTcUAWECBg@mail.gmail.com>
	<87ef2i6z99.fsf@concordia.ellerman.id.au>
	<ff0c5578-1cb4-af29-ca40-ef2c6b246d2f@anastas.io>
Date: Tue, 23 Jul 2019 09:09:04 +1000
Message-ID: <87blxl7jlb.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Cc: Sam Bobroff <sbobroff@linux.ibm.com>,
	"open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
	Oliver O'Halloran <oohall@gmail.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Shawn Anastasio <shawn@anastas.io> writes:
> On 7/22/19 7:16 AM, Michael Ellerman wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>>> On Thu, Jul 18, 2019 at 11:52 AM Christoph Hellwig <hch@lst.de> wrote:
>>>> On Thu, Jul 18, 2019 at 10:49:34AM +0200, Christoph Hellwig wrote:
>>>>> On Thu, Jul 18, 2019 at 01:45:16PM +1000, Oliver O'Halloran wrote:
>>>>>>> Other than m68k, mips, and arm64, everybody else that doesn't have
>>>>>>> ARCH_NO_COHERENT_DMA_MMAP set uses this default implementation, so
>>>>>>> I assume this behavior is acceptable on those architectures.
>>>>>>
>>>>>> It might be acceptable, but there's no reason to use pgport_noncached
>>>>>> if the platform supports cache-coherent DMA.
>>>>>>
>>>>>> Christoph (+cc) made the change so maybe he saw something we're missing.
>>>>>
>>>>> I always found the forcing of noncached access even for coherent
>>>>> devices a little odd, but this was inherited from the previous
>>>>> implementation, which surprised me a bit as the different attributes
>>>>> are usually problematic even on x86.  Let me dig into the history a
>>>>> bit more, but I suspect the righ fix is to default to cached mappings
>>>>> for coherent devices.
>>>>
>>>> Ok, some history:
>>>>
>>>> The generic dma mmap implementation, which we are effectively still
>>>> using today was added by:
>>>>
>>>> commit 64ccc9c033c6089b2d426dad3c56477ab066c999
>>>> Author: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> Date:   Thu Jun 14 13:03:04 2012 +0200
>>>>
>>>>      common: dma-mapping: add support for generic dma_mmap_* calls
>>>>
>>>> and unconditionally uses pgprot_noncached in dma_common_mmap, which is
>>>> then used as the fallback by dma_mmap_attrs if no ->mmap method is
>>>> present.  At that point we already had the powerpc implementation
>>>> that only uses pgprot_noncached for non-coherent mappings, and
>>>> the arm one, which uses pgprot_writecombine if DMA_ATTR_WRITE_COMBINE
>>>> is set and otherwise pgprot_dmacoherent, which seems to be uncached.
>>>> Arm did support coherent platforms at that time, but they might have
>>>> been an afterthought and not handled properly.
>>>
>>> Cache-coherent devices are still very rare on 32-bit ARM.
>>>
>>> Among the callers of dma_mmap_coherent(), almost all are in platform
>>> specific device drivers that only ever run on noncoherent ARM SoCs,
>>> which explains why nobody would have noticed problems.
>>>
>>> There is also a difference in behavior between ARM and PowerPC
>>> when dealing with mismatched cacheability attributes: If the same
>>> page is mapped as both cached and uncached to, this may
>>> cause silent undefined behavior on ARM, while PowerPC should
>>> enter a checkstop as soon as it notices.
>> 
>> On newer Power CPUs it's actually more like the ARM behaviour.
>> 
>> I don't know for sure that it will *never* checkstop but there are at
>> least cases where it won't. There's some (not much) detail in the
>> Power8/9 user manuals.
>
> The issue was discovered due to sporadic checkstops on P9, so it
> seems like it will happen at least sometimes.

Yeah true. I wasn't sure if that checkstop was actually caused by a
cached/uncached mismatch or something else, but looks like it was, from
the hostboot issue (https://github.com/open-power/hostboot/issues/180):

  12.47015|  Signature Description    : pu.ex:k0:n0:s0:p00:c0 (L2FIR[16]) Cache line inhibited hit cacheable space


So I'm not really sure how to square that with the documentation in the
user manual:

  If a caching-inhibited load instruction hits in the L1 data cache, the
  load data is serviced from the L1 data cache and no request is sent to
  the NCU.
  If a caching-inhibited store instruction hits in the L1 data cache,
  the store data is written to the L1 data cache and sent to the NCU.
  Note that the L1 data cache and L2 cache are no longer coherent.

I guess I'm either misinterpreting that section or there's some *other*
documentation somewhere I haven't found that says that it will also
checkstop.

cheers
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
