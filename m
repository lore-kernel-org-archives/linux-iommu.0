Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6BC400DFE;
	Tue, 19 May 2026 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204256; cv=none; b=X8tLe6dY5EbbK5jmPxcajSUeiIce88ktefigTZRVtKwZrGr2hC+4xS1vPA6AIEaXVfNPx14UF0CCMzWdgmEwuikH76oOuYnHd5DQQpc9IJmXeZVRqXkEYChmXLBOKYJcy8L1k/Iif87fBenSsfy6wY/7cJJgbMTQniNNbpUBlKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204256; c=relaxed/simple;
	bh=6yzeZKjIY7KncVYLNHjU8B1TmRbz+P56hztlrktOXjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlBzzy34v66TRvxk3ySbvmupGIYNc4yittARSDv2OCnOHYFegbHchV4dhfXAz0IF3a7fz4MfdgXHks0sa10s/Vakp5VhVi6XNxdaKLunlEQePfLV0i8JhWFJb5BSjEuKxv9I7UfgAexIeu+Cl02wRxr3vLmsASBfOLID5R0sx8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ds4cLQmr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ds4cLQmr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5721C2BCB3;
	Tue, 19 May 2026 15:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779204255;
	bh=6yzeZKjIY7KncVYLNHjU8B1TmRbz+P56hztlrktOXjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ds4cLQmrolBcjcmaH2fKTelUol+Rtg41iRm6WbzrtsN2vJzZzGQaJAE7IkSLAlNUn
	 AJBhs3E9v2YsYhImXYanmD7ioIZE+7pptRxkFVilZGbyuWo7bHA8FAIufYJN6ifcSS
	 0xT0w3/uiqN+Psyd7vpEFFtiBgJBkbMR2C2JSJiUQKTKH1sBtPXkzqdnikuNQ2OIjm
	 LzAi339N1zyZ/MBxgRw6xdaAk0PjDAx5MX3CpBmPVlybm0mnOodfTByss4VSwT2uZt
	 0Ye9ir0C2jE1pXIrMxmyMYSUHqK7POgWOrFEZHqSMuVp7fMA51n+zS0yE6nwy5X6k7
	 GZ4C6k34JTJ5g==
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
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: qcom: Add Hawi compatible for Application processor
Date: Tue, 19 May 2026 16:23:06 +0100
Message-ID: <177918729848.741670.14409258656864671686.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427174915.3639641-1-mukesh.ojha@oss.qualcomm.com>
References: <20260427174915.3639641-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 27 Apr 2026 23:19:15 +0530, Mukesh Ojha wrote:
> Commit 5e8323c3d528 ("dt-bindings: arm-smmu: qcom: Add compatible for
> Hawi SoC") was intended for the APSS SMMU but was mistakenly placed
> under the Adreno GPU SMMU section. Since that compatible is also valid
> for the Hawi GPU SMMU, keep that commit as-is and add proper
> documentation for the Hawi APSS SMMU here.
> 
> 
> [...]

Applied to iommu (arm/smmu/bindings), thanks!

[1/1] dt-bindings: arm-smmu: qcom: Add Hawi compatible for Application processor
      https://git.kernel.org/iommu/c/c3f9dabf58bb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
