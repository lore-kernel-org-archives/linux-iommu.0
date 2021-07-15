Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F05C07E96
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 16:41:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DBA2613EB
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 16:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBA2613EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31DD3423A9;
	Thu, 15 Jul 2021 16:41:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8tthNCTlF8RJ; Thu, 15 Jul 2021 16:41:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5922140582;
	Thu, 15 Jul 2021 16:41:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21078C0010;
	Thu, 15 Jul 2021 16:41:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2020FC000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 16:41:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ECFF283EE0
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 16:41:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="Qw1fmKRm";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="LOQHq7Qu"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mgSNWrFwHW4T for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 16:41:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 829B083EE1
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 16:41:41 +0000 (UTC)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id 4CC975803B9;
 Thu, 15 Jul 2021 12:41:39 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Thu, 15 Jul 2021 12:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm1; bh=iVxU7AAJ5cGlvCJLWVtLKD/A+jxO
 MQaqMWyCXRBMJvk=; b=Qw1fmKRm25Q/UDsMe/hbqQrQ3zNq0oElZGhw5B0AMpOM
 RRS1gJzYP9neZhku9Jd3QGVcazmj3IT2XZnbhZBAdLO0HofyF6LK4CbhUOhCWibN
 iJk6XntSvuRKXaZFGrioa2eOdxywL8UxY/czjMjrR+zVw6JIbMWDlWWFMmcy3XxX
 sXnUwi2VbYSGEwr0xhPEA/yyTwiRY4kDetMytIH/57ZVKDS1K/QTOGpgWQWpE7Mu
 D2S02p2QKixBRSvPo3ZUZNOfNoTEIwmOZDeAFQHtyhbg6V854ED7HuI1VXTf+NUF
 pgaWMFiRNCnHBvcr3eI5tlEOg3+OWPne46VVLBDgRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=iVxU7A
 AJ5cGlvCJLWVtLKD/A+jxOMQaqMWyCXRBMJvk=; b=LOQHq7QuRNDqkcKc/w7Mdo
 iqvOu1bA3Z0xiPIsLQxa7zhRZK67MFKllnDB2PBMB9ApnwYHXJJNaRnd+iangkzJ
 ICTfDXS7XX1ryMQNYtaIv0J2SixpmbbxwE1MxARd82ieevt7BYaQaBq0qJKgxnWu
 25yk2NXsNqj44Jce48z5Ya9RcFhShIbSETWWMgctgAzzjcO1t5oBNNN7UFRdJx0v
 9QPBZEqIj0FYPvxPoMlrqJoezdJHUqGdM+ufl0079rIqvHKhu9rNFEFaojzF0SMj
 YHrfAyYwYJ19ogENF5AIqIbiqnx+QF8/SzLdxTcHgYxMhGVDK6Oey1FQFMcG7l+A
 ==
X-ME-Sender: <xms:QWXwYOhDzzejekZStX7Ji88UgmnTiqc8P6xGttS6akJsf08BlIp_HQ>
 <xme:QWXwYPB1GAzZ6BEjC2ZQ-inXFYofSqLe4VXZOvzTTWIwS3P5FZ59NSFz45Ehi_nC5
 uKV9CyiP7A7VyKlTvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtgdeilecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhvvghn
 ucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
 htvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudehvdef
 keffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
 hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:QWXwYGEvAPHJyTAgoq95OaPfAw8zM2nczrYmx1aMdxw9xeHAZWVHXQ>
 <xmx:QWXwYHS-9NeTq27yPtPGcGFvBv0-kedaSqmsvjlNP6r1ij7OtIt0WQ>
 <xmx:QWXwYLwThT2eYsYpdqstYLkNmyxaz6zNkhtXku6SMoK5VW4MGF8ttg>
 <xmx:Q2XwYAI3yo0dPjuN9aL424ZIoD4QIFj-VUxx_kVtRg4oLbdQNwDSgg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 113DC51C0026; Thu, 15 Jul 2021 12:41:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-533-gf73e617b8a-fm-20210712.002-gf73e617b
Mime-Version: 1.0
Message-Id: <30b00cf1-6366-4075-be8a-992fb1778306@www.fastmail.com>
In-Reply-To: <f3574c75-db2d-47fc-bda5-0f0f627fb524@arm.com>
References: <20210627143405.77298-1-sven@svenpeter.dev>
 <20210627143405.77298-4-sven@svenpeter.dev>
 <f3574c75-db2d-47fc-bda5-0f0f627fb524@arm.com>
Date: Thu, 15 Jul 2021 18:41:08 +0200
To: "Robin Murphy" <robin.murphy@arm.com>, "Will Deacon" <will@kernel.org>,
 "Joerg Roedel" <joro@8bytes.org>
Subject: Re: [PATCH v4 3/3] iommu: dart: Add DART iommu driver
Cc: Arnd Bergmann <arnd@kernel.org>,
 Rouven Czerwinski <r.czerwinski@pengutronix.de>, devicetree@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org,
 Petr Mladek via iommu <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, linux-arm-kernel@lists.infradead.org,
 Stan Skowronek <stan@corellium.com>
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

Hi,

Awesome, thanks a lot for the detailed review!


On Wed, Jul 14, 2021, at 01:23, Robin Murphy wrote:
> ^^ Nit: the subsystem style for the subject format should be 
> "iommu/dart: Add..." - similarly on patch #1, which I just realised I 
> missed (sorry!)

Sure!

> 
> On 2021-06-27 15:34, Sven Peter wrote:
> > Apple's new SoCs use iommus for almost all peripherals. These Device
> > Address Resolution Tables must be setup before these peripherals can
> > act as DMA masters.
> > 
> > Signed-off-by: Sven Peter <sven@svenpeter.dev>
> > ---
> >   MAINTAINERS                      |    1 +
> >   drivers/iommu/Kconfig            |   15 +
> >   drivers/iommu/Makefile           |    1 +
> >   drivers/iommu/apple-dart-iommu.c | 1058 ++++++++++++++++++++++++++++++
> 
> I'd be inclined to drop "-iommu" from the filename, unless there's some 
> other "apple-dart" functionality that might lead to a module name clash 
> in future?

Sure, DART should only be an iommu.

