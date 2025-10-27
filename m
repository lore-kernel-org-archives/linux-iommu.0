Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B0523D7E4
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565334; cv=none; b=dH2kwDBqwN0Sz4SyfwszEr9rUZu34HOJEHb0pSxfthh4qG1nXih8kzj/S0KW6kqzzGI62y4FOrHl4hr1HzaFNg0Qe/AmrXWRREsLiHlbDk4U2pw6O0k5k0FOam+9OnTKSK7Ylt+JhhcEm50ni47+V0G5kGaDv8BLx8gOZdUtEZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565334; c=relaxed/simple;
	bh=yqzIBFJW1n+nS1+66mDfajB+nxaPKXUzfOcuF+B4uPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxREQEPbdaTmHEZw3EV19ClueKuDjCfACrW4HYLQWyvKBUIbWj+EgFtF9nmIu4FevA9ErIPXH6Ry2sNeLHjsR4bNY2v7SCNPF4wLT0hvbg1oalAKUgn8LA0q2j40WmKQuP4HFTN8N3s9N+9KHy2M9t2ylQZ8F19dISg+b0ekoY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=UBWAu1Le; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="UBWAu1Le"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 11C1B598D5;
	Mon, 27 Oct 2025 12:42:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1761565331;
	bh=yqzIBFJW1n+nS1+66mDfajB+nxaPKXUzfOcuF+B4uPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UBWAu1LednunpDwWyA6dN/T5o++Ac0xIHSNyHI2q6aNwwGBoDzmOu5fPBEFc8ArbW
	 /tt8/W2BQ1vmQ4IAz1Nyb104x9b2KteD0nGMUiIeCt12QtQa7PBYD6YBCnrGAnBc3/
	 Qn0JhNAhnoCOhZV98otZjkfHLqNDdxzdtqE+wUKrNuac+jsIeeqfsfsGAH/ne5A61+
	 fJVgnYxkRNIdWQ6FVublLLmG5wjH46QN/ie1gMaNbSwwI4m4daasyct7wC0Ne/pUUf
	 lpUvTiLRC205Aa4QBlQdiUIjcR8HkRzg6GlsEj28ZWB+3Gdl+rXI9orww+F0KE4FtQ
	 tusBXnMM4yTlA==
Date: Mon, 27 Oct 2025 12:42:09 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net, will@kernel.org, 
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, 
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	rppt@kernel.org
Subject: Re: [RFC PATCH 1/4] drivers/iommu: Add page_ext for
 IOMMU_DEBUG_PAGEALLOC
Message-ID: <uwznrzdsbfpbalzf5jxxpguf2ykslphfs47u7gf66ssiwzpqju@dh7nw3van6sr>
References: <20251003173229.1533640-1-smostafa@google.com>
 <20251003173229.1533640-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003173229.1533640-2-smostafa@google.com>

On Fri, Oct 03, 2025 at 05:32:26PM +0000, Mostafa Saleh wrote:
> +config IOMMU_DEBUG_PAGEALLOC
> +	bool "Debug page memory allocations against IOMMU"
> +	depends on DEBUG_PAGEALLOC && IOMMU_API && PAGE_EXTENSION
> +	help
> +		This config checks when a page is freed by the kernel
> +		it's not mapped in any IOMMU domain. It can help with
> +		debugging use-after-free from driver doing DMA.
> +		This santaizer can have false-negative cases where some
> +		problems won't be detected.
> +		Expect overhead when enabling this + enabling the kernel
> +		command line iommu.debug_pagealloc.
> +
> +		If unsure, say N here.

Expected indentation here is <tab><space><space> and not <tab><tab>.

> --- /dev/null
> +++ b/drivers/iommu/iommu-debug.c

Is there a plan for this file to contain more than page-alloc debugging? If
not, it should get a more specific name, like iommu-debug-pagealloc.c or
similar.

