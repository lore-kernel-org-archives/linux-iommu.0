Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2853EFFCF
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 22:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778883369; cv=none; b=ot17BeQ/82aPVgSJnlSqgxrR5RdwiKKHSeftNa/MDeJGAY6xxBv/tL8oPcQg0OroA93BcE019W+H6k1q3wLUYXqOEDyBAAdWpIikup6y9DjHA6GQGJZR1/x1oBeSIoph/gFXA3weTj32cA/7fPlhfXnuzn+xjwhrZ+7Ibpvd8KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778883369; c=relaxed/simple;
	bh=GGi5FP1TfaEYJKQ7ggUUrDXlF/3PIJtQncMwz7QMfto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TitzxkDGjJJWJOmeuYYI6er7w+PC8f0FvFngjNUcWigua4ACJdDXoHm6gJoNkhqmhCj3xIo+0ZHrHmMoV6H0/9w1G4+iUOrT5E5DxFBmvrfvWSNompYNYcOMJ9D6lKK97ykXcL5BkreMsw1wkrTKQrCKFPgsepGli3OMrM5A5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=enQl/oxk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zh+bUP6m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="enQl/oxk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zh+bUP6m"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FJfaI82840043
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 22:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g6gFmG52451iCRGkhhhcMmCq+yZXn0FSxt2aFKyqf4k=; b=enQl/oxkGo4EUY1C
	0nmObNylCTCi+UVv7Git6oE8B7q8Bt1uKHiilYmDewZ8qqnxSX6AK/PKoKpOLIm1
	0aWmlBr6qJ1zvln6zk64GhcuzLUmoTAHHN/xfsc+4BTUxqsBnaGC2gYKHVPlTKyZ
	x5CG8V/PoH6TiqHonXu+3gMcp6HhDy4GETZblyihZn+z5k5pfcuot0+O9mFVesey
	q4kxw/021aWB2iYk0ygL7qx0AWtv/qXYJbNO6tbzOooKCEfxaQUXryof/9EYjPgV
	yNF7vOe0ErUh4Sdj4zyegucA3XumsC0oM6di4BXlncDVa4h9UK5uPFTNIulzHPOB
	kKZNCQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e694n0hhx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 22:16:07 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3692f395339so219459a91.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 15:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778883367; x=1779488167; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g6gFmG52451iCRGkhhhcMmCq+yZXn0FSxt2aFKyqf4k=;
        b=Zh+bUP6mPxzC7ot+fIe9mvlNXLQAL8JmIQ8/9LFj/gB2ECkSCwwQfEzCbIiBHEAvsT
         i3XLZVOPIx22eBsbwb8wUwmtGoXsX96xLAtei19ezp0fbZCL9gjtGrdoATvtsXo35Jfo
         oA9ruvrN+cdfGjtiAEof2YJtzB2nl/mu+frl5TzQMP/dtx5i4e5lGS9i/j9D+qB5GHJo
         8+O9AdjAL6IaUteBuCfs4spD/8NG1CkNgPRd4fgGilrLlVDV6XuW3wE0W6io3zYZJXzP
         838kP25/e4CTjUQjJYf+NNdk9le8aLBTd+trYzlLg7x/baAbM2OjJ6mKqG81hwe/pPKt
         el/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778883367; x=1779488167;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6gFmG52451iCRGkhhhcMmCq+yZXn0FSxt2aFKyqf4k=;
        b=QT8WP8ddbFxZNmMuzqT7S2GaqE5svtZ1NYfC2sRj6Ay6Hzm29Lkcd5o0ftgfGSipHd
         jEXD1bqiUpaaeIagsE5v4DC4TEsEsaLYPJPcqE9nGFXLdevqDP+hdRUGO1Ty++jqZy0/
         ceyrznEfm+LRCkaUITtiARh6wpmYEl8zmrbZ0GoxIFK8x9A53iBDO3brxyg5xmisvhGr
         8Xu4Ya/xekprmY/FidcjIfI8f4WhqWhlKmlrFSERuk7jWs/p/g67S+vL9IezcJk/5MM1
         ELSlzk1aWir2klNE8aEj025QjEiwNZeOOGsY+g5vYRhWN3Stx+TJ2BhjS4GxKWjOamTV
         1bpg==
X-Forwarded-Encrypted: i=1; AFNElJ8rxkr6j+BLTpBMkt3CFszxkzVCLPwEn2sFXzBcgmDtv6FzvHlvRvwuPDwpMVsqfBTTX7SeCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoN3p97yU26GsRJpePllQjMq6rrDRsdIQLfj0FW0jb50B4ZEqY
	Vt4rXconnf9J79wnUM6cm7obALgCJGFtNgCWFD1+yB5bjVsHaeDFlL4AMMWAtBMwDozDCk55UeO
	aLgQLIDkIPEMBW3TFe/LNBImKhRkpMPaeCYA0IuamerrudLvAesHiFSJ98Q==