> 
> >   4 files changed, 1075 insertions(+)
> >   create mode 100644 drivers/iommu/apple-dart-iommu.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 29e5541c8f21..c1ffaa56b5f9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1245,6 +1245,7 @@ M:	Sven Peter <sven@svenpeter.dev>
> >   L:	iommu@lists.linux-foundation.org
> >   S:	Maintained
> >   F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
> > +F:	drivers/iommu/apple-dart-iommu.c
> >   
> >   APPLE SMC DRIVER
> >   M:	Henrik Rydberg <rydberg@bitmath.org>
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 1f111b399bca..87882c628b46 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -249,6 +249,21 @@ config SPAPR_TCE_IOMMU
> >   	  Enables bits of IOMMU API required by VFIO. The iommu_ops
> >   	  is not implemented as it is not necessary for VFIO.
> >   
> > +config IOMMU_APPLE_DART
> > +	tristate "Apple DART IOMMU Support"
> > +	depends on ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
> > +	select IOMMU_API
> > +	select IOMMU_IO_PGTABLE
> 
> This is redundant - the individual formats already select it.

Removed for the next version.

> 
[...]
> > +#include <linux/pci.h>
> 
> Redundant duplicate

Whoops, removed for the next version as well.

> 
> > +#define DART_MAX_STREAMS 16
[...]
> > +
> > +/*
> > + * This structure is used to identify a single stream attached to a domain.
> > + * It's used as a list inside that domain to be able to attach multiple
> > + * streams to a single domain. Since multiple devices can use a single stream
> > + * it additionally keeps track of how many devices are represented by this
> > + * stream. Once that number reaches zero it is detached from the IOMMU domain
> > + * and all translations from this stream are disabled.
> 
> That sounds a lot like something you should be doing properly with groups.

The hint to look at arm-smmu for a similar flow was very helpful, thanks!
Now that I understand how these groups works I completely agree that this
needs to be reworked and done properly.


> 
> > + * @dart: DART instance to which this stream belongs
> > + * @sid: stream id within the DART instance
> > + * @num_devices: count of devices attached to this stream
> > + * @stream_head: list head for the next stream
> > + */
> > +struct apple_dart_stream {
> > +	struct apple_dart *dart;
> > +	u32 sid;
> 
> What are the actual SID values like? If they're large and sparse then 
> maybe a list makes sense, but if they're small and dense then an array 
> hanging off the apple_dart structure itself might be more efficient. 
> Given DART_MAX_STREAMS, I'm thinking the latter, and considerably so.
> 
> The impression I'm getting so far is that this seems conceptually a bit 
> like arm-smmu with stream indexing.

There are two (very similar) types of DARTs.
The one supported with this series has up to 16 stream ids which will be
integers <16. There's another variant used for Thunderbolt for which I will
add support in a follow-up that supports up to 64 stream ids then. 
So at worst this is an array with 64 entries if this structure won't
disappear completely.

And yes, this is conceptually a bit like arm-smmu's stream indexing I think.


> 
> > +	u32 num_devices;
> > +
> > +	struct list_head stream_head;
> > +};
> > +
> > +/*
> > + * This structure is attached to each iommu domain handled by a DART.
> > + * A single domain is used to represent a single virtual address space.
> > + * It is always allocated together with a page table.
> > + *
> > + * Streams are the smallest units the DART hardware can differentiate.
> > + * These are pointed to the page table of a domain whenever a device is
> > + * attached to it. A single stream can only be assigned to a single domain.
> > + *
> > + * Devices are assigned to at least a single and sometimes multiple individual
> > + * streams (using the iommus property in the device tree). Multiple devices
> > + * can theoretically be represented by the same stream, though this is usually
> > + * not the case.
> > + *
> > + * We only keep track of streams here and just count how many devices are
> > + * represented by each stream. When the last device is removed the whole stream
> > + * is removed from the domain.
> > + *
> > + * @dart: pointer to the DART instance
> > + * @pgtbl_ops: pagetable ops allocated by io-pgtable
> > + * @type: domain type IOMMU_DOMAIN_IDENTITY_{IDENTITY,DMA,UNMANAGED,BLOCKED}
> > + * @sw_bypass_cpu_start: offset into cpu address space in software bypass mode
> > + * @sw_bypass_dma_start: offset into dma address space in software bypass mode
> > + * @sw_bypass_len: length of iova space in software bypass mode
> > + * @streams: list of streams attached to this domain
> > + * @lock: spinlock for operations involving the list of streams
> > + * @domain: core iommu domain pointer
> > + */
> > +struct apple_dart_domain {
> > +	struct apple_dart *dart;
> > +	struct io_pgtable_ops *pgtbl_ops;
> > +
> > +	unsigned int type;
> 
> Given that this is assigned from domain->type it appears to be redundant.

Yup, removed.

> 
> > +	u64 sw_bypass_cpu_start;
> > +	u64 sw_bypass_dma_start;
> > +	u64 sw_bypass_len;
> > +
> > +	struct list_head streams;
> 
> I'm staring to think this could just be a bitmap, in a u16 even.

The problem is that these streams may come from two different
DART instances. That is required for e.g. the dwc3 controller which
has a weird quirk where DMA transactions go through two separate
DARTs with no clear pattern (e.g. some xhci control structures use the
first dart while other structures use the second one).
Both of them need to point to the same pagetable.
In the device tree the node will have an entry like this:

dwc3_0: usb@382280000{
   ...
   iommus = <&dwc3_0_dart_0 0>, <&dwc3_0_dart_1 1>;
};

There's no need for a linked list though once I do this properly with
groups. I can just use an array allocated when the first device is
attached, which just contains apple_dart* and streamid values.


> 
> > +
> > +	spinlock_t lock;
> > +
> > +	struct iommu_domain domain;
> > +};
> > +
> > +/*
> > + * This structure is attached to devices with dev_iommu_priv_set() on of_xlate
> > + * and contains a list of streams bound to this device as defined in the
> > + * device tree. Multiple DART instances can be attached to a single device
> > + * and each stream is identified by its stream id.
> > + * It's usually reference by a pointer called *cfg.
> > + *
> > + * A dynamic array instead of a linked list is used here since in almost
> > + * all cases a device will just be attached to a single stream and streams
> > + * are never removed after they have been added.
> > + *
> > + * @num_streams: number of streams attached
> > + * @streams: array of structs to identify attached streams and the device link
> > + *           to the iommu
> > + */
> > +struct apple_dart_master_cfg {
> > +	int num_streams;
> > +	struct {
> > +		struct apple_dart *dart;
> > +		u32 sid;
> 
> Can't you use the fwspec for this?


I'd be happy to use the fwspec code if that's somehow possible.
I'm not sure how though since I need to store both the reference to the DART
_and_ to the stream id. As far as I can tell the fwspec code would only allow
to store the stream ids.
(see also the previous comment regarding the dwc3 node which requires stream
ids from two separate DART instances)

> 
> > +		struct device_link *link;
> 
> Is it necessary to use stateless links, or could you use 
> DL_FLAG_AUTOREMOVE_SUPPLIER and not have to keep track of them manually?

I'll just use DL_FLAG_AUTOREMOVE_SUPPLIER. No idea why I went for stateless links.

>
[...]
> > +	/* restore stream identity map */
> > +	writel(0x03020100, dart->regs + DART_STREAM_REMAP);
> > +	writel(0x07060504, dart->regs + DART_STREAM_REMAP + 4);
> > +	writel(0x0b0a0908, dart->regs + DART_STREAM_REMAP + 8);
> > +	writel(0x0f0e0d0c, dart->regs + DART_STREAM_REMAP + 12);
> 
> Any hint of what the magic numbers mean?

Yes, it's just 0,1,2,3...,0xe,0xf but I can't do 8bit writes to the bus
and 32 bit writes then require these slightly awkward "swapped" numbers.
I'll add a comment since it's not obvious at first glance.

> 
> > +	/* clear any pending errors before the interrupt is unmasked */
> > +	writel(readl(dart->regs + DART_ERROR), dart->regs + DART_ERROR);
> > +
> > +	return apple_dart_hw_invalidate_tlb_global(dart);
> > +}
> > +
> > +static void apple_dart_domain_flush_tlb(struct apple_dart_domain *domain)
> > +{
> > +	unsigned long flags;
> > +	struct apple_dart_stream *stream;
> > +	struct apple_dart *dart = domain->dart;
> > +
> > +	if (!dart)
> > +		return;
> 
> Can that happen? Feels like it's probably a bug elsewhere if it could :/

No, this can't happen. I'll remove it.

> 
> > +	spin_lock_irqsave(&domain->lock, flags);
> > +	list_for_each_entry(stream, &domain->streams, stream_head) {
> > +		apple_dart_hw_invalidate_tlb_stream(stream->dart, stream->sid);
> > +	}
> > +	spin_unlock_irqrestore(&domain->lock, flags);
> > +}
> > +
> > +static void apple_dart_flush_iotlb_all(struct iommu_domain *domain)
> > +{
> > +	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
> > +
> > +	apple_dart_domain_flush_tlb(dart_domain);
> > +}
> > +
> > +static void apple_dart_iotlb_sync(struct iommu_domain *domain,
> > +				  struct iommu_iotlb_gather *gather)
> > +{
> > +	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
> > +
> > +	apple_dart_domain_flush_tlb(dart_domain);
> > +}
> > +
> > +static void apple_dart_iotlb_sync_map(struct iommu_domain *domain,
> > +				      unsigned long iova, size_t size)
> > +{
> > +	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
> > +
> > +	apple_dart_domain_flush_tlb(dart_domain);
> > +}
> > +
> > +static void apple_dart_tlb_flush_all(void *cookie)
> > +{
> > +	struct apple_dart_domain *domain = cookie;
> > +
> > +	apple_dart_domain_flush_tlb(domain);
> > +}
> > +
> > +static void apple_dart_tlb_flush_walk(unsigned long iova, size_t size,
> > +				      size_t granule, void *cookie)
> > +{
> > +	struct apple_dart_domain *domain = cookie;
> > +
> > +	apple_dart_domain_flush_tlb(domain);
> > +}
> > +
> > +static const struct iommu_flush_ops apple_dart_tlb_ops = {
> > +	.tlb_flush_all = apple_dart_tlb_flush_all,
> > +	.tlb_flush_walk = apple_dart_tlb_flush_walk,
> > +	.tlb_add_page = NULL,
> > +};
> > +
> > +static phys_addr_t apple_dart_iova_to_phys(struct iommu_domain *domain,
> > +					   dma_addr_t iova)
> > +{
> > +	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
> > +	struct io_pgtable_ops *ops = dart_domain->pgtbl_ops;
> > +
> > +	if (domain->type == IOMMU_DOMAIN_IDENTITY &&
> > +	    dart_domain->dart->supports_bypass)
> 
> That second check seems redundant - if you don't support bypass surely 
> you shouldn't have allowed attaching an identity domain in the first 
> place? And even if you fake one with a pagetable you shouldn't need to 
> walk it, for obvious reasons ;)

True, and with the patch you sent I don't need this here either way.

> 
> TBH, dealing with identity domains in iova_to_phys at all irks me - it's 
> largely due to dubious hacks in networking drivers which hopefully you 
> should never have to deal with on M1 anyway, and either way it's not 
> like they can't check the domain type themselves and save a pointless 
> indirect call altogether :(
> 
> > +		return iova;
> > +	if (!ops)
> > +		return -ENODEV;
> > +
> > +	return ops->iova_to_phys(ops, iova);
> > +}
> > +
> > +static int apple_dart_map(struct iommu_domain *domain, unsigned long iova,
> > +			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> > +{
> > +	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
> > +	struct io_pgtable_ops *ops = dart_domain->pgtbl_ops;
> > +
> > +	if (!ops)
> > +		return -ENODEV;
> > +	if (prot & IOMMU_MMIO)
> > +		return -EINVAL;
> > +	if (prot & IOMMU_NOEXEC)
> > +		return -EINVAL;
> 
> Hmm, I guess the usual expectation is just to ignore any prot flags you 
> can't enforce - after all, some IOMMUs don't even have a notion of read 
> or write permissions.

Sure, I'll just remove those checks.

> 
> > +	return ops->map(ops, iova, paddr, size, prot, gfp);
> > +}
> > +
> > +static size_t apple_dart_unmap(struct iommu_domain *domain, unsigned long iova,
> > +			       size_t size, struct iommu_iotlb_gather *gather)
> > +{
> > +	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
> > +	struct io_pgtable_ops *ops = dart_domain->pgtbl_ops;
> > +
> > +	if (!ops)
> > +		return 0;
> 
> That should never legitimately happen, since no previous mapping could 
> have succeeded either.

Ack, removed.

> 
> > +	return ops->unmap(ops, iova, size, gather);
> > +}
> > +
> > +static int apple_dart_prepare_sw_bypass(struct apple_dart *dart,
> > +					struct apple_dart_domain *dart_domain,
> > +					struct device *dev)
> > +{
> > +	lockdep_assert_held(&dart_domain->lock);
> > +
> > +	if (dart->supports_bypass)
> > +		return 0;
> > +	if (dart_domain->type != IOMMU_DOMAIN_IDENTITY)
> > +		return 0;
> > +
> > +	// use the bus region from the first attached dev for the bypass range
> > +	if (!dart->sw_bypass_len) {
> > +		const struct bus_dma_region *dma_rgn = dev->dma_range_map;
> > +
> > +		if (!dma_rgn)
> > +			return -EINVAL;
> > +
> > +		dart->sw_bypass_len = dma_rgn->size;
> > +		dart->sw_bypass_cpu_start = dma_rgn->cpu_start;
> > +		dart->sw_bypass_dma_start = dma_rgn->dma_start;
> > +	}
> > +
> > +	// ensure that we don't mix different bypass setups
> > +	if (dart_domain->sw_bypass_len) {
> > +		if (dart->sw_bypass_len != dart_domain->sw_bypass_len)
> > +			return -EINVAL;
> > +		if (dart->sw_bypass_cpu_start !=
> > +		    dart_domain->sw_bypass_cpu_start)
> > +			return -EINVAL;
> > +		if (dart->sw_bypass_dma_start !=
> > +		    dart_domain->sw_bypass_dma_start)
> > +			return -EINVAL;
> > +	} else {
> > +		dart_domain->sw_bypass_len = dart->sw_bypass_len;
> > +		dart_domain->sw_bypass_cpu_start = dart->sw_bypass_cpu_start;
> > +		dart_domain->sw_bypass_dma_start = dart->sw_bypass_dma_start;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int apple_dart_domain_needs_pgtbl_ops(struct apple_dart *dart,
> > +					     struct iommu_domain *domain)
> > +{
> > +	if (domain->type == IOMMU_DOMAIN_DMA)
> > +		return 1;
> > +	if (domain->type == IOMMU_DOMAIN_UNMANAGED)
> > +		return 1;
> > +	if (!dart->supports_bypass && domain->type == IOMMU_DOMAIN_IDENTITY)
> > +		return 1;
> > +	return 0;
> > +}
> > +
> > +static int apple_dart_finalize_domain(struct iommu_domain *domain)
> > +{
> > +	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
> > +	struct apple_dart *dart = dart_domain->dart;
> > +	struct io_pgtable_cfg pgtbl_cfg;
> > +
> > +	lockdep_assert_held(&dart_domain->lock);
> > +
> > +	if (dart_domain->pgtbl_ops)
> > +		return 0;
> > +	if (!apple_dart_domain_needs_pgtbl_ops(dart, domain))
> > +		return 0;
> > +
> > +	pgtbl_cfg = (struct io_pgtable_cfg){
> > +		.pgsize_bitmap = dart->pgsize,
> > +		.ias = 32,
> > +		.oas = 36,
> > +		.coherent_walk = 1,
> > +		.tlb = &apple_dart_tlb_ops,
> > +		.iommu_dev = dart->dev,
> > +	};
> > +
> > +	dart_domain->pgtbl_ops =
> > +		alloc_io_pgtable_ops(ARM_APPLE_DART, &pgtbl_cfg, domain);
> > +	if (!dart_domain->pgtbl_ops)
> > +		return -ENOMEM;
> > +
> > +	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
> > +	domain->geometry.aperture_start = 0;
> > +	domain->geometry.aperture_end = DMA_BIT_MASK(32);
> > +	domain->geometry.force_aperture = true;
> > +
> > +	/*
> > +	 * Some DARTs come without hardware bypass support but we may still
> > +	 * be forced to use bypass mode (to e.g. allow kernels with 4K pages to
> > +	 * boot). If we reach this point with an identity domain we have to setup
> > +	 * bypass mode in software. This is done by creating a static pagetable
> > +	 * for a linear map specified by dma-ranges in the device tree.
> > +	 */
> > +	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> > +		u64 offset;
> > +		int ret;
> > +
> > +		for (offset = 0; offset < dart_domain->sw_bypass_len;
> > +		     offset += dart->pgsize) {
> > +			ret = dart_domain->pgtbl_ops->map(
> > +				dart_domain->pgtbl_ops,
> > +				dart_domain->sw_bypass_dma_start + offset,
> > +				dart_domain->sw_bypass_cpu_start + offset,
> > +				dart->pgsize, IOMMU_READ | IOMMU_WRITE,
> > +				GFP_ATOMIC);
> > +			if (ret < 0) {
> > +				free_io_pgtable_ops(dart_domain->pgtbl_ops);
> > +				dart_domain->pgtbl_ops = NULL;
> > +				return -EINVAL;
> > +			}
> > +		}
> 
> Could you set up a single per-DART pagetable in prepare_sw_bypass (or 
> even better at probe time if you think you're likely to need it) and 
> just share that between all fake identity domains? That could be a 
> follow-up optimisation, though.

I'll see if that's possible. So essentially I want to setup an identity
mapping with respect to bus_dma_region from the first attached device.
Right now this is always mapping the entire 4G VA space to RAM
starting at 0x8_0000_0000. 
See also my reply to another comment further down since software
bypass mode might have to disappear anyway.

> 
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void
> > +apple_dart_stream_setup_translation(struct apple_dart_domain *domain,
> > +				    struct apple_dart *dart, u32 sid)
> > +{
> > +	int i;
> > +	struct io_pgtable_cfg *pgtbl_cfg =
> > +		&io_pgtable_ops_to_pgtable(domain->pgtbl_ops)->cfg;
> > +
> > +	for (i = 0; i < pgtbl_cfg->apple_dart_cfg.n_ttbrs; ++i)
> > +		apple_dart_hw_set_ttbr(dart, sid, i,
> > +				       pgtbl_cfg->apple_dart_cfg.ttbr[i]);
> > +	for (; i < DART_MAX_TTBR; ++i)
> > +		apple_dart_hw_clear_ttbr(dart, sid, i);
> > +
> > +	apple_dart_hw_enable_translation(dart, sid);
> > +	apple_dart_hw_invalidate_tlb_stream(dart, sid);
> > +}
> > +
> > +static int apple_dart_attach_stream(struct apple_dart_domain *domain,
> > +				    struct apple_dart *dart, u32 sid)
> > +{
> > +	unsigned long flags;
> > +	struct apple_dart_stream *stream;
> > +	int ret;
> > +
> > +	lockdep_assert_held(&domain->lock);
> > +
> > +	if (WARN_ON(dart->force_bypass &&
> > +		    domain->type != IOMMU_DOMAIN_IDENTITY))
> > +		return -EINVAL;
> 
> Ideally you shouldn't allow that to happen, but I guess if you have 
> mixed capabilities afross different instances then in principle an 
> unmanaged domain could still slip through. But then again a user of an 
> unmanaged domain might be OK with using larger pages anyway. Either way 
> I'm not sure it's worthy of a WARN (similarly below) since it doesn't 
> represent a "this should never happen" condition if the user has got 
> their hands on a VFIO driver and is mucking about, it's just a normal 
> failure because you can't support the attachment.

Makes sense, will remove that WARN (and other below as well).

> 
> > +	/*
> > +	 * we can't mix and match DARTs that support bypass mode with those who don't
> > +	 * because the iova space in fake bypass mode generally has an offset
> > +	 */
> 
> Erm, something doesn't sound right there... IOMMU_DOMAIN_IDENTITY should 
> be exactly what it says, regardless of how it's implemented. If you 
> can't provide a true identity mapping then you're probably better off 
> not pretending to support them in the first place.

Some background: the PCIe DART only supports a 32bit VA space but RAM
on these machines starts at 0x8_0000_0000. I have something like 
  dma-ranges = <0x42000000 0 0 0x8 0 0 0xffff0000>;
in the pcie nodes to add that offset to dma addresses.

What I want to do here then is to setup an identity mapping with respect
to the DMA layer understanding of addresses encoded in bus_dma_region.
Now this will always just be a constant offset of 0x8_0000_0000 for
all M1s but I didn't want to hardcode that.
The code here is just there to guard against a situation where someone
somehow manages to attach two devices with different offsets to the same
domain.

If that's not how the abstraction is supposed to work and/or too big of a hack
I'll just remove the software bypass mode altogether.
PCIe won't work on 4k kernels then but the only people using this so far 
build their own kernels with patches either way and won't complain.
And by the time Linux will actually be useful for "normal" setups
the dma-iommu layer can hopefully just handle a larger page granularity.



> 
> > +	if (WARN_ON(domain->type == IOMMU_DOMAIN_IDENTITY &&
> > +		    (domain->dart->supports_bypass != dart->supports_bypass)))
> > +		return -EINVAL;
> > +
> > +	list_for_each_entry(stream, &domain->streams, stream_head) {
> > +		if (stream->dart == dart && stream->sid == sid) {
> > +			stream->num_devices++;
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	spin_lock_irqsave(&dart->lock, flags);
> > +
> > +	if (WARN_ON(dart->used_sids & BIT(sid))) {
> > +		ret = -EINVAL;
> > +		goto error;
> > +	}
> > +
> > +	stream = kzalloc(sizeof(*stream), GFP_ATOMIC);
> > +	if (!stream) {
> > +		ret = -ENOMEM;
> > +		goto error;
> > +	}
> 
> Couldn't you do this outside the lock? (If, calling back to other 
> comments, it can't get refactored out of existence anyway)

Probably, but I'll first see if I can just refactor it away.

> 
> > +	stream->dart = dart;
> > +	stream->sid = sid;
> > +	stream->num_devices = 1;
> > +	list_add(&stream->stream_head, &domain->streams);
> > +
> > +	dart->used_sids |= BIT(sid);
> > +	spin_unlock_irqrestore(&dart->lock, flags);
> > +
> > +	apple_dart_hw_clear_all_ttbrs(stream->dart, stream->sid);
> > +
> > +	switch (domain->type) {
> > +	case IOMMU_DOMAIN_IDENTITY:
> > +		if (stream->dart->supports_bypass)
> > +			apple_dart_hw_enable_bypass(stream->dart, stream->sid);
> > +		else
> > +			apple_dart_stream_setup_translation(
> > +				domain, stream->dart, stream->sid);
> > +		break;
> > +	case IOMMU_DOMAIN_BLOCKED:
> > +		apple_dart_hw_disable_dma(stream->dart, stream->sid);
> > +		break;
> > +	case IOMMU_DOMAIN_UNMANAGED:
> > +	case IOMMU_DOMAIN_DMA:
> > +		apple_dart_stream_setup_translation(domain, stream->dart,
> > +						    stream->sid);
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +
> > +error:
> > +	spin_unlock_irqrestore(&dart->lock, flags);
> > +	return ret;
> > +}
> > +
> > +static void apple_dart_disable_stream(struct apple_dart *dart, u32 sid)
> > +{
> > +	unsigned long flags;
> > +
> > +	apple_dart_hw_disable_dma(dart, sid);
> > +	apple_dart_hw_clear_all_ttbrs(dart, sid);
> > +	apple_dart_hw_invalidate_tlb_stream(dart, sid);
> > +
> > +	spin_lock_irqsave(&dart->lock, flags);
> > +	dart->used_sids &= ~BIT(sid);
> > +	spin_unlock_irqrestore(&dart->lock, flags);
> > +}
> > +
> > +static void apple_dart_detach_stream(struct apple_dart_domain *domain,
> > +				     struct apple_dart *dart, u32 sid)
> > +{
> > +	struct apple_dart_stream *stream;
> > +
> > +	lockdep_assert_held(&domain->lock);
> > +
> > +	list_for_each_entry(stream, &domain->streams, stream_head) {
> > +		if (stream->dart == dart && stream->sid == sid) {
> > +			stream->num_devices--;
> > +
> > +			if (stream->num_devices == 0) {
> > +				apple_dart_disable_stream(dart, sid);
> > +				list_del(&stream->stream_head);
> > +				kfree(stream);
> > +			}
> > +			return;
> > +		}
> > +	}
> > +}
> > +
> > +static int apple_dart_attach_dev(struct iommu_domain *domain,
> > +				 struct device *dev)
> > +{
> > +	int ret;
> > +	int i, j;
> > +	unsigned long flags;
> > +	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
> > +	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
> > +	struct apple_dart *dart = cfg->streams[0].dart;
> > +
> > +	if (WARN_ON(dart->force_bypass &&
> > +		    dart_domain->type != IOMMU_DOMAIN_IDENTITY)) {
> > +		dev_warn(
> > +			dev,
> > +			"IOMMU must be in bypass mode but trying to attach to translated domain.\n");
> > +		return -EINVAL;
> > +	}
> 
> Again, a bit excessive with the warnings. In fact, transpose my comment 
> from apple_dart_attach_stream() to here, because this means the 
> equivalent warning there is literally unreachable :/

Okay, I'll go through the code paths again, get rid of these warnings and
make sure I don't check the same thing more than once.

> 
[...]
> > +
> > +static void apple_dart_release_device(struct device *dev)
> > +{
> > +	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
> > +	int i;
> > +
> > +	if (!cfg)
> > +		return;
> 
> Shouldn't happen - if it's disappeared since probe_device succeeded 
> you've got bigger problems anyway.

Ok, will remove it.

> 
> > +
> > +	for (i = 0; i < cfg->num_streams; ++i)
> > +		device_link_del(cfg->streams[i].link);
> > +
> > +	dev_iommu_priv_set(dev, NULL);
> > +	kfree(cfg);
> > +}
> > +
> > +static struct iommu_domain *apple_dart_domain_alloc(unsigned int type)
> > +{
> > +	struct apple_dart_domain *dart_domain;
> > +
> > +	if (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_UNMANAGED &&
> > +	    type != IOMMU_DOMAIN_IDENTITY && type != IOMMU_DOMAIN_BLOCKED)
> > +		return NULL;
> 
> I want to say there's not much point in that, but then I realise I've 
> spent the last couple of days writing patches to add a new domain type :)

Hah! Just because I'm curious: What is that new domain type going to be? :)

> 
> > +	dart_domain = kzalloc(sizeof(*dart_domain), GFP_KERNEL);
> > +	if (!dart_domain)
> > +		return NULL;
> > +
> > +	INIT_LIST_HEAD(&dart_domain->streams);
> > +	spin_lock_init(&dart_domain->lock);
> > +	iommu_get_dma_cookie(&dart_domain->domain);
> > +	dart_domain->type = type;
> 
> Yeah, this is "useful" for a handful of CPU cycles until we return and 
> iommu_domain_alloc() sets dart_domain->domain->type to the same thing, 
> all before *its* caller even knows the domain exists.

True, will remove it.

> 
> > +	return &dart_domain->domain;
> > +}
> > +
> > +static void apple_dart_domain_free(struct iommu_domain *domain)
> > +{
> > +	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
> > +
> > +	WARN_ON(!list_empty(&dart_domain->streams));
> 
> Why? This code is perfectly legal API usage:
> 
> 	d = iommu_domain_alloc(bus)
> 	if (d)
> 		iommu_domain_free(d);
> 
> Sure it looks pointless, but it's the kind of thing that can 
> legitimately happen (with a lot more going on in between) if an 
> unmanaged domain user tears itself down before it gets round to 
> attaching, due to probe deferral or some other error condition.

Ah, makes sense. I'll remove the warning!

> 
> > +	kfree(dart_domain);
> > +}
> > +
> > +static int apple_dart_of_xlate(struct device *dev, struct of_phandle_args *args)
> > +{
> > +	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
> > +	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
> > +	unsigned int num_streams = cfg ? cfg->num_streams : 0;
> > +	struct apple_dart_master_cfg *cfg_new;
> > +	struct apple_dart *dart = platform_get_drvdata(iommu_pdev);
> > +
> > +	if (args->args_count != 1)
> > +		return -EINVAL;
> > +
> > +	cfg_new = krealloc(cfg, struct_size(cfg, streams, num_streams + 1),
> > +			   GFP_KERNEL);
> > +	if (!cfg_new)
> > +		return -ENOMEM;
> > +
> > +	cfg = cfg_new;
> > +	dev_iommu_priv_set(dev, cfg);
> > +
> > +	cfg->num_streams = num_streams;
> > +	cfg->streams[cfg->num_streams].dart = dart;
> > +	cfg->streams[cfg->num_streams].sid = args->args[0];
> > +	cfg->num_streams++;
> 
> Yeah, this is way too reminiscent of the fwspec code for comfort. Even 
> if you can't use autoremove links for some reason, an array of 16 
> device_link pointers hung off apple_dart still wins over these little 
> pointer-heavy structures if you need more than a few of them.

I can get rid of the links, but I'll still need some way to store
both the apple_dart and the sid here. Like mentioned above, I'll
be happy to reuse the fwspec code but I don't see how yet.

> 
> > +	return 0;
> > +}
> > +
> > +static struct iommu_group *apple_dart_device_group(struct device *dev)
> > +{
> > +#ifdef CONFIG_PCI
> > +	struct iommu_group *group;
> > +
> > +	if (dev_is_pci(dev))
> > +		group = pci_device_group(dev);
> > +	else
> > +		group = generic_device_group(dev);
> 
> ...and this is where it gets bad :(
> 
> If you can have multiple devices behind the same stream such that the 
> IOMMU can't tell them apart, you *have* to ensure they get put in the 
> same group, so that the IOMMU core knows the topology (and reflects it 
> correctly to userspace) and doesn't try to do things that then 
> unexpectedly fail. This is the point where you need to check if a stream 
> is already known, and return the existing group if so, and then you 
> won't need to check and refcount all the time in attach/detach because 
> the IOMMU core will do the right thing for you.
> 
> Many drivers only run on systems where devices don't alias at the IOMMU 
> level (aliasing at the PCI level is already taken care of), or use a 
> single group because effectively everything aliases, so it's not the 
> most common scenario, but as I mentioned before arm-smmu is one that 
> does - take a look at the flow though that in the "!smmu->smrs" cases 
> for the closest example.

Okay, this is very good to know. Thanks again for the pointer to the
arm-smmu code, it really helped me understand how iommu_groups are
supposed to work. I'll do this the proper way for v5, which should also
simplify this driver :-)


> 
> > +
> > +	return group;
> > +#else
> > +	return generic_device_group(dev);
> > +#endif
> > +}
> > +
> > +static int apple_dart_def_domain_type(struct device *dev)
> > +{
> > +	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
> > +	struct apple_dart *dart = cfg->streams[0].dart;
> > +
> > +	if (dart->force_bypass)
> > +		return IOMMU_DOMAIN_IDENTITY;
> > +	if (!dart->supports_bypass)
> > +		return IOMMU_DOMAIN_DMA;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct iommu_ops apple_dart_iommu_ops = {
> > +	.domain_alloc = apple_dart_domain_alloc,
> > +	.domain_free = apple_dart_domain_free,
> > +	.attach_dev = apple_dart_attach_dev,
> > +	.detach_dev = apple_dart_detach_dev,
> > +	.map = apple_dart_map,
> > +	.unmap = apple_dart_unmap,
> > +	.flush_iotlb_all = apple_dart_flush_iotlb_all,
> > +	.iotlb_sync = apple_dart_iotlb_sync,
> > +	.iotlb_sync_map = apple_dart_iotlb_sync_map,
> > +	.iova_to_phys = apple_dart_iova_to_phys,
> > +	.probe_device = apple_dart_probe_device,
> > +	.release_device = apple_dart_release_device,
> > +	.device_group = apple_dart_device_group,
> > +	.of_xlate = apple_dart_of_xlate,
> > +	.def_domain_type = apple_dart_def_domain_type,
> > +	.pgsize_bitmap = -1UL, /* Restricted during dart probe */
> > +};
> > +
> > +static irqreturn_t apple_dart_irq(int irq, void *dev)
> > +{
> > +	struct apple_dart *dart = dev;
> > +	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> > +				      DEFAULT_RATELIMIT_BURST);
> > +	const char *fault_name = NULL;
> > +	u32 error = readl(dart->regs + DART_ERROR);
> > +	u32 error_code = FIELD_GET(DART_ERROR_CODE, error);
> > +	u32 addr_lo = readl(dart->regs + DART_ERROR_ADDR_LO);
> > +	u32 addr_hi = readl(dart->regs + DART_ERROR_ADDR_HI);
> > +	u64 addr = addr_lo | (((u64)addr_hi) << 32);
> > +	u8 stream_idx = FIELD_GET(DART_ERROR_STREAM, error);
> > +
> > +	if (!(error & DART_ERROR_FLAG))
> > +		return IRQ_NONE;
> > +
> > +	if (error_code & DART_ERROR_READ_FAULT)
> > +		fault_name = "READ FAULT";
> > +	else if (error_code & DART_ERROR_WRITE_FAULT)
> > +		fault_name = "WRITE FAULT";
> > +	else if (error_code & DART_ERROR_NO_PTE)
> > +		fault_name = "NO PTE FOR IOVA";
> > +	else if (error_code & DART_ERROR_NO_PMD)
> > +		fault_name = "NO PMD FOR IOVA";
> > +	else if (error_code & DART_ERROR_NO_TTBR)
> > +		fault_name = "NO TTBR FOR IOVA";
> 
> Can multiple bits be set at once or is there a strict precedence?

I'll double check and either add a comment that there's a precedence or
print names for all bits that are set.

> 
> > +	if (WARN_ON(fault_name == NULL))
> 
> You're already logging a clear and attributable message below; I can 
> guarantee that a big noisy backtrace showing that you got here from 
> el0_irq() or el1_irq() is not useful over and above that.
> 
> > +		fault_name = "unknown";
> > +
> > +	if (__ratelimit(&rs)) {
> 
> Just use dev_err_ratelimited() to hide the guts if you're not doing 
> anything tricky.

Ack.

> 
> > +		dev_err(dart->dev,
> > +			"translation fault: status:0x%x stream:%d code:0x%x (%s) at 0x%llx",
> > +			error, stream_idx, error_code, fault_name, addr);
> > +	}
> > +
> > +	writel(error, dart->regs + DART_ERROR);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int apple_dart_probe(struct platform_device *pdev)
> > +{
> > +	int ret;
> > +	u32 dart_params[2];
> > +	struct resource *res;
> > +	struct apple_dart *dart;
> > +	struct device *dev = &pdev->dev;
> > +
> > +	dart = devm_kzalloc(dev, sizeof(*dart), GFP_KERNEL);
> > +	if (!dart)
> > +		return -ENOMEM;
> > +
> > +	dart->dev = dev;
> > +	spin_lock_init(&dart->lock);
> > +
> > +	if (pdev->num_resources < 1)
> > +		return -ENODEV;
> 
> But you have 2 resources (one MEM and one IRQ)? And anyway their 
> respective absences would hardly go unnoticed below.

Probably a leftover from when I just had the MEM resource.
I'll just remove the check here.

> 
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (resource_size(res) < 0x4000) {
> > +		dev_err(dev, "MMIO region too small (%pr)\n", res);
> > +		return -EINVAL;
> > +	}
> > +
> > +	dart->regs = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(dart->regs))
> > +		return PTR_ERR(dart->regs);
> > +
> > +	ret = devm_clk_bulk_get_all(dev, &dart->clks);
> > +	if (ret < 0)
> > +		return ret;
> > +	dart->num_clks = ret;
> > +
> > +	ret = clk_bulk_prepare_enable(dart->num_clks, dart->clks);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = apple_dart_hw_reset(dart);
> > +	if (ret)
> > +		goto err_clk_disable;
> > +
> > +	dart_params[0] = readl(dart->regs + DART_PARAMS1);
> > +	dart_params[1] = readl(dart->regs + DART_PARAMS2);
> > +	dart->pgsize = 1 << FIELD_GET(DART_PARAMS_PAGE_SHIFT, dart_params[0]);
> > +	dart->supports_bypass = dart_params[1] & DART_PARAMS_BYPASS_SUPPORT;
> > +	dart->force_bypass = dart->pgsize > PAGE_SIZE;
> > +
> > +	dart->irq = platform_get_irq(pdev, 0);
> > +	if (dart->irq < 0) {
> > +		ret = -ENODEV;
> > +		goto err_clk_disable;
> > +	}
> 
> FWIW I'd get the IRQ earlier when there's still nothing to clean up on 
> failure - it's only the request which needs to wait until you've 
> actually set up enough to be able to handle it if it does fire.

Good point, will move it further above.

> 
> > +	ret = devm_request_irq(dart->dev, dart->irq, apple_dart_irq,
> > +			       IRQF_SHARED, "apple-dart fault handler", dart);
> 
> Be verfy careful with this pattern of mixing devrers-managed IRQs with 
> explicitly-managed clocks, especially when IRQF_SHARED is in play. In 
> the failure path here, and in remove, you have a period where the clocks 
> have been disabled but the IRQ is still live - try CONFIG_DEBUG_SHIRQ 
> and don't be surprised if you deadlock trying to read an unclocked register.

Good catch, I didn't even think about that situation.
"Luckily" the clocks are usually shared with the master device(s) attached to
the iommu, so they are already on long before apple_dart_probe is called.

> 
> If you can't also offload the clock management to devres to guarantee 
> ordering relative to the IRQ (I think I saw some patches recently), it's 
> probably safest to manually manage the latter.

Okay, will take a look and see if I can offload it and otherwise manage it
manually then.

> 
> > +	if (ret)
> > +		goto err_clk_disable;
> > +
> > +	platform_set_drvdata(pdev, dart);
> > +
> > +	ret = iommu_device_sysfs_add(&dart->iommu, dev, NULL, "apple-dart.%s",
> > +				     dev_name(&pdev->dev));
> > +	if (ret)
> > +		goto err_clk_disable;
> > +
> > +	ret = iommu_device_register(&dart->iommu, &apple_dart_iommu_ops, dev);
> > +	if (ret)
> > +		goto err_clk_disable;
> > +
> > +	if (dev->bus->iommu_ops != &apple_dart_iommu_ops) {
> > +		ret = bus_set_iommu(dev->bus, &apple_dart_iommu_ops);
> > +		if (ret)
> > +			goto err_clk_disable;
> > +	}
> > +#ifdef CONFIG_PCI
> > +	if (dev->bus->iommu_ops != pci_bus_type.iommu_ops) {
> 
> But it's still a platform device, not a PCI device?

Er, yes, I will fix this code here by doing something similar to what
arm-smmu does:

        if (!iommu_present(&platform_bus_type)) {
                ret = bus_set_iommu(&platform_bus_type, &apple_dart_iommu_ops);
                if (ret)
                        goto err_clk_disable;
        }
#ifdef CONFIG_PCI
        if (!iommu_present(&pci_bus_type)) {
                ret = bus_set_iommu(&pci_bus_type, &apple_dart_iommu_ops);
                if (ret)
                        goto err_reset_platform_ops;
        }
#endif


> 
> > +		ret = bus_set_iommu(&pci_bus_type, &apple_dart_iommu_ops);
> > +		if (ret)
> > +			goto err_clk_disable;
> 
> And the platform bus ops?

ugh, good catch. will clean them up as well.

> 
> > +	}
> > +#endif
> > +
> > +	dev_info(
> > +		&pdev->dev,
> > +		"DART [pagesize %x, bypass support: %d, bypass forced: %d] initialized\n",
> > +		dart->pgsize, dart->supports_bypass, dart->force_bypass);
> > +	return 0;
> > +
> > +err_clk_disable:
> > +	clk_bulk_disable(dart->num_clks, dart->clks);
> > +	clk_bulk_unprepare(dart->num_clks, dart->clks);
> 
> No need to open-code clk_bulk_disable_unprepare() ;)

True :-)

> 
> > +	return ret;
> > +}
> > +
> > +static int apple_dart_remove(struct platform_device *pdev)
> > +{
> > +	struct apple_dart *dart = platform_get_drvdata(pdev);
> > +
> > +	devm_free_irq(dart->dev, dart->irq, dart);
> > +
> > +	iommu_device_unregister(&dart->iommu);
> > +	iommu_device_sysfs_remove(&dart->iommu);
> > +
> > +	clk_bulk_disable(dart->num_clks, dart->clks);
> > +	clk_bulk_unprepare(dart->num_clks, dart->clks);
> 
> Ditto.
> 
> And again the bus ops are still installed - that'll get really fun if 
> this is a module unload...

Ugh, yeah. I'll fix that as well. I'll have to see how to make this work
correctly with multiple DART instances. I guess I should only remove the
bus ops once the last one is removed. Now that I think about it, this
could also get tricky in the cleanup paths of apple_dart_probe.

Maybe just add a module_init that sets up the bus ops when it finds at
least one DART node and module_exit to tear them down again?

> 
> > +	return 0;
> > +}
> > +
> > +static void apple_dart_shutdown(struct platform_device *pdev)
> > +{
> > +	apple_dart_remove(pdev);
> 
> The main reason for doing somthing on shutdown is in the case of kexec, 
> to put the hardware back into a disable or otherwise sane state so as 
> not to trip up whatever the subsequent payload is. If you're not doing 
> that (which may be legitimate if the expectation is that software must 
> always fully reset and initialise a DART before I/O can work) then 
> there's not much point in doing anything, really. Stuff like tidying up 
> sysfs is a complete waste of time when the world's about to end ;)

Makes sense, I'll see if I can put the DARTs back into a sane state
for whatever the next payload is here then.

> 
> Robin.
> 
> > +}
> > +
> > +static const struct of_device_id apple_dart_of_match[] = {
> > +	{ .compatible = "apple,t8103-dart", .data = NULL },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, apple_dart_of_match);
> > +
> > +static struct platform_driver apple_dart_driver = {
> > +	.driver	= {
> > +		.name			= "apple-dart",
> > +		.of_match_table		= apple_dart_of_match,
> > +	},
> > +	.probe	= apple_dart_probe,
> > +	.remove	= apple_dart_remove,
> > +	.shutdown = apple_dart_shutdown,
> > +};
> > +module_platform_driver(apple_dart_driver);
> > +
> > +MODULE_DESCRIPTION("IOMMU API for Apple's DART");
> > +MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
> > +MODULE_LICENSE("GPL v2");
> > 
> 

Sven

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
