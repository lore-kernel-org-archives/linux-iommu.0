Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8553E3165
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935430; cv=none; b=aN+JcNFmlfoTPb0TPHAAdc1S4/zxFeH39PNTeZu1PbjRL5m+uZtyAoW1w4p9fG1iCbpEMeO/wIFuDviK0TF7u79XnJEyJ0A2OEhWYviNjlWZQ533obSWe33OZ3bF+rtl+hUdenr7Pma1J8DYZ6/a/aa4U1Rpd/P+oB8F+FKcgqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935430; c=relaxed/simple;
	bh=OOiabRzfIU2rkzstMHupJQAL4bYIGNlCquN6bH2HLmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSgX1QvZdWAuuXLGqYg3kVBIAgsUqVPMwmPwICp9FCYStZiWau0I+81F1/iV3RL98dHXo2uXBVvMzjXI6gJqTq2Bpy4444Tpns0U5jKiFUOeidFx5ChYiN1i/WBgPfWMEZs8w30At6uS6ZZJmES8v4Dl6jL2DSH/smaxn3snoI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vy2p5TPf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vy2p5TPf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A911C19424;
	Thu, 19 Mar 2026 15:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773935430;
	bh=OOiabRzfIU2rkzstMHupJQAL4bYIGNlCquN6bH2HLmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vy2p5TPfckFpW/r8pn1mfBzmjmPLf3nSoaQvLsdcIPNZYEqNBsyrMpTuxMv/Of0f0
	 ir9sIQW8LHJeUBtTiOSifjezt2M+2bdF3no3Rq2XnsHEvh6AtjkrdY3eVx2uILAlld
	 WyE82C14fWCVpXtgHWuuLBKCditeGTQYJ/Ql8VmRd+bwLLGle2lBvplPYEOo7+9BZ/
	 lLUyCeDpw0XtWAR7zYI+rP+Q5g/NKxJTYJAGCYCanxmZ5LR7JPnfmNyvlgxovQvEnN
	 AYp3RWnFny4eAU4V0d23x9Id4Qq3f3UxS/AHEZAt29z7YUWoahLO2zX5A1yCfjnsgV
	 OUC++t35vDKog==
Date: Thu, 19 Mar 2026 15:50:25 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com, joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, daizhiyuan@phytium.com.cn
Subject: Re: [PATCH 1/3] arm64: errata: Reformat table for IDs
Message-ID: <abwbQWfV-yRZzkJC@willie-the-truck>
References: <cover.1772125743.git.robin.murphy@arm.com>
 <3adc16d4d035cf76803e706e325822b99c13e977.1772125743.git.robin.murphy@arm.com>
 <abwNg5LY9Ll235vS@willie-the-truck>
 <7fe97d37-b6e4-4fe7-a871-b4d67763079a@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fe97d37-b6e4-4fe7-a871-b4d67763079a@arm.com>

On Thu, Mar 19, 2026 at 03:32:22PM +0000, Robin Murphy wrote:
> On 2026-03-19 2:51 pm, Will Deacon wrote:
> > On Thu, Feb 26, 2026 at 06:10:20PM +0000, Robin Murphy wrote:
> > > We have some inconsistency where multiple errata for the same component
> > > share the same Kconfig workaround; some are one ID per line, some are
> > > smooshed together, and some are entirely separate entries. Standardise
> > > on the single entry, one ID per line format so that things render nice
> > > and consistently in the HTML docs, and it's simple and clear to add new
> > > IDs to existing workarounds without churning the table too much.
> > > 
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > ---
> > >   Documentation/arch/arm64/silicon-errata.rst | 44 ++++++++++++---------
> > >   1 file changed, 25 insertions(+), 19 deletions(-)
> > 
> > I think we're better off doing this at -rc1 in the Arm tree, so we avoid
> > unnecessary cross-tree conflicts for something that doesn't really matter
> > that much in the grand scheme of things.
> > 
> > For now, please can you send the SMMU patch on its own so that I can
> > pick it up?
> 
> Yeah, that's fair enough, it's not like it's a real dependency that would
> justify taking the SMMU patch through arm64 either. v2 sent, and if I
> haven't forgotten all about this by -rc1, I'll rebase and re-send this one
> then.

Thank you!

Will
