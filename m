Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792742791;
	b=yZkbrC2O5ZonHHQA1ADGSwGXW4FKEiiFk7euK/6NXq34OiJEPDhqHSdWdxF2Nl/1WJ4P
	 naweo1FMu6eWYKqQTTjjFSN6HOxUfYd+Ge1FKVrdo+bj/V0PbOV1MC9NklNEqd4+qBKFv
	 IRzEMci72pjDRPtnSr8pD0m1CWWP2eDNO2GL9ynfSFcDWtkwOHfiDFQRzbg3ehpwxcHLA
	 DT8D9dtYODBg0f7kjGLLDS32DT3AkgcidIZLS706O2Hfsg9DMQuiBUihZoJgMHGHZv2zW
	 U7PAN8Uespy+9Z3lYfIYftsfniJDIK3RzLj57VuqY1g8YCGSHpOYjCmw+Ro5CiF+Viw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742791;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WkRK8y3p+giH1Dz66bRMZzeRiuELQ+JWzWO1dmY60cA=;
	b=j4SXNPPxHl3/YrkX6n5XMF/uFmcZxBMkTWvNHWfvnaXlpvuigNQhAAYriWgfW5azgWRg
	 zD/fVKBLTDlCj45VOn/wguOOf7chIw/5FoOmrkztzVcS+49xNng1V+FKxvbyhE1QpFInd
	 SDJlv2epTwv9osKBi5Dv8nuemqS1gQkHuGBhGyfZLuU1BTUPc90ND8vfRlLIjEVJF/QPP
	 03HkUXTPzuErsNiCZ3z1j7kyiClA1EMNGZdEFkyL+P6OCccP228PUvO3bGGFOlIsHvscK
	 l5j0B+v9Xj6fSGAX149bTzOfLvdH3HquAXaHfv8CpfynvJaqvGDh9UixT1zv35N6LFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U4UQBO7O;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="OQ/YDH0L";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744A2606A31D
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 08:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 744A2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U4UQBO7O;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OQ/YDH0L
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FLqW1552394
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 08:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WkRK8y3p+giH1Dz66bRMZzeRiuELQ+JWzWO1dmY60cA=; b=U4UQBO7OvfeVT+v0
	++oqPsbyXmrsA7tzlP+uwizroGuKX8cWnNIN1LH0ZJpnDSJ8y88P9EfEQH0Fzxpm
	feBGBzmS4CiQBc1uQCcypry671AEWQ1hKDf+72l3GmdvwMcUC3+CrUV20tfRjkUh
	gWd8QlybeNXQWyHBckO1C7+0hLRQ1djNec1SosahkPj1T4zG0hIlMXvOa3ZEgIGH
	nxlFr8Z0mf/WMpYgyVjRNygIpgBioctlRvXTnY7FpkpnLtV1PcbEkDpfKriXj/N+
	SWa9xsmn9H7fxFsEt0vawjeSWyj7W4D5jbCaCbukP5ddVBOx4rBx4ki7LSBdZFx9
	Pm2hWQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmttmev-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 08:06:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb1091fffso5677985a.3
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 01:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792742790; x=1793347590; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WkRK8y3p+giH1Dz66bRMZzeRiuELQ+JWzWO1dmY60cA=;
        b=OQ/YDH0L/vAc10gIfLUIMOz3YIiDYZCuc/w1GxwhPEH+aCmXve8U+P6pBudcl1hwRu
         KArKb8Xi+WhfmuCzod1QLy4YvFSjzSrtqEcxgwtW8KEuIuaY0qIM+gRRz12WSTjhF69g
         Hw4pV3qUswxgyjZNkpQmJFu+hEhVz/2u49Ao9JX4uApGrq3UXbTCwcXqemTCD5xEGYSa
         mupnsjzWtU3ON3dBuQMx86aEL5OVc6/Qw1p7o0k5ToZHMLAig5t6YnnAxYXoKfdYUk2R
         qRhtFThCzAiC0YTdQ8OkI3K6mv31wnXYeaDcBrTOj10HgfeCZ6jJeBLHPglFfsC2rm8p
         CdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792742790; x=1793347590;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WkRK8y3p+giH1Dz66bRMZzeRiuELQ+JWzWO1dmY60cA=;
        b=u9vVvGW7rRPbjkRa8yvjgMp4p81FuDEHH6cOy4kknJd2Yg5+HXP/xnoxIDeAQ0//Q9
         iYsNltBYQQos2KzMeAOcxUIv017uMifDg7778TXHiI7lmg6M014mQqhtZ2UzIwhE0eBx
         QrgzmFGCr4InpDcl1uPPk0ruKSTuGtTiqC2InO84+PLPDg19o3RZCBpzgLmYUqv1ORq4
         MZQZXQR6IWkZ92sT4lGpTLBrGzIAlWtI0m4bnV9AhGoKdun9wNwCiDXhPTAlh9SQB4Vg
         0jGNXS+UuOXQZ53y164Me91v+swDbjKYY8lF1QsYXwBxqOBZJCa5tJXx2wb7No+4wKsL
         +uZQ==
