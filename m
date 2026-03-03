Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E7947CC98
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563751; cv=none; b=drKKvOThFshFy4oR8zNB9wUwR1BU202UvouO8jKdge6TQifRAiJs0uOJ8FvAlTDZ945QXdtVw7yvgN2NJmHvIyJykC82rlACd8Aedk4vqEdGVg3IWywpXVWdmklHsrfeE+p2ENxU78sInw0Y3jAqA8LuFyjhY6+TF5eWpfY9yag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563751; c=relaxed/simple;
	bh=+YCHZthXzXferOAYmuw1oAFs0k8y0dUN8O4oTXBLz4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gni+8ktMJAWDU/+9djy3ejd0R0aCaoakyhroo/CxdXCGLqs3ISbTpr3WeRok4qaig9uRPGWO/ZcCklH+r80qyjhw6C9rlP14BB6+VwKJj3+ItkTSDGAf9EkI8PzoYajRU9vCEhcDNQMzms2QiwxLxJ2FE2rx/wEynpZcf6wl5iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XSb3zBBR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ai57bVtR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XSb3zBBR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ai57bVtR"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623H0ZKq3548704
	for <iommu@lists.linux.dev>; Tue, 3 Mar 2026 18:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i00w6JYppMDGe8px09NxESnkQORu5ngL847U9vrSgKg=; b=XSb3zBBRLGvsPltX
	KITAC+6l8F8e4K5i41hygfyDR8/STImJdseZDQ2lDNOQOe4P/UaqF+p8HSXHoxFN
	5JABDk9/26hJOolg0w0lVsP2iH9Ed7yEhy7mFh2ZRLjZWGSgzc9EiG2aMNmeYd30
	+QuovYiPmAiK5Om9oKNxYXY1qpiF1H7k8RWHOxWFyGLWJDiFHt8eovtxk7GdexE4
	PMPdTYKV/vq/OWaptUJ5zTbxRLB/Y/eLpl60jyR5+soPRfZiLa9Unp7b6Dj5UKpx
	C9RualGYhzge+4VVJF4nKxyojpJDsC12NndMGLuevk0NNjwGuf62A1qrpO8TbGW3
	IaMuIA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnvxf9uyx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 18:49:08 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3597f559e70so2336373a91.3
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 10:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772563748; x=1773168548; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i00w6JYppMDGe8px09NxESnkQORu5ngL847U9vrSgKg=;
        b=ai57bVtR+J3twKOWWmCmnBm8iCzF41KXFxgGrgyEX4C3kqEoTF6ukEuj+KuCeR+qxA
         ThjyVt/X9w+yd7q9kh/qXt/uYXp0sr8lrfypvq0ueNPJYjY5jANkjo1IrsKHdkUkl0P0
         ZTfcEDE8UMm8f3u/EZu/LRIK3rOVq3qL+hqqbpnmOk8ZJadLaD9tEUC/u4ctPF8WH04S
         Mhqw/ZgEppha5M3NknH1NULwu0yjsSA6gtgCOwiOijVFdGR6mTDyjhUqC5GdpKWfEVru
         Zj8rN71pGnNGC9kGLQTksa0DN7imArGc6iu+Iqrvvt0msWWCqas04x4H4kHb9SZ/DfMQ
         838w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772563748; x=1773168548;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i00w6JYppMDGe8px09NxESnkQORu5ngL847U9vrSgKg=;
        b=TSv9qy+uJm8IOa3XqEEWXg94gu9xN0OXEivgO0n4NwEHEHkS+KFqyIxmKbIv3x7Ol+
         Ph2sOM7p/1DSmTIZsdDWUnysfOve8cp8v5cDv9TxrJ6mKlhc2qGJmhgOHbjvhDmW6mnq
         BqOTA4hCVEPwh7MLj+djF+lRgIBKxKQ+PSl/f+QeWmFnazE6upJZll/LJTIxdL4CSU16
         vcbp7CSHC7clvvKq1CHRIZe57DBE2VPX7A8IMwnF/2+SU0nrEuzyV7vxDlZvqRYJkCzP
         9IZlSLmlu7+D4T6MB4Es8lRCBPYlTuccuI1kVFH08kupmWUK5VQW9A6j18geWIkJNIFj
         RaDw==
