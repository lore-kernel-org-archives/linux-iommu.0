Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ECB43CE6D;
	Wed, 22 Jul 2026 21:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756414; cv=none; b=tdrl7gAEgt5K/sdrxTNC8jd+JBZDHsNyn90IcFsHp8zIAvcdwftgDPKI0y+asij6stVLLTUXFuWNtUSH8KE0ow6GkeDX8cCZw0IQNMDmtlEAEK9NAlPTk4j6VMFnOeIkAgMmkRaqi77Fq11Qc7nGpoXbDojb6ViVMVNVpPaA09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756414; c=relaxed/simple;
	bh=w5Ag+iM/cYHWn8rDgwEBXQtG92U3dJRuvwOAsj9HR4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2JDja/jgZKeASlwDmeiWoL20awbaQEOSnd5u1GCKQxq1ZUShhWpV8dBAHKWKRn0bX4LSiZzrfG5IcVoNQT3NgFDYlBLNjW4pZMLdjl7FFcZHIgmI7YcseOx9EI2IvfUbPuLzwwyi/pAy7hy8M65aAXYQjr2gRLogorfBiHFiTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRFVJwQU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRFVJwQU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252371F000E9;
	Wed, 22 Jul 2026 21:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756409;
	bh=2G9r8fYaB8St4kBB8vENlcvsH0RfySNRNVJF+kfQiu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GRFVJwQUBcgIyLolEYyvXJuKd3lKIxn9edV9NAE2+3Fe4+Z+GtuDjBP0XkgwUDNc6
	 iEZnKI3p3194E9CeZWpkJGoc/ffJoduQa5ntardIArgzrEtAB78EvLZvGxIJHPpptC
	 01EvEELLoqDIdBbO+DsulNqnyfe16P7b15ZjzUIzzs9zaLrtapuq6RZB9vfl+IF5pI
	 CGyIURFRjaw1EfLTCFEJd4l9tpYxzaK5fsVhH2zUxItNOY+SUTGjUlf039LCNDjQ0w
	 AhBBCoEX6k4eZa1xYaSjZiTd6r7BJrcvi1ZZmlUyrQUpbqkhO5pLOCjSZYBT9DRbIm
	 LZHN3HzH7EEgA==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	aiqun.yu@oss.qualcomm.com,
	tingwei.zhang@oss.qualcomm.com,
	trilok.soni@oss.qualcomm.com,
	yijie.yang@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: arm-smmu: qcom: Add compatible for Maili SoC
Date: Wed, 22 Jul 2026 22:39:24 +0100
Message-ID: <178472685795.2885692.14366470703772895331.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260703-maili-smmu-v3-1-b48de6f5ae4a@oss.qualcomm.com>
References: <20260703-maili-smmu-v3-1-b48de6f5ae4a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 03 Jul 2026 00:50:33 -0700, Jingyi Wang wrote:
> Qualcomm Maili SoC includes apps smmu that implements arm,mmu-500,
> which is used to translate device-visible virtual addresses to
> physical addresses. Add compatible for it.
> 
> 

Applied to iommu (arm/smmu/bindings), thanks!

[1/1] dt-bindings: arm-smmu: qcom: Add compatible for Maili SoC
      https://git.kernel.org/iommu/c/7b97226bfb4f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
