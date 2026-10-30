Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365745;
	b=4O5vT7qZQIjSMdsDV0AlPXQe8qf42VD6351V2tl/m0TnJqLR+EssK+ySjHR5Ha/jjxcU
	 PONrqy7AMQ2RO0RthaFgE6Ngir15Osglfah+DCShXWseNQKeeZmfZrDPbNx6qU0o3JFik
	 lxBP+QNvY4QQlSKH6Mnyp+T+ONRBSYQ6bWgWSncM5T6H4V+dh+m3B0hwvF1iv8W5KJWYI
	 SdYRlu6kVDvS6bMZ9R+WeyaMYMf9+DMMbo2XodnPWHmOk6js4gFZtRHkK60FZzxUbu0Qe
	 8z6JQpojQerqH7UjwPv8v6cRYpqTNcNCLFH7SPd9IvE1+of+YvOIQszHUpk+Nb5rIyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365745;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=y4P301YqaFnb7KKDE2QgQixMk0k7HBc05iLOcpHCCho=;
	b=P/Wb+QLZUleXpShEVlyTXBnf8FwU0SXxEHxwZY6x+mcWXf4+LwdmG7mroC+xYLm01eQm
	 f964uGNsNJLblrINkfffzIPc1pJhpvg+F2h1NwoTqpBii9pxuDHtsCeH58VPUmYjNHCTI
	 J+QQgszGcWjdXztOEAT+anxT28OxFMY3d8OCmwx7uwUvxjAJG5k4h6TFrN+fUYrsNml5i
	 f0t7oImRV1hUBVYkJyg6GpML3ZOICUA40roeccN55+R+5a9XyJotZif5jrwbdmy5nh7o4
	 vMhqMFConVDDJqIKhGam93J08tq0sQK5wUbwDi17MhGk99T6p8JHoUMUnyNyJZSeMZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jofX2PlH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GKqRsnV3;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4452606A31D
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 13:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4452606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jofX2PlH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GKqRsnV3
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBG6Xv2169742
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 13:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y4P301YqaFnb7KKDE2QgQixMk0k7HBc05iLOcpHCCho=; b=jofX2PlH9sK44rY1
	hTJwH/V8S1h2Ehj/NWXUdY64MVX3m+B7He4PrRq6Yb9Iekg2dQxrn0HvtZI28zJ9
	RRcY15pL9JIX/ZRIW1lSCPl2zi8c+svbt1KdqyBn7OuE618BEsyNZA/awYfXJfHZ
	x394lXmUJwAi5oWW7Y3mnrQb4mhpf5ALmAZkfuOBe1PS6soxP30XEchqhEVQXb8S
	6wfxhs5I3ebouclMOJoynZoJ8Lm7FMseFxIg3Aa7qkHnSU7I8HOiGB0jkDZ1sMbu
	mKCDKfioiruMwPg2jwuK8B5KLaUXuIWmy2seuAdgtrA912gg7ClcJYCBdXlsoH4r
	r9G6wA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pb535-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 13:09:03 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9833e1390beso16885241.0
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 06:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793365743; x=1793970543; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y4P301YqaFnb7KKDE2QgQixMk0k7HBc05iLOcpHCCho=;
        b=GKqRsnV32hDUvy+64Si8E6228J3sqJFhQOG7sdLXLsPw8jK3nNZhkt0FkGlSTS1LUw
         Om3SvDXHzGubySeiUU0Q+artgHZxt1j2+Mq1O4ivdrrjPYXmixdTvWOfNb5ND/V7DpH1
         74u068gBK/l9YV+4DlGXcCqYCkSPDLZgE/UsTR/hYzuPQQ0HFmTmDrMs2ryognPB0opo
         2AtAAJPOv+2xzLaO3Za/a0Xea+8NNFJRU2cvrvvUJnVcvEfJtJuGwTAzfJ0RbT00Gp1o
         x5cF97otBKr72OWBr4qKv0N8Hda65nAopXxq26EgxyS7gqJ7EHZYQj4bVGAKdKeW+FYg
         uvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793365743; x=1793970543;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y4P301YqaFnb7KKDE2QgQixMk0k7HBc05iLOcpHCCho=;
        b=kCu72CaUaf1vsU+FkLkC3aVkeNILAZRRjYte1OGfjDb9nZwUTcAoZfSf9ZHECG/sTK
         zk7cJ4R1G4EryP1AQDx4knPBhIuWtbgVV7q5h6fCo+eliX+1U6Z08gzGEgbMYou3Y3Ev
         jlFZRQzf+Snf765lyj32rkmNx/ZrvIeqEOKKhKSp7QN7jNt1sJIMRgkALNb4qPO3Z5L5
         KZSlKfDIoLxtEoaiVGOko1O1XGrBW7pRRdUIGrOBMnqpENyZHM9zVJsv2mrfYE051bD7
         iTHKTteg3ep8fVx3j0mxH3SxNRk+hPOdtXC9bJUSi0g/QAL98a9/P2epQwXwCjl790Oy
         fzIw==
X-Gm-Message-State: AFq9FYJwaiWTQvHdMMIVjrX8ifQZf6IS3o1YzfYtlxMnAZnISuodnK/F
	z7QZE2jBwzpFaXO1Yuz8QmFa3Y5+s8tUOtnswbRQ3jUM3p5BBpWE5pvrPNcJWqOq36pWEADZiAB
	9/k95Zec25MYz6NlcgL6G+Z5Uy+izWhrb8+0eTgMczZ82aShVpFYfyHTI1g==
