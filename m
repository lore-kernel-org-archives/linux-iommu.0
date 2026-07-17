Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341E226FA4B;
	Fri, 17 Jul 2026 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295994; cv=none; b=e9kpOQSHBGRPhVkbUJW0YhKHuhgxFCGMu4r5ihNBdqLzOv8futUKELFWCFikVG1ObX4IHhZAIRKNr4p5BMe8vxk9F+CxEZtIVGUx+pu1dH7PVmNvyRkd5p6yZDITlLX/Z82HVsDcqJNlk5NG31NLy1KeUWGLKID90GoqQjdkoFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295994; c=relaxed/simple;
	bh=YoDCwTy69pT8cceOg0Omujansm0pIvCx4GWKR7uiV6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBrRj2fXmoGAFHefP3IPD7u715HreXVUS1Dw8bR7HoG+KNmHRQkBLos1y9HZ2Di13F6rLwr8dwwJnfzwHSTj4P3qk3wqtvUdUOWTEW+8lR+TBGBNc6JXFpi/c4ubIF4jQsJscj3yXnqyKzegByeFBVCaWJiDoxLKJxfG+krS5GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QScorUxP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QScorUxP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09771F000E9;
	Fri, 17 Jul 2026 13:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784295992;
	bh=33zVz7s+Sfab7xvZbDxZpGQiVyBxiYPKc1AbFarxwU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QScorUxPnn65CEocxcAeCdZLJwjzyTejRYndPXJhzTpChrsMcBR70n2sNrkkc99V4
	 uOu+jEc9YTIT5XFDEVG5mehZ9DD/Sx2BpAZ01sDYVPpY0gHidVHQfA8NaOFhHq76pO
	 x8KZ7Pgf+v3W9YbwENwHm8JNoQHBekHrFI1ihCXVzrHQ2yPzpCnaQrQlKi2U03lBYs
	 OJUHKGBC0nD8UfoG8/5Ykp51Mc1+2KjrJqAhhfmzfgTApSVUg1o0S5DyvipN5S61ht
	 gfYdFbpCkHhCdillcOdJsgG7SDYCFniV1sm+PmtjPbNAwxrbJa+YZLc286qZBkW4fq
	 qd5qlA3jQRFjA==
Date: Fri, 17 Jul 2026 08:46:32 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bhargav Joshi <j.bhargav.u@gmail.com>
Cc: m-chawdhry@ti.com, Will Deacon <will@kernel.org>,
	daniel.baluta@gmail.com, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	iommu@lists.linux.dev, goledhruva@gmail.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	simona.toaca@nxp.com, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] dt-bindings: iommu: ti,omap-iommu: Convert to DT
 schema
Message-ID: <178429599134.475806.17069661662952348214.robh@kernel.org>
References: <20260708-ti-omap-iommu-v2-1-612d4a6644ba@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708-ti-omap-iommu-v2-1-612d4a6644ba@gmail.com>


On Wed, 08 Jul 2026 22:21:43 +0530, Bhargav Joshi wrote:
> Convert Texas Instruments OMAP2+ IOMMU from text to DT schema. Make the
> 'ti,hwmods' property optional and mark it deprecated as it is no longer
> used, it is kept to support legacy dtbs.
> 
> Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
> ---
> Changes in v2:
> - Added maxItems:1 to ti,syscon-mmuconfig as property expects only one
>   pair of phandle-args
> - Added deafult value 32 for ti,#tlb-entries
> - Link to v1: https://lore.kernel.org/r/20260708-ti-omap-iommu-v1-1-48cfc53aaa46@gmail.com
> ---
>  .../devicetree/bindings/iommu/ti,omap-iommu.txt    |  59 -----------
>  .../devicetree/bindings/iommu/ti,omap-iommu.yaml   | 114 +++++++++++++++++++++
>  2 files changed, 114 insertions(+), 59 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

