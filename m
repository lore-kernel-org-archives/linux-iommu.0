Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F362F316911
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518226; cv=none; b=LJtaqgN//xiYPxwyLcIa87gLRP8G3mmH7ku+sptFyxGsgshMA9iXDArDqkeTgItEgzqw05kkoka8ktoA7o3HFsosSCdAZouaXNC0f8LdpeOCqqC/eiwo64VWi6tpVlPjJjGiFBfjO7uPp4/et57tMt2PxHneYgXwt8qbeV7p23U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518226; c=relaxed/simple;
	bh=t29c9PtetIvlXp2obnw6JXqlK2zmWW7fIGiXSexeMgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjwkIlpicG2Cu9kvuoGS8LHIcOJqpoOTwtHeU0FFwDYoz+kZTqQTswkZx34HA2PiZhHT+ZZLmNApPhBjTYlR+6CU8EgbivUxzaPZaUk4H+u+ZdmEUL1Ut5ZlINw9mxD6yfPIGZQsLps6WDNqzXJJzBca7E9dy+dbTcKkXBNHVfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jxwy1LCo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jxwy1LCo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760518216;
	bh=t29c9PtetIvlXp2obnw6JXqlK2zmWW7fIGiXSexeMgc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jxwy1LCorlVU2G/siyVim5FEcPV20rrZ4gDiPM0fjx7FIGoPL5hJraFldsbvEg1cH
	 mXse3vmeNjq80z22fd/dBmYnkjBQb5NTWnxxcYlP81egBwJmRoclO7SvBf3vVmzgNK
	 ysr+PspBw5Jf6l5FcgdjeVXNpQFR3CJhhoe5Z0R0HxYPLg8qid8zlsf/+IT5RXg4Zz
	 gGZBGS/mBdUrBRBW2kNyWA6c22wH2m++sHip2qds5qB5YliYRfEb1UTvoKFv/T4fkh
	 7ACa7+rASft6rMcdD/QMHOizCGIz+fPiwUsYBESUdGvRUfqy3PtoQys6ca34quIk0w
	 u1pA1Gb54kbnA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 05B2217E12C8;
	Wed, 15 Oct 2025 10:50:15 +0200 (CEST)
Message-ID: <0848e13c-8eaa-4a26-88f8-a1b7e5da4d10@collabora.com>
Date: Wed, 15 Oct 2025 10:50:15 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] iommu/mediatek: mt8189: Add INFRA IOMMUs support
To: Zhengnan Chen <zhengnan.chen@mediatek.com>, Yong Wu
 <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20251015032509.5057-1-zhengnan.chen@mediatek.com>
 <20251015032509.5057-5-zhengnan.chen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251015032509.5057-5-zhengnan.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/10/25 05:24, Zhengnan Chen ha scritto:
> Add support for mt8189 INFRA IOMMUs.
> 
> Signed-off-by: Zhengnan Chen <zhengnan.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


