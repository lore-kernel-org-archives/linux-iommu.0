Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4CB37D111
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772224110; cv=none; b=NHPnILxRYRgm9VZNFaYrHhydmQyGjcwBMLLBn6fnlr1KgYMd8RDBw9u19oRsYwvImtBkFq3t3hi5qicUdeOew8rE6MCOgyuMGbynHg2Ma7nTxjL84njemcoWUFZ5VH0SWHAqkF/XvlbXQ7Xkkt2nOWz78TqQSGPCPXwr6Zmm7h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772224110; c=relaxed/simple;
	bh=ubRpnnZCa3BtxGeTQH8/24NroyvQw+/jfEMurUW7GwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgxqdm+1WRnTLp66P90Dbag4aUHyR9LRo8r1ekUyps0vqAhjnbfAgCfMRAie6oPSbQfDG+lXm6gNGWcJoMn1QlTpfNsKd5m1howiv0dWSfm25LfN8FZsVN+497BqyyZtxxKHvSRxEHdyrqj1V9n5ER4SU1PTKpqxuis58XGs/FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nK2X3KtX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZCaPVy8o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nK2X3KtX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZCaPVy8o"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RH0Gfw065303
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 20:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lXz8uYqb+tpPwbAm+qmdqDbm
	VqPyxZKSrLTUZphOd/U=; b=nK2X3KtXtku82Y76wPMRZmUpj+8CT6L0uOmOgU3E
	L2BNQubsByoq8ptEwCyi5yH/pBdKpE3uCef79vOGcWJUbE0pDE0Q8/KxclSTQOgE
	vGm3V3CtiS3FodsjQ99+0YzzLBA2jZxABdWsJzIEAhOIGbfw7njRxnKhSY1W0Ib3
	AgNdgQApkYjlETglgOr2ZF9PBCRm3zKPPw4VO7V4EXffwXJdoZZ6XkKRVzIDnwep
	pglHMArpoTuAHbxb5x4uKbNlOBK9jR9kiIiM64RY1VoQI2TalU3hZ7EbRDW8yD1h
	ur0ZFOjaN1pimiJUixUXyJv5DYfLuJUN9PiXYsj9RV7tXQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cka2xhq7s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 20:28:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb706313beso306753085a.3
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 12:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772224108; x=1772828908; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lXz8uYqb+tpPwbAm+qmdqDbmVqPyxZKSrLTUZphOd/U=;
        b=ZCaPVy8oM+WX8c4XM8XCZF3dQFVO9gAsCh4uSPryP0SJu2dQ43k38+aJKAYaY4XSwA
         UZYE+2qKEYLsasopW19sVJsdu9HxYSq/N5BkvhV3h/n/IXFIPl9PiWe07oiHB0CB79eu
         BQfxhjbLwlVOMw56hoU35hGR8wJmOXHz/Oh+wfQzagjcIrFzyXb4ZfuP6i51aU8vDVOW
         /Z+2pSSZ3gKyqFHyGzlkdWShHxnXn1O+kOE8mff+tzpT9OjZv4wfp5iLZigPBRtD/Cui
         un2GDE9sS/YGyC1kXAWi1y4NAw6CsVwlgqZofXLe9OVPujKmQjFlp3j8qgsgzFRoC3u8
         1uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772224108; x=1772828908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXz8uYqb+tpPwbAm+qmdqDbmVqPyxZKSrLTUZphOd/U=;
        b=ecqeipnQRosN0fCl7O5AwuFSBdn//pEKZmyT7u2TtDCFuKtcGpQwU4ypDb1gFCzqU4
         tZ03o2wDh4n5+iTbSRBI0HgPfixWGL3G0CWyi8tluvevsExUnDBT1koieY2Hbpr7rYbf
         Lcg103Fy8GJVK1M/IxTlL7e1iOXmkLyaYWaovShuYXDZgpbrzU8HEMdkOA5KobM6WagL
         VG5+7a88RNw5xt0rhIoUDsC3T0Z5bjpGfwkApo1GpiAIz44sh+1V02sSHcMUVn/eLTJQ
         uIRTUVQwUf9me7tpk3bRKhhhbi5qEco7z7M5RxSn1znzmIkIL+n8Ri9xeZ0P//JIs10/
         Mg+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV823vAtlUnqc/qcMHCkOkoI+hcTsicRq9rg3CMAl9MXPj2dkUAGkYIBYBmRtfmi1/c5s1rag==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZvuxVvtTDhZNq6JG3ZgWCVCPnS3IxdrrVHERendZ25Hccv4GM
	5A2PsAkE2+6fN83VenzKLusCEZWjWA6c2HDS4wDLgK2IOJCgRJzj/ogPTZEkjV6TR6xJ0CCiyw8
	lf1ajjPDY3IaavuZDZClQcUsv6ZEiQ0T02HixSOda8lxfL8W8Xpac0DI1JQ==
