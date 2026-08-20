Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D0F440631
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231163; cv=none; b=NL968QiIbhTztFf/rNuqfqjEj/0uiMKoqKIXSy8ekoxXZkkmSFAwcXwNrZlwQeV9N+gQHTLDWZYvpIVNfAd7BvP19rFBGTyrhDia+AQ8ijHOldre5bbsr3WvLX07I92MIDo+9WMvrEYaWm3roICTistgoVPa/qVM/lANjeamsU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231163; c=relaxed/simple;
	bh=/MvLGjCq9P+3TJQdi9yv+SMKwpIqRwp5tDl+T95B12k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hK3Jo1TnwRDv7ZPyLVuobLsxJPFttUuDlAQ2RbpOHUqeG+if9xV8Uu1MmbGf58XaNRj9Epxmulc0zgb8Dy7wWXGFyrDzy+GfjKkUJeatO0AgeCOfYCRBZHiwwYc62qIyA/WBF4zG6bWtR8lbCm/qg2Z9UwHYU+rwf7blgLUc1PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jwaV4z2T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KFsXNihh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jwaV4z2T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KFsXNihh"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8PERN2465472
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 13:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AieFSNSsSUo34uQSMJ/dNEJ/DOfK3/fGsi4sE8iI73Y=; b=jwaV4z2TzGHiIR6o
	jRjasUFvEdE3hZE4YOADkjaSjyq+fcG4SjuMiuZVqbaXpQo4fXaIGY24SYwIat5Y
	xEHhlCuMnmrr/SJYHxUbGJ+FCUVgQRxIlibWMy7b/sBOaiRz0+BwV58KjdvUWos0
	MymhkSBlK9tfmtpyUhUVKJsUFs7C/x9lF8qpNUMfawb2xETI4YbvdSb/Fm3cQMvp
	wpXyQIuiglhtbRGv11uPR8LPyT8bF0b6C169b+Ox9GnAJLwwDeqD8AZtXLm3YYqq
	gt/e/bKxwCGZ8iFBBe16qImQzjIyszZalA0J2/MKSZVYh0FOA7HSdLy82KtShU+Q
	AQ3oYw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x29h1dp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 13:05:58 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39533bb224cso2623356a91.3
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 06:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787231158; x=1787835958; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AieFSNSsSUo34uQSMJ/dNEJ/DOfK3/fGsi4sE8iI73Y=;
        b=KFsXNihhNPUWp9iVJygiIw2vHWUALSztv8TlWIkjmpFheJHQL4jrRRmdJf7zuyCzbS
         Fd9GnrFQNv7J/CGvJGkeBuWbIlVU66FfQX/XpS/WjmDuOyNDW6XSq8yNsmEh+HB02R8w
         I7z+tg3vlhi70TAo4nau/yeCAduxOh9NpTjzV3u2DgzvVAJfHT0kSTXjFUl/H46aB69P
         7deg5TRto7YOe615M8BHU2HvjZv24TmkZ0gz8+HMMHDQWwWsmCCwiPOPIq70xxPYx6r5
         6UH85viMjbuZstqMMgVG/Y4kJp9wwt7L5OjRzScYU4O5vHncsmSNaFhW4lxZm4kTdsJm
         jJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787231158; x=1787835958;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AieFSNSsSUo34uQSMJ/dNEJ/DOfK3/fGsi4sE8iI73Y=;
        b=d8bZH9ufQzodS2uMWJPNczGWGuV/83wlnKzJAXt4sUFcAzqLqbxWlsobD84kCTpLIs
         acmFukupT34Lab4BJGch736Aa/g3EMy6TNa9OD02/LEXxGL/XgYEA3t6ar45bOzk9EN1
         wpDBdFe3ALIBwux0gFRUbd7ym+ZyzUcubQ4Ub+ysxuaFB3hLRpK6kYYPttrZKQmphP7s
         PySOC+frEFpqzDjnVHhxmcoDHOSB0MMKVo470LYC49ouv7ORRedfqgaE6wwcsJix3lJV
         Tb12HKjv4j6ThgRP6HpCrTnqZGD71a+7NtJa0E07/hPChYe+azyja0s3m1gqesb0XIVQ
         y9+g==
