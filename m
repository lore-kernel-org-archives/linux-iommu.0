Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4378541A547;
	Tue,  4 Aug 2026 06:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785825881; cv=none; b=aPzT57OgV8zz5useIkqO89Ki1p9NOYXRltU1tCKnGX+oTPPXuUo0kldf+OrzOrpJb46zBOK6A2Wh/wEfE45zejG3MmSNYnPH6TLIRpzdGUY6JAcFYmEQAilVenJ2diGf9J0CVV5exElhkLjSBW/k0yDEdY/H7Tu7zZv0G/Nmdvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785825881; c=relaxed/simple;
	bh=blQdVul0jRWJKVdRYjnlGcJlUpqG0ungF68gS0XGaA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKb8HJ6BeeuIHtjQOadWE7dKd/z1gLkP5XKOeVUwjQTpnPyqRHbuSPZ1O4jO0JH7o/eK4lmlrwbyUmDLa6j256xLL1IF77S2Dmz34b8BvDv6o8trlw3B8SE6QlZC0msHfG+H4QmUU5olbz9Ph91xSp30YaF6LZrc/qn62nRWBvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bc+/lsPY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bc+/lsPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865C61F000E9;
	Tue,  4 Aug 2026 06:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785825879;
	bh=nIISJSbW9tQzvtZi2AAbqzB7TfQIoI0ZnCXID/DMNyU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bc+/lsPYNzMNFiyIDjzFxadBtytoJzoczBcsXVEUAS/xsAYMbYU9Z91DmgYdY22Pi
	 YGVLSbDNdkRtrbeSM8hQrWGPjQ6gOIqg1PziBB6ikYrGxp1ro+RpMwyoOnGKfd0G2K
	 SVfGQJ/Ba/YxR2A+Px7G0fdl9WyahJtEnf9jNXVTTt/Ws6Z8RJF5KqCMKvP/ZWurD1
	 ALA+FAdB3HUCEfSenjkoHmO2GfGqZMRSi3wupgXpzh7ydEAVghT/dIqIOXVMB8eRRi
	 Ee/1d0LWg8UTTensLQeNWTxT0c5jfjA51BDNDqPqs4Mf7RMvME9IDYje1Rhq2+ZPom
	 RIIIv20frU63Q==
Message-ID: <c29bceeb-cf01-4221-bb8e-a16f998c6e35@kernel.org>
Date: Tue, 4 Aug 2026 08:44:33 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: arm-smmu: qcom: add compatible for
 IPQ9650 SoC
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260731-ipq9650_smmu_binding-v2-1-143a51c8ffce@oss.qualcomm.com>
 <20260803-therapeutic-coua-of-judgment-5c6cdf@quoll>
 <c3c01f2e-9070-4603-a5b2-9b404ab2b94d@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <c3c01f2e-9070-4603-a5b2-9b404ab2b94d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/08/2026 08:43, Kathiravan Thirumoorthy wrote:
> 
> On 8/3/2026 2:54 PM, Krzysztof Kozlowski wrote:
>> On Fri, Jul 31, 2026 at 11:01:26AM +0530, Kathiravan Thirumoorthy wrote:
>>> Add the compatible string for the APPS SMMU present on the Qualcomm
>>> IPQ9650 SoC.
>>>
>>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>>> ---
>>> Changes in v2:
>>> - Add the proper constraints - no clocks needed for IPQ9650
>>> - Link to v1: https://patch.msgid.link/20260512-ipq9650_smmu_binding-v1-1-04defdaa140c@oss.qualcomm.com
>>>
>>> To: Will Deacon <will@kernel.org>
>>> To: Robin Murphy <robin.murphy@arm.com>
>>> To: "Joerg Roedel (AMD)" <joro@8bytes.org>
>>> To: Rob Herring <robh@kernel.org>
>>> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
>>> To: Conor Dooley <conor+dt@kernel.org>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: iommu@lists.linux.dev
>>> Cc: devicetree@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>> index f2188942f877..ffa33b7f4a96 100644
>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>> @@ -38,6 +38,7 @@ properties:
>>>                 - qcom,eliza-smmu-500
>>>                 - qcom,glymur-smmu-500
>>>                 - qcom,hawi-smmu-500
>>> +              - qcom,ipq9650-smmu-500
>>>                 - qcom,kaanapali-smmu-500
>>>                 - qcom,maili-smmu-500
>>>                 - qcom,milos-smmu-500
>>> @@ -625,6 +626,7 @@ allOf:
>>>                   - qcom,eliza-smmu-500
>>>                   - qcom,glymur-smmu-500
>>>                   - qcom,hawi-smmu-500
>>> +                - qcom,ipq9650-smmu-500
>> This will disallow clocks also for the Adreno one, so confirm that it
>> also does not have clocks.
> 
> IPQ9650 doesn't have Adreno IP. Please let me know if I need to explicit 
> about it in the commit message or this is fine?

Would be useful but anyway

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>


Best regards,
Krzysztof
