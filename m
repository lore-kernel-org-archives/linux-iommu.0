Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD187C10F03
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 15:10:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8545F2175B
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 15:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gyKu5faS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8545F2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5C049C2A;
	Tue, 23 Apr 2019 15:10:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6811EB5F
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 15:10:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 83609F4
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 15:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209;
	h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v9zySKYYnsu0nbBdMLtJbdq2RS3FMjAkeykZUsZvTiE=;
	b=gyKu5faSS8LXZj9XRJouMiBZjU
	XASolTJePGoBvpLeRtOGD0Jds+L4YqC+8mg1+4Vph7aht+DxgdLkMxSAS2K3rSjLCE/1unPCcHKY8
	8CAOq3FvxVhpblpl0otlgX9obPFwANUBjaE2t9wg0sWYYW+hJ+SD7ycBWE9eE1TObd1ngU9LvxnhO
	N0lZ6kKQx/ikRpAVnOMB2YMjubYbDUC7KXLHGrFGORjQWON1e6rDXUBfbz2NkYEw6XHzvaqT5Mu2F
	9O3mBn4OFlBZqhCyQ1xTEMa8W9XVSpJQ3FIjY11bKB5UDyy8Mjbl7Mjm/Dvf5rlA6y1ixusUDLklF
	4uUQN6Nw==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
	helo=coco.lan)
	by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hIx1l-0006YJ-P6; Tue, 23 Apr 2019 15:08:10 +0000
