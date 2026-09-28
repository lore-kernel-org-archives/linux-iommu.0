Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A354F3368B0
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578225; cv=none; b=jBaagD5Q28cMtPdt5Vc8AZI0LGUdChmKnMf/9bLxI6m6Teh+LfQZ4RifWg0i3SWO5qulKOYlaCMPX/5F6KPlIVf7thjNKMkT0uuWKEcebvBYMkjWPxMeDReJzgMF9E8AEwxzlgNl1DI1s7V3oNkoOnB4xkbZiTAholRxbyjrkT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578225; c=relaxed/simple;
	bh=GCgrWcGSYCDY9mnbDQEO1hABrtGS7fG1AJ/ZSwmQZpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mVIxVlIm58ZTHb7rWNxBmsL65Scnc1ljJk1ZHW2/T08j2Ot/eNlBPQ6QLopnFGrUYNu94hX3FYGL4hd3s1l3NovfD1cGsLHbhMUGRXYkejIMXPHSBUuxt3oenzZLnpuMKWwIctnHX/1jmoN5chyXFKwp6y0PE2t4D7Z+eS5GtWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LwYh32Uw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hisB7vp7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LwYh32Uw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hisB7vp7"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S6EWxt4026546
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 06:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4OUbyzBVRks7k0WbMnD+M/l6sliOO4VjgKoS0xSBAbg=; b=LwYh32UwulbZf+IO
	jFpCE09jsSD2szNPg9DkANXz9m8kUMETxG9LCYtzMzFpv7lXFMdde9yaKbrwB8TJ
	7mGM3a4wiI+DpvtiWB5qINf/U8sPmxkjCx1rDH1dVdNrjesQJ3qeY77zovnS4CFU
	8cn37vAhe7RtJrXWeHGG8uZyDhGYByHmyaHEMeFm2geFxnhczHnnUj8dRWe19S7k
	XP+XmRukowi/i3NrMXGm4tULmhijwPT3ALAlZcwO0WFWknGQKXpaGR6cPfe6jCmk
	l5uPUVagub5ceP9pvs9B2iVuUe3cah7FIslcRPpFSKoUPCKTdmU890NSDPMqYkU5
	r+wmvQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjt103pc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 06:50:22 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8823fb254e3so30859b3a.0
        for <iommu@lists.linux.dev>; Sun, 27 Sep 2026 23:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790578221; x=1791183021; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4OUbyzBVRks7k0WbMnD+M/l6sliOO4VjgKoS0xSBAbg=;
        b=hisB7vp7HKT3pA4jtBkQBlTHib+diyCgtrW0qsC2GFdYaa0lk6GttB6f5zIsTCf4OB
         yU3LpyPP/nq9rTLMZzmncw+GQE6HuY2kUfHwG8IKiGC4FrVGgoGiWk6XXCxfOqGUncfT
         CIAEZOOxPFpWEZCIkjQ126Y1a9eONjdVS8+xhoI0XxwGrLs0aqe3xiJV+9bqRbYaou6y
         kds1C/6HG81cxIWvY72Pp7CLJGfpooQnEjwMJQz/u+O9dOjgYdlabPYfTenDq4zx2cX5
         LRZJ+Q+SJ5Jd4wSlN6bMy/wHBgL3lJQAEik3Pl2zWugdqSFR45NQnqi6IP5+7ttD8rJc
         Vyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790578221; x=1791183021;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4OUbyzBVRks7k0WbMnD+M/l6sliOO4VjgKoS0xSBAbg=;
        b=C8ayKrETyjNRGs2q1elYqX0KqKbphAuPnSQmmdeBD1camzb5rRCkwNllof+BeVl69S
         rQm7BT4f9+NoDf216hebhiwRcSv9pDMWRRH4o0aytbaWqvlsvHExvOV7Ad0pLFoP7jt/
         vxbCmE9p58cMGzX0fmuN2duBsDpwYwey+GYkfkvrWzqhjx50HGMoAn3sO9tw+eIC3SdX
         RCQSDfnEzudiBz9p2a/E4Cfuh3SIVQGinkgDwU0IAlXPub3aTPXfZc7RIjyjXaNSvlE9
         dyTOXlYiHrL/xaxKmnxM7y9H5c2y9lRq4GjhILvWKF31NKhgBexpTAL4AL6i72Zut5g/
         +fWg==
X-Forwarded-Encrypted: i=1; AKwUvBwGJ5Han0vQogEB3BG34LlPcx6RmvBgmyiPmab58bkPF4XBmSYeL2fHLQEgdSnp/heAnBy/7w==@lists.linux.dev
X-Gm-Message-State: AFuF++m9RlPTr/5o1V1C6zOqf53wy3k6rc5nnh0aG+GebzOo9tXR920z
	ah0ttEcIRSUxereEYmRdeBrIHAjJDiK3T+Nhx56xFhCCUmqdIZvx3bzabGErezgmB0UmuI5e8kv
	YvHjdFhQuz8ltFFkzqgz854p8lHFU0Nfalh+ksqnSnoMSfvo9/ltiZ/+i/Q==
