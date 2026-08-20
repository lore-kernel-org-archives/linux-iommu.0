Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A143587A2
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 04:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787199176; cv=none; b=bxa/dXp3iO1sXsZ5BG8Sb/+cNaxr2mMY25A7TIbkD7V66dMBbpdAvlzddJ4QDctxj7vvWIRmc8fSsZrx6vXOq0WddSjiGdUdQyECCh0DHhAQ/qGhCGsWC5yKaINzwIcCAzvYVNLMe0drnawijga0FzSOm8gh0J5q9T6awRP2YA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787199176; c=relaxed/simple;
	bh=gl53nmErgxNHnBhywqBf9y2uMEPF2VoEaOuh6BLQ358=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEjA15GJ3bs8L0wDTKi/jpF6pCqoCTJSR/oHQJda9h28wKSqivj2PEW+AGw2F46Q+ZvcLkRylD17UBtnCA6wXsX0FyD8u+zazmC8cH10VBvmUURUkYZSL/CAZHq9NblzoRqNpZ9ES5Wtf3g82Ol+CJNMrqlBun/qy71P0lKzpZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cQgR9plk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IRq2h98Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cQgR9plk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IRq2h98Y"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JL7jMC490799
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 04:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/So9S1KEAt5OvNBUFCqjrX+Y7R9w32tufku2nOhCX44=; b=cQgR9plkA7XTyz/x
	f5xmgIfOnuBZAITDNXw+tp/xBCL7i5h3742aucSTz67ITEQ5pVQ4x7GlZpopD2ue
	rY6S3YtJIkGI9E/vThBosMqht2uFYyF837f3tVULItgVkoDUAR4R/YQldZsRAjg3
	fNaOBmcvmBuf6ZuxwMGJ/QzhHI4ZGfz/CFL3VoPXESuTblDWtaU8xQZqY+MwjT7N
	gkKkqZjnUPBQTz4IzGUHtUIou0iJ/Ri9cQnXU4Zfprgw0zQTIeKiQd2Wh7MtWuPy
	jL9pNN24O70HUA93grBVhLfx8C/OrP2WvJllP7HItMIgTiQsRHL70lboMin87WeN
	V8s10A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5ervk3pn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 04:12:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc640dfde3so20634325ad.1
        for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 21:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787199173; x=1787803973; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/So9S1KEAt5OvNBUFCqjrX+Y7R9w32tufku2nOhCX44=;
        b=IRq2h98YcI6qAV+vibUTw7+SJ1YEyenJY+D2wDpJftsBbrO65tiESB0r09+l+6o6hW
         doUGLAjUch2w54nVC73pQCem0ew8ULL3MPkTMXseWG2ZmzMExaXB/q+1ZVaw4fh9i/T9
         8wIYRJdgZfhKO9Q6kQxQaTt5cDHRG96gEfquXmnWeh9VZz8VCvRhagtK62ObBrxj5RwD
         WAQwEETO+GyGRHA/TS6NOf4gZU1/0AM71tUTzR3aYfnOzAH2TgfTChtfI8q2KQPLW3/d
         2eVx+WbsB7LmGkvyFvtPGeITP7wwXyOSLtM2ahU6aD7AJxsGMpPmGwgQHD4J89Zhw/1k
         isog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787199173; x=1787803973;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/So9S1KEAt5OvNBUFCqjrX+Y7R9w32tufku2nOhCX44=;
        b=qMipFsBHcTqeA8Wp8cIOxBx9nGfcTnIRmZCSmfl9c4MvNysCqiK2aaeU+/uDXDnioQ
         e05G0a2N4YDCRtbYp7Z0qSEKeEpkAUsgSlf8DUKLUwTC1dJXyZf48USuPnRRxusPJu2a
         nD7UYHDuQSt2QhWHOoIkLXDodH3g1y0viuypMd7aEd6lwJ6W8+QDH+Sjimsc/AJqw2d5
         hitfAlClMBpAHJpkZJpQJ4L8JUN0Q7U75Wc0bRkhbfSC+9U7BM3hzKdZ68A0hhGmPq8R
         6LLSt8rArAtYcc08oQUYpr7hB/jsqwDmRR9OJoqoU4K2ifNqhDtoConaAc4rkckIvHc5
         Gv6w==
X-Forwarded-Encrypted: i=1; AHgh+Rp/EdDbBxXGRQzrb0kR7xtxLCFKidg+lBwI3WzO7L2ThJXiJR0wK/b491NDdHzUL3WUpZ+VBQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lgf7Rasi8rPIyFlYV8Qkx3NeL62cu5NIospb5dHCnW4XSDm8ON
	UpsPEwUTCOPLRstxGy979IKajVeFq8sgCc93guXsBzVEBvc9MkXfND8UDyhzGSGvzqzpWhSvGsL
	qX5CwPxMzzRGEIa8Le3ZeLRGM887J3gAeu9R25pCbtRcsvjG1NMBQvPgTaw==
