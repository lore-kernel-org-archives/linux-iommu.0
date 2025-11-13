Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAC82E06EA
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027677; cv=none; b=NDE/93dl5GKesW/2C7GF0NkUeJuuwj2bTtQIYjIicdUSoxcFFxEn8ENpildnjdyq1d7Teij1ScxRk0+FzfaB0CUKLFAPzOJiZut8/VNzH9bJFwQ4f55B4KY/DlNhLQGfCUDpi1VZGSMcYCQBw0gplY8betKof4FI+VozhRvquZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027677; c=relaxed/simple;
	bh=8iAtj5DbgY4AaZ2Ot7jJeIbmNyqP+z+6PwnXeSkuUFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/Q/J0JN0GMDdLCOs9FmE0S6oksM2zP0W2h/o8iGlFnuKTVUE0wRSkmPxj9NSy21ffOFHUDEc+8M3AmixavV1MrzRvg/j1K7EqlKmVwoX4/tOrCiJLuYgsMFOwHJlO0fcjFkHKohjK8lT7y2EXuiBpJpynqWbM/qV4YJMdokHNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UA1XHHHd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fqzeus09; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UA1XHHHd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fqzeus09"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD65hMg3563304
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 09:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	omyFsDM0eGj29Q1WT1EzsONp+JQNaIFi05rWWj2fj0k=; b=UA1XHHHd06fGc5oj
	UDE+8yWJZUDMpUakkDIBVnZ0jGSLIw1/LrjbR4g9fysnT0ovoqWOW3Ndpc7EpCbb
	HGdAgKMXxXnmD+Cc2QrNEqE+ucptu0uYQ0uHQ1xWmVTsw2TL6sAFykqfnhw2w9T+
	KjDzxSIR32k7vnh1wz1Rlhi5UvNBFaYzkMed/JBioNpx3Tf3bq6XtX3O925XHiML
	7Lm4wL6pT6JfytKQ5RepsV03igwJVXDuZGar3glhxLxtkhNoBYuSFs8VMSF3BTxJ
	yadKRTeBB63jFiY3i/ojJyr1bMOmIm6W8Kvmkf7oRVSYdY8akmubSoVY/UdiKZYN
	L06QZw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad9rvgpvc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 09:54:35 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88057e35c5bso1451936d6.3
        for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 01:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763027674; x=1763632474; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omyFsDM0eGj29Q1WT1EzsONp+JQNaIFi05rWWj2fj0k=;
        b=fqzeus09m8ziM7fMNOdD7J4YbSVuiOwy56sZ4+Olhp7mKy+c+FPGalqKubC9Kg0tTL
         W0zzkqNf5JREyEFgKWQSv6QWNwyICO0ZlikX3QNkR2LL7Kvylkq2ZwAMzd+Lr9pD+Soq
         Zca2vx13GB7Of0TKowofL3/tAp2KfScX0hv0a/tE2D8tJuyOQZcZRL2QyupsIFnl0VsK
         FrSIjHC6pTN6Z4dMy0Ze7VQNpZX883gIiEce/XDq7AJ7o4VyS1p2itCDLS2swWsOwaC/
         dhgIimY9GhUKduzh8MH87DhI+zUjEXWAjV6sKX9gEaWDkUmpM4F3VnH2ozUgVs8pSeEs
         o9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763027674; x=1763632474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omyFsDM0eGj29Q1WT1EzsONp+JQNaIFi05rWWj2fj0k=;
        b=Z9foO4HgCRgX9CH2b0jfUNdUoaBsvmIAkbW/Hn8v1FUbTNqPPYTaosqqgm9SEupWqj
         rKs7yd2naCruxw4bFlrfHEVqH8x7DQ7hepPC9lSzKlUDhufXnf8iCv2yePaGU8BQm6zg
         KekqW8EMOfA4+nRgTLHEjaeI3kve/J4gPgRxG9e8U0VfoufJHhz0YKSr1nY8xRI180EM
         IfxooCnGtOFess774RKFuLz9g/go8GY+gcyZ4N40wWVzT7//u5ewwvOturIZoAfnUDTC
         lR6FBvLXGBP31ZvTs7p6b0q9i51BVRCHRX0Pe9gVEku3haHUe7Q3zBrN4Mcs3/qqnuNl
         WARQ==
