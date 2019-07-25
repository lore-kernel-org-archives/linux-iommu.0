Return-Path: <SRS0=la/L=VW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653FDC76190
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 23:42:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F0420828
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 23:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhlQMRV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F0420828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2297FDC5;
	Thu, 25 Jul 2019 23:42:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 807BBDB9
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 23:42:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
	[209.85.214.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A20AA224
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 23:42:08 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id c14so23939090plo.0
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 16:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:content-transfer-encoding:in-reply-to
	:user-agent; bh=2GAKwzMUlP3WmD+pUyDwl1ISawmBP4193MDBqvqYky4=;
	b=nhlQMRV4GLFqDHbvHEVj927TPmOUDzCmyQAOPAhADKYhtD4vUWzxIqr2aX9vAbeZzl
	6UNddx7i8te7kDOGI5lPrVNTDf5YKgXxjfn1frBGFdt59mmme7SyfyGbK4g6Qbfh59Rh
	dmZb7w4twDQA8h23OhYaze90zTj09s1Gqf9xIO6OUAV+6aT34cWLmOPpQvXbwdaj8XQ4
	tpB/rgQ7VXgWieBv8a2/tHguSg58j0XsFK1hiG8GKVx6CcYqBM4/iV2C/SdVAS0GDYgt
	bnVF4Ag/VVGXD4jSolHNLGwZp5VjyCP1+flcLEs62i30q2ztxQUfHQqyQiuUDaEJ8zjF
	nrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=2GAKwzMUlP3WmD+pUyDwl1ISawmBP4193MDBqvqYky4=;
	b=WLAGEMiYNOUMBax2GxOW94gjQUseVL0dd1EdZXgVCjuvyRlBNHF88aVBJvnqmAuFwu
	um3X9HUQhiwp+aQFpaxEvrYtawVrgIKbt7UmN+sJo8PtRjCwIm9cmu0zXQZh0JJQjl+p
	mll5JWcgQM6ojSgQUFoL1oHKEC5ZC0ymUeBLJ08JWMPO39BgK8mr1+0A+VzsKNov3ykF
	/tqbB5lpftGOZWT6+/wLGRHK/9HP1JTUdFUbWP8N/cUtbH9m4JUvTyFI3NyXBHYXVrap
	XDHSadzQ6KJEUO7qy1eFEDBXSpndLDEVnbjHwO32DXtkSIL7lDr1Gf9aoq+BZaR3YW7b
	VVJA==
X-Gm-Message-State: APjAAAV1IQDf4ZsKe9slV8+90xt4xoSNb7HRMqfwdCTAtQe+qdA7M05m
	uq7srtInFVGeY1i4uMxcTos=
X-Google-Smtp-Source: APXvYqxmi/FzQIP8qaoABUPm3Xq2BFl14gHU3e414MTPj/K/JgQlbCdKyJCGGx3VBOTmJzmUKQDrtQ==
X-Received: by 2002:a17:902:20ec:: with SMTP id
	v41mr88146472plg.142.1564098128158; 
	Thu, 25 Jul 2019 16:42:08 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22])
	by smtp.gmail.com with ESMTPSA id u3sm44695365pjn.5.2019.07.25.16.42.07
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Jul 2019 16:42:07 -0700 (PDT)
Date: Thu, 25 Jul 2019 16:42:51 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Subject: Re: [PATCH v3 1/2] dma-contiguous: Abstract
	dma_{alloc,free}_contiguous()
Message-ID: <20190725234250.GA15714@Asurada-Nvidia.nvidia.com>
References: <20190524040633.16854-1-nicoleotsuka@gmail.com>
	<20190524040633.16854-2-nicoleotsuka@gmail.com>
	<CAAEAJfA+edVLfZzEZe98249Y7NZQFht9185JH21pV10Bq9Wk3w@mail.gmail.com>
	<20190725165015.GA31961@Asurada-Nvidia.nvidia.com>
	<1564075865.2339.6.camel@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1564075865.2339.6.camel@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, jcmvbkbc@gmail.com,
	hch@lst.de, sfr@canb.auug.org.au, dann.frazier@canonical.com,
	Russell King <linux@armlinux.org.uk>, hans.verkuil@cisco.com,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	treding@nvidia.com, linux-media@vger.kernel.org,
	linux-xtensa@linux-xtensa.org, keescook@chromium.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	chris@zankel.net, wsa+renesas@sang-engineering.com, robin.murphy@arm.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org, iamjoonsoo.kim@lge.com,
	David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, Jul 25, 2019 at 07:31:05PM +0200, Dafna Hirschfeld wrote:
