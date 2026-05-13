Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE373385D89
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778705479; cv=none; b=tEIY3tsfS6ae1ThVX2nYmAkA3T+fBVSjLH40fHJB4fBjUC6GoICrfncU2yDLFtlMNYfvH/0RFiZgC+sMDYQsODFa0tbVkceT8h4IeMwIHKsMwg4/VetWoxJLZj7WVpIZojPrHPKUIgzufz8Qzxx0dfRZoNGJBOSJwiibiL04AH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778705479; c=relaxed/simple;
	bh=qgUL5l6LG1LjiT4uTB/UJEu7KgRc4b/z/fRgvu4/+Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiC0RnVit3SMY39wpf9qzuKcdQa97NACGem36utElYyZtJV3oOKzVXClhWHX/aLKlS83Nq9FzwhYvpnv+teWMTidKW8L0LtcWBF4UPsDrnp2olOsrFaVfiYl4YUMpJbyItyFaZhksDwGpYsOawN7olZnfnQ7aHu9Lz+0m8CpbTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XtQ5O5aK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZQhawIiu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XtQ5O5aK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZQhawIiu"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DIW9AA3324683
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 20:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=thyzqnlnbdIEabdNYQu9CwdI
	JIdicm8i3KSQI23YSBw=; b=XtQ5O5aKZ3S41t6CSF5mHkv9inoSALu8xZrWxlji
	MU2TsBhV3z9aMs7+Nby+0QuVvqoCRxHoDfeLotCX6qRbN/YujjkH6auSA61ljWpQ
	+qnxhXV0QLBWI7+xtC0roKNESgVrJVuouNM3d02w5yaJHzlu1ZwujPc5z7/mdA1g
	5//opoDs5yL5L3/2J6vDBmVA5Sr2tnkcQKZ3ESouF+DG9iL62hz3GYjIPznN+aoB
	WnzieKvJ3vaUDAvjZkGxkP85T+lINeB6C3WfxnYteQkuv+hnByZT17LRmJc8UTvF
	DvPFpf/4b7ycUviBGu7Kwt0VW7U7dk73/NSRztOWsPM7kQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4kvdbftf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 20:51:16 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d890580e1so122561911cf.3
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 13:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778705476; x=1779310276; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=thyzqnlnbdIEabdNYQu9CwdIJIdicm8i3KSQI23YSBw=;
        b=ZQhawIiu6BEF+hKyD8rHE2uWtw8ITB/hEpCKsiI8mr6HUhTuBbf6dpeo8QkFNOCLUG
         FGDDz1yS7ffNCXk4MfnCiKBSfmp8bpFD7OXxiaLzg8lYJc3fqg7BK6NYi5Vi8PBtV2gE
         xe7isSZEt/oiMmFSVvio8ab+9Pwe1Dl+DIkYouRIIfvA1naCr02CfO7iJIZePD3J2GSf
         jRXfeGelzZk6JPB8lCYp3T2/YMe4XajTp5PZ96fljcZ3QNdZQRjevNeo777kdHuut0PU
         WTa613EBcJu/hu2ocKI3asPO6Hy2TeejwYnnvRmcW92x5Y9yQXfV9QArhKI6SgIu93P/
         44SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778705476; x=1779310276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thyzqnlnbdIEabdNYQu9CwdIJIdicm8i3KSQI23YSBw=;
        b=idCUWHL0C4/YOE9/DkFEb14z1GN1cKOE8CIg47Cs4+83JTHGjkWn5aIzo0BWuEy1us
         haFo6/3FD/CnfyWPOWy7f1WsVSnf08ZXqIIxh8MXt65eEMT3YgSc7ivUnbJn/cOAARmv
         k86ltEcDCy+b+PA33cETjBtaLRzCAOQ9JWNJbQ9HnB3U5oWFiNcPrIFRaGQ6Mk6/iPO3
         0MQLibrHQ0p4kGq+l4v62LmhRwOj6mu3zCk72B5pvHhExfFPBjeF11EeigsJ9INbvfnV
         On4NkIN7Lq92J8Pz+NvrZl+WDyTPmMqN88dRSRZAwdE54kr0mqogIGssyf7N7Rt4wx8t
         0zdQ==
