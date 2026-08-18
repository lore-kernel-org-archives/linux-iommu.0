Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24207368D50
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 04:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787028032; cv=none; b=YzLoJ0hsklWBWi5zzKO45q6+crbD85DJIHS1ADKGDrTtmkybvdQBzH1yb0SEJb43NFa1G4gegij18cX38FGfUPXBU6plFQd/Ymm6oB5fteO32XC7lic47Kd/OjEhFZqK7pJAW/Kyuydh/IDsdZbR/2LC+TsXDAhcxdegyiiGonc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787028032; c=relaxed/simple;
	bh=SkI+jLB5PybtzDBAVH3JBTwadJx+1GhjlOb0OamvgDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXACPhWPB/Z1huxYiJgRvGqQyOZgb/TQs/G8RZE+v6Dy9FYK5fDldVpdNsjtj7w0L7bN/Fg/elI7ymnTA7wgYnI1rxP0QTZo1bMTbuJqkvCpIvnbKiHIhf5W2PEENnzDoDc3WQOFEoVKvvQ3bvKbsHhxU3u+BJPsr++tOZbiw7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bZmsGspu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=USPA00gr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bZmsGspu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="USPA00gr"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLkS9I3532025
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 04:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NrzWHA3rSEs1ygei9S1vAZxJ/Pn8mnrI8++ukqsmDEA=; b=bZmsGspu7FTgZAHE
	gRBd0rBWRXtpP7UkhP9KoRFyc1yMqLpm1m7xHGcmM01K9ftPJHOXw0rweGqkv2Bp
	KZlNiULXfhiKK/ax3kHG7QDANYBAsOW+Ex5hiTRGux7/qwXwfsPb6uaj9QisHiLg
	ZIlc+4m8fRZ2wrXVEeZV6qNF1t+KRQKjhLB9T5IFbPdxmOo+cMtR4XJIrPXwyVq5
	gVwLx8g0XNw14LqnvOiGtFAhAF7kdz5GmS0DztvUapAM1PYaiGtI+mtKgqyZsEp9
	CMqva/aoq+bPOzCZrbZ0ZX3NfYqG2H1L+ecxx88lH0gjmEfPXwOU5VbH/PSJc5/J
	Gczyyw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4615jfr4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 04:40:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-385d2703b64so627817a91.1
        for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 21:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787028027; x=1787632827; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NrzWHA3rSEs1ygei9S1vAZxJ/Pn8mnrI8++ukqsmDEA=;
        b=USPA00gr5t1xOXArBGMp7j1Am/FKISCU5AV07gy67Lm8r09CAahcdrq0H5qNfkc/r5
         OU6+okRiZuZF5bmMo5Eeo1s7OWyn/EZJleEaU8tNd9hdX22PtQq7DpgUc07DD4PE4DQF
         Wy7pFSZE70PyX5aGTiz598GcioCDWz8MeCgoCZabVQmBA2nYy7oc2Kph3tcbVHDJ5DmK
         s3cZZhX7SGhlQrz+2IGsZCdaY9HrD+ZZC0eEaE5UFn6qju6MTuU1rIfkImwS/Q6YHwlW
         XRSRhwYHRN56n5q585eMa7tInn2ahbruGuaMAPXoD0QMHrzugY2kqCc3mx51eHtNCRtV
         VBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787028027; x=1787632827;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NrzWHA3rSEs1ygei9S1vAZxJ/Pn8mnrI8++ukqsmDEA=;
        b=fR1dgrpm6AH4XhZvToVoNzKlKhDUuyjXHYC/XtjvwlbR9Yb8Rmmq3iu2WtFHKAZ5Wx
         Y+HCKfMon88x5kUyGrBX77fevn35hagG2bEONp7K+4P4DmGwb3QDQibd79sUQz3ibPyp
         rSPyPHobAiTeP/AwAZB8QPCrJgQmvAuWPdbx7VUpr5q024EQ9tQSle+ojBz7TsAGLRIm
         2rC339Vg4xflnHUuaca74hbY5iy2laleqk9Q7xgwolMCLA+Dwazc9RaCLH+qQYVuFDAR
         k8xG2RBk/j8JbdQOY/Me9wASGTsIsE7j81ZXF1vZWUNWSybphF66q99WtOc9d3/oJP35
         jgEg==
