Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB23D16E5;
	Tue,  7 Apr 2026 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775581432; cv=none; b=O+TtJxoKn67luB3HQzgMol1mYBVO42y9E7MMabC/FGd3KwwPO6FsbsorL1doLY+dmTukYqt92kMBYMOWxWDaHGJTb3lP/NYijIluA5X7Z0lh7HyX94nTQ2WLwJY+iAyZti47iQ5XJFAU7SZ0JFNDmHKXujfm3WogRxEtMg2E5/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775581432; c=relaxed/simple;
	bh=cvSfD19P7uTmsATu2GySWCnv/dAXkRtQ9Eb0rF3LY/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDzmekMBBkGY5c5VYIhZKMLtllw2bx1M6uI5Inn/HqScI9Xy++ku+b7PHaQYIPQNsAMsfZ8/rrKM4a5jWDMlryninB/B0XE3nuK3UnpG8iiDK4n9MOp7Oc2r/D5P9FL3yTzp70dsGimkpiTsgm8EQj1fkmzWnSBPf1hH7r1NpK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAowgwY8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAowgwY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D687C116C6;
	Tue,  7 Apr 2026 17:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775581432;
	bh=cvSfD19P7uTmsATu2GySWCnv/dAXkRtQ9Eb0rF3LY/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YAowgwY8frarC3ngk17I+k/t9K/0gPezR4wsmrg2wUodIyeKKKyY3f4j83jovC1UG
	 x0OU8wils+E0iyIsFAs2LHttPoJ1px8fDhbFmOePXHRoZPtpsH4/07+G228uFFzCP5
	 1DDiOPyZ1BQgTnwHtMatOWcIqpeFJDH4X3cj63X9gtA3BK1EPpzgqCA6PgQtxFOBkF
	 Sk3AT55vezhVu9+R7EMhGolvc4eHRoNKHQGvJPQMJoYl+WVHcmj6o+8MOiCqPU94or
	 3/x+qmiof/kn6hH4t/ofc8JN9+BMEiHqde+BtiKTUrvzpWJ5/PEsaxcT+1XhnvbhVL
	 bNGXJMsjAZVpg==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Murphy <Robin.Murphy@arm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: qcom: Add compatible for Hawi SoC
Date: Tue,  7 Apr 2026 18:03:43 +0100
Message-ID: <177558103339.2252830.5428863486031269927.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403080956.2714415-1-mukesh.ojha@oss.qualcomm.com>
References: <20260403080956.2714415-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 03 Apr 2026 13:39:56 +0530, Mukesh Ojha wrote:
> Qualcomm Hawi SoC include apps smmu that implements arm,mmu-500, which
> is used to translate device-visible virtual addresses to physical
> addresses. Add compatible for these items.
> 
> 

Applied to iommu (arm/smmu/bindings), thanks!

[1/1] dt-bindings: arm-smmu: qcom: Add compatible for Hawi SoC
      https://git.kernel.org/iommu/c/5e8323c3d528

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
