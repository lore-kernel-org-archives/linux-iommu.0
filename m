Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE053CD8BB
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772576852; cv=none; b=mIngSPAm3jq4TsEsxDvCUXmsMROBnTdkHjdDcv83qnrAYhVgQUK5O3ggMNU/VElWY6CgvfOonrSjZfOBHzni4t1Nq+qAJUmti9WXDJdY7bfLR+MMaGIQkvywVwIzyIWHwR9PhVilfEuqXfGCe8RtN+/4qTAwpAWeOgSonc+6gSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772576852; c=relaxed/simple;
	bh=kUiCMni+mSdLNaS6+bi0vffQF5/T2BCKuXPlaqtnkqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXvqcL507FedpmtBuXi1xfBQhHbUrAKHhHuBKF2jGC72GOFXUIUzb50C4qwee4+U9kncuIN+1BeaUA5vzAQmDJMKJxuNon4lzK2luz5Tb+1rrjaqz6Gl+9Z2ac9RUOiMq0HQ/VvYmnFtRD0alqaMKm7V5BbJk0+bpG/thI/5LSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ngFWalpq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J7oC/97f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ngFWalpq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J7oC/97f"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623H1GZt728310
	for <iommu@lists.linux.dev>; Tue, 3 Mar 2026 22:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4bi3Gp9rCUijoG+XiXSdtsQm
	sC243pZHx3H6hSlT6Fc=; b=ngFWalpqxSqsS2O+cgHy4sQEJZGw4Fi/0d0BMu0Y
	cl9Ou5OC/9fkTkhvZVVBHH+LWrK6IEpgjLBZ2JawUHh6ORX00lmz3xbXnWkZaSAN
	pWMIFbhBHCrj3Rd0kikypUn++uKeawwED0b2ZNExX6TEpImWS3JJpG+OxVbBpSaK
	3PA9iiKTzswecDjbtFucrx9eVYGqIHXCLwLnNbfAawbebq+A+mQKnPsEFCPyGvBG
	AG/4Jge8vZJOV51k05Rq+Wk6XFg8cUsYG/xAjc2NiddPN5gVmKe45jeEh3M7VV1t
	EjMq3gg3qNQAtAS5Krt0ZDm4nEch7QJELLcKBYUX2m+mUw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cns5fud8v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 22:27:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-504888a2a1dso457186071cf.0
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 14:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772576849; x=1773181649; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bi3Gp9rCUijoG+XiXSdtsQmsC243pZHx3H6hSlT6Fc=;
        b=J7oC/97fxWtPPKztVQfY8keI++SqB+KkBn+7863G7uUc+ZgbdotO3b13Ipi2DioEmg
         pDDjnJbDK8OXjW5JTYgldC1kLOU5B24eNhQyUnjPLLx6EOk7dt47e1dT5SgIRD9p4J2S
         cbHqxOaffA5r09GzKNWbzdcihzy1THKT24XJoRJdWdTpf2LzC+0SYWugTNT4XTwJmgXI
         arnHNdxoCw+3/bQmTrl+QpeS7reNO81x1cNN5tAYgeXt7uKq7b15oRKn3Hl12XcPBFVv
         Ub3KGC+nnOK5sFb+R6Jmn+om+5+6959npO9qzsy7zsasAlgOoLCNuyfYfnHVCy068j16
         z2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772576849; x=1773181649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bi3Gp9rCUijoG+XiXSdtsQmsC243pZHx3H6hSlT6Fc=;
        b=AhrISr5dlgPFDXGmr/b1iLR4fskOBMbnk+AMq9RKXtu4QuyaAuih1hDgDTHygt6ef8
         RP0VWpoNHxrnFAj54C07ZaW2kJtwK6u4OwgjDpT5wRdKhTJWIam7PQQqqXfkKZE1k2D0
         AvAQUvGrO+hKYXRuT8vjrcmiBm7Pvsm10OCd4jQg3OJXlm1utE0KhDxQSdNfRnCd62RO
         rxw0W2ULQ0OnAKmrEzPi8td8wWK/Yq2aoHt1Atc9ofnAWSMHlZjUhWbDnfzOSYWzfsYV
         P+EfOfpqOsXU+K3w4Bwi1T6gk8R9DpRHsyjT2zff6RoOCQfSu36TjMBjZYN2dzfociZ3
         +MUg==
X-Forwarded-Encrypted: i=1; AJvYcCUGfjmWoptKL+/SO/q2XB9K2O4CyFTSHHZcXnWPYxxikVVNba04yejHkwWM0yjTqWmj4O2s1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzC3QA2HO26d5XEgOAmlfLFROTG9JoYuqMCcZE5whZlC+a6F2oc
	3aDhu6SPYLfOAkog22TmZkfsqvFPiHayVZlYXHasBhioqfJXfQOIbua2+OC5c87yfOIhfH0ihQv
	M4Pu+scOX6nlILa9vmuYBupePQdXYQ7RJGpNG94GzQD1BEMBwotmBqZj2ZA==
