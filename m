Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F852C10F11
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 10:42:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD0320811
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 10:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HiViw6Xk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD0320811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8DB12EF4;
	Wed, 24 Apr 2019 10:42:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CB75CEF1
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 10:42:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E4EE8786
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 10:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209;
	h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CKJPV0I9SyUUg5F9TPf6hUjTE9Jh7lyl05IAphRN+qA=;
	b=HiViw6Xkj0TQdK90azdiHFpYNv
	B0GxQ9VW3uimiNcP81Apw7ZH+kUTfQadYVJ3cCVoxBNEH56PBL9BEFm8Vcn7TJ+8wHXRmFclifwHU
	v5POargTY3elo70A1aZ/sMmA9jiP+y1/18DvxQFbbPWr7IrOqPaZLo9+d88P5v9aJjEo1U5wzPT2S
	A1iOWNFCE08y3RUnAzWB3vbFqm+sS8ue65bUP3wuP7BprdPNwst63C9M/P79om6IAnUW0C1RoGCB7
	TxPmTuTAkx/OqpginIsqUV9IpWPPO//Rwd8q8SKI8ZNekLfNqlIDzDBg+eD1g9tnx3bXVZc5q8olF
	KDI7LYdw==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
	helo=coco.lan)
	by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hJFKR-0007Rt-3x; Wed, 24 Apr 2019 10:40:39 +0000
