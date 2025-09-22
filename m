Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B1D30C36E;
	Mon, 22 Sep 2025 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570655; cv=none; b=SbfVX+oNOV0NGBZqWajih95RMqpMHiAVf9dCIjNfUfChnMXxnJ3eZQjT/NtpQN8ckRjjLBcLwVhssSiV4M9O0zQsqnnnQWt0vw9eHUbnvI8jUhRz0slRX6SWF/w5syzuUD34IVaz9ewav85A0CzdNw+iZFKP2HhJ739LnrwhxmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570655; c=relaxed/simple;
	bh=PJ14tEXKCCze1FgoKpPEwcWDdS3QXMtPv/Gt8dbIO8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwsT6gAld7GBGmVYowPmUXBjjjZxaq97KEtXJjuBbvPjDZ/sgOiTqGGTWkVd9KpJBdc7A4Ehod0HlW05Mr1gylzTgfWs/CaSkxS4mWkuRLS37pHtMiU9igWX1AD/9JwKIC+byeCphuq0vd0OEVJ+OosgTe9XwWHzDRVQmHUXh7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSM2LXk3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSM2LXk3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0876CC4CEF0;
	Mon, 22 Sep 2025 19:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758570654;
	bh=PJ14tEXKCCze1FgoKpPEwcWDdS3QXMtPv/Gt8dbIO8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pSM2LXk3MJBdfinmJaWTBhkL2yIyaDcKjFJjIv44irmcaMcPiq+Ttz9tgc3JWyPr4
	 T+BcYpvAl5sNAI2PUrC94gt1A6PQ1Mr8uNLGxJIr3BGii+VYCliwzIbIoVMCCtzkly
	 6azOYfxTxCyYHpLu+3vA19jAokfAhaHMhFM0zdehy0JlJU5J8MzfQuP9CeACezbh1u
	 XishcU1dwE7cn8yQiCKGjYQx2T0m4/1SIFB8USrXo/tQXMdU6IdzOiUfB2YsPn8KrT
	 S7J1m1xPv+Fjp+xTH6KwE/2eF1+w/dO1sb0FDxCfAdGN+OHN/caAfLDD7eb5D2gdSj
	 bUYWPg+hxRMHw==
Date: Mon, 22 Sep 2025 14:50:51 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, robin.murphy@arm.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, joro@8bytes.org,
	will@kernel.org, krzk+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: arm-smmu: Document Glymur SMMU
Message-ID: <175857065066.1064671.10595725300353083455.robh@kernel.org>
References: <20250919133439.965595-1-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919133439.965595-1-pankaj.patil@oss.qualcomm.com>


On Fri, 19 Sep 2025 19:04:39 +0530, Pankaj Patil wrote:
> Document the compatible for Qualcomm Glymur APPS smmu
> 
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

