Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B9E6FC3
	for <iommu@lists.linux.dev>; Mon,  5 Jun 2023 16:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64862C433EF;
	Mon,  5 Jun 2023 16:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685982933;
	bh=kzk1uLqR7lhr9MbM4g4pUuPLXhPsS5eosz4kR4msr3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hvY+Tt2nizHAIAgmP5WHt6hWuudvrSwOCe10koDSb3NB8He5rzfv5MxqH06/64Qsl
	 vB6ln02PopoxNU4jIuF7PgdtTKorOSpcLvj2h8MHpEtuOTwMrlJux/UDbAnajiQnZ6
	 fJVm6GDiqXBMKvwJrbcsx/p/Y2DomzS5tSnSYS5B5USJi878hgOiG/XpxEDNPujtE8
	 EImRhN4DcIUKooEg+HpKDOaBxMD2fZ4Ny2e1vRTLmnV1jIg7Kn8NlzqjjzAZotp6l2
	 Yu9uDf+YZe4UEGkM5+QrXbW2HNiXcWStzRF71cblpc5mUu5c3OTKv8kS7HJ3j11+/4
	 LCAcdE7Xdh3zw==
From: Will Deacon <will@kernel.org>
To: conor+dt@kernel.org,
	andersson@kernel.org,
	robin.murphy@arm.com,
	maz@kernel.org,
	Rohit Agarwal <quic_rohiagar@quicinc.com>,
	tglx@linutronix.de,
	robimarko@gmail.com,
	robh+dt@kernel.org,
	agross@kernel.org,
	quic_gurus@quicinc.com,
	joro@8bytes.org,
	konrad.dybcio@linaro.org,
	krzysztof.kozlowski+dt@linaro.org
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Add devicetree support for SDX75 Modem and IDP
Date: Mon,  5 Jun 2023 17:35:07 +0100
Message-Id: <168597991653.31513.630869633781794728.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 19 May 2023 14:39:02 +0530, Rohit Agarwal wrote:
> This series adds devicetree support for Qualcomm SDX75 platform and IDP
> board. This series functionally depends on GCC and RPMh Clock support
> series [1], and pinctrl support for SDX75 [2] which are under review.
> 
> With this current devicetree support, the IDP can boot into initramfsshell.
> 
> [1] https://lore.kernel.org/lkml/20230419133013.2563-3-quic_tdas@quicinc.com/
> [2] https://lore.kernel.org/all/1684409015-25196-1-git-send-email-quic_rohiagar@quicinc.com/
> 
> [...]

Applied bindings patch to will (for-joerg/arm-smmu/bindings), thanks!

[4/8] dt-bindings: arm-smmu: Add SDX75 SMMU compatible
      https://git.kernel.org/will/c/48989c0b25ca

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
