Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8065CC4332F
	for <iommu@archiver.kernel.org>; Wed, 23 Mar 2022 19:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12DD484A1D;
	Wed, 23 Mar 2022 19:06:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6LIbyCfSAHqD; Wed, 23 Mar 2022 19:06:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D34B284A16;
	Wed, 23 Mar 2022 19:06:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 991ACC0012;
	Wed, 23 Mar 2022 19:06:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C4FCC000B
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 19:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2476184A1C
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 19:06:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tj00bDXbkEEt for <iommu@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 19:06:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 001FE84A16
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 19:06:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 409D0D6E;
 Wed, 23 Mar 2022 12:06:30 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A5F83F73B;
 Wed, 23 Mar 2022 12:06:27 -0700 (PDT)
Message-ID: <27b5a287-7a33-9a8b-ad6d-04746735fb0c@arm.com>
Date: Wed, 23 Mar 2022 19:06:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
Content-Language: en-GB
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
References: <1812355.tdWV9SEqCh@natalenko.name>
 <CAHk-=wiwz+Z2MaP44h086jeniG-OpK3c=FywLsCwXV7Crvadrg@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAHk-=wiwz+Z2MaP44h086jeniG-OpK3c=FywLsCwXV7Crvadrg@mail.gmail.com>
Cc: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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

On 2022-03-23 17:27, Linus Torvalds wrote:
> On Wed, Mar 23, 2022 at 12:19 AM Oleksandr Natalenko
> <oleksandr@natalenko.name> wrote:
>>
>> The following upstream commits:
>>
>> aa6f8dcbab47 swiotlb: rework "fix info leak with DMA_FROM_DEVICE"
>> ddbd89deb7d3 swiotlb: fix info leak with DMA_FROM_DEVICE
>>
>> break ath9k-based Wi-Fi access point for me. The AP emits beacons, but
>> no client can connect to it, either from the very beginning, or
>> shortly after start. These are the only symptoms I've noticed (i.e.,
>> no BUG/WARNING messages in `dmesg` etc).
> 
> Funky, but clearly true:
> 
>> These commits appeared in v5.17 and v5.16.15, and both kernels are
>> broken for me. I'm pretty confident these commits make the difference
>> since I've built both v5.17 and v5.16.15 without them, and it fixed
>> the issue.
> 
> Can you double-check (or just explicitly confirm if you already did
> that test) that you need to revert *both* of those commits, and it's
> the later "rework" fix that triggers it?
> 
>> So, I do understand this might be an issue with regard to SG I/O
>> handling in ath9k, hence relevant people in Cc.
> 
> Yeah, almost certainly an ath9k bug, but a regression is a regression,
> so if people can't find the issue in ath9k, we'll have to revert those
> commits.
> 
> Honestly, I personally think they were a bit draconian to begin with,
> and didn't limit their effects sufficiently.
> 
> I'm assuming that the ath9k issue is that it gives DMA mapping a big
> enough area to handle any possible packet size, and just expects -
> quite reasonably - smaller packets to only fill the part they need.
> 
> Which that "info leak" patch obviously breaks entirely.

Except that's the exact case which the new patch is addressing - by 
copying the whole original area into the SWIOTLB bounce buffer to begin 
with, if we bounce the whole lot back after the device has only updated 
part of it, the non-updated parts now get overwritten with the same 
original contents, rather than whatever random crap happened to be left 
in the SWIOTLB buffer by its previous user. I'm extremely puzzled how 
any driver could somehow be dependent on non-device-written data getting 
replaced with random crap, given that it wouldn't happen with a real 
IOMMU, or if SWIOTLB just didn't need to bounce, and the data would 
hardly be deterministic either.

I think I can see how aa6f8dcbab47 might increase the severity of a 
driver bug where it calls dma_sync_*_for_device() on part of a 
DMA_FROM_DEVICE mapping that the device *has* written to, without having 
called a corresponding dma_sync_*_for_cpu() first - previously that 
would have had no effect, but now SWIOTLB will effectively behave more 
like an eagerly-prefetching non-coherent cache and write back old data 
over new - but if ddbd89deb7d3 alone makes a difference then something 
really weird must be going on.

Has anyone run a sanity check with CONFIG_DMA_API_DEBUG enabled to see 
if that flags anything up?

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
