Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26FF295DAC
	for <iommu@lists.linux.dev>; Mon,  9 Feb 2026 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770651342; cv=none; b=PRkUOgnVDQaPSrQzieDpCFyksGuID/VKEbGRGa0Nvli4aGSndSNsCAzuY6dqeSG0PDs3nv7ra3bSp2rY2gQAjusD1Vsdpv4eJ+GLSsVDd3wGtALMGRaMbMHD98j2LIoT1qBGMJOIu6kOgy70DamQHNVBO0uMxPe2fNaJNP+e12w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770651342; c=relaxed/simple;
	bh=U15/F91JTKEekYShyiR6dUHXzcOCFPKVIlg/bRPTaAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f22YGEh6/xobCZycQiNMPr+Tdmd0Vhp9lgYvskRZZHWgP8OpwLMk/S/etOWcAWNipxysMmVZLh+N5qjaJcQDgIDXPm5m8rlFEoe/tXxNSD+XGPsYPCNSLQJ7qlL+rCUAN2ewgH0a9bBDs2ShSAumKUkp1Hxzoq5VXw45D8fUIOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BZAfX8oe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BZAfX8oe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770651340;
	bh=U15/F91JTKEekYShyiR6dUHXzcOCFPKVIlg/bRPTaAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BZAfX8oeM74obJfB9jbkW5ibDvMSdYszm/4kicoQIfE7r7NQx378ig4ngcSNN7OQF
	 NJaoHq6H56xEzf0KJYHWe8CzU2T7owLlCNGO2zINtknrR81jP7rW2gw8sX9WzqpECc
	 u+gz4Cxq6w38fmMg3/gzFnYCHEeaSgHlWiBedFn0jtw8O5LC2d4LWXOaDskn5VUZ5f
	 ojRlSJL2jT95WK4kG4Ipg3n3eGwBlHX8XRpweiulTl1BLWNA+SYZWMAt1q6sP5oCQx
	 xjdUNiThoYONG4rCZO6J29fEqsqYyprXGK+IJvzvlOTwBcXq9aGAGxsNpMZvc+U0X9
	 82mMJKT+6bLVg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A441117E0699;
	Mon,  9 Feb 2026 16:35:39 +0100 (CET)
Date: Mon, 9 Feb 2026 16:35:34 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Steven Price <steven.price@arm.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Rob
 Clark <robin.clark@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Karunika Choo <karunika.choo@arm.com>, Liviu
 Dudau <liviu@dudau.co.uk>
Subject: Re: [RFC PATCH] iommu/io-pgtable: Add support for Arm Mali v10+
 GPUs page table format
Message-ID: <20260209163534.45b0ec7a@fedora>
In-Reply-To: <aYn7obNImaI72MhK@e142607>
References: <20260209112542.194140-1-liviu.dudau@arm.com>
	<0af5b5f3-912a-4f16-a68b-032617576537@arm.com>
	<aYngwtq_GtBYGjOC@e142607>
	<ac5c3df0-1d94-4a1c-9eec-a359096cfce5@arm.com>
	<aYn7obNImaI72MhK@e142607>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Feb 2026 15:22:09 +0000
Liviu Dudau <liviu.dudau@arm.com> wrote:

> > > Ultimately the role of this RFC is to start a discussion and to figure out a path
> > > forward for CSF GPUs where we want now to tighen a bit the formats we support and
> > > add PBHA and in the future we want to add support for v15+ page formats.  
> > 
> > PBHA is definitely an area for discussion. AIUI there are out-of-tree
> > patches floating about for CPU support, but it hasn't been upstreamed. I
> > don't know if any serious attempt has been made to push it upstream, but
> > it's tricky because the architecture basically just says "IMPLEMENTATION
> > DEFINED" which means you are no longer coding to the architecture but a
> > specific implementation - and there's remarkably little documentation
> > about what PBHA is used for in practice.
> > 
> > I haven't looked into the GPU situation with PBHA - again it would be
> > good to have more details on how the bits would be set.  
> 
> I have a patch series that adds support in Panthor to apply some PBHA bits defined
> in the DT based on an ID also defined in the DT and passed along as a VM_BIND parameter
> if you want to play with it. However I have no direct knowledge on which PBHA values
> would make a difference on the supported platforms (RK3xxx for example).

I don't know if that's what it's going be used for, but one very
specific use case I'd like to see this PBHA extension backed by is
"read-zero/write-discard" behavior that's needed for sparse bindings.
Unfortunately, I've not heard on any HW-support for that in older
gens...
