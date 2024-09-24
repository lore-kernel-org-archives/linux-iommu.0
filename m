Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4201A4E94
	for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727177857; cv=none; b=F4W1b+dJAAQEiBiDbdTQsqPHqTw1KlDVM1cObGNSiSNVTIdmlkLj7ub0BXdVeH8CDgBf8M+4g5x2sb4P8JNuM4sTTeKgFlJn6/2yxmcdS7nnrz7S+rQ0AxJB/9dp4FNUQGKCLJ9Q4gLK003skKhauNsIeqMrIoDnXW9R+f/9JJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727177857; c=relaxed/simple;
	bh=ZNGj3fXHWNs2Yk3ko4od30ZdDG3zCz60t4Vi+H2gtZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/p02KGN9NUCuql6qkZwCrrAEQYtXRfFK/PdPiSoXKzdj3EFWkpb6t8RTTQvIUPG0fCLo/IycCUIHuxyCn4KVJP/uSVqdSPuEcu8vTk8+8tL5JyLgGUtpO6IvpSlnWqTCvGnbgfcpnDmeT5JpAc3FbuTfI4kbkG0gjvv9rBQH2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qVNGk8xh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qVNGk8xh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727177853;
	bh=ZNGj3fXHWNs2Yk3ko4od30ZdDG3zCz60t4Vi+H2gtZ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qVNGk8xh/0Dq8GQ1/4BfpatCqrWfmnwGhgki469IObqRc1ZnyDbIcn/WzoW9Re2XM
	 Cik24nKD3FoGA7erHPx3DnbbQB3e2j44+TyCO3QqK/huM+IJe2jsHF/GRt6OJ22q6s
	 /X9QVoJfvia1Bv3ViHSspzXUBQVvVnszIS1zHqfzqKE0121iX9TBNGcAeOO7AkNUt2
	 EJdfXhhPdsJ3ttI2HYIe/KbBEbuDqtgcKoy80NWUa3ilGESyvJ26YtnqqDgqOdy779
	 ztzFuV6IuT/UPFz9ULNu3iFh3eEl5aygmOVZgK/iiZLeQPDwoi4zpLZ8AI84126DZZ
	 HL+FLuJvQn2AQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 971C417E1245;
	Tue, 24 Sep 2024 13:37:32 +0200 (CEST)
Message-ID: <459b17d4-439d-4f09-aa0e-f18f9cc184b3@collabora.com>
Date: Tue, 24 Sep 2024 13:37:32 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] arm64: dts: mt8195: Fix dtbs_check error for
 infracfg_ao node
To: Macpaul Lin <macpaul.lin@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20240924103156.13119-1-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240924103156.13119-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/09/24 12:31, Macpaul Lin ha scritto:
> The infracfg_ao node in mt8195.dtsi was causing a dtbs_check error.
> The error message was:
> 
> syscon@10001000: compatible: ['mediatek,mt8195-infracfg_ao', 'syscon',
>                   'simple-mfd'] is too long
> 
> To resolve this, remove 'simple-mfd' from the 'compatible' property of the
> infracfg_ao node.
> 
> Fixes: 37f2582883be ("arm64: dts: Add mediatek SoC mt8195 and evaluation board")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