X-Gm-Gg: AYBFou3ijzo5glQuKBA7tt21uSOeRSoChc+8hKyslVEY88qTRmozuZQfDgzROi25sCp
	csCdu9AtsbIMTPdZbA7w6hupUaONpXad67vPkKWnbBgjVu9b4ZXDirakxgYVaDdL8Hf662Z8d9u
	yscCERbqgdGuCoi4b9V43gUmcJ04a0IYFYixgaIKSAssk6VyRN8n6kCvZNa1pqtea4PKUMPfr9C
	teWyUVs3P3lGAxfWvLvIDME0/E89NspcP4hRupC9T4g6Izr/P99ALkG89mnQbSUnzjyPZg78hZC
	h46lUSwzo3k+4BDeS4OXATe9t8xkaBlS4P3mBXACrkjHrcBdBFGtmyZVmWaeazzhE+XsF012vEo
	zc3l3IOVM2wbQQ4uhz6ZcMiJ8xtsPmm75JqPLyB/DTyAjAKkd/PYFsu/oTJC7N/Rdto3GQjA=
X-Received: by 2002:a05:6102:868f:20b0:7b4:f1cd:80dd with SMTP id ada2fe7eead31-7d0727a54dbmr802586137.1.1793365742037;
        Fri, 30 Oct 2026 06:09:02 -0700 (PDT)
X-Received: by 2002:a05:6102:868f:20b0:7b4:f1cd:80dd with SMTP id ada2fe7eead31-7d0727a54dbmr802519137.1.1793365741491;
        Fri, 30 Oct 2026 06:09:01 -0700 (PDT)
Received: from [10.169.205.110] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4d7b01b5esm605327a12.20.2026.10.30.06.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 06:08:59 -0700 (PDT)
Message-ID: <3f11cf8c-db2a-4243-b1f6-7f2cb9a7a87e@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 14:08:55 +0100
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
Subject: Re: [PATCH RFC v2 05/14] firmware: qcom: scm: Configure LPAC aperture
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
 <20261029-descriptive-name-lpac-upstream-v2-5-a21a5c850961@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-5-a21a5c850961@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MiBTYWx0ZWRfX0da/nWYdkH55
 vF4PPDbkE3q49cfSjCWd7J3hpiI+SiS3BZPtMf3ke9XCiCF8dwHrnpEnH46pb/0VcoQ7NwSS68q
 11dyTxTe+NvR2PYiavh5BaAVMxO9YeNdMxF19TtZoojFs/yIM4el1s85Xk3pYCK0mcgSEqrs7JH
 qBZe5OBvr3Lg9XgPcNPU+dysG9HbHmyoY+LK9sEujr5AJbyP66ronsjyDZSYQTxnND8vl0jT+Eo
 11HYPjZ94CbWoexb729nhxbLWK+LstoZ2oT0Q7VFoQe7ESVNN34Phfl3PTTMZQyAH4vgK16oRR9
 JubXgqv4szZkVAau/RnXC8eDkH2GCCVpql4VgwpPYbta9iZ1LugLZN2RYnKSpKEppjFjoYPcM1c
 HHKwNfLqeChogOatJzHhJRtsR0km/a+6kqbWkzs+NPbIsE4bb3Ac0ZJXK6LcvV9kb5hYPRnWmeE
 LY/tPnEn0iixAIeXbYw==
X-Proofpoint-GUID: tH40A0Yrm4y3oqEUKhOcTVEyqT0vj_1G
X-Authority-Analysis: v=2.4 cv=Lp4HWXdc c=1 sm=1 tr=0 ts=6ae496ef cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=HiRCik2jR1DMqHai1FgA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: tH40A0Yrm4y3oqEUKhOcTVEyqT0vj_1G
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MiBTYWx0ZWRfXwN6nKXdHDw4i
 xQf8gwxZxk//dqG6LouH9eCJsFPoq6I5mwsm3akZZaXw0iZg2BjBZ8Xm58lcKZhxbnA18YLnJwX
 1jk8A/nIkuOA6kAfmkVPZOz9tval5Gs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300052

On 10/29/26 2:52 PM, Anna Maniscalco wrote:
> In order to be able to update the SMMU registers from CP for page table
> updates we need to configure the LPAC aperture to include the context
> bank that will be associated with SID 1.
> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c        | 18 ++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  6 ++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  1 +
>  include/linux/firmware/qcom/qcom_scm.h  |  1 +
>  4 files changed, 26 insertions(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 9b06a69d3a6d..92093399f20d 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1204,6 +1204,7 @@ int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare)
>  EXPORT_SYMBOL_GPL(qcom_scm_restore_sec_cfg);
>  
>  #define QCOM_SCM_CP_APERTURE_CONTEXT_MASK	GENMASK(7, 0)
> +#define QCOM_SCM_LPAC_APERTURE_CONTEXT_MASK	GENMASK(7, 1)
>  
>  bool qcom_scm_set_gpu_smmu_aperture_is_available(void)
>  {
> @@ -1229,6 +1230,23 @@ int qcom_scm_set_gpu_smmu_aperture(unsigned int context_bank)
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_set_gpu_smmu_aperture);
>  
> +int qcom_scm_set_gpu_smmu_lpac_aperture(unsigned int context_bank)
> +{

Please make qcom_scm_set_gpu_smmu_aperture() take a parameter instead
- bit 8=0 is QCOM_SCM_CP_APERTURE_REG, bit 8 =1 is
QCOM_SCM_CP_LPAC_APERTURE_REG

Konrad
