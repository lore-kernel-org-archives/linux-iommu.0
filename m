Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB6B4FDA7F;
	Tue, 29 Sep 2026 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682105; cv=none; b=THg201gyMxdNO4mk6sbs0CH2ObucTtOCoePqyfegHk1P3gev+1wG152PGPIwb66DL3VSOlFoYNK2yclc/6Jth9fLwNZrHLsLKdUZT3cbjyohyqLCeTGwV2QA7ZAxuhUB4jkxR/vKBnq5sgs+rSPw+lmDYvzoEV32NhrLu4ZhzuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682105; c=relaxed/simple;
	bh=r4DkuD8c9rJugP/soUm/UW9JpR/D77uf7Eprg6SeX/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=it6kHrbWficaT1UoAnpaYLqIBb1YQTZpI45ZcZg4uqygHFmzJJOheFMyJIb8hjnaHzu2IcZEKTLBuh6XvyNmn6g1gQLSPIHjwWTOwMmWtUNwiMHIQKp7MilChs0u2cr2mEd/VvgbHcg66XJh9/0FF3SI6LOeKQtJJzrYr/1Ihc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d940tbRw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d940tbRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662161F00893;
	Tue, 29 Sep 2026 11:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790682103;
	bh=tf3LWXKU+gR3zlJtLFtS4/H1jz1r6YhuQkB47pa4hXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d940tbRwwR8NEwHkMpZn5KYXeqbS3Abmxl3YE2EE7GcP/CO0xnBr98czUyUUspKah
	 1GjvBr1z/uy620X6G+uTNih3vMmXjpmX27t03rOv3r/hDFxeG63yo3RF4+AuX0FYrT
	 btNsb7XXSzppQcLhPyGotJoT5Tl/Fa+eIMkMIJQD+C/B61ptEZl7brqeyLfZeliR75
	 +QOOYlXIwWyULludOWMGxUEEermNO9yNsqUxScScF6+s/v0euL145J2qApTW/DacOX
	 l8PykdfCAxzyVBFcwAl8huV1fTWzK4jNOka4u4Q+WN+uYWJsqUa5SLF2m5pXSPitmO
	 h5IulB3DP4dFg==
Date: Tue, 29 Sep 2026 12:41:38 +0100
From: Will Deacon <will@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: Document Adreno SMMU for Nord
 SoC
Message-ID: <aruj8uLUUiuKfJpp@willie-the-truck>
References: <20260902013858.130887-1-shengchao.guo@oss.qualcomm.com>
 <arpNicG_jUzh1ZrL@QCOM-aGQu4IUr3Y>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arpNicG_jUzh1ZrL@QCOM-aGQu4IUr3Y>

On Mon, Sep 28, 2026 at 07:20:41PM +0800, Shawn Guo wrote:
> On Wed, Sep 02, 2026 at 09:38:58AM +0800, Shawn Guo wrote:
> > Add specific compatible string to document the GPU SMMU present on
> > Nord SoC, and constrain it to the single HLOS vote clock.
> > 
> > Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> > ---
> > Changes for v2:
> > - Add the missing HLOS vote clock constraint
> > - Link to v1: https://lore.kernel.org/all/20260901140816.74200-1-shengchao.guo@oss.qualcomm.com/
> 
> Hi Will,
> 
> Would you pick up this change? Or are you okay with that we route this
> change via arm-soc tree?

I'll grab it, I'm just thousands of patches behind atm

Will
