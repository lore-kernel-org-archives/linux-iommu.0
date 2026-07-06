Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E263A7584
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336088; cv=none; b=gPMMMgTDg4b22k2asrhKJnvXQQaJ2yGVZ90EW+NtjPIm8TFFaWk4rt1KbQGbEpkQVmSwhUMDfmsgOGgO8KO1KobHnVVa0kydTzM90NfvyIeKY30nBnafvPcQxyBXPCzPt90+ROo/X8hC+Gd/7RADdpJN6tn503D+5TQRCdWocnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336088; c=relaxed/simple;
	bh=lnCRP++C8hi3TQVnzk2JF8NMeYP6Qggb58ii34Am7s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pb6A8URwK/54iBOPj+ukctX1wuiiNXFZJ9c2h6PiAkyp5wxtOEw670lzgM8hGwgwNIDLvhl7V58wELlCGBpwwRAlECYyI1UmDng47/XZuXTS9VAvZwENnayp4iY3N3v9oto2i4y7BCYh+nFdhbcT/CS/NuVc8FboHdGwnf8n4kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ENQWdUF6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PA3iKFm0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ENQWdUF6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PA3iKFm0"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxFQC368942
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 11:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M9+o4PUKMgHJp9AdorOs0p5SVquVy+abyY/nSxhj6Bs=; b=ENQWdUF6x1jx8yL0
	TK34NknB8KymeARAmE8QPgyereYZDw3jnXe1q0/8g8VIFp52NHROi3RqaFudgQWB
	5zhFcvneVdsjzC4lAtz+xN4hN8soi0D0zrkeozEht9CPW4BSfkXXGS/jD9U323y1
	/ogrS24EEAoedojh9FLljIPmZiPkg3Je1RtIU/U/X9Y9YxRXjiwi5R8cE2hJs9XK
	pm9NYzofTI9ptS+Zy118aqiLUxsiF0BAVbr5c+zxiNtevKsFrT9hHyGN7ggwLDOs
	TYMKWyTD5JQoP8CysdFe+g8AbOM/w9G0UIwT4QyYEOOxbQ9xwEiHh/esOHlx+YT6
	Ywkprw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h98qvw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 11:08:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bfe75b7dbso9661381cf.3
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 04:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783336085; x=1783940885; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M9+o4PUKMgHJp9AdorOs0p5SVquVy+abyY/nSxhj6Bs=;
        b=PA3iKFm0gnrDlGOSvwBFV+RolS32hdz49tMsaEbxdyhAAgz/ifWEmiyrT5JFJl23p2
         u8ztvSGgjjz9meFvRufYkxtWIKPdUO9vyi0Kvq/ivGm5vBQYNVYpPMp26+1+DPpUXdSG
         CLEhGZ2DgGLKiqOvzBy7VohoTPNLnV9A+YiOLWVDpHwUvHfktywhD9Zk97OQmc+OpIj3
         SBpFH2oXO1Jdas6zeLPOdxwRSDr/7txPMnq4Xs2K+FPLRRsedo5ku/6m2ART0KelL/8A
         GFegeaKwlTQFc9HObhKC46LkBfIyI793yQEqR4UCFGVja/MmwhVuX8NPQ1Jtnw8TvdWW
         343A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783336085; x=1783940885;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M9+o4PUKMgHJp9AdorOs0p5SVquVy+abyY/nSxhj6Bs=;
        b=FHv0Qpbpy4bsDZRZv1jYbE9wO7NmwRaB9yoPbHl6eHZcISdHYkRVn5ellAIvtx5jvH
         C6V6MPJabYUtQ0jKUp6yFoZW3d0tMR7wBza3j690agxw0deucuSOlE1jGCrtN0HuhaJ/
         wzcVEjQpouvYbJB7acahINvaMKQhiLr1Tbc2mguZkePyoL1gIDiMnTqumQX3JA9Eb4ip
         TucEDEydF2Gik458z8OMWL6RXrpnTXJIQigkA5ddx9ulY5GNT5IbRUAbYq6/D1LUI8yD
         iiPlf2s6J4lrPbHVqo1rfhxZ7FhEaT1NZHkdcSGa4sNnXyVPA+K2m1yrtCKnaIkiIubq
         bKpQ==
X-Forwarded-Encrypted: i=1; AHgh+RqU/aasQlulxyir8z6Cn/iyNSGGXu2xOd+f1JAhyQ94ICKOjpCbH7V0Px5N0FiCoXhPq8fZQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YweFJ3X/YCbakk7zxAIr3APv7mQMCE0XODGVGrOXme565XMD8yG
	ZLczV1fo/O+L/ZtPs2OFKGyvUarJvjz2rjsfuTPeKlYvWYmL38WOCHJBGrrYskabamhbm3tCQ0+
	TLxCBzziTYagLB6WGEPL3o8wRe/6SgfH2Ip0PIySMEKPy96+vHbPsLFY9iw==
