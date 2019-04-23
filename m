Return-Path: <SRS0=UFM6=SZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F242C10F14
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 08:31:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC7920843
	for <iommu@archiver.kernel.org>; Tue, 23 Apr 2019 08:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QMvxp/Yn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC7920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CE858C84;
	Tue, 23 Apr 2019 08:31:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2A875C7F
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 08:31:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BDE77786
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Apr 2019 08:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mVbTPadcqfIC9mixerPpd69JlL1rVPk8BX8DnNvgvak=;
	b=QMvxp/Yn7DDeYn4Q66HX0xT9h
	Nx+1dJzHy0zvMv6Sc7H1o8Hdv9A+oVO2yGDbN+Wl84SH1Wcue9BDPxX7ij9wxf4BcO0fsp5pqmZ/r
	Q0IDOdOnkWVAJWHe3ntCgQkecqw/SAQp9ITZCcfSn7ZIcv1wvqX8NDg/PSDtlBOL+ZzvC1u1zpPEq
	2weTJXW3GJlzDqqlw1aNnQIHlM9y9SN94w3YPPuAMyy/w21z43jj61ho6nBNliXK98Q4bYdZH04XJ
	n0AkGQ7xdRb5ne3/nfoKdH6IvY6fRUBAPsMFnuI+P+39OX9+iWtEwL03nWgSlOgxTPcuCfGSjIyai
	MR8D3MB3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
	helo=hirez.programming.kicks-ass.net)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hIqq1-0007YP-Cg; Tue, 23 Apr 2019 08:31:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6323E29B47DC6; Tue, 23 Apr 2019 10:31:35 +0200 (CEST)
Date: Tue, 23 Apr 2019 10:31:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v2 56/79] docs: Documentation/*.txt: rename all ReST
	files to *.rst
Message-ID: <20190423083135.GA11158@hirez.programming.kicks-ass.net>
References: <cover.1555938375.git.mchehab+samsung@kernel.org>
	<cda57849a6462ccc72dcd360b30068ab6a1021c4.1555938376.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cda57849a6462ccc72dcd360b30068ab6a1021c4.1555938376.git.mchehab+samsung@kernel.org>
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
	Emese Revfy <re.emese@gmail.com>, Darren Hart <dvhart@infradead.org>,
	Jade Alglave <j.alglave@ucl.ac.uk>, "Serge E. Hallyn" <serge@hallyn.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Ning Sun <ning.sun@intel.com>, Borislav Petkov <bp@alien8.de>,
	Luc Maranget <luc.maranget@inria.fr>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Guan Xuetao <gxt@pku.edu.cn>, linux-parisc@vger.kernel.org,
	iommu@lists.linux-foundation.org, Stuart Hayes <stuart.w.hayes@gmail.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
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
Message-ID: <20190423083135.6W_TAcWPdDf5_w4U6P8F5l8yWntbpgpRhGzVxORPmu0@z>

On Mon, Apr 22, 2019 at 10:27:45AM -0300, Mauro Carvalho Chehab wrote:

>  .../{atomic_bitops.txt => atomic_bitops.rst}  |  2 +

What's happend to atomic_t.txt, also NAK, I still occationally touch
these files.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
