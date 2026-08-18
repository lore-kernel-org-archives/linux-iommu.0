Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6460C3CC7EC
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787032344; cv=none; b=Pi/s83LcCEP/X1to+/9Adfj3lA2NiaQCgFg9/a3H6cFyKy06UvAtxYtALT+cGDrDXd+eh6Vsf++vya5hkWoppKJE2ijoeWsASuz9BgwaMjAqPs+TmIGSvdr7EnOwytAaq7KLPaIxdiJVT7JjipNy3OjijYC9NDAR49sJUpL0Hls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787032344; c=relaxed/simple;
	bh=Vqa8rQTBY3Zk3hkVDjVZQpf12nyCayVJDNTfdX7cKMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ET4uk7cGyV4mcZRadveKSTmjTO6X6PqfkM9+JbKmpgVNimqeZ/rDQzc2azL0ZZzSv1Ii2te8K2BJmMnxfxouoHDJxEqBsfqPcZBSI7kRxIvL2T0+00LPYDOEHRZ3WZuTujRNgML3AbicFysFe4EkbRnBngGhTUfWlkOAsTlAhuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SldZMb+Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L8OIKagR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SldZMb+Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L8OIKagR"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I2YMnW3761799
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 05:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xjYcnSrjSmgMzkRMxQam0GLR8tuJBIbwpiu16ja4GG4=; b=SldZMb+Zwc0l7/OG
	VMJ5pOsnhgpR2d8vJWDIFpUgn9RmdHDUlNOxDuTQ1jPuhIfd4zNWZYhwBkQFtXZU
	5t1uSxLpO5uIbAg0oUQUantoiZCuNBdpwDUOyooVOivP5ujX91pf1tqA3E138In5
	p7ajf20i/n1Guk9Z1wfhuh9dTFdvf2p9jtX1wzQbuUPCgYJGvER9q8h2oSjIkE9K
	LlwMujYMfVLZw34PIqC86VEgA9pOAfYQ158AwCI1rw6qtMtjl+djaoaM6T7XHt3j
	BPLnCBbUkt+apwC0A+IZxEpDEpCRhoPz+IV7DJLbJvrljST7LqCm1DiXASw6AtAz
	9CGDYQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4eqtrr6v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 05:52:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc5faecf01so87780305ad.1
        for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 22:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787032341; x=1787637141; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xjYcnSrjSmgMzkRMxQam0GLR8tuJBIbwpiu16ja4GG4=;
        b=L8OIKagRaPEPSDwv/QqFbvpX0tf/LdzkiYo308QUaJaN+7NEBLrJdjAgEB812XX/ej
         14mTwsc5Tfds5Tftf+/SuDPYd4VtinH8kSuBTV05pnPXHSJ9CbyGo60rm7M8itinwwz8
         1BDsdJjOKcIfiQLfSnaBlkSqJikrHfRxKDnohrcnRw1yNeu8c+is4L+dyvBG+rARrll9
         R+uI0Z9GoPfm08nPR3cPsUKGc/wk/1w49PoK6yvpHBQwp1aAmxHPJ3sIhX8jgnVXsd1K
         5VYnkhYG37tX1nLNebhwBNWprjz5f54DomBTMe9hjhDnMcUuBoc/HBQVXrBxYJ8JSh63
         nBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787032341; x=1787637141;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xjYcnSrjSmgMzkRMxQam0GLR8tuJBIbwpiu16ja4GG4=;
        b=n8GQ8hrv635nakYa7mi32pWz07In990IhQHKZvjIuornDJpfULMbYK0J33sgEHELZM
         6bcyNommpzIhmPlV6hkoWTlpdAeV1KedwSzdmyLWr0A7PUqXkrhe0HTgn/vTstSTD+R/
         dbBPmoRhlqjHJ0DnYwkNXDmmnqc4oLAEV4CGbCcQOT35jFAG3ZRgZAAkRr5mKIisUiJJ
         cFdgCmsk4cDfhOUx6Cr4PVn+inkLl7FwxteUQWCkiyRr5e4IMGNUJxl0nFO0IS4YE5ar
         GaxLjt3b+s2eyjXlIXWSuMUOPbvI83mvdowGD8k0KJ7MTgpMI1lWvCItBDyUzSj/iIC8
         YL/A==
X-Forwarded-Encrypted: i=1; AHgh+RqL4wFlmnUDgX2yDzYORnU07q+rB/ukvxO654RvQGIxAI4RaQy9eZ/GPI6iwVL5VWNIioTjmw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/B3mb89UX6lessAzt48cAGUTgUeqvb1VHz/O8uOhcQjwl4NwL
	jBYUnP9wXOu0ews1Y1WRMqlezqBWffRa0K6E+abRFHDRk/sHy7um8k4N7vOUgLFDX4siAO/6LCJ
	IYxMZNZu02uXy4f4DuxpumKNBoA8j+pO8nUZG89F2VDMOrUyIBeOM3tBfvw==
X-Gm-Gg: AR+sD13GhQqBXrnYpjMLzgUsETW3Nz72n2e3Qr8LPRLhW4WHbA+EE8MZAEv5DVwweqv
	ooxj0pR842vOfIXr1HlweNm41olW6dvBR5WGSMEO/Jt7eCZwaeBOshyZy7GgZUaXxL1ZAQ3frNP
	Am9kRMmjOQOTJGgjSl6HJkrL1/H5TgpEpnnpH4jZ2anj4Hn4K6/sp92o2InOIfAlXEJH+u3fmBy
	RUpqnOkFcZkCpT6FAG6Ivaz9PxbdR7CE0tfhtPuGEDl9qifFITdST9cvg8rKN36lw+Ua6A5qKH3
	eqdl7QRKXDPTmOQEHYZN0qPX1GnI0suXhsMYXVvc7zq8avFX24LmJ+xTlsnOA457hUbN4ozYjOz
	i9INw5dAMTxtTKjkJIluEfs+ELZSe/g==
