From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v8 06/08] iommu/ipmmu-vmsa: Use fwspec iommu_priv on ARM64
Date: Thu, 18 May 2017 14:23:29 +0900
Message-ID: <CANqRtoQRCZsU9873=M+ac1qDBE5jtFOpDeZJZUgvvuoz+7YwEg@mail.gmail.com>
References: <149501557669.21593.1017116915706613060.sendpatchset@little-apple>
 <149501564036.21593.16964345443958773870.sendpatchset@little-apple> <2c64bcfc-e93b-703a-0326-54b6eef73766@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <2c64bcfc-e93b-703a-0326-54b6eef73766@arm.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro <joro@8bytes.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Sricharan R <sricharan@codeaurora.org>, Will Deacon <will.deacon@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, iommu@lists.linux-foundation.org, Simon Horman <horms+renesas@verge.net.au>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Wed, May 17, 2017 at 11:29 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> Hi Magnus,
>
> On 17/05/17 11:07, Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Convert from archdata to iommu_priv via iommu_fwspec on ARM64 but
>> let 32-bit ARM keep on using archdata for now.
>>
>> Once the 32-bit ARM code and the IPMMU driver is able to move over
>> to CONFIG_IOMMU_DMA=y then coverting to fwspec via ->of_xlate() will
>> be easy.
>>
>> For now fwspec ids and num_ids are not used to allow code sharing between
>> 32-bit and 64-bit ARM code inside the driver.
>
> That's not what I meant at all - this just looks like a crazy
> unmaintainable mess that's making things that much harder to unpick in
> future.
>
> Leaving the existing code fossilised and building up half of a second
> separate driver around it wrapped in ifdefs is not only hideous, it's
> more work in the end than simply pulling things into the right shape to
> begin with. What I meant was to start with the below (compile-tested
> only), and add the of_xlate support on top. AFAICS the arm/arm64
> differences overall should only come down to a bit of special-casing in
> add_device(), and (optionally) whether you outright reject
> IOMMU_DOMAIN_DMA or not.
>
> Sorry, but I just can't agree with the two-drivers-in-one approach.

Thanks for checking the code and sorry to disappoint you by not using
->ids[] and ->num_ids right away. The two-drivers-on-one approach
comes from wanting to use the same IOMMU driver on both 32-bit and
64-bit ARM architectures but the former is lacking IOMMU_DMA support
upstream.

Obviously using ->ids[] and ->num_ids is the right forward, and in my
mind it is only a question of time and merge order. I'm more than
happy to make use of your patch but I'm wondering if it will work on
32-bit ARM and R-Car Gen2 that currently does not use ->of_xlate(). I
can see that you're using iommu_fwspec_init() so it might work right
out of the box. Thanks for your help cooking up the patch by the way.

>From my side I was hoping on doing one larger feature jump for 32-bit
ARM by moving over to IOMMU_DMA=y together with ->of_xlate()and fwspec
at the same time. Doing minor increments of the legacy code that is
still using special mapping code instead of OMMU_DMA=y in case of
32-bit ARM just feels like a lot of potential breakage and little gain
to me.

What's the plan for supporting IOMMU_DMA=y on 32-bit ARM? Anything I
can do to help? Or do you prefer minor increments on 32-bit ARM over
larger feature jumps?

Let me know what you think. My plan is to revisit this topic early next week.

Cheers,

/ magnus
