Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3503E9589
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776182567; cv=none; b=LjYFUFvI7kYsRgjrrVRr/Fd0GMWDx1LpcztpO+LieAXAUT4sl8uCU0UUwIOQKN82oncTrc0YKHL4iTxM++kPahKPSJGq9UfoxoXrEK1pSD17FqMhGkwyjfeBGnbDaWMYiwGxasNdhNfhP/RiZI5PyZptMggr9obMSjYBawSw4eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776182567; c=relaxed/simple;
	bh=EP8n3YLnADnw2/3kHVDDISUzu1uMqBvZHl417sZONP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwTh/zUPwZqO/aokVmQvptHkvqlcY1I58hzoDY6fcv62lnpOBt6erMwUMmIgXDqg+Rbr62yOK0diFaYRIIcTfTyn95wEzrVbQVkpPa2RBgaMHUPCJGk9l6osOukX1z1dvh+ghwFRKkMsyH6k+jlCa7rzzE3zJg6MIrfZeoOy2qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G0bsYxwn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dMN3JlNR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G0bsYxwn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dMN3JlNR"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EFYN8r3936622
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 16:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oMvbzrILlvyLIiv+/fp3MK3A
	IiOJf+NHiV4k5LZV/is=; b=G0bsYxwnOiOicesphNu2acj7cQ8u86WT/FGi2MMp
	gkrImPnRCwkm1znj4mj1WJZiWpyERXBgRrCSxQIUTxYNfuZCB9wMCMbBnfxOYK1f
	iz5z1f0AMKhmdODrUFzwQ3Yu9opq8YKSJsHSN8u31HBIUtJEpgSks4EVj18eJYYW
	xIBBCSFeFINiCQiZ0Lq6ZAd7889XVjtap/0Cm852Rr07LNy7oNQBY/XFUKDCr4iR
	Lx+4k4g3xuF5fQ76POhTMkOUdtA2XFqMJxooNuKS6QkjKcrkleh4ZzWzG4EiFZ8w
	Na04ynP3NsItWUduU+aVUb223OOvMYRx9+nY75JKoPFKHg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhrbf034r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 16:02:44 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-bce224720d8so3113420a12.1
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 09:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776182563; x=1776787363; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMvbzrILlvyLIiv+/fp3MK3AIiOJf+NHiV4k5LZV/is=;
        b=dMN3JlNRU77YGoRSus13r12bpkjmXTQM5QD+UvwRW++Ak/QRrB9R2YeGsgGaHPf92M
         MMijQ/NFGgnvLCDect9pw7ZArk5S7JU8+OwAR7qI9SGJ5alGVY4H9sjuzmpHHQv9HQEW
         GQjL/1Aok5AtRoqKYN8SbACYYgvEy4e5PGcnFkM9LJHk8e0ZPVmkgp8AtyXgIRF+/Ovu
         DDj94Puo1ui9wcxleBW1ZjyV3D2J8cDetVB1IORNbvv+kW1nOK+cx6ZLj22kLaMvzIh3
         iMWy0XBvgTP/hlIcQAVycVdHkpYEV6ITGSsD3pK/Q6eH3q03v0GFTzgdZ1jlT6BRuCbh
         mFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776182563; x=1776787363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMvbzrILlvyLIiv+/fp3MK3AIiOJf+NHiV4k5LZV/is=;
        b=YWvNVmukgsPcLtNADshEN4ZQ7kJBNC1K1QKIQ/XX5oV4Wf7PWI7D73m/c8zv0COg9F
         hJ2yLw5pTiXqqwjlndlb1JfvQqeD5nEYs6iIl1ViAk2NDuEZx4EH42UlbUNpsi69nNh/
         NKfsyeKrG1JjrryPgO8RlguMOLERmE6xEKquRdBAGj8PelZ+P6iWQ5DSBh2B7xmBJN86
         /IlUHDKcLb+8bbrxphKo5X3AFCzhpCSmKQXLbp7Y0xifr23PQ8A1E4JaDfUeCr2hZnpN
         QVmKsXDFBDdyxZrziLNHo7fiOlxOLFMI7Chr0PCOSn0dRUklbZ7tGeAZslZzlFgf7lo3
         g4gw==
