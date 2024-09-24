Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0762D1A270
	for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178199; cv=none; b=aBIwzWQrHUCDGenrDggPJYXo9/zZLvsQzl0H81ufJPcLQF2gilnVxGxMhyZqLA21OZH/yk1rRy4MxmDOCaI1Nol37ek6EeVsQejM9dkSjh+S7z+ehI2JCUKHsFECtZUplLH2sqgPjxCy4pS91Jzin6VLoBJ7+7CRfYZVz6yWDU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178199; c=relaxed/simple;
	bh=SU5MDVugN9wq2UPurRQrLx+qX4c0j5tAS7Phiv68XM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1UL4kdDxQR0pHQdvsFPT6YJOjtHjZ4j4gKDL1qfTovMZ76E3LLXnmU+TAkXLCC/bvyzb6r/AD3Oyzc+RFCwBplOPm5pgvZgcZeg3sS75D/JH4X/yM/SGvoX+PjhR2kVktVmdlldW28MLB7IceMBJxXBxVxUerXrIhnc3friW5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Wi77O6rq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Wi77O6rq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727178195;
	bh=SU5MDVugN9wq2UPurRQrLx+qX4c0j5tAS7Phiv68XM0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wi77O6rqSD6tSZk8btni0aIKEOC6piGPVcqP1Heu5337fwpUGa50wSEojpHyHu87I
	 atAAuVDZFLKRV3Nud4DRyR7k7HryJuTUsY5sP8urmJXVzk4M0KE+C4PYEJG7CGalHW
	 aEi701FKGVKOOKWrqwg3RSkkW3OaVOWX3u9TmDhQ735c68De37y5Cy4UYyVsqkrcXm
	 4njlzguOP3/pRQCtKNk9TbjkqwZq/vLFKjqXe63ZuchL/jCQaawX0z3WDCfKLdypzs
	 rdFAywR+ocmuqagsyGYhs8cHnTKNn1azKASnWgt4rD1gg+SglTyfnTIB0O2yCXz0kj
	 oUtc6ybxbechQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2505217E1250;
	Tue, 24 Sep 2024 13:43:14 +0200 (CEST)
Message-ID: <0b573e20-e08b-42e3-bc45-7db07fc6cf57@collabora.com>
Date: Tue, 24 Sep 2024 13:43:13 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm64: dts: mt8195: Fix dtbs_check error for mutex
 node
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
 <20240924103156.13119-5-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240924103156.13119-5-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/09/24 12:31, Macpaul Lin ha scritto:
> The mutex node in mt8195.dtsi was triggering a dtbs_check error:
>    mutex@1c101000: 'clock-names', 'reg-names' do not match any of the
>                    regexes: 'pinctrl-[0-9]+'
> 
> This seems no need by inspecting the DT schemas and other reference boards,
> so drop 'clock-names' and 'reg-names' in mt8195.dtsi.
> 
> Fixes: 92d2c23dc269 ("arm64: dts: mt8195: add display node for vdosys1")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


