Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5ED2FB624
	for <iommu@lists.linux.dev>; Fri, 14 Nov 2025 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763119619; cv=none; b=PDUoS/OOzp7VLzVOXC8LDLFp0FchtTk3SX4VUItJoMESU266GWXl71aELlamdnBS0VfvurtmCRHQXKcNrSon5lGdM73Wr1uzNG9Or1PpPnHwxhr0Ik3p1m0rqYiC3mK1T0Ds89EGa3+XjAHHukhYRGoYNoD+WoxCbRZQATrLCmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763119619; c=relaxed/simple;
	bh=FjgcuY6SxnUFbFV//lcFGoEp8mOCm8RF0YZOkQurjI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLAX9gC0jGxN0i4PBsWwLigjoKdW6syN0QM7Nho+/NHUSq8lEOSaQbrLRZ0abJrwQTf+wkvCHV4EXk5xJ/2rISs8tmVPery/JU5wI0AiLVJCwbbTQABw//Zhb3rHtWxrNXUe47TqGpPE7veMnmCCiZnofyTGlx34agaWL/w39HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YvmEGhHa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AgVhbFs8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YvmEGhHa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AgVhbFs8"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE8VgDG1488265
	for <iommu@lists.linux.dev>; Fri, 14 Nov 2025 11:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xj6btczQP9EttHmyg9oi/yzZG5tH5YacuDZXJnwTFdA=; b=YvmEGhHayMHB5uzm
	enctitrc46sCoSYts4Pd9jZjRcyEUid2Ik/mbTzm8syTdh4h4lXKq37hSw8lTm8u
	Yhy8xu/xdQxTek7UznfSUHnt7Unsi24CjmQHL3RP0QBVu7uPEq+iTY6nQGTFN45Q
	GGAap7UTFISWYeA7ukX5CUosV266vxpbLt6zcavgnyczJO7ANnJaxrfLwRCxQq9R
	u8ZYGBePYg0IyQ/Zzu1PDGTHB74DtlwOFi90Kv4Dh8PSZHso9CgSO+WOGtPeU+Rt
	3iD78ZHcicHcJHs4x6j/DiT6z8TlLjfXAuNPUfpaZR9anLgM/rs1mo1BsMjgydUc
	JJgxmg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9hsyqe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 14 Nov 2025 11:26:56 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3418ad76023so4569309a91.0
        for <iommu@lists.linux.dev>; Fri, 14 Nov 2025 03:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763119616; x=1763724416; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xj6btczQP9EttHmyg9oi/yzZG5tH5YacuDZXJnwTFdA=;
        b=AgVhbFs8obNxIlhXHT6/H1LRfkbMQjeTsiiu9sM2zSR6TpkJMrc9DVIDsXYbmQSxBT
         Nj+wBSPlBR2eBkx9iamPO6Ig7WUkAZp+EO+9gVLhFHSieB82Zwz217TwybBVaOAsg0BM
         /S3p4WSJPZY/KCvYueQzMEjrIhC96oQeqBWY6bjP/MLVm95l4s8qvSji52KMpYaUqN9r
         gayiRRRxXU89eORE5T4qJDeaLQnpBVxS0SS3b3pdY+bSdv+BNw6IQmzaQPXJ+iO/z/X2
         D6SZ3iS04zCDr7KWziIUZyRplDYDNg4pFg2amlIDsoC2cck4fKvWuxI5q9f8xzi4d7/Y
         1jHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763119616; x=1763724416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xj6btczQP9EttHmyg9oi/yzZG5tH5YacuDZXJnwTFdA=;
        b=SgiY09LW4cvXt1RPxIfiC1Tz/IfDVhFLiDp5o1Gv6fGs9vRIAlrjNkbAocTPcTuLC6
         XmnloisTGpWYXgXLGH77Slg+aU9QWN52KeJttyS7m90b1YQwYw8yD485JsCoMDbtI9Ub
         zz6QpbI3Dmbo7XzJQLU45TeN/nrmcLaYClvbhn0H9pWtR9I4Er4mI48kZxLMyIyo0la7
         wW1Kg0GguygHHLI5sNWaCl/rGgcXwoCsKB1pTI8LDjPJ2UtlhtWtNwPw7LEGD3d7IRXq
         XFQQ3zR6LJmKtIwjLU2U+pHgH6PD5SsbH7V1s7AaSWYTAyu57qKbMJ7OIa3UEG240UkY
         fxtA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ+wSrwqT00fouWk0o9O72jaAciZr6+bi1n6Crk1yvWTJ+4bEdyl1vZYIAbw77kuDloUVz7w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyO5CIJl9U2e5VEs9bfFUdridJVy0JpSN4bmLr/jNHpT551Pd03
	Onw0t93pnt5/oKO4JFvUx5Md67Maue0fWPKBBXN6XS3Qf6Xn3HMCzOEE+MlDvQm2uLtN4/fQeKA
	nLGaCQA643ME5YSAKpSCEkGZBLHYscNTD+x7wx5myahSc93at5tuudRbQnA==