X-Forwarded-Encrypted: i=1; AJvYcCWAo8bRl99Bh44aOvXr8ncaR72ThPxT7mamB4n0sotxmoDzegPcaPBv2Noo0oojoIaRVYbDsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJBim3bihZM0CU6fX5PTjrNqG0c9zvpXHU4bZzn+g38Aw7ADmh
	i93l58Pd877+h33d/HgThtV2MoxdB+lLZSaFy3tkEpUlAExEi7v2mr7JLDtW7yTArBwgE7Y1wzq
	5mFuGLrn5ntIy970M4aPSDWyYHMSjljD/avQmmuOvqIFyc9nexveFE0k6GQ==
X-Gm-Gg: ATEYQzyez/axGqmMFKgBUB5QiTSLg7v9hGp4okII6XJI6UA9tAty3uC2TYNc298dBVb
	snYzmjpY2bOsuGPnvn+DviX/K9SlK0Gr0dYOPNhpIzUkdLoSDgVQzoAFA7drWCNCswjpUrp06dS
	dPWiGIMt5L597r2TEqDG0UHPWq3fXkuAl3lCaBm8jzoWQc6E4vGM6/UHZpp/yF+LQ4Zp5sUI5Ze
	Q6wDvUcthgEBXzLYpaHGtcsHCtggYW2Ut5l2aRJ0Zrnf5HP2aWMdwukXV4L9gefs55clARbT0/h
	4wEavzo73jCrki0HTBqmHva+EetjePw7SstfEsHb2MTwGzkrHXv3XapGInwXeEqFXZn3tu9C6oz
	rycm+xJU3ESdcCMBgP7AQb8unrmV/1hi5z8QNnAPH6qAst3EAEteLZH8=
X-Received: by 2002:a17:90b:5847:b0:340:bb64:c5e with SMTP id 98e67ed59e1d1-35965c34e76mr16015870a91.14.1772563747535;
        Tue, 03 Mar 2026 10:49:07 -0800 (PST)
X-Received: by 2002:a17:90b:5847:b0:340:bb64:c5e with SMTP id 98e67ed59e1d1-35965c34e76mr16015837a91.14.1772563746967;
        Tue, 03 Mar 2026 10:49:06 -0800 (PST)