X-Gm-Gg: ATEYQzweDeomxbCiJsddGM7HCpXYFcTVpKrJcR3yHC6Iev455ZUZ4xKZNHG5gGVtuhE
	24wfdwS2XnosKF/l0RWqDxDI4x1u+pzDnrZDyrKrMAd9VqQ0/3+DOXj1h7sxHh0PwUKtVHABszr
	AgSOyB/HDJBduo19ouEiSuOfnTR5yQj70aAlTRzcJ+KKlie9wXM+DNtkxQFn8cdLoHacTaKCqo3
	pBJmTB0IFzQA9E5A6kktbzxGojADkGz+nzr4y/+Jb2mPEh1OQgGRD84zHZeGNrJ9wSOrKQKwjtN
	5PA8kfGzyeKr+j4ujl9sDJ8HXQ8PisRHiHZnekeTZbNTMX3sU9IHDLeCO5vzXAxazXNe3P86uKQ
	fd8oMJ+JgDc0KLk25DpnTZTDQWo7rEoA1snCjG8rVhrL61squAfmtorPF9XhzZHQJtgc7COhvRT
	dsO/sIljy9GDDBV6kuGyRx1WhffJfihZXjlec=
X-Received: by 2002:a05:620a:1a1f:b0:8ca:305b:749b with SMTP id af79cd13be357-8cbc8f3626bmr2244611085a.60.1772576849164;
        Tue, 03 Mar 2026 14:27:29 -0800 (PST)
X-Received: by 2002:a05:620a:1a1f:b0:8ca:305b:749b with SMTP id af79cd13be357-8cbc8f3626bmr2244606585a.60.1772576848655;
        Tue, 03 Mar 2026 14:27:28 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a12357d2f5sm869131e87.39.2026.03.03.14.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 14:27:27 -0800 (PST)
Date: Wed, 4 Mar 2026 00:27:26 +0200
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
Subject: Re: [PATCH v2 5/7] media: iris: add helper to select context bank
 device
Message-ID: <jgygscmwovezkytizhh54cmmu5etgv23bgopfqrql3qj7zlhxh@adxo2b7izlrc>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-5-850043ac3933@oss.qualcomm.com>
 <bi3i37ho3ppzlgdx264ohxpcem3nwumjelzckf4x5uzdj5rt7a@2y2jrilmfimj>
 <1dc86b00-9a18-482c-94b1-96692c1dd530@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dc86b00-9a18-482c-94b1-96692c1dd530@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Pv2ergM3 c=1 sm=1 tr=0 ts=69a76052 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=I8bSfGjBC853jA9yTMYA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: tXu_WxxuOwi5_xfOHUMHWrDXPVaNJ5MU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE4NSBTYWx0ZWRfX0K6InRwKl9ol
 +hvmbSQ8JQdRPDA4Pzu6MViJvfCDYrM+1BkH9J8Ys4QK0n28k0+K7Q0LK9Q/6Qt7FN3D8nLPxg8
 tV6oxkNtStqLAfofuGnH4KCUibseJksXVQo0bDCenmCMs1g/fjrgmrk757UmXZCmmg0AXjWWuov
 S4X2/dhijR7hrHuHo7uA3G4ginLOcauAhWiKXhcJx7ZXG5Luo9xpOsmR7QEKSTbw4Wl0/O9B0I+
 WgqdVzxAHQgkrvZPPab96eFBvjnbS0alUo5T57OKgFZ+cuPdrzPllCnMXmr7xvPmljBzSnX+h1u
 39o0t/BV2j3SkAnHyIIhqJmdhy0GLG4U/Vv3r3hbVJ0Y1VE7kSUqF0GMX64X99fWUmmdZg2JKoE
 flvd7EDiktUesXNZfyKrQWdaScCTPHQS94A4n2kz4ptA8ZQ4djcQQv/xTSeeosbC62xATTYtOKG
 X1GuOf+rK2Ke9A8rJTw==
X-Proofpoint-GUID: tXu_WxxuOwi5_xfOHUMHWrDXPVaNJ5MU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030185