X-Forwarded-Encrypted: i=1; AJvYcCUudaBIWmY7nnPevjDK3HWZhBByCCAR28EILSfjZRZNEweI78Xtl145F0qIhO6vGc1LoQzA7A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxfy0DFIAEnrTCiE7Xs/oBrQL1ERrRCqp+QKlcRitP7+YmP2LhG
	3OG1jQmnWeuD1X7u11smTJrjKz/lbNybl5YctikV+v7c0PXggPx79LZZ+PHyDTqifeo593jp5Z2
	t6E8eeNcC80TELvQCyPhCmEl+fJ8hx6xW3IkiqUSKzEc0lFGQw/Yaxt8UdA==
X-Gm-Gg: ASbGnctENQcc2+Tx1lVOrL+PNGs0abhSWNyae1EuaLFawv/x44rpJVN3jGvHsf0FEc1
	gksMQ9/fGsaFUNw76VxeaG0W05SoxSxKgFOXnwC4nuiKZdB3x4W410n3cpfW4UT8SLr/0SWXb8k
	W3fHAuzar9y83+syyo77moirb1G+obMqOYdPYwtzW5lCbs3/d7Y+t5gFHokwtaF3L16nMPXWdn2
	Zl7/w3sHSGeYvzbiNJ1wW0JSQSDmACvLpAfMHo0rXfxaZv0Jt4wKgzdBlgTjZHxU77RbXlssOP+
	ORw5pzbKmABCMe5hdThUA4Z55FBevt/zgKNbNoRZJdIK5OI76JprCFAXA3AIqyM3bH6/Zhk5lZA
	dcHasfl94+iYB99PXemkyZWMDAaACI/+3Q1/DYc9SXXBFIxvoPvkyIytW
X-Received: by 2002:a05:622a:7908:b0:4ed:e284:4a18 with SMTP id d75a77b69052e-4ede2845978mr28815781cf.9.1763026978818;
        Thu, 13 Nov 2025 01:42:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvKWw3IiL7wkrQy/+jmFVdR2o6TRc+eiHUU5enpTNDh4j+/qHBb66cMr9ZJ4pw+AV310uIfA==
X-Received: by 2002:a05:622a:7908:b0:4ed:e284:4a18 with SMTP id d75a77b69052e-4ede2845978mr28815661cf.9.1763026978200;
        Thu, 13 Nov 2025 01:42:58 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fdac667sm124168766b.58.2025.11.13.01.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 01:42:57 -0800 (PST)
Message-ID: <fee56a54-5da0-47a4-b8e3-7ec01e2a1559@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 10:42:53 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/21] drm/msm/a6xx: Share dependency vote table with
 GMU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-12-bef18acd5e94@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-12-bef18acd5e94@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XrX3+FF9 c=1 sm=1 tr=0 ts=6915aadb cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=DqcpYa4PS6cT72Y9dlEA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: aLcEo_BxPQGJ95DsLDeo2rZV0aG8ZojH
X-Proofpoint-GUID: aLcEo_BxPQGJ95DsLDeo2rZV0aG8ZojH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA3MiBTYWx0ZWRfX/lU/ejrvZExQ
 64XZ1PvBHAfqSogkDjD8GAVSxuvw+dypSE+VgiBwRFqqssRD2QXoCqzv8Ojw0BsodTE7k4LD78c
 dC5FoJGqTlfUurAlg9amN+iIuWUor/O6jUJVmy6BuOhbRv3/4DOozaAD3yeaRp2Ibnc8Ql/kljw
 qt3dOfn2/ML4pD4ydjPP4r4Dr19Ee+EWAH0uUbqFuxktt6t4xfeSH01oUimVWHDs3/zX9/oULAg
 6M7Wdg3hDt42jO1iqC+7Yhlop0xrDmIx+WM4iq7EwX5RcvE1nOtFXjbqi1FayIEF0DcSz8Rx6yE
 JrjZ/GgGnlr+biYfZX7vGqu+CQpNcMp13FS5qw3GAbezed+b1MHp1rhf9qJa34+AF3fr1TzWsF7
 XIXPxge0dxErmz8wi1cEVznGkZnPcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130072

On 11/10/25 5:37 PM, Akhil P Oommen wrote:
> A8x GMU firmwares expect a separate vote table which describes the
> relationship between the Gx rail and MxA rail (and possibly Cx rail).
> Create this new vote table and implement the new HFI message which
> allows passing vote tables to send this data to GMU.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 54 +++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 53 ++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.h | 17 +++++++++++
>  4 files changed, 125 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 8597d7adf2f7..396da035cbe8 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -1591,6 +1591,57 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
>  	return 0;
>  }
>  
> +static int a6xx_gmu_rpmh_dep_votes_init(struct device *dev, u32 *votes,
> +		unsigned long *freqs, int freqs_count)

