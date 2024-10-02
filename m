Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B911CCB58
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861612; cv=none; b=IAxvm46m9PHM2MBdal3YCwnlaRomtgUksU11A+cp5VmSBtVp3RjCHlikqlhgVtCW/0OExtlaskt6kDZSHJVa4/AIwqyKWGd3Z1J1jrX8R54b3hEJYwdiCEy2L0g3vQbS/2HUwhIjvK+UvOwdJsSnWe7YG53rMrqLMQ51P55CY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861612; c=relaxed/simple;
	bh=njMg/9RI1rTkCGQDwWauI7hP2kFYOcqvpE1iClQ224M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nmMpitsKBv6w3KobPeacQpLNsifTp6WRSIYpA5imR2CHYsGIv20oaljvmWQ3Ge0lEkwvPbohPTcYpAm4g5PgVwyTrmxt5T5LeVuPER+k28weiU/8Wn50g1F/zUlHctOUx1KjuEfKrWKu2sxqeiWfpaNiuzzoyYj207MsXRSFrcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kLqObsbj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kLqObsbj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727861609;
	bh=njMg/9RI1rTkCGQDwWauI7hP2kFYOcqvpE1iClQ224M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kLqObsbjFwS3kY6Nc6E0IPIIAOHgFf10svfRZIS/xyS+ycUcrWhUfaVjIv4jOKu/R
	 dQ8UjzMpzv7T8bQKCHZbWZpfEHu1DkPNoHmNk21HdrSnNctsM0amLlWcfcj98QTS/x
	 1iXNqP0knFJQsHYd4Uw7kthQALxeTKHFBTxlN2bNHMGkaKTXPYitGdF56vNO4mohOa
	 xUlgCub9uJbaM3OGd2WN0jZqs6C5F9knxB9I3pH+F3IaW1U5FaaLSF+IN6ZSeGCdRX
	 DT4cE3xW9UNMvhcqVxNze+9mKdc8hZe97QoAbelEJWnKq+c6u5cHV2Z2VhSczjV/gm
	 gUBRmv0XA32SQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0398217E120B;
	Wed,  2 Oct 2024 11:33:27 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Rohit Agarwal <rohiagar@chromium.org>, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>, 
 Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, 
 Chris-qj chen <chris-qj.chen@mediatek.com>, 
 MediaTek Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
In-Reply-To: <20241002051620.2050-1-macpaul.lin@mediatek.com>
References: <20241002051620.2050-1-macpaul.lin@mediatek.com>
Subject: Re: (subset) [PATCH v5 1/5] arm64: dts: mt8195: Fix dtbs_check
 error for infracfg_ao node
Message-Id: <172786160795.39477.6513480009726463898.b4-ty@collabora.com>
Date: Wed, 02 Oct 2024 11:33:27 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 02 Oct 2024 13:16:16 +0800, Macpaul Lin wrote:
> The infracfg_ao node in mt8195.dtsi was causing a dtbs_check error.
> The error message was:
> 
> syscon@10001000: compatible: ['mediatek,mt8195-infracfg_ao', 'syscon',
>                  'simple-mfd'] is too long
> 
> To resolve this, remove 'simple-mfd' from the 'compatible' property of the
> infracfg_ao node.
> 
> [...]

Applied to v6.12-next/dts64, thanks!

[1/5] arm64: dts: mt8195: Fix dtbs_check error for infracfg_ao node
      https://git.kernel.org/mediatek/c/c14ab45f

Cheers,
Angelo


