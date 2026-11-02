Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623474;
	b=l2Y7z5lSQQCZfAY2dH7GuNntMY8ogzBZ41gCNHoFGALWklV7+dWZd6bfQJhrJR7xIO5i
	 7bOvfl0oDe4BzUN6RmEeWYn0ZWdWRF/95AywBx7pzG37mZ4f6YtoQf2aKmbwHqI3YaNnR
	 b2Z1Q2fTxlnDFlIlS7DltvGj0jx17oabj/turhoNDopRg2dQ6QFhOkmTmbAwyucvkQrQj
	 Q99Trv43T7TKFRV0FoCPh5reCb3hiGU1Y8KAJrjii4RQ5b4lIKU6a0l+yQK4swrHnE+4K
	 UYhPqTylr9lK/HJUqcwhw2mnAo68H9hRGYDX7HTxqFqfXZvVn72xueereTqcazKkm7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623474;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2IEIbjIJXVuOp6D5eD8OuUuoxSabHhJvcs0+CWKwqGM=;
	b=qnF7wso1TPtFGVFg1ZEUk7eCPBg9fpsdF6CxkvmrJxydChMW76pnamzfTgXW1PCQszv8
	 Fn/KRzyyqyuDu3GJglU/lNgrsG/UnLlkhVDh5sVbKXrJX698bFLBusWxnJ8HeyDz961pK
	 Gi7FqXHDLVP4uvd51yPLbiG3oHjaolivLc9dfDVWEc4kUcnm05qT88awJU/1JcCLXLju9
	 u2irCqH/1onuV4+masGdyJRFwRo15Si6Jz8Uu7rERAKUDqw1Zoavj0Oo2GabVucr88PrF
	 2XthL/j6DmAZu9IkKtg9rm1ZnPi0NTeSHljxqtjnuyp/9/M+8uEduRtvTrjSUcnI04Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EOioltV4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TmDykKYm;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF12260A3816
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 12:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF12260A3816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EOioltV4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TmDykKYm
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29ALvh2880833
	for <iommu@lists.linux.dev>; Mon, 2 Nov 2026 12:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2IEIbjIJXVuOp6D5eD8OuUuoxSabHhJvcs0+CWKwqGM=; b=EOioltV4rTXNoKF3
	ipmP8gz3lEBkTW5wy4eLvI4Uk9sWVyL/sio7Fh0GJKxk5fXSaL0VhZlQ37M5gKkl
	utI1djX5mcfcMR2+HBR7ym00h560mBPHQ18bsMi/7RC38I0QdVzzCaVslhFxPB8g
	WOQ8v9kMSmzZEf1Jp88whqKbJ/1aklD7VKWlFCwzgWhsfVoWp2Oiw4bKNw404hw6
	HfrnjxMrD+UPUO/PmrzmEn2hqobqG7OY2RbeXRZ+2UxMZ06IrUJGvsgmVvVdvgaB
	C2SVui3qlW+SumQ0SbJk3E6Qz5H/SzHMVgy3dcp4nnWhlThLJ6KEXmc17CFlcK+f
	ur6lYQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqfrguy2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Nov 2026 12:44:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5350173dc7aso7946091cf.0
        for <iommu@lists.linux.dev>; Mon, 02 Nov 2026 04:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793623467; x=1794228267; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2IEIbjIJXVuOp6D5eD8OuUuoxSabHhJvcs0+CWKwqGM=;
        b=TmDykKYmCNFey9EHOk2NnQ+dOLrw+ak27YU+2cxtrul55I8vlu/FStS/ZW+MHIEHyr
         seXwhkhFngVHtlDqgOXYYv0rbHJdIHxnPPinQoJRyO55cLEXym5hj98AUC8G3eFu8di3
         LyKo3ayAGYo67yN5O6whRf/CBOMHxI5EUq116IpX+uHpuuJv/ofOXUPFR6JnRvF87VKc
         ZJ8VspfaZ2Fv+GrTN0J15Wk8b/fo0m8frRRy04zykcOCF1GEUXpC0Z6XM6TRpgHS+3+a
         9EJp24z5asFEVVIBTWDl0Pl/j5bVrktkH0hzOl9e9E9f3qLy3AylCFNq6HLoKqdSQx2+
         bN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623467; x=1794228267;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2IEIbjIJXVuOp6D5eD8OuUuoxSabHhJvcs0+CWKwqGM=;
        b=GbAEEv0AI0ZPiAMkDR69Fc1lMUmwtYpzX7HLJJy/xZxwTIjBR+qm0lpzqggv/WjtOO
         8UpyECU+zRquNBWooiXz/RPipeogt7DNvbw93jC8Fmtsa1Qg+Q+2V+hhB395Fyt49674
         Nrf0EBkJVHDOPa0d9TxMxh03wzhN7k0ZgxC8ffb8BgiCAHx1U+Hck2+2o3720MjBQtjC
         nzaFpcs61zotiDdQN0EEB80aKN6/ZTQ60uWBlB2F1D7SpdQSKSCT8uQIE64UnTgm6R2c
         m3bq+2BdcAqQipaCVJPp+Udc0fYPpDr9xR0ZLKGteCqQmDVCec5oSjOX/CITj9foQXrX
         WL+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwgkwkhPXbb5suE6xarfcvzdwpXm8hXl3EPMbHPfkJh6kyIngonbWC88hPPoncWab+HngxsoQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJCKNTB4idBUWLGCSTR+CZtwWgqenleRBaQCoMFORChx2G7Xrru
	+wUduO2Pko5ixULQYpB+ognp9Kikv1NX8Tlpx4f3p2eO16au5c39evWu15ANTHdeCgNxnhAqZ0r
	i73ZKGKFR6c/CxByW4dGD1IWsrezcv9vZz3vtXAkQBVSL6vP0AlhLDGhi+Q7mAle7oQ==
