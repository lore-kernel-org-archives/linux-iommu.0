Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C403B3D1CB2
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029043; cv=none; b=RvNiKNAkOk5x2d/BO0vd1Zrn+c+xfm6CcaPfS+d0kkKMzOiLGMJ21HD2s0+tSbwiEJ4PSgV4hpsCO+iJhfVN5DnLiqEtdGRomLeysFr4tLJG3XnPc7pxPM75TlZEJ19On2/h+HWK+LSCsGcVUDgau5yRQo6Zi2OGR0xzYVnL/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029043; c=relaxed/simple;
	bh=vlmj78ENu4V6iQt2nHu8920yOHityKAFdoRy/fn73hU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PenaugnTjsgh+Xe7kCJwYMxnTNnQF3xtayl131PV4Zgc5b8AD7oEewDUqg3OiRc9qO8RJ+H9+aAWoNSc4te9ddkBG5IVoOkLrnS6X7GNm5PfgqFEnf665Yg13TjFmgYw+jljY2YNN+R4a8ToybCkJQuwzuQLw7/yh+r50zw6GQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ujpyutbf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fx37mL/Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ujpyutbf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fx37mL/Z"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P9SvJc2127926
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 14:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ghT7JDNMf0qUDVWiQwz9lqduowwivTxtJyYYgUsqveE=; b=UjpyutbfEqKkZYGW
	i6kNlF9sQC7810SDSSgkU8qIP2h1NJNWIAo4UfV0mRnzviKkCvRAo52AoTF2bTS7
	CneBdh+Sr0XyU2zVaDbqwh9u495udpm8r++TK3HGvLUHiaNWDugOI9DATLA063uv
	LkpzZasUEP9ivAozPL1zzagcggPjxVkicPDNpziwIwuiSzI4MiJlfe8j/Yx4KKki
	srhd9JRj5Fk/2/hPWEM4x2Ph1Tpr51ftHEpOcKM1aGxVGV6vLlTZ1fmsClhU6v+1
	A1ko3K8cDD38EZJo9JpgkcsSbRaS1N3EK0YrR22Fb0ZLNHCusRdMWdoMT2zRyXdO
	SOT0hg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chexekqu1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 14:17:19 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-824b5cae336so3155780b3a.3
        for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 06:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772029038; x=1772633838; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghT7JDNMf0qUDVWiQwz9lqduowwivTxtJyYYgUsqveE=;
        b=fx37mL/ZReNFue/MnY+PQTdGQ87PrrZgzw7kug2XpkCL+dXzgKvYOrCgR2xYGrspq8
         Kh57jKp8isAa63iIZdxok4y6g06nrqPLvFtlEFpmzH+a/gG9t3iH8tBDu0bkD1j9+vIx
         ATtUou+qyge9qNropTlf73CV7mYfKoWBJpYhEH+6zVnC/iQG2TWxOXewq0G0V+0JlK92
         1PH8vzXBbDeZyJG97veSknRZmaJ+AVYCbfqOF6EmfNffN334djhuuST7I7p/djf5dTu1
         b4r/PotT/wlaQFNjn/YDol/YCz62wEu5lcvFas4gmaLtWkxXg8sGxriJnh2CIKn3k1Kd
         JV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772029038; x=1772633838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghT7JDNMf0qUDVWiQwz9lqduowwivTxtJyYYgUsqveE=;
        b=Sy2QxCnBCx056leMeIm+qk8scJrsRd5ZHF1ZK+8IsR2YXdkxK03WO/LJOgXMLtWozo
         W3TobjwoBrZcg4MJJd4E3jGTO98o01WViJDyONMMb/DChnKVmfKV7d65w5xOSOcO6Sb5
         +x7JK6UEY8CfDvy7FuaPcKyF113S6Sr4EFv0zPYjaVRIxvQzKqANAHhXjjXIuZ0uf6jm
         XktfT+rDPgqNbVlxl1vI7jJDz89wpWOekcZ3H9xi5Cw8ZX2t3jQfgzQW0PkDsvZvp2be
         VVHdF0922eIth27wDxNkehTFfYTvmqR2u99BWZWDDul5re+MkabSAX/qL1mFD9rsFkyj
         9JIw==
X-Forwarded-Encrypted: i=1; AJvYcCVmsSIUPAxfWqhgfq6G8mhulwp6UgppJCK1qXH6G0BvHJvYCn0AtZ8z6VwycNo+GcOFqfwdOg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy50h7rG4Dbce6p0CoF9JRMWT4SGZGBSBgnbxI4NfGB/YBAnspB
	3yu0gYtk15aoSqt0ZNHVYmgJzAEmaM/a4YQFfw1s1vN2ok8nfoqkZu5KZ/oPKT+UgTqlgQkQqfp
	Sn0csKxCYT6zUx48oqqX1u7Xpkpde1VUFTBLim3oBLDSbNDrdrbHPvUFArA==
X-Gm-Gg: ATEYQzyrMLmprTB4KOiJvSwUzBZb+bbcXi/BANVTdt2o6mIFi79Ng2wZBKnWMHREFI/
	csF+4aH7dN+CChzwMAuURPvjFOfge2PvLGahO7HVUru+R0P5t8YPCRIu8kkRI3gKP9aSVYvDglM
	W8nLmaC9ag0I2P/5eG8McBU2o+kQ+EwYBBE2D65vQ0IjLduv5LnRCsV2zrRA6jvQ4FETtMoBnp2
	rkApx5mNHy9VvsXJ8n51tKUa8Uh/6kancagsVuvwuHxIubWoNZCxMRVB5XyIixpfCkczIqWeHfy
	s/9wruni305LjryKnezb4hz4xzssnbsM1s1YO9ybwdsChOV8v6TDI0IlnTmVbav1ip5yoqWgigv
	D/oX73f1zioNY5XX34zNVA7sQ1Gu5oBsiSbORKJ1R4VVpRW6Yl9Q=
