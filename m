Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE343EA95B;
	Tue, 19 May 2026 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204241; cv=none; b=NxDiF3a35Wq8yaYPWN6BiYpeXNLuuZMLA3vmVh7eGOq3woVbCmseqCrWhJFSKA9VMRQs9UhiJiiJPxvF/he6l1xtnbgIE5xTCieDpZy5cYSdkAJR4rNojjgIElSz8T+y40YT12O+8JxFRG31iG8UBdWMWs8yDHpujPeqL9+MVzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204241; c=relaxed/simple;
	bh=D/PAHA23j1HXXTU2QCXdtDypXNlUffAPZMXfwziQEQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zz2B0KajfjbEzjYhvbWLLyyaPfFw+pl/qgQ2XUx1Z/RRokH7G5efeEzlBagOwetKcce6MT9Y5dnJ0C/KjdcWVocVNfavbSLfSHE9B7InMNWbdLrCbtAIVE6HxYQWl2fGzGj4bxW0bSFp9me9+TWF23Bc7PVuAhYLZ4/Hqgz89pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=py1H1y27; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="py1H1y27"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2FEC2BCB3;
	Tue, 19 May 2026 15:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779204240;
	bh=D/PAHA23j1HXXTU2QCXdtDypXNlUffAPZMXfwziQEQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=py1H1y27Qw9ckoMFQ0oCPrD2GbTcv10C8kHet4RxQHAzv1OvXWprUioT5Pvc11PM1
	 T3u4DsC+oCRxG3x/TsuIYMdQ7EE/2D1yjgKuDARYIR/cIhWfyIS1/EpMBEHMHHMFhk
	 0nRchv8MLrsWONoS23+mF2L9yUrA1NNiXMcoVQwZAWdS/+nC91BM+Sh88nbTv8paHS
	 LH4a1U5mog5VaIkY1eTvN5/aNfg5u/Xi8ofGj+F6MF+uQBUipZxf4/9Jl9LJHmcgwe
	 3NNWrrE5KEFHEsR2ylArzy/KJNAClKTYrkZvVwKlUhwdnn1g3bf70Sq7c13oNiH1np
	 iA6pQEdX1RJsQ==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm-smmu: qcom: Add compatible for Qualcomm Shikra SoC
Date: Tue, 19 May 2026 16:23:01 +0100
Message-ID: <177919159473.817912.7697068787428918777.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430-shikra-smmu-binding-v1-1-1a28572ebccf@oss.qualcomm.com>
References: <20260430-shikra-smmu-binding-v1-1-1a28572ebccf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 30 Apr 2026 17:54:44 +0530, Komal Bajaj wrote:
> Qualcomm Shikra SoC includes an apps SMMU that implements arm,mmu-500,
> which is used to translate device-visible virtual addresses to physical
> addresses. Add compatible for it.
> 
> 

Applied to iommu (arm/smmu/bindings), thanks!

[1/1] dt-bindings: arm-smmu: qcom: Add compatible for Qualcomm Shikra SoC
      https://git.kernel.org/iommu/c/5091bfe5d4c6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
