Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F1C3AB5B2
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698574; cv=none; b=MtiNK2vaOs5vvc0zhMUdVi0UUgmi4e8AZwe3BVjKOtxEhsX0bT+g2r6iFObJ/xFS/X7lQ9eKqcHXFkYGSzSMF7AXj3Aw+waJKBZR1CXeVf6oO0CUBUOxWveTRIbTf3awsPFu9A+bvWV4xKTPMih0+A749+52NRKezs5ZfGbx7uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698574; c=relaxed/simple;
	bh=ygAXg0yIaIgGsp62GGnfC5yDl2KNxF7XrFSjT3ekOXQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Do+Wk82js0OYnUnKZqjEPvmtdmL5EeRCdtC7ZV6Uc2RXi2KlGJzDdWvjC5LGi9TQxRoKRS+159TRWbOY7hSq/HovjuSeY/95dMCIV4BNrDx4PYbWrp4oBVgQ1i6GV70k3PQcmmPKoLqnK3Le+AYXhC4T7yVSyTssjPknrCxswFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XNnl75Vq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CxffXDKa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XNnl75Vq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CxffXDKa"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DGArc82524315
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 18:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lMUtsmmXt0qUbaR0tmN+fLAyBCwIAa6nmnyrZoPa5NI=; b=XNnl75VqhH2EXAgX
	cuG+cL6Ril3WR0AaPb+WH4filrKXbkkF/otEdCY5HvqjiZpcZumor1T33pOvFHu5
	/Mi4xxeq03+YR9I1gDxb3u7Tuq7p63lqi0E6s52TkNz9H3/h1Y1zaR1k6rswBUr1
	Kt7KtAqt2tblvq9mbTi6pRCXv8b5AzoTMSq/Q7hGwQTJ3GVnUZraMpEyOERe5+OD
	gqKZsr0uRh1+7h+mVoyfLyCYclu3qHDjnC3H8Q/HV1dlP5Rjb4qHbF1uiQbn3xjF
	wkiz1tLD7h8dNff2tIkC1nwPQXlI9bqIY/zcJ33XdksHJTId8f/lmx5WyX9u2aqm
	9xSbww==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4vkjgq9e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 18:56:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36642d2f4deso10570866a91.3
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 11:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778698571; x=1779303371; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lMUtsmmXt0qUbaR0tmN+fLAyBCwIAa6nmnyrZoPa5NI=;
        b=CxffXDKa6x1CXItA+6WIS7OuPfDFfVdxDBBYh+uRAkRUIvppsZGEfqDFsFtlmrH1Q8
         ncO4gWwFDa91XwtxsRJQLqwEmiX2IPYIivTHydGbhS3qWaE26u9NFzkuK4Fe2Jv5rc6v
         sSxXdnbPzgasS2XrGXFGoAyOaR0t8hg2C4IYPNJwwbXOucwN5UFgdFEB4446vECweXvx
         QJzFfpXtSKPqRGB2Z5RB+joq4cg2s8xvD5bdK51mAjDhp+S+xfURG0ECuYNKgvbzHLH3
         J5PF/2qVNknpOV2thuBGCqfKSOa2Hlf6YVdUbmiXgjNvHnqH/RbbycE5VKYoxg2XNU8Z
         p22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778698571; x=1779303371;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMUtsmmXt0qUbaR0tmN+fLAyBCwIAa6nmnyrZoPa5NI=;
        b=meYJwwTJoQ3rUfd4K6SRjLwI937CtO8X2iCAX+J7SYt1MEeyEds8EAws+EpFV8ALZ0
         kJEG2PYS8tj0PVFBSQrVwG7eHvuOcs6vdxcYySWVN1H7vt4opZ5KKpqoarwt5wwVm6uq
         PkZn/MDHLfIyAoiPAf3XWR36jHTtHJ423aXA4LyKry3MgkXBcCdQOn2rQfdDkwcF+1wi
         jrn1amokvxcr9R+Swp+Lxp9dtFSihHbArw8qCmBNY9Orw2cZi2ydUbPAw0b1TwufOaO0
         nQkTi9+iP0t+2hzlerhYywDP8v5xy5/IF7XWwOukysJA5FMofR6Akgv8nce3Shx9Gl4T
         p+8g==
