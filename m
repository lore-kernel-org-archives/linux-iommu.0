Return-Path: <SRS0=f7gc=B5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0113DC433E4
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 20:49:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C063222CBB
	for <iommu@archiver.kernel.org>; Wed, 19 Aug 2020 20:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDED5GsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C063222CBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 97CAD88075;
	Wed, 19 Aug 2020 20:49:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KKFCqqkRNTcB; Wed, 19 Aug 2020 20:49:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 85DB887FD8;
	Wed, 19 Aug 2020 20:49:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 663BEC07FF;
	Wed, 19 Aug 2020 20:49:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A29C9C0051
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 20:49:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8BCF48619E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 20:49:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XUsBHUKAs48F for <iommu@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 20:49:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 14EE686141
 for <iommu@lists.linux-foundation.org>; Wed, 19 Aug 2020 20:49:05 +0000 (UTC)
Received: from kernel.org (unknown [87.70.91.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4559022B43;
 Wed, 19 Aug 2020 20:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597870143;
 bh=qGoMJNQU47bi4Lr27Xvnh0/Sq60m3eAX4xqpvHpl7z0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EDED5GsJw4zUuBdGb05pEvujvo8C6rUQNmDr6tFajHgKyq8u0aC1JhmrGGKixlNzr
 iJK0JwajiHl4HBTkAxVXhkjy+fJ4SSitgCYA/knE1HAPx9DykSi5zvv7ufmh3aqaBj
 /RQUWYvoEHKL6x5oDDNaW/gHGb6Yyk2UI/DMzVR8=
Date: Wed, 19 Aug 2020 23:48:48 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 09/17] memblock: make memblock_debug and related
 functionality private
Message-ID: <20200819204848.GX752365@kernel.org>
References: <20200818151634.14343-1-rppt@kernel.org>
 <20200818151634.14343-10-rppt@kernel.org>
 <20200819122405.88e9719e86ac7c3c44b4db32@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200819122405.88e9719e86ac7c3c44b4db32@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Mike Rapoport <rppt@linux.ibm.com>, clang-built-linux@googlegroups.com,
 Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Stafford Horne <shorne@gmail.com>, Hari Bathini <hbathini@linux.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Michal Simek <monstr@monstr.eu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Palmer Dabbelt <palmer@dabbelt.com>, linuxppc-dev@lists.ozlabs.org
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

On Wed, Aug 19, 2020 at 12:24:05PM -0700, Andrew Morton wrote:
> On Tue, 18 Aug 2020 18:16:26 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The only user of memblock_dbg() outside memblock was s390 setup code and it
> > is converted to use pr_debug() instead.
> > This allows to stop exposing memblock_debug and memblock_dbg() to the rest
> > of the kernel.
> > 
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -137,7 +137,10 @@ struct memblock_type physmem = {
> >  	     i < memblock_type->cnt;					\
> >  	     i++, rgn = &memblock_type->regions[i])
> >  
> > -int memblock_debug __initdata_memblock;
> > +#define memblock_dbg(fmt, ...) \
> > +	if (memblock_debug) printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> > +
> 
> checkpatch doesn't like this much.
> 
> ERROR: Macros starting with if should be enclosed by a do - while loop to avoid possible if/else logic defects
> #101: FILE: mm/memblock.c:140:
> +#define memblock_dbg(fmt, ...) \
> +	if (memblock_debug) printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> 
> WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...
> #102: FILE: mm/memblock.c:141:
> +	if (memblock_debug) printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> 
> ERROR: trailing statements should be on next line
> #102: FILE: mm/memblock.c:141:
> +	if (memblock_debug) printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> 
> 
> The first one is significant:
> 
> 	if (foo)
> 		memblock_dbg(...);
> 	else
> 		save_the_world();
> 
> could end up inadvertently destroying the planet.

Well, it didn't till now ;-)

> This?
> 
> --- a/mm/memblock.c~memblock-make-memblock_debug-and-related-functionality-private-fix
> +++ a/mm/memblock.c
> @@ -137,8 +137,11 @@ struct memblock_type physmem = {
>  	     i < memblock_type->cnt;					\
>  	     i++, rgn = &memblock_type->regions[i])
>  
> -#define memblock_dbg(fmt, ...) \
> -	if (memblock_debug) printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> +#define memblock_dbg(fmt, ...)						\
> +	do {								\
> +		if (memblock_debug)					\
> +			pr_info(fmt, ##__VA_ARGS__);			\
> +	} while (0)

Sure, thanks!

>  static int memblock_debug __initdata_memblock;
>  static bool system_has_some_mirror __initdata_memblock = false;
> _
> 

-- 
Sincerely yours,
Mike.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