> On Thu, 2019-07-25 at 09:50 -0700, Nicolin Chen wrote:
> > On Thu, Jul 25, 2019 at 01:06:42PM -0300, Ezequiel Garcia wrote:
> > > I can't find a way to forward-redirect from Gmail, so I'm Ccing Dafna
> > > who found a regression caused by this commit. Dafna, can you give all
> > > the details, including the log and how you are reproducing it?
> > =

> > I saw the conversation there. Sorry for not replying yet.
> > May we discuss there since there are full logs available?
> > =

> > Thanks
> > Nicolin
> > =

> =

> Hi,
> I compiled vivid as built-in into the kernel (not as a separate module) f=
or nitrogen8m device (imx8) and
> set it to use contig dma for mem_ops by adding the kernel param
> vivid.allocators=3D1,1,...
> =

> I use this devicetree patch for the dtb file: https://lkml.org/lkml/2019/=
7/24/789. Although it should
> be the same on any Aarch64 platform.
> =

> Then, on the board I run the command:
> =

> v4l2-ctl -d3 -v width=3D2592,height=3D1944,pixelformat=3DUYVY,bytesperlin=
e=3D5184 --stream-mmap --stream-to video.UYVY
> =

> In every run there is a different crash. Here is one of them: https://pas=
tebin.com/xXgbXMAN

This probably should be a fix: https://lkml.org/lkml/2019/7/25/1432

I also sent it to you. Would it be possible for you to test it?

Thanks
Nicolin

> =

> Dafna
> > > =

> > > =

> > > > > On Fri, 24 May 2019 at 01:08, Nicolin Chen <nicoleotsuka@gmail.co=
m> wrote:
> > > > =

> > > > Both dma_alloc_from_contiguous() and dma_release_from_contiguous()
> > > > are very simply implemented, but requiring callers to pass certain
> > > > parameters like count and align, and taking a boolean parameter to
> > > > check __GFP_NOWARN in the allocation flags. So every function call
> > > > duplicates similar work:
> > > > =A0 /* A piece of example */
> > > > =A0 unsigned long order =3D get_order(size);
> > > > =A0 size_t count =3D size >> PAGE_SHIFT;
> > > > =A0 page =3D dma_alloc_from_contiguous(dev, count, order, gfp & __G=
FP_NOWARN);
> > > > =A0 [...]
> > > > =A0 dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT);
> > > > =

> > > > Additionally, as CMA can be used only in the context which permits
> > > > sleeping, most of callers do a gfpflags_allow_blocking() check and
> > > > a corresponding fallback allocation of normal pages upon any false
> > > > result:
> > > > =A0 /* A piece of example */
> > > > =A0 if (gfpflags_allow_blocking(flag))
> > > > =A0=A0=A0=A0=A0=A0page =3D dma_alloc_from_contiguous();
> > > > =A0 if (!page)
> > > > =A0=A0=A0=A0=A0=A0page =3D alloc_pages();
> > > > =A0 [...]
> > > > =A0 if (!dma_release_from_contiguous(dev, page, count))
> > > > =A0=A0=A0=A0=A0=A0__free_pages(page, get_order(size));
> > > > =

> > > > So this patch simplifies those function calls by abstracting these
> > > > operations into the two new functions: dma_{alloc,free}_contiguous.
> > > > =

> > > > As some callers of dma_{alloc,release}_from_contiguous() might be
> > > > complicated, this patch just implements these two new functions to
> > > > kernel/dma/direct.c only as an initial step.
> > > > =

> > > > > > > Suggested-by: Christoph Hellwig <hch@lst.de>
> > > > > > > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > > > ---
> > > > Changelog
> > > > v2->v3:
> > > > =A0* Added missing "static inline" in header file to fix build erro=
r.
> > > > v1->v2:
> > > > =A0* Added new functions beside the old ones so we can replace call=
ers
> > > > =A0=A0=A0one by one later.
> > > > =A0* Applied new functions to dma/direct.c only, because it's the b=
est
> > > > =A0=A0=A0example caller to apply and should be safe with the new fu=
nctions.
> > > > =

> > > > =A0include/linux/dma-contiguous.h | 11 ++++++++
> > > > =A0kernel/dma/contiguous.c=A0=A0=A0=A0=A0=A0=A0=A0| 48 ++++++++++++=
++++++++++++++++++++++
> > > > =A0kernel/dma/direct.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0| 24 +++-=
-------------
> > > > =A03 files changed, 63 insertions(+), 20 deletions(-)
> > > > =

> > > > diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-con=
tiguous.h
> > > > index f247e8aa5e3d..00a370c1c140 100644
> > > > --- a/include/linux/dma-contiguous.h
> > > > +++ b/include/linux/dma-contiguous.h
> > > > @@ -115,6 +115,8 @@ struct page *dma_alloc_from_contiguous(struct d=
evice *dev, size_t count,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0unsigned int order, bool=
 no_warn);
> > > > =A0bool dma_release_from_contiguous(struct device *dev, struct page=
 *pages,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0int count);
> > > > +struct page *dma_alloc_contiguous(struct device *dev, size_t size,=
 gfp_t gfp);
> > > > +void dma_free_contiguous(struct device *dev, struct page *page, si=
ze_t size);
> > > > =

> > > > =A0#else
> > > > =

> > > > @@ -157,6 +159,15 @@ bool dma_release_from_contiguous(struct device=
 *dev, struct page *pages,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0return false;
> > > > =A0}
> > > > =

> > > > +static inline
> > > > +struct page *dma_alloc_contiguous(struct device *dev, size_t size,=
 gfp_t gfp)
> > > > +{
> > > > +=A0=A0=A0=A0=A0=A0=A0return NULL;
> > > > +}
> > > > +
> > > > +static inline
> > > > +void dma_free_contiguous(struct device *dev, struct page *page, si=
ze_t size) { }
> > > > +
> > > > =A0#endif
> > > > =

> > > > =A0#endif
> > > > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > > > index b2a87905846d..21f39a6cb04f 100644
> > > > --- a/kernel/dma/contiguous.c
> > > > +++ b/kernel/dma/contiguous.c
> > > > @@ -214,6 +214,54 @@ bool dma_release_from_contiguous(struct device=
 *dev, struct page *pages,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0return cma_release(dev_get_cma_area(dev), p=
ages, count);
> > > > =A0}
> > > > =

> > > > +/**
> > > > + * dma_alloc_contiguous() - allocate contiguous pages
> > > > + * @dev:=A0=A0=A0Pointer to device for which the allocation is per=
formed.
> > > > + * @size:=A0=A0Requested allocation size.
> > > > + * @gfp:=A0=A0=A0Allocation flags.
> > > > + *
> > > > + * This function allocates contiguous memory buffer for specified =
device. It
> > > > + * first tries to use device specific contiguous memory area if av=
ailable or
> > > > + * the default global one, then tries a fallback allocation of nor=
mal pages.
> > > > + */
> > > > +struct page *dma_alloc_contiguous(struct device *dev, size_t size,=
 gfp_t gfp)
