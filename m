Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB83C0600;
	Thu,  7 May 2026 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177962; cv=none; b=AaKJEkbT3GZl4AMzdFYuczctt/xznFeghvu5UgwS3IDqIUGLwVuHS7UQceBX6hvXwT8LXFSS8XnEisuw1bDu2JeFttin4liou9EW/+/WV6ZTjI+QENdc4OflpKkQDlfrgGqR10Aucoy7+QXFnHwBpNOCh2aLhvZpOH/O+bC93ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177962; c=relaxed/simple;
	bh=L13Ya1YLtr11/2vSHCsuWV2gqbbrk3THnoiNxoiKkoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WU2iz9/P3y9p5PFHAw9inGwnQHmj/2CjVpP/40rKxDdodqKRtdb4HnC0LqVcKLNRNEOKMYDUAGUVE2zziSUt6jpKec3YiiFaqTUdKBACG7qffBGEFxodDAGpu4ev1qQJ8EmHTINiX+NTSPpV720+OMZ2pseDr5NXTDlD1cqw0Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FphLEBkW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FphLEBkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAA8C2BCB2;
	Thu,  7 May 2026 18:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778177962;
	bh=L13Ya1YLtr11/2vSHCsuWV2gqbbrk3THnoiNxoiKkoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FphLEBkW2BByd/51JTrKOETzSTkxz355vauLF556Z550I3Vp+8XDuYYZdq755prvL
	 WEhJgJuudOzkpTdDGu2hZkOA5mq9htHiumi5gPnpJx70xjrxGpPwTLkiQtnTcaDq80
	 ALyaa1qMgzvHEALZgpRzHSTnw1BxE4P0WOp4m5UIEbojP0vQvv+sCIwe+JOwwKLl8p
	 iXM5jj/05LCMSoJcztk1bKnc6ErOKN4l6CFxzsreiVSDmWiWpf6+9KaCtwehcKBq1M
	 /jMMUbrLADPOk54Y4a6KNJbLXzl/u6B6QjjDN36vJrmJukVXGmxgsRNS9fIkOaqZvN
	 C9d2y1omsOzEg==
Date: Thu, 7 May 2026 13:19:20 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm-smmu: qcom: Add compatible for Qualcomm
 Shikra SoC
Message-ID: <177817795959.2206284.11592002109697803806.robh@kernel.org>
References: <20260430-shikra-smmu-binding-v1-1-1a28572ebccf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430-shikra-smmu-binding-v1-1-1a28572ebccf@oss.qualcomm.com>


On Thu, 30 Apr 2026 17:54:44 +0530, Komal Bajaj wrote:
> Qualcomm Shikra SoC includes an apps SMMU that implements arm,mmu-500,
> which is used to translate device-visible virtual addresses to physical
> addresses. Add compatible for it.
> 
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

