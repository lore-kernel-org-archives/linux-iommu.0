Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811E21E766F
	for <iommu@lists.linux.dev>; Thu,  8 May 2025 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746693291; cv=none; b=R434N6l0PurtXbiUHbg/lQSFEQICYpAefHAAmPCSkT0WDi8QE9mT2vKIzJkxOilWDtg05TZfGR9OSufSRITrycqzH83fFSu8lvVnKUO8qguuySJ6G6J1IfAFRKplrkHIfUcdBUyyFRlTWItIDotbtNuqbODLcVAl+DRv5AFU6rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746693291; c=relaxed/simple;
	bh=/yn0vOBSqs1gT1qgFskCzgf8UxOw44a5QvWI6DwYPmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvauHNCGPEYqUeyNOxczEgjdt5Ko3CKqgEGQJjqIkfTdq5L4s7nEeylI5rxHRiPE4Ql8ZttO7STdTW8c+KVzgIcurGaIb17euCibgcjgbrrWpgnh8bO1eAARebcohQ2CN+Y81NpumnlNr1Ie+uuuPhvH2NGC0YH4YjY7iG80g+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lvHX6Jfr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lvHX6Jfr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1746693287;
	bh=/yn0vOBSqs1gT1qgFskCzgf8UxOw44a5QvWI6DwYPmM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lvHX6Jfr7OJ3b9RU2pr9vKKmVzcczO72O3biC5VnlBbkLBYBi4j80YJi2EahlHN1c
	 6I9FwWK2rI9vTlfgY0vX59fGYaiqUGpGcxReA8po/KwPkXIJBEPYgbVoK27U8P4nkQ
	 X4QD/QaGCH6DAVicsxmX8fpMRCdFt6D/fag3nmUd43PN/6uB7xi1I6h2Cgt/WTqLpq
	 SZEaWRHihGqfwPDfI/lIhJzyu9FoTR2A8LrpgfmZCRkdBpb7sSHMCQ9F4OpeDxNYKz
	 VId7swgQvxQGPbEbgdeQEvtYfy088uRJpCZWNsQMmZX2KRcEXgt4abxmz6xz2/sV+O
	 wA2RMcDIF2HaA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 62D3417E02BE;
	Thu,  8 May 2025 10:34:46 +0200 (CEST)
Message-ID: <ff8da58b-9e87-46d9-b4d2-4059ef05780d@collabora.com>
Date: Thu, 8 May 2025 10:34:45 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: iommu: mediatek: mt8195 Accept up to 5
 interrupts
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Julien Massot <julien.massot@collabora.com>, kernel@collabora.com,
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
 <baeae909-4d12-4cbd-a063-7ad165304b96@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <baeae909-4d12-4cbd-a063-7ad165304b96@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/05/25 08:03, Krzysztof Kozlowski ha scritto:
> On 05/05/2025 15:23, Julien Massot wrote:
>>
>> Fixes: 3b5838d1d82e3 ("arm64: dts: mt8195: Add iommu and smi nodes")
>> Signed-off-by: Julien Massot <julien.massot@collabora.com>
>> ---
>>   Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
>> index 75750c64157c868725c087500ac81be4e282c829..035941c2db32170e9a69a5363d8c05ef767bb251 100644
>> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
>> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
>> @@ -97,7 +97,8 @@ properties:
>>       maxItems: 1
>>   
>>     interrupts:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 5
>>   
> Every iommu or just some (as described in commit msg) can have 5
> interrupts? Looks you miss here proper constraints per variant.
> 
Technically, all of the IOMMUs can have more than one interrupt - but it's not
clear which one and why, as documentation is lacking.

Let's restrict this discussion to MT8195 anyway, as it's the only one declaring
those 5 interrupts...
...all of the IOMMUs declare just one, and mediatek,mt8195-iommu-infra declares 5.

P.S.: Nice catch!

Cheers,
Angelo