X-Forwarded-Encrypted: i=1; AFNElJ89Ki+vE549UYHzUSJj6jP/g5Yltn3WQB40Ljn89Pv6BaNALkdwOi9irfsYJpYrSRioENJp1g==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywq/D0mVEDyNp7PwlQyPbS1ea48AM3bZgZ4Stqc5WJgo9YGrDrh
	gQ9Y3nqIPX5As7Aw2eOqG6dIMU2iTYEWzDrrB9z4mFEFdtSPfin9B30Fy76AtNd0dIHhxxx0+lq
	Y6pnyjrDU5yT3IsGTMiggzEonrwmVy4MqObRZrSjo9uYB47TwOPL72IGIBg==
X-Gm-Gg: Acq92OFBstwFm3LBkYYyKievyWFMbzif6Y2H6bGCyfFNL9mR6MdnKh2M2s1sqEngpO8
	ceYhFGJ+fRO6poHnVM1VRPMzdvnDScbab0H+KtPT2x5wjBQxgqlyzqkUa41d7rUH4DwYIFhso6L
	9MYRViSq+f1mzyhV3wO8naXqKR71bVKOuFLGeOaPfvNmbVUq7vD8HwwW8wmXxoem1rJlcQDvH1g
	iHwBxsMCFV4mLGIHBe7HZpDWLbLMCl5C7cqJOyNscE5hhIyqO/NqRErwCU+G7N7vHCGhbpExVJN
	ye/fg2a4aeD8wst3vxHPkZ3HYgGc//EF+4vQBTP4FKq7DWl2O+L/2rRzBRBQcO8vIbomDfWFU1k
	Mcpa8BqnclSCow0aYicyE1fuwMIuPu8pzSnRqqGbACbqYKMnS9Oz4PBC/kfD6Kv+XoOj1DkgI/t
	k4a6xdXhVjbQHPjhPAMghG96uEouN4imGPFXw=
X-Received: by 2002:a05:622a:2c2:b0:50f:be4f:465d with SMTP id d75a77b69052e-5162f5c9a7dmr65137591cf.46.1778705475961;
        Wed, 13 May 2026 13:51:15 -0700 (PDT)
X-Received: by 2002:a05:622a:2c2:b0:50f:be4f:465d with SMTP id d75a77b69052e-5162f5c9a7dmr65137131cf.46.1778705475399;
        Wed, 13 May 2026 13:51:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3945cb4d24bsm1075671fa.39.2026.05.13.13.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 13:51:14 -0700 (PDT)
Date: Wed, 13 May 2026 23:51:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 11/14] media: iris: Add support to select core for
 dual core platforms
Message-ID: <fbbxepjsdmikduj7yu53jc6djiqkcqojcz7sxywqaov6e6evg6@5ezmetiuoqjw>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-11-7fbb340c5dbd@oss.qualcomm.com>
 <qodaq4xoi6whna4phhrfbdfanfm43y7vmg4qxjuke5m3qgxozn@h2ot2a7w36xh>
 <a9658e1e-70ed-0c30-28d9-28966242a4eb@oss.qualcomm.com>
 <uujvaqpr72vmdl7w6kjh4xggci4pnhfwukatdj2x63hewfhawa@muzebwimx4oi>
 <fa2eb472-92f9-9bf0-be62-93a88785b405@oss.qualcomm.com>
 <urpdhb6svgprfvo3drmpr5pusy4vjqf3hom3vtvf6kket3fqcw@lrad6xcrbzex>
 <b9d69082-2a76-db71-365f-b8867ba692f5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9d69082-2a76-db71-365f-b8867ba692f5@oss.qualcomm.com>
X-Proofpoint-GUID: oxQJ7_r57o7hgDcTXvbysb428bZq21l5
X-Proofpoint-ORIG-GUID: oxQJ7_r57o7hgDcTXvbysb428bZq21l5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDIwNiBTYWx0ZWRfX/n0edBnrUyMg
 bUTKLzITHffUwB96EGMe6aqYfnuo9FO+dLPBVHJTrjA5pJL+SkD6Z4y7CRxURifqT2N7DlDRM/G
 zwskusR9NFqjEpJ+2wuLEFYDY9DZG88jp4sbin78ZdcuXnM0TCWElG3lEf/CkLgq/aeHOphHv+F
 cfeLoI7YogNsV9az/UkkUyzO3EAtUD1oUP/s4cbxTFwkIJJAG9X7DOv9jeC3H4kU3A5+NI4adDd
 cJtouJevqFGl0+R2oTOKEzeMklQ1gJfvXaIuDubRWiPWauZbeeYFfeUYFD+a2snknznqJT9gLkD
 Wg8/8BaOINg0qWj+F30QTfPvQx3800ChaGxYllnlUQCizjjIrAQFEoiTT/6dl9esVAfbllG0GZo
 LEoeXXkSB70Gjqbo55+HMQoepvKXqb/QJBxfgnh1c6uK4zaHdCAPzR6suKhs2dWnMMpB7KogWdv
 qJ+IAyFUmmAu7Ol8Xmw==
