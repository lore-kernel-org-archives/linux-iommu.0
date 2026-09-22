Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1673476077
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 18:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100685; cv=none; b=XiuUpZM3UAU75m6a7aoNlpN+zcnKgNGukgqGtsGU02WyxaMTitsu1AykfJuSvQEX0MRWPcsT6eDksW3y2EzTDjvXHpgCKfpZZ/zZDYR5jXSs8fb9vjU3gXjd6xu/zlh6GzDMxVaZFPDc1P+OvRkmN/mVYE06Xn9jHm+P81nP4rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100685; c=relaxed/simple;
	bh=YKr6r9TaiLIpPUWDV0xkTF5KFQVZkNaHc0UaH2PmIW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQpPimgY+x/GkmX2YfKQ76YRikBDkMjPFst1evKnIu+eoAetbvnKkBRmsMPLOn3dk2MIdYsPz1sPLNwwFaeOt/yW428YVKDnW+Yqwhl9Dii4tXfHr0y2co5dQbCDLT/SLwAtcbughBLikRZzk718XyJlDEnNFadjvt/gRoyLzEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mq5xR74s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B1/MJ85e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mq5xR74s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B1/MJ85e"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI7EsX179890
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 18:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CWIwxqyDzc+G0ifYXGQ0NxRUVu17NP66iLLTZQkvEVs=; b=mq5xR74s0W1iC71v
	Ws9VU0XAi9kOtRct7TTaPdoE8RuEL1VVSPqK7qk0nybUd3UX+hHdBIWBMfVzrWja
	7Tpsz6h1G0PdGMgtV4dtbzWBtqQ5bBQV9hro28fTJjsrHssFqa37sALSzSnZ1+EM
	jN2T3cgXUVT+F1mfaCskhJxcvQn5C5m8quVh5KMY4S9EbYQfB5IPNOzJKTTqIbWY
	NtNuQMRxA0BhBzQpPEzIuMF16WxinLFR47a8AwHUD8oqzCmujTfSBlkVfDzTcTjc
	kj81I4PQqA8LdZ9rpXhzB6cZzMczvMe5fdoOG6u+gPAWTgKixNOwFjYDuw7HZU82
	RLOcvw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guuec17cq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 18:11:23 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3284bbaa89dso250962eec.0
        for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 11:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790100682; x=1790705482; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CWIwxqyDzc+G0ifYXGQ0NxRUVu17NP66iLLTZQkvEVs=;
        b=B1/MJ85eL6L1yHfG3/XsvaYZX0E4IV5famiuaatY32I135ANLcUKxf9/U38MNakWGo
         C8b2hOGcY6gcU+YgGdtkVQ6w6JzeE9EpCgESVGQ0Aiuc+z4FxiI9leaZuxoLLc+b5e8J
         Jtrnji5aUeWuRj1kCifNRZHhEpg2iigMAL3o0y7Ru5etuufeNTvqTsYf4T1dTDuP90Zw
         JvElW8/gp+SoKQSEOPMMavp6dk0D9nJENuGP5+WFAzAhPccvy4/GscJvnZsm1vo9rFd1
         +kIppjXOblW8SdKBfrPL8hF/WsrO6VwfwWN5Bvpgny+Bv3kADIXnh/Wf8qwbkJu/h28z
         i7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790100682; x=1790705482;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CWIwxqyDzc+G0ifYXGQ0NxRUVu17NP66iLLTZQkvEVs=;
        b=eaoH/u6ZsvZjREkA4ZMtfnf2OrLcA0WxjuA6nB8qrkDJmW393Xk03HcuVBKLPk+8jS
         9ZXDXZCee3IDyziLVJt3EPK6fvMVfyIPmxHOrX873FF1E4JPn0Wt+Exu3XxOeHKHDQtg
         Lz/rIPeo/EN2PsRbC+SKaSoXv8XU4NS+Q/B8RLYfliecsIIHxrWBQVEYquV6Mb2yfQq7
         VNmUhOyvKK4va1cbpYBUK0P28QYrpqIeTfTwJ6gZ1aNglKnGXmv4A0xFGxQ9FFajdweE
         hFIl0KSBDawLUHLXt2TqHlBq2icmic+EcRNUURAEjxbJSWS0kt0TacGj9mT5zACXGRin
         n0dg==
X-Forwarded-Encrypted: i=1; AKwUvBxpukMiHGCyApsv6yNEiEM4yUfMfWWfbrSkYugEgpXVNFRki3J0CcfVdUiG81xD1c3Ia7XsUA==@lists.linux.dev
X-Gm-Message-State: AFuF++kixB/J8iBBQw6p1zwSYq625EGtB/zrPevhBzQYslE7SB8vUFQ+
	jmN4V6OcR9sXdHdWSTqANXbOnveINVpXKFh97xBU3sROMmsyxj07UZYUqz2HYCrl531GvSx8pma
	hR+T6dPw8sADhso7eL2yNXMXhl3cSQ6Wx8alZTGcvSfA8HC5jxC9zvH1ijA==