Date: Wed, 24 Apr 2019 07:40:07 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 56/79] docs: Documentation/*.txt: rename all ReST
	files to *.rst
Message-ID: <20190423232325.679c100b@coco.lan>
In-Reply-To: <20190423213816.GE16353@zn.tnic>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
	<cda57849a6462ccc72dcd360b30068ab6a1021c4.1555938376.git.mchehab+samsung@kernel.org>
	<20190423083135.GA11158@hirez.programming.kicks-ass.net>
	<20190423125519.GA7104@redhat.com>
	<20190423130132.GT4038@hirez.programming.kicks-ass.net>
	<20190423103053.07cf2149@lwn.net>
	<20190423171158.GG12232@hirez.programming.kicks-ass.net>
	<20190423172006.GD16353@zn.tnic> <20190423170409.7b1370ac@coco.lan>
	<20190423213816.GE16353@zn.tnic>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
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
	David Airlie <airlied@linux.ie>, "James E.J.
	Bottomley" <James.Bottomley@HansenPartnership.com>, dm-devel@redhat.com,
	Harry Wei <harryxiyou@gmail.com>,
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
	Darren Hart <dvhart@infradead.org>,
	Jade Alglave <j.alglave@ucl.ac.uk>, "Serge
	E. Hallyn" <serge@hallyn.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Ning Sun <ning.sun@intel.com>, Luc Maranget <luc.maranget@inria.fr>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Guan Xuetao <gxt@pku.edu.cn>, linux-parisc@vger.kernel.org,
	iommu@lists.linux-foundation.org, Stuart Hayes <stuart.w.hayes@gmail.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>,
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
Message-ID: <20190424104007.ytl_e-QIw7-YPlj1rmS7uPz47xZEV-0of8lNqogz0c4@z>

Em Tue, 23 Apr 2019 23:38:16 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Tue, Apr 23, 2019 at 05:05:02PM -0300, Mauro Carvalho Chehab wrote:
> > That's my view about how that specific file would be after
> > converted to ReST:
> > 
> > 	https://git.linuxtv.org/mchehab/experimental.git/tree/Documentation/x86/x86_64/mm.rst?h=convert_rst_renames
> > 
> > I don't have any troubles reading/understanding it as a plain text
> > file,  
> 
> If that is all the changes it would need, then I guess that's ok. Btw,
> those rst-conversion patches don't really show what got changed. Dunno
> if git can even show that properly. I diffed the two files by hand to
> see what got changed, see end of mail.

Well, you can use git show -M01 and it will likely show what
changed. The thing is that plain diff is not very good showing
diffs on text files. I suspect that using some tool like wdiff
would give a better view of such changes.

> So I guess if table in rst means, one needs to draw rows and columns, I
> guess that's ok. It's not like I have to do it every day.

Yes, for complex tables, one needs to draw rows/columns. For simple
tables, all you need to do is something like:

  ====== ========   ====    ========    ===
  -      CONT PTE    PMD    CONT PMD    PUD
  ====== ========   ====    ========    ===
  4K:         64K     2M         32M     1G
  16K:         2M    32M          1G
  64K:         2M   512M         16G
  ====== ========   ====    ========    ===

in order to teach Sphinx where each column starts/stops, and
(optionally) show the table titles in bold.

(that's from Documentation/arm64/hugetlbpage.rst conversion)

> But exactly this - *having* to do rst formatting would mean a lot of
> getting used to and people writing something which is not necessarily
> correct rst and someone else fixing up after them.

Yeah, one has to take the conversion effort, but once done, it should be
easy to keep it updated.

> > and its html output is also nice (although Sphinx 1.7.8 seems to
> > have some issues when parsing some cells - probably due to some bug):
> > 
> > 	https://www.infradead.org/~mchehab/rst_conversion/x86/x86_64/mm.html  
> 
> I don't know how that looks in your browser but in mine those addresses
> are not in monospaced font and there's no properly reading them.
> 
> And yap, the cells parsing fun I see too.

Font selection is one of the things would require some markup, as a
plain text file doesn't have font changes.

There are several ways to make it use a monospaced font.

The straight forward way would be to place everything that it is
monospaced inside ``double quotes``, with is the ReST way to mark
a literal block inside a text. IMHO, that would add too much
"noise" at the tables.

Another possibility would be to do:

	.. raw:: html

	       <head><style>td { font-family: monospace, monospace; }</style></head>

(the double monospace here is not a mistake - it is due to a known
bug^H^H^Hfeature on some browsers[1])

[1] https://stackoverflow.com/questions/38781089/font-family-monospace-monospace

IMO, the best alternative would be to add a new class to the css file,
and use it whenever we need a table with monospaced font, e. g.:

diff --git a/Documentation/sphinx-static/theme_overrides.css b/Documentation/sphinx-static/theme_overrides.css
index e21e36cd6761..0948de6651f8 100644
--- a/Documentation/sphinx-static/theme_overrides.css
+++ b/Documentation/sphinx-static/theme_overrides.css
@@ -125,3 +125,7 @@ div[class^="highlight"] pre {
         color: inherit;
     }
 }
+
+table.monospaced {
+	font-family: monospace, monospace;
+}
diff --git a/Documentation/x86/x86_64/mm.rst b/Documentation/x86/x86_64/mm.rst
index e8a92fa0f9b2..704bad5c5130 100644
--- a/Documentation/x86/x86_64/mm.rst
+++ b/Documentation/x86/x86_64/mm.rst
@@ -18,6 +18,8 @@ Notes:
    notation than "16 EB", which few will recognize at first sight as 16 exabytes.
    It also shows it nicely how incredibly large 64-bit address space is.
 
+.. cssclass:: monospaced
+
 +-----------------+------------+------------------+---------+-----------------------------------------------------------+
 |   Start addr    |   Offset   |     End addr     |  Size   | VM area description                                       |
 +=================+============+==================+=========+===========================================================+

(patch on the top of this tree
https://git.linuxtv.org/mchehab/experimental.git/tree/Documentation/x86/x86_64/mm.rst?h=convert_rst_renames)

The ..cssclass:: markup on the above example will be applied just to
the table below it. So, with that, it is possible to have normal and
monospaced tables mixed (if you apply the above patch, you'll see
that just the first table will use monospaced fonts).

- 

Personally, I don't care much with monospaced fonts on this table. After
all, if I want to see it monospaced, I can simply click at the
"View page source" at the browser, and it will display the file as a
plain old monospaced text file.

Thanks,
Mauro
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
