Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6C4399F8;
	Mon, 14 Sep 2026 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789382364; cv=none; b=c1QSSBL9ku9ovqKQ8v1pyZoNOTErl9k2uu+fzGbjiekUY288P50gdEkzwhUratOJFTkdArN7IDvjQEH9RL1e1QUklieJip90B3rpqHiSW4bZotId2kuOLVpVo1zt5ZB5/uE3KOjPB3vh01DUCEMOuH0ZDbb/npVNJEhYrdS+7PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789382364; c=relaxed/simple;
	bh=Zps+9Wi6caDEuSi0rGtQ0cNlmnd/6KRwXM3+kvWAoKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di+K1TwlnGufRQEWPJk9CboTp2hvGXqZ9O388HjPlFmTNQmZ8cjgu64D41XeAXrrrv/ickycVw36qkRLdeB/ZUguS3ra7P15fRSZCaB9EkU3oZlGix1ZHrGA09IPJKhOT2ewjYIlsl7q9NudtgsPR4DsUE4Pvk6KResNhziV8D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=NxrC7vsf; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="NxrC7vsf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X+yUjOW/SjFiacu+4MTIUll3EvJZVdDjg7M5mV1xjPI=; b=NxrC7vsf0hgo/xProYwLCwq+gf
	VXcw3rISGt2u3FWr4ZCKbxxxp7U6O7cCEUqpPD9zoGdnutjPML8JwYzpU2ORxsIhMSb79HMgj2USV
	40nuKs2uak5kvOyKatMe0m3hEIaESOtCrfIx5j3GQvgjPTb4wjSLKtA4xy3UOuCpTE7R3bxZmVKWy
	vW6PINsXIhs4a7juDttbAYGT9swGjHjZ/XR8mcdCoBSagRbb5/fd7H18UsvXbrufmuasCnlTt6F5D
	oyKjaATE95SDZ5Gy6eBawGPn3FtnQf4xqT/XvvoZ6Pb0+BuRW7MoFN5gKJhwrMrvmg0Fk9esz97zH
	JcPevA7A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x645e-003Yd7-2b;
	Mon, 14 Sep 2026 10:39:11 +0000
Date: Mon, 14 Sep 2026 03:39:06 -0700
From: Breno Leitao <leitao@debian.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, catalin.marinas@arm.com, mark.rutland@arm.com, 
	puranjay@kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rmikey@meta.com, kernel-team@meta.com
Subject: Re: [PATCH 0/2] iommu/arm-smmu-v3: SMMU hitting kdump mid-air
Message-ID: <aqfOKGiElMz1YX6N@gmail.com>
References: <20260911-smmu_fix_aws-v1-0-75870bf9655b@debian.org>
 <aqSBQKDoUTy/l2d7@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqSBQKDoUTy/l2d7@nvidia.com>
X-Debian-User: leitao

On Fri, Sep 11, 2026 at 03:31:28PM -0700, Nicolin Chen wrote:
> On Fri, Sep 11, 2026 at 07:54:43AM -0700, Breno Leitao wrote:
> > My lovely robot and I came with two patches that solved the problem,
> > from a practical perspective and I want to share what has been tested.
> > 
> > Patch 1 carries the previous kernel's L1 descriptors into the new KDUMP table, so
> > those streams keep translating.
> > 
> > Patch 2 stops the core discarding that again: iommu_dma_init() already
> > enables deferred attach for a capture kernel, but the core only honours
> > it for drivers implementing .is_attach_deferred, which until now meant
> > amd and intel. Without it iommu_setup_default_domain() attaches
> > a default domain at probe and the fault returns as F_TRANSLATION.
> > 
> > The x86 IOMMU drivers solve the same/similar problem the same way; see
> > commit 38e5f33ee3596 ("iommu/amd: Reuse device table for kdump").
> 
> This looks like my bigger series:
> https://lore.kernel.org/linux-iommu/cover.1788130528.git.nicolinc@nvidia.com/
> 
> Would you please help check/test?

Tested, and it fixes the problem on Meta kdump kernel. Thanks for the message.
I am dropping my two patches in favour of your series.

Test it on AWS Graviton EC2 metal, 96 cores, two ENA NICs at
0003:2c:00.0 and 0003:2d:00.0. When the kernel crashes the NICs keep
bus-mastering, and the capture kernel builds a stream table with no L1
descriptor for the ENA's StreamID 0x32d00, so that DMA raises
C_BAD_STREAMID. 

Patch 11 is what makes the difference for us. "SMMU currently enabled!
Resetting..." opens every failed capture boot we have on record, and it
does not appear at all with your series applied.

Tested-by: Breno Leitao <leitao@kernel.org>