X-Forwarded-Encrypted: i=1; AFNElJ+xM1y/3CeYseyEx2k5ESIk+XcxMVnPG+SUueulDEFbdGx7qhvUM3YtpkWSOwXBDRIP7FmKNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJRlqOj4TOcd7Jg3TQSS6S9Xk1fBBiVJ/NN/iDuscHTHSq/jvs
	WB5LYSDC+SqvG8xktIvasqNpppVxidHQYZQbeBg5a5Vy1Jp7cB11aU5D/WLUYP1QNAXNPjaoOwi
	+EZd4plAOBzDAzXTwpTKMDHWV8RD41WR0oGoBsAmFIa+vY34hLfeio7zAhQ==
X-Gm-Gg: AeBDietTfRUbJ6+FD1+SmmPurefIsdvU+9MJDx2q70j2Ec14iBay32b/WdJmhWgqaW0
	2nyTPeQ/q8ZokrURZ3Qwvbd6lyD9A7cf1TMI8ohruKGkbuNqt3qBR86GklsluojNlN/NNYqgxi1
	B7EuYqehjZ85xMdfbus1LGn9G29XkjoPmIyu3D3zHYMbISuhnyYrF0mZabcfCla6NSnY7fn9W38
	TF8zLz9fCI82wGiVvivVtXuGgEKbip4tP3RIKGRXt9OpdFP1i2dPKufWpiEGQi1bcmkBg3lVsg7
	qXhzip6EQ0uYh8UBET4cbLJdvUNhbbaydXCM1568Owj/tWI260aqqm8mLlhjqvlO0qkejZh0gU+
	ldXh8P5s2NhrNxIIW8CNppXwiK5tCcFBbtVDzycVf2kLB5gRDvTppQg0Tzl8M8J5ipaHYymTi13
	COXB6GNXkT7xIQbTCd6+7YqDohWYqnDHBnS9Rmnyvh2biwrQ==
X-Received: by 2002:a05:6a20:3953:b0:398:7eea:50a0 with SMTP id adf61e73a8af0-39fe3da99c8mr20480561637.18.1776182563261;
        Tue, 14 Apr 2026 09:02:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:3953:b0:398:7eea:50a0 with SMTP id adf61e73a8af0-39fe3da99c8mr20480464637.18.1776182562524;
        Tue, 14 Apr 2026 09:02:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e495b4e73sm30336891fa.41.2026.04.14.09.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:02:41 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:02:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 09/11] media: iris: Add support to select core for dual
 core platforms
Message-ID: <utri77cprqzk5b4pt3qjucugs7vihfb4tn7rcg67nwpajkppqc@cizxr5zs2v66>
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-9-7d3d1cf57b16@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-glymur-v1-9-7d3d1cf57b16@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: jMJh8FkJttRw3Z-mjuP2V_O2BPPA3xaf
X-Authority-Analysis: v=2.4 cv=X8Ji7mTe c=1 sm=1 tr=0 ts=69de6524 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=9YbfNqiAQuj9XNyp570A:9 a=CjuIK1q_8ugA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: jMJh8FkJttRw3Z-mjuP2V_O2BPPA3xaf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE0OSBTYWx0ZWRfX0JFP3jF66bIi
 37QHiVVnfPctESg+fo15qG5WdCU4c0AKdysBLbZ9YVr2PTvETli0DJ7grQt3QGh5oHErw/2iP9I
 obOWaKnyZ2gScX/twCydfWjXH6yxdMje0mPVIrRGt1WLxYydaeYurDa3/z/WbHzAuyDeUZI0L/o
 kEvyXQoYQYoE8fNxxqBArgMWpy/AuEDYrbSnFfndheLNTNnOC36iyAjws0MzdbNfiM+GHxjOWlF
 Vj4okhE72VD3xXE/Cs4hEB7WUbFVvbrOkq64vpLj7Bxj7rVVUwWjl9aEgt2uLaOTNgbIw8svJXt
 tXxGx/UxlkXWqoRksYm2wuCj0JGhJKcUQ8XcGfG3YvOwA4LjbktHIT1KMQgk3g4EF55u1RH4b8m
 927JopaZeKSiVjjAyeKlrCMGqiA3RqKuG7OD8mGEx1QbbIdd3aaiYDQnEtvpSFWbL27jUmAiL+Y
 XHvwhbut1X0DhnRmPDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140149