X-Received: by 2002:a17:902:f543:b0:2ca:6eca:492f with SMTP id d9443c01a7336-2d5c5381b3fmr57275105ad.14.1787032341126;
        Mon, 17 Aug 2026 22:52:21 -0700 (PDT)
X-Received: by 2002:a17:902:f543:b0:2ca:6eca:492f with SMTP id d9443c01a7336-2d5c5381b3fmr57274255ad.14.1787032340674;
        Mon, 17 Aug 2026 22:52:20 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1ef0147sm10197055ad.77.2026.08.17.22.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 22:52:20 -0700 (PDT)
Message-ID: <50b067ad-0ccf-4b9b-9116-c95f40105140@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 11:22:11 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] accel/qda: Add DMA-backed GEM objects and memory
 manager integration
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
 <20260817-qda-v2-v2-9-69a02e9090d4@oss.qualcomm.com>
 <pm5yr7fovkav4cuat5zqn3ngf2fxzrqutsgyaobwp5djv4xkuv@in7n4o3x3x6y>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <pm5yr7fovkav4cuat5zqn3ngf2fxzrqutsgyaobwp5djv4xkuv@in7n4o3x3x6y>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA0MiBTYWx0ZWRfX/LQG03UldeOO
 C4ziDmHC6Ik33rSbXs3JfRdk5FTTj0D/RoKmjFIym+y+LBx4/qyvyxkpOu4Fp2ucAyRpfgeEWIu
 o29DIY+CRYtOqGeXs+/cTu8pc+iuSTs=
X-Proofpoint-ORIG-GUID: scFBESlBh5ynyK44bPoKAjcmUXQxVSSA
X-Authority-Analysis: v=2.4 cv=UfFhjqSN c=1 sm=1 tr=0 ts=6a83f316 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=5LPJMhapKY6Lgul3swkA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: scFBESlBh5ynyK44bPoKAjcmUXQxVSSA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA0MiBTYWx0ZWRfX8YTx6wr5a/ah
 YQJgc3pnAzk5ub2M/tXGmtN1M0zSc0wPYO0qBzjdSRKlsFNlCI5bIPH2Y6o1eUaYDCtaiSIW7bb
 jA/A4POgL0z6tyVzfsgtykbhOTBvPt0OpPPxHW2CLyPXYqb7ryZK2lfuKpZlxwIpIXrtJRePAwo
 0bFWZFRH5rIvupynNQA+DxmfG071CuevGbYfnueX3xECAyI5H+IMQXaOPQa2C94AW7yie1zMGzf
 fuB4sXZAmDN/pZD6zPZN24tHbmkmpjco4IjBkmaxDJGXDU/WFlzYgxpcTXZpvl0buXtRmrNrdAF
 S/vUoMiqGvGKYHA6h2L+GN0PmnbNe0w1U+oNYTKldkUrB7TMlZ1B/uVRT2KT5r1iLDiWviIP0h1
 RIMwSa9bwrpymlTbNCCqHSPhaSePm3O9qXYE6mJyBVOCNT88xSZzbYjIOB0hlbmM7iFuAZaUiMu
 v9NObjRcK/QeXTPg6iw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180042

On 18-08-2026 09:18, Dmitry Baryshkov wrote:
> On Mon, Aug 17, 2026 at 10:17:44AM +0530, Ekansh Gupta wrote:
>> Introduce DMA-coherent buffer management for the QDA driver, wiring
>> together the GEM subsystem, the IOMMU memory manager, and a DMA
>> allocation backend.
>>
>> +
>> +/*
>> + * The DSP identifies the IOMMU context bank from the upper bits of the address,
>> + * so the stream ID is folded into every address handed to it. The DMA API only
>> + * ever sees the plain 32-bit address, which is why the context bank devices are
>> + * created with a 32-bit DMA mask.
>> + */
>> +static dma_addr_t get_actual_dma_addr(struct qda_gem_obj *gem_obj)
> 
> Let me propose a very simple rule for you. Unless you know what you are
> doing, all function, struct and macro names should start with qda_. The
> to_qda_foo(), I think, is the only example up to now where you don't need
> to have the prefix.
ack>
>> +{
>> +	return gem_obj->dma_addr - ((u64)gem_obj->iommu_dev->sid << 32);
>> +}
>> +
>> +static void setup_gem_object(struct qda_gem_obj *gem_obj, void *virt,
>> +			     dma_addr_t dma_addr, struct qda_iommu_device *iommu_dev)
>> +{
>> +	gem_obj->virt = virt;
>> +	gem_obj->dma_addr = dma_addr;
>> +	gem_obj->iommu_dev = iommu_dev;
>> +}
>> +
>> +static void cleanup_gem_object_fields(struct qda_gem_obj *gem_obj)
>> +{
>> +	gem_obj->virt = NULL;
>> +	gem_obj->dma_addr = 0;
>> +	gem_obj->iommu_dev = NULL;
>> +}
> 
> These functions are called only once. Inline them.
ack>
>> +
> 

