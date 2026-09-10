Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBCE49B5DE
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078118; cv=none; b=ET7upWLNKEfcLLLRJ8caTMw+8XGdQyobzzQhzVkrYogV0SAVZqOI6i+sDYg1EEslhsJtNye8JoVpsYM8LCwl3NQVVHdgh12z2oAsHYgyLarBH6bXSC5lL9N3401SkptprHF5dEJ4NF8Nt0RPvNnH05NyqH+MkjLDvupuvQRRda0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078118; c=relaxed/simple;
	bh=fyjDM6iNxubB63oWGZSsLMjlYJXtdX1HZPin1JoDBHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSzc68YrtzHUl3FG3u6SQPp1KdC3KrEF/gxM4XL/Y0W28x5n5R8pFlxE49IbrJ8UT6iSyGwZxdbNdJd4AbRsoFb8qLrG/zwRw3aeP/S0vq/Y3S6jVtLy8n4E23nbcXyavoTFzXqIcQ9Pcr+e9WN9iBMP+C+GxpfmxOY+ZYkDwyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7WP1p6t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7WP1p6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6176E1F00893;
	Thu, 10 Sep 2026 22:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789078117;
	bh=9y9YUZsrVpPc7jJgMR4kWBBon5l+dalyTe1ql4Bs5Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O7WP1p6tzqylWK95AMS3JLqhdDsevUV9QHEMugV/8r4TuHKVJ6WiH+h+gHOMorMeX
	 A7aIk10TZTjUO4Hy2KeCtqkys2qb4jirprr6F0kFqzdHVvUU5eMEO2rliJIZgZX0G8
	 8TW2joUgdxkx/xoUwvCzMzj2XI7KuX+TN1P6SMASS8iI/RTtRj/IodqledOU53wd8A
	 zwTR5paOw71waAJFKao8kaZzjpHjMwmqiS/n3Y87RFShM0uZpz+wEQpirM8qmLAXyf
	 yOA+NA6ivPArCM6yHzGSl5mHVeBPBIct2Qa8VbbL9Zb+fQlIBtHESWVm8VoTjeYPc4
	 8janHRGoEgxvg==
Date: Fri, 11 Sep 2026 00:08:33 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>, 
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka <sebastian.brzezinka@intel.com>, 
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v6 2/7] drm/i915/gem: Count mapped pages in a folio
Message-ID: <aqMpIkMBmnZWsckc@zenone.zhora.eu>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
 <20260902082525.1149367-3-krzysztof.karas@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902082525.1149367-3-krzysztof.karas@intel.com>

Hi Krzysztof,

> -		next_pfn = folio_pfn(folio) + nr_pages;
> +
> +		/*
> +		 * We assume folios are placed one after the other in memory
> +		 * and predict where the next folio begins.
> +		 */
> +		next_pfn = folio_pfn(folio) + folio_page_index + nr_pages;

referring to the comment, we are not really "assuming" anything
here; we are storing the next PFN so that continguous physcal
pages can be merged into the same SG entry.

Thanks,
Andi