On Tue, Apr 14, 2026 at 10:30:05AM +0530, Vishnu Reddy wrote:
> Select the hardware core (vcodec) for a session, based on load when the
> platform supports dual vcodec cores. Assign the session to vcodec if its
> MBPF/MBPS capacity allows it, otherwise assign to vcodec1. Communicate
> the selected vcodec core to firmware using new HFI_PROP_CORE_ID property.

Is it possibly do dynamically control power to those codec cores? Is it
possible to shutdown unused vcodec?

> 
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_common.c     |  7 +++
>  drivers/media/platform/qcom/iris/iris_hfi_common.h |  1 +
>  .../platform/qcom/iris/iris_hfi_gen2_command.c     | 19 ++++++
>  .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  1 +
>  drivers/media/platform/qcom/iris/iris_instance.h   |  2 +
>  .../platform/qcom/iris/iris_platform_common.h      |  1 +
>  drivers/media/platform/qcom/iris/iris_utils.c      | 68 +++++++++++++++++-----
>  7 files changed, 83 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_common.c b/drivers/media/platform/qcom/iris/iris_common.c
> index 7f1c7fe144f7..e31d4c988c55 100644
> --- a/drivers/media/platform/qcom/iris/iris_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_common.c
> @@ -49,11 +49,18 @@ void iris_set_ts_metadata(struct iris_inst *inst, struct vb2_v4l2_buffer *vbuf)
>  int iris_process_streamon_input(struct iris_inst *inst)
>  {
>  	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
> +	bool dual_core = inst->core->iris_platform_data->dual_core;

inline

>  	enum iris_inst_sub_state set_sub_state = 0;
>  	int ret;
>  
>  	iris_scale_power(inst);
>  
> +	if (dual_core) {
> +		ret = hfi_ops->session_set_core_id(inst, inst->core_id);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = hfi_ops->session_start(inst, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_common.h b/drivers/media/platform/qcom/iris/iris_hfi_common.h
> index 3edb5ae582b4..fbaf852a6b99 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_common.h
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_common.h
> @@ -124,6 +124,7 @@ struct iris_hfi_command_ops {
>  	int (*session_drain)(struct iris_inst *inst, u32 plane);
>  	int (*session_resume_drain)(struct iris_inst *inst, u32 plane);
>  	int (*session_close)(struct iris_inst *inst);
> +	int (*session_set_core_id)(struct iris_inst *inst, u32 core_id);
>  };
>  
>  struct iris_hfi_response_ops {
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> index 30bfd90d423b..9d9fae587297 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> @@ -1300,6 +1300,24 @@ static int iris_hfi_gen2_session_release_buffer(struct iris_inst *inst, struct i
>  					inst_hfi_gen2->packet->size);
>  }
>  
> +static int iris_hfi_gen2_set_core_id(struct iris_inst *inst, u32 core_id)
> +{
> +	struct iris_inst_hfi_gen2 *inst_hfi_gen2 = to_iris_inst_hfi_gen2(inst);
> +	u32 payload = core_id;
> +
> +	iris_hfi_gen2_packet_session_command(inst,
> +					     HFI_PROP_CORE_ID,
> +					     HFI_HOST_FLAGS_NONE,
> +					     HFI_PORT_NONE,
> +					     inst->session_id,
> +					     HFI_PAYLOAD_U32,
> +					     &payload,
> +					     sizeof(u32));
> +
> +	return iris_hfi_queue_cmd_write(inst->core, inst_hfi_gen2->packet,
> +					inst_hfi_gen2->packet->size);
> +}
> +
>  static const struct iris_hfi_command_ops iris_hfi_gen2_command_ops = {
>  	.sys_init = iris_hfi_gen2_sys_init,
>  	.sys_image_version = iris_hfi_gen2_sys_image_version,
> @@ -1317,6 +1335,7 @@ static const struct iris_hfi_command_ops iris_hfi_gen2_command_ops = {
>  	.session_drain = iris_hfi_gen2_session_drain,
>  	.session_resume_drain = iris_hfi_gen2_session_resume_drain,
>  	.session_close = iris_hfi_gen2_session_close,
> +	.session_set_core_id = iris_hfi_gen2_set_core_id,
>  };
>  
>  void iris_hfi_gen2_command_ops_init(struct iris_core *core)
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> index cecf771c55dd..1926a5344427 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> @@ -56,6 +56,7 @@
>  #define HFI_PROP_BUFFER_HOST_MAX_COUNT		0x03000123
>  #define HFI_PROP_BUFFER_FW_MIN_OUTPUT_COUNT	0x03000124
>  #define HFI_PROP_PIC_ORDER_CNT_TYPE		0x03000128
> +#define HFI_PROP_CORE_ID			0x030001A9

lowercase hex

>  
>  enum hfi_rate_control {
>  	HFI_RC_VBR_CFR		= 0x00000000,
> diff --git a/drivers/media/platform/qcom/iris/iris_instance.h b/drivers/media/platform/qcom/iris/iris_instance.h
> index 16965150f427..dd341ca5be57 100644
> --- a/drivers/media/platform/qcom/iris/iris_instance.h
> +++ b/drivers/media/platform/qcom/iris/iris_instance.h
> @@ -37,6 +37,7 @@ struct iris_fmt {
>   *
>   * @list: used for attach an instance to the core
>   * @core: pointer to core structure
> + * @core_id: specifies the hardware core on which the session runs
>   * @session_id: id of current video session
>   * @ctx_q_lock: lock to serialize queues related ioctls
>   * @lock: lock to seralise forward and reverse threads
> @@ -79,6 +80,7 @@ struct iris_fmt {
>  struct iris_inst {
>  	struct list_head		list;
>  	struct iris_core		*core;
> +	u32				core_id;
>  	u32				session_id;
>  	struct mutex			ctx_q_lock;/* lock to serialize queues related ioctls */
>  	struct mutex			lock; /* lock to serialize forward and reverse threads */
> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> index e3c1aff770dd..aeb70f54be10 100644
> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> @@ -258,6 +258,7 @@ struct iris_platform_data {
>  	const struct tz_cp_config *tz_cp_config_data;
>  	u32 tz_cp_config_data_size;
>  	u32 core_arch;
> +	bool dual_core;
>  	u32 hw_response_timeout;
>  	struct ubwc_config_data *ubwc_config;
>  	u32 num_vpp_pipe;
> diff --git a/drivers/media/platform/qcom/iris/iris_utils.c b/drivers/media/platform/qcom/iris/iris_utils.c
> index cfc5b576ec56..38ede9f76d0b 100644
> --- a/drivers/media/platform/qcom/iris/iris_utils.c
> +++ b/drivers/media/platform/qcom/iris/iris_utils.c
> @@ -90,18 +90,51 @@ struct iris_inst *iris_get_instance(struct iris_core *core, u32 session_id)
>  	return NULL;
>  }
>  
> -int iris_check_core_mbpf(struct iris_inst *inst)
> +static u32 iris_get_mbps(struct iris_inst *inst)
>  {
> -	struct iris_core *core = inst->core;
> -	struct iris_inst *instance;
> -	u32 total_mbpf = 0;
> +	u32 fps = max(inst->frame_rate, inst->operating_rate);
> +
> +	return iris_get_mbpf(inst) * fps;
> +}
> +
> +static void iris_get_core_load(struct iris_core *core, u32 *core_load, bool mbpf)
> +{
> +	bool dual_core = core->iris_platform_data->dual_core;
> +	struct iris_inst *inst;
> +	u32 load;
>  
>  	mutex_lock(&core->lock);
> -	list_for_each_entry(instance, &core->instances, list)
> -		total_mbpf += iris_get_mbpf(instance);
> +	list_for_each_entry(inst, &core->instances, list) {
> +		if (mbpf)
> +			load = iris_get_mbpf(inst);
> +		else
> +			load = iris_get_mbps(inst);
> +
> +		if (inst->core_id == BIT(0))
> +			core_load[0] += load;
> +		else if (dual_core && inst->core_id == BIT(1))
> +			core_load[1] += load;
> +	}
>  	mutex_unlock(&core->lock);
> +}
>  
> -	if (total_mbpf > core->iris_platform_data->max_core_mbpf)
> +int iris_check_core_mbpf(struct iris_inst *inst)
> +{
> +	struct iris_core *core = inst->core;
> +	u32 max_core_mbpf = core->iris_platform_data->max_core_mbpf;
> +	bool dual_core = core->iris_platform_data->dual_core;
> +	u32 core_mbpf[2] = {0, 0}, new_mbpf;
> +
> +	inst->core_id = 0;
> +	iris_get_core_load(core, core_mbpf, true);
> +	new_mbpf = iris_get_mbpf(inst);
> +
> +	if (core_mbpf[0] + new_mbpf <= max_core_mbpf)
> +		inst->core_id = BIT(0);
> +	else if (dual_core && core_mbpf[1] + new_mbpf <= max_core_mbpf)
> +		inst->core_id = BIT(1);
> +
> +	if (!inst->core_id)
>  		return -ENOMEM;
>  
>  	return 0;
> @@ -110,17 +143,20 @@ int iris_check_core_mbpf(struct iris_inst *inst)
>  int iris_check_core_mbps(struct iris_inst *inst)
>  {
>  	struct iris_core *core = inst->core;
> -	struct iris_inst *instance;
> -	u32 total_mbps = 0, fps = 0;
> +	u32 max_core_mbps = core->iris_platform_data->max_core_mbps;
> +	bool dual_core = core->iris_platform_data->dual_core;
> +	u32 core_mbps[2] = {0, 0}, new_mbps;
>  
> -	mutex_lock(&core->lock);
> -	list_for_each_entry(instance, &core->instances, list) {
> -		fps = max(instance->frame_rate, instance->operating_rate);
> -		total_mbps += iris_get_mbpf(instance) * fps;
> -	}
> -	mutex_unlock(&core->lock);
> +	inst->core_id = 0;
> +	iris_get_core_load(core, core_mbps, false);
> +	new_mbps = iris_get_mbps(inst);
> +
> +	if (core_mbps[0] + new_mbps <= max_core_mbps)
> +		inst->core_id = BIT(0);
> +	else if (dual_core && core_mbps[1] + new_mbps <= max_core_mbps)
> +		inst->core_id = BIT(1);

else return -ENOMEM.

But... Which of the checks will be used in the wild? Will it be
iris_check_core_mbpf() or iris_check_core_mbps()? What if they disagree?

>  
> -	if (total_mbps > core->iris_platform_data->max_core_mbps)
> +	if (!inst->core_id)
>  		return -ENOMEM;
>  
>  	return 0;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