X-Gm-Gg: ATEYQzyUIx+oin5eO05p8RawMX4HIXxKfHIAna1NO4MMfWXTJ1bE1NRt72vP4fdT8JY
	7wtZrwdlOr/1Fs4uVsMV3JehK9kyQPon8hG9R88vZt8Sv/mO+mjWu9eivvCAnrssim7kNVuvzFX
	5yjecPfFT9I+2TAUuopYu3ssSOWy5nhfy1SwUL3XCvn2e7jR7ZTsmarwRGBtesgKrLkC7GzYUNH
	cmn7VpxJH0OfYwBcDBtoDd2Rx4/9St36sz8V2mHK8HFyr72ZUnU/oOzFBt6Jo5NWd2evqXWC5aX
	MRuu7PDKGSPRrxJCe6it+vhRkou3LewTDugZWtirxzeXD9/NaCz6SzhaxrJG2BFFf+8OYjcm9bs
	Kq4MnKYEL+VbBc0LYwCuFKBR3qjVtlfetyU8ZVMJsJEllXRPZDp7XVzCozWAalPg9N8gmLNJM6T
	kUPAncfNRNFJzfmHQ92EdiGzVeiyweB91CJCo=
X-Received: by 2002:a05:620a:4891:b0:8c7:a53:4d17 with SMTP id af79cd13be357-8cbc8e863f5mr527247485a.21.1772224107559;
        Fri, 27 Feb 2026 12:28:27 -0800 (PST)
X-Received: by 2002:a05:620a:4891:b0:8c7:a53:4d17 with SMTP id af79cd13be357-8cbc8e863f5mr527242385a.21.1772224107036;
        Fri, 27 Feb 2026 12:28:27 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389f30179e9sm15051161fa.33.2026.02.27.12.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 12:28:26 -0800 (PST)
Date: Fri, 27 Feb 2026 22:28:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
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
Subject: Re: [PATCH v2 6/7] media: iris: add iris4 specific H265 line buffer
 calculation
Message-ID: <cbwz5wtd55enswdi2zvvy3d66nsxlemyzdypheibvljnewmkax@kybx63aveepn>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-6-850043ac3933@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227-kaanapali-iris-v2-6-850043ac3933@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=BOC+bVQG c=1 sm=1 tr=0 ts=69a1fe6c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=BuJnJetHAO0UpRBxyx0A:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 9owuYc_vbfnHabqAfbEA7qO7waBkQ67Y
X-Proofpoint-ORIG-GUID: 9owuYc_vbfnHabqAfbEA7qO7waBkQ67Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE3OSBTYWx0ZWRfX7+1k0R9pUBzN
 9PjjIaYFnmC9g5wm1jqLvivxJXGoXB03uRljzB46RtoBq/L2C5ehfAPjjm045r997Ejl6IqazhM
 Q48fXyLypx0tUAoWCH+XamTdln3TF60hWQzPGVvpj/k0W68WLaPMqyVwiwrkr3Mul03m6A+tXSG
 ZpeqyPrzTnA8ryjpADu5I8aktf2j2Yr2Ak13/RkWe2mIWGC1mf/voajEZFurBdGCgrQTAF1i+pm
 7IRtKGgAnztcMdHY36fWYguFAmf7GEnKj2X4fEqba/NGYVJcXA30PCkMF3pcNgJq9w84F7exuHA
 9jlzPaeRNLpD8pN05fcWQ4hMkaIX5mMmhJAWJUxkTZD7tO9uZdt2MPHemZEyr2OuYKys70gllvd
 bcxjfAZ/0EOaHygNDGYLzWEOR5PzFcW34uIj2LsNqS69CsMXRILBBfpgRsoYcyjZeiHSrnzlblE
 a48OgeBqJij4C26jvMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270179

On Fri, Feb 27, 2026 at 07:41:22PM +0530, Vikash Garodia wrote:
> The H265 decoder line buffer size calculation for iris4 (VPU4) was
> previously reusing the iris3 formula. While this works for most
> resolutions, certain configurations require a larger buffer size on
> iris4, causing firmware errors during decode. This resolves firmware
> failures seen with specific test vectors on kaanapali (iris4), and fixes
> the following failing fluster tests
> - PICSIZE_C_Bossen_1
> - WPP_E_ericsson_MAIN_2

This reminds me of the commit fixing SC7280 support. Should SC7280 or
all VPU2.0 platforms also use separate formula?