X-Forwarded-Encrypted: i=1; AFNElJ/buFGMGlMjP8CIsZrKO9GrJi+2skqI2UzvvMDCKKpE6wIiJY472Bj82nA7WuVMfpTckJA+Gg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUHJwU77ofxYKmQcQ18dRdbzNOsD/D3LjLRdNPM4nEaXYFsjCZ
	YPk+gBp+17z+iIA9sk8JJR1+P0nWY8G5+ze0JGnq8veNM21do+ScduWpS/Urf1w0ts4Fiu477sT
	s6CiKUXdGCAUvYe9mbQ7dcIL3roPJyRHcfJQiimBe/vptM7Hb6jXKAPc6wA==
X-Gm-Gg: Acq92OGYqY4OoYjrmzAUWe2AqqJCXLJHWUq1N1riYUSCUUYhn/F5o1W+k/FchBfIeqg
	Mpk0aR2rEycceY1fvdCJTs1BcenIHTVkZDetz0PXEkWn7jl4rP9N0eIk3IJ1HWJzWXKYaD34cUJ
	Pyv/whWvxr0JQMVSxafCNH+p3reAu1s0KOI6ev90lARO8IYL62Bi79NbVIEIaW9OvuHwNaI5eRg
	oZRWgT2qopmeQcu3LIuioB+GSxFF43wHni8I43HYe0UC03CQtYBrkB8Cw5OP3zmgrMK5tmeg9qt
	5wr5JJTySPa30YutJcmIIp2aGvJFANL5Qk3xpCoKW7GA8AzQBIKnJusegapkhl5yrZzYzu3PZ90
	8tACEs1YWC3vpHtAZ5edOtiA5tj/kBC01XUe2dhOaWWNXcZVDsUX2
X-Received: by 2002:a17:90b:56cb:b0:365:c8e3:ec53 with SMTP id 98e67ed59e1d1-368f3d3b8d2mr4973328a91.20.1778698570525;
        Wed, 13 May 2026 11:56:10 -0700 (PDT)
X-Received: by 2002:a17:90b:56cb:b0:365:c8e3:ec53 with SMTP id 98e67ed59e1d1-368f3d3b8d2mr4973280a91.20.1778698569910;
        Wed, 13 May 2026 11:56:09 -0700 (PDT)
