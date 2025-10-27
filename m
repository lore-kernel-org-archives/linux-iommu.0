Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47F32FE076
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 11:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565566; cv=none; b=k26qd0xbjyOb+vYrS3o+pgRBeF2zmB1t/M1x0PCc7Q7egs59ZrWC9sRCZisdreHa+lhyf92qBWVXP4RXFEmLm8UiQNz7zYGXglwKBwIE35U8D/Fme0L79YVQadsCQEs6loEBbmfne230Gi+KiMV6KYb4IiWpNmVcmKrKdxL3se0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565566; c=relaxed/simple;
	bh=0kFQ3vvotzBg63RutfyUDjSc729Pvux23b7TJTDNuI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3H/r8Bb6fBI96OY1A4BFKqfrfYBg29pDMGpw3jllR52orTCf6L4EaQ+gFiGNDHWDvnrewdtO+FgJYwkslp5bqpy9KgP8i4Sgt0yQIPz7dlWSvdN2RBLkSPZdNGQas8Ke7g3MxFGsObAJrMx2lJAC+n60iEMkKwseC5a0BMCMVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=b3xKaH3H; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="b3xKaH3H"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6712359947;
	Mon, 27 Oct 2025 12:46:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1761565563;
	bh=0kFQ3vvotzBg63RutfyUDjSc729Pvux23b7TJTDNuI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b3xKaH3HIudsEnOPgSqaPsxNHCv9VETGXSvTt3can61L0gC0FNaMQ/HyGWLblVxA3
	 txbYg9DFCxLEFFAtT4pKKju3Fmc4dGtOkPpX/GYPwTk3102HYnqfE757wa20vkD2Oz
	 dL6ZKWVy0WvmtbbhxTchW+b9gMz1surolQgcgEvMSSGplxLiS5t6rHpAwWx1g+A2ZH
	 YP1KzLYZt+BOVBBC8j1a9h2lBoHR6nZMYhMYA77Or6QMl4fgwgBBH0Lj907vGrZDBl
	 JxPqVPXf+SwI6dqcq84JT7+zKj0w82jVFYelzVOUFGxX1U2rViC3o8+3m3McFb/Int
	 gHnhbE4h5uFQw==
Date: Mon, 27 Oct 2025 12:46:02 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net, will@kernel.org, 
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, 
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	rppt@kernel.org
Subject: Re: [RFC PATCH 3/4] drivers/iommu-debug: Track IOMMU pages
Message-ID: <3ajy2xcjo3t6xdrbeo5xinlwtxzujvx4plzk3vqj3za7ren2rv@wdmwpjlaq6ql>
References: <20251003173229.1533640-1-smostafa@google.com>
 <20251003173229.1533640-4-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003173229.1533640-4-smostafa@google.com>

On Fri, Oct 03, 2025 at 05:32:28PM +0000, Mostafa Saleh wrote:
>  void iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
>  {
> +	size_t off;
> +	size_t page_size = iommu_debug_page_size(domain);
> +
> +	if (!static_branch_likely(&iommu_debug_initialized))
> +		return;

This still adds function call overhead even in cases where iommu-debugging is
disabled. Move the static_branches to the header files as well.

