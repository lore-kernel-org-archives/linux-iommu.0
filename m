Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B394FC433C1
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 20:48:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2427761A28
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 20:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2427761A28
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D535240F6B;
	Thu, 25 Mar 2021 20:48:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k94mavru9172; Thu, 25 Mar 2021 20:48:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1CD1C405C5;
	Thu, 25 Mar 2021 20:48:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE79AC000E;
	Thu, 25 Mar 2021 20:48:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DB20C000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 20:48:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 025B740F60
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 20:48:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mSA8Mu2MDb7l for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 20:48:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7B31D40ED2
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 20:48:18 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 7E04C5807E8;
 Thu, 25 Mar 2021 16:48:15 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute4.internal (MEProxy); Thu, 25 Mar 2021 16:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm1; bh=BopbUwo+71LF70JJ+LzTjR0pX9XT
 ynwjRdypsYc+V7k=; b=KcPhafu0alFiQH3XvUxwxKxQ75ROuqT/rOq/4zHo8T6o
 SihJqEE5Hb+sicyWodLFzCskUDN1+Ok0q/V0OHm+ph/ls07KEodaFwHUfmMdiCBf
 nhvrZm/CpSiOq1I1Dws3LUGSvDQGG7r96wgiSFyPtXHgtcvuZPESr7r/tFH5jvWu
 m7nv8dD+lTO8tTZvZkpQOmo76hTlnTT1b1mjPwrQdDNn1bCV2J1BMlVX8TqW/QL4
 fdSYDZgLW+GFstjVsLFnuYd0YaJfUMO5R+be5a6E2CpRj2lOlqHnXfNciIYIX+jk
 wW8QlrT6kxrVa1WUzi4Ga0Zl/D12YwPeLou992YwHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=BopbUw
 o+71LF70JJ+LzTjR0pX9XTynwjRdypsYc+V7k=; b=GtYZhRpsMI6RKLnf6NgsNW
 XrRlmjGAdjKGJzbnOHoH8ZtKxtLtGVWY5iEhOqx9W678Zj8hKgUUSQ4JS/zGqMNk
 g6I8PHVaeBsPUgQLPlu+TdCwoShXDF/UE0Wp9DK0qTF7G7ewWiURQaoMNO0vxkXw
 9rx8xjfpYXE4oiE+62emOr1DxxvpDMOdrkqEb9QD6gNbNgxEuysH93zH71urPy8f
 CtEoKofkH8oVedQiR6uqrH47nZyndxH+saG+607h/eg06tdmQ2VQKW27GeAoIcGW
 VdSqkchwEnve+R/E1r9d/ETYWDAIPvRqsjD5GjKBX0Ay9NRbKkYTjC6W8Ql5Oyaw
 ==
X-ME-Sender: <xms:DfdcYCEJYg9FwIFbnhAvd8u56Em0zHFWcXMCOTowJef8QCMXg1iEFg>
 <xme:DfdcYJUo8YETnJuQTpfAcq6mw5XbzF-_hJ_FSl-uiDkUPCMxOY1bIUiWIsg2TY_se
 G0lQJi44C_LfYS_Wic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehtddgudeggecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
 vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
 grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
 vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:DfdcYJwbydEVM8v8UAnQlzvlk8x7Utj_P7QSbw-E26ivPXnehtmQZA>
 <xmx:DfdcYHMyGeVmI-mI8BaiCIujk4xhkoLje3xUFzbeMLOnrn7DA7AzHg>
 <xmx:DfdcYK5K2FRkE9VUOyPNm3vyq8kViZ5ElSHE0igfk0xLBiCGymOz6w>
 <xmx:D_dcYOK5sjk2Uo7RmNTDqxLfz3y3lgAT0v4DrVuk_Z6Q2bAaSB3luG7Ssyk>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 1EA3851C005F; Thu, 25 Mar 2021 16:48:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <0391ede7-42d0-4169-ae4f-dfba5e6486b7@www.fastmail.com>
