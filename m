Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9968313E1D;
	Sat, 11 Jul 2026 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783799401; cv=none; b=cXYnTDQBjxZvciFt90HhVELFrINwNYsm7h70FArLYQFu5OZKQGUDMbGnqjW5Am5u8t5a3X+LV1EQSgKOQNGNA96U8Eb9rBuiO19OpK3yqeJdX3ttfzRJb6jgFmd1dGbvivh0+4aPzlbym2mpumYQiWBPvCBrKkfPFFsf+pLtuG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783799401; c=relaxed/simple;
	bh=UD0X/VlrqvntugIHHINEwVGMXYZSo3+os2CpK2Uq+9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZajnVzYsOUYX3Ktc4uYFatQ3ibctYHB5ygTNfTWyKjlIanKQXMmMVIVCBPRd6d0GyeO9fzSCn0ImB0sd8UJLcPyKm2Pc+YZeyynjWG0KwW4KN8a94vHFy265aiCdqyZk57OqGxnpeD3OB0ulDESDLZG/qeKD6F/RUV7pDOx2sbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CV9cizgU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CV9cizgU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3985C1F00A3E;
	Sat, 11 Jul 2026 19:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783799400;
	bh=4KW0mDYxxvCs+MdA9V1BDmlww/e9OaKOFuPRGtfySv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CV9cizgUZHxiVfZXVePzS/iz1smxoeAzfg53JhpVEBDDs2dK+lKh4yPOFlQuvPZqT
	 0CMXJRjGOWp0LELoIf27NMEyB3rQL16ZTiK6wmedmZwiDiUW2sQd5L603zYP6zYS5S
	 +MFApwjk6Eo/G/nVi2hpt6/qjlzecRO7UCWU7ZeWNPneg1+MVCJZexWE/EFGGlePOF
	 dj1Hy3hFGSwb+r/S38zRYqlR9XQ52LBwmRbr0YX22TLYVwg/AEX5izEp3g+rdvwRIL
	 vTQnCZRxYFA5KhbHFySxlDjDhsA0spuS+VGh0pAapzjSDUUaXKxxqHLKMIafgHjjVF
	 p5xy1mvG0I5aw==
From: Bjorn Andersson <andersson@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Esteban Urrutia <esteuwu@proton.me>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org
Subject: Re: (subset) [PATCH 0/8] SM8450 QoL changes
Date: Sat, 11 Jul 2026 14:49:40 -0500
Message-ID: <178379938594.163099.2250376340461760537.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622-sm8450-qol-v1-0-37e2ee8df9da@proton.me>
References: <20260622-sm8450-qol-v1-0-37e2ee8df9da@proton.me>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 22 Jun 2026 20:54:21 -0400, Esteban Urrutia wrote:
> I've been mainlining an SM8475 based device for quite some time now and
> I feel now's the proper time to start submitting patches.
> I'm starting with the smallest part which are mostly modifications
> regarding the current support for the SM8450 SoC.
> 
> Regards,
> Esteban
> 
> [...]

Applied, thanks!

[4/8] arm64: dts: qcom: sm8450: Add missing PCM_OUT port
      commit: 9c510bde799765bf1d28004b0e6555e05565f464

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