X-Gm-Gg: AYBFou00UC2VaHVXeyJh5C9yHGk3exHAfwgfo+qA4Cc8saRy/UP2F5Z7xX+seCWmAVa
	q8JZfhxqroajZWkCdnEeis2m/1iqCQbyJ2XuDJ9v5VXYP8d+p27xzXst+oAg8LEFA/QB87lEVZg
	Nh1QIDitXMuiquhOYgb/IwV6Lw8IQ0QR9Vsj2iycom7DQn92oppTSx273hsG4MBez2b+M+ypHqK
	sjLZgmjKZTxYe/yrnjMIMw3wZClnLoZDNMXoCA7zxM6o7ZyafGAPKYWeLRxh2+K9yHw/2thsQEv
	tG9hp95VGR3E6x0ClDQMPLsLUEWxsibc4wv3Vo1nzE19sa9v3XMxWv8+0oHuVrL9EWXHknOPKir
	hpkm+SvW/EScaAY94sAnj52ne
X-Received: by 2002:a05:6a00:1488:b0:882:4ef4:8eb with SMTP id d2e1a72fcca58-8824ef40e06mr5035235b3a.1.1790578221264;
        Sun, 27 Sep 2026 23:50:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:1488:b0:882:4ef4:8eb with SMTP id d2e1a72fcca58-8824ef40e06mr5035201b3a.1.1790578220721;
        Sun, 27 Sep 2026 23:50:20 -0700 (PDT)
Received: from [10.239.132.150] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fe81f2290sm3633951b3a.5.2026.09.27.23.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 23:50:20 -0700 (PDT)
Message-ID: <9760cdc5-a2e5-4522-8e2f-3daba8331883@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 14:50:15 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: arm-smmu: Document GPU SMMU on Qualcomm
 Maili SoC
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>, Will Deacon
 <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260830-maili-gpu-smmu-v1-1-253e1108ce82@oss.qualcomm.com>
From: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260830-maili-gpu-smmu-v1-1-253e1108ce82@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyNyBTYWx0ZWRfX+t7N9d/7OvAA
 YRrxUepU2VM1YE6FQyDHGKUMSJBYztLwkvmR/sUUKTSMNppYKqBMb/Kw6Mwa9DEDYmvsBcI2zJm
 ru3pKX79QO9Y+1Kr8Cvu0LSlEe1JQ5JLwd63+e7dPP6B0UWS60FSIv/BWSwB3m1FF9b5osU/95w
 LlQGyXYF9vwgo8iPnPoXSIIUCMykgjuVKssW2NIdGzCZ7SDbz6VqUFbR2dZF7VMVKX4XM7G9Q1/
 fbjNLNXOH24jMTqdVP3JEB15PeAgrub+FpEVwej/l3r9R7PdnS4C38Ls1jhJJkF+VCVGmEa8oEt
 VSwWT4UknQmdsm1Db+pJBkO+fbRW6resS18/fApGkfgJfXaVtKnk8P3ioJ8ecNEpfsUAtzimzMv
 d4ENYCaAdcv0gb2k9tyXPXw9NpbzE2TgHv3xO31SfK4AMda+Pd7D4Ek6DpGxvgB6hSE2gZk9XJL
 Rk2tIyEgB/3clwH54XQ==
X-Authority-Analysis: v=2.4 cv=V8foQuni c=1 sm=1 tr=0 ts=6aba0e2e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oR-CnN3JeSK-wwzircoA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 5QuH5icfXLfEKdK89tma1L6wh2bhVif8
X-Proofpoint-GUID: 5QuH5icfXLfEKdK89tma1L6wh2bhVif8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyNyBTYWx0ZWRfX3Li9ym8o8R5K
 jVql78kzGz5c2e1gSZXdYrFybMmz5XhO+36bGe4DkFBT931SF8wbiqL1WKZijIbuI5KoASNJfWq
 OKACLjZJ3tckwM4xjVTDzvdnQcU27Pc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280027

On 8/31/2026 10:44 AM, Jingyi Wang wrote:
> Document GPU SMMU which uses "hlos" vote clock on Qualcomm Maili SoC.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index ffa33b7f4a96..187710fcc567 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -101,6 +101,7 @@ properties:
>                - qcom,glymur-smmu-500
>                - qcom,hawi-smmu-500
>                - qcom,kaanapali-smmu-500
> +              - qcom,maili-smmu-500
>                - qcom,milos-smmu-500
>                - qcom,qcm2290-smmu-500
>                - qcom,qcs615-smmu-500
> @@ -579,6 +580,7 @@ allOf:
>                  - qcom,glymur-smmu-500
>                  - qcom,hawi-smmu-500
>                  - qcom,kaanapali-smmu-500
> +                - qcom,maili-smmu-500
>                  - qcom,sm8750-smmu-500
>              - const: qcom,adreno-smmu
>              - const: qcom,smmu-500
> 
> ---
> base-commit: e30626823a406725ce29bc75cb8ec467d3e1e326
> change-id: 20260830-maili-gpu-smmu-33d20c1f4672
> 
> Best regards,

Trying to be a polite ping here to request apply since outstanding
series are waiting for apply of this patch.
Feel free to let us know if anything is needed here.
Tested with below series [1] :


[1]https://lore.kernel.org/lkml/20260922-maili-dts-v1-0-ac2b1b76bfd9@oss.qualcomm.com/

Reviewed-by: Maria Yu <aiqun.yu@oss.qualcomm.com>

-- 
Thx and BRs,
Aiqun(Maria) Yu
