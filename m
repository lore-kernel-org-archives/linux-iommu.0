Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6D631AF07
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233235; cv=none; b=K7KMxpxfFlTg4U2vCeofDfKFJbUTQfPLm3vAvH80qNhgcpns04xlaZVeUH5wgAuJPPgmGdZifu3PwGcEdZYwyktSAP618Ntx9zyR7zRNYKTOvwetyHNCeWnLr/UB+/gXiVfuPomqPVKH3AvCHvVP2yJj3+qqdMMfl3mb9MA/m80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233235; c=relaxed/simple;
	bh=ickOgqp7e7FCZNO3eNjSwNBANQsKvA/8RRTMthmVMuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToQfY8cCp8sXOEDivL9Ij9hAJ2dz/9fVVwxxzViSDc2DJX4YM9zHeydwF2dBmB3gJrqMINCj3fbGSVzrBQDUycCV1yxstAVgTVuMCSWBT2bNHlcBTm5CBhjENhmma+H6W1hOFeL7SY4LdWgQ80U3t1MoVrsouxUglVBkK0uMAGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pDY3yLV8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QrIfa1se; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pDY3yLV8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QrIfa1se"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBXZ6S3744733
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SNCnasIGge6iLQlgIEDujkQhHNFEgY5Q07iOwzqg3uE=; b=pDY3yLV8p6AaPYor
	6i1WnaLjwRgDHl+AqULKrA+SvQ7QGs7OtcgUPlg+oCSRXyETLuz1MldKJ9cw1ZUs
	Wgj18jmlMuxQ3ohXl7BfanVmjD2x2JjEVq8ZLMn/uC74mDpMeS6a2i/HzGIyhAP/
	I1WR8eE3wwTbp6aywJR0NKUdycz6bPQMrE9ds+fD7Eon3UBWOJ9bbJWOO+qZDzIb
	ymQpl9HsYzYldCHlqXXIxOnPcFqm+Oe1pMxLK1otiphDTPjVu1PBVxYSPPggBjLg
	urGCm+rqwf4hHkvxLLUq7F5PjaZpzobeneMMnyUW/8A7jA42ekDRb/ay2cdUjFI+
	vH9yQw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eypx3a1u5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 16:47:13 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7297b2a8689so9126137.2
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782233232; x=1782838032; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SNCnasIGge6iLQlgIEDujkQhHNFEgY5Q07iOwzqg3uE=;
        b=QrIfa1se+Jrs84RTueZHYaix52noWS590MyYFPSLTWP5SUpB5FyUKkzc3HLDzeN9cl
         PZtwoJtXQ0mBn6oYdqxa9C6eKucekGndMhuNaRmdmiLVxrP3IRrj6ii7Bg2xYCewWMTi
         +lJMsv39kq8MC6WQKENQy80iLLy810KA6/6/PwLmAfoYo5sIPyG//1RzCQrmr/RR2O4O
         AwAUW8E1MGvr79vlJENZql7++F/f+k4/th4djKRV2yHCx+01T2EruEs+r7VdIrwqcWM3
         GN3AsG7tBpVw4FxAddX8yvFJSD5R96ZePLRKzI6nsL15iSx86etT7IdR43lzUqstioVF
         LXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782233232; x=1782838032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNCnasIGge6iLQlgIEDujkQhHNFEgY5Q07iOwzqg3uE=;
        b=bFIREzz+95zDaAojVNeJu1weqjCwJEl8HytlAn/FHj7H5HFkoNylCfkJJfWFTcZ3xi
         572FWo8OcQgpkiMd7FDTqIQ7J3uo/jCPvefg+NHMyT7HBSGpabQue0sKmcUYqIoMq/Nh
         c5iP1aNqMyAyWY5TPqPk+pO6jfOnCPTfloc/gHcUoZgG3daCDugSVSd2TAVZZTMgEkRt
         ovM4Yq95J8eAIxkmTBw8C3UMjBVQ9iaSP1Kv8+Qxtlmz4BLO1MlGYPJj+1GWe1SNO//b
         cSFf7j9HX7n3mcJJNxILP5pAuJWLagvaoQq4HMiKe9bsMOvFbSL0HhFKeNpnE3xSqeDm
         paYA==
X-Forwarded-Encrypted: i=1; AFNElJ9JWPlKzxL/414jHlFCRI+zGxwfOFybcnY7toar7Pvf+v9BPd5R0nF68dt3Va0IjukOiWtIMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzyLAKfi+TjcqWfc8l9hynDDCbhBZExxRV8Iv5K3TMBq+D3UW/
	wugqwvNyvvMJm1e4F1Hhoivs2QlQtP09fpe754KGsTTV1s1lGnvJPzbzNuAeTMuX44KLhIbha0M
	xX2gdQihvH8TRuuc2+LD0YdgjXm7xdtheuN+1h5D0GkWnMUZqBKnpbfq3Jw==