Checkpatch should be grumpy about indentation here

[...]

> +	/* Construct a vote for rest of the corners */
> +	for (int i = 1; i < freqs_count; i++) {
> +		u8 j, index = 0;
> +		unsigned int level = a6xx_gmu_get_arc_level(dev, freqs[i]);

nit: reverse-Christmas-tree would be nice here

> +
> +		/* Get the primary index that matches the arc level */
> +		for (j = 0; j < count; j++) {
> +			if (mx[j] >= level) {
> +				index = j;
> +				break;
> +			}
> +		}
> +
> +		if (j == count) {
> +			DRM_DEV_ERROR(dev,
> +				      "Mx Level %u not found in the RPMh list\n",
> +				      level);
> +			DRM_DEV_ERROR(dev, "Available levels:\n");
> +			for (j = 0; j < count; j++)
> +				DRM_DEV_ERROR(dev, "  %u\n", mx[j]);
> +
> +			return -EINVAL;
> +		}
> +
> +		/* Construct the vote */
> +		votes[i] = (0x3fff << 14) | (index << 8) | (0xff);

FIELD_PREP() + GENMASK, please

[...]

> +static int a8xx_hfi_send_perf_table(struct a6xx_gmu *gmu)
> +{
> +	unsigned int num_gx_votes = 3, num_cx_votes = 2;
> +	struct a6xx_hfi_table_entry *entry;
> +	struct a6xx_hfi_table *tbl;
> +	int ret, i;
> +	u32 size;
> +
> +	size = sizeof(*tbl) +  (2 * sizeof(tbl->entry[0])) +
> +		(gmu->nr_gpu_freqs * num_gx_votes * sizeof(gmu->gx_arc_votes[0])) +
> +		(gmu->nr_gmu_freqs * num_cx_votes * sizeof(gmu->cx_arc_votes[0]));
> +	tbl = devm_kzalloc(gmu->dev, size, GFP_KERNEL);

devm_ only adds overhead here, there's not even an error-return path,
go with regular kzalloc/kfree

> +	tbl->type = HFI_TABLE_GPU_PERF;
> +
> +	/* First fill GX votes */
> +	entry = &tbl->entry[0];
> +	entry->count = gmu->nr_gpu_freqs;
> +	entry->stride = num_gx_votes;
> +
> +	for (i = 0; i < gmu->nr_gpu_freqs; i++) {
> +		unsigned int base = i * entry->stride;
> +
> +		entry->data[base+0] = gmu->gx_arc_votes[i];
> +		entry->data[base+1] = gmu->dep_arc_votes[i];
> +		entry->data[base+2] = gmu->gpu_freqs[i] / 1000;

This is essentially struct perf_gx_level with the ACD field recycled

> +	}
> +
> +	/* Then fill CX votes */
> +	entry = (struct a6xx_hfi_table_entry *)
> +		&tbl->entry[0].data[gmu->nr_gpu_freqs * num_gx_votes];
> +
> +	entry->count = gmu->nr_gmu_freqs;
> +	entry->stride = num_cx_votes;
> +
> +	for (i = 0; i < gmu->nr_gmu_freqs; i++) {
> +		unsigned int base = i * entry->stride;
> +
> +		entry->data[base] = gmu->cx_arc_votes[i];
> +		entry->data[base+1] = gmu->gmu_freqs[i] / 1000;

And this is struct perf_level

[...]

> +#define HFI_H2F_MSG_TABLE 15
> +
> +struct a6xx_hfi_table_entry {
> +	u32 count;
> +	u32 stride;
> +	u32 data[];
> +};
> +
> +struct a6xx_hfi_table {
> +	u32 header;
> +	u32 version;
> +#define HFI_TABLE_BW_VOTE 0
> +#define HFI_TABLE_GPU_PERF 1

Such defines usually go below the field definition, not above

Konrad
> +	u32 type;
> +	struct a6xx_hfi_table_entry entry[];
> +};
> +
>  #define HFI_H2F_MSG_GX_BW_PERF_VOTE 30
>  
>  struct a6xx_hfi_gx_bw_perf_vote_cmd {
> 