Received: from [192.168.0.172] ([49.205.248.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4083a1sm2897718a91.6.2026.03.03.10.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 10:49:06 -0800 (PST)
Message-ID: <ce80e60e-90ca-415d-83af-4fe2e86ffd91@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 00:18:58 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] media: iris: add iris4 specific H265 line buffer
 calculation
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-6-850043ac3933@oss.qualcomm.com>
 <cbwz5wtd55enswdi2zvvy3d66nsxlemyzdypheibvljnewmkax@kybx63aveepn>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <cbwz5wtd55enswdi2zvvy3d66nsxlemyzdypheibvljnewmkax@kybx63aveepn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE1MSBTYWx0ZWRfXyt0+TmVOHIml
 OVEkpqB1uQBsVtTlo/GRJdM1DTyfSUEGb24NMA+G69xtkHvrY89JhR17x7gr/qRm3nDeEWfA1Lz
 itBE/YpK3mfh7CPUyPiRhOug9Df2tp7a5SnF4VPstxugfIyjGQBSaW6Mhs3gvxWN/ZxR+iStL/R
 1Nwg/GdZ+LPGFhhAV9WSJk7d7nTG8AxL+Z4KjRUbxLjp/vSKd1SzI4xBnHve3XKk+Nt3jXMQyB2
 1t8WkXqLUbk16DY5caoEuozpPxzIopnqV6CUfsCkBwGNbu9hyfZiDXXVnNw1dfqV5MCnKZZqeGB
 n8rmNgAlW8pbCIxMoeUBBGBVkN76qCCoK5io/0vEjxNrR4bKyOo1zzbNQ7+e3RrS8NiGF7hw9EP
 /XE56xp/5/+T7IzgJieDmRW+xl8ijBCc6iq7KslL9orobXphirT486pYwNo6Wk8OKGfqzLm+lQF
 icp7tFz2UZ2uJD76qDw==
X-Proofpoint-ORIG-GUID: 1d_v7FVq3U4pK5VzEPxr6AzB-mWcicom
X-Authority-Analysis: v=2.4 cv=S+HUAYsP c=1 sm=1 tr=0 ts=69a72d24 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=KPiuay1jFzAquJblYynD6w==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=hv41YOXH2Fg2t9TqYk4A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 1d_v7FVq3U4pK5VzEPxr6AzB-mWcicom
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030151


On 2/28/2026 1:58 AM, Dmitry Baryshkov wrote:
> On Fri, Feb 27, 2026 at 07:41:22PM +0530, Vikash Garodia wrote:
>> The H265 decoder line buffer size calculation for iris4 (VPU4) was
>> previously reusing the iris3 formula. While this works for most
>> resolutions, certain configurations require a larger buffer size on
>> iris4, causing firmware errors during decode. This resolves firmware
>> failures seen with specific test vectors on kaanapali (iris4), and fixes
>> the following failing fluster tests
>> - PICSIZE_C_Bossen_1
>> - WPP_E_ericsson_MAIN_2
> 
> This reminds me of the commit fixing SC7280 support. Should SC7280 or
> all VPU2.0 platforms also use separate formula?
> 
for vpu2, there is already a separate formula

>>
>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>   drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 51 +++++++++++++++++++++-
>>   1 file changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
>> index 9270422c16019ba658ee8813940cb9110ad030a1..a4d599c49ce9052b609b9cedf65f669ba78b5407 100644
>> --- a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
>> +++ b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
>> @@ -1755,6 +1755,55 @@ static u32 hfi_vpu4x_buffer_line_vp9d(u32 frame_width, u32 frame_height, u32 _yu
>>   	return lb_size + dpb_obp_size;
>>   }
>>   
>> +static u32 hfi_vpu4x_buffer_line_h265d(u32 frame_width, u32 frame_height, bool is_opb,
>> +				       u32 num_vpp_pipes)
>> +{
>> +	u32 num_lcu_per_pipe, fe_left_lb, se_left_lb, vsp_left_lb, top_lb, qp_size,
>> +	    dpb_obp = 0, lcu_size = 16;
>> +
>> +	num_lcu_per_pipe = (DIV_ROUND_UP(frame_height, lcu_size) / num_vpp_pipes) +
>> +			   (DIV_ROUND_UP(frame_height, lcu_size) % num_vpp_pipes);
>> +
>> +	fe_left_lb = ALIGN((DMA_ALIGNMENT * num_lcu_per_pipe), DMA_ALIGNMENT) *
>> +				FE_LFT_CTRL_LINE_NUMBERS;
>> +	fe_left_lb += ALIGN((DMA_ALIGNMENT * 2 * num_lcu_per_pipe), DMA_ALIGNMENT) *
>> +				FE_LFT_DB_DATA_LINE_NUMBERS;
>> +	fe_left_lb += ALIGN((DMA_ALIGNMENT * num_lcu_per_pipe), DMA_ALIGNMENT);
>> +	fe_left_lb += ALIGN((DMA_ALIGNMENT * 2 * num_lcu_per_pipe), DMA_ALIGNMENT);
>> +	fe_left_lb += ALIGN((DMA_ALIGNMENT * 8 * num_lcu_per_pipe), DMA_ALIGNMENT) *
>> +				FE_LFT_LR_DATA_LINE_NUMBERS;
>> +
>> +	if (is_opb)
>> +		dpb_obp = size_dpb_opb(frame_height, lcu_size) * num_vpp_pipes;
>> +
>> +	se_left_lb = max_t(u32, (ALIGN(frame_height, BUFFER_ALIGNMENT_16_BYTES) >> 3) *
>> +				MAX_SE_NBR_CTRL_LCU16_LINE_BUFFER_SIZE,
>> +				max_t(u32, (ALIGN(frame_height, BUFFER_ALIGNMENT_32_BYTES) >> 3) *
>> +				MAX_SE_NBR_CTRL_LCU32_LINE_BUFFER_SIZE,
>> +				(ALIGN(frame_height, BUFFER_ALIGNMENT_64_BYTES) >> 3) *
>> +				MAX_SE_NBR_CTRL_LCU64_LINE_BUFFER_SIZE));
>> +
>> +	vsp_left_lb = ALIGN(DIV_ROUND_UP(frame_height, BUFFER_ALIGNMENT_64_BYTES) *
>> +				H265_NUM_TILE_ROW, DMA_ALIGNMENT);
>> +
>> +	top_lb = ALIGN((DMA_ALIGNMENT * DIV_ROUND_UP(frame_width, lcu_size)), DMA_ALIGNMENT) *
>> +				FE_TOP_CTRL_LINE_NUMBERS;
>> +	top_lb += ALIGN(DMA_ALIGNMENT * 2 * DIV_ROUND_UP(frame_width, lcu_size), DMA_ALIGNMENT) *
>> +				FE_TOP_DATA_LUMA_LINE_NUMBERS;
>> +	top_lb += ALIGN(DMA_ALIGNMENT * 2 * (DIV_ROUND_UP(frame_width, lcu_size) + 1),
>> +			DMA_ALIGNMENT) * FE_TOP_DATA_CHROMA_LINE_NUMBERS;
>> +	top_lb += ALIGN(ALIGN(frame_width, BUFFER_ALIGNMENT_64_BYTES) * 2, DMA_ALIGNMENT);
>> +	top_lb += ALIGN(ALIGN(frame_width, BUFFER_ALIGNMENT_64_BYTES) * 6, DMA_ALIGNMENT);
>> +	top_lb += size_h265d_lb_vsp_top(frame_width, frame_height);
>> +
>> +	qp_size = size_h265d_qp(frame_width, frame_height);
>> +
>> +	return ((ALIGN(dpb_obp, DMA_ALIGNMENT) + ALIGN(se_left_lb, DMA_ALIGNMENT) +
>> +		ALIGN(vsp_left_lb, DMA_ALIGNMENT)) * num_vpp_pipes) +
>> +		ALIGN(fe_left_lb, DMA_ALIGNMENT) + ALIGN(top_lb, DMA_ALIGNMENT) +
>> +		ALIGN(qp_size, DMA_ALIGNMENT);
>> +}
>> +
>>   static u32 iris_vpu4x_dec_line_size(struct iris_inst *inst)
>>   {
>>   	u32 num_vpp_pipes = inst->core->iris_platform_data->num_vpp_pipe;
>> @@ -1770,7 +1819,7 @@ static u32 iris_vpu4x_dec_line_size(struct iris_inst *inst)
>>   	if (inst->codec == V4L2_PIX_FMT_H264)
>>   		return hfi_buffer_line_h264d(width, height, is_opb, num_vpp_pipes);
>>   	else if (inst->codec == V4L2_PIX_FMT_HEVC)
>> -		return hfi_buffer_line_h265d(width, height, is_opb, num_vpp_pipes);
>> +		return hfi_vpu4x_buffer_line_h265d(width, height, is_opb, num_vpp_pipes);
>>   	else if (inst->codec == V4L2_PIX_FMT_VP9)
>>   		return hfi_vpu4x_buffer_line_vp9d(width, height, out_min_count, is_opb,
>>   						  num_vpp_pipes);
>>
>> -- 
>> 2.34.1
>>
> 