X-Gm-Gg: AfdE7cmTmMKrEmBcCguTIFwOfFsPmG7LGfDvFaQpLStF5tKhnSBm9IkXIbUEg4l6jr2
	KiBu+EAmxP++1z8JBd1VeqUKdD0WSpRKc2juOIUpvNF+n1Ul30YEICNGWVG/8k2JuVQRnwN7L6j
	fo0mnawz+6ZafGop+U7UwjbM/RSNOm7dT7cQgPlwbnWQTTS9QUwPMKiFDcro9O6hdoQOyEB1DtT
	O6bZ+gdI3q02EQEpt8oQYEzHZAlR7dFWZL1FYjignAHR2ysao0wAOtR82uhUfz9myJlbBjjnzTR
	pNXHk0/7x1k8aW8z/7dCiMIIbt/iKyRGM8cTNlydehyh4epFQ2R5JPbxukdUtYsyX6TB+w+F3tb
	sg44dR1KgHfF66s6xr4oHwKtr5Uc8jaaRDNs=
X-Received: by 2002:a05:6102:5715:b0:632:8717:e553 with SMTP id ada2fe7eead31-72f3b6a9e65mr1438691137.7.1782233232036;
        Tue, 23 Jun 2026 09:47:12 -0700 (PDT)
X-Received: by 2002:a05:6102:5715:b0:632:8717:e553 with SMTP id ada2fe7eead31-72f3b6a9e65mr1438685137.7.1782233231529;
        Tue, 23 Jun 2026 09:47:11 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1002d6c5f6sm195658166b.49.2026.06.23.09.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 09:47:10 -0700 (PDT)
Message-ID: <adb84189-59ba-40cc-a18f-0405ee5a7b6a@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 18:47:08 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] iommu/qcom: Add NULL ctx check in TLB invalidation
 paths
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260623122034.1166295-1-mukesh.ojha@oss.qualcomm.com>
 <20260623122034.1166295-7-mukesh.ojha@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260623122034.1166295-7-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EsfiaycA c=1 sm=1 tr=0 ts=6a3ab891 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=5zc1ivFRGWfvx6kDekkA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: bWTLPBC1Jk0z3RtDXblTGBpHvZVfffRm
X-Proofpoint-GUID: bWTLPBC1Jk0z3RtDXblTGBpHvZVfffRm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEzNyBTYWx0ZWRfXzCD/cQKMfBnF
 rMdLzocxye7frezLVOVcCpE5oJ8S71jHcUJxA1onZiEeSl/kh9IUoZ+d7EBGYVweMTu6CWJhhtr
 C0MeAsRHV99uJuTh0SYs0oKWd9gS/84=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEzNyBTYWx0ZWRfXzzva7GjYlRJ/
 8UXM7r2eXW1/a94R9idG3iXZcKyqpzi0e6HzqzvsTYrG2DVVEYzNaNtFnydq36TpXMDWWvEm1zR
 OIpQpjsu8JO/TsaOxhhODgAcq5TH9+HL5kiapHFFv3E7xR/ZQq8OHZNihadL1fK4VcY0kMFHYmU
 wANpjVieatFthKWipvqz97V1irimOz+g958l53U+l7fLDaT3BHTzhwH6Ax/tKzZss6+/IO4fS8F
 0uwymKa33IcGRhacsQWQkeN5EAsI0jh2bhmG/4IBYFy5td1Z6oLHc7nL/2JHcu5C3b35o34S9I8
 2P540Uy2oZsW+ks6c7T7sds/xTZoCJtUaBmmUeV6wGEQp1EkmN2uOGl3Exr6f2mjpnQ3Ctx24DG
 d1xohi2JB/zuVh5FAJjKPO91U2yw37p8re+OYyoHOGClHsTZUiHlGwU09T7AH+Wr/eKBU36/UDl
 i2cnaYzN6AKwmv1NLIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230137

On 6/23/26 2:20 PM, Mukesh Ojha wrote:
> to_ctx() returns qcom_iommu->ctxs[asid], which can be NULL if the
> corresponding context bank failed to probe or was already removed.
> qcom_iommu_tlb_sync(), qcom_iommu_tlb_inv_context(), and
> qcom_iommu_tlb_inv_range_nosync() all dereference the returned pointer
> directly, risking a NULL pointer dereference.
> 
> Add WARN_ON(!ctx) guards with continue so TLB operations skip
> broken context banks without crashing.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index 40fb0408dc07..51b60b296bb8 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -121,6 +121,9 @@ static void qcom_iommu_tlb_sync(void *cookie)
>  		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
>  		unsigned int val, ret;
>  
> +		if (WARN_ON(!ctx))
> +			continue;

I'm rather unamused that we have to deal with this in the first
place.. I don't know if this can be easily reworked to be more
predictable, but this works in the interim

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