On Wed, Mar 04, 2026 at 12:46:27AM +0530, Vikash Garodia wrote:
> 
> 
> On 2/28/2026 1:57 AM, Dmitry Baryshkov wrote:
> > On Fri, Feb 27, 2026 at 07:41:21PM +0530, Vikash Garodia wrote:
> > > Depending on the buffer type (input, output, internal and interface
> > > queues), associated context bank is selected, if available. Fallback to
> > > parent device for backward compatibility.
> > > 
> > > Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> > > Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> > > ---
> > >   drivers/media/platform/qcom/iris/iris_buffer.c    |  7 +--
> > >   drivers/media/platform/qcom/iris/iris_buffer.h    |  2 +
> > >   drivers/media/platform/qcom/iris/iris_hfi_queue.c | 16 +++---
> > >   drivers/media/platform/qcom/iris/iris_resources.c | 60 +++++++++++++++++++++++
> > >   drivers/media/platform/qcom/iris/iris_resources.h |  2 +
> > >   drivers/media/platform/qcom/iris/iris_vidc.c      |  4 +-
> > >   6 files changed, 79 insertions(+), 12 deletions(-)
> > > 
> > > @@ -177,3 +178,62 @@ int iris_create_child_device_and_map(struct iris_core *core, struct iris_context
> > >   	return 0;
> > >   }
> > > +
> > > +static enum iris_buffer_region iris_get_region(struct iris_inst *inst,
> > > +					       enum iris_buffer_type buffer_type)
> > > +{
> > > +	switch (buffer_type) {
> > > +	case BUF_INPUT:
> > > +		if (inst && inst->domain == ENCODER)
> > 
> > Can inst be NULL here?
> 
> during queues init/deinit, instances are not created.

Is this function being called during queues init?

> 
> > 
> > > +			return IRIS_PIXEL_REGION;
> > > +		else if (inst && inst->domain == DECODER)
> > > +			return IRIS_BITSTREAM_REGION;
> > 
> > Are there any other possibilities than encoder and decoder?
> 
> will simplify it as
> 
> if (inst) {
>     if (inst->domain == ENCODER)
>         return IRIS_PIXEL_REGION;
>     else
>         return IRIS_BITSTREAM_REGION;
> }
> > 
> > > +		break;
> > > +	case BUF_OUTPUT:
> > > +		if (inst && inst->domain == ENCODER)
> > > +			return IRIS_BITSTREAM_REGION;
> > > +		else if (inst && inst->domain == DECODER)
> > > +			return IRIS_PIXEL_REGION;
> > > +		break;
> > > +	case BUF_BIN:
> > > +		return IRIS_BITSTREAM_REGION;
> > > +	case BUF_DPB:
> > > +	case BUF_PARTIAL:
> > > +	case BUF_SCRATCH_2:
> > > +	case BUF_VPSS:
> > > +		return IRIS_PIXEL_REGION;
> > > +	case BUF_ARP:
> > > +	case BUF_COMV:
> > > +	case BUF_HFI_QUEUE:
> > > +	case BUF_LINE:
> > > +	case BUF_NON_COMV:
> > > +	case BUF_PERSIST:
> > > +		return IRIS_NON_PIXEL_REGION;
> > > +	default:
> > > +		return 0;
> > 
> > dev_err(dev, "unsupported buffer type %x\n", buffer_type)
> > return -EINVAL;
> 
> these are bit fields, returning -EINVAL would still match some bits and can
> make the logic as true. 0 can be defined as IRIS_UNKNOWN_REGION

Yes, sounds good.

> 
> > 
> > > +	}
> > > +
> > > +	return 0;
> > 
> > Drop
> > 
> 
> Ack
> 
> > > +}
> > > +
> > > +struct device *iris_get_cb_dev(struct iris_core *core, struct iris_inst *inst,
> > > +			       enum iris_buffer_type buffer_type)
> > > +{
> > > +	enum iris_buffer_region region;
> > > +	struct device *dev = NULL;
> > > +	int i;
> > > +
> > > +	region = iris_get_region(inst, buffer_type);
> > > +
> > > +	for (i = 0; i < core->iris_platform_data->cb_data_size; i++) {
> > > +		if (core->iris_platform_data->cb_data[i].region & region) {
> > > +			dev = core->iris_platform_data->cb_data[i].dev;
> > > +			break;
> > > +		}
> > 
> > You really seem to overcomplicate things. Replace array search with the
> > indexed array access. Much easier and much better.
> > 
> > enum iris_buffer_region {
> > 	IRIS_PIXEL_REGION,
> > 	IRIS_BITSTREAM_REGION,
> > 	IRIS_NON_PIXEL_REGION,
> > 	// add more when necessary
> > 	IRIS_NUM_REGIONS,
> > };
> > 
> > struct iris_core {
> > 	struct iris_cb_device cb_devices[IRIS_NUM_REGIONS];
> > };
> > 
> > region = iris_get_region(inst, buffer_type);
> > dev = core->cb_devices[region];
> 
> all the regions may/may not be present in all SOC

You can check for dev != NULL afterwards.


-- 
With best wishes
Dmitry
