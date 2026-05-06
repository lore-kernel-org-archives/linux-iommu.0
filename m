Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF4D48034A
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078925; cv=none; b=ZTuakM1bNwpnyL1UrvU77bq5f8Ve0q947scLDuKX3q1c2BVBs2BJpWEl0bbdpE6dwN4tnxIiNiByNNTkGvKf7Jsg7h+KLtZLfin9n58j7oTY5Cntybk0s384bQ3D950oYYEpfO+KuA1/dp4n9Os7JeRNLmlYAYV2CEwc0XTbEME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078925; c=relaxed/simple;
	bh=tjshc45sU4NDeKpBxwXJx7JcPp9DPCMPsWPxeYE+In0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kaRQUMMTFITcFX1h4Db/P7MESriW2J4KXoaBpQUFUbHzQw+bOg0I/GG1gcQkzn/L1CYHYPPVcSxJXQAW8wxz0AwW5czUHQ40Fl+NBom3d7cas961QGYNNW4L2pMKl3WEnpoYEM6+2qocL6fQRkF+kDDak/ml+xsiuXvO0hPP1hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ceomNAkv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fZNYElC0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ceomNAkv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fZNYElC0"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6468Zrr2442581
	for <iommu@lists.linux.dev>; Wed, 6 May 2026 14:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gBXTd60yitJVrz4Yyr33f4/s9WV5E4ilRPkk/RHgt1k=; b=ceomNAkvrfwJ+ir1
	F3t2WczOY3Rb0C5KI2HbPVv0ycR4hZyz1jM7+bywELz3ibvKHaoGxp2esjSKbzVp
	fpiMbdggtGspYTMq9CFN5sThX2ddGnHq0UYoNOWF3Qlu7wlmgGMF19MuDLXYJQfP
	Ux9NbtSHh/Xcel0jr6eGZpWZQxnrvgwCtrBn3lfWSRol95mhCLmKKQ6beRQL6HfE
	kRp7aajwX3aa8rYQY485Mcm/DCWL/+TVaaKFxfVpgNhY8pfeZTUkB67JGPdr+Br9
	XlJ81LF8b6j8kpAEIVteNDK1qIupbz6lezRLZNkjWx/60gIABoqpYZyo1cqaBwtX
	9+5lqg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0299hbhb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 06 May 2026 14:48:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36512f223d8so8447496a91.3
        for <iommu@lists.linux.dev>; Wed, 06 May 2026 07:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778078913; x=1778683713; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBXTd60yitJVrz4Yyr33f4/s9WV5E4ilRPkk/RHgt1k=;
        b=fZNYElC0Bopx0Lm/m/JaibxC7jFSEfgWGBXNIFK5Yp9QXiWfSGjKpB+PXAYs9P67up
         D4AqHfa+FOQrtGxT6l2ojuk3+SZVzCV71xZhkZBKCmWlWUF9OopP7JDD5HPeRLxgqCWn
         +Uwdd1Le4uE6u7HSUTtEKHN8zycCs+iTLGS6DzLR2iSdx4gIuLpIqG3+9b5vzPzsM6CI
         pzmUwCrtpBOAndAC4vEtDW0fg3zhAfBpQIWrz2DCUAnN+P/9WVv4bm7vah7vQIMq0xv/
         27WCkoMVMUpD4nAASc7UF1MWi0Q3Dukyd5miIExquQm0nvjvAhACkAFhmQu9Ba7cCuL/
         Gr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778078913; x=1778683713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gBXTd60yitJVrz4Yyr33f4/s9WV5E4ilRPkk/RHgt1k=;
        b=WQKeqxnc82MMKfzs47HgO+SiKPVD0F1UX0cPJK9AoyE0qRXu2h6VjUIwdQ+OBGHXLG
         vTaklaECi6St/pwd1TZp7svT6x+TiNo51GDZW37rcqR1e9s1CJK/r0aorDm317rFa/6k
         yckZZmNke2A5Y6kzYEgp1ym9GIv1rWdmzHOksE/a5jfoiafoEjPzgi0JmrPpEHwoh/wY
         GUxcaLZ1rrTKK676WrJlJgPBpK/LFiu4Xrf2a+4Lurtaa4rBuo2yemNrZjbpQk0svybQ
         bWZkAJ35Cv2rvEZlU9Jtp2oBIL9+222QuWThSx401pF8htSCKhJKIYria5I4NTSev5Uz
         wPlw==