X-Gm-Gg: AYBFou2IZepd34SYRNlj1I9eMRJ8MbV6WgcKN1GQ7/FoXLR2BYU7kL5AMklzAOny8Kf
	xqNPtTiM5zuKQxX2pYoMZA0Y07rUAQn6Q7tShr07NFvBt/srEe6T2lqWCPsLTUUawlSXrska0HV
	jbopGt8T9Auhf2hxlA+lZjwao+kqii9n3vFJ4yEV9dTUt/KV2aQixC7Y40gEvxM1pFJXzgzoCiO
	It2+8FnYKzDxR1ytcfKcEyIEylhJOvwqNmz+kO53ajKB2U2npI0WLy0hl1y+FPSbr9hdTKqQx8y
	kterpDh9BjvJTaf+QCZutVBh7yCR4ub5Mwoo8iqDeFJRYEb+M6ENI1Se4UQOt/QRnXEdhbittFN
	Ue6iwkjCT/eTQEpYejqPZ04JCrkcjG2uvSw==
X-Received: by 2002:a05:7301:8605:b0:334:30bb:5e87 with SMTP id 5a478bee46e88-33e8e3af1d8mr90100eec.36.1790100682244;
        Tue, 22 Sep 2026 11:11:22 -0700 (PDT)
X-Received: by 2002:a05:7301:8605:b0:334:30bb:5e87 with SMTP id 5a478bee46e88-33e8e3af1d8mr90065eec.36.1790100681597;
        Tue, 22 Sep 2026 11:11:21 -0700 (PDT)
Received: from [192.168.0.172] ([183.83.143.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7d003sm16349eec.9.2026.09.22.11.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 11:11:21 -0700 (PDT)
Message-ID: <7bcc736f-e994-463a-b363-9854aafd5649@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 23:41:11 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 6/9] media: iris: Add support to select core for dual
 core platforms
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260917-glymur-v11-0-e0c8bc914742@oss.qualcomm.com>
 <20260917-glymur-v11-6-e0c8bc914742@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20260917-glymur-v11-6-e0c8bc914742@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI2NSBTYWx0ZWRfX4mxDmWmD8Jyu
 s0bQLFTXNyDjgbE2L6MvOjP9ojfXKaFjKbne/eUs+yvoHKB0qmDF3SiRHpJN90JGeYvs2Cj0nUb
 MmX7iV3vvDeRL0cZLfHH0h7Zsgj5GtZ4yZ48+wFZ4Cbx7i5rP0UrMXuSGOI3XxG6Hn6HGuk6Qoc
 YOlUVcTaJ/d/p8LWpBNjjv0h9VydqNV1M12XWw1aCLaGjeMaHhdipP+a36dwywEFCL66wjGY7GI
 Hp58SQYsk9OOOBlLPV6X98ZbP5QjuSBscKbCPJjIo2xu3Z0lvtUOak7OYSb+HJ6/mrusKLpNv7q
 THYw9CQWZrxEAsjkItYnbC2DKjUDziD2PcOqTaRqQZzbjvBEctXi8a5UCYAYAOIn7eurOcL/D8q
 C0JvDKtW/F+uLh5QS63iwbOimSYcRiYc7rLr2/rJ4ycBsEXWgZ/thwZ2RxR33ceMfuU7JDBf3qQ
 mW9G9CYwwxVPdfFNOwg==
X-Authority-Analysis: v=2.4 cv=VKdIDNPX c=1 sm=1 tr=0 ts=6ab2c4cb cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=d+GKXRUq2vCLDWIvqUj1TA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=0GF_beopZQ-buuiTRkAA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: TLDSjPeBQKLtW-0ihL2_RWo5_1HtA-z4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI2NSBTYWx0ZWRfX2CTN+tAZBhix
 1fdk5+Y1oJt2LFdz3m5qA63BwZAGf6YNjp3Q82FFywdqqbniRDM0LGdPR6B1+AHSWYMyuwrCwy3
 We8mMih3Q4q/ccLbl4jmjlMSSy6EBtc=
X-Proofpoint-ORIG-GUID: TLDSjPeBQKLtW-0ihL2_RWo5_1HtA-z4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220265


On 9/17/2026 10:30 AM, Vishnu Reddy wrote:
> On platforms with two video codec cores, select the hardware core for
> a new session based on the current Macroblocks Per Frame (MBPF) and
> Macroblocks Per Second (MBPS) load on each core. The selected core is
> communicated to the firmware via the HFI_PROP_CORE_ID property at
> stream-on time.
> Since both cores share the same clock source, the required clock
> frequency is the maximum of the aggregated frequencies across both
> cores.
> The total session count limit is scaled by the number of cores, since
> each core independently supports sessions up to its own limit.
> 
> Reviewed-by: Dmitry Baryshkov<dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_common.c     | 10 ++++
>   drivers/media/platform/qcom/iris/iris_common.h     |  1 +
>   drivers/media/platform/qcom/iris/iris_core.h       |  5 ++
>   drivers/media/platform/qcom/iris/iris_hfi_common.h |  1 +
>   .../platform/qcom/iris/iris_hfi_gen2_command.c     | 19 +++++++
>   .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  1 +
>   drivers/media/platform/qcom/iris/iris_instance.h   |  2 +
>   drivers/media/platform/qcom/iris/iris_power.c      | 20 ++++++-
>   drivers/media/platform/qcom/iris/iris_utils.c      | 58 ++++++++++++-------
>   drivers/media/platform/qcom/iris/iris_utils.h      |  3 +-
>   drivers/media/platform/qcom/iris/iris_vb2.c        |  4 ++
>   drivers/media/platform/qcom/iris/iris_vidc.c       |  6 +-
>   drivers/media/platform/qcom/iris/iris_vpu3x.c      | 66 ++++++++++++++++++++++
>   drivers/media/platform/qcom/iris/iris_vpu_common.h |  2 +
>   14 files changed, 174 insertions(+), 24 deletions(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
