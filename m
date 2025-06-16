Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73F86340
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750089986; cv=pass; b=j7QR7u/nx0UkOyy9R15PJFO1brnFVBNx+zb8gbH7N6NwsKSWuTvEbcPF5XL+5dgZ16/9mx9lcU7VhLqA3BNv48w0olqekV64yR+LawyH7gXaMO0Oik8quvDEqrn1sgtrjRucsp6xN5Aa5q8uMqPVvi0i2V1/YGQ68ixA06H2Ejo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750089986; c=relaxed/simple;
	bh=ASFFuuxt+NkRcr85V9Pfr5TSV45ijN++k4YYQyXOBPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tnA7WPiMCqS/vaIKSXzwC3hhJTaPXJmzRG/B0WPN1IuNw6nK1gsg/WzsDF6x4QCYOg/u+6GGYWT80ECyr5mTlIo5RmQjX3D4T8SMhjz0CDGx/5ZGnWB2+u7mjEl0cNknLS5DXR4+o3tZiahAqNA+m+bpZilTCIE8H0o8SuYGMt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b=Cxej/lQU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b="Cxej/lQU"
ARC-Seal: i=1; a=rsa-sha256; t=1750089974; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e3GNWk/WbTMBevIRzVxs0X0CrdY0pRAyPGz6jfHOmRORUsjwLA1tl83Tcg69Gdmjm6LtbNDMWkmzWPXstgPN13BL4cUCzalmADCecyqghzLvTPu7xIp5Zte6CJ7oUCnJXZEHBgK41h40PJKyFeuACrxbSi+mpnczIfdnz4rfot8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750089974; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=R2NIJYlZXUCPFvz62oOBC7RgnkUtxPH/uiLdx+Eefzw=; 
	b=LPTH8d3DUcfCDo7jV04mDGb73PcRIZcqmB6HWL3b3Fwmaro5ZWuxr+RCxr3Gh3EofXC1PFLsCGqgykkco3tglMzjHesUsHPyai1hut15i1TFpPYezmbnoImx6TieTKuB6c2a9oBwESWEKNux8OyIhLTWlIF7v0/BhzqbDVUirqs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750089973;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=R2NIJYlZXUCPFvz62oOBC7RgnkUtxPH/uiLdx+Eefzw=;
	b=Cxej/lQUz2GTaTy62PcnOSfRvxKBanXxW0lGKW0AFWDQ7U+qDpLJSKzl0sFtrdA7
	IlPkQnAXxZZRvNLvs2aFKNCn7ht/En6XoDdo+4KiSUwcNsn0YeE3BwU1TiJVG+uovHv
	FdY7IkjAhFOlAV0AndUjZn8f5RMcY2IxVzacAGQM=
Received: by mx.zohomail.com with SMTPS id 1750089971949421.80620542117106;
	Mon, 16 Jun 2025 09:06:11 -0700 (PDT)
Message-ID: <163a05ac-b0de-4345-8489-dbf858326908@collabora.com>
Date: Mon, 16 Jun 2025 18:06:08 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] dt-bindings: iommu: verisilicon: Add binding for VSI
 IOMMU
To: Conor Dooley <conor@kernel.org>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 nicolas.dufresne@collabora.com, p.zabel@pengutronix.de, mchehab@kernel.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20250616145607.116639-1-benjamin.gaignard@collabora.com>
 <20250616145607.116639-3-benjamin.gaignard@collabora.com>
 <20250616-winter-strict-db98f85db22d@spud>
 <5c971c09-c398-40a3-9ed5-ec38b6645e1d@collabora.com>
 <20250616-contempt-remix-5af2b7281cbd@spud>
 <2d251d7c-7906-4a66-9791-7f71e7a4b54d@collabora.com>
 <20250616-capped-rehab-6e7fd24d23ae@spud>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20250616-capped-rehab-6e7fd24d23ae@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 16/06/2025 à 17:58, Conor Dooley a écrit :
> On Mon, Jun 16, 2025 at 05:50:50PM +0200, Benjamin Gaignard wrote:
>> Le 16/06/2025 à 17:42, Conor Dooley a écrit :
>>> On Mon, Jun 16, 2025 at 05:30:44PM +0200, Benjamin Gaignard wrote:
>>>> Le 16/06/2025 à 17:14, Conor Dooley a écrit :
>>>>> On Mon, Jun 16, 2025 at 04:55:50PM +0200, Benjamin Gaignard wrote:
>>>>>> Add a device tree binding for the Verisilicon (VSI) IOMMU. This IOMMU sits
>>>>>> in front of hardware encoder and decoder blocks on SoCs using Verisilicon IP,
>>>>>> such as the Rockchip RK3588.
>>>>>>
>>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>>>> ---
>>>>>>     .../bindings/iommu/verisilicon,iommu.yaml     | 71 +++++++++++++++++++
>>>>>>     1 file changed, 71 insertions(+)
>>>>>>     create mode 100644 Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml b/Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..acef855fc61d
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
>>>>>> @@ -0,0 +1,71 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/iommu/verisilicon,iommu.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: Verisilicon IOMMU
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>>>> +
>>>>>> +description: |+
>>>>>> +  A Versilicon iommu translates io virtual addresses to physical addresses for
>>>>>> +  its associated video decoder.
>>>>>> +
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    oneOf:
>>>>>> +      - items:
>>>>>> +          - const: verisilicon,iommu
>>>>> You're missing a soc-specific compatible at the very least here, but is
>>>>> there really no versioning on the IP at all? I'd be surprised if
>>>>> verisilicon only produced exactly one version of an iommu IP.
>>>> I only aware this version of the iommu for the moment.
>>> "for the moment", yeah. Is there any information that could be used to
>>> version this available?
>> The hardware block isn't documented in the TRM so I don't know if there is a version
>> field or something like that.
>>
>>>> Does adding verisilicon,rk3588-iommu sound good for you ?
>>> It'd be "rockchip,rk3588-iommu", but sure.
>> "rockchip,rk3588-iommu" is already use for other MMUs in rk3588.
> "rockchip,rk3588-video-iommu" then? Instances of an IP in an SoC get a
> specific compatible with the SoC vendor's prefix, so having verisilicon
> there isn't suitable unless they made the SoC.

Other hardware video codecs have a different IOMMU so I will suggest
"rockchip,rk3588-av1-iommu" which is specific to this video hardware block.

