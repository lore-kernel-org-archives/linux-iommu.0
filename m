Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC923A7F59
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486627; cv=none; b=LBRPybpYbE/iLOX/mO3cbLrXeIcEw4IXf8xw5MUb0qBDyqkATqr+zRVrtafcGlbXGy6R3f0616rBN0GQH+18F2RWpMRCZ8ZkB70qy/eH52wFrZ7VwrYZJQDhz6AasV5zpKEHBQu3yBtPifYKSZApAWTtiR2PMUgIiSn7NU8WdmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486627; c=relaxed/simple;
	bh=OOD9ejGOq1GD23MKZbk3wWbT69dIL2i532BvtjlqEA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stsjZBydM/h1jbExYRo1WbLy3eYBJSB/AjNt06GLr+noHYMlGJC+DDfFV/AGVK7a+KczCkfEbP8YLjisdpQgeLV7a+HXV+g6wRr93aptPpMRdoQ4/wdJ5WdRSuuU6SkZG5jB3GgEh1tGISXR64ebtRQxR7YGA0BHfviV4UxTWe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f/doleWf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f/doleWf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1778486614;
	bh=OOD9ejGOq1GD23MKZbk3wWbT69dIL2i532BvtjlqEA4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f/doleWfbDXAM+7D0dCxYoFGCSg3KnthDXDoMsGPNoO3k35eOH4dooG6z9nefPe4m
	 86J4pMorgiQXIkBkd21pAlpC2AeiUWpjcf0stP7przS5L5MLautRM62dNU9EbOoPn/
	 SoTri/wqpYBMsDiBvaKFSw2RZrAFAnP7bwk8ZIEjqlVXYrmIZECyBbiK62sbV4yo84
	 YDUTGNXVu+HFsVE3vwfEaToC6nxAlb5euL0wtj2mpqmagLim1Nrhyleipt57V5yvag
	 UNwpGmlc9xOgcDCR8P1sRCuOfaN6TmGPjcJm5J9rl/2qT/cA+9kFKfGFPdv9zu+ixJ
	 ZftEEEt9NS3Bg==
Received: from [100.64.1.43] (unknown [100.64.1.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 44E1E17E1004;
	Mon, 11 May 2026 10:03:34 +0200 (CEST)
Message-ID: <57c8310f-c972-40b2-96ed-90358d96b2ac@collabora.com>
Date: Mon, 11 May 2026 10:03:33 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/5] Add support for Verisilicon IOMMU used by media
 codec blocks
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: will@kernel.org, robin.murphy@arm.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com
References: <20260415072349.44237-1-benjamin.gaignard@collabora.com>
 <33nsz23rcstwznq6dnsuibndbwtoc767evshltj35kgysdg63r@fxhwobu53cww>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <33nsz23rcstwznq6dnsuibndbwtoc767evshltj35kgysdg63r@fxhwobu53cww>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 11/05/2026 à 10:01, Jörg Rödel a écrit :
> On Wed, Apr 15, 2026 at 09:23:36AM +0200, Benjamin Gaignard wrote:
>> Benjamin Gaignard (5):
>>    dt-bindings: vendor-prefixes: Add Verisilicon
>>    dt-bindings: iommu: verisilicon: Add binding for VSI IOMMU
>>    iommu: Add verisilicon IOMMU driver
>>    arm64: dts: rockchip: Add verisilicon IOMMU node on RK3588
>>    arm64: defconfig: enable Verisilicon IOMMU for Rockchip RK3588
>>
>>   .../bindings/iommu/verisilicon,iommu.yaml     |  71 ++
>>   .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>>   MAINTAINERS                                   |   8 +
>>   arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  11 +
>>   arch/arm64/configs/defconfig                  |   1 +
>>   drivers/iommu/Kconfig                         |  11 +
>>   drivers/iommu/Makefile                        |   1 +
>>   drivers/iommu/vsi-iommu.c                     | 796 ++++++++++++++++++
>>   8 files changed, 901 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
>>   create mode 100644 drivers/iommu/vsi-iommu.c
> Applied to the new verisilicon branch.

Thanks a lot.

Regards,
Benjamin

