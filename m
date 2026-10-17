Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FCE3B8BBB;
	Sat, 17 Oct 2026 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258801; cv=none; b=DX4IqMTowHenIJes0Yyl/IS4AoyXPXb63iG2x+iDIxwB16dkk9bQa6ne0SARuPeFw5DmluKgQv9tMuCC0t5aLUASq7C77G4aUP2XaamUrEeZK88J65ElIlJAjpXKmKpi58d7csh9OWQa3BqNllvaZq2iPCs5fo+4ZF6r/QJrOvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258801; c=relaxed/simple;
	bh=Odj9zDKD3/e22xT3SRovV4qjHpB1usXaluOEnpZbsEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWuv545Mr5fpVUjSCVSMP4pjbTfmSDGo57yvpmKl2fkWTb28csHt0w3vyTBj/BwoF36gUtziqeRV2HE4BWQSc71af0GF42Ly+wJlTHkAJmmBuWbL8JOZRpMa1Rmlcxp7mRhOQ4e333PiaAmcQ++brtCCmf1dLI+FvPybLNHysKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKmt+38T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKmt+38T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AC41F000C5;
	Sat, 17 Oct 2026 17:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792258800;
	bh=GucSTx+vMay15N5xRgcUGHqnmTXGCCFC1khzIlrgII0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HKmt+38T+BLu5TvojRf4ZV39zzF/QcTdZh6TMuC0SeWukADTM5OZbQWRCRm9BXPrf
	 otvBn5jW6nB28dnbzgpimUuEE6zPZN2coyB+5J96jDmS0xwvAUhu/MxxCUqzo178xa
	 KLk7/iPwbiDVus+uFpd2s10NoHfG2I9M6hmBI2VzzhL2RHxuCT4Isv1EKsm6L5a+uW
	 swTUDKi9E2OznM1/bxm82kmOJQJ8CdHpkVPKHLT0OVj0x7BLW1HKHJCGSCLObTyfZi
	 S25d6HyYlYADJdzDj81v3O6vXP4OPn3ek9Vgxhtoe9EgEnFiTULs5QF1WEzqTAMpzn
	 WSdy1dWLiaUjg==
Date: Sat, 17 Oct 2026 19:39:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ishu Brar <patches@brar.si>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Document SM7250 SMMU
Message-ID: <20261017-fluffy-porpoise-of-brotherhood-0f8c19@quoll>
References: <20261016-smmu-sm7250-v1-0-e11fc0384cfa@brar.si>
 <20261016-smmu-sm7250-v1-1-e11fc0384cfa@brar.si>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016-smmu-sm7250-v1-1-e11fc0384cfa@brar.si>

On Fri, Oct 16, 2026 at 03:16:40PM +0530, Ishu Brar wrote:
> Document the SMMU found on the Qualcomm SM7250 SoC: the apps SMMU, which
> is an MMU-500 implementation, and the GPU SMMU, which additionally
> carries qcom,adreno-smmu.
> 
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---

Seems valid Sashiko comments.

Best regards,
Krzysztof