X-Forwarded-Encrypted: i=1; AFNElJ8c2qYKTrfrG3yIc4E8Hz5VjaxlnYHgH2YfQ6/+4Gwgaafxf0MngrxZ79svAMaCJc/3vp1X6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YztLqVjvSP6z0MPamMyHJbBS+Y2ahy0B91N8Jb9hWr/i0SMMDEI
	xbO5yPTwGVAriSRD6LnaiU6egTaHiwyuze2gQbR+FYkDmV2P/H6ik7XWS0fkOi8pOydiJAw5nr/
	+Kw5GiwtqDJg1eHpgQQplasjkRUHCYvbUYTg/yNH18dnO8WZyUd5vrJLG2w==
X-Gm-Gg: AeBDietV1ZRSQ78yAuHM9DapNTONUrFrxCXbtGvkmmLVP34fxtHiRERcXQaS0La3a/7
	boMvGo2aZFGe2QpWdspQK5xOC/iXhcMAg6t9mJwEsynbS+fim4b9a9WO+9oIL6ZC8gxah6ezC0r
	07Y6CnN/YqmDaeVO5xAZlE0wABwryNtwNhYzPRDhSRrWouqlib/t5BYM0PFD2CgdaRWwpwuITkS
	3FjV+aMvv87PYAvMHZT3pqXhjzx2veu8gd3O1ptrgBSPSRYt/BGfB62i9rdqPcNi2Y3IKSGTQtK
	egDskEJZkP8IbyrRBVLsm8B23YK49zOD5Mh+rGdUY3QDXvwyQdOE1WHm1FVwXx1SUQgRQYOYXmh
	tENGIrazqHV/ijXYMI+09Ya1XP/30K1pUsodU89/jiUvqTJj+VEemkQnM/hqjv1Hn
X-Received: by 2002:a17:90b:254d:b0:35e:57cf:c0ae with SMTP id 98e67ed59e1d1-365ab9c8160mr4155559a91.7.1778078912560;
        Wed, 06 May 2026 07:48:32 -0700 (PDT)
X-Received: by 2002:a17:90b:254d:b0:35e:57cf:c0ae with SMTP id 98e67ed59e1d1-365ab9c8160mr4155514a91.7.1778078911952;
        Wed, 06 May 2026 07:48:31 -0700 (PDT)
Received: from [10.204.101.47] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4c28b1asm2713330a91.8.2026.05.06.07.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 07:48:31 -0700 (PDT)
Message-ID: <351f5afc-784d-4c1a-a386-199bd528723a@oss.qualcomm.com>
Date: Wed, 6 May 2026 20:18:23 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/13] media: iris: Use power domain type to look up
 pd_devs index
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
 <20260505-glymur-v4-9-17571dbd1caa@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260505-glymur-v4-9-17571dbd1caa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fMMJG5ae c=1 sm=1 tr=0 ts=69fb54c1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ZJZrQh8Pd_IjRIY_cScA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: KvCKzXRmM77G-aegR1DxC2CG9e_qnp96
