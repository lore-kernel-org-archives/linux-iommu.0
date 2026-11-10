Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294795;
	b=AI/9DOzgPgywD6GnDvAtgJdLOpvBFVsa0DgPUy0Bb0HVW1/AbcY0RZuMUyF9Ifg7SjTF
	 UGXax74v1Vp+N5Yl7BOb4jQG3MwTT8tkSNzKGJ0tyenpyJdWuB6krooaFT3AsATGeac8k
	 PSy1uWBFtufTwvpuZPQRtlPrcOSV4RAn1XZtp6NIQjKc5uXytn7p1+NY04RA/MV2Yf+YD
	 1toqNoIqt0ALeIo2ZNZX6aFGgwDM7HxbSl4K7qRgKzl/O/XqtsXEPohzLFMZcGO9QXCs1
	 s82cRafPK/2YvedHZXRSriMt8F1Z/53mtyr0mZhIbTr/2oPH9V8M2EXJ5LVbnD/R2Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294795;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=O7UXFVgKpvNjfKTFlHSJy5Szag8SKeYr2EcItqqOWiw=;
	b=cIejEQYbkwETMHKYPkvIVJQ48iu6LH9VdiZ5k0N2AWFAi/mWR0UtrWDT8TlTR3J1mAnz
	 LUWVul9lh0YSK1ZdYTi50DgHokIK7PX5uTlUfx98kryxWMXvRcBklYH3ZGr4umJrSJu+H
	 EoV5n5AaFAI7ECi/HLYX012EF9dKHsVHEaDgPqGLrbXfHo52273olSroWegooQnsizk36
	 0pxZdP+HNqTncBNkqUSzqjQeWsRm+JJfbA85hifaXHFPDJz4tK2V1pHz90ikwCdRTknYf
	 qLIXRxX8Ys9Q0RP1LinXO8N/1oaw+IDsO6CV114rMeqBqG8oDVtaTEQGomg5DzIvJ+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pccZ+g5B;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ja5r3Neu;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E401606A31C
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 07:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E401606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pccZ+g5B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ja5r3Neu
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA49tJm1767205
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 07:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O7UXFVgKpvNjfKTFlHSJy5Szag8SKeYr2EcItqqOWiw=; b=pccZ+g5B8bNi6/gv
	byGX8aXLKOZRv456TpYR+WsMYwZif4FXQvaudpLIWegAEQmWeFKJhOCC6gT4NhWu
	HJgZKatPY/GzU4RNa784o9mMe9LssI6kF47gqz2lsYynCTEQAHydRm+U1rfZ26yO
	HMD5OADYkcwCRRUiBc+mumXP06zuiedmYXsATCtUw5EyBjAw00FMg40it6BkC2ds
	VqokwfaSeCHdyevjt+LoBcFbCLnFoikjy7ZdV8taEhIhV7jpEF8ZvhUm1Vvjdsop
	4O1OvU6PLo/Ko5wEsmyDwbNupgFKbFnKfm7T1Wb5SGKO695TR+3gOynmlqP0f6wO
	PjogAw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huucp0sg7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 07:13:14 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab926c236aso1665668a91.0
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 23:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794294794; x=1794899594; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O7UXFVgKpvNjfKTFlHSJy5Szag8SKeYr2EcItqqOWiw=;
        b=Ja5r3NeuFG1hhv2EN0DZoxpvohJvt2cHDX9yMvr3acXAvr1Ck9Ckgczl4xEV9mKQ9f
         RzcORfYPo7mA8Op+7aIpfTYNbxwR9WT4IMsYjXH24rMmQ/5m+KLTssZK2WJZnu+DGS05
         RzNopdm/ECwrYXRs+c8Vuy+QvGpb7YzSUOdoO+HB5nbGZZxxPvEHW3sQTe++jkgvTQ5o
         Z2gqPBVxbZRbfkhV1JkaSFCoYaMWhDQS6G0d94Vb/diXB3Kdaid85K30SW6Zg32NSIHF
         j9EoR/m4z9hcI+eKjJhKK4a+oJVgQ0GBxTxqPiGOh+tm2zhYY1bATIghDD2JQKi4/PTe
         pCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794294794; x=1794899594;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O7UXFVgKpvNjfKTFlHSJy5Szag8SKeYr2EcItqqOWiw=;
        b=TuwdZy7YpB7G2BgaTUshTvnXgEGiqhSIvAkGDdmq3zX7fD9dWdQLKMVrZ5sqJPNNOD
         imARIYrQ7iwFKSYMr/tVMcCgEtVfoO9aIXOPCaBO0AdmyVndCcNQTEScMU9N+lugyNRA
         MB4To6maeNnp0A5xx0+v4GNHXECnLUkVg/IEfK8KFKo4zqdHJjCt+rffmVjAeF+wmgIV
         GEerllPRos+VsBggJGHjeZl2zcmnY549UF6bXow3DmZTiXLpOhdznBKp+n03FQeu7SWc
         b1yrh9H4EYsZBTOArRLPEfr/iGbBM5ej8tbG9vVszSw6V4wLvckDZlSJ4nS9CnKJHJr0
         mhsQ==