X-Gm-Gg: ASbGncsKf/P9JfMVAU/Z2ppzhhfBdhIKPqW+0XbK3Ng2ftuAxoTjrRIwfX9YRe6qWCz
	ivL7qnfIkipifEweNkpPDbyuoLG1rhLrV8sE6jqP8dIMGvDm+ZsPxAfqj531/nVOpiXp2zqlvZv
	ou7JkK4xCDSVLScRYZCEYfV3BxqfpSMxoLnliIWb+9CHXBpmb8CVbFPC18G075uWTvPg+5mgg71
	Mv7fGfbWl0Ww/yJ6VD66yts5fhZmCrTIwrseZKxJAW+9+++lcKI4t8oRFax/ET+Yna8etfGqOOj
	Q83++CbG975LocjR+wOE4LPjSERMTO1vGzATBerjaW8bDhDWn9yLA6uiTcSUcjFr8nhtyZLQIGt
	lmWQ3WHPmwha9hIlb/oocUq0=
X-Received: by 2002:a17:90a:d408:b0:33b:b020:597a with SMTP id 98e67ed59e1d1-343f99c1cc3mr3251182a91.0.1763119615949;
        Fri, 14 Nov 2025 03:26:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgKCyHJGBBYPB4qZv+EAl4Tx88PJN32VSjZcg29sFOWP5dg9DS3lwkBEwjYg2dmQ/BXtGF2A==
X-Received: by 2002:a17:90a:d408:b0:33b:b020:597a with SMTP id 98e67ed59e1d1-343f99c1cc3mr3251153a91.0.1763119615473;
        Fri, 14 Nov 2025 03:26:55 -0800 (PST)
Received: from [192.168.1.8] ([106.222.229.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456516c622sm167599a91.9.2025.11.14.03.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 03:26:55 -0800 (PST)
Message-ID: <76523142-b337-4a31-90d2-c8477ef0b270@oss.qualcomm.com>
Date: Fri, 14 Nov 2025 16:56:45 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/21] drm/msm/a6xx: Improve MX rail fallback in RPMH
 vote init
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
 <20251110-kaana-gpu-support-v2-11-bef18acd5e94@oss.qualcomm.com>
 <dd32a5e0-1dd1-484d-8fb7-8f6c506c8c83@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <dd32a5e0-1dd1-484d-8fb7-8f6c506c8c83@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: P7YueG2YH1v6ddvf15l4jPprSl98C33I
X-Proofpoint-ORIG-GUID: P7YueG2YH1v6ddvf15l4jPprSl98C33I
X-Authority-Analysis: v=2.4 cv=N+Qk1m9B c=1 sm=1 tr=0 ts=69171200 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=UUXEStRZTiKyGgBwSCQbmw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=lZFDvItL9zSOf8gjBGIA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA5MSBTYWx0ZWRfX/g0BqoJhVd62
 736C/52xGDxCGeJkRG8DUOOlzJ8jabqn9xfBaGjBRxxKG3jLzGEa9sBchOBBmr0z66PkJo9pV85
 AasYVEKqK/+DgZi9G+iJCs2D52XBSBSzJYGGV6JvCFmK3zrxDotZrJkAMn20yU7ZF3W+QBIVY2r
 7Y4KjOWBgVwAutb4g27pN6nAggmkhnBYuhEKyTFYaQ/BBOmlXOR9qqGQvKfiYSqob2FajNfp1YZ
 E0WPl6qSYDddd4/J9AcZCncwBA2RzKxLpZyUVkUZhZMw400xdnwRB1JZ/KjLjTT3RtwyFk06Sx4
 GYZU1b+AZRIUSn5rL2rzhU7Kw/dQY3/yCtQCTPBhdkn55bAydXkcS+KhbBc5rdLoItI+XLkHdNh
 bKTjy4/XVTNVWJN1Q1P2/BzQCHOuDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140091

On 11/12/2025 4:29 PM, Konrad Dybcio wrote:
> On 11/10/25 5:37 PM, Akhil P Oommen wrote:
>> Current logic assumes that the voltage corners in both MxG and MxA are
>> always same. This is not true for recent targets. So, rework the rpmh init
>> sequence to probe and calculate the votes with the respective rails, ie,
>> GX rails should use MxG as secondary rail and Cx rail should use MxA as
>> the secondary rail.
> 
> Is GMU always on Mx*A* and never Mx*C*?

I believe the GMUs we have so far are always on MxA when it is available.

-Akhil.

> 
> Konrad

