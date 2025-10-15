Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5573164C0
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517955; cv=none; b=VVTSLmeq05tvnQLv59HV+0OZHssWsAJ8yZKdCDb5/FSy6VqO5rWZ90cYIDFD9KM5C/xmO/yHZRTNH+q5Xia0WanxZhYXk821nu+nllnxSzyU+0QCdpBNOjiGQFGLSgciV9EEjGX7vaIJ9nfOf5q+HNXdD337p/5Pu2AZXd0wD1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517955; c=relaxed/simple;
	bh=Tu2AHP6luKsiurT9a4lne7CLhn3ugAJtHzpoSPKfhdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6qTNyfNS6xxJN1eSIU57EG8UgpsBskQ86R9JP/pyKGMrtsakPQdQP7coBEYPmtt3NGMvCkq9+DMuZAS8ePKsIzjUp39R5kt5lazW5PttP6sv9Lb4D5MLhCiQojAl2EGKj54N+aV7cFqBHqCzKPZ3gTA/CAa5l9Koh5WtBasBXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Lv2Kd0vb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Lv2Kd0vb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760517952;
	bh=Tu2AHP6luKsiurT9a4lne7CLhn3ugAJtHzpoSPKfhdY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lv2Kd0vbfl62sJunmw3iykR/1ljZJmdB/GF+Phrrn4JOMG9LzAsRvx/IFYD2keek+
	 TSjylyC/je4k3u/A3Eo/S8XOSGnpAh+ON5E80+jeuaR5uBFDPaBS1JbZ3hVforhhET
	 Y4IfQ0SoKtFzeZ0ZZpZwy9rbxMwpiZzBGbeKEXptqafn2mLdk9EMNK7O0z/96R7my+
	 4YSdYcCYrOVexFic8NA+5bpfVu2/nZrOfydptSPAB+ORYcLj1XK0vKLAaIDIG2nYBR
	 DWVoRvxcTZhQkjQOw79WkeXy+lY4VrDOuF3LkERB9WOCBwuAFPGGXZofYv2n1ghcb3
	 0g7uL4CHIutXg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6078417E0C54;
	Wed, 15 Oct 2025 10:45:51 +0200 (CEST)
Message-ID: <cda37b6b-1ad5-48b4-b861-ae49297f72cf@collabora.com>
Date: Wed, 15 Oct 2025 10:45:50 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: mediatek: mt8189: Add bindings for MM
 & APU & INFRA IOMMU
To: Zhengnan Chen <zhengnan.chen@mediatek.com>, Yong Wu
 <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 Conor Dooley <conor.dooley@microchip.com>
References: <20251015032509.5057-1-zhengnan.chen@mediatek.com>
 <20251015032509.5057-2-zhengnan.chen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251015032509.5057-2-zhengnan.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/10/25 05:24, Zhengnan Chen ha scritto:
> There are three iommu in total, namely MM_IOMMU, APU_IOMMU, INFRA_IOMMU,
> Add bindings for them.
> 
> Signed-off-by: Zhengnan Chen <zhengnan.chen@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