X-Proofpoint-GUID: KvCKzXRmM77G-aegR1DxC2CG9e_qnp96
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE0NSBTYWx0ZWRfX6s9gVG3Vo1wv
 lHC2FL+9q72DdZtZPHEH0J9zddAmH/yOiJS2oyD0e+lb3IkMo5XAiLTa6Ad6OJeYQDZa5Szg3hS
 Q5NZCHSQ1nxtQaEO5NeMXOMjZafpSNg8TBtBaik8sqP+G6J7xUppgJhewmTYMAimJtXOxZKzmMp
 mLkeICN1ZaCgRUjGVGsa/eVfGKT1VN3jdYnrFgjEr3vlR9kvvAhtO7wUrYrQHx96jPvRwXU+Uu5
 qnvClPXf7392ZiPvZMOKYYy+gEg/XzmrLjr/rC5g8FLD439+p3yFKIrH7A1R3bGXiNnIF5jlydz
 0xa99+sVWIVrGgvKEYzarInMH27elK9frlxfMAveK0VPKSQVTl2uGAZh3bsv792EySWAPxG0LW5
 71FUrZS1CKKcDOVcD+xpfmEIL9eru39FXSBAO9XdT2FqN/qvIfdlIpZtTOB86nzDJlAtxlKnEyv
 sehsVuCOTGSdkZgKTlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060145



On 5/5/2026 12:29 PM, Vishnu Reddy wrote:
> The pmdomain_tbl was a array of strings holding only the power domain
> names. Callers had to pass a pd_devs[] pointer indexed directly by the
> platform_pm_domain_type enum value to iris_enable_power_domains() and
> iris_disable_power_domains().
> 
> A future platform may need to introduce a new enum value that aliases
> an existing one (e.g. IRIS_VCODEC1_POWER_DOMAIN aliasing the
> IRIS_VPP0_HW_POWER_DOMAIN on Glymur), which would break the assumption
> that enum values map 1:1 to pd_devs[] indices.
> 
> To fix this, replace the string array with a new struct platform_pd_data
> that pairs each power domain name with its platform_pm_domain_type. Add
> a helper iris_get_pd_index_by_type() that walks this table and returns
> the correct pd_devs[] index for a given type.
> 
> Update iris_enable_power_domains() and iris_disable_power_domains()
> to accept a platform_pm_domain_type instead of a struct device pointer.
> They now call the helper internally to resolve the index, removing the
> need for callers to do the index lookup themselves.
> 
> This prepares the driver for adding new platforms where power domain enum
> values cannot be used directly as pd_devs[] indices.
> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>   .../platform/qcom/iris/iris_platform_common.h      |  9 +++-
>   .../media/platform/qcom/iris/iris_platform_gen1.c  | 18 +++++---
>   .../media/platform/qcom/iris/iris_platform_gen2.c  | 24 ++++++----
>   drivers/media/platform/qcom/iris/iris_probe.c      |  4 +-
>   drivers/media/platform/qcom/iris/iris_resources.c  | 44 +++++++++++++++++-
>   drivers/media/platform/qcom/iris/iris_resources.h  |  6 ++-
>   drivers/media/platform/qcom/iris/iris_vpu3x.c      |  7 ++-
>   drivers/media/platform/qcom/iris/iris_vpu4x.c      | 52 ++++++++--------------
>   drivers/media/platform/qcom/iris/iris_vpu_common.c | 23 +++++-----
>   9 files changed, 116 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> index 30e9d4d288c6..7d59e6364e9d 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> @@ -212,6 +212,12 @@ enum platform_pm_domain_type {
>   	IRIS_APV_HW_POWER_DOMAIN,
>   };
>   
> +struct platform_pd_data {
> +	enum platform_pm_domain_type *pd_types;
> +	const char **pd_names;
> +	u32 pd_count;
> +};
> +

<snip>

>   
> -int iris_enable_power_domains(struct iris_core *core, struct device *pd_dev)
> +static int iris_get_pd_index_by_type(struct iris_core *core, enum platform_pm_domain_type pd_type)
>   {
> +	const struct platform_pd_data *pd_tbl;
> +	u32 pd_count, i;
> +
> +	pd_tbl = core->iris_platform_data->pmdomain_tbl;
> +	pd_count = core->iris_platform_data->pmdomain_tbl->pd_count;

pd_count can be dropped, use pd_tbl->pd_count instead.

with that fixed,

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
