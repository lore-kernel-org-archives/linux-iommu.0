Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27530346AD4
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769513209; cv=none; b=IQ3wAGilQbHea0xWgLvWYpjOn53vO8LTiLJdSn0tEDY2SFTnWyQteP8+mYu80asy4On7dQva59NC7/DaPrxzB57A2lmYxoLfKVAfwEplJa1OfaQqk/wWSYe4PPS2r1boNjiXxviEduDiUhNSfK9Jz/ac7H+MmsUs1fFzNDFsemo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769513209; c=relaxed/simple;
	bh=rgrYVjGNcBcrE9oeJPVBno8Lt/YAMWDEC79bWmIJR6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bu+BS9clDWaiWIESdtFSB/up7RyIKM8Cc+6iIDTbPMbwyQqIocs5xNcy/ENW5mRdPxjrPVjB0BrmWJ24e+Db6UvR+eRt8pkSOY9GQe8KJMisbe1MZP6TiD/vaS3BMuG10kXJYUlIQ93EJU8mVo0+CpcoHJ/qdRCAF46N9qs881Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZKmmWLW+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gp594kL5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZKmmWLW+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gp594kL5"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RAxfB23714712
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 11:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SSFWjKOmQdvYxWzHnlfk96Wt+02KeMlBMvjq2MCYtWk=; b=ZKmmWLW+NjXvcmhH
	688u6kvG4+P2ig6wsUHMtpXzyAYd+dDw7fSYg2tBmQMIrGMbhGajrP4FdxHF30cR
	Eib6w7hTc9Hr01MGu5Yv5GfduqH7rearqrcbPy3v6I5LuxQRECi54Qpl1/dgtkC5
	qPsVWXC5CqWBfpgTHT4+hsd0HauKRGVX+W2vMEC5q2F+r8enxgN4k5bZ+8Hk4bJn
	8DGJ0TCnAFLIy1PDyWNcVE8H3V09DSJ/1jG12Do6QI4CPBk17UoX6Juxb08pIdg1
	0OtOigvPzvk6u8b+fw7mw/tX9htYRPAgWtpL+8j5O0OHl9GSjXjW0EvvBalPQUUD
	M6vi+g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxdv0aspq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 11:26:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a863be8508so25972715ad.2
        for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 03:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769513206; x=1770118006; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SSFWjKOmQdvYxWzHnlfk96Wt+02KeMlBMvjq2MCYtWk=;
        b=Gp594kL525pjtBC7w8IAW8OFqrT2cTyQOQ303vMoSe4Y0Jvp0/JHwI0QWDtitAU2m/
         uWJN4wAMgEqDyw6TZJHvxE9PcE2eiix8lOxSB6iEzFDEYRFW2GGkXjTP0RNw0yzp3LVx
         A5KI/jWrJEnHpH+Ct9pFlqno1DE62nrkWKGm5cd2GnISruSBYEw2GSPY0QmCydF+xPCN
         dMuCjbWwANXcw5LX7LbOFp4u0atuQuD2jeQ4KEcdr1z0kO3gSw5i//nVLo4NQeBCQ2Qp
         zeFPAeZ8WUdymWoJY4nm0miZC/XkQ/ek2DmaX/xe78/OJ8UtsYyWH+maZxFLAjRFiWXI
         iRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769513206; x=1770118006;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSFWjKOmQdvYxWzHnlfk96Wt+02KeMlBMvjq2MCYtWk=;
        b=VgCV7pldCSGMGmbp0FTm6WoYGysN1Y1RMOzEl76n7+cwbLAeA5iwQ2CtTfaF1p2M78
         0sn8XoyeZ5gXL1bZ0+VZBqrWDbwZF6CWiycU/0BlupOwZeGV03mye4gAgdAARNIzgDsG
         mvNZTOyciIq594j8PhFHLAt/eV1C/M5roUbTdeFmSabjNOcUFQlwyJB3bzLpaWJyCt3c
         /J3U/gFXzGmZZSppcOrajc7IAco47c5i/S7gxqKYYqRFeCFOW6KuyOS4qPp50DtNjK58
         ZBGRkho6r1VfdEc2tD/VgCqbFobzaADtDwy3H3lL6Qy8pvl1BB737VRN94XCqV3KCVYV
         htaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNGQuShypt5jCGa3TeA3kj8pNx6Z8AeqpE3aXR54+ESYVCLRlDl/exe0xVYQ2a6zB9w2i65g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3OvSMCVyjskpUDH2Z0h1bF1M9FRI3Jg7yQA8gA+5bxpLoOBQi
	smgIqE7HtzjccvXs5E/O1XhqgkomBCSoMNQae0rmqWKJtTEHr5Uox+BjRwbLG4DWtcTY5QWik7i
	+YXfFelEnkO+Kz1Ir06tzmtsXH2sG6j2vfOnzGeKh+KVWvm+VmAuLxNCnbw==