X-Gm-Gg: AfdE7cmLjBqqZEsIxr7pk7xe5GbpiLdaF/lGlaqAGADQpLb0C1ZNKB0GTT8N54CFSoo
	G1TPY/Hl6eIw96v8XT21eGCOOpXeDP1T8P0xyDDsOzz0uLHZmoM73dC3G7TRr2+MXqNwOua9dC7
	iP1adE8rtYdM57ThvxSqHHQxgWv2owe1cSZIuf3DaC36pTBlLi1jGbhFX4zyL0Tpa30hJ6v5TlC
	pmrjkvsXOCVqceGHC1vaB7VTbqorQj3VGwJNBX3d7brbKerVpnKHU+rUQzReNy6tXEiD7rAYL4H
	dlfMr0/g9B6foRoKRmYUQiIhfF08iF+ClG9Iy+DiS+HPDduIfT3C+iDD6Jw6uNkz1zRWrSabo98
	nWNuIf1RmI2UcIE6ISkD2DSh7Flv/0n9Jwng=
X-Received: by 2002:ac8:5710:0:b0:51c:db4:3cb8 with SMTP id d75a77b69052e-51c4bed6cd2mr88275321cf.8.1783336085176;
        Mon, 06 Jul 2026 04:08:05 -0700 (PDT)
X-Received: by 2002:ac8:5710:0:b0:51c:db4:3cb8 with SMTP id d75a77b69052e-51c4bed6cd2mr88274771cf.8.1783336084718;
        Mon, 06 Jul 2026 04:08:04 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b629a1c7sm723146366b.30.2026.07.06.04.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 04:08:03 -0700 (PDT)
Message-ID: <5fcc0bc1-7f9e-4611-be77-42860e0f4c74@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 13:08:00 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] arm64: dts: qcom: eliza: Add GPU SMMU node
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
 <20260705-eliza-gpu-v1-6-c9f1354dbd29@oss.qualcomm.com>
 <10b0ad51-8766-449c-a51c-979364e6c781@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <10b0ad51-8766-449c-a51c-979364e6c781@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Nds-vzakCdvHNrYhexV8DzaNXUBnc-z0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDExMyBTYWx0ZWRfX7x0C3t8eZHF4
 rmqT8/YxAWdsobWH9Vmq4tTcNs6zWWn34vWDvVJUmq6yDKWNdOkyN2+oAn1L0EX/a/3hnChjtgF
 K9E9Er38dZhSi3YNNQKAn4Jotb2M3ig=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDExMyBTYWx0ZWRfX2CI3ojlXzjvp
 pFoo3FwxMK+BeenrYlLyzLMxJETLSqTm1q/kjK79v+ReWlbSxsI0xilc83/52CSTYcg5ZB3Ec3q
 ENVXwY0W7FiqF636RF4VikBxHnGen3p7e64NA/nUM9PFEdHqSh0WhmxTdcNcUomYB+70fnpS7Q7
 U2k3WTy73nJcZpfqWH6ZW/BDWF1xYpxs3b6BqcRFHfKume76tVG16uuMRgRJ6cTkimcYsOU63lZ
 Y6LNnIH6I/HVwldTgaBKftGRcMG2ItQWlSR6qsFO98uop2q4ZTOlmjwcXUL3XA/Lk2qgCEcTnkI
 IJb5J9hX+NJ+e6duVdojMno89MbUrNOmYNarEAB30YPCTLS0W+SJbnPZP97FJ5P9Rht/FTCRSl8
 14lW/8O/CajYxQQkJXLeQT8+iOu/Rfa8FNhflKTykwVb5Nxu3w9qUG4lZxgoE3pwYkfU/n9sft/
 sJgEo26ivEd6pcBFwbg==
X-Proofpoint-GUID: Nds-vzakCdvHNrYhexV8DzaNXUBnc-z0
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4b8c95 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=rL6LpJHDE9oUo6aHBFIA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060113

On 7/6/26 1:07 PM, Konrad Dybcio wrote:
> On 7/5/26 10:14 AM, Akhil P Oommen wrote:
>> From: Abel Vesa <abel.vesa@oss.qualcomm.com>
>>
>> Add the nodes to describe the GPU SMMU.
>>
>> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/eliza.dtsi | 38 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
>> index c5635f22e2a7..e5b8377e6c3a 100644
>> --- a/arch/arm64/boot/dts/qcom/eliza.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
>> @@ -2674,6 +2674,44 @@ mdss_dp0_out: endpoint {
>>  			};
>>  		};
>>  
>> +		adreno_smmu: iommu@3da0000 {
>> +			compatible = "qcom,eliza-smmu-500", "qcom,adreno-smmu",
>> +				     "qcom,smmu-500", "arm,mmu-500";
>> +			reg = <0x0 0x03da0000 0x0 0x40000>;
>> +			#iommu-cells = <2>;
>> +			#global-interrupts = <1>;
>> +			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
> 
> 674 is the correct globla

(modulo the issue i explained below)

[...]

> This list is not quite correct. It must be sorted by the context index,
> to which a given interrupt corresponds to - the driver relies on that
> to give you information about where a context fault happens
> 
> Moreover, I see that the interrupt sheet has the bug where some
> interrupts are offset by 32 from the base vector, and others are offset
> by 31 (i.e. the SPI number doesn't equal irq vector - 32) - please find
> out which mapping is correct with the right folks

Konrad
