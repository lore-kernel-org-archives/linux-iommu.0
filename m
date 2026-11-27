Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=139.138.37.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795768380;
	b=KDIUy1+agE5725idq6zACtdjyJBGdQdvFKj1wUANFIwycjyEIAzYaMXD6D1gmm65Al/0
	 guR4QE34WA5nxNMw+fOAni+u7tcWsp/kK6RSCdoanYy2SlRIbFwveJmNiwccVt4AcVpKC
	 iK1+1+YA/tHkYWeLUwUEiCln7U4920sTBNOrqrJD2mefOdWMfKtYmmocp+IOneQIA7ve3
	 C4/FR5XSbNQD6Gy+MXTFYKl2J4hpPtm3bnfjAhSnBvhpPRqx23KR7vPubFG080bkgSTxD
	 nlIZuvFAZezOp8/P6XNIsdBaUseHwMwgdnA3i4WtmI+dAChJrduEP9Or+jL0GyLy5kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795768380;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=x7T2hvQbWIwodUQErSaaCwrbt5ZR0SaoWTUBnFNg5fA=;
	b=TiPj6D7Zlah17eZVf35zz2WcNTqesi5UtBGkxU0Ok+anuCvS4JWY2GNXN8RFMg463hQ1
	 nAiGXTf4YRboRwQnD9PZeCvIZHRSMih/J1ufqDw7v6gCPpEbsrN2dB5qOovSro7vtgMrC
	 Oafom8FD83WPX5MFn2/GYyiaIatS9f89jvnuSHw9sidWqO5GjARNKLh+iKSmJ4szCE9m7
	 MQKePO4NeyPUyuJGLg1TGJx4i0a1sOJ5kSd6kIjrxNEbUuhhG40OxfRA78dH02i/a6+6B
	 v1UbxFymVlemZvEpX0oYBL69CjDIOkph9TyL5rD/la5GsWtD7cN3XzaI78Rd4O/C5ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=Swf+ci1q;
	arc=none smtp.remote-ip=139.138.37.100
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B00606A323
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 08:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57B00606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=Swf+ci1q
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1795768379; x=1827304379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ImbUcSS8Q6xOASEFymtw22SRZBZBBDi6HTSnPwkGl+s=;
  b=Swf+ci1qpuk6l/o5dMuF019GxotmipzbLFNlAozGaL1kdRUsjPFg0eRu
   WOI0Bk5mj1L2TXHPTbDBkkzN/WTpvSWHtHCeT19SPiOphoHNAaEXuHaMM
   J9g5MuK3TBcWouOEZ+VO2UxAqOuGe0tGkhiMGAsnyh9TBPehyQKPzsi6P
   +UnqgVKxFNr3uTStC58K5mC3vHFAoue8oFSP4WOPgMlxMSrWrL8Ps2/Dl
   oqvBx2NwnOrnFpmaZmQgyGxkrL6/szxAdgo5e8OheKtdCmKGS4gVriV6+
   z+1OcTBeqNyIYNLUhNbRO7XPdBhjd01h7j8NAzSvufXE1EpKw/iOEYPFT
   g==;
X-CSE-ConnectionGUID: bU1y8QYTTn+n62E49WySmg==
X-CSE-MsgGUID: HOx+3H+jSPyNnv1t7UH2FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="241071014"
X-IronPort-AV: E=Sophos;i="6.27,236,1786978800"; 
   d="scan'208";a="241071014"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 17:32:52 +0900
Received: from az2uksmgm4.o.css.fujitsu.com (unknown [10.151.22.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 727CB1C0169A
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 08:32:52 +0000 (UTC)
Received: from az2uksmom2.o.css.fujitsu.com (unknown [10.151.22.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm4.o.css.fujitsu.com (Postfix) with ESMTPS id 2780A1400632
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 08:32:52 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.8.69.152])
	by az2uksmom2.o.css.fujitsu.com (Postfix) with SMTP id 4F4DA14063B5;
	Fri, 27 Nov 2026 08:32:49 +0000 (UTC)
Date: Fri, 27 Nov 2026 17:32:47 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
Message-ID: <awk97nvn_HKgONmF@FCCLS0092175.localdomain>
References: <asYZFXGyafRjjBS0@arm.com>
 <asYiOgskwi8JYLe_@willie-the-truck>
 <yq5awlrt3dwo.fsf@kernel.org>
 <yq5av77c92oo.fsf@kernel.org>
 <aseRzPshcoys7AJS@arm.com>
 <yq5ao6d48dqr.fsf@kernel.org>
 <auR0fT1yrKQ9wbm8@FCCLS0092175.localdomain>
 <yq5a8q3d9oe6.fsf@kernel.org>
 <avRKiCBs81XSYMqW@FCCLS0092175.localdomain>
 <yq5a33t6qrvc.fsf@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <yq5a33t6qrvc.fsf@kernel.org>

On 11/12 15:43, Aneesh Kumar K.V wrote:
> Kohei Enju <enju.kohei@fujitsu.com> writes:
> 
> > Hi Aneesh,
> >
> > On 11/01 09:47, Aneesh Kumar K.V wrote:
> > [...]
> >> >
> >> > Hi Aneesh,
> >> >
> 
>  [ ... 35 lines skipped ... ] 
> 
> > Overall, I would prefer the dynamic sizing approach. However, I believe
> > the initial pool size still matters.
> >
> > Also, as Catalin pointed out earlier in the following message:
> >
> >     https://lore.kernel.org/all/ann6noRzoPLL9kDY@arm.com/
> >
> > the arm64 adjustment also reduces the target size used for dynamic
> > pool allocation, since both the initial pool and dynamic allocation
> > currently use default_nslabs.
> >
> > I am testing the patch below to decouple the initial pool size from the
> > dynamic allocation target. It adds swiotlb_adjust_initial_size() for
> > callers that only want to reduce the initial allocation, while keeping
> > the existing swiotlb_adjust_size() semantics for callers that want to
> > adjust both sizes.
> >
> 
> Should we instead update the logic so that reducing the swiotlb size
> leaves the dynamic allocation size unchanged, while increasing it also
> bumps the dynamic allocation size?

Sorry for the late response.

That makes sense for the arm64 and RISC-V cases. However, for
plat_swiotlb_setup() in arch/mips/cavium-octeon/dma-octeon.c, I'm not
sure whether we also want to preserve the dynamic allocation target when
reducing the initial pool size.

Do we want that change on Octeon too? If not, I'd prefer a separate API
so that we can preserve the existing behavior and explicitly update only
the callers that need to reduce the initial pool size independently of
the dynamic allocation target.

Thanks,
Kohei
