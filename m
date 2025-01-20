Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C03B1B87F2
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737377601; cv=none; b=tDRV1b6JMkcSE0pHZ6K2EVrjXa27iqeNVSWYgh29jlt8BxHFboZPJCjuIQUNOthOlPt1Y9ch0/tBBGqqLcqQEBV4sRCd6eXjuAPTxPt4TERDdMvO13icZsD3d1zxD2r4mGt+xBkmcdxy8/kmGExqk7sDSgiusIf3jSa1C6J5YF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737377601; c=relaxed/simple;
	bh=zsHFNCa7MUOIvYY+F/lq4yL2WqY8ZnsvklOBRTPPdCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RoGRLhZKjd7DtSeIc9R9ZXwkW5vONaImmDcUI8Bz2KF/8/M6JoL7Rb/MhFqbzGZYJjH9ozeLCb0Qgykodqa8jNpUtCg+XGSWOHI29RSaAEqeNTi/Ib3v+05och4Oo+aYOC698ZA92QemkCAg4RAMJQ5o7yDDniYPURnqNy+Hqmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qx98U3Yx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qx98U3Yx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737377596;
	bh=zsHFNCa7MUOIvYY+F/lq4yL2WqY8ZnsvklOBRTPPdCM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=qx98U3YxpMeplMwSgT+BtySHgoBhVuwjKBsP7C602QSFOMTtIxbti9R5HLnAkU18J
	 jEAKJjAI2C+iuTvwCLOEXAInblTN0o2/f5ILYEoS1TnqIfMi7orrm+zD0WHGAjebON
	 d3n1J0IsGcNj7dCkA5oPdKYOapZRPfh6g5AB/0uVDVyrsiTZA5BsRKNMBe8PfSk52Q
	 3/F7prODWWm3g0vyO6ZQ2sbj4iffSPyJ5CpVGRgmUskLI7cmI8fwlkyGbXlj0MlQ7D
	 JXY/TAS+9EfX/PL69XMtiOPtuRasTbrJWL+3hLeuLMJnkGIo27oNXkNvm3etv0mXaY
	 C8KE+udFcN7cg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EC6E917E0F66;
	Mon, 20 Jan 2025 13:53:15 +0100 (CET)
Message-ID: <92e327a9-d131-458f-8cf2-109023c5b81e@collabora.com>
Date: Mon, 20 Jan 2025 13:53:15 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Use str_enable_disable-like helpers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250114192642.912331-1-krzysztof.kozlowski@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250114192642.912331-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/01/25 20:26, Krzysztof Kozlowski ha scritto:
> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>     operator has three arguments and with wrapping might lead to quite
>     long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>     file.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

MediaTek IOMMU/IOMMUv1

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