X-Gm-Message-State: APuU4Z8MTp+dVwT7g1qm63UVfZAOnvMbz1viY8Ut7GEvmfkSvwr78FX2
	ghfJ9UQoui2+dnS8g1IuBUThlMDlp5D2YZPShavET0kwM1FvUuZ5hIumwlePEeE+6YuO2k9Ta7D
	Z9Zps08kqiOjA46FNnER77H0wH+X8+Bzspx39IGGaQz+OFFLscmdegUTPhg==
X-Gm-Gg: AYBFou3PFN3POJyW4D7T7+m4/W3aORJz8jIugPzo/FpwjZ8e9CZxeB6dy2v4iIqyDli
	LN0tXHlW1Mnk5AVOj0PXr+XQF6O+rAjrzTiw9JC5Rx4c+uU2UQOstKBcX7dD4KOhfgVGJf5gSND
	gZo43FLC8peRNPHPMOaw0Z5TgJ1RoXT7rbzVqZteVY9N904jIR8GUbzN1aKRyIYgnUJu9qIuGWo
	7tHfW04pmGWZUFlf2BWuXXGjgCurmQ4BqVMNh4zOukzSHidR/wXzvA+slpCaqaTid14WHF+eh9F
	Fj+phJdm1rEaX0huPcpuZ91E9qI1XhkkWMuiMAYmh/skk6MklNCq7H5HGi/G4AsQcoJWsWRuXci
	ZKTqECgXnwCX57bVCKzEZ+nqR8Kb7sYZb6tPgESGLrzgNjceR8cTaxZ8cRrsbp04b6W+o8z/7Jg
	==
X-Received: by 2002:a17:90b:1c8e:b0:3a7:8350:3f7e with SMTP id 98e67ed59e1d1-3b166cd3dfamr1883541a91.44.1794294793465;
        Mon, 09 Nov 2026 23:13:13 -0800 (PST)
X-Received: by 2002:a17:90b:1c8e:b0:3a7:8350:3f7e with SMTP id 98e67ed59e1d1-3b166cd3dfamr1883528a91.44.1794294792977;
        Mon, 09 Nov 2026 23:13:12 -0800 (PST)
Received: from [10.64.68.239] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1678d1f42sm2761077a91.7.2026.11.09.23.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 23:13:12 -0800 (PST)
Message-ID: <b75ff010-305a-492a-bd16-b27fb8a4e064@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 15:13:07 +0800
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
Subject: Re: [PATCH 1/3] iommu/qcom: Invalidate the TLB in flush_iotlb_all
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261031-msm-smmu-identity-v1-0-a2a70580eebd@oss.qualcomm.com>
 <20261031-msm-smmu-identity-v1-1-a2a70580eebd@oss.qualcomm.com>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <20261031-msm-smmu-identity-v1-1-a2a70580eebd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9VwAcjfoJi2g0BEneElfnLz8TeSmGsdh