X-Forwarded-Encrypted: i=1; AHgh+RrwhvUKevRS+PyGD75MVokETREB2415upZOxnvYGf1Fa6dIMWL4hndOvki1MecucUKbd5Tknw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1a/UcwIlwjh8A6gXUgdJWzIQCiVmAT2pPPjRFuDsFdF1JfT3o
	2u9lA7FdHKu/Avh26zpR7XN3E6YbsZ/G28R8mk73T8JtcuwA9CGnIEJuo9A1tq14ZLI0x+tHqGf
	j4esse4UaI6CbJUTK30NGkMO9LG6XdhoBClRPqUAkeRIAoUryYB3xk0M/Jg==
X-Gm-Gg: AR+sD11WTAbFUg+0wHrPv5Fp3e/9hr+wciIcFtcru485bGtD8WjNftr2U08sYmA53Rw
	c3tWjMagdJIlozTRl7A50qRQl1AFRmifaGVSewqH+8OUoJi5jLuzuWH593Ng55xVHXkEfEIUZR5
	eWyzd+fmGPklMBGgWdZppyvefYCC3f7WehMtNEEkvgkusg5EEArJEhwxf27GIwzvlEX+X4P/3fV
	ya7M4SMjjoH/fUR3w0dnF+NZs0VSbkh8WGGpNwqxNEF4fWa8jspD+Pwcm5qPSiCZ12B29kjQQUS
	yuxsjWwaqu47lBvQ5t2XkT+NvxYY0fQdmGoJp4TDl8P/KwSTEfu3af67YPPdICgOhZxI/AjnGQR
	lJHycblClao1r8L6+XsO/+JSeQHfJyw==
X-Received: by 2002:a17:90b:518c:b0:38f:cab0:9aa9 with SMTP id 98e67ed59e1d1-3955f17c702mr3916872a91.13.1787028027489;
        Mon, 17 Aug 2026 21:40:27 -0700 (PDT)
X-Received: by 2002:a17:90b:518c:b0:38f:cab0:9aa9 with SMTP id 98e67ed59e1d1-3955f17c702mr3916824a91.13.1787028026993;
        Mon, 17 Aug 2026 21:40:26 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267be8e35bsm11880079eec.14.2026.08.17.21.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 21:40:26 -0700 (PDT)
Message-ID: <c54f5212-809e-4517-beda-f86b375c086f@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 10:10:16 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] accel/qda: Add QUERY IOCTL and QDA UAPI header
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap
 <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling
 <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-8-69a02e9090d4@oss.qualcomm.com>
 <r7bx25akbxomzhxxyqd644efy2vc65etwcnhlyha7wm7xrt7ea@p4v5sesn5rzw>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <r7bx25akbxomzhxxyqd644efy2vc65etwcnhlyha7wm7xrt7ea@p4v5sesn5rzw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zlTPFEZXKK-x7bD51ypw3kd9HbylelPv
X-Proofpoint-ORIG-GUID: zlTPFEZXKK-x7bD51ypw3kd9HbylelPv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzMiBTYWx0ZWRfX2zSpVK6LYCEX
 DyFiVL5pJZNty4JJ2xLR3MsaTfIWIfxandG+U03UCWzhnICU4/q39az32L3vQ/L/Toi5AqpN6Iw
 4qMzYmBGghlPoPko29XWRrv6RZX332S4e5KvR36A7ZuErlSBff2xqtd/BM5WkgXDyQVVD30NX7a
 Xfgmpm6Dhp006zRT+fyphziLYlMW7XdlVtqNmBPqquXHhZoN/K6t2TSqdKOMS+PZdnPDfk9en2N
 XlxhUBQ2PRkiaB+5Pr2nED/wCG8t6b6I8/Tvv6Euecsi7ic9lTamOpXO6dcStJGkTfY9ViUXW3p
 H+sH3u6jdGjqle3lwulJtQvlXprm372WkLWDShkri6lxCUtqK474c891+cX/c4Z5PaHXoXQxYyw
 Omb8Es5Ta6jaEZfWNnYhbTlpL2CHEHvB6qQ3Nkx9zDuFzSMBWtECz4gFXK9EJ7UUBSQ2Fl+cdBy
 HQU9XN4JCc3lpDRhzGA==
X-Authority-Analysis: v=2.4 cv=Ruf16imK c=1 sm=1 tr=0 ts=6a83e23c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=GCkxi1q0J_mCzIEPFfUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzMiBTYWx0ZWRfX26Z8pbCB5v4m
 Cog2idQ4lKSDz1iL8ZGNTgRdcR3xM0dRVhBDTUOqHmpsQWw9z/iHyOiASRVuTPmwfOjVO8Dni+z
 GBrw2y0zzTOlornXa/aSDA+ushHwXjU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180032

