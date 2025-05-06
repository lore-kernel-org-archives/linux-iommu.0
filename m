Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2839263C9E
	for <iommu@lists.linux.dev>; Tue,  6 May 2025 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746526853; cv=none; b=RypXp4xXdlHp6swxDbN9VPRjLVcOUWWzIdaAmzaqGk4L4gC8ckMsow7UERiSNcLom2xgB+/6siLxtQeUtMn5RgFgKHmGdxP2peYWk9JNKeXoxu+cGjGDP5rcF0a7d7QrHWDTfPVnon65R1zyrMJTU5mh21trxA0LCGiuiAXMYsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746526853; c=relaxed/simple;
	bh=cTlctsLV2/rm79eOqeotyVv+FV9QLw5D/EGMnFgswkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHN17POLYJsfDoXdIuaLa93+jHb4flPbcnd7WZU51R/0eUjs2lcSsdSSBehuLyU+an+dqa01Kf5GmMlX3IyahlO8D+6lRuA4Dp3Y7F22Qg8qGh1/w0UrgM7nIkG1eUxds7lhzjCLWEsOdqVGVpoaGrM2jxSor0OshcNOJVLJano=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Oic6ZbqM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Oic6ZbqM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1746526848;
	bh=cTlctsLV2/rm79eOqeotyVv+FV9QLw5D/EGMnFgswkQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Oic6ZbqMxNknj0hcfe+ZvNlfYvKMruLwQGy/idLjU5+wHNR2dqVkJ+YfCmH1IK6WP
	 bkuqQJLdrFtkcvwYnNM/MJ+GEBjIlpCFFalEaVWlq/x9f/EQNdTH8gJwtZOeWdCGHk
	 iAL7PuEQ2kl1x6OLuV3IQVGDmRzUFEZ8K7kJSQU4wI7tOUGhNmpkxFWwV3WRIfCU4i
	 YQDbrbhm99KAbgZQQLZ2RoZsRevMRvMiMUmC26hB0OsJMyPxrzbgKMcAi6b5B/s1b/
	 S16uKYZkLIj1dZGqinA4nvSK2rOyrdiBGUiUryzeZtmOxpMPkOJ5obOpVtCVdkrer2
	 PjxX9fcWQ7OrA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 62EEB17E088B;
	Tue,  6 May 2025 12:20:47 +0200 (CEST)
Message-ID: <c8bb938d-5a43-47a2-b7de-695f95b077ad@collabora.com>
Date: Tue, 6 May 2025 12:20:46 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: iommu: mediatek: mt8195 Accept up to 5
 interrupts
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
References: <20250505-mt8395-dtb-errors-v1-0-9c4714dcdcdb@collabora.com>
 <20250505-mt8395-dtb-errors-v1-2-9c4714dcdcdb@collabora.com>
 <cb715936-3a44-4002-8d64-565f8d31820c@collabora.com>
 <2d3a8e55105526c999b490a2e92dd448c099faab.camel@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <2d3a8e55105526c999b490a2e92dd448c099faab.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 06/05/25 12:03, Julien Massot ha scritto:
> Hi Angelo,
> 
> On Tue, 2025-05-06 at 10:34 +0200, AngeloGioacchino Del Regno wrote:
>> Il 05/05/25 15:23, Julien Massot ha scritto:
>>> Some Mediatek IOMMU can have up to five interrupts so increase
>>> the 'maxItems' to 5.
>>>
>>> Fix the following dtb-check error:
>>>
>>> mediatek/mt8395-radxa-nio-12l.dtb: infra-iommu@10315000: interrupts:
>>> [[0, 795, 4, 0], [0, 796, 4, 0], [0, 797, 4, 0], [0, 798, 4, 0], [0, 799, 4, 0]] is too long
>>>
>>> Fixes: 3b5838d1d82e3 ("arm64: dts: mt8195: Add iommu and smi nodes")
>>> Signed-off-by: Julien Massot <julien.massot@collabora.com>
>>> ---
>>>    Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
>>> b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
>>> index 75750c64157c868725c087500ac81be4e282c829..035941c2db32170e9a69a5363d8c05ef767bb251 100644
>>> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
>>> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
>>> @@ -97,7 +97,8 @@ properties:
>>>        maxItems: 1
>>>    
>>>      interrupts:
>>> -    maxItems: 1
>>> +    minItems: 1
>>
>> Isn't minItems already implicitly 1? :-)
>>
>> Looks not, from my understanding if 'minItems' is omitted then
> dt-schema is setting it to 'maxItems'.
> https://github.com/devicetree-org/dt-schema/blob/v2025.02/dtschema/fixups.py#L129
> 
> And you will have an error for a one item interrupts:
> Documentation/devicetree/bindings/iommu/mediatek,iommu.example.dtb: iommu@10205000: interrupts: [[0,
> 139, 8]] is too short
> 

Whoops, you're right.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