X-Authority-Analysis: v=2.4 cv=U4oHnuru c=1 sm=1 tr=0 ts=6af2c40a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Ih06bLOFWD0XbLq0AFAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAyOCBTYWx0ZWRfX6mMSHAVZHqRw
 Fq/y/nufAejFu/mFcbxQugOHWUZdrQqhc7VmHmrHjud8o2Bq0Bc70j4VU+5RlWphpQhGkSgZsAt
 GTp9S3vZYKqdtycEurf0ZqTnEwA9Nv4H0qy3X+LutQEbmuj6MQt/1V6eIoRU8Kiz4q8svWaVZ3/
 bg09hN4dvrKpSZ/WC/4SPE9ioE2mK0co/VqL9IJlVvpI8daSSRbH3fVdRirBBnsclpb5QK6e5dY
 em+Fv7avnrmYlGCdu2fVGJ2mnXbVNIXKGhW2JorqxyZflkT5LukrI4TFR4NPk4mkVysNEdNeGVF
 bdZWs4nrqDkuMvLhDH528W3rrVP+U0jlx3k3EkEIH9eoQM5Rh3ciU+O+MABr8g5E3Yx6nVnoNR5
 iyRJr6siIRkpDvOXsTlqsMwuVbO0CLy8Y3yBiorhm6fBgf6vzB08OUHd2TteVBBXFXtV007VD1d
 YCHVbHqjfA8vi1AVL/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAyOCBTYWx0ZWRfXwO6lTVmXpfEU
 t643TH1FVewnT9eKU/+jnhRT/g8TIXTu39w5J6dXYRhQVMCPd4EtuRy7WSMvW0ylYPtU6m8uE9y
 zHIjpa+DQV9gIfp/D1lue0w47jSx19M=
X-Proofpoint-GUID: 9VwAcjfoJi2g0BEneElfnLz8TeSmGsdh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100028



On 10/31/2026 6:04 AM, Dmitry Baryshkov wrote:
> qcom_iommu_flush_iotlb_all() only waits for a TLB sync and never
> invalidates anything. iommu_unmap() users do not notice, since
> io-pgtable invalidates each page through the gather, but drm/msm unmaps
> with a NULL gather and relies on flush_iotlb_all. On db410c the GPU then
> hangs on stale TLB entries as soon as another process reuses the IOVAs.
> 
> Invalidate the whole context, as arm-smmu does, and keep iotlb_sync a
> plain sync.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index 21d18ce67b98..54130c32056a 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -479,14 +479,22 @@ static void qcom_iommu_flush_iotlb_all(struct iommu_domain *domain)
>   		return;
>   
>   	pm_runtime_get_sync(qcom_domain->iommu->dev);
> -	qcom_iommu_tlb_sync(pgtable->cookie);
> +	qcom_iommu_tlb_inv_context(pgtable->cookie);
>   	pm_runtime_put_sync(qcom_domain->iommu->dev);
>   }
>   
>   static void qcom_iommu_iotlb_sync(struct iommu_domain *domain,
>   				  struct iommu_iotlb_gather *gather)
>   {
> -	qcom_iommu_flush_iotlb_all(domain);
> +	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
> +	struct io_pgtable *pgtable = container_of(qcom_domain->pgtbl_ops,
> +						  struct io_pgtable, ops);
> +	if (!qcom_domain->pgtbl_ops)
> +		return;
> +
> +	pm_runtime_get_sync(qcom_domain->iommu->dev);
> +	qcom_iommu_tlb_sync(pgtable->cookie);
Optional cleanup: pgtable->cookie is already qcom_domain. Could both 
callbacks pass it directly to the TLB helpers and drop the pgtable 
variable and container_of() lookup?

> +	pm_runtime_put_sync(qcom_domain->iommu->dev);
>   }
>   
>   static phys_addr_t qcom_iommu_iova_to_phys(struct iommu_domain *domain,
> 

-- 
Best Regards,
Yijie

