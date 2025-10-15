Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAF93148CA
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517957; cv=none; b=h0UtkW5Z+D6ZhKNFeYxYGpOe/32kEH83X99lzTogQzdpSgrFjEnL1CkbzhqYnaQwn7Adp58e3vETSUXlqE/dlxM7K9nbUUWx2FNPDQ3uiK2WenzErhJkW1vHk05+QRfYm14rYznSRzaCL9OBO88zz65ir8MtAgWUv7Rz8iUgYlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517957; c=relaxed/simple;
	bh=XOGY5weYjz0PiayCterLaiEnlsWjQtw9y9up2bDmOsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SS4jm/hMWEBAQchuTwklpTNLK8JgFS72Y77V5oZ826NJd68WYDOfTZKBqA4q5tqvLm2J6LiRwDFH8pd6kO1mbJ/3xm/o5yMzOpwLL2bm1jBhgGV7G+k0Xzz0LNvc2YdQaQga/1zGHSfZWc2lCuEq8vEgqcmo/xTL/ywxJ7uJMic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GjkGHF67; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GjkGHF67"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760517953;
	bh=XOGY5weYjz0PiayCterLaiEnlsWjQtw9y9up2bDmOsg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GjkGHF67ScAYrb7IvLKJvMSEUfi0mN2Xa/y5Rcfy4tOIUPekVBfiaLoo9l79yRkQb
	 hetxLA6ID23ZEsfTHO5dEC6Oz2kJ+MTRfnVAWDPDwLeBpVjs3G6tJuj6B54BoUDkUe
	 tF8YJZjguG24puC7gXYHH/yDij89WPu6z/TJhv1j1W1IrA+wpLR6XzGMJpCEyjgq3c
	 A7dgr/Yv2Lf6n/cLaIOd4Fvu5N2E1GhcIvGwXy+QMszSNLJBguBkwUNKXT2P17Ibw/
	 arrU+qH+5cMN9Nbs5XeVuFs8T4c3h8MBUnnfExI+AauUjTFw7CamhW2jebZaLckFB2
	 xTjl8zWTjlhtQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DAAD517E1340;
	Wed, 15 Oct 2025 10:45:52 +0200 (CEST)
Message-ID: <02c98be4-6baa-42e0-a226-506a817c83e9@collabora.com>
Date: Wed, 15 Oct 2025 10:45:52 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] iommu/mediatek: Add a flag DL_WITH_MULTI_LARB
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
 <20251015032509.5057-3-zhengnan.chen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251015032509.5057-3-zhengnan.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/10/25 05:24, Zhengnan Chen ha scritto:
> Add DL_WITH_MULTI_LARB flag to support the HW which connect with
> multiple larbs. Prepare for mt8189. In mt8189, the display connect
> with larb1 and larb2 at the same time. Thus, we should add link
> between disp-dev with these two larbs.
> 
> Signed-off-by: Zhengnan Chen <zhengnan.chen@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


