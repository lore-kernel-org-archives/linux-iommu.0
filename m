Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5F41F7D4
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330687; cv=none; b=bn07Ho0fnKZmOrufPrK9VfhzrxLUONjk2fq7+Y1DtFy10QfMUSePffI/NeRnU4Wucb1Cnn2uCxGYd/rbVwDzcSkQdhOniMwHQC7X4BAZ95PzD4w3ULCl1iI+b2IrOCgt3A5h2KkbevjNtTrt47kqj82VJipBr4djgXn6/iqI/x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330687; c=relaxed/simple;
	bh=Pj+ozva9T0fcwNSEKOkK2xdvTm9ebLUEPwBdOCPGS18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSJ5wgWTiC+hlaYM1LpEjC++Km5bwlrwyhOsYEPiuuDPWxx5bVGnCmVRdPQ/u4m6Sna4+iDfrk0m5eMWlYaJ9oBy6lIU+iyEf35BOczOgUP7xJFOGO0J2ncHNJFcb3+oXEn7eUhhibwIHMvKJSpbmLRfrCd1zvmX7NlUbDEj/iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SMME+Egv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZsN+nqqd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SMME+Egv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZsN+nqqd"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66694Gpq142740
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 09:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UmvEo3pA7Pq8NfvYG3chpyYLUANHLsFRyacd45P4BwM=; b=SMME+EgvC39EFdP2
	bvUtHETUasD8CkHlv0Jqwax6ufpmJ3R8p0IP4CWInLPYJ34pAOcmIvOsqLmVwotX
	pDkGVN2Dm4+0DvNhYD3iKDhIqCUfjY1FGr9V0XS6f15/qd/UpX+oU2RQxski7/gi
	yaX+W1CVH8XapWfVCbo4KQvNCmRy+eSpzktuQkCP9fBXs5D/WjsZMuVuQtxZ4ZGl
	6nwhnUVzC8LJuuXXgonFiJ4BhpYIdyhUX3IQHsgZR0HZDbEXp3MUnKo0b4Ozoe3x
	lQygoy2uVQAZaMSxFhkXWYUzKqbY6+pgOuVT7GeVXH3QSen4oDiKvkZlJrcL2/Yn
	CP911w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s4swpqp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 09:38:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e5e21552dso66380785a.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 02:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783330681; x=1783935481; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UmvEo3pA7Pq8NfvYG3chpyYLUANHLsFRyacd45P4BwM=;
        b=ZsN+nqqdCx3QKlC6smpiCvvmpYZYwCSeQYJpc4UuJ7v6JRVg5aqGQJPXGJd5W7+7qp
         NOIjBT3VQ3w1hy1P4iKBbKzwuICT4fyWGQDIgezrLFpanNghlTxtbo7lKNrO4KqrvSq7
         VXbDZ1Y2ZpAKTAAfn1/bN6L1o91KnKJ8yVIloZCT29WXncYzTS9oYg9LVmm9Aad1oJgC
         PvBWTJwYu1jVeKNK7IAq5YOqMvrzTMAw7oLBu8g4qa29WCrxARb5XlES1rMuWL5CYRPm
         2zWJkr82/h9F4M+wqmNXLR9vSf9jNsNj+rUdafccqyrVgH4X60zkGwj2+MofMxDsTByx
         c+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330681; x=1783935481;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UmvEo3pA7Pq8NfvYG3chpyYLUANHLsFRyacd45P4BwM=;
        b=biR/t1SlDJZ6SrIUgKy/UZDgYZ5GmOa2emJXJryfnUnnPjwuFGeQ769bEebv690gT2
         ULYK8cDK8jIZq4lyj4DEzWq6ypjp7UnLLLlHN10yRETJjdvIfpblwykszC+yVm/1niEH
         CK54cALLuj4TbwwgvPRpORng8XaNooRD/4KIyApde51M+ZqvvdL2DkvFHnaEZz/oDtv1
         A1Cy5OOIM5So7ycER6NUKVI8Fh1kvErGoXDCsbZT8OL2RuIYBYPjYC+UwOcD3m6flew1
         AhvzHQp9ZTtFemp57fS96FUVLy21IKGEN6lytITNgT91fFjgPKMsYhL8RHOBYD3lNyCi
         w/qA==
X-Forwarded-Encrypted: i=1; AHgh+RoV3xnG3y+thAhVVss7JXgYMYsyeE0jHehlfqDymWM57PsxAB3zPSiPsG4UZ0hqNQfR7XwK3A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLoJFU3+GpEyEcKsFcU/qzkXHwCH811GZH8gUH+kS4l9wQ7gBO
	oI/Ts12tqu84aqRwPkNuN7MmQPfe71b7CmbWkGDNcO+DE+AxVknh7WxEd3tZLwlIq+2Gl2VaT7n
	vlaFVe+N3z9EtJh2lKh3sG25imqJTdwS+J9XtDdfmsnRNlQEJJyAlbgdvgQ==
