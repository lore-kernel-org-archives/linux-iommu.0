Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C61C10F03
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 20:08:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5101217D9
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 20:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EzZdj0Rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5101217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 84A9FE4A;
	Tue, 23 Apr 2019 20:08:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 51C5FE48
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 20:08:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 99137829
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 20:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209;
	h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fNfF1Op4WOz9r7cwOGdHULsoKlkdXOaOBxEXTjXZmBQ=;
	b=EzZdj0RnPoB5TYkqUDXbC7Hbi6
	VGvOQBvIr50BQnT5Ib9xJI45NeqyHgiwHBlAWnQKT9BqHt7FpdVaycpvuMj4ZAOmBgChyIzdCxim5
	lkQtwTgUzem6ijTQwUPXh7giNeY3oSIAbIPORizYJTM1HW90s1BzyWDJnWdl5e2w2OkUi6QTgbWyS
	aVvTwV7/eQ4gf1zkdHRKyRH8syMHcOwEfgDBhDV84qIzzn0W1RXWTDxo03OTdjadeWSGvjKatxo51
	ns3pI57qs+F7zySmtv7NjvOBZ89lTwO12so3X23ooHVMf7YT1i8z2UNwrb7AqD4tT20npkuHobEqR
	jOfD5Kgg==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231]
	helo=coco.lan)
	by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hJ1fY-0001BA-Np; Tue, 23 Apr 2019 20:05:33 +0000
Date: Tue, 23 Apr 2019 17:05:02 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 56/79] docs: Documentation/*.txt: rename all ReST
	files to *.rst
Message-ID: <20190423170409.7b1370ac@coco.lan>
In-Reply-To: <20190423172006.GD16353@zn.tnic>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
	<cda57849a6462ccc72dcd360b30068ab6a1021c4.1555938376.git.mchehab+samsung@kernel.org>
	<20190423083135.GA11158@hirez.programming.kicks-ass.net>
	<20190423125519.GA7104@redhat.com>
	<20190423130132.GT4038@hirez.programming.kicks-ass.net>
	<20190423103053.07cf2149@lwn.net>
	<20190423171158.GG12232@hirez.programming.kicks-ass.net>
	<20190423172006.GD16353@zn.tnic>
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
Message-ID: <20190423200502.Hy8cZz-DU8xSAoj-L41iMVU3SjT5SbEYoBeLF-8fbPw@z>

Em Tue, 23 Apr 2019 19:20:06 +0200
Borislav Petkov <bp@alien8.de> escreveu:

> On Tue, Apr 23, 2019 at 07:11:58PM +0200, Peter Zijlstra wrote:
> > I know I'm an odd duck; but no. They're _less_ accessible for me, as
> > both a reader and author. They look 'funny' when read as a text file
> > (the only way it makes sense to read them; I spend 99% of my time on a
> > computer looking at monospace text interfaces; mutt, vim and console, in
> > that approximate order).  
> 
> +1
> 
> It is probably fine to stare at them here
> https://www.kernel.org/doc/html/latest/ and the end result is good
> for showing them in browsers but after this conversion, it is
> getting more and more painful to work with those files. For example,
> Documentation/x86/x86_64/mm.txt we use a lot. I'd hate it if I had to go
> sort out rest muck first just so that I can read it.

That's my view about how that specific file would be after
converted to ReST:

	https://git.linuxtv.org/mchehab/experimental.git/tree/Documentation/x86/x86_64/mm.rst?h=convert_rst_renames

I don't have any troubles reading/understanding it as a plain text
file, and its html output is also nice (although Sphinx 1.7.8 seems to
have some issues when parsing some cells - probably due to some bug):

	https://www.infradead.org/~mchehab/rst_conversion/x86/x86_64/mm.html

> 
> I think we can simply leave some text files be text files and be done
> with it.

Changbin's approach was somewhat close to what you want. He simply
prepended the tables with ::, in order to show them as plain old
ascii:

	https://lore.kernel.org/lkml/20190423162932.21428-60-changbin.du@gmail.com/

Both equally works, from ReST conversion PoV. I'm fine ether way.

I prefer my approach, as, IMHO, it is visually nicer on both text and
html versions, but his approach is likely easier to maintain, as doing
ascii artwork by hand is sometimes painful.

Thanks,
Mauro
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