X-Received: by 2002:a05:6a00:2407:b0:81f:33a6:e9cd with SMTP id d2e1a72fcca58-826daa82b31mr16934488b3a.57.1772029038307;
        Wed, 25 Feb 2026 06:17:18 -0800 (PST)
X-Received: by 2002:a05:6a00:2407:b0:81f:33a6:e9cd with SMTP id d2e1a72fcca58-826daa82b31mr16934446b3a.57.1772029037741;
        Wed, 25 Feb 2026 06:17:17 -0800 (PST)
Received: from [192.168.1.5] ([171.61.227.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd641040sm13758026b3a.10.2026.02.25.06.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 06:17:16 -0800 (PST)
Message-ID: <5a278b02-f2ad-408b-b0ad-f2297817bd7e@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 19:47:08 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/18] accel/qda: Add Qualcomm QDA DSP accelerator
 driver docs
To: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-1-fe46a9c1a046@oss.qualcomm.com>
 <e94ce683-d47c-4c8e-8b26-cd327c891cc8@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <e94ce683-d47c-4c8e-8b26-cd327c891cc8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDEzNiBTYWx0ZWRfX1elEWYezlp8i
 ZuJSUAeJ2QnDECl2UNiyvOY3zWotLxvgJXXedLZBjoQollOjBILF+0dbyrm+bLWxZg+JwPgUOdK
 JfnGfwFtUP8AsgDqGKhd5LMIDNvZVbJHHR9g3oC/O2Ft94S6+Rllf63DQhA0XoQws20BoEkqC/C
 GulzgOyzbYxpXVZIOS/yYm+B8tCJw/b42l4fDaokIZtZOXRTzNO6JMI3PFdqV+6gaVZWt5RaKGt
 eEMtNd8zIfnGXtMqoKWmxMztV42vWrXhcTmzLz/OwVmVR/lx45FmvFuU1EYp9rxqyI0taK01fn3
 sZ8/v0gWDnEdL8rkPouOCA/yJvofCsjEo8Rc4Z+lFhJAwebKxXrhXS9DShTXef5+Qarm11kNT4Z
 I2x5rhtim1bQlnWWatYqO9OphZZF2ZWz8wP1aBqtIYJ48QsW8u1iJM4ugLbs7h/ltrFBfQZkiwm
 XUF9TNDl8dXJAQFrVHg==
X-Authority-Analysis: v=2.4 cv=V85wEOni c=1 sm=1 tr=0 ts=699f046f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=CLJ8B99oKJtQbdnoKiLypA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p29BN9gyRe82g0miaHUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: kU9h4RE0549ga0w-XpLwwZei6mer5tUW
X-Proofpoint-ORIG-GUID: kU9h4RE0549ga0w-XpLwwZei6mer5tUW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250136



On 2/24/2026 9:03 AM, Trilok Soni wrote:
> On 2/23/2026 11:08 AM, Ekansh Gupta wrote:
>> Add initial documentation for the Qualcomm DSP Accelerator (QDA) driver
>> integrated in the DRM accel subsystem.
>>
>> The new docs introduce QDA as a DRM/accel-based implementation of
>> Hexagon DSP offload that is intended as a modern alternative to the
>> legacy FastRPC driver in drivers/misc. The text describes the driver
>> motivation, high-level architecture and interaction with IOMMU context
>> banks, GEM-based buffer management and the RPMsg transport.
>>
>> The user-space facing section documents the main QDA IOCTLs used to
>> establish DSP sessions, manage GEM buffer objects and invoke remote
>> procedures using the FastRPC protocol, along with a typical lifecycle
>> example for applications.
>>
>> Finally, the driver is wired into the Compute Accelerators
>> documentation index under Documentation/accel, and a brief debugging
>> section shows how to enable dynamic debug for the QDA implementation.
> So existing applications written over character device UAPI needs to be
> rewritten over new UAPI and it will be broken once this driver gets
> merged? Are we going to keep both the drivers in the Linux kernel
> and not deprecate the /char device one? 
>
> Is Qualcomm going to provide the wrapper library in the userspace
> so that existing applications by our customers and developers
> keep working w/ the newer kernel if the char interface based
> driver gets deprecated? It is not clear from your text above. 
Thanks for raising this, Trilok.

This is one of the open items that I have. I'm not exactly sure what would be the
acceptable way for this. 

As you mentioned, applications that rely on /dev/fastrpc* might not work on QDA
without modification.

I was thinking in the same lines as you have mentioned and  having some shim/compat
driver to translate FastRPC UAPI to QDA. The compat driver would expose the existing
character devices and route the calls to QDA. The compat driver could be built via Kconfig.

However, I haven’t encountered an example of such a UAPI‑translation driver in the kernel
before, so I would want guidance from maintainers on whether this is an acceptable
model or not.

Regarding your question about library, all the APIs exposed by github/fastrpc library are kept
unchanged in terms of definitions and expectation. The same project can be build for both
FastRPC and QDA based on configure options. So, the applications using github/fastrpc should
not face any problem if the libs is built with proper configure options.

I have noted your point regarding the doc not providing clear details, I have added interface
compatibility information in cover letter and will try pulling the same to Doc.
>
> ---Trilok Soni

