Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA14481235;
	Thu,  6 Aug 2026 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036324; cv=none; b=XrESXIKKS7gyCOPpSqZ97/090GZEsCOh1nMxbe5q3xpQbATRLJPpiIbxb1xiSrt3RGSlgGUbhS1HO4j/yGupi/1GSYFNwfWNDFSfKGTQaSwsqRi+/W5QSoq3EG9uIyx5F5e/79q0BgMCNzwc1LgtCp+nJO6SuafDYIs4Ls83dyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036324; c=relaxed/simple;
	bh=BnLRLUuW0HCuDHD60R6MWgkjLx0zp31VP1O98JjARRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvCm53qoyuzw/l+235bGGKk8mqdb0CbUYN3c8P51yxjKPIPdHz/t1/B1h5NYk7b/D0fKqoKgTbecQ70i16zk4psNVMxMqQZlJKkmd5U7evXUelMtt5yzkjuMfsGaKSfb5ZGEMDsTgQMlAuyv7IRqT4fzCuTgsYAUQkLz0kx7fa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZGulFHm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZGulFHm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EF11F00A3A;
	Thu,  6 Aug 2026 17:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786036322;
	bh=nc0GZEveyNsfDrAwQEPhop1DRFKVu2AYZuwNyht0URA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HZGulFHmp2kRydQcX+HNixq1fQGz3Rl29xnmQfAkrAmykBfoHo8Nq/4xOrrNca27X
	 jT9nyRtSD7+hhJr6wbZqIzOKhvh6uzLHz6x3LGYMd36xREbB3L4skkNe8umNghNmkp
	 fwN4AvN48za6TfxrYVcSSyCnWEC5SVDENlzwePvwudD1bRqGdSJv1JnD/QtHhHIxAK
	 yZ11HliiBp2Hwx3Z/T3qTZvtSA+vQ1I6pXvvurL57UkiRw0SkR82ciLI6/6vr161ze
	 QPqEyzWDpI3ahaChlGle/uCNUp1V83hk+i+rVobryhSyQw0e2OOlh+tgTrWVTAvUV3
	 iBLVZaG2TJ7OA==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: qcom: add compatible for IPQ9650 SoC
Date: Thu,  6 Aug 2026 18:11:39 +0100
Message-ID: <178601639875.384211.6516528975191609551.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260731-ipq9650_smmu_binding-v2-1-143a51c8ffce@oss.qualcomm.com>
References: <20260731-ipq9650_smmu_binding-v2-1-143a51c8ffce@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 31 Jul 2026 11:01:26 +0530, Kathiravan Thirumoorthy wrote:
> Add the compatible string for the APPS SMMU present on the Qualcomm
> IPQ9650 SoC.
> 
> 

Applied to iommu (arm/smmu/bindings), thanks!

[1/1] dt-bindings: arm-smmu: qcom: add compatible for IPQ9650 SoC
      https://git.kernel.org/iommu/c/02f1359b1143

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