On 17-08-2026 12:28, Dmitry Baryshkov wrote:
> On Mon, Aug 17, 2026 at 10:17:43AM +0530, Ekansh Gupta wrote:
>> Introduce DRM_IOCTL_QDA_QUERY, a query IOCTL that lets user-space
>> retrieve information about the DSP a given /dev/accel/accel* node
>> represents.
>>
>> The IOCTL takes a query_type selector as input, so it can be extended
>> to return additional parameters (capabilities, attributes) in the
>> future without adding new IOCTLs: drm_ioctl() zero-extends the argument
>> structure, so new fields can be appended to struct drm_qda_query as
>> long as they go at the end. The first supported query,
>> QDA_QUERY_DSP_NAME, returns the DSP domain name (e.g. "cdsp", "adsp").
>>
>> The UAPI header include/uapi/drm/qda_accel.h defines the command number,
>> the DRM_IOWR IOCTL definition, the query_type values, and struct
>> drm_qda_query. It follows the standard DRM UAPI conventions: fixed-width
>> types, a C++ extern "C" guard, and GPL-2.0-only WITH Linux-syscall-note
>> licensing.
>>
>> qda_ioctl_query() validates the reserved pad field, dispatches on
>> query_type, and copies the DSP name from qda_dev.dsp_name into the
>> user-supplied buffer with strscpy(). Unknown query types are rejected
>> with -EINVAL.
>>
>> qda_drv.c registers the qda_ioctls[] table with the drm_driver so the
>> DRM core dispatches DRM_IOCTL_QDA_QUERY to qda_ioctl_query().
> 
> Please tell your AI agent to stop describing patch contents. Ask it to
> describe the reasons for the change.
ack>
>>
>> Assisted-by: Claude:claude-sonnet-5
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Add a query_type input selector so the IOCTL can return different
>>   parameters in future, and switch DRM_IOR -> DRM_IOWR so the input
>>   reaches the kernel (Dmitry Baryshkov)
>> - Reject unknown query types and a non-zero pad with -EINVAL
> 
>> +
>> +/*
>> + * QDA IOCTL command numbers
>> + *
>> + * These define the command numbers for QDA-specific IOCTLs.
>> + * They are used with DRM_COMMAND_BASE to create the full IOCTL numbers.
>> + */
>> +#define DRM_QDA_QUERY		0x00
>> +
>> +/*
>> + * QDA IOCTL definitions
>> + *
>> + * These macros define the actual IOCTL numbers used by userspace applications.
>> + * They combine the command numbers with DRM_COMMAND_BASE and specify the
>> + * data structure and direction (read/write) for each IOCTL.
> 
> Is it not obvious?
will fix this.>
>> + */
>> +#define DRM_IOCTL_QDA_QUERY		DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_QUERY, \
>> +					 struct drm_qda_query)
>> +
>> +/* Query type definitions for drm_qda_query */
>> +#define QDA_QUERY_DSP_NAME	1
> 
> Why is it necessary for the userspace?
Currently the requirement is that on systems with multiple DSP domains,
each is exposed as a separate /dev/accel/accelN node, the library must
query the domain name to select the correct DSP to offload to and use
other dependencies like shell etc.
> 
>> +
>> +/**
>> + * struct drm_qda_query - Device information query structure
>> + * @query_type: Type of query (input)
>> + * @pad: Padding for 64-bit alignment (must be zero)
>> + * @dsp_name: Null-terminated name of the DSP (returned when query_type is QDA_QUERY_DSP_NAME)
>> + *
>> + * This structure is used with DRM_IOCTL_QDA_QUERY to query device attributes
>> + * based on @query_type.
>> + */
>> +struct drm_qda_query {
>> +	__u32 query_type;
>> +	__u32 pad;
> 
> What for? If you have u8 array afterwards, you don't need the padding.
I'll remove this from here and bring it later if we extend this ioctl to
support other options.>
>> +	__u8 dsp_name[16];
>> +};
>> +
>> +#if defined(__cplusplus)
>> +}
>> +#endif
>> +
>> +#endif /* __QDA_ACCEL_H__ */
>>
>> -- 
>> 2.34.1
>>
> 