In-Reply-To: <2e7e4002-4f37-9348-40e6-aaa523207472@arm.com>
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <20210320151903.60759-2-sven@svenpeter.dev>
 <2e7e4002-4f37-9348-40e6-aaa523207472@arm.com>
Date: Thu, 25 Mar 2021 21:47:52 +0100
To: "Robin Murphy" <robin.murphy@arm.com>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 1/3] iommu: io-pgtable: add DART pagetable format
Cc: Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Stan Skowronek <stan@corellium.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mark Kettenis <mark.kettenis@xs4all.nl>
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Robin,

Thanks for the review!

On Wed, Mar 24, 2021, at 17:37, Robin Murphy wrote:
> On 2021-03-20 15:19, Sven Peter wrote:
> > Apple's DART iommu uses a pagetable format that's very similar to the ones
> > already implemented by io-pgtable.c.
> > Add a new format variant to support the required differences.
> 
> TBH there look to be more differences than similarities, but I guess we 
> already opened that door with the Mali format, and nobody likes writing 
> pagetable code :)

Fair enough. There are some similarities but especially the actual
PTE format is completely different. And yes, I very much prefer to use
well-tested and written pagetable code rather than coming up with
my own if possible :-)


> 
> > Signed-off-by: Sven Peter <sven@svenpeter.dev>
> > ---
> >   drivers/iommu/Kconfig          | 13 +++++++
> >   drivers/iommu/io-pgtable-arm.c | 70 ++++++++++++++++++++++++++++++++++
> >   drivers/iommu/io-pgtable.c     |  3 ++
> >   include/linux/io-pgtable.h     |  6 +++
> >   4 files changed, 92 insertions(+)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 192ef8f61310..3c95c8524abe 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -39,6 +39,19 @@ config IOMMU_IO_PGTABLE_LPAE
> >   	  sizes at both stage-1 and stage-2, as well as address spaces
> >   	  up to 48-bits in size.
> > 
> > +config IOMMU_IO_PGTABLE_APPLE_DART
> 
> Does this really need to be configurable? I don't think there's an 
> appreciable code saving to be had, and it's not like we do it for any of 
> the other sub-formats.
> 

Probably not, I'll just make it unconditional for v2.

> > +	bool "Apple DART Descriptor Format"
> > +	select IOMMU_IO_PGTABLE
> > +	select IOMMU_IO_PGTABLE_LPAE
> > +	depends on ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
> > +	help
> > +	  Enable support for the Apple DART iommu pagetable format.
> > +	  This format is a variant of the ARMv7/v8 Long Descriptor
> > +	  Format specific to Apple's iommu found in their SoCs.
> > +
> > +	  Say Y here if you have a Apple SoC like the M1 which
> > +	  contains DART iommus.
> > +
> >   config IOMMU_IO_PGTABLE_LPAE_SELFTEST
> >   	bool "LPAE selftests"
> >   	depends on IOMMU_IO_PGTABLE_LPAE
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > index 87def58e79b5..18674469313d 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -127,6 +127,10 @@
> >   #define ARM_MALI_LPAE_MEMATTR_IMP_DEF	0x88ULL
> >   #define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL
> > 
> > +/* APPLE_DART_PTE_PROT_NO_WRITE actually maps to ARM_LPAE_PTE_AP_RDONLY  */
> > +#define APPLE_DART_PTE_PROT_NO_WRITE (1<<7)
> Given that there's apparently zero similarity with any of the other 
> attributes/permissions, this seems more like a coincidence that probably 
> doesn't need to be called out.

Agreed, removed for v2.

> 
> > +#define APPLE_DART_PTE_PROT_NO_READ (1<<8)
> > +
> 
> Do you have XN permission? How about memory type attributes?

I haven't been able to find either of them yet.

