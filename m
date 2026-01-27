Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB89E2C031B
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530274; cv=none; b=dV5OEq7pmqP6o93eVJSPJOC6UViMgV5fwE0DnPUrSy6SXe0y+DDY+qJ28n5VKMso7KPrA0JXNdcI2tNlQDfh/g2jgJoYhesfqV/R1izW9GZlEKDa3Ne7xqmtavgAOLHTct1gLA4GY1Ypl/BZUEeOqjDss9YFLd9QTCrdc19rYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530274; c=relaxed/simple;
	bh=f8blZPMmP2uKNbdeWfk/2YDpCBfNTfna/PEqxzdJs3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSl6AGr5W+gRFjK/Zgeqqurm05UlNn2Z2Lrz/PDgaV07H1fPKcHFfRMw3Q0pOBvT0jZgKwKiDD3tYeHcOnz66lto2DESZ6SoFANiDzfsoNFMoj78undzkCARjbjYESizUdlvxyN8OE3H0ReJ92LNkQU1JD5mfFpoqMd808xDPwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J5aeP8Va; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vc3pnR0K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J5aeP8Va";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vc3pnR0K"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60REZwVB1066277
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 16:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8fWdIXq6Sw/irgpXGik/ORVzIn5cU1rtiyzZ63WlMT0=; b=J5aeP8VaExXP58cC
	ZynB9WGYaLfJxdLijlI7b5QxKNexdXCcZhDNEFYnvo2tRykpi1me801IlxrO3yFS
	LXUMuGJpNabSZyIlUSNQw7d9fAi3vXBEyeZfklqgRdHYSiPjibla+QTo/q4Pr4KV
	z9MH8W6J51qXQS3ZKJ6gbtvK+Tvm7LdGqNZCKdi0j/98ECN3wI7vW3nK+LAtEIWZ
	JfSemnm3M07w5wqbXn2a6vfAk9wDKWJmRSzqfJW4izXlEur/sidBYgjbYniGjgg0
	DqxVP0iX1Z86Ze5Kuu/nCZnPl5/u+FsSpQu/u8YH4EYcFuggTt83xEKcEPVysnjz
	recc+g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxy8x0c4v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 16:11:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a755a780caso42376695ad.0
        for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 08:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769530271; x=1770135071; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8fWdIXq6Sw/irgpXGik/ORVzIn5cU1rtiyzZ63WlMT0=;
        b=Vc3pnR0KzfZsyP8AI2xij5lgV8pODDxMV97prSDzPHbaAJYs+bPSHTwe2kfkEy6hg7
         wpWbLiUJeYdwZ4p8+RmBjL+zEDv+Y6QlsigMlj/hwYbMqyy9Wbdnak1b1S2lLzARSqm0
         wHl5SzkGCndXjrcxag0HhMSG+/yAM/jYor+hF/Ko4sJ7kb/ie5NGjJGcxX04zHjmarEA
         rilMeas6T8jyX1HG01oIUVFHUZIX+b8yXDtgqUq30bse6WpPep8j6oBxtApxwG/4rHI/
         3IeRoQcaiytqCKHa5icN8pzJ6UdyfRcXu/CGZrlOuJuZIADagtrIWTqwupG3effm9A2N
         DKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769530271; x=1770135071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fWdIXq6Sw/irgpXGik/ORVzIn5cU1rtiyzZ63WlMT0=;
        b=KXsupGfMMP48AJV4nULTMxRZlSaMFh6dwnnz0ixD42VYrhG7vYhYVn7eCUTUiK/OMW
         5PcC4LFSofpYGl+wCvmwoA9FGeaW9Tl2z2w06GKYMyPRpUfS7TbdWytZDSJEh+mJUuNV
         zBbsiIa9KHblUjIhjVFhrc3ERIKbzuws4rWOO4OLA/4gLNnIDOlRe3sJz1MOqpporEng
         gGvcJdJ4EVVob03jemn0n+mPosnK+5ZT+KiUaPX4EfjErQf1twCWV6e/eShBqbKrtuZ/
         LmPnHMbhm2TiLfcsLCDz0252LObPZ3p3Aj4vosCddlDaFyPbQChg8VMzW6emEiJ6r0FX
         hazw==
X-Forwarded-Encrypted: i=1; AJvYcCWQfVRMSCiM0F4HHRJs6/7jp62mjgqL3LCBqvckRL2NA+cKg3pTfQVzeJTG0HIwgKBdlDeSxw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz54IFad2Z8YYhATYfO+gjaUNdomrY7ZlWZJvaParYWJLnoQ0Y1
	XbL0ca/pHR4wD2E/2axzcqtsQ6UY8xF5rIOHmWTlBEYRyK8vJoyGpkI1jOVnhRcOIBKOzMksnDZ
	sYxmUllN4Eo+Sx7UNFHqQ8pUnASAih7mr45HFbpo4Xj6YWkv1xMW6PUsvag==