Received: from [192.168.0.17] ([49.205.251.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ede204a4sm3725604a91.4.2026.05.13.11.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 11:56:09 -0700 (PDT)
Message-ID: <fa2eb472-92f9-9bf0-be62-93a88785b405@oss.qualcomm.com>
Date: Thu, 14 May 2026 00:25:58 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v5 11/14] media: iris: Add support to select core for dual
 core platforms
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-11-7fbb340c5dbd@oss.qualcomm.com>
 <qodaq4xoi6whna4phhrfbdfanfm43y7vmg4qxjuke5m3qgxozn@h2ot2a7w36xh>
 <a9658e1e-70ed-0c30-28d9-28966242a4eb@oss.qualcomm.com>
 <uujvaqpr72vmdl7w6kjh4xggci4pnhfwukatdj2x63hewfhawa@muzebwimx4oi>
Content-Language: en-US
In-Reply-To: <uujvaqpr72vmdl7w6kjh4xggci4pnhfwukatdj2x63hewfhawa@muzebwimx4oi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GHC4xNrNdKpMBhEBP3Jxbgn8O3HdrMDJ
X-Proofpoint-ORIG-GUID: GHC4xNrNdKpMBhEBP3Jxbgn8O3HdrMDJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4NyBTYWx0ZWRfX0onph9bcwc/h
 5dKazec0boNKTv8Q7x70Y2TGnpeOA2VmsVuE8Z6aMRxa/OMGObupReHNMDoATJyDJGOp5M8zoZV
 N5Vmek6/IvL43BnWm0sRrPer0OkfqCdNQNIpSuf4Ieakc12xsoEUAtJQ7OoUfLa1rkRTWCifqXJ
 XXC3AdMqyU5Zny1knhRg0ZYaKfMil9kVArFCH9RZQQ4Wpg3klq389O8VJbVuJje8+5RGahxvr08
 hHBovO3yMRVqLEfjKmbnRnUwh6vqJ4tIINBOt8AlgO8/wau0lQQsQFgruLvWNSZyc3mcpO6bDEP
 lhrvTHWZo9Ki+Jrc9moD8nSEc3foGCbpzo7nFxZKxiCxbAfPZeuQvFJ50xhsZmV7XzY67ArSWiy
 1q0TyybuARQVttktCgqx24oFGAZsCv9mU8qxMw0SFjy4RP7pkrTXWzs8Q98EQGXlBkdYyk11gRp
 9e9RaIhKxYpIUcRCUhA==
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a04c94b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=UdqKVphAFhxg2bWZaUV5ew==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=4Kw0L1zkfPIsoMSo1fEA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130187


On 5/13/2026 7:21 PM, Dmitry Baryshkov wrote:
> On Mon, May 11, 2026 at 09:42:43PM +0530, Vishnu Reddy wrote:
>> On 5/9/2026 2:30 AM, Dmitry Baryshkov wrote:
>>> On Sat, May 09, 2026 at 12:30:00AM +0530, Vishnu Reddy wrote:
>>>> On platforms with dual vcodec cores, select the hardware core for a
>>>> session based on current load. Assign the session to vcodec0 if its
>>>> MBPF/MBPS capacity allows it, otherwise assign to vcodec1. Communicate
>>>> the selected core to firmware using the new HFI_PROP_CORE_ID property.
>>>>
>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>> ---
>>>>  drivers/media/platform/qcom/iris/iris_common.c     | 10 +++
>>>>  drivers/media/platform/qcom/iris/iris_common.h     |  1 +
>>>>  drivers/media/platform/qcom/iris/iris_core.h       |  5 ++
>>>>  drivers/media/platform/qcom/iris/iris_hfi_common.h |  1 +
>>>>  .../platform/qcom/iris/iris_hfi_gen2_command.c     | 19 ++++++
>>>>  .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  1 +
>>>>  drivers/media/platform/qcom/iris/iris_instance.h   |  2 +
>>>>  .../platform/qcom/iris/iris_platform_common.h      |  1 +
>>>>  drivers/media/platform/qcom/iris/iris_power.c      | 11 ++--
>>>>  drivers/media/platform/qcom/iris/iris_utils.c      | 75 ++++++++++++++++------
>>>>  drivers/media/platform/qcom/iris/iris_vb2.c        |  4 ++
>>>>  drivers/media/platform/qcom/iris/iris_vidc.c       |  6 +-
>>>>  12 files changed, 113 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/drivers/media/platform/qcom/iris/iris_common.c b/drivers/media/platform/qcom/iris/iris_common.c
>>>> index 7f1c7fe144f7..3b3fc482e194 100644
>>>> --- a/drivers/media/platform/qcom/iris/iris_common.c
>>>> +++ b/drivers/media/platform/qcom/iris/iris_common.c
>>>> @@ -46,6 +46,16 @@ void iris_set_ts_metadata(struct iris_inst *inst, struct vb2_v4l2_buffer *vbuf)
>>>>  	inst->metadata_idx++;
>>>>  }
>>>>  
>>>> +int iris_set_core_id(struct iris_inst *inst)
>>>> +{
>>>> +	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
>>>> +
>>>> +	if (!inst->core->iris_platform_data->dual_core)
>>>> +		return 0;
>>>> +
>>>> +	return hfi_ops->session_set_core_id(inst, inst->core_id);
>>>> +}
>>>> +
>>>>  int iris_process_streamon_input(struct iris_inst *inst)
>>>>  {
>>>>  	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
>>>> diff --git a/drivers/media/platform/qcom/iris/iris_common.h b/drivers/media/platform/qcom/iris/iris_common.h
>>>> index b2a27b781c9a..34e32c60f768 100644
>>>> --- a/drivers/media/platform/qcom/iris/iris_common.h
>>>> +++ b/drivers/media/platform/qcom/iris/iris_common.h
>>>> @@ -11,6 +11,7 @@ struct iris_buffer;
>>>>  
>>>>  int iris_vb2_buffer_to_driver(struct vb2_buffer *vb2, struct iris_buffer *buf);
>>>>  void iris_set_ts_metadata(struct iris_inst *inst, struct vb2_v4l2_buffer *vbuf);
>>>> +int iris_set_core_id(struct iris_inst *inst);
>>>>  int iris_process_streamon_input(struct iris_inst *inst);
>>>>  int iris_process_streamon_output(struct iris_inst *inst);
>>>>  int iris_session_streamoff(struct iris_inst *inst, u32 plane);
>>>> diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
>>>> index b396c8cf595e..54a8649841e4 100644
>>>> --- a/drivers/media/platform/qcom/iris/iris_core.h
>>>> +++ b/drivers/media/platform/qcom/iris/iris_core.h
>>>> @@ -30,6 +30,11 @@ enum domain_type {
>>>>  	DECODER	= BIT(1),
>>>>  };
>>>>  
>>>> +enum iris_vcodec_core_id {
>>>> +	IRIS_VCODEC0 = 1,
>>>> +	IRIS_VCODEC1,
>>>> +};
>>>> +
>>>>  /**
>>>>   * struct iris_core - holds core parameters valid for all instances
>>>>   *
>>>> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_common.h b/drivers/media/platform/qcom/iris/iris_hfi_common.h
>>>> index 3edb5ae582b4..fbaf852a6b99 100644
>>>> --- a/drivers/media/platform/qcom/iris/iris_hfi_common.h
>>>> +++ b/drivers/media/platform/qcom/iris/iris_hfi_common.h
>>>> @@ -124,6 +124,7 @@ struct iris_hfi_command_ops {
>>>>  	int (*session_drain)(struct iris_inst *inst, u32 plane);
>>>>  	int (*session_resume_drain)(struct iris_inst *inst, u32 plane);
>>>>  	int (*session_close)(struct iris_inst *inst);
>>>> +	int (*session_set_core_id)(struct iris_inst *inst, u32 core_id);
>>>>  };
>>>>  
>>>>  struct iris_hfi_response_ops {
>>>> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
>>>> index 30bfd90d423b..9d9fae587297 100644
>>>> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
>>>> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
>>>> @@ -1300,6 +1300,24 @@ static int iris_hfi_gen2_session_release_buffer(struct iris_inst *inst, struct i
>>>>  					inst_hfi_gen2->packet->size);
>>>>  }
>>>>  
>>>> +static int iris_hfi_gen2_set_core_id(struct iris_inst *inst, u32 core_id)
>>>> +{
>>>> +	struct iris_inst_hfi_gen2 *inst_hfi_gen2 = to_iris_inst_hfi_gen2(inst);
>>>> +	u32 payload = core_id;
>>>> +
>>>> +	iris_hfi_gen2_packet_session_command(inst,
>>>> +					     HFI_PROP_CORE_ID,
>>>> +					     HFI_HOST_FLAGS_NONE,
>>>> +					     HFI_PORT_NONE,
>>>> +					     inst->session_id,
>>>> +					     HFI_PAYLOAD_U32,
>>>> +					     &payload,
>>>> +					     sizeof(u32));
>>>> +
>>>> +	return iris_hfi_queue_cmd_write(inst->core, inst_hfi_gen2->packet,
>>>> +					inst_hfi_gen2->packet->size);
>>>> +}
>>>> +
>>>>  static const struct iris_hfi_command_ops iris_hfi_gen2_command_ops = {
>>>>  	.sys_init = iris_hfi_gen2_sys_init,
>>>>  	.sys_image_version = iris_hfi_gen2_sys_image_version,
>>>> @@ -1317,6 +1335,7 @@ static const struct iris_hfi_command_ops iris_hfi_gen2_command_ops = {
>>>>  	.session_drain = iris_hfi_gen2_session_drain,
>>>>  	.session_resume_drain = iris_hfi_gen2_session_resume_drain,
>>>>  	.session_close = iris_hfi_gen2_session_close,
>>>> +	.session_set_core_id = iris_hfi_gen2_set_core_id,
>>>>  };
>>>>  
>>>>  void iris_hfi_gen2_command_ops_init(struct iris_core *core)
>>>> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
>>>> index cecf771c55dd..600e9dc07669 100644
>>>> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
>>>> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
>>>> @@ -56,6 +56,7 @@
>>>>  #define HFI_PROP_BUFFER_HOST_MAX_COUNT		0x03000123
>>>>  #define HFI_PROP_BUFFER_FW_MIN_OUTPUT_COUNT	0x03000124
>>>>  #define HFI_PROP_PIC_ORDER_CNT_TYPE		0x03000128
>>>> +#define HFI_PROP_CORE_ID			0x030001a9
>>>>  
>>>>  enum hfi_rate_control {
>>>>  	HFI_RC_VBR_CFR		= 0x00000000,
>>>> diff --git a/drivers/media/platform/qcom/iris/iris_instance.h b/drivers/media/platform/qcom/iris/iris_instance.h
>>>> index 16965150f427..dd341ca5be57 100644
>>>> --- a/drivers/media/platform/qcom/iris/iris_instance.h
>>>> +++ b/drivers/media/platform/qcom/iris/iris_instance.h
>>>> @@ -37,6 +37,7 @@ struct iris_fmt {
>>>>   *
>>>>   * @list: used for attach an instance to the core
>>>>   * @core: pointer to core structure
>>>> + * @core_id: specifies the hardware core on which the session runs
>>>>   * @session_id: id of current video session
>>>>   * @ctx_q_lock: lock to serialize queues related ioctls
>>>>   * @lock: lock to seralise forward and reverse threads
>>>> @@ -79,6 +80,7 @@ struct iris_fmt {
>>>>  struct iris_inst {
>>>>  	struct list_head		list;
>>>>  	struct iris_core		*core;
>>>> +	u32				core_id;
>>>>  	u32				session_id;
>>>>  	struct mutex			ctx_q_lock;/* lock to serialize queues related ioctls */
>>>>  	struct mutex			lock; /* lock to serialize forward and reverse threads */
>>>> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
>>>> index 8995136ad29e..502d7099085c 100644
>>>> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
>>>> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
>>>> @@ -258,6 +258,7 @@ struct iris_platform_data {
>>>>  	const struct tz_cp_config *tz_cp_config_data;
>>>>  	u32 tz_cp_config_data_size;
>>>>  	u32 core_arch;
>>>> +	bool dual_core;
>>>>  	u32 hw_response_timeout;
>>>>  	struct ubwc_config_data *ubwc_config;
>>>>  	u32 num_vpp_pipe;
>>>> diff --git a/drivers/media/platform/qcom/iris/iris_power.c b/drivers/media/platform/qcom/iris/iris_power.c
>>>> index 91aa21d4070e..b72ce5b596b8 100644
>>>> --- a/drivers/media/platform/qcom/iris/iris_power.c
>>>> +++ b/drivers/media/platform/qcom/iris/iris_power.c
>>>> @@ -77,9 +77,9 @@ static int iris_vote_interconnects(struct iris_inst *inst)
>>>>  
>>>>  static int iris_set_clocks(struct iris_inst *inst)
>>>>  {
>>>> +	u64 vcodec0_freq = 0, vcodec1_freq = 0;
>>>>  	struct iris_core *core = inst->core;
>>>>  	struct iris_inst *instance;
>>>> -	u64 freq = 0;
>>>>  	int ret;
>>>>  
>>>>  	mutex_lock(&core->lock);
>>>> @@ -87,11 +87,14 @@ static int iris_set_clocks(struct iris_inst *inst)
>>>>  		if (!instance->max_input_data_size)
>>>>  			continue;
>>>>  
>>>> -		freq += instance->power.min_freq;
>>>> +		if (instance->core_id == IRIS_VCODEC0)
>>>> +			vcodec0_freq += instance->power.min_freq;
>>>> +		else
>>>> +			vcodec1_freq += instance->power.min_freq;
>>>>  	}
>>>>  
>>>> -	core->power.clk_freq = freq;
>>>> -	ret = iris_opp_set_rate(core->dev, freq);
>>>> +	core->power.clk_freq = max(vcodec0_freq, vcodec1_freq);
>>>> +	ret = iris_opp_set_rate(core->dev, core->power.clk_freq);
>>>>  	mutex_unlock(&core->lock);
>>>>  
>>>>  	return ret;
>>>> diff --git a/drivers/media/platform/qcom/iris/iris_utils.c b/drivers/media/platform/qcom/iris/iris_utils.c
>>>> index cfc5b576ec56..da8a89d3dd41 100644
>>>> --- a/drivers/media/platform/qcom/iris/iris_utils.c
>>>> +++ b/drivers/media/platform/qcom/iris/iris_utils.c
>>>> @@ -90,40 +90,79 @@ struct iris_inst *iris_get_instance(struct iris_core *core, u32 session_id)
>>>>  	return NULL;
>>>>  }
>>>>  
>>>> -int iris_check_core_mbpf(struct iris_inst *inst)
>>>> +static u32 iris_get_mbps(struct iris_inst *inst)
>>>>  {
>>>> -	struct iris_core *core = inst->core;
>>>> +	u32 fps = max(inst->frame_rate, inst->operating_rate);
>>>> +
>>>> +	return iris_get_mbpf(inst) * fps;
>>>> +}
>>>> +
>>>> +static int iris_check_and_assign_core(struct iris_inst *inst, bool mbpf)
>>>> +{
>>>> +	const struct iris_platform_data *platform_data = inst->core->iris_platform_data;
>>>> +	u32 max_load = mbpf ? platform_data->max_core_mbpf : platform_data->max_core_mbps;
>>>> +	u32 max_session_cnt = platform_data->max_session_count;
>>>> +	u32 core0_session_cnt = 0, core1_session_cnt = 0;
>>>> +	bool dual_core = platform_data->dual_core;
>>> num_cores
>> A num_cores field would require updating all platform data entries. For two
> I was thinking about adding num_cores to platform_data and to iris_inst
> (or iris_core) and setting it to 1 if the value is unset in
> platform_data.
>
> A better option would be to move all these multi-core functions to a
> separate file.

Thanks for your point, Adding num_cores to platform_data makes sense if the
number of cores grows beyond two. For now, since we only handle single and
dual core, the current logic feels simpler and sufficient to cover both cases.
Happy to adopt the num_cores approach in the future if we have any platform
with more than dual core.

>> cores, a simple boolean flag feels sufficient here.
>>
>>>> +	u32 core0_load = 0, core1_load = 0;
>>>> +	bool select_core0, select_core1;
>>>>  	struct iris_inst *instance;
>>>> -	u32 total_mbpf = 0;
>>>> +	u32 load, new_load;
>>>>  
>>>> -	mutex_lock(&core->lock);
>>>> -	list_for_each_entry(instance, &core->instances, list)
>>>> -		total_mbpf += iris_get_mbpf(instance);
>>>> -	mutex_unlock(&core->lock);
>>>> +	inst->core_id = 0;
>>>>  
>>>> -	if (total_mbpf > core->iris_platform_data->max_core_mbpf)
>>>> +	list_for_each_entry(instance, &inst->core->instances, list) {
>>>> +		load = mbpf ? iris_get_mbpf(instance) : iris_get_mbps(instance);
>>>> +
>>>> +		if (instance->core_id == IRIS_VCODEC0) {
>>>> +			core0_load += load;
>>>> +			core0_session_cnt++;
>>>> +		} else if (instance->core_id == IRIS_VCODEC1) {
>>>> +			core1_load += load;
>>>> +			core1_session_cnt++;
>>> Arrays, please.
>> Since we only have two cores, explicit variables feel cleaner and easier to
>> read than arrays.
>>
>>>> +		}
>>>> +	}
>>>> +
>>>> +	new_load = mbpf ? iris_get_mbpf(inst) : iris_get_mbps(inst);
>>>> +
>>>> +	select_core0 = core0_load + new_load <= max_load && core0_session_cnt < max_session_cnt;
>>>> +	select_core1 = dual_core && core1_load + new_load <= max_load &&
>>>> +		     core1_session_cnt < max_session_cnt;
>>>> +
>>>> +	if (select_core0 && select_core1)
>>>> +		inst->core_id = (core0_load <= core1_load) ? IRIS_VCODEC0 : IRIS_VCODEC1;
>>>> +	else if (select_core0)
>>>> +		inst->core_id = IRIS_VCODEC0;
>>>> +	else if (select_core1)
>>>> +		inst->core_id = IRIS_VCODEC1;
>>>> +	else
>>>>  		return -ENOMEM;
>>>>  
>>>>  	return 0;
>>>>  }
>>>>  
>>>> -int iris_check_core_mbps(struct iris_inst *inst)
>>>> +int iris_check_core_mbpf(struct iris_inst *inst)
>>>>  {
>>>>  	struct iris_core *core = inst->core;
>>>> -	struct iris_inst *instance;
>>>> -	u32 total_mbps = 0, fps = 0;
>>>> +	int ret;
>>>>  
>>>>  	mutex_lock(&core->lock);
>>>> -	list_for_each_entry(instance, &core->instances, list) {
>>>> -		fps = max(instance->frame_rate, instance->operating_rate);
>>>> -		total_mbps += iris_get_mbpf(instance) * fps;
>>>> -	}
>>>> +	ret = iris_check_and_assign_core(inst, true);
>>>>  	mutex_unlock(&core->lock);
>>>>  
>>>> -	if (total_mbps > core->iris_platform_data->max_core_mbps)
>>>> -		return -ENOMEM;
>>>> +	return ret;
>>>> +}
>>>>  
>>>> -	return 0;
>>>> +int iris_check_core_mbps(struct iris_inst *inst)
>>>> +{
>>>> +	struct iris_core *core = inst->core;
>>>> +	int ret;
>>>> +
>>>> +	mutex_lock(&core->lock);
>>>> +	ret = iris_check_and_assign_core(inst, false);
>>>> +	mutex_unlock(&core->lock);
>>>> +
>>>> +	return ret;
>>>>  }
>>>>  
>>>>  bool is_rotation_90_or_270(struct iris_inst *inst)
>>>> diff --git a/drivers/media/platform/qcom/iris/iris_vb2.c b/drivers/media/platform/qcom/iris/iris_vb2.c
>>>> index bf0b8400996e..5a05f7d65501 100644
>>>> --- a/drivers/media/platform/qcom/iris/iris_vb2.c
>>>> +++ b/drivers/media/platform/qcom/iris/iris_vb2.c
>>>> @@ -176,6 +176,10 @@ int iris_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
>>>>  	if (ret)
>>>>  		goto error;
>>>>  
>>>> +	ret = iris_set_core_id(inst);
>>>> +	if (ret)
>>>> +		goto error;
>>>> +
>>>>  	if (V4L2_TYPE_IS_OUTPUT(q->type)) {
>>>>  		if (inst->domain == DECODER)
>>>>  			ret = iris_vdec_streamon_input(inst);
>>>> diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
>>>> index 5eb1786b0737..a1ce3cd524a3 100644
>>>> --- a/drivers/media/platform/qcom/iris/iris_vidc.c
>>>> +++ b/drivers/media/platform/qcom/iris/iris_vidc.c
>>>> @@ -41,16 +41,20 @@ static void iris_v4l2_fh_deinit(struct iris_inst *inst, struct file *filp)
>>>>  
>>>>  static void iris_add_session(struct iris_inst *inst)
>>>>  {
>>>> +	u32 max_session_count = inst->core->iris_platform_data->max_session_count;
>>>>  	struct iris_core *core = inst->core;
>>>>  	struct iris_inst *iter;
>>>>  	u32 count = 0;
>>>>  
>>>> +	if (inst->core->iris_platform_data->dual_core)
>>>> +		max_session_count *= 2;
>>> max_session_count *= num_cores.
>>>
>>>> +
>>>>  	mutex_lock(&core->lock);
>>>>  
>>>>  	list_for_each_entry(iter, &core->instances, list)
>>>>  		count++;
>>>>  
>>>> -	if (count < core->iris_platform_data->max_session_count)
>>>> +	if (count < max_session_count)
>>>>  		list_add_tail(&inst->list, &core->instances);
>>>>  
>>>>  	mutex_unlock(&core->lock);
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
