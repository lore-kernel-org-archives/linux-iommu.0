Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA372D4B40
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931912; cv=none; b=Ik30h5ub3+QTOgIKhIZSwWdQXekEjNB4iu/B7vwCf3jjoMlzv/Zb26pCDoZE7fV7gmsP7wllISys5zOqTyTzv/QorrDYNBQmsqYuXHlR/3zBo6ZPwTXW+d7Io+uv82uPQjOzbD5truyrMXM5Bf2ArkZ2wyqvhIAi9B2rNlGrAuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931912; c=relaxed/simple;
	bh=j1zhHp+LlWM4HYSeiz20Owo/jhwDZaDEh9PKWkA6qrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcokpZqljglp9HYSjvIQ0rUiQF8UEmpWMJ+l2tEWPmP057wlzqb/Z86eX3HyjXpJ7N79uh07jjKUGaOYXM9hk70LYiQ+e/kqcFn0rXUJf5hzLyV9t8RZdLCAsQTjKslK8Vi1O837cFxE/Pd8tgct6xfQH7dohVu11Y0fR+aGrMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tkn+jAn1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tkn+jAn1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770E8C19424;
	Thu, 19 Mar 2026 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773931911;
	bh=j1zhHp+LlWM4HYSeiz20Owo/jhwDZaDEh9PKWkA6qrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tkn+jAn10QP6PnJbXnnaIx5qs52AN0Ip4q1bDgcXKxpy688c33AwMWeQaTduS2I6E
	 FMawLISthXtDKVAJRIfIQCZ8tQhHuc4JvuoHa54l4ugrIYEzSLoQi+U8Ge5GV9onNd
	 OH2KkDu+dBU69BGKDweB/2+6WumCxD7pvv4iJXJAs1ryxM8g6xfmoSeWGrcWUvn0cl
	 eOb+3GAkjNmDu6mstiSfmTbMaKaMI3fmeYMkRCQLY0WUbJf6iAdXjlQvMC3WSlX16S
	 asSUTmnsTBS8zV+CIbnymSNxDRbRFTmzA1SXK6kJDmFOL0JVBGEjYdxMOhSe+2XIUn
	 yL15YoW3zep1w==
Date: Thu, 19 Mar 2026 14:51:47 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com, joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, daizhiyuan@phytium.com.cn
Subject: Re: [PATCH 1/3] arm64: errata: Reformat table for IDs
Message-ID: <abwNg5LY9Ll235vS@willie-the-truck>
References: <cover.1772125743.git.robin.murphy@arm.com>
 <3adc16d4d035cf76803e706e325822b99c13e977.1772125743.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3adc16d4d035cf76803e706e325822b99c13e977.1772125743.git.robin.murphy@arm.com>

On Thu, Feb 26, 2026 at 06:10:20PM +0000, Robin Murphy wrote:
> We have some inconsistency where multiple errata for the same component
> share the same Kconfig workaround; some are one ID per line, some are
> smooshed together, and some are entirely separate entries. Standardise
> on the single entry, one ID per line format so that things render nice
> and consistently in the HTML docs, and it's simple and clear to add new
> IDs to existing workarounds without churning the table too much.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  Documentation/arch/arm64/silicon-errata.rst | 44 ++++++++++++---------
>  1 file changed, 25 insertions(+), 19 deletions(-)

I think we're better off doing this at -rc1 in the Arm tree, so we avoid
unnecessary cross-tree conflicts for something that doesn't really matter
that much in the grand scheme of things.

For now, please can you send the SMMU patch on its own so that I can
pick it up?

Cheers,

Will