X-Authority-Analysis: v=2.4 cv=Iu0utr/g c=1 sm=1 tr=0 ts=6a04e444 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=YUjwTH3TWSO4uhTXXAwA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130206

On Thu, May 14, 2026 at 12:53:14AM +0530, Vishnu Reddy wrote:
> 
> On 5/14/2026 12:40 AM, Dmitry Baryshkov wrote:
> > On Thu, May 14, 2026 at 12:25:58AM +0530, Vishnu Reddy wrote:
> >> On 5/13/2026 7:21 PM, Dmitry Baryshkov wrote:
> >>> On Mon, May 11, 2026 at 09:42:43PM +0530, Vishnu Reddy wrote:
> >>>> On 5/9/2026 2:30 AM, Dmitry Baryshkov wrote:
> >>>>> On Sat, May 09, 2026 at 12:30:00AM +0530, Vishnu Reddy wrote:
> >>>>>> On platforms with dual vcodec cores, select the hardware core for a
> >>>>>> session based on current load. Assign the session to vcodec0 if its
> >>>>>> MBPF/MBPS capacity allows it, otherwise assign to vcodec1. Communicate
> >>>>>> the selected core to firmware using the new HFI_PROP_CORE_ID property.
> >>>>>>
> >>>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> >>>>>> ---
> >>>>>>  drivers/media/platform/qcom/iris/iris_common.c     | 10 +++
> >>>>>>  drivers/media/platform/qcom/iris/iris_common.h     |  1 +
> >>>>>>  drivers/media/platform/qcom/iris/iris_core.h       |  5 ++
> >>>>>>  drivers/media/platform/qcom/iris/iris_hfi_common.h |  1 +
> >>>>>>  .../platform/qcom/iris/iris_hfi_gen2_command.c     | 19 ++++++
> >>>>>>  .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  1 +
> >>>>>>  drivers/media/platform/qcom/iris/iris_instance.h   |  2 +
> >>>>>>  .../platform/qcom/iris/iris_platform_common.h      |  1 +
> >>>>>>  drivers/media/platform/qcom/iris/iris_power.c      | 11 ++--
> >>>>>>  drivers/media/platform/qcom/iris/iris_utils.c      | 75 ++++++++++++++++------
> >>>>>>  drivers/media/platform/qcom/iris/iris_vb2.c        |  4 ++
> >>>>>>  drivers/media/platform/qcom/iris/iris_vidc.c       |  6 +-
> >>>>>>  12 files changed, 113 insertions(+), 23 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/media/platform/qcom/iris/iris_common.c b/drivers/media/platform/qcom/iris/iris_common.c
> >>>>>> index 7f1c7fe144f7..3b3fc482e194 100644
> >>>>>> --- a/drivers/media/platform/qcom/iris/iris_common.c
> >>>>>> +++ b/drivers/media/platform/qcom/iris/iris_common.c
> >>>>>> @@ -46,6 +46,16 @@ void iris_set_ts_metadata(struct iris_inst *inst, struct vb2_v4l2_buffer *vbuf)
> >>>>>>  	inst->metadata_idx++;
> >>>>>>  }
> >>>>>>  
> >>>>>> +int iris_set_core_id(struct iris_inst *inst)
> >>>>>> +{
> >>>>>> +	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
> >>>>>> +
> >>>>>> +	if (!inst->core->iris_platform_data->dual_core)
> >>>>>> +		return 0;
> >>>>>> +
> >>>>>> +	return hfi_ops->session_set_core_id(inst, inst->core_id);
> >>>>>> +}
> >>>>>> +
> >>>>>>  int iris_process_streamon_input(struct iris_inst *inst)
> >>>>>>  {
> >>>>>>  	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
> >>>>>> diff --git a/drivers/media/platform/qcom/iris/iris_common.h b/drivers/media/platform/qcom/iris/iris_common.h
> >>>>>> index b2a27b781c9a..34e32c60f768 100644
> >>>>>> --- a/drivers/media/platform/qcom/iris/iris_common.h
> >>>>>> +++ b/drivers/media/platform/qcom/iris/iris_common.h
> >>>>>> @@ -11,6 +11,7 @@ struct iris_buffer;
> >>>>>>  
> >>>>>>  int iris_vb2_buffer_to_driver(struct vb2_buffer *vb2, struct iris_buffer *buf);
> >>>>>>  void iris_set_ts_metadata(struct iris_inst *inst, struct vb2_v4l2_buffer *vbuf);
> >>>>>> +int iris_set_core_id(struct iris_inst *inst);
> >>>>>>  int iris_process_streamon_input(struct iris_inst *inst);
> >>>>>>  int iris_process_streamon_output(struct iris_inst *inst);
> >>>>>>  int iris_session_streamoff(struct iris_inst *inst, u32 plane);
> >>>>>> diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
> >>>>>> index b396c8cf595e..54a8649841e4 100644
> >>>>>> --- a/drivers/media/platform/qcom/iris/iris_core.h
> >>>>>> +++ b/drivers/media/platform/qcom/iris/iris_core.h
> >>>>>> @@ -30,6 +30,11 @@ enum domain_type {
> >>>>>>  	DECODER	= BIT(1),
> >>>>>>  };
> >>>>>>  
> >>>>>> +enum iris_vcodec_core_id {
> >>>>>> +	IRIS_VCODEC0 = 1,
> >>>>>> +	IRIS_VCODEC1,
> >>>>>> +};
> >>>>>> +
> >>>>>>  /**
> >>>>>>   * struct iris_core - holds core parameters valid for all instances
> >>>>>>   *
> >>>>>> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_common.h b/drivers/media/platform/qcom/iris/iris_hfi_common.h
> >>>>>> index 3edb5ae582b4..fbaf852a6b99 100644
> >>>>>> --- a/drivers/media/platform/qcom/iris/iris_hfi_common.h
> >>>>>> +++ b/drivers/media/platform/qcom/iris/iris_hfi_common.h
> >>>>>> @@ -124,6 +124,7 @@ struct iris_hfi_command_ops {
> >>>>>>  	int (*session_drain)(struct iris_inst *inst, u32 plane);
> >>>>>>  	int (*session_resume_drain)(struct iris_inst *inst, u32 plane);
> >>>>>>  	int (*session_close)(struct iris_inst *inst);
> >>>>>> +	int (*session_set_core_id)(struct iris_inst *inst, u32 core_id);
> >>>>>>  };
> >>>>>>  
> >>>>>>  struct iris_hfi_response_ops {
> >>>>>> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> >>>>>> index 30bfd90d423b..9d9fae587297 100644
> >>>>>> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> >>>>>> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
> >>>>>> @@ -1300,6 +1300,24 @@ static int iris_hfi_gen2_session_release_buffer(struct iris_inst *inst, struct i
> >>>>>>  					inst_hfi_gen2->packet->size);
> >>>>>>  }
> >>>>>>  
> >>>>>> +static int iris_hfi_gen2_set_core_id(struct iris_inst *inst, u32 core_id)
> >>>>>> +{
> >>>>>> +	struct iris_inst_hfi_gen2 *inst_hfi_gen2 = to_iris_inst_hfi_gen2(inst);
> >>>>>> +	u32 payload = core_id;
> >>>>>> +
> >>>>>> +	iris_hfi_gen2_packet_session_command(inst,
> >>>>>> +					     HFI_PROP_CORE_ID,
> >>>>>> +					     HFI_HOST_FLAGS_NONE,
> >>>>>> +					     HFI_PORT_NONE,
> >>>>>> +					     inst->session_id,
> >>>>>> +					     HFI_PAYLOAD_U32,
> >>>>>> +					     &payload,
> >>>>>> +					     sizeof(u32));
> >>>>>> +
> >>>>>> +	return iris_hfi_queue_cmd_write(inst->core, inst_hfi_gen2->packet,
> >>>>>> +					inst_hfi_gen2->packet->size);
> >>>>>> +}
> >>>>>> +
> >>>>>>  static const struct iris_hfi_command_ops iris_hfi_gen2_command_ops = {
> >>>>>>  	.sys_init = iris_hfi_gen2_sys_init,
> >>>>>>  	.sys_image_version = iris_hfi_gen2_sys_image_version,
> >>>>>> @@ -1317,6 +1335,7 @@ static const struct iris_hfi_command_ops iris_hfi_gen2_command_ops = {
> >>>>>>  	.session_drain = iris_hfi_gen2_session_drain,
> >>>>>>  	.session_resume_drain = iris_hfi_gen2_session_resume_drain,
> >>>>>>  	.session_close = iris_hfi_gen2_session_close,
> >>>>>> +	.session_set_core_id = iris_hfi_gen2_set_core_id,
> >>>>>>  };
> >>>>>>  
> >>>>>>  void iris_hfi_gen2_command_ops_init(struct iris_core *core)
> >>>>>> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> >>>>>> index cecf771c55dd..600e9dc07669 100644
> >>>>>> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> >>>>>> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
> >>>>>> @@ -56,6 +56,7 @@
> >>>>>>  #define HFI_PROP_BUFFER_HOST_MAX_COUNT		0x03000123
> >>>>>>  #define HFI_PROP_BUFFER_FW_MIN_OUTPUT_COUNT	0x03000124
> >>>>>>  #define HFI_PROP_PIC_ORDER_CNT_TYPE		0x03000128
> >>>>>> +#define HFI_PROP_CORE_ID			0x030001a9
> >>>>>>  
> >>>>>>  enum hfi_rate_control {
> >>>>>>  	HFI_RC_VBR_CFR		= 0x00000000,
> >>>>>> diff --git a/drivers/media/platform/qcom/iris/iris_instance.h b/drivers/media/platform/qcom/iris/iris_instance.h
> >>>>>> index 16965150f427..dd341ca5be57 100644
> >>>>>> --- a/drivers/media/platform/qcom/iris/iris_instance.h
> >>>>>> +++ b/drivers/media/platform/qcom/iris/iris_instance.h
> >>>>>> @@ -37,6 +37,7 @@ struct iris_fmt {
> >>>>>>   *
> >>>>>>   * @list: used for attach an instance to the core
> >>>>>>   * @core: pointer to core structure
> >>>>>> + * @core_id: specifies the hardware core on which the session runs
> >>>>>>   * @session_id: id of current video session
> >>>>>>   * @ctx_q_lock: lock to serialize queues related ioctls
> >>>>>>   * @lock: lock to seralise forward and reverse threads
> >>>>>> @@ -79,6 +80,7 @@ struct iris_fmt {
> >>>>>>  struct iris_inst {
> >>>>>>  	struct list_head		list;
> >>>>>>  	struct iris_core		*core;
> >>>>>> +	u32				core_id;
> >>>>>>  	u32				session_id;
> >>>>>>  	struct mutex			ctx_q_lock;/* lock to serialize queues related ioctls */
> >>>>>>  	struct mutex			lock; /* lock to serialize forward and reverse threads */
> >>>>>> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> >>>>>> index 8995136ad29e..502d7099085c 100644
> >>>>>> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> >>>>>> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> >>>>>> @@ -258,6 +258,7 @@ struct iris_platform_data {
> >>>>>>  	const struct tz_cp_config *tz_cp_config_data;
> >>>>>>  	u32 tz_cp_config_data_size;
> >>>>>>  	u32 core_arch;
> >>>>>> +	bool dual_core;
> >>>>>>  	u32 hw_response_timeout;
> >>>>>>  	struct ubwc_config_data *ubwc_config;
> >>>>>>  	u32 num_vpp_pipe;
> >>>>>> diff --git a/drivers/media/platform/qcom/iris/iris_power.c b/drivers/media/platform/qcom/iris/iris_power.c
> >>>>>> index 91aa21d4070e..b72ce5b596b8 100644
> >>>>>> --- a/drivers/media/platform/qcom/iris/iris_power.c
> >>>>>> +++ b/drivers/media/platform/qcom/iris/iris_power.c
> >>>>>> @@ -77,9 +77,9 @@ static int iris_vote_interconnects(struct iris_inst *inst)
> >>>>>>  
> >>>>>>  static int iris_set_clocks(struct iris_inst *inst)
> >>>>>>  {
> >>>>>> +	u64 vcodec0_freq = 0, vcodec1_freq = 0;
> >>>>>>  	struct iris_core *core = inst->core;
> >>>>>>  	struct iris_inst *instance;
> >>>>>> -	u64 freq = 0;
> >>>>>>  	int ret;
> >>>>>>  
> >>>>>>  	mutex_lock(&core->lock);
> >>>>>> @@ -87,11 +87,14 @@ static int iris_set_clocks(struct iris_inst *inst)
> >>>>>>  		if (!instance->max_input_data_size)
> >>>>>>  			continue;
> >>>>>>  
> >>>>>> -		freq += instance->power.min_freq;
> >>>>>> +		if (instance->core_id == IRIS_VCODEC0)
> >>>>>> +			vcodec0_freq += instance->power.min_freq;
> >>>>>> +		else
> >>>>>> +			vcodec1_freq += instance->power.min_freq;
> >>>>>>  	}
> >>>>>>  
> >>>>>> -	core->power.clk_freq = freq;
> >>>>>> -	ret = iris_opp_set_rate(core->dev, freq);
> >>>>>> +	core->power.clk_freq = max(vcodec0_freq, vcodec1_freq);
> >>>>>> +	ret = iris_opp_set_rate(core->dev, core->power.clk_freq);
> >>>>>>  	mutex_unlock(&core->lock);
> >>>>>>  
> >>>>>>  	return ret;
> >>>>>> diff --git a/drivers/media/platform/qcom/iris/iris_utils.c b/drivers/media/platform/qcom/iris/iris_utils.c
> >>>>>> index cfc5b576ec56..da8a89d3dd41 100644
> >>>>>> --- a/drivers/media/platform/qcom/iris/iris_utils.c
> >>>>>> +++ b/drivers/media/platform/qcom/iris/iris_utils.c
> >>>>>> @@ -90,40 +90,79 @@ struct iris_inst *iris_get_instance(struct iris_core *core, u32 session_id)
> >>>>>>  	return NULL;
> >>>>>>  }
> >>>>>>  
> >>>>>> -int iris_check_core_mbpf(struct iris_inst *inst)
> >>>>>> +static u32 iris_get_mbps(struct iris_inst *inst)
> >>>>>>  {
> >>>>>> -	struct iris_core *core = inst->core;
> >>>>>> +	u32 fps = max(inst->frame_rate, inst->operating_rate);
> >>>>>> +
> >>>>>> +	return iris_get_mbpf(inst) * fps;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int iris_check_and_assign_core(struct iris_inst *inst, bool mbpf)
> >>>>>> +{
> >>>>>> +	const struct iris_platform_data *platform_data = inst->core->iris_platform_data;
> >>>>>> +	u32 max_load = mbpf ? platform_data->max_core_mbpf : platform_data->max_core_mbps;
> >>>>>> +	u32 max_session_cnt = platform_data->max_session_count;
> >>>>>> +	u32 core0_session_cnt = 0, core1_session_cnt = 0;
> >>>>>> +	bool dual_core = platform_data->dual_core;
> >>>>> num_cores
> >>>> A num_cores field would require updating all platform data entries. For two
> >>> I was thinking about adding num_cores to platform_data and to iris_inst
> >>> (or iris_core) and setting it to 1 if the value is unset in
> >>> platform_data.
> >>>
> >>> A better option would be to move all these multi-core functions to a
> >>> separate file.
> >> Thanks for your point, Adding num_cores to platform_data makes sense if the
> >> number of cores grows beyond two. For now, since we only handle single and
> >> dual core, the current logic feels simpler and sufficient to cover both cases.
> >> Happy to adopt the num_cores approach in the future if we have any platform
> >> with more than dual core.
> > Again, an alternative approach is to get all the platform specifics into
> > the corresponding iris_vpuXX.c file.
> 
> Are you suggesting moving this function to the corresponding iris_vpuXX.c file
> and hooking it into the platform-specific ops?

Yes, where that makes sense. If it is the only dual-core platform we
should not introduce code into the generic codepaths...

-- 
With best wishes
Dmitry