X-Gm-Gg: AZuq6aJRaXCP39a/AwLyWrTs0FRPihwyY+3HbM53MoxAwJwV6F//6fvM5Ft9UPRLNtz
	UC2rlLu23MS/TZUaCULYEv+aYGwB2hFxhs0uCRLvNR/cPclF/lOGePfamcAG/Ux+23C3zXhf1zJ
	btyURycYS/nE654U1Efa/ShIls8QDhtsClJYxtU289Jr/OCdlBSPIwck106BI9DncEUs6BYZ9aU
	l2PEEIU32jbks2JqH7UFMNWmtBBGhUGrv8EYDJjX+D27VRyr0vDWPRuDTe1tEHp3P9Voyln95we
	cc6q3JJc6InMq5zFjWkI/1Q+H7xRipOS8GwOYBMlMmV+Q87jdQvcIesAYqes1yziXLLJlQB2YVC
	rtgZTewI6CsKc7hGBgIatk37o+t+FHQT4R+gMLbrpaQU=
X-Received: by 2002:a17:902:d2cc:b0:2a7:bbe0:f01f with SMTP id d9443c01a7336-2a87120f624mr20172235ad.2.1769530271005;
        Tue, 27 Jan 2026 08:11:11 -0800 (PST)
X-Received: by 2002:a17:902:d2cc:b0:2a7:bbe0:f01f with SMTP id d9443c01a7336-2a87120f624mr20172005ad.2.1769530270363;
        Tue, 27 Jan 2026 08:11:10 -0800 (PST)
