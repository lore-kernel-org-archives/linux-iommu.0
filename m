Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A048C36C5BF;
	Mon,  1 Jun 2026 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319002; cv=none; b=hrznT6wEB3pVK4mVPcrSSYk2+fh5tigsJcg7O/zYKuNRr22lrXlb9eDpL/Trr7aYTKHH99LOFNhtA1mX1Q+QBs+HwPUNF5QEiGOls3IWaM9TeXXLXqsg91JK2r2hOmUVMOcvi0WUaVJCupFEHGV/6/m9vJHjiffNO3m9QmYZeGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319002; c=relaxed/simple;
	bh=U591pDuWaii6wOnIcsVn1CfhpRm6Af3uNfnlk7jsJ5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDzy4T19wiVWt7C2BAI0W0fnvovgB4xUPyvS4aaT40gbZLJrhw2nLcHp9Hgh61Pa7nFE2gjraB/+cjcsf8O1oFWGOUP3SGCtFKGBTF5sdcamrhTTqrDz221DWNFYo3l+r6j38nvkbdWg0Kfc41iUCXnhBS/KgI0m2Dwz2f0Ap0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hro2EzSk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hro2EzSk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C841F00899;
	Mon,  1 Jun 2026 13:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780319001;
	bh=4Qcuv6WiyFpTTR6NYZc9zcTGXOdCJ5UbWCYksTq8AEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hro2EzSkkrgwHRQkLSvw1iWDm+KKS2NQi9QHW5cFDDP+eYjZwthbqxNpNQ9Ci7gpm
	 gQ4lxGNJa69h5exAGHP6RQf9OK75AMpVc/bhpDGC9OdulIw40M/ZGrVYB9cCe29M5d
	 VS8GQKfJmaG2j3THoI9HJu4Ugh/IKuIZ+Zjyia3SpmHhqTRtbETx/KAZk8GQlqHbD7
	 iNWe4Akzk4y+TFgyNh5Mo0mV+sRhcA2cq0EbYhgZH7RDzymhP+Lqf1lEqRY0ON4a1+
	 3wDwOz/IZYrRWeeJBSInUM0HhurF34SNe+VaYCkiT8h71jcI8mQTfe4B4j2+knTZ8Z
	 7d8UiPGmoKADA==
Date: Mon, 1 Jun 2026 15:03:17 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: iommu: arm,smmu: Document
 interconnects property
Message-ID: <20260601-grumpy-crouching-baboon-9cee5a@quoll>
References: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
 <20260526-smmu_interconnect_addition-v2-1-2a6d8ca30d63@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260526-smmu_interconnect_addition-v2-1-2a6d8ca30d63@oss.qualcomm.com>

On Tue, May 26, 2026 at 08:12:02PM +0530, Bibek Kumar Patro wrote:
> Some SoC implementations require a bandwidth vote on an interconnect

"... implementations like Qualcomm foo bar ..."

> path before the SMMU register space is accessible. Add the optional
> 'interconnects' property to the binding to allow platform DT nodes
> to describe this path.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.yaml        | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