X-Forwarded-Encrypted: i=1; AHgh+RoS8TKN/ZIaP6SUT8NSTz+7SH/uk0ZuiY/2u3zdTRUrwJm2sxY9razmXaM5Z2Y/watBCVAoHQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mSGRRhTzZ/RRszx5V5F++rAcUn1z4CW1ZUghOn9eO5Jgse+nN1
	/BUEw52hu055yIWuWx3Qt6g3fn8TykOtKvoyxgOjtCHC21hWEodhpbM1fjnYY4GJgLrsIBicQpv
	J/1I1NuIPrNs5CYu8NZVE+I5vOOY4B9DIXpKIC/a2ByDxStq+4T0PF9pvvg==
X-Gm-Gg: AR+sD13wghk9TPNQG7G/tWMgFm6s177ZeZART3seyr5Li5a1kvR0rwRjInwgAdCSxCW
	E3IKJZCQUWXv4xvj4FDpMJdQnRrWnOvoFiLTJR3QtKTSZBx6nl3ELFju3J2Av2DSuVjWddu2YaU
	G9c2Vwq2LLA+Cic7hbYxBlp2Q2esFurHuZprHfeWexRRgvBCtFiyr5O3jWAc2moGJllrIbAakpS
	gquwil4h39UDFYHHWONPdUu5LYD8c+FmzMuOmaB8yc9FYATgXuUQwSMZdAKZ+vqs6SWdi3Eiwn1
	1EF2Eo1/VSe9hatv2BOBVrSAYq606oeKL6duwBnuxVGYIF0CLuqTH7jhdfg9NQxdwDkMkhKJvur
	mLNBULiTNq9zNDiGR7aC5JlA9fKJtGg==
X-Received: by 2002:a17:90b:4d82:b0:395:4de4:92c7 with SMTP id 98e67ed59e1d1-39580ed143bmr23044560a91.3.1787231157830;
        Thu, 20 Aug 2026 06:05:57 -0700 (PDT)
X-Received: by 2002:a17:90b:4d82:b0:395:4de4:92c7 with SMTP id 98e67ed59e1d1-39580ed143bmr23044231a91.3.1787231156489;
        Thu, 20 Aug 2026 06:05:56 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb12145sm6574171a91.4.2026.08.20.06.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 06:05:49 -0700 (PDT)
Message-ID: <eb05740b-8683-41ea-83ec-8a4a484881e9@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 18:35:40 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] accel/qda: Add remote memory unmap from DSP
 address space
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
References: <20260817-qda-v2-v2-0-757ab8ed2f64@oss.qualcomm.com>
 <20260817-qda-v2-v2-15-757ab8ed2f64@oss.qualcomm.com>
 <6k6ogbosxx4z5bh7uriu4fnj24ycuakylq6g2gnuwsbckl2zww@e66jgj5xo52o>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <6k6ogbosxx4z5bh7uriu4fnj24ycuakylq6g2gnuwsbckl2zww@e66jgj5xo52o>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: mzxvdwuzEvFTF3PWlRdtvWfQkLgBVrCK
