Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7981E98E3;
	Sun,  5 Jul 2026 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783244337; cv=none; b=I8SzfDaW0o+ePvOeN0FzPjpuotTaELS5pbezwau4t02Hy0fVaZlgLOTwQh4ZN+jRDUGyjbzXLyjVoNkD4sZCN84z5kpMJ43H0EixCJ2hmxoOJ/Ho3xkqQGTvxo4Cw+nC3RbQMahw1QvxaVvSAXfUaEyW0nVrEbIPcO5NX4ttGSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783244337; c=relaxed/simple;
	bh=Lib5vaBWiCQQA+ItOW6bu8bidbSl/SbYsleBZxcltTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYFpR9Kn0G9VD6Glo4pKNVAtPvKAZe3ymHPX3yu/MtF+f2MWUh+9EbiW98D62IzghFAwh047wjpViDYGdD8GohM+p+p0+dLUjxvYdrmSWVLi70IuDlnvpQy3mj4xEE+o0bYZ8Gu6JU+1cqC/HGrhz071X6OCs1wHn93G0wjg48A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry21T4sY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry21T4sY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30DC1F000E9;
	Sun,  5 Jul 2026 09:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783244335;
	bh=XZhM/0+OvqhrwsSvTpUuB05s8KN//HqjSTRLZy1Sajk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ry21T4sYhIVr7FwMl4zizXNPV327UPOoEoUqQKDU0r3Q5w2GTM+4y3CofylaqxlzH
	 yz4tN5puBXEQX0i+FEXpuCFdkKCOpW3y3BftZrm9+EQjNT2Hrvh8xE5R21PCDV2PNW
	 hvAPGp+RtiEkxsfPrz4W46aWlbZxTrfQTQnSnl7/MqkELjGWyeUrFASMJiD0XTgOG9
	 IcvSiJkzioBzeZFTx33D1qgKLA50gwtO3oyutXlLNDqjW+ENMxBfDbn6QkVpVOZkye
	 VrUPCtfbeXiN1BurU3JcEhg7BQSOLkBVD5UlKYUFxBxaY1qsUodZrDr7bXwK1fch9W
	 WWcy8YmeiOJWg==
Date: Sun, 5 Jul 2026 11:38:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, aiqun.yu@oss.qualcomm.com, 
	tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: arm-smmu: qcom: Add compatible for Maili
 SoC
Message-ID: <20260705-hungry-dolphin-of-spirit-c74e4b@quoll>
References: <20260703-maili-smmu-v3-1-b48de6f5ae4a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703-maili-smmu-v3-1-b48de6f5ae4a@oss.qualcomm.com>

On Fri, Jul 03, 2026 at 12:50:33AM -0700, Jingyi Wang wrote:
> Qualcomm Maili SoC includes apps smmu that implements arm,mmu-500,
> which is used to translate device-visible virtual addresses to
> physical addresses. Add compatible for it.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

