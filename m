Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28A3D3002
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212602; cv=none; b=Mn7xX1DLVsueshRzT2quZ4KaExQU2TrOy11Pc6WF8UhUDL+bNby+F99ik/jrNJ9quxg1ofr4gKOljU3rHWnWUxeNmjQeixvSilY9o33EWaI8TQ30J1uu2qz46XTXv074LhAS07wP/wa28K4RSA+GUM+K6xfKX9XbEnRrmzlxkLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212602; c=relaxed/simple;
	bh=0nT9hdNPje/aGUFGC9AidrWMm4oZfR7I8Iq44grMgSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOMsCrL/JjfZ7iZQGXFM5juDk26o6PhN4nLlNmWS+UB2ySSbwsH1iawYLr4xymMhrNYcHvd0f0OM6y2AemAM8g+Mpd1JYiAv27Na60V6nvAIkW9duXly4zF18WCqb9MTvNNE6L7MnsQZYrPymwvuWe9H6pgIzmUaPbcobGG0QDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RVdCAvqE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YKVEZnel; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RVdCAvqE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YKVEZnel"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NAsQtb4134525
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 11:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F8pQ7+KpbTQISYSQqbM73wZKxkqVf5wMyvX6KaoXFwg=; b=RVdCAvqEWeUN4sA6
	aJ7cAuzKkdlxrFrS5DnO2V36dnxYfoJl/dCrO2ZBhDHzppUXsiW/EafB4FPhDLEU
	J23HzHeoWxl53kCfsQkJuGqtEJkQYQfFnTg4zopVtIeAiZMLpfPfsQ/AtTobEv/r
	7L/SyN/EeZst+NGmPFfCJQnBjRELF4F8eHU6ymokW7+gpc5J48T3pCqw8pBpTn0R
	IPipluNIN20IrrX5fSns78Msa9fw3XP8DtAM7n5JlN+aLf8muGNGg76UG3litXLW
	CqoGPbtW0MSzUREcqcocvNzswkTl9IfEg4daeEjlGCH7h7TihD7dfhjNc9kdr3oW
	wdbJmw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyqe68ew6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 11:03:18 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-72f38340243so67632137.1
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 04:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782212598; x=1782817398; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F8pQ7+KpbTQISYSQqbM73wZKxkqVf5wMyvX6KaoXFwg=;
        b=YKVEZnel6DDLqX45MjQSc+Y+EKoIs871PpCMwHK9Zu32VVJbP7KKPfV0Ao+Cx4sCwl
         CT6k/zvyaZPJFDuKEoRdpS+Cjof9fk5TYD2NsokYHtG7pu2m6WI7xQAQLI7R87fX6xYu
         d9eui1Gu7TQN0FvoZ/N3WpngF7HRkjemFPmPR3PS1caryAdqhp6Yw68U/OF8JP8Itgit
         Fcu1tYIlI1WKNTOSSYjUlXRPA39ZGCbm6EiovkZ9BodMHVO8wi8uvP/ZJoS6d48YhUv0
         6I+xLIgLcFyWo+b5+u1RbV6dGuij3PYzi21OAWUw9S4cdabpDE1juOZmdTgvnaqfPREq
         0r5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782212598; x=1782817398;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F8pQ7+KpbTQISYSQqbM73wZKxkqVf5wMyvX6KaoXFwg=;
        b=Y4EQIpH6lat85eeNB7IVhg1D6uY6MgfqjBfw002KIOgxzAagoKETsjkmY56x2NSImd
         Kqp2nBlvMz2sapLlXcKAi+xZhkKePrAtLanGyRQ/WjbTPVasYD9BIET3ybE89P+3sMnn
         5Xy+hFlkMgz7Nk2M3Vj8WNKiQIJY3AzO7xQuwbLnvASEuOgvQBt5wqJEqvdVbpbINYPI
         ftln0BX5QRJLDPo83nSevyufuT+Q9MXKeMsH5g3OQopiHxopBiLmaeZj77ehXjZMeekZ
         BZbhHVBzi9wiFhzhrezMIDa+5ehVdCVr478ENjzW0izUVbX8g7Erhm4711G9qIkXRv0q
         FBDA==
X-Forwarded-Encrypted: i=1; AFNElJ8zihR7JkWLkhmdj/1sIgNgzurIX+V4ajSwe+LBzE7CvQxaV8OZQRWMZdQufws7GClu3pVC3w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy26OVxSKr/g1r+3ql3OOt3zn9xWxlugZr7da5urJNBENKGG3No
	6VPa1Ik4h6OivBYi8a2nGLl+RguwA4YqBnXYevLDKI+ouTTzD8y9hC8LOWGa07MpraZr4P63V2X
	6epmXbDS0oYbKb3rfo116lEoM1ydFFtY5LIrxKhiB6+gmGoMQg3WfkmDZlA==