X-Gm-Gg: AZuq6aLzhEVzIn6evdjutYMh/+s2XtLWN2ASx/cv0KrHqZNSXoTPnHn+D+uUoPRqt3o
	m15YNOejhVQ2WEZWYvkDTZrj14aND1SUNpM64m3yZuU3gzsrHVe5piYYZGTFL4bHrqHGlHjjHxI
	RxP5vFoEv94aFmtqFO9lcuewhVne9AMV3vN1wagTATunv7BVh/PN4Z/yXyGnOQ/mPPp5VQgRpUS
	Z+UqEqFXXjQ1oFcKF3u11bitOx/9HnZeaEaoXmCgdeTq3nAaqvrUfi2Euv7FVAX15RrnRdnrcZt
	DV5wLeqRvPaJ1IJjwFbxYeEEgcdcNFL+WDQqiKHFQBN4UGNRYg9erCE7PsfD/ZT5rj3B5N5Taa7
	JOGv4sUq+zRBUYOnSAB8JBtRdQrJTnlJYcrF/YFdDew==
X-Received: by 2002:a17:902:e811:b0:2a7:c21e:398d with SMTP id d9443c01a7336-2a870e34ab9mr15009045ad.32.1769513205785;
        Tue, 27 Jan 2026 03:26:45 -0800 (PST)
X-Received: by 2002:a17:902:e811:b0:2a7:c21e:398d with SMTP id d9443c01a7336-2a870e34ab9mr15008695ad.32.1769513205241;
        Tue, 27 Jan 2026 03:26:45 -0800 (PST)
Received: from [10.206.101.19] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802fb063esm113820875ad.85.2026.01.27.03.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 03:26:44 -0800 (PST)
Message-ID: <2d4632b2-916a-4eda-ad08-44af68461dc8@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 16:56:34 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] media: iris: add support for kaanapali platform
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
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <lpgw6eodclsvfwgvtljfiorvjkpd5vd27yhxs7i3ijfibaqzuk@bak2lwbyh77f>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <lpgw6eodclsvfwgvtljfiorvjkpd5vd27yhxs7i3ijfibaqzuk@bak2lwbyh77f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ux10KgL-iDnV-Uku2wMpEdEeM-2prQp0
X-Authority-Analysis: v=2.4 cv=SvedKfO0 c=1 sm=1 tr=0 ts=6978a0f7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=IkwSlwTgAPm3BNmR4DcA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: ux10KgL-iDnV-Uku2wMpEdEeM-2prQp0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA5MyBTYWx0ZWRfXxa5FJC2UYetW
 Boqa9iJk9W+aa484Ilma8JBmqvDDG3e+nWssGDc9H/MHN4uzLIphydVRsEKcpO8DMTyn3to60bw
 XzAoIuIl/jZW2WSGiY8JZ4pTO7BEJ7on8SUV9i3OvyFGtBczvprymKNnK6Oax7ysAGsrY013N8N
 u9wPxqO9zGS/+tAvJrvAlEb13uWOhM2U1hIiS1nay9mn60iI56UymVwGqapcN62geNbACGDiQFm
 Y6yrY/97NohhuHquswdrMoLySYpJCRl1+X1I1cTnZ7bNTEv3wPZ8hCGPCk9Ez11jwZcmnGIrMHo
 W7deBSrti8H1H54lIpVXnLf2riUMuhh/wDCSrQU64zeTGaeTJqjEOgtnOPQf1u70Q+WYlNuDXaf
 szophNRf0V4pEJbxkUZlZscveDY381UMqP6FD0c9E3kjgU9SY7kdOBrkvTRHpma9Rcnc0Vj/tie
 fyCJdiAFPQFcjHTBJug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270093