X-Gm-Gg: AYBFou0+xEOZEFCUKUgpo/rrhzBa+wKkcl15vM76m23hJcdbTiqK2MQP2w2m1CO3Sdn
	r71m1IObhaGz7nuM2W4doInpXfD1VvZCiwpKz8Ez/S9nQ2d3zDyC2tcJ8lB3x4rH5WVPiS+fnZF
	bUDjktXPQ3cUvT9qvajE9qgj9S+OZLa3wAXSx1TuoK9uqC+aSUJDzUcE/INxEKKZ/iFxgTCUh/Q
	YR9cuc8gw2ykm3fjceB3F0/sgcdHbf6hSsxYvKsnp9pvPxujWCXtOzbNKttxUNncnNOWODfev7H
	OFNXBl9Fd1+gSfq+soAyJgK3gVY3QpQ7ldU7KpJjlJsZm4NSe3dz/kEifFrFc+UWBt49tJb0UKH
	OdpiOsZMdERLkSfv20M+H3tWwpS/mBm2UjP9LJtJAplM/ijUhBpfgyk/3qUed079K2fq/BxM=
X-Received: by 2002:a05:620a:6e46:10b0:939:c7d1:7471 with SMTP id af79cd13be357-944216cc78bmr1564907585a.4.1793623466889;
        Mon, 02 Nov 2026 04:44:26 -0800 (PST)
X-Received: by 2002:a05:620a:6e46:10b0:939:c7d1:7471 with SMTP id af79cd13be357-944216cc78bmr1564904885a.4.1793623466454;
        Mon, 02 Nov 2026 04:44:26 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe101d4sm389225666b.40.2026.11.02.04.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 04:44:25 -0800 (PST)
Message-ID: <73f05be8-6335-4d48-87fe-71ba5fb1d2c6@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 13:44:19 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/11] arm64: dts: qcom: generalmobile-shamrock: new
 device
To: muzafferkadir@mainlining.org, Srinivas Kandagatla <srini@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
 <linux@roeck-us.net>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Jassi Brar
 <jassisinghbrar@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org
References: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
 <20261030-msm8952-initial-support-v7-11-ad748ace375d@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261030-msm8952-initial-support-v7-11-ad748ace375d@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HMJWhYtv c=1 sm=1 tr=0 ts=6ae885ac cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NCdQflJRAAAA:20 a=OuZLqq7tAAAA:8 a=EUspDBNiAAAA:8 a=MxLZmUXcRv2kY27zAqIA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=AKGiAy9iJ-JzxKVHQNES:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: KTsQqWIoOesTfddxFu4e0POqVkVv2soz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX6uXVrI+W9Z8k
 xVHXOqYnmi3wJY/0i4IJeNngRpDBdfoiyjH1BxAlesQBjsIQGj68ZNmjOfJBV77UYAMo7f0WPKf
 kVeXUSQGuCMB77J36J+RaMU1INa2Wsc=
X-Proofpoint-ORIG-GUID: KTsQqWIoOesTfddxFu4e0POqVkVv2soz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX9h4HlpJYziOy
 HjHSxKMZZSnYbI1ztFVIQR0hGh6LlQbsHxuO+d71RWeSYMsegLn67tsrapWy6GqU1hl/eckwM8F
 LtZ+6F1XnwCrs7RSBfm+iEqEB7PP3revtDo3ETLgD5sOdxOd06WrbycSb8HNA4kkal2IWCuDrZW
 eCWncuZGSVz+D1+IPyv/wt3y2WwDQzXPD0u3KUptrFSOLy2KC8RCnMw8HSBpajQOkWYG1LlIhyT
 hkvUrU0IuacMWBywy15Fz5lq0DMzR6LOTHp94TqrAUgU3V1BehdZJQrx2GmxRQKm3cZeTJvxTRt
 fgd6Md2tszufLNl9nFZQn4ibg50yQQRvfQW3WtOHO3D8NHy9q36Jq9ZS7xAxUUHxbwvoCwfQqMz
 m+0Mgn1vS8xC5AYXffqj4AkIsrqENf69ej4ShbKttfKKQF4+V2RKjA5DB3VESqCzOZrVwvJOlWK
 dQAmvCnh5It7RQ9hpBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020050

On 10/29/26 10:02 PM, Muzaffer Kadir via B4 Relay wrote:
> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
> 
> Add General Mobile Shamrock (GM 5 Plus). Shamrock is designed
> similar to L9300. Downstream reference is [1].
> 
> [1] https://github.com/Asderdd/android_kernel_generalmobile_shamrock/blob/cm-14.1/arch/arm/boot/dts/qcom/msm8952-l9300.dtsi
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
