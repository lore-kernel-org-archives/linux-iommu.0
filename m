Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FE43161B0;
	Mon,  3 Nov 2025 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186682; cv=none; b=X1JSz3zFMP4O1/XZTJagpO6v3xu4sm4GF665YZn0szCYFoi40KfEfz5o/cjf1qz/YrWKKhwuqp5ow8uTXJdCBW+6j25HD6thTtpdpqZxATVfQa4uNjivgC4emh9ZFYzjzwodwvXkzxnSc46fS3zn7CvC41XmrLlnSuFyrRnDQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186682; c=relaxed/simple;
	bh=1jqhRNkAoXZW07AubL5jUqcArPCGQen9XHdy6CfaED0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9EWzQZDqyx8dZrQHNuFlLG0yOIdaTxLE1dJe7clN6mHizgfqXBAGIgYv+bEZFxp7Da+zb3OiagyOCBHPuwhSeLFZiZkh84toL8mt5/+MK8k7ef+SEWuNqfU2dl39cbiOypr3uHflWx+bdoiRAVE64550iZY/TfM3dVpg2Fk7II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5I2M9rv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5I2M9rv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC88C4CEFD;
	Mon,  3 Nov 2025 16:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762186681;
	bh=1jqhRNkAoXZW07AubL5jUqcArPCGQen9XHdy6CfaED0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5I2M9rvFYRg13EhCdpGlmy1zwLxcweioaogE4dBkh+X/AZwYatEQYQQjQ2rNiRZY
	 ArpouXhz1v0ai7R6xUlYKN1rLsx4HVtlsbKZJmCCcYr+brf3tRJlzVhE0SFoH7E0c3
	 UNf0baNdwP9XqGX+c9v/Hj1nywOv0WHShBcZ03uKYL5wYOBzF53ec+CAB1dcKtl5Y0
	 oPXrrl31A9ac2gVAr3vpG4KaCCp9kwGuHjzrFEC60au8TuqjegzbIwK0AJbiCFWlCK
	 XzYXRcp2Rh2eqcbvNeP/g34Kz6F36/59BFV9DMk07pxd3X3kVo+EMF8RouqPxv8BTx
	 Z7uFrx8vWCx5A==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
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
	linux-kernel@vger.kernel.org,
	Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: Add compatible for Kaanapali and Glymur SoCs
Date: Mon,  3 Nov 2025 16:17:50 +0000
Message-Id: <176218530799.3313037.12661315019771733776.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251021-b4-knp-smmu-v2-1-88774e6d2def@oss.qualcomm.com>
References: <20251021-b4-knp-smmu-v2-1-88774e6d2def@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 21 Oct 2025 23:15:54 -0700, Jingyi Wang wrote:
> Qualcomm Kaanapali and Glymur SoCs include apps smmu that implements
> arm,mmu-500, which is used to translate device-visible virtual addresses
> to physical addresses. Add compatible for these items.
> 
> 

Applied to iommu (arm/smmu/bindings), thanks!

[1/1] dt-bindings: arm-smmu: Add compatible for Kaanapali and Glymur SoCs
      https://git.kernel.org/iommu/c/45859c059c20

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