On 1/26/2026 7:08 PM, Dmitry Baryshkov wrote:
> On Mon, Jan 26, 2026 at 05:55:43PM +0530, Vikash Garodia wrote:
>> Qualcomm kaanapali platform have a newer generation of video IP iris4.
>> The hardware have evolved mostly with respect to higher number of power
>> domains as well as multiple clock sources.
>>
>> The series extends support for multiple iommu-map entries for the same
>> input id. Considering iris as a client driver, it adds the handling for
>> multiple stream ids from VPU via iommu-map.
>>
>> This series is depend on the below series:
>> Link: https://lore.kernel.org/all/20260121055400.937856-1-vijayanand.jitta@oss.qualcomm.com/
>>
>> Following are the compliance and functional validation reports.
> 
> Please validate with fluster too. Having a "knowingly good" command line
> is not a validation. It can't be reproduced by anybody else.
> 

Below is the fluster result on kaanapali (will add in cover letter in 
next revision)

H264:
77/135 while testing JVT-AVC_V1 with GStreamer-H.264-V4L2-Gst1.0.JVT-AVC_V1.
- 52 test vectors failed due to interlaced clips - not supported
- 3 test vectors failed due to unsupported bitstream.
- 2 test vectors failed because SP_SLICE type - not supported by the
   hardware.
- 1 test vector failed due to unsupported profile

H265:
  129/147 testcases passed while testing JCT-VC-HEVC_V1 with
  GStreamer-H.265-V4L2-Gst1.0.
  The failing test case:
  - 10 testcases failed due to unsupported 10 bit format.
  - 4 testcase failed due to unsupported resolution
  - 2 testcase failed due to CRC mismatch
  - 2 test fails due to session error (under debug)
    - PICSIZE_C_Bossen_1
    - WPP_E_ericsson_MAIN_2

VP9:
235/305 testcases passed while testing VP9-TEST-VECTORS with
  GStreamer-VP9-V4L2-Gst1.0.
  The failing test case:
  - 64 testcases failed due to unsupported resolution
  - 2 testcases failed due to unsupported format
  - 1 testcase failed with CRC mismatch (fails with ref decoder as well)
  - 2 testcase failed due to unsupported resolution after sequence change
  - 1 testcase failed due to unsupported stream

>> gstreamer test:
>> Decoders validated with below commands, codec specific:
>> gst-launch-1.0 multifilesrc location=<input_file.h264> stop-index=0 !
>> parsebin ! v4l2h264dec ! video/x-raw ! videoconvert dither=none !
>> video/x-raw,format=I420 ! filesink location=<output_file.yuv>
> 
> Neither of these commands specify, what exactly was validated. They
> specify that you've validated _some_ videos. It's impossible to even
> reproduce your results, because you don't specify which files you've
> used.
> 

commands are shared indicating the pipeline used for validation for 
different codec plugins. These are some basic encode and decode 
commands, and shared for reference for anyone to pick input test files 
of their own.

>>
>> gst-launch-1.0 multifilesrc location=<input_file.hevc> stop-index=0 !
>> parsebin ! v4l2h265dec ! video/x-raw ! videoconvert dither=none !
>> video/x-raw,format=I420 ! filesink location=<output_file.yuv>
>>
>> gst-launch-1.0 filesrc location=<input_file.webm> stop-index=0 !
>> parsebin ! vp9dec ! video/x-raw ! videoconvert dither=none !
>> video/x-raw,format=I420 ! filesink location=<output_file.yuv>
>>
>> Encoders validated with below commands:
>> gst-launch-1.0 -v filesrc location=<input_file.yuv> ! rawvideoparse
>> format=nv12 width=<width> height=<height> framerate=30/1 ! v4l2h264enc
>> capture-io-mode=4 output-io-mode=4 ! filesink sync=true
>> location=<output_file.h264>
> 
> At least these should use test sinks in order to be reproducible.

it is using filesink in the pipeline to generate the encoded bitstream

Regards,
Vikash
