Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335F1DD0DF;
	Thu, 24 Oct 2024 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780977; cv=none; b=CTlillY8xw3iQlx7N+OIXC6ICarNQ/UMtmPYoTtoT3M9WowpIVJseSzwbv8IorCsTQlNVBd+Q1ZlcIP38QRtb0LW+XSgOaN2qLNbYHK8M6EJFQjKRRElqlbvPnqidQHZoox0JrKthXHuRF6LQzSiZcTsjJVeAquToC2ZXB5yQdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780977; c=relaxed/simple;
	bh=t0OZKA4n9mqRbbHhAysa4Kw5aWrJMRzwz3vf4umP7xM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5uTA38LQt+gijZHPagIyhcBxJbRIIGES5et88U0JDaJa2lrRucOb3acDQv7yZejGbfsmRIgSV19cqV4xfQKt4BBze7tAL6ONHklHtqVK3skyoKmvyq7yPLdlfgyMbkiIA3FR4vn6FOrUBZW4PMJ7EFfaiWjef18k+Fu5WmXS4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYKDodnz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYKDodnz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C01DC4CEC7;
	Thu, 24 Oct 2024 14:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729780977;
	bh=t0OZKA4n9mqRbbHhAysa4Kw5aWrJMRzwz3vf4umP7xM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DYKDodnz92n7qFauFPJX856mxEtkMRGNMjwUV3bSfuD0OhqE5y777vSTQMVai1eby
	 dezWu7I0s2pZn1/Md7UiCeTTCrgNR1nBVE9tS6lkCVmT9ZLVNeKhUvBdLZSN0BdVGW
	 RFjOBNBgcI9snA5UIgyKtbIYtKsecpcQ9xnhQ4MqRIKwB/SngBKoIPvGU0G4B2TM8h
	 t6lHtDvX+RLgvrI+5nVZdQ9PFa1l+UYKZk/nvAMuwfV1BpkhYMc3ng7/nnx1C/1fiX
	 gz4f4dJJALNX0HfLLnlpkWNGbaAU/ICOGkGlEc2cf78+sPwMA11DkdFGg3yalKt8tB
	 SU9IfRILVVs8A==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Clark <robdclark@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iommu: arm,smmu: Add Qualcomm SAR2130P compatible
Date: Thu, 24 Oct 2024 15:42:49 +0100
Message-Id: <172977349100.1427890.9934602061209095444.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241018-sar2130p-iommu-v2-1-64c361fceac8@linaro.org>
References: <20241018-sar2130p-iommu-v2-1-64c361fceac8@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 18 Oct 2024 11:28:46 +0300, Dmitry Baryshkov wrote:
> Document compatible for ARM-500 SMMU controller on Qualcomm SAR2130P
> platform.
> 
> 

Applied to will (for-joerg/arm-smmu/bindings), thanks!

[1/1] dt-bindings: iommu: arm,smmu: Add Qualcomm SAR2130P compatible
      https://git.kernel.org/will/c/0ddb903fab63

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