X-Gm-Gg: Acq92OGXBiPAqRCgM649YoLnrwqpSjVPG/gdFe/gviKl2DSEEBvw0t8a1aCpPPQu9ik
	3/3c3n1iN3+eiGT5i1keuiUXhUZuOgG1R1adSxxAe+9ebpqOFznufWVSiFHOWkyFLgIXylkV8N0
	yZ0MAX2CmQaXCZXzOYTDPpL4uhXM8ayV3706JQITW4wdEyyym5Gsph+VcHw7YiltGzWIFmM2y8j
	D1meHrMCavSgWXtTykPSsi0OkzIVruc2mSB+foqXMjbE8BF3RiEzBWohkIXvEsFBJc9R3M1rz5h
	otRzt61iHAQLR3dMxPWQ1rhPVryJzlTM81Uecvsh4lnnyMPmecYEM0Q4sswYyQjArdpVg8Y98xI
	boBEseoluB+K8pMVkxNXJtksWJxhPywwRNdM+szYTRu38416XFx1viA==
X-Received: by 2002:a17:90b:134e:b0:368:5367:d681 with SMTP id 98e67ed59e1d1-369519c348cmr5767577a91.10.1778883366310;
        Fri, 15 May 2026 15:16:06 -0700 (PDT)
X-Received: by 2002:a17:90b:134e:b0:368:5367:d681 with SMTP id 98e67ed59e1d1-369519c348cmr5767533a91.10.1778883365800;
        Fri, 15 May 2026 15:16:05 -0700 (PDT)
Received: from [192.168.1.3] ([182.60.13.113])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb11683fsm6304190a12.26.2026.05.15.15.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 15:16:05 -0700 (PDT)
Message-ID: <f946b661-ee69-4502-9745-247940c54653@oss.qualcomm.com>
Date: Sat, 16 May 2026 03:45:55 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] dt-bindings: display/msm: gpu: Document Adreno
 X2-185
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev
References: <20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com>
 <20260513-glymur-gpu-dt-v4-2-f83832c3bc9a@oss.qualcomm.com>
 <20260514-pearl-mamba-of-inquire-e4888f@quoll>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260514-pearl-mamba-of-inquire-e4888f@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ba3oFLt2 c=1 sm=1 tr=0 ts=6a079b27 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ba8plz+5YpscmDk5DVa2Cg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=CuuWk3emYSqqoFdssNoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDIyMyBTYWx0ZWRfX7UvkdUGttPXo
 u6jPWKKpTbYQZz32fh0UboPrO4TpN30HU7vyFs5uFttvAzurYw1wprwkIQP+2zU9JEKIybMEbwY
 R5QMFYOinO1b+aL0W1LKvfEJGZIxVrVt5eodrCTdQKfA7S4Bm81S7F+p63kFoDm1Av8zkf07ncG
 s4rEk8BBp57ccwu4rrUVfgYy/ap0cEpdp6TX20h6hg+UT0bo7HEqugNxHVposhEC9RrvR+KclIB
 b3DeRGtO58zsrI12H9k/kpF1yWpeWVe96MpxsZLz3jSAkLuOkS77S4p78RJ2B06xHzQgkE5nYlk
 HLbH6jhh1cQtsg99oI5ptLFyQOFrt4cJQk49j9IpXyj9+O5BkVD92vfNCTN9zvFWChbxsapMIBc
 E5/6AiqKyYpusKOWLos3Lng+VfYRxhXFt6RXh5loOLk+takAff+tCzNVOTcUjpj2Omk1Jgh2UiV
 2LQGIo5iWwdD5FJnKuA==
X-Proofpoint-ORIG-GUID: N0epMDhHDd3lbg3b1dq9vs1mBerj9Lkb
X-Proofpoint-GUID: N0epMDhHDd3lbg3b1dq9vs1mBerj9Lkb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150223

On 5/14/2026 3:43 PM, Krzysztof Kozlowski wrote:
> On Wed, May 13, 2026 at 12:51:19AM +0530, Akhil P Oommen wrote:
>> Adreno X2-185 GPU found in Glymur chipsets belongs to the A8x family.
>> It features a new slice architecture with 4 slices, significantly higher
>> bandwidth throughput compared to mobile counterparts, raytracing support,
>> and the highest GPU Fmax seen so far on an Adreno GPU (1850 Mhz), among
>> other improvements. Update the dt bindings documentation to describe this
>> GPU.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/display/msm/gpu.yaml | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
> 
> Someone needs to start applying Adreno GPU patches...
> https://lore.kernel.org/all/20260301142033.88851-2-krzysztof.kozlowski@oss.qualcomm.com/
> 
> 
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> index 04b2328903ca..e67cd708dda2 100644
>> --- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> +++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
>> @@ -411,6 +411,22 @@ allOf:
>>          - clocks
>>          - clock-names
>>  
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: qcom,adreno-44070001
>> +    then:
>> +      properties:
>> +        reg:
>> +          minItems: 2
>> +          maxItems: 2
>> +
>> +        reg-names:
>> +          items:
>> +            - const: kgsl_3d0_reg_memory
>> +            - const: cx_mem
> 
> Are you sure there is no cx_dbgc? If not, then just minItems+maxItems
> like for 'reg:'.

I merged cx_dbgc region into the kgsl_3d0_reg_memory region for A8xx
series. It was getting in the way of covering the entire GPU MMIO in DT
without overlaps.

We don't prefer overlapping regions even if it is within a single
device, right?

-Akhil.

> 
> Best regards,
> Krzysztof
> 