X-Gm-Gg: AfdE7cmH78QesA2Quux0nD6MqW8w0mdExwhtWOQ0xkz9K1ZykepEgnK35i7msqUm3TG
	NHfbvKdPlrceEZMRj42NUrwOKAVHgX/gL8qwyPoJvYdO+8V2QnleZDf91vIsiGaxBZOWiG2b5pp
	dYPg+EjBmNddvRIy5kOaah5u+0KBV16vODh4bt0PzSktiagC26I46TuWRHTPhb4cPlLopSvXE4j
	rUj1DYiphqJfZjVPlZdffkEalP3ijaSkgaPTNR6WxuDnACTvAGSqtoKfvnyT4oBYSvGDw9hKgN1
	M17kSl5Xowi+leclsSJrHKLBF/r1mRBuLL1YFPlvd1bhRZM8WfFR6c1IibM7WrpcKVRZttKY9tN
	tVB8JNRjU8m+nNVjeCSKb9iPpB+657I6rMFQ=
X-Received: by 2002:a05:622a:13cd:b0:51c:f3e:781e with SMTP id d75a77b69052e-51c4be97d68mr86773151cf.6.1783330680866;
        Mon, 06 Jul 2026 02:38:00 -0700 (PDT)
X-Received: by 2002:a05:622a:13cd:b0:51c:f3e:781e with SMTP id d75a77b69052e-51c4be97d68mr86772871cf.6.1783330680497;
        Mon, 06 Jul 2026 02:38:00 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b60575c4sm709337566b.9.2026.07.06.02.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 02:37:59 -0700 (PDT)
Message-ID: <e2b7e03f-911b-41cd-8ac4-044492e2bdbc@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 11:37:56 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: Add GPU support for Kaanapali
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
 <20260705-kaana-gpu-dt-v2-5-6ac53de56314@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-5-6ac53de56314@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NyBTYWx0ZWRfX+jzeh09GTKtt
 +jOnu70Pesfw+yIPY5Ix16EnVdQ+z5k7cfGibn5PWQO+10Z793mAaD4ZBsXquxVbkZFrIsKjDHF
 OQwfwckfNuJZwWIwxQckaU6VEQuOLhs=
X-Proofpoint-ORIG-GUID: 6ckQQoPZsVdsmrjSzi-I2jdQxsIN9js9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NyBTYWx0ZWRfX81SKILyW5jAT
 x7hmPHzD1CD+acQHpVipqx9H6JS5pVydjNy+rgBysdJZTx/oXwZyqb8Dc6lWkeUz0ODLodxXXCp
 ChUo0DmzURko3Xw1nqMpSkXWYPFq0QJSQFdMUlzgVMLvckfRGZDfsbJSKAVNvl2QjQrvvBSQ/80
 kaKE7A5D9F+IT7oDCBxxOa1cbcN1aQbEKlh7NR18QX3osLAGH8f0DzJyXfVPTBo/F146r6N5Wul
 CCFkWbqcX0LHaHIBt44S+p9znLOcxQ6CISoqAbkzY04w3dhwrI6C24nX0U+V7W+mHAOc18b3ypy
 5MXqstE+DMe1aJZvSGAIsAX0HGmZBVEAF9Df4HNRFY+U8cx+aWsQHTYhDj1z4mSzcU3y51NJKYm
 z5L8MNaGCdYq8JofRZUjPwI6DTsMFS0KKWuYQcs8a7dav9u6zOLLy6crwsI0ex6AeGKbDPTQTNp
 SuCimbAdzJWj5Z4KyRw==
X-Proofpoint-GUID: 6ckQQoPZsVdsmrjSzi-I2jdQxsIN9js9
X-Authority-Analysis: v=2.4 cv=ZfQt8MVA c=1 sm=1 tr=0 ts=6a4b7779 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=z65YV3W3F_EkYOo9s_QA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060097

On 7/5/26 10:00 AM, Akhil P Oommen wrote:
> Adreno 840 present in Kaanapali SoC is the second generation GPU in
> A8x family. It is based on the new slice architecture with 3 slices,
> higher GMEM/caches etc.
> 
> There is some re-arrangement in the reglist to properly cover maximum
> register region. Other than this, the DT description is mostly similar
> to the existing chipsets except the OPP tables.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

[...]

> +			qcom,gmu = <&gmu>;
> +			#cooling-cells = <2>;
> +
> +			nvmem-cells = <&gpu_speed_bin>;
> +			nvmem-cell-names = "speed_bin";

This looks good to me, but I thought that on a8x, we're supposed to use
the freq limiting register in CX_MISC - is either of them preferred?
Or are they just hardwired to the same thing by chance

Konrad