X-Forwarded-Encrypted: i=1; AKwUvBz7FxgERjyEW7HvwhOEZQTdA3k6E+35A2bHNeCOEmTzeWAHYmO6t1P4eyBQ4/2kSlMBECsy8g==@lists.linux.dev
X-Gm-Message-State: AFq9FYLZKYewKIsVlgTjtUyowYsSiywnLGs40fahEa8VGOIMldWz1fvf
	whkPBUrO0xTnFM3cn0sHh4xvwWlFm9aTfFUPQ07xOOXNHEgOfLC2Iq7TsndSajS8HCA4WcY0y5M
	vQjaRCiuPKJy/Ukb6fX38Bm4q8d2XfzRJ+Ay5/UxQaHrGrbwOSEhfCmAAoQ==
X-Gm-Gg: AYBFou2dHvqhz047x3LbWjmPltb5C9W6siP4WzSGr+zhPe9omOQ7hYNfCPD1IjLnVCq
	1/xEq0ToEd3rSF0N74XEWpNMEglEwmJB7QaLDVLCtjJRG54ngE7HvCpfltE28pQcZe2XiSY24q8
	N/K4CnqgiUTNAHZaRQiD3H73+Ejq9hucrtBs0n4gc4w5hRGTF2K6qTpWHVKwt/sRVQ7td791C6/
	TE6wTKoEsCM1VIXJtEsKHqTEiuSOVH/lbP4jfUVYfPtZwL7cxE0Ce+mQF0adL9qkbSsmmwdPqUy
	Cg7np27MtDbcmCBjteODBDC7J45Y/lLcZgfqwGvB4ybaegXj/6EBz7XLGCNTb9M+Pq8PBIPYqTR
	GFXcXqx3gGEOrfwOo10MGJQ==
X-Received: by 2002:a05:620a:7313:10b0:939:8148:1e3d with SMTP id af79cd13be357-93f6f7f3e78mr296824385a.2.1792742789591;
        Fri, 23 Oct 2026 01:06:29 -0700 (PDT)
X-Received: by 2002:a05:620a:7313:10b0:939:8148:1e3d with SMTP id af79cd13be357-93f6f7f3e78mr296819785a.2.1792742788961;
        Fri, 23 Oct 2026 01:06:28 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46a5c4d54dsm73770766b.24.2026.10.23.01.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 01:06:27 -0700 (PDT)
Message-ID: <f3c13144-660d-49f6-9933-9d9cead006ee@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 10:06:25 +0200
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-qcom: Skip PRR setup on SM7250 GPU
 SMMU
To: patches@brar.si, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20261023-smmu-sm7250-v2-0-8bb881ce19f5@brar.si>
 <20261023-smmu-sm7250-v2-2-8bb881ce19f5@brar.si>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261023-smmu-sm7250-v2-2-8bb881ce19f5@brar.si>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adb1586 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=U7Z_fe4AFx8LFHQn5dUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: Jjxh8FqI5EXj22pRcZumksIYH4swyvuF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX7jXjZyLmsvN0
 UaVBuxYdKxkLjUw6Rq79KrAN6jHnytz1soNWJafHPSk+Wm6IeTJ3XeAyNo9wtpCOa953YaZptET
 8/17Kd3rp7gSXvEFyRfuTWDO3MUA3zKlbI4X10L/N3OinwP7i8ouAst+C5euzBIHCfTgKkrk7y0
 7o0VilpNI/NB57CC24jefh/2U1ONT6EqcNT5GQtQvEzOZXQMoKoRClzpvSq/k4qoHag/xfbzad3
 eRozsSiy/jYCpIU6F6HJEIY8pb8Nor1Q5q6BdVwEhnvlPxHGBXyGCotfjLe5iv7h2wXJqyuLexT
 dX60OP+7iRN0JlX6IUNmCS1TWVN6yW93yMow/SinLbxqj+alZEcCnpY8bMfCGrvkE6YKvS1m6kd
 ExRf5I++lvVGl2pgjRTaUmndJ5jdT4r7Msj+Mi3UtHFr+NCEnj6Z/mPP1l8ZvggJGRIjUWVJuiT
 1KAjhhE3Ho8bffhWswQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX7KwnQhhmCNGF
 b4xJyTEQZ5ooiZVIpikg3ZeSagTElwlprn8HM8Qon+GAS0pVWSXYI2u7QLUyVR22hRrq2kQFC9i
 IweKURYbRaor9w23xq1zaMWVcJQY8Q4=
X-Proofpoint-ORIG-GUID: Jjxh8FqI5EXj22pRcZumksIYH4swyvuF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230032

On 10/23/26 9:54 AM, Ishu Brar via B4 Relay wrote:
> From: Ishu Brar <patches@brar.si>
> 
> As on SM8250, the firmware on SM7250 resets the device when the Adreno
> SMMU PRR registers are written. This happened as soon as the first
> per-process GPU pagetable was created. Do not install the PRR
> callbacks for the SM7250 GPU SMMU either.
> 
> Tested on a OnePlus Nord (SM7250) with Vulkan.
> 
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
