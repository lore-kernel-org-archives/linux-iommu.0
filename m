Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B043750C4;
	Thu, 16 Jul 2026 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784238465; cv=none; b=gTnI8yIuwo/IrwK1k/n7oS+LEX2QRQCguJc3/RkX7d81HWkcfc8jBgq62q8oPEHw+2sgcEtTEsi/I2X67y3mQ+S2Bo7IQuKVsrLTAY0T5qrHIK5FZZuU6In+QjkfVUjxV25NTpEYg3KHPi2RQc4XeFrSiCiNNi5dA3wJXIOykUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784238465; c=relaxed/simple;
	bh=HAgehQhvCwODbuRoOhfsKLbfxYi9CQHPhQ2g8LcjA8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ofxTZ/fD+u70joGHDXqSHLcI1cXvTIhJHvWCAOrp/QGSmBUR7yjXHKb7BSsmrolhV1dsBl+WuBYUCcj1t9gWMMig1+trEKcU8Lbn2U2ZJGF8tnYoFZtz6X9T6MAIOahlCNo4qX8pz1g3Kf/gE5XeBZG6qE7bTAvxdtEs+w4RSto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD3DGrpb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD3DGrpb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49BA1F000E9;
	Thu, 16 Jul 2026 21:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784238464;
	bh=QzYC2qdbmTk5YpQBfxYhnGOS/wmoRI5NDx6J6mkmuKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kD3DGrpbMq80l8QArAqP497uQAvJMJYKHOha5Lw+/Xzv/rLDJFtunw1jyDnwSal4Q
	 BJjWEJjZdjE1Igakqhdd38trtnNYtDF9YCGK/4BCWpbw1QE1iZtqJUkTw3NoXrilEO
	 kUaZXWhS9kS9Yk4w5Jzp8HNh0y79fgX2KGUaOD0vQ6doxBahLhgmXHQFz4fSYkyTg3
	 gIDcHNx6DdT4EF59zSD3tYNMY675+K4reTlauXIK2A0I6wkBegB0Abc/sxe752kD0j
	 gcyxKcLHp6V761y+LudiOoMT9SPOXDrfdmPpUnpHI0O7MhP4jSGcdeJ2Uf2GJvZJqa
	 6D/qNpGujJHNw==
From: Thierry Reding <thierry.reding@kernel.org>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jonathanh@nvidia.com,
	thierry.reding@kernel.org,
	nicolinc@nvidia.com,
	Ashish Mhetre <amhetre@nvidia.com>
Cc: iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] dt-bindings: iommu: Fix interrupt type in example
Date: Thu, 16 Jul 2026 23:47:31 +0200
Message-ID: <178423843029.994431.6172980786421708160.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622065410.2780215-1-amhetre@nvidia.com>
References: <20260622065410.2780215-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>


On Mon, 22 Jun 2026 06:54:09 +0000, Ashish Mhetre wrote:
> The CMDQV interrupt on Tegra264 is edge-triggered per the hardware
> interrupt documentation, but the binding example describes it as
> level-triggered. Correct the example to use IRQ_TYPE_EDGE_RISING so
> that it does not propagate the wrong trigger type.

Applied, thanks!

[2/2] arm64: tegra: Fix CMDQV interrupt type on Tegra264
      commit: e70af6a126e172274d9e6459d80438a46d4455f3

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
