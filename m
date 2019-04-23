Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672EEC10F03
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 21:38:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B45E218D3
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 21:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lo4wHUjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B45E218D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D35A7F23;
	Tue, 23 Apr 2019 21:38:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 487CDF15
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 21:38:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6A498F4
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 21:38:25 +0000 (UTC)
Received: from zn.tnic (p200300EC2F10CC006C678EE1EA32B98E.dip0.t-ipconnect.de
	[IPv6:2003:ec:2f10:cc00:6c67:8ee1:ea32:b98e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id
	E27731EC021C; Tue, 23 Apr 2019 23:38:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1556055503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:in-reply-to:in-reply-to: references:references;
	bh=NtaNYAZze2UDIswDoiUADMmIdJ1zFzxKUCVn/S1NbwU=;
	b=lo4wHUjLO86YEPGlJiToctnoQpLC1X1hiyf9ssh9IkqVfB+mKn7BOBg7ZvVjUIW0ZIJFHo
	OvbZNbkrKC3BWs1LZ7bc7+DtfEorU+fP7qvrAEPe9s6YTHrOekvgN2z9WFolsGjvbbO/bF
	LDv1YDHiy9xbZozzWlGiNjOyLVl3b1M=
Date: Tue, 23 Apr 2019 23:38:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v2 56/79] docs: Documentation/*.txt: rename all ReST
	files to *.rst
Message-ID: <20190423213816.GE16353@zn.tnic>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
	<cda57849a6462ccc72dcd360b30068ab6a1021c4.1555938376.git.mchehab+samsung@kernel.org>
	<20190423083135.GA11158@hirez.programming.kicks-ass.net>
	<20190423125519.GA7104@redhat.com>
	<20190423130132.GT4038@hirez.programming.kicks-ass.net>
	<20190423103053.07cf2149@lwn.net>
	<20190423171158.GG12232@hirez.programming.kicks-ass.net>
	<20190423172006.GD16353@zn.tnic> <20190423170409.7b1370ac@coco.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190423170409.7b1370ac@coco.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mike Snitzer <snitzer@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>, Farhan Ali <alifm@linux.ibm.com>,
	Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org,
	Jaroslav Kysela <perex@perex.cz>, kernel-hardening@lists.openwall.com,
	Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
	linux-sh@vger.kernel.org, James Morris <jmorris@namei.org>,
	Halil Pasic <pasic@linux.ibm.com>, tboot-devel@lists.sourceforge.net,
	Alan Stern <stern@rowland.harvard.edu>,
	openipmi-developer@lists.sourceforge.net,
	Guenter Roeck <linux@roeck-us.net>, Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Matt Mackall <mpm@selenic.com>, Thomas Gleixner <tglx@linutronix.de>,
	Sean Paul <sean@poorly.run>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>, linux-fbdev@vger.kernel.org,
	linux-ia64@vger.kernel.org,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	David Airlie <airlied@linux.ie>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	dm-devel@redhat.com, Harry Wei <harryxiyou@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alasdair Kergon <agk@redhat.com>, linux-s390@vger.kernel.org,
	Alex Shi <alex.shi@linux.alibaba.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>,
	Changbin Du <changbin.du@gmail.com>, Eric Farman <farman@linux.ibm.com>,
	linux-watchdog@vger.kernel.org, Corey Minyard <minyard@acm.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	linaro-mm-sig@lists.linaro.org, linux-gpio@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
	Tony Luck <tony.luck@intel.com>, Cornelia Huck <cohuck@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Andrea Parri <andrea.parri@amarulasolutions.com>,
	linux-pci@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	platform-driver-x86@vger.kernel.org,
	"Paul E. McKenney" <paulmck@linux.ibm.com>,
	Jonathan Corbet <corbet@lwn.net>, Kishon Vijay Abraham I <kishon@ti.com>,
	Peter Zijlstra <peterz@infradead.org>, Emese Revfy <re.emese@gmail.com>,
	Darren Hart <dvhart@infradead.org>, Jade Alglave <j.alglave@ucl.ac.uk>,
	"Serge E. Hallyn" <serge@hallyn.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Ning Sun <ning.sun@intel.com>, Luc Maranget <luc.maranget@inria.fr>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Guan Xuetao <gxt@pku.edu.cn>, linux-parisc@vger.kernel.org,
	iommu@lists.linux-foundation.org, Stuart Hayes <stuart.w.hayes@gmail.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Rich Felker <dalias@libc.org>, kvm@vger.kernel.org,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Jerry Hoemann <jerry.hoemann@hpe.com>,
	David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
	Kirti Wankhede <kwankhede@nvidia.com>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Ingo Molnar <mingo@redhat.com>, devicetree@vger.kernel.org,
	Daniel Lustig <dlustig@nvidia.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	linux-block@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jens Axboe <axboe@kernel.dk>, netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
	Johannes Berg <johannes@sipsolutions.net>,
	Robin Murphy <robin.murphy@arm.com>, Andy Shevchenko <andy@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190423213816.I1aOfjDEZBgrTzrIf1d9yYXVrBfoQ8AFzYcHpxq3_sw@z>

On Tue, Apr 23, 2019 at 05:05:02PM -0300, Mauro Carvalho Chehab wrote:
> That's my view about how that specific file would be after
> converted to ReST:
> 
> 	https://git.linuxtv.org/mchehab/experimental.git/tree/Documentation/x86/x86_64/mm.rst?h=convert_rst_renames
> 
> I don't have any troubles reading/understanding it as a plain text
> file,

If that is all the changes it would need, then I guess that's ok. Btw,
those rst-conversion patches don't really show what got changed. Dunno
if git can even show that properly. I diffed the two files by hand to
see what got changed, see end of mail.

So I guess if table in rst means, one needs to draw rows and columns, I
guess that's ok. It's not like I have to do it every day.

But exactly this - *having* to do rst formatting would mean a lot of
getting used to and people writing something which is not necessarily
correct rst and someone else fixing up after them.

Another pain point is changing the file paths. Without cscope I would've
been cursing each time I'm looking for kernel-parameters.txt, for
example. First of all, it is in Documentation/admin-guide/ now and then
there's Documentation/admin-guide/kernel-parameters.rst too.

I guess the .rst sucks in the .txt file and shows it monospaced. Oh
well.

So* I'd suggest having as less markup in those files as possible and if
it is needed, automate adding the needed markup, as Jon suggested.

The perfect example was the one which Peter gave and I had to paste in a
thread today:

"The memory allocations via :c:func:`kmalloc`, :c:func:`vmalloc`,
:c:func:`kmem_cache_alloc` and"

That is very unreadable.

Anyway, stuff like that. Just giving my feedback here in case you're
interested. :-)

> and its html output is also nice (although Sphinx 1.7.8 seems to
> have some issues when parsing some cells - probably due to some bug):
> 
> 	https://www.infradead.org/~mchehab/rst_conversion/x86/x86_64/mm.html

I don't know how that looks in your browser but in mine those addresses
are not in monospaced font and there's no properly reading them.

And yap, the cells parsing fun I see too.

> Changbin's approach was somewhat close to what you want. He simply
> prepended the tables with ::, in order to show them as plain old
> ascii:
> 
> 	https://lore.kernel.org/lkml/20190423162932.21428-60-changbin.du@gmail.com/

Yap, that's better.

I mean, the file is just as readable in plain old ASCII, if not even
more so. At least to me but I prefer simple things so...

> 
> Both equally works, from ReST conversion PoV. I'm fine ether way.
> 
> I prefer my approach, as, IMHO, it is visually nicer on both text and
> html versions, but his approach is likely easier to maintain, as doing
> ascii artwork by hand is sometimes painful.

Yap.

Thx.

---
--- mm.old	2019-04-23 23:18:55.954335784 +0200
+++ mm.new	2019-04-23 23:18:48.122335821 +0200
@@ -18,51 +18,68 @@ Notes:
    notation than "16 EB", which few will recognize at first sight as 16 exabytes.
    It also shows it nicely how incredibly large 64-bit address space is.
 
-========================================================================================================================
-    Start addr    |   Offset   |     End addr     |  Size   | VM area description
-========================================================================================================================
-                  |            |                  |         |
- 0000000000000000 |    0       | 00007fffffffffff |  128 TB | user-space virtual memory, different per mm
-__________________|____________|__________________|_________|___________________________________________________________
-                  |            |                  |         |
- 0000800000000000 | +128    TB | ffff7fffffffffff | ~16M TB | ... huge, almost 64 bits wide hole of non-canonical
-                  |            |                  |         |     virtual memory addresses up to the -128 TB
-                  |            |                  |         |     starting offset of kernel mappings.
-__________________|____________|__________________|_________|___________________________________________________________
-                                                            |
-                                                            | Kernel-space virtual memory, shared between all processes:
-____________________________________________________________|___________________________________________________________
-                  |            |                  |         |
- ffff800000000000 | -128    TB | ffff87ffffffffff |    8 TB | ... guard hole, also reserved for hypervisor
- ffff880000000000 | -120    TB | ffff887fffffffff |  0.5 TB | LDT remap for PTI
- ffff888000000000 | -119.5  TB | ffffc87fffffffff |   64 TB | direct mapping of all physical memory (page_offset_base)
- ffffc88000000000 |  -55.5  TB | ffffc8ffffffffff |  0.5 TB | ... unused hole
- ffffc90000000000 |  -55    TB | ffffe8ffffffffff |   32 TB | vmalloc/ioremap space (vmalloc_base)
- ffffe90000000000 |  -23    TB | ffffe9ffffffffff |    1 TB | ... unused hole
- ffffea0000000000 |  -22    TB | ffffeaffffffffff |    1 TB | virtual memory map (vmemmap_base)
- ffffeb0000000000 |  -21    TB | ffffebffffffffff |    1 TB | ... unused hole
- ffffec0000000000 |  -20    TB | fffffbffffffffff |   16 TB | KASAN shadow memory
-__________________|____________|__________________|_________|____________________________________________________________
-                                                            |
-                                                            | Identical layout to the 56-bit one from here on:
-____________________________________________________________|____________________________________________________________
-                  |            |                  |         |
- fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
-                  |            |                  |         | vaddr_end for KASLR
- fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
- fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | ... unused hole
- ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
- ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole
- ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
- ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole
- ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping, mapped to physical address 0
- ffffffff80000000 |-2048    MB |                  |         |
- ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapping space
- ffffffffff000000 |  -16    MB |                  |         |
-    FIXADDR_START | ~-11    MB | ffffffffff5fffff | ~0.5 MB | kernel-internal fixmap range, variable size and offset
- ffffffffff600000 |  -10    MB | ffffffffff600fff |    4 kB | legacy vsyscall ABI
- ffffffffffe00000 |   -2    MB | ffffffffffffffff |    2 MB | ... unused hole
-__________________|____________|__________________|_________|___________________________________________________________
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|   Start addr    |   Offset   |     End addr     |  Size   | VM area description                                       |
++=================+============+==================+=========+===========================================================+
+|                 |            |                  |         |                                                           |
+|0000000000000000 |    0       | 00007fffffffffff |  128 TB | user-space virtual memory, different per mm               |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|                 |            |                  |         |                                                           |
+|0000800000000000 | +128    TB | ffff7fffffffffff | ~16M TB | ... huge, almost 64 bits wide hole of non-canonical       |
+|                 |            |                  |         | virtual memory addresses up to the -128 TB                |
+|                 |            |                  |         | starting offset of kernel mappings.                       |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|                      **Kernel-space virtual memory, shared between all processes:**                                   |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffff800000000000 | -128    TB | ffff87ffffffffff |    8 TB | ... guard hole, also reserved for hypervisor              |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffff880000000000 | -120    TB | ffff887fffffffff |  0.5 TB | LDT remap for PTI                                         |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffff888000000000 | -119.5  TB | ffffc87fffffffff |   64 TB | direct mapping of all physical memory (page_offset_base)  |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffc88000000000 |  -55.5  TB | ffffc8ffffffffff |  0.5 TB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffc90000000000 |  -55    TB | ffffe8ffffffffff |   32 TB | vmalloc/ioremap space (vmalloc_base)                      |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffe90000000000 |  -23    TB | ffffe9ffffffffff |    1 TB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffea0000000000 |  -22    TB | ffffeaffffffffff |    1 TB | virtual memory map (vmemmap_base)                         |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffeb0000000000 |  -21    TB | ffffebffffffffff |    1 TB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffec0000000000 |  -20    TB | fffffbffffffffff |   16 TB | KASAN shadow memory                                       |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|                         **Identical layout to the 56-bit one from here on:**                                          |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole                                           |
+|                 |            |                  |         | vaddr_end for KASLR                                       |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping                                    |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks                                         |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space                                  |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping, mapped to physical address 0         |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffff80000000 |-2048    MB |                  |         |                                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapping space                                      |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffffff000000 |  -16    MB |                  |         |                                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|   FIXADDR_START | ~-11    MB | ffffffffff5fffff | ~0.5 MB | kernel-internal fixmap range, variable size and offset    |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffffff600000 |  -10    MB | ffffffffff600fff |    4 kB | legacy vsyscall ABI                                       |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffffffe00000 |   -2    MB | ffffffffffffffff |    2 MB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
 
 
 ====================================================
@@ -76,51 +93,66 @@ Notes:
    offset and many of the regions expand to support the much larger physical
    memory supported.
 
-========================================================================================================================
-    Start addr    |   Offset   |     End addr     |  Size   | VM area description
-========================================================================================================================
-                  |            |                  |         |
- 0000000000000000 |    0       | 00ffffffffffffff |   64 PB | user-space virtual memory, different per mm
-__________________|____________|__________________|_________|___________________________________________________________
-                  |            |                  |         |
- 0100000000000000 |  +64    PB | feffffffffffffff | ~16K PB | ... huge, still almost 64 bits wide hole of non-canonical
-                  |            |                  |         |     virtual memory addresses up to the -64 PB
-                  |            |                  |         |     starting offset of kernel mappings.
-__________________|____________|__________________|_________|___________________________________________________________
-                                                            |
-                                                            | Kernel-space virtual memory, shared between all processes:
-____________________________________________________________|___________________________________________________________
-                  |            |                  |         |
- ff00000000000000 |  -64    PB | ff0fffffffffffff |    4 PB | ... guard hole, also reserved for hypervisor
- ff10000000000000 |  -60    PB | ff10ffffffffffff | 0.25 PB | LDT remap for PTI
- ff11000000000000 |  -59.75 PB | ff90ffffffffffff |   32 PB | direct mapping of all physical memory (page_offset_base)
- ff91000000000000 |  -27.75 PB | ff9fffffffffffff | 3.75 PB | ... unused hole
- ffa0000000000000 |  -24    PB | ffd1ffffffffffff | 12.5 PB | vmalloc/ioremap space (vmalloc_base)
- ffd2000000000000 |  -11.5  PB | ffd3ffffffffffff |  0.5 PB | ... unused hole
- ffd4000000000000 |  -11    PB | ffd5ffffffffffff |  0.5 PB | virtual memory map (vmemmap_base)
- ffd6000000000000 |  -10.5  PB | ffdeffffffffffff | 2.25 PB | ... unused hole
- ffdf000000000000 |   -8.25 PB | fffffbffffffffff |   ~8 PB | KASAN shadow memory
-__________________|____________|__________________|_________|____________________________________________________________
-                                                            |
-                                                            | Identical layout to the 47-bit one from here on:
-____________________________________________________________|____________________________________________________________
-                  |            |                  |         |
- fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
-                  |            |                  |         | vaddr_end for KASLR
- fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
- fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | ... unused hole
- ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
- ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole
- ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
- ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole
- ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping, mapped to physical address 0
- ffffffff80000000 |-2048    MB |                  |         |
- ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapping space
- ffffffffff000000 |  -16    MB |                  |         |
-    FIXADDR_START | ~-11    MB | ffffffffff5fffff | ~0.5 MB | kernel-internal fixmap range, variable size and offset
- ffffffffff600000 |  -10    MB | ffffffffff600fff |    4 kB | legacy vsyscall ABI
- ffffffffffe00000 |   -2    MB | ffffffffffffffff |    2 MB | ... unused hole
-__________________|____________|__________________|_________|___________________________________________________________
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|   Start addr    |   Offset   |     End addr     |  Size   | VM area description                                       |
++=================+============+==================+=========+===========================================================+
+|0000000000000000 |    0       | 00ffffffffffffff |   64 PB | user-space virtual memory, different per mm               |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|0100000000000000 |  +64    PB | feffffffffffffff | ~16K PB | ... huge, still almost 64 bits wide hole of non-canonical |
+|                 |            |                  |         | virtual memory addresses up to the -64 PB                 |
+|                 |            |                  |         | starting offset of kernel mappings.                       |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|                       **Kernel-space virtual memory, shared between all processes:**                                  |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ff00000000000000 |  -64    PB | ff0fffffffffffff |    4 PB | ... guard hole, also reserved for hypervisor              |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ff10000000000000 |  -60    PB | ff10ffffffffffff | 0.25 PB | LDT remap for PTI                                         |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ff11000000000000 |  -59.75 PB | ff90ffffffffffff |   32 PB | direct mapping of all physical memory (page_offset_base)  |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ff91000000000000 |  -27.75 PB | ff9fffffffffffff | 3.75 PB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffa0000000000000 |  -24    PB | ffd1ffffffffffff | 12.5 PB | vmalloc/ioremap space (vmalloc_base)                      |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffd2000000000000 |  -11.5  PB | ffd3ffffffffffff |  0.5 PB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffd4000000000000 |  -11    PB | ffd5ffffffffffff |  0.5 PB | virtual memory map (vmemmap_base)                         |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffd6000000000000 |  -10.5  PB | ffdeffffffffffff | 2.25 PB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffdf000000000000 |   -8.25 PB | fffffbffffffffff |   ~8 PB | KASAN shadow memory                                       |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|                           **Identical layout to the 47-bit one from here on:**                                        |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole                                           |
+|                 |            |                  |         | vaddr_end for KASLR                                       |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping                                    |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks                                         |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space                                  |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffff80000000 |   -2    GB | ffffffff9fffffff |  512 MB | kernel text mapping, mapped to physical address 0         |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffff80000000 |-2048    MB |                  |         |                                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffffa0000000 |-1536    MB | fffffffffeffffff | 1520 MB | module mapping space                                      |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffffff000000 |  -16    MB |                  |         |                                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|   FIXADDR_START | ~-11    MB | ffffffffff5fffff | ~0.5 MB | kernel-internal fixmap range, variable size and offset    |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffffff600000 |  -10    MB | ffffffffff600fff |    4 kB | legacy vsyscall ABI                                       |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
+|ffffffffffe00000 |   -2    MB | ffffffffffffffff |    2 MB | ... unused hole                                           |
++-----------------+------------+------------------+---------+-----------------------------------------------------------+
 
 Architecture defines a 64-bit virtual address. Implementations can support
 less. Currently supported are 48- and 57-bit virtual addresses. Bits 63

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