X-Gm-Gg: AfdE7ckwRPeyDxmvm8Y52FpkU4Hj3EbjwRcBExcAqbtOi8R7SCmHNoLSRJuYd099SFX
	eHhaLuh65rRV+LoYVBEoZdtqWUU4UEKaBCthmfiwDaPARYFZdmTWj9bYb4fEGnhQFAxWn+4k1GY
	/hs6gBSCcCYaLnPK05kI2gxd4oHQNBxCq4gufzpBqv6OEAms72/JaHvEfiZXxcPWTdyaj6WmMyr
	vX+bsXu7oUgmkjS4xrhsU1UErMSeg359JX8jDCvB3FDUbx6nbAVSqJ3mM4QScsjlXgZTZenvETD
	c6bveaTmNI59JAJMigByr6HS6iabBUx+OkXF2jAv80TY1Fh10zHrUcg0b/baLJWt2LPcPYf7jzi
	SmM17ACDR1rLB7pxpcPwpXyaKVP+aU52ZY8Y=
X-Received: by 2002:a05:6102:e12:b0:637:30f8:5cd5 with SMTP id ada2fe7eead31-72b172a99fcmr2725509137.8.1782212598337;
        Tue, 23 Jun 2026 04:03:18 -0700 (PDT)
X-Received: by 2002:a05:6102:e12:b0:637:30f8:5cd5 with SMTP id ada2fe7eead31-72b172a99fcmr2725475137.8.1782212597845;
        Tue, 23 Jun 2026 04:03:17 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977b86de31sm4303377a12.12.2026.06.23.04.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 04:03:16 -0700 (PDT)
Message-ID: <6123a923-21dd-4f69-9ac5-02165963027c@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 13:03:12 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] arm64: dts: qcom: sm8450: Remove unneeded reserved
 memory nodes
To: esteuwu@proton.me, Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org
References: <20260622-sm8450-qol-v1-0-37e2ee8df9da@proton.me>
 <20260622-sm8450-qol-v1-2-37e2ee8df9da@proton.me>
 <e1e492ab-884e-442b-8410-cc100c54fd5f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e1e492ab-884e-442b-8410-cc100c54fd5f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YjyQfUES9bF_JdpOc6PR8nhygW_53kVQ
X-Proofpoint-ORIG-GUID: YjyQfUES9bF_JdpOc6PR8nhygW_53kVQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA5MCBTYWx0ZWRfX7WUPG+ie4BQc
 JGIWumIkJv0lzKTLJQ7O5QixooaovdLzlNd+djZ6PLYg2Ee+rwme8LeFPyRK6hOgukHiZA67trf
 PLuxQVWLLYKIfxHoPi7FMdPk8rL+XEk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA5MCBTYWx0ZWRfXxaxD/xekgzsZ
 VX2eRAbMzWeIVoSu/LY9KZtfODXhd6JeHiOPf0PIY1YYZWGLtkYipEfUOEtH4GjZfjs9f+FyPwE
 +y/EdWtukVogXkU1Sisu9Ra8QoWptNcg1+60SHoS1mOO6lhK+CyRmd0cTpbNLC57CTN4rUr+vmC
 QFRiN+zIeng6UpY1KyWC+TMvw412XiS/4oO7UT03xcmJIWiktZ0YJulxDtED+4LDxH7Xe52wcAF
 BuXEm0Ht+neG+7S1sjQcT0eO4HL5ZSiXpxR1+e1Tf7kGkwAb1QYVQQH7+j4tw3R53ibvHymp6km
 NxA+OhGEaj6er1vQaByH2OM1HaxhuU/w62aQ9mty0Ri1lkr3eEImjvazIfvzQaPGf6N1WLSzjAu
 KZs9SSEzybmCMKMSNNJfFOsbJMKc0v1PjH+bcvRvmgOJqXYu2H6kJ1mKc6ptpJv8hz78NNAnNl4
 /063H6gJfg3nnkabKlw==
X-Authority-Analysis: v=2.4 cv=OeKoyBTY c=1 sm=1 tr=0 ts=6a3a67f6 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=qh3hvowi6R8gCIqNXE0A:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230090

On 6/23/26 1:02 PM, Konrad Dybcio wrote:
> On 6/23/26 2:54 AM, Esteban Urrutia via B4 Relay wrote:
>> From: Esteban Urrutia <esteuwu@proton.me>
>>
>> These nodes are not present on downstream device trees and only take
>> memory away from the AP.
>> No crashes occur without these nodes, so remove them.
>>
>> Signed-off-by: Esteban Urrutia <esteuwu@proton.me>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 15 ---------------
>>  1 file changed, 15 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index 56cb6e959e4e..e34e3c05bf74 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -752,11 +752,6 @@ oem_vm_mem: memory@bb000000 {
>>  			no-map;
>>  		};
>>  
>> -		mte_mem: memory@c0000000 {
>> -			reg = <0x0 0xc0000000 0x0 0x20000000>;
>> -			no-map;
>> -		};
> 
> This is mentioned in the memory map description, but is not part
> of it.
> 
> I booted up a 8450 HDK and it doesn't even have MTE, so it's
> probably valid

i.e. it doesn't report MTE to Linux. I don't know if it's Gunyah
trapping it.

Konrad