> > > > +{
> > > > +=A0=A0=A0=A0=A0=A0=A0int node =3D dev ? dev_to_node(dev) : NUMA_NO=
_NODE;
> > > > +=A0=A0=A0=A0=A0=A0=A0size_t count =3D PAGE_ALIGN(size) >> PAGE_SHI=
FT;
> > > > +=A0=A0=A0=A0=A0=A0=A0size_t align =3D get_order(PAGE_ALIGN(size));
> > > > +=A0=A0=A0=A0=A0=A0=A0struct cma *cma =3D dev_get_cma_area(dev);
> > > > +=A0=A0=A0=A0=A0=A0=A0struct page *page =3D NULL;
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0/* CMA can be used only in the context which =
permits sleeping */
> > > > +=A0=A0=A0=A0=A0=A0=A0if (cma && gfpflags_allow_blocking(gfp)) {
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0align =3D min_t(size_=
t, align, CONFIG_CMA_ALIGNMENT);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0page =3D cma_alloc(cm=
a, count, align, gfp & __GFP_NOWARN);
> > > > +=A0=A0=A0=A0=A0=A0=A0}
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0/* Fallback allocation of normal pages */
> > > > +=A0=A0=A0=A0=A0=A0=A0if (!page)
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0page =3D alloc_pages_=
node(node, gfp, align);
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0return page;
> > > > +}
> > > > +
> > > > +/**
> > > > + * dma_free_contiguous() - release allocated pages
> > > > + * @dev:=A0=A0=A0Pointer to device for which the pages were alloca=
ted.
> > > > + * @page:=A0=A0Pointer to the allocated pages.
> > > > + * @size:=A0=A0Size of allocated pages.
> > > > + *
> > > > + * This function releases memory allocated by dma_alloc_contiguous=
(). As the
> > > > + * cma_release returns false when provided pages do not belong to =
contiguous
> > > > + * area and true otherwise, this function then does a fallback __f=
ree_pages()
> > > > + * upon a false-return.
> > > > + */
> > > > +void dma_free_contiguous(struct device *dev, struct page *page, si=
ze_t size)
> > > > +{
> > > > +=A0=A0=A0=A0=A0=A0=A0if (!cma_release(dev_get_cma_area(dev), page,=
 size >> PAGE_SHIFT))
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0__free_pages(page, ge=
t_order(size));
> > > > +}
> > > > +
> > > > =A0/*
> > > > =A0 * Support for reserved memory regions defined in device tree
> > > > =A0 */
> > > > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > > > index 2c2772e9702a..0816c1e8b05a 100644
> > > > --- a/kernel/dma/direct.c
> > > > +++ b/kernel/dma/direct.c
> > > > @@ -96,8 +96,6 @@ static bool dma_coherent_ok(struct device *dev, p=
hys_addr_t phys, size_t size)
> > > > =A0struct page *__dma_direct_alloc_pages(struct device *dev, size_t=
 size,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dma_addr_t *dma_han=
dle, gfp_t gfp, unsigned long attrs)
> > > > =A0{
> > > > -=A0=A0=A0=A0=A0=A0=A0unsigned int count =3D PAGE_ALIGN(size) >> PA=
GE_SHIFT;
> > > > -=A0=A0=A0=A0=A0=A0=A0int page_order =3D get_order(size);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0struct page *page =3D NULL;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0u64 phys_mask;
> > > > =

> > > > @@ -109,20 +107,9 @@ struct page *__dma_direct_alloc_pages(struct d=
evice *dev, size_t size,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0gfp |=3D __dma_direct_optimal_gfp_mask(dev,=
 dev->coherent_dma_mask,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0&phys_mask);
> > > > =A0again:
> > > > -=A0=A0=A0=A0=A0=A0=A0/* CMA can be used only in the context which =
permits sleeping */
> > > > -=A0=A0=A0=A0=A0=A0=A0if (gfpflags_allow_blocking(gfp)) {
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0page =3D dma_alloc_fr=
om_contiguous(dev, count, page_order,
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0gfp & __GFP_NOWARN);
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (page && !dma_cohe=
rent_ok(dev, page_to_phys(page), size)) {
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0dma_release_from_contiguous(dev, page, count);
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0page =3D NULL;
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > > -=A0=A0=A0=A0=A0=A0=A0}
> > > > -=A0=A0=A0=A0=A0=A0=A0if (!page)
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0page =3D alloc_pages_=
node(dev_to_node(dev), gfp, page_order);
> > > > -
> > > > +=A0=A0=A0=A0=A0=A0=A0page =3D dma_alloc_contiguous(dev, size, gfp);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0if (page && !dma_coherent_ok(dev, page_to_p=
hys(page), size)) {
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0__free_pages(page, pa=
ge_order);
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dma_free_contiguous(d=
ev, page, size);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0page =3D NULL;
> > > > =

> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (IS_ENABLED(CONF=
IG_ZONE_DMA32) &&
> > > > @@ -154,7 +141,7 @@ void *dma_direct_alloc_pages(struct device *dev=
, size_t size,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0if (PageHighMem(page)) {
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/*
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0* Depending on t=
he cma=3D arguments and per-arch setup
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0* dma_alloc_from_c=
ontiguous could return highmem pages.
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0* dma_alloc_contig=
uous could return highmem pages.
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0* Without remapp=
ing there is no way to return them here,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0* so log an erro=
r and fail.
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*/
> > > > @@ -176,10 +163,7 @@ void *dma_direct_alloc_pages(struct device *de=
v, size_t size,
> > > > =

> > > > =A0void __dma_direct_free_pages(struct device *dev, size_t size, st=
ruct page *page)
> > > > =A0{
> > > > -=A0=A0=A0=A0=A0=A0=A0unsigned int count =3D PAGE_ALIGN(size) >> PA=
GE_SHIFT;
> > > > -
> > > > -=A0=A0=A0=A0=A0=A0=A0if (!dma_release_from_contiguous(dev, page, c=
ount))
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0__free_pages(page, ge=
t_order(size));
> > > > +=A0=A0=A0=A0=A0=A0=A0dma_free_contiguous(dev, page, size);
> > > > =A0}
> > > > =

> > > > =A0void dma_direct_free_pages(struct device *dev, size_t size, void=
 *cpu_addr,
> > > > --
> > > > 2.17.1
> > > > =

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