Received: from [192.168.0.171] ([49.205.248.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcd96bsm123128645ad.33.2026.01.27.08.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 08:11:09 -0800 (PST)
Message-ID: <eef542b8-2a1c-4941-8895-453a108634dd@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 21:41:01 +0530
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
 <2d4632b2-916a-4eda-ad08-44af68461dc8@oss.qualcomm.com>
 <vv4stkmrrwdqmbnpv7pg5nd4immtqo5iplwbcia3oykycfmg2m@dsithotfy5ls>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <vv4stkmrrwdqmbnpv7pg5nd4immtqo5iplwbcia3oykycfmg2m@dsithotfy5ls>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: AxGOXvP5rLj40FlIvykohZ9fG3XIlBZi
X-Authority-Analysis: v=2.4 cv=OcWVzxTY c=1 sm=1 tr=0 ts=6978e39f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=4hJEjaH6g9CgPEswoao2AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=421KuCM3en4z17v6548A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: AxGOXvP5rLj40FlIvykohZ9fG3XIlBZi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMiBTYWx0ZWRfX6YWVQfzNKr3T
 QwmuQ7dzRrgcDTEWWwDRBQpOe8iRH8Y/jDE64z6ZmDOZQMlf+u1/3RE77NCILRWGcUMopSMtKfm
 gN6QPA0FFcPrkzcg9B4dmuRd3LafTIVizff8hqlNNjo6/RjEHOinQ3rDpKLCGk/bdywSGfbDpjX
 HzXhGQvTUrxBqEeoJPYCuGcn9+Rj8Etjxcx7ev6hH+klEUcQDgZV44JYlp1fzk+v/23BSfNaSP7
 o+gC8Ki9ieIunrt5xjb7yYAm6F7S8nmBahqT2LxNCHkyTlGkJ7tqneDCfT43GavE9Z20bjA/usH
 zvsyWkqZfBWs9rmN7PHLh6lndTZiJbYvl6GTSv7BlKO0t5NZyRz7XxAaTzsxmTpK0d7Gh0W7qn/
 LubXuaID/NVw3vPUnfccaTF+M0+kwoyMtigigWa6q/UEWPRNnFZl99unE2nakT2BzixZh5emSw1
 g6FiSZXZ3pmOIJ6s0XQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270132


On 1/27/2026 5:22 PM, Dmitry Baryshkov wrote:
> On Tue, Jan 27, 2026 at 04:56:34PM +0530, Vikash Garodia wrote:
>>
>> On 1/26/2026 7:08 PM, Dmitry Baryshkov wrote:
>>> On Mon, Jan 26, 2026 at 05:55:43PM +0530, Vikash Garodia wrote:
>>>> Qualcomm kaanapali platform have a newer generation of video IP iris4.
>>>> The hardware have evolved mostly with respect to higher number of power
>>>> domains as well as multiple clock sources.
>>>>
>>>> The series extends support for multiple iommu-map entries for the same
>>>> input id. Considering iris as a client driver, it adds the handling for
>>>> multiple stream ids from VPU via iommu-map.
>>>>
>>>> This series is depend on the below series:
>>>> Link: https://lore.kernel.org/all/20260121055400.937856-1-vijayanand.jitta@oss.qualcomm.com/
>>>>
>>>> Following are the compliance and functional validation reports.
>>>
>>> Please validate with fluster too. Having a "knowingly good" command line
>>> is not a validation. It can't be reproduced by anybody else.
>>>
>>
>> Below is the fluster result on kaanapali (will add in cover letter in next
>> revision)
> 
> Nice, thanks!
> 
>>
>> H264:
>> 77/135 while testing JVT-AVC_V1 with GStreamer-H.264-V4L2-Gst1.0.JVT-AVC_V1.
> 
> What about the extension testsuites? Even if they are not supported,
> they should not crash or cause the timeouts.
> 
>> - 52 test vectors failed due to interlaced clips - not supported
> 
> Yet or completely? Does "failed" mean "returned an error" or something
> else?

completely. Driver returns error on firmware detecting the content as 
interlace.

> 
>> - 3 test vectors failed due to unsupported bitstream.
>> - 2 test vectors failed because SP_SLICE type - not supported by the
>>    hardware.
>> - 1 test vector failed due to unsupported profile
>>
>> H265:
>>   129/147 testcases passed while testing JCT-VC-HEVC_V1 with
>>   GStreamer-H.265-V4L2-Gst1.0.
>>   The failing test case:
>>   - 10 testcases failed due to unsupported 10 bit format.
> 
> MAIN10? I was actually surprised, Venus driver supported them for the
> Iris2 hardware. Is it somethething to be fixed in future?

10bit would be added in iris. We are catching up with all the codecs, 
10bit should be next from decoder side.

> 
>>   - 4 testcase failed due to unsupported resolution
> 
> Can it be fixed?
> 
>>   - 2 testcase failed due to CRC mismatch
> 
> Which means an error in the testsuite or somewhere on our side?
> 
>>   - 2 test fails due to session error (under debug)
>>     - PICSIZE_C_Bossen_1
>>     - WPP_E_ericsson_MAIN_2
>>
>> VP9:
>> 235/305 testcases passed while testing VP9-TEST-VECTORS with
>>   GStreamer-VP9-V4L2-Gst1.0.
>>   The failing test case:
>>   - 64 testcases failed due to unsupported resolution
> 
> Can it be fixed?
> 
>>   - 2 testcases failed due to unsupported format
> 
> Hmm?
> 
>>   - 1 testcase failed with CRC mismatch (fails with ref decoder as well)
> 
> Could you please raise an issue against fluster?
> 
>>   - 2 testcase failed due to unsupported resolution after sequence change
> 
> Can it be fixed?
> 
>>   - 1 testcase failed due to unsupported stream
> 
> ?
> 
>>
>>>> gstreamer test:
>>>> Decoders validated with below commands, codec specific:
>>>> gst-launch-1.0 multifilesrc location=<input_file.h264> stop-index=0 !
>>>> parsebin ! v4l2h264dec ! video/x-raw ! videoconvert dither=none !
>>>> video/x-raw,format=I420 ! filesink location=<output_file.yuv>
>>>
>>> Neither of these commands specify, what exactly was validated. They
>>> specify that you've validated _some_ videos. It's impossible to even
>>> reproduce your results, because you don't specify which files you've
>>> used.
>>>
>>
>> commands are shared indicating the pipeline used for validation for
>> different codec plugins. These are some basic encode and decode commands,
>> and shared for reference for anyone to pick input test files of their own.
> 
> Thanks, but it would also be helpful if you stated, which filesets were
> used for validation. There are enough public filesets for testing video
> decoders.

Ack, will add that info in the cover letter in next revision.

>>
>>>>
>>>> gst-launch-1.0 multifilesrc location=<input_file.hevc> stop-index=0 !
>>>> parsebin ! v4l2h265dec ! video/x-raw ! videoconvert dither=none !
>>>> video/x-raw,format=I420 ! filesink location=<output_file.yuv>
>>>>
>>>> gst-launch-1.0 filesrc location=<input_file.webm> stop-index=0 !
>>>> parsebin ! vp9dec ! video/x-raw ! videoconvert dither=none !
>>>> video/x-raw,format=I420 ! filesink location=<output_file.yuv>
>>>>
>>>> Encoders validated with below commands:
>>>> gst-launch-1.0 -v filesrc location=<input_file.yuv> ! rawvideoparse
>>>> format=nv12 width=<width> height=<height> framerate=30/1 ! v4l2h264enc
>>>> capture-io-mode=4 output-io-mode=4 ! filesink sync=true
>>>> location=<output_file.h264>
>>>
>>> At least these should use test sinks in order to be reproducible.
>>
>> it is using filesink in the pipeline to generate the encoded bitstream
> 
> I should have been more explicit: test sinks to generate the image.
> 

If you could suggest a gst pipeline for it, i can give it a try.

Regards,
Vikash