X-Authority-Analysis: v=2.4 cv=V8BNF+ni c=1 sm=1 tr=0 ts=6a86fbb6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=rYwYc2LNA-xZppdo0x8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA5NyBTYWx0ZWRfX/HxJP+YHwEa5
 HL1uhSsMxZTG0B36PwB0XgVOv+gBO3U87x9d7pP/F6nxl4u/TUWXi61HpbdCOUFTw2UEmj+b92n
 XoK/DDobUv0jUw6QrYF33cx9+PHNU2qwEdNk3F4GVi0li49V0kJTo/dJmRXk1vZs9pVhTOFSn76
 kHwMuqfaS9ASB0kVxaJ+dRyWleoftQ6TmpA+nGSMfBSfqJN+iq2LTjUGHAJfDeY0K/yEAVEQhDz
 vjvmQv7euUxS1EbNhTsLQ+Bbz0kRQvNDbS/i4mc+2Izg7FfCKAsTm+gRG9t0doB/P1C7CnPuz6S
 iPu43gqawCTRMn2qxC7KvIeOGwodt3qR6wTGXO7rBg48lcjkCJo6MtwS+UGlL4YTw5m/feTjBw8
 p94TDlSlLF2EOOLjT9IAFRnV0IKIwHSn0+9YDczvjlPh0lsKYX1zWP9XpQ26qTR7E6KRb6mkXSP
 kO72EynFaqD0NqO64WQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA5NyBTYWx0ZWRfX4tyeq7lOKkY0
 dVp30Jp5wZIoQXkBTtjawmgtqMNWRLyWQ780PiYBvGTS1GgXXkscC0GLDmnFu/6vtFp7Dvib2Ws
 7Y3ch47XJS8gwzmQDCvOvPQDDZfeEJc=
X-Proofpoint-GUID: mzxvdwuzEvFTF3PWlRdtvWfQkLgBVrCK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200097

On 17-08-2026 11:14, Dmitry Baryshkov wrote:
> On Mon, Aug 17, 2026 at 10:38:45AM +0530, Ekansh Gupta wrote:
>> Add DRM_IOCTL_QDA_REMOTE_MUNMAP, which removes a mapping previously
>> established with DRM_IOCTL_QDA_REMOTE_MAP from the DSP address space of
>> the calling process.
>>
>> Mirroring the map path, the DSP exposes two unmap operations, both
>> reachable through this IOCTL and selected by the request field of
>> struct drm_qda_mem_unmap:
>>
>>   QDA_REQUEST_MUNMAP unmaps a region by the DSP address that the
>>   corresponding map call returned. It uses the vaddrout and size fields.
>>
>>   QDA_REQUEST_MEM_UNMAP unmaps a region by buffer identity, using the
>>   GEM handle, the DSP virtual address and the size.
> 
> Why do we need two different operations? Can you just pass the GEM
> handle to the IOCTL?
QDA_REQUEST_MUNMAP (RMID 5): The DSP locates the mapping by the DSP
virtual address that was returned by the corresponding MMAP call. This
is the older protocol message that only needs {address, size} to
identify the region in the DSP's page table.

QDA_REQUEST_MEM_UNMAP (RMID 11): The DSP locates the mapping by its
internal handle association. This is the newer protocol message that is
not supported on older platforms.

> 
> Also, what happens if the buffer is still in use on the DSP side? Will
> the DSP crash? Will the whole board crash?
The access from DSP after unmap will trigger an SMMU context fault on
the context bank device. The fault does not bring down the board but
might trigger remoteproc to restart(I'm not exactly sure about the iommu
side handling of such faults).

Thanks for reviewing the patches.

//Ekansh

> 
> 
>>
>> Each request type has its own argument builder in qda_fastrpc.c,
>> documented with the packed argument layout the DSP expects. Unknown
>> request types are rejected with -EINVAL.
>>
>> Assisted-by: Claude:claude-sonnet-5
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/accel/qda/qda_drv.c     |   1 +
>>  drivers/accel/qda/qda_fastrpc.c | 119 ++++++++++++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_fastrpc.h |  34 ++++++++++++
>>  drivers/accel/qda/qda_ioctl.c   |  22 ++++++++
>>  drivers/accel/qda/qda_ioctl.h   |   1 +
>>  include/uapi/drm/qda_accel.h    |  39 ++++++++++++-
>>  6 files changed, 215 insertions(+), 1 deletion(-)
>>
>>
> 

