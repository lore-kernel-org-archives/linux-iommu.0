Return-Path: <SRS0=Zw9n=BL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA86C433DF
	for <iommu@archiver.kernel.org>; Sat,  1 Aug 2020 10:19:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A8F208A9
	for <iommu@archiver.kernel.org>; Sat,  1 Aug 2020 10:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOX5CM31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A8F208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 130168715D;
	Sat,  1 Aug 2020 10:19:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XF-XxO9HgPiY; Sat,  1 Aug 2020 10:19:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 798328714B;
	Sat,  1 Aug 2020 10:19:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56013C0050;
	Sat,  1 Aug 2020 10:19:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C552BC004D
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 10:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BF73B8714D
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 10:19:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qeKibWQ-ulLK for <iommu@lists.linux-foundation.org>;
 Sat,  1 Aug 2020 10:19:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 42CA28714B
 for <iommu@lists.linux-foundation.org>; Sat,  1 Aug 2020 10:19:11 +0000 (UTC)
Received: from kernel.org (unknown [87.70.91.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5ED692087C;
 Sat,  1 Aug 2020 10:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596277150;
 bh=jQD0i2dEJRPR8dDJK6vZOAFdpUe2Ho5YLvcSFtENhXg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BOX5CM31age4ZqR8WpA9Tu6Sib3TWB8q0axiVZJ9476Af21jQMyZgnRXNsbolGSGn
 pWpwQlO3I1Ym/ZhVqWnuEZ70zJ8p8UgBgfsl0uitfuYMEFBB9GFeRHX0dU8VC7876G
 1GC7zC28lCBEAGXT18VZfRnXSGNcrY6WFAZx7Yv0=
Date: Sat, 1 Aug 2020 13:18:54 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 06/15] powerpc: fadamp: simplify
 fadump_reserve_crash_area()
Message-ID: <20200801101854.GD534153@kernel.org>
References: <20200728051153.1590-1-rppt@kernel.org>
 <20200728051153.1590-7-rppt@kernel.org>
 <87d04d5hda.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87d04d5hda.fsf@mpe.ellerman.id.au>
Cc: linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Hari Bathini <hbathini@in.ibm.com>,
 linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
 Stafford Horne <shorne@gmail.com>, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Mike Rapoport <rppt@linux.ibm.com>, clang-built-linux@googlegroups.com,
 Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <monstr@monstr.eu>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
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

On Thu, Jul 30, 2020 at 10:15:13PM +1000, Michael Ellerman wrote:
> Mike Rapoport <rppt@kernel.org> writes:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > fadump_reserve_crash_area() reserves memory from a specified base address
> > till the end of the RAM.
> >
> > Replace iteration through the memblock.memory with a single call to
> > memblock_reserve() with appropriate  that will take care of proper memory
>                                      ^
>                                      parameters?
> > reservation.
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/powerpc/kernel/fadump.c | 20 +-------------------
> >  1 file changed, 1 insertion(+), 19 deletions(-)
> 
> I think this looks OK to me, but I don't have a setup to test it easily.
> I've added Hari to Cc who might be able to.
> 
> But I'll give you an ack in the hope that it works :)

Actually, I did some digging in the git log and the traversal was added
there on purpose by the commit b71a693d3db3 ("powerpc/fadump: exclude
memory holes while reserving memory in second kernel")
Presuming this is still reqruired I'm going to drop this patch and will
simply replace for_each_memblock() with for_each_mem_range() in v2.
 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> 
> > diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> > index 78ab9a6ee6ac..2446a61e3c25 100644
> > --- a/arch/powerpc/kernel/fadump.c
> > +++ b/arch/powerpc/kernel/fadump.c
> > @@ -1658,25 +1658,7 @@ int __init fadump_reserve_mem(void)
> >  /* Preserve everything above the base address */
> >  static void __init fadump_reserve_crash_area(u64 base)
> >  {
> > -	struct memblock_region *reg;
> > -	u64 mstart, msize;
> > -
> > -	for_each_memblock(memory, reg) {
> > -		mstart = reg->base;
> > -		msize  = reg->size;
> > -
> > -		if ((mstart + msize) < base)
> > -			continue;
> > -
> > -		if (mstart < base) {
> > -			msize -= (base - mstart);
> > -			mstart = base;
> > -		}
> > -
> > -		pr_info("Reserving %lluMB of memory at %#016llx for preserving crash data",
> > -			(msize >> 20), mstart);
> > -		memblock_reserve(mstart, msize);
> > -	}
> > +	memblock_reserve(base, memblock_end_of_DRAM() - base);
> >  }
> >  
> >  unsigned long __init arch_reserved_kernel_pages(void)
> > -- 
> > 2.26.2

-- 
Sincerely yours,
Mike.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