> 
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 51 +++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
> index 9270422c16019ba658ee8813940cb9110ad030a1..a4d599c49ce9052b609b9cedf65f669ba78b5407 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
> @@ -1755,6 +1755,55 @@ static u32 hfi_vpu4x_buffer_line_vp9d(u32 frame_width, u32 frame_height, u32 _yu
>  	return lb_size + dpb_obp_size;
>  }
>  
> +static u32 hfi_vpu4x_buffer_line_h265d(u32 frame_width, u32 frame_height, bool is_opb,
> +				       u32 num_vpp_pipes)
> +{
> +	u32 num_lcu_per_pipe, fe_left_lb, se_left_lb, vsp_left_lb, top_lb, qp_size,
> +	    dpb_obp = 0, lcu_size = 16;
> +
> +	num_lcu_per_pipe = (DIV_ROUND_UP(frame_height, lcu_size) / num_vpp_pipes) +
> +			   (DIV_ROUND_UP(frame_height, lcu_size) % num_vpp_pipes);
> +
> +	fe_left_lb = ALIGN((DMA_ALIGNMENT * num_lcu_per_pipe), DMA_ALIGNMENT) *
> +				FE_LFT_CTRL_LINE_NUMBERS;
> +	fe_left_lb += ALIGN((DMA_ALIGNMENT * 2 * num_lcu_per_pipe), DMA_ALIGNMENT) *
> +				FE_LFT_DB_DATA_LINE_NUMBERS;
> +	fe_left_lb += ALIGN((DMA_ALIGNMENT * num_lcu_per_pipe), DMA_ALIGNMENT);
> +	fe_left_lb += ALIGN((DMA_ALIGNMENT * 2 * num_lcu_per_pipe), DMA_ALIGNMENT);
> +	fe_left_lb += ALIGN((DMA_ALIGNMENT * 8 * num_lcu_per_pipe), DMA_ALIGNMENT) *
> +				FE_LFT_LR_DATA_LINE_NUMBERS;
> +
> +	if (is_opb)
> +		dpb_obp = size_dpb_opb(frame_height, lcu_size) * num_vpp_pipes;
> +
> +	se_left_lb = max_t(u32, (ALIGN(frame_height, BUFFER_ALIGNMENT_16_BYTES) >> 3) *
> +				MAX_SE_NBR_CTRL_LCU16_LINE_BUFFER_SIZE,
> +				max_t(u32, (ALIGN(frame_height, BUFFER_ALIGNMENT_32_BYTES) >> 3) *
> +				MAX_SE_NBR_CTRL_LCU32_LINE_BUFFER_SIZE,
> +				(ALIGN(frame_height, BUFFER_ALIGNMENT_64_BYTES) >> 3) *
> +				MAX_SE_NBR_CTRL_LCU64_LINE_BUFFER_SIZE));
> +
> +	vsp_left_lb = ALIGN(DIV_ROUND_UP(frame_height, BUFFER_ALIGNMENT_64_BYTES) *
> +				H265_NUM_TILE_ROW, DMA_ALIGNMENT);
> +
> +	top_lb = ALIGN((DMA_ALIGNMENT * DIV_ROUND_UP(frame_width, lcu_size)), DMA_ALIGNMENT) *
> +				FE_TOP_CTRL_LINE_NUMBERS;
> +	top_lb += ALIGN(DMA_ALIGNMENT * 2 * DIV_ROUND_UP(frame_width, lcu_size), DMA_ALIGNMENT) *
> +				FE_TOP_DATA_LUMA_LINE_NUMBERS;
> +	top_lb += ALIGN(DMA_ALIGNMENT * 2 * (DIV_ROUND_UP(frame_width, lcu_size) + 1),
> +			DMA_ALIGNMENT) * FE_TOP_DATA_CHROMA_LINE_NUMBERS;
> +	top_lb += ALIGN(ALIGN(frame_width, BUFFER_ALIGNMENT_64_BYTES) * 2, DMA_ALIGNMENT);
> +	top_lb += ALIGN(ALIGN(frame_width, BUFFER_ALIGNMENT_64_BYTES) * 6, DMA_ALIGNMENT);
> +	top_lb += size_h265d_lb_vsp_top(frame_width, frame_height);
> +
> +	qp_size = size_h265d_qp(frame_width, frame_height);
> +
> +	return ((ALIGN(dpb_obp, DMA_ALIGNMENT) + ALIGN(se_left_lb, DMA_ALIGNMENT) +
> +		ALIGN(vsp_left_lb, DMA_ALIGNMENT)) * num_vpp_pipes) +
> +		ALIGN(fe_left_lb, DMA_ALIGNMENT) + ALIGN(top_lb, DMA_ALIGNMENT) +
> +		ALIGN(qp_size, DMA_ALIGNMENT);
> +}
> +
>  static u32 iris_vpu4x_dec_line_size(struct iris_inst *inst)
>  {
>  	u32 num_vpp_pipes = inst->core->iris_platform_data->num_vpp_pipe;
> @@ -1770,7 +1819,7 @@ static u32 iris_vpu4x_dec_line_size(struct iris_inst *inst)
>  	if (inst->codec == V4L2_PIX_FMT_H264)
>  		return hfi_buffer_line_h264d(width, height, is_opb, num_vpp_pipes);
>  	else if (inst->codec == V4L2_PIX_FMT_HEVC)
> -		return hfi_buffer_line_h265d(width, height, is_opb, num_vpp_pipes);
> +		return hfi_vpu4x_buffer_line_h265d(width, height, is_opb, num_vpp_pipes);
>  	else if (inst->codec == V4L2_PIX_FMT_VP9)
>  		return hfi_vpu4x_buffer_line_vp9d(width, height, out_min_count, is_opb,
>  						  num_vpp_pipes);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