There is no (public) documentation for this hardware and this was all
figured out by essentially looking at the pagetables the (unknown)
first-level bootloader left around for us by the time we get to run code
and by flipping bits in HW registers or pagetables and observing what happens.

I only have the framebuffer and USB running right now and neither of
them are able to run code so I can't really find the NX bit if it exists.
I'm not sure if there are any peripherals that can even execute code
from pages mapped through a DART. *Maybe* the GPU but it'll still take
a while until we can tackle that one.

I'll see if I can find something that controls memory attributes though.

The only other way would be to actually reverse engineer Apple code but
that's something I've been deliberately avoiding and I'd really like to
keep it that way.


> 
> >   /* IOPTE accessors */
> >   #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
> > 
> > @@ -381,6 +385,17 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
> >   {
> >   	arm_lpae_iopte pte;
> > 
> > +#ifdef CONFIG_IOMMU_IO_PGTABLE_APPLE_DART
> 
> As a general tip, prefer IS_ENABLED() to inline #ifdefs.

Thanks, will keep that in mind for the future! This #ifdef here will disappear
in v2 once I remove this from Kconfig.

> 
> > +	if (data->iop.fmt == ARM_APPLE_DART) { > +		pte = 0;
> > +		if (!(prot & IOMMU_WRITE))
> > +			pte |= APPLE_DART_PTE_PROT_NO_WRITE;
> > +		if (!(prot & IOMMU_READ))
> > +			pte |= APPLE_DART_PTE_PROT_NO_READ;
> > +		return pte;
> > +	}
> > +#endif
> > +
> >   	if (data->iop.fmt == ARM_64_LPAE_S1 ||
> >   	    data->iop.fmt == ARM_32_LPAE_S1) {
> >   		pte = ARM_LPAE_PTE_nG;
> > @@ -1043,6 +1058,54 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> >   	return NULL;
> >   }
> > 
> > +#ifdef CONFIG_IOMMU_IO_PGTABLE_APPLE_DART
> 
> Similarly, prefer __maybe_unused rather than #ifdefing functions if they 
> don't contain any config-dependent references.

Will also keep that mind for the future since I probably won't need that for v2.

> 
> > +static struct io_pgtable *
> > +apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> > +{
> > +	struct arm_lpae_io_pgtable *data;
> > +
> > +	if (cfg->ias > 38)
> > +		return NULL;
> > +	if (cfg->oas > 36)
> > +		return NULL;
> > +
> > +	if (!cfg->coherent_walk)
> > +		return NULL;
> 
> For completeness you should probably also reject any quirks, since none 
> of them are applicable either.

Good point, added for v2.

> 
> > +
> > +	cfg->pgsize_bitmap &= SZ_16K;
> 
> No block mappings?

Don't think so. I've tried this early on and couldn't get it to work.
The HW just ignored my block mappings and reported faults for any iova
in there. I'll check again this weekend though to be sure.

> 
> > +	if (!cfg->pgsize_bitmap)
> > +		return NULL;
> > +
> > +	data = arm_lpae_alloc_pgtable(cfg);
> > +	if (!data)
> > +		return NULL;
> > +
> > +	/*
> > +	 * the hardware only supports this specific three level pagetable layout with
> > +	 * the first level being encoded into four hardware registers
> > +	 */
> > +	data->start_level = ARM_LPAE_MAX_LEVELS - 2;
> 
> The comment implies that walks should start at level 1 (for a 3-level 
> table), but the code here says (in an unnecessarily roundabout manner) 
> level 2 :/
> 
> Which is it?

Now that I'm reading it again it does sound very confusing. This is essentially
a small workaround to be able to reuse this code.

I'll fix the strange way to encode that we start at level 2 and I'll replace the
comment with a better explanation for v2:

	/*
	 * This is how the hardware actually works:
	 *   First level: four registers pointing to the second level tables.
	 *   Second level: 2048 entries pointing to the third level tables.
	 *   Third level: 2048 entries pointing to pages.
	 *
	 *  And this is how we pretend the hardware works:
	 *    First fake level: Merges first and second level, i.e.
	 *       4x2048 entries pointing to the second fake / third real
	 *      level tables
	 *    Second fake level: Equivalent to the third real level.
	 *       2048 entries pointing to pages.
	 *
	 * We then set up the four hardware registers to point to the first
         * 'fake' pagetable with different offsets (0x0, 0x4000, 0x8000, 0xc000).
	 */

I hope that makes it more clear what happens there.

> 
> > +	data->pgd_bits = 13;
> 
> What if ias < 38? Couldn't we get away with only allocating as much as 
> we actually need?

Good idea, will fix that for v2.

> 
> > +	data->bits_per_level = 11;
> > +
> > +	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data), GFP_KERNEL,
> > +					   cfg);
> > +	if (!data->pgd)
> > +		goto out_free_data;
> > +
> > +	cfg->apple_dart_cfg.pgd[0] = virt_to_phys(data->pgd);
> > +	cfg->apple_dart_cfg.pgd[1] = virt_to_phys(data->pgd + 0x4000);
> > +	cfg->apple_dart_cfg.pgd[2] = virt_to_phys(data->pgd + 0x8000);
> > +	cfg->apple_dart_cfg.pgd[3] = virt_to_phys(data->pgd + 0xc000);
> > +
> > +	return &data->iop;
> > +
> > +out_free_data:
> > +	kfree(data);
> > +	return NULL;
> > +}
> > +#endif
> > +
> >   struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
> >   	.alloc	= arm_64_lpae_alloc_pgtable_s1,
> >   	.free	= arm_lpae_free_pgtable,
> > @@ -1068,6 +1131,13 @@ struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
> >   	.free	= arm_lpae_free_pgtable,
> >   };
> > 
> > +#ifdef CONFIG_IOMMU_IO_PGTABLE_APPLE_DART
> > +struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns = {
> > +	.alloc	= apple_dart_alloc_pgtable,
> > +	.free	= arm_lpae_free_pgtable,
> > +};
> > +#endif
> > +
> >   #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
> > 
> >   static struct io_pgtable_cfg *cfg_cookie __initdata;
> > diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> > index 6e9917ce980f..d86590b0673a 100644
> > --- a/drivers/iommu/io-pgtable.c
> > +++ b/drivers/iommu/io-pgtable.c
> > @@ -27,6 +27,9 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
> >   #ifdef CONFIG_AMD_IOMMU
> >   	[AMD_IOMMU_V1] = &io_pgtable_amd_iommu_v1_init_fns,
> >   #endif
> > +#ifdef CONFIG_IOMMU_IO_PGTABLE_APPLE_DART
> > +	[ARM_APPLE_DART] = &io_pgtable_apple_dart_init_fns,
> > +#endif
> >   };
> > 
> >   struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
> > diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> > index a4c9ca2c31f1..19d9b631d319 100644
> > --- a/include/linux/io-pgtable.h
> > +++ b/include/linux/io-pgtable.h
> > @@ -16,6 +16,7 @@ enum io_pgtable_fmt {
> >   	ARM_V7S,
> >   	ARM_MALI_LPAE,
> >   	AMD_IOMMU_V1,
> > +	ARM_APPLE_DART,
> >   	IO_PGTABLE_NUM_FMTS,
> >   };
> > 
> > @@ -136,6 +137,10 @@ struct io_pgtable_cfg {
> >   			u64	transtab;
> >   			u64	memattr;
> >   		} arm_mali_lpae_cfg;
> > +
> > +		struct {
> > +			u64 pgd[4];
> 
> Nit: in the driver you call the registers "TTBR" rather than "PGD". The 
> config here tries to represent hardware/architecture definitions rather 
> than internal abstractions.
> 

Renamed for v2.


Thanks!


Sven
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
