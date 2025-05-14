Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732362040AB
	for <iommu@lists.linux.dev>; Wed, 14 May 2025 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747230241; cv=none; b=OXIEBqyoUbUOYu2ckhGRH8n7AUO38kCfDafVY0WhppUVjwJw3jDb7cKiqxGxRgbJqXrtaIasQuvz3Dq86iXXU+QOiq1SNAhhL+j9W7R5W+qpj4+E8oTi4mpJSAgHaO8pft7b7jSIEKP8osPE3fxdmXYmWUpXecn6w3PSZN6tWYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747230241; c=relaxed/simple;
	bh=jhvYh/l6FiXcGjp04Rwh3X1CLo9llYiEmQf5JBD/Kf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+8RN4Ub9UrGlE7q0nxFi4GhkRrM0KVFyjXg913yb/Pa1MbSKJK7z3mu+Q6h0FJxB8CM9cQ2ZgjyPQH75SSmRTiRskI0t8r87FZ7pX3hhDfYSeFTIBZOyAEbH4bsmNURcFKHnReHZGTHudX8ijTf7SvHOzoBIEwpthaEh3qe/Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RlY0MAC1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RlY0MAC1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1747230237;
	bh=jhvYh/l6FiXcGjp04Rwh3X1CLo9llYiEmQf5JBD/Kf4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RlY0MAC16U67eamGI5lpVkLGVIjqsUpw9q7ecO3jcwQw2aExIhcaen14DlGvFdR01
	 oroEDNOK1JaRGBIqz+l8x2ZFdxUu+ytw3oT7h3DjeNQx3QRnl4n84ezpEEmzUd14je
	 MjuSRwAj6OL4IO2bUaUqaqN5s8sEZpoW2fGUhG/zmFhG6e4rO2t3Z18Qfb4nh9jyX0
	 Kl8JBQGVCiMifSDe07wa4In7HUrWCWpfrbvTD21WuAV7rwkx33xK5orSGX8bGdZXUh
	 lU9PAlao3Tw09FF94MjtAKpM3ozVmjy3Lihmb0naFMYNQa3obHTEoX0J/JVyDtUxv3
	 QAWD64rvgX3xg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0C17F17E07C9;
	Wed, 14 May 2025 15:43:56 +0200 (CEST)
Message-ID: <6fc2027b-2afc-433f-a9af-c458221c96ce@collabora.com>
Date: Wed, 14 May 2025 15:43:55 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: mt6359: Rename RTC node to match
 binding expectations
To: Julien Massot <julien.massot@collabora.com>, kernel@collabora.com,
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?=
 <nfraprado@collabora.com>, Hui Liu <hui.liu@mediatek.com>,
 Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Tinghan Shen <tinghan.shen@mediatek.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, iommu@lists.linux.dev
References: <20250514-mt8395-dtb-errors-v2-0-d67b9077c59a@collabora.com>
 <20250514-mt8395-dtb-errors-v2-3-d67b9077c59a@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250514-mt8395-dtb-errors-v2-3-d67b9077c59a@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/05/25 10:19, Julien Massot ha scritto:
> Rename the node 'mt6359rtc' to 'rtc', as required by the binding.
> 
> Fix the following dtb-check error:
> 
> mediatek/mt8395-radxa-nio-12l.dtb: pmic: 'mt6359rtc' do not match
> any of the regexes: 'pinctrl-[0-9]+'
> 
> Fixes: 3b7d143be4b7 ("arm64: dts: mt6359: add PMIC MT6359 related nodes")
> Signed-off-by: Julien Massot <julien.massot@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


