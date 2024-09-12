Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F801A4E85;
	Thu, 12 Sep 2024 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726145839; cv=none; b=l6zhQGSDuK80SOwBr0+kWmO+9RmKy/krRzd4uSCopYJtmV5WGLy8ozpOV5Zn+US9+7XvF/ZdwPs0YCmZ4x7VlixZNIE5tK8PywabyNZnJBA9WQt/9khtN7cfAXFFYPGfByFdO2nH1DilHe3ur1P8zYnbb+ohruCMf9OX/QROMnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726145839; c=relaxed/simple;
	bh=p7nGimO1GKfTwPQf1MdOhdY3Sb1Jkm8Wrmgi6DDC3pA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHHEc2ObIyGFRybcVFNWH2tZbHOQ8QLqmbKEHlGdwxYdmcP9Pczdn1THPe8T414QluQfwBYreKspMMRJT1DAD0GAVUFsbvd3/drgEld2YPMQqzl56Ak22w7/ISzdcNHL0mdsn+He9rJndvH0aQk39MYUA1n/9V50AeeZ9AlfVYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvlv0HDy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvlv0HDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8324C4CEC4;
	Thu, 12 Sep 2024 12:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726145838;
	bh=p7nGimO1GKfTwPQf1MdOhdY3Sb1Jkm8Wrmgi6DDC3pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bvlv0HDy2btq73DZGGGQnMVyGQica/rGdoPAkg6mOi4jCLpa7SBhqjjjf4+kjUIsV
	 17yJPvfLbilqGDzThDOy7t+Nt9daU8cM5ExqQHRwEcLnlCiRRFaJgTj+XLYlp4YN1o
	 1z0Y3UlcGYPjEzpkTUjOJdaZ0eeBYhckPnW6FWkZvnUjkmTC0D6ZOg6CpiNyLS+Ix3
	 6Yz9vtcFODWICzOP4NS3wbfsnpttscWklL7R2FmW0YiNooPyvjXE7P4gcdLN8aR4f+
	 2nlwaPyqviWkQ+Avb1V2dgfxzUTwboSXD8hwSaAYzBxKf5A3/zqSXLBUF3V1h79i7T
	 jgQv3HnUrfZhg==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jingyi Wang <quic_jingyw@quicinc.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	quic_tengfan@quicinc.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_tingweiz@quicinc.com,
	quic_aiquny@quicinc.com,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: Add compatible for QCS8300 SoC
Date: Thu, 12 Sep 2024 13:57:08 +0100
Message-Id: <172614192441.4013779.6322517245790684641.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240911-qcs8300_smmu_binding-v2-1-f53dd9c047ba@quicinc.com>
References: <20240911-qcs8300_smmu_binding-v2-1-f53dd9c047ba@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 11 Sep 2024 15:18:54 +0800, Jingyi Wang wrote:
> Qualcomm QCS8300 SoC includes apps smmu that implements arm,mmu-500, which
> is used to translate device-visible virtual addresses to physical
> addresses. Add compatible for it.
> 
> 

Applied to will (for-joerg/arm-smmu/bindings), thanks!

[1/1] dt-bindings: arm-smmu: Add compatible for QCS8300 SoC
      https://git.kernel.org/will/c/4638a0474d34

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
