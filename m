Return-Path: <SRS0=vtxH=ET=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF87C388F7
	for <iommu@archiver.kernel.org>; Fri, 13 Nov 2020 11:29:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44A92137B
	for <iommu@archiver.kernel.org>; Fri, 13 Nov 2020 11:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44A92137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5E6B1874B3;
	Fri, 13 Nov 2020 11:29:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a4WG6igVFqIV; Fri, 13 Nov 2020 11:29:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 54BA087469;
	Fri, 13 Nov 2020 11:29:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28385C0891;
	Fri, 13 Nov 2020 11:29:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DBDFC0800
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 11:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6741E878DA
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 11:29:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uqWShZ5YPVy7 for <iommu@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 11:29:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 65258878D9
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 11:29:08 +0000 (UTC)
Received: from gaia (unknown [2.26.170.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 45804207DE;
 Fri, 13 Nov 2020 11:29:05 +0000 (UTC)
Date: Fri, 13 Nov 2020 11:29:02 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v6 1/7] arm64: mm: Move reserve_crashkernel() into
 mem_init()
Message-ID: <20201113112901.GA3212@gaia>
References: <20201103173159.27570-1-nsaenzjulienne@suse.de>
 <20201103173159.27570-2-nsaenzjulienne@suse.de>
 <e60d643e-4879-3fc3-737d-2c145332a6d7@arm.com>
 <88c69ac0c9d7e144c80cebc7e9f82b000828e7f5.camel@suse.de>
 <X6rZRvWyigCJxAVW@trantor>
 <b5336064145a30aadcfdb8920226a8c63f692695.camel@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b5336064145a30aadcfdb8920226a8c63f692695.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, Chen Zhou <chenzhou10@huawei.com>,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 ardb@kernel.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 James Morse <james.morse@arm.com>, linux-rpi-kernel@lists.infradead.org,
 guohanjun@huawei.com, will@kernel.org, hch@lst.de,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Nicolas,

On Thu, Nov 12, 2020 at 04:56:38PM +0100, Nicolas Saenz Julienne wrote:
> On Tue, 2020-11-10 at 18:17 +0000, Catalin Marinas wrote:
> > On Fri, Nov 06, 2020 at 07:46:29PM +0100, Nicolas Saenz Julienne wrote:
> > > On Thu, 2020-11-05 at 16:11 +0000, James Morse wrote:
> > > > On 03/11/2020 17:31, Nicolas Saenz Julienne wrote:
> > > > > crashkernel might reserve memory located in ZONE_DMA. We plan to delay
> > > > > ZONE_DMA's initialization after unflattening the devicetree and ACPI's
> > > > > boot table initialization, so move it later in the boot process.
> > > > > Specifically into mem_init(), this is the last place crashkernel will be
> > > > > able to reserve the memory before the page allocator kicks in.
> > > > > There
> > > > > isn't any apparent reason for doing this earlier.
> > > > 
> > > > It's so that map_mem() can carve it out of the linear/direct map.
> > > > This is so that stray writes from a crashing kernel can't accidentally corrupt the kdump
> > > > kernel. We depend on this if we continue with kdump, but failed to offline all the other
> > > > CPUs.
> > > 
> > > I presume here you refer to arch_kexec_protect_crashkres(), IIUC this will only
> > > happen further down the line, after having loaded the kdump kernel image. But
> > > it also depends on the mappings to be PAGE sized (flags == NO_BLOCK_MAPPINGS |
> > > NO_CONT_MAPPINGS).
> > 
> > IIUC, arch_kexec_protect_crashkres() is only for the crashkernel image,
> > not the whole reserved memory that the crashkernel will use. For the
> > latter, we avoid the linear map by marking it as nomap in map_mem().
> 
> I'm not sure we're on the same page here, so sorry if this was already implied.
> 
> The crashkernel memory mapping is bypassed while preparing the linear mappings
> but it is then mapped right away, with page granularity and !MTE.
> See paging_init()->map_mem():
> 
> 	/*
> 	 * Use page-level mappings here so that we can shrink the region
> 	 * in page granularity and put back unused memory to buddy system
> 	 * through /sys/kernel/kexec_crash_size interface.
> 	 */
> 	if (crashk_res.end) {
> 		__map_memblock(pgdp, crashk_res.start, crashk_res.end + 1,
> 			       PAGE_KERNEL,
> 			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> 		memblock_clear_nomap(crashk_res.start,
> 				     resource_size(&crashk_res));
> 	}
> 
> IIUC the inconvenience here is that we need special mapping options for
> crashkernel and updating those after having mapped that memory as regular
> memory isn't possible/easy to do.

You are right, it still gets mapped but with page granularity. However,
to James' point, we still need to know the crashkernel range in
map_mem() as arch_kexec_protect_crashkres() relies on having page rather
than block mappings.

> > > > We also depend on this when skipping the checksum code in purgatory, which can be
> > > > exceedingly slow.
> > > 
> > > This one I don't fully understand, so I'll lazily assume the prerequisite is
> > > the same WRT how memory is mapped. :)
> > > 
> > > Ultimately there's also /sys/kernel/kexec_crash_size's handling. Same
> > > prerequisite.
> > > 
> > > Keeping in mind acpi_table_upgrade() and unflatten_device_tree() depend on
> > > having the linear mappings available.
> > 
> > So it looks like reserve_crashkernel() wants to reserve memory before
> > setting up the linear map with the information about the DMA zones in
> > place but that comes later when we can parse the firmware tables.
> > 
> > I wonder, instead of not mapping the crashkernel reservation, can we not
> > do an arch_kexec_protect_crashkres() for the whole reservation after we
> > created the linear map?
> 
> arch_kexec_protect_crashkres() depends on __change_memory_common() which
> ultimately depends on the memory to be mapped with PAGE_SIZE pages. As I
> comment above, the trick would work as long as there is as way to update the
> linear mappings with whatever crashkernel needs later in the boot process.

Breaking block mappings into pages is a lot more difficult later. OTOH,
the default these days is rodata_full==true, so I don't think we have
block mappings anyway. We could add NO_BLOCK_MAPPINGS if KEXEC_CORE is
enabled.

> > > Let me stress that knowing the DMA constraints in the system before reserving
> > > crashkernel's regions is necessary if we ever want it to work seamlessly on all
> > > platforms. Be it small stuff like the Raspberry Pi or huge servers with TB of
> > > memory.
> > 
> > Indeed. So we have 3 options (so far):
> > 
> > 1. Allow the crashkernel reservation to go into the linear map but set
> >    it to invalid once allocated.
> > 
> > 2. Parse the flattened DT (not sure what we do with ACPI) before
> >    creating the linear map. We may have to rely on some SoC ID here
> >    instead of actual DMA ranges.
> > 
> > 3. Assume the smallest ZONE_DMA possible on arm64 (1GB) for crashkernel
> >    reservations and not rely on arm64_dma_phys_limit in
> >    reserve_crashkernel().
> > 
> > I think (2) we tried hard to avoid. Option (3) brings us back to the
> > issues we had on large crashkernel reservations regressing on some
> > platforms (though it's been a while since, they mostly went quiet ;)).
> > However, with Chen's crashkernel patches we end up with two
> > reservations, one in the low DMA zone and one higher, potentially above
> > 4GB. Having a fixed 1GB limit wouldn't be any worse for crashkernel
> > reservations than what we have now.
> > 
> > If (1) works, I'd go for it (James knows this part better than me),
> > otherwise we can go for (3).
> 
> Overall, I'd prefer (1) as well, and I'd be happy to have a got at it. If not
> I'll append (3) in this series.

I think for 1 we could also remove the additional KEXEC_CORE checks,
something like below, untested:

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 3e5a6913acc8..27ab609c1c0c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -477,7 +477,8 @@ static void __init map_mem(pgd_t *pgdp)
 	int flags = 0;
 	u64 i;
 
-	if (rodata_full || debug_pagealloc_enabled())
+	if (rodata_full || debug_pagealloc_enabled() ||
+	    IS_ENABLED(CONFIG_KEXEC_CORE))
 		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	/*
@@ -487,11 +488,6 @@ static void __init map_mem(pgd_t *pgdp)
 	 * the following for-loop
 	 */
 	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
-#ifdef CONFIG_KEXEC_CORE
-	if (crashk_res.end)
-		memblock_mark_nomap(crashk_res.start,
-				    resource_size(&crashk_res));
-#endif
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
@@ -518,21 +514,6 @@ static void __init map_mem(pgd_t *pgdp)
 	__map_memblock(pgdp, kernel_start, kernel_end,
 		       PAGE_KERNEL, NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
-
-#ifdef CONFIG_KEXEC_CORE
-	/*
-	 * Use page-level mappings here so that we can shrink the region
-	 * in page granularity and put back unused memory to buddy system
-	 * through /sys/kernel/kexec_crash_size interface.
-	 */
-	if (crashk_res.end) {
-		__map_memblock(pgdp, crashk_res.start, crashk_res.end + 1,
-			       PAGE_KERNEL,
-			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
-		memblock_clear_nomap(crashk_res.start,
-				     resource_size(&crashk_res));
-	}
-#endif
 }
 
 void mark_rodata_ro(void)

-- 
Catalin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