X-Gm-Gg: AR+sD10Cam02qkDL/tcm1jvVpYzUhDJ9JeqRDZ16gsbEm9CVQeHwgsfY6szzGEhvlEM
	x4WrGokW3V9vWBPLY4HUEwnE8qmnEh9q08NQC3XJN5FJu3vgJ0GbQbZrh1TjTKP3wKs5aEpZV+e
	hPGj8uOUYpNuJGK0NL1kHaSX6c2M2SHelQW/K2xbNWQFErHRfY0b8wbRKlZAAda3Jf3bHkSvRT+
	gJeq6tXsxofJUXX9SfRqXFUayaDWN0mDVLQ15scHHrJA0OymgyWhsn2fqk0hknA5nqiQJIDcUNK
	QqtOb9bbyB+dEEdJuiVdpHdhASbtpe/rom/K6ucJiLO/XKTYk4cOGFk+qFBk2hufululHezXWrP
	O7pDM0nhC0oCc2iTdBDUPCca2iVaJjw==
X-Received: by 2002:a17:90b:5385:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-395812a872dmr18290527a91.5.1787199172841;
        Wed, 19 Aug 2026 21:12:52 -0700 (PDT)
X-Received: by 2002:a17:90b:5385:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-395812a872dmr18290423a91.5.1787199172352;
        Wed, 19 Aug 2026 21:12:52 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf15ff5dsm11842356eec.25.2026.08.19.21.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 21:12:51 -0700 (PDT)
Message-ID: <4f11dfb3-9d92-450f-97e7-f04404c63250@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 09:42:41 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] MAINTAINERS: Add entry for Qualcomm DSP
 Accelerator (QDA) driver
To: Krzysztof Kozlowski <krzk@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
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
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-1-69a02e9090d4@oss.qualcomm.com>
 <cc43a545-20a1-4f15-a7b9-ca48842bffca@kernel.org>
 <e0a25f11-5c7c-406f-a223-da29bf6e1401@oss.qualcomm.com>
 <f725955b-27aa-4b20-8a4b-84906782b921@kernel.org>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <f725955b-27aa-4b20-8a4b-84906782b921@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3gYcjQJR-wjmO1ETt0is6BxVHV8mZIDH
X-Authority-Analysis: v=2.4 cv=VZ3H+lp9 c=1 sm=1 tr=0 ts=6a867ec5 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=4Unm9NrEEcootba8-QIA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAyNyBTYWx0ZWRfX7ybal+sc6sGp
 UGK+i1ga0blLSbPn+PLd5vTor7/8EXRjHoEDvfiNkvGM8n5ILrKCpTCUgDG4J6/uj2aJ4JFKm9z
 pv0JqX+zLhNXJUICXS/EaDO06+wAw9B0NPsW+9w9jjAIaukUZ0Iml8d/PrN8j2G1OrH1ggCteQs
 p1f0AYpFgq9pJPUPYhw9il5vzSUX1Blq4ojtPC6cXBC4cLuXaGzrMbK3rooEWIOitwXeWxh/FyJ
 wKAzzgFWw78UvPoZbOiVNQDPH7s7F9CeEbwS8hfJA9/hA1Eia1YEzFMeJ2Ds+bM8Bmj8qrcXra6
 sc6fCjhHQbl3IQ9B1thdqV3/UR9F4/2V7glCnxcTfoPar/Ws0V1KKNAFTvLo3iWB4bq9JCRl1u4
 p9cnr9FPriH5KqrQyKqNDrG3xi0+TVTd+VtRanoY9U7BWVKxx8kPzgTuxXdQIjz/GQCQ2gtlLih
 OXPniEqbqvVPCtviHTw==
X-Proofpoint-ORIG-GUID: 3gYcjQJR-wjmO1ETt0is6BxVHV8mZIDH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDAyNyBTYWx0ZWRfX+35fCGQ9wZiI
 wUNiZwV4UVcdBa9ee61V/rF+Ck/P6gMbSKQKNl75pP9hLJbrCEqCPVUAEuMvywbM8R9m8VVUsP7
 U1Pxk/EpgVCNEL8N3QeQYA7KJxZTsTE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200027

On 19-08-2026 19:46, Krzysztof Kozlowski wrote:
> On 19/08/2026 15:05, Ekansh Gupta wrote:
>> On 19-08-2026 00:52, Krzysztof Kozlowski wrote:
>>> On 17/08/2026 06:47, Ekansh Gupta wrote:
>>>> Add a MAINTAINERS entry for the Qualcomm DSP Accelerator (QDA) driver,
>>>> covering the driver source under drivers/accel/qda, documentation under
>>>> Documentation/accel/qda, and the UAPI header
>>>> include/uapi/drm/qda_accel.h. The linux-arm-msm and dri-devel mailing
>>>> lists are listed as the relevant review lists.
>>>>
>>>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>>> ---
>>>>  MAINTAINERS | 11 +++++++++++
>>>>  1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 912837dd4640..75fa90c137c7 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -22388,6 +22388,17 @@ S:	Supported
>>>>  F:	Documentation/devicetree/bindings/crypto/qcom-qce.yaml
>>>>  F:	drivers/crypto/qce/
>>>>  
>>>> +QUALCOMM DSP ACCELERATOR (QDA) DRIVER
>>>> +M:	Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>>> +L:	linux-arm-msm@vger.kernel.org
>>>> +L:	dri-devel@lists.freedesktop.org
>>>> +S:	Supported
>>>> +T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>>>> +F:	Documentation/accel/qda/
>>>
>>> There is no such directory.
>> the directory got added in a later patch, added this patch at the start
>> following the comment here[1].
>>
> 
> This comment did not tell you to make it non-bisectable. This comment
> asked you to add that parts in your first patch. Why did you move
> patches instead of adding this into the first one?
ah I misunderstood the comment, my bad. I'll fix this in next spin.>
> Best regards,
> Krzysztof

