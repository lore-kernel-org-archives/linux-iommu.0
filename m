Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440E1BA2E;
	Wed,  5 Jun 2024 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602353; cv=none; b=CAksopUq49lMLjHqXDpthZBf7G9G2cyxCHDdpR2uQaGAYOLpVfmnY866RSBNJ3NVd6OoxKySxIRi71IIF/rRm65qIwoEHDmKwS4SPTA677Ftst/YW3YhAWxcQf3v6vRMTZZPBtYRuxfknGYOTcCOoIINXzFJZgnAxD+NDW9/hY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602353; c=relaxed/simple;
	bh=/4b2Oc13OWrhqsDRfLyVFCNyvQh48mBrU70XCCNLnto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8MryLE4fJ1K1G1BqMAbEg7aGuDXO2YsiNwSoES5HILis2fJz6huLgL9mCA96yNFAcJglxWImhiutVjknRAunVBmFmjq/hXo2be+4OSRAg7Uoi51RXNqP78qvEudaxtTTMhQDL2pbiqaULYkSjHYeIk1Hyf6mhke0d7uW6vXhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTVzir6C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTVzir6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4545CC2BD11;
	Wed,  5 Jun 2024 15:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717602352;
	bh=/4b2Oc13OWrhqsDRfLyVFCNyvQh48mBrU70XCCNLnto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dTVzir6ChL8UP297CNx53xsSHusVOjyZFxWJMHARDlNRt5IDp+Gm7VW4TWL6EoXZc
	 LO6kTcxhKVEmS5V3/JYnyQZgnUC9rPmmSPR290UqLAarT4Ye7Z0vfqbwLmglBgNRAw
	 O6Lv9WIfCacqrm2pdVB3UpoAatcWJqTqxoYH/NQCeHd/c1uoZlbLGcmgazO9qV+3uB
	 2HIdOC3O6n8oOdP5lcbQ/qdCI+fMU9648L6zxzGfd5dQgxq5hUPQ+HPEWwXokr6h4F
	 lmyUglEpNmuodihUDsb/Uia4gTiZ3vfilag+KO0CWD+qL+B9NOSRx3CPnEdMOZ69u/
	 n7+GHNeNIBgZg==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH] dt-bindings: arm-smmu: Fix Qualcomm SC8180X binding
Date: Wed,  5 Jun 2024 16:45:44 +0100
Message-Id: <171760059433.1151679.16301597939945537864.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240525-sc8180x-adreno-smmu-binding-fix-v1-1-e3c00aa9b9d4@quicinc.com>
References: <20240525-sc8180x-adreno-smmu-binding-fix-v1-1-e3c00aa9b9d4@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 25 May 2024 10:58:52 -0700, Bjorn Andersson wrote:
> Update the Qualcomm SC8180X SMMU binding to allow describing the Adreno
> SMMU, with its three clocks.
> 
> 

Applied to will (for-joerg/arm-smmu/bindings), thanks!

[1/1] dt-bindings: arm-smmu: Fix Qualcomm SC8180X binding
      https://git.kernel.org/will/c/e5af06b7cfb3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