Date: Tue, 23 Apr 2019 12:07:38 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH v2 56/79] docs: Documentation/*.txt: rename all ReST
	files to *.rst
Message-ID: <20190423120738.3be8337e@coco.lan>
In-Reply-To: <20190423132100.GB7132@redhat.com>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
	<cda57849a6462ccc72dcd360b30068ab6a1021c4.1555938376.git.mchehab+samsung@kernel.org>
	<20190423083135.GA11158@hirez.programming.kicks-ass.net>
	<20190423125519.GA7104@redhat.com>
	<20190423130132.GT4038@hirez.programming.kicks-ass.net>
	<20190423132100.GB7132@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
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
	Eric Farman <farman@linux.ibm.com>,
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
	Ning Sun <ning.sun@intel.com>, Borislav Petkov <bp@alien8.de>,
	Luc Maranget <luc.maranget@inria.fr>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Guan Xuetao <gxt@pku.edu.cn>, linux-parisc@vger.kernel.org,
	iommu@lists.linux-foundation.org, Stuart Hayes <stuart.w.hayes@gmail.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>,
	Rich Felker <dalias@libc.org>, kvm@vger.kernel.org,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Jerry Hoemann <jerry.hoemann@hpe.com>,
	David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
	Kirti Wankhede <kwankhede@nvidia.com>, "H.
	Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
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
Message-ID: <20190423150738.xkCBkhS0cGrOPpUQhMfTcrOUAeYnPUdIrZ69Z89QQ0g@z>

Em Tue, 23 Apr 2019 09:21:00 -0400
Mike Snitzer <snitzer@redhat.com> escreveu:

> On Tue, Apr 23 2019 at  9:01am -0400,
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, Apr 23, 2019 at 08:55:19AM -0400, Mike Snitzer wrote:  
> > > On Tue, Apr 23 2019 at  4:31am -0400,
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > >   
> > > > On Mon, Apr 22, 2019 at 10:27:45AM -0300, Mauro Carvalho Chehab wrote:
> > > >   
> > > > >  .../{atomic_bitops.txt => atomic_bitops.rst}  |  2 +  
> > > > 
> > > > What's happend to atomic_t.txt, also NAK, I still occationally touch
> > > > these files.  
> > > 
> > > Seems Mauro's point is in the future we need to touch these .rst files
> > > in terms of ReST compatible changes.
> > > 
> > > I'm dreading DM documentation changes in the future.. despite Mauro and
> > > Jon Corbet informing me that ReST is simple, etc.  

ReST is simple[1], and neither Jon or me wants to burden developers to
use complex documents all over the Kernel tree. ReST is just a way to 
make the documents with similar visual. The main advantage of ReST is
that documents can be better organized, as they will be inside some
index.rst file.

[1] Ok, as any document, you could write an easy or hard to read stuff.
The way we're using on most places is to be just a coding style with
benefits. I wrote a quick 101 guide to ReST at the end, with all you
probably need to know about it.

So, for example, in the specific case of atomic_bitops, all it takes for
it to be parsed by Sphinx is to rename it to .rst. With that, it can be
added into an index.rst file, like at Documentation/driver-api/index.rst.

The document, as is, will be displayed like this:

	https://www.infradead.org/~mchehab/rst_conversion/driver-api/atomic_bitops.html?highlight=atomic_t

And the original text file can also be seen from the output data:

	https://www.infradead.org/~mchehab/rst_conversion/_sources/driver-api/atomic_bitops.rst.txt

> > 
> > Well, it _can_ be simple, I've seen examples of rst that were not far
> > from generated HTML contents. And I must give Jon credit for not
> > accepting that atrocious crap.
> > 
> > But yes, I have 0 motivation to learn or abide by rst. It simply doesn't
> > give me anything in return. There is no upside, only worse text files :/  
> 
> Right, but these changes aren't meant for our benefit.  They are for
> users who get cleaner web accessible Linux kernel docs.  Seems the
> decision has been made that the users' benefit, and broader
> modernization of Linux docs, outweighs the inconvenience for engineers
> who maintain the content of said documentation.

> This kind of thing happens a lot these days: pile on engineers, they can
> take it :/

Yes, that's the main goal: ensure that more people will see the
documents and write less crappy code. So, overall, reducing the
time we spent with reviews of bad code.


----

=================================
My 101 ReST quick reference guide
=================================

Basically, a "quick" ReST guide for those that don't want to learn it
and like to have an easy to read text document would be

1) to format documents like:

	=========
	Doc Title
	=========

	foo chapter
	===========

	bar section
	-----------

	foobar sub-section
	^^^^^^^^^^^^^^^^^^

	foobarzeta sub-sub-section
	..........................

(the actual character used to mark the titles can be different,
provided that you use the same character for the same title
level - the above is just the way *I* use, as it makes easier for
me to remember the title level).

2) remember that ReST considers new lines with same indentation as
   belonging to the same paragraph. So,

	foo
	bar

is identical to:

	foo bar

while
	foo
	   bar

will make "foo" bold, and write bar on the next line. So, if you
want to have them on two separate lines on its output, it should
be either write it as:

	foo

	bar

or you could use a list:

	- foo
	- bar

Btw, *a lot* of Kernel documents already have the above format.

3) literal values should be either inside ``foo``, `foo` or on an
   indented line after a ::, like:

	example::

		# some_command_to_be_typed

If you follow those three simple rules, your document will be properly
parsed. The above covers 90% of what we normally use.

Tables are also easy to write there, as it recognizes two ways to write
ascii tables, with are already popular ways to write them.

So, those are valid tables:

Without a title:

	===   ===============
	foo   foo description
	bar   bar description
	===   ===============


	+-------+-----------------+
	| foo   | foo description |
	+-------+-----------------+
	| bar   | bar description |
	+-------+-----------------+

(both will produce exactly the same output)

With a title:

	===== ===============
	field description
	===== ===============
	foo   foo description
	bar   bar description
	===   ===============

	+-------+-----------------+
	| field | description     |
	+=======+=================+
	| foo   | foo description |
	+-------+-----------------+
	| bar   | bar description |
	+-------+-----------------+

(both will produce exactly the same output)

This is not too different on what we usually do on documents - except that
some documents sometimes use UTF8, or a different character set to mark the
table lines. So the "conversion" is simply to follow one of the above
styles.

Thanks,
Mauro
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
