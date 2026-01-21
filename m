Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8C137E306
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977488; cv=none; b=o6ut8gc2e//DUsq0q+bUWqBGRZQnqp6d3/LkPepLhtvs0RiNIcLBw/EdIiaAG7kFQf3mXj2bYszEyaXIPoj/nboagp2PQnBlAiSlo+YJeX0p2YeFgO0skq7cT0823+dK4azG41M3RqAAy9wCXHwkoqGv+U4XbAcSaCyE591GSGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977488; c=relaxed/simple;
	bh=JhhV8f9p5OxHC2OlmUgE1BDNnvFKTu0OjyNnlXV50XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hg375z4AjGhZcC+JjxHGThpP3HPl4oE5nrZ0FShx/oJQIIcRtfmkaZTp8HerfGXCVh22OFG/TYp4hrEziDLtngeX4Z2IgN/HererwWPygKnHNNs3gcpta74hNKTsebwg15WNkrV5aXlTOsBPRsSq9VkZxi9OKR+eD+Sec6G2/oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VSlS5D1W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ETIqQfyb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VSlS5D1W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ETIqQfyb"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L2m9Do824255
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 06:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yvd9VsTWTAbkA4hMrcvZeNdIUE2XO3yiPpt/jBXoYVc=; b=VSlS5D1W/ADwqMHX
	J/ElEI5N7UQcuAogAnA9z0FpP4J2+xwtOqD3eSrMdyNnCn4b2edg8x82tkij9Cym
	FLZhpywh1pdPWw490jVxAnV0kRQlhGlivR/vk4theyrpGfXSzNYrUOO8AXrBZ5le
	lzTjaCxvwxH1wEwuDxPELLEED6KbCBGzzKhpEe+3zl9Bwbt1Up6rXblD2YVcIFcV
	RRCZLOei3X1T005VRqcZu/VO8UjiFXWGu7zAQIQ+fP/gNJN+rQ7HPAHpTf4UQipi
	rY02i41D2xjzBBwH+SeybgqzvZ1mWxLNXLEiRE3FLrOciji94GhruP/KLDASnet2
	X5kS/Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bte5e2gyc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 06:38:02 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81f3fe5ca8eso5535993b3a.0
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 22:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768977481; x=1769582281; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yvd9VsTWTAbkA4hMrcvZeNdIUE2XO3yiPpt/jBXoYVc=;
        b=ETIqQfyb0RGGSxqZGZU/UQ6hELk4lfK8xY1F13j1+hdftABROYL7HVzZAmas94IDZt
         GiGT6W0KIEC8hKeYtDCux2I0W3Y1VxiCjpaqrFNRTFDUSNZk6/WRUog0VwWW7BDEswou
         yBKy/JxKq2p8o6tpiJWta6H9vdGnPaQWRQB70PfS5yFpXW6lCfeULy9ilh44T3LG7h/P
         fey8HzrF5fGsw+VErbxNE2uGdEFuIeFyvh1aQa4k5en1cvYG60h/ZdndmWJOGm6YnBIA
         dM4+WMdfaXgRifuYc5WhbARrHDJyoFeHxMzibHvtnQ8N2D8LIMymzzFHlNwauZGHz5ho
         7glA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768977481; x=1769582281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yvd9VsTWTAbkA4hMrcvZeNdIUE2XO3yiPpt/jBXoYVc=;
        b=vuurhlvrti42kffLg/CIbpA3KtO/Ga17CwbGZ59/qub6SHWpyReP0jJyrgwWT01SXh
         PPPuxrQ0rmWhUh4s3QSbwoQ55kMW2UpTS4TmXgP3MHLFNqUjgpLLNnmjrp21OiTjm1L7
         1z0YAuE6z3XyHMIBd3J6fwYm0S4rS3hsoT73yPRzDXaayutZXgMgYInJk2oFDKatwEL3
         3Le71B+gJqSVK34FT+dxW8HrIajjTn4tdnGu2dTfEosR9tpQiUULOYtY7dXRrCzQKEnR
         QhP+OgvQME9z6aGqALd6zKu1DXfVXbgcTKpqyXIpm+9lsll23o58VSIS7T7unRwRk5Ic
         hplA==
X-Forwarded-Encrypted: i=1; AJvYcCX/wQPjg0MPLpWKRsRkKLJgLs7hXqW7j+T0zzdSi2cwVzmapKG5cABKKIxnI0aLMTZhRUdqIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDetVXxqG1kIqiEiofJ0lCPpzJUmXzoVd4upOiQil0d6R6NiX6
	G13jntdSZCGFhzWlVcioUGManqV0seP6ahxuPolW5OlZaNw9DVPkk+rgkaMxuY9lp3fxcBfNwk4
	0l5GWb4DBYWe7UgwDn7EL24ABJvCTsvaHaDF1CJnb5GYQ5KMmNGnqyFU/FA==
X-Gm-Gg: AZuq6aIy4UsPVs8NvGNPJEhRnr/VsQofHmEq4ewa072n8t+a1sISh+0+sgJAX4CiVT9
	lBy4UwJtuE8ukeSFNYe3V0wAnPIUQDH6L4APbukde99wHuOOYbSbUz+mvBJJ6ZVlqoTzqU0DWm+
	5LDo00knniCaVQbAqDyTAXoEwyQnETZ5VrkuCSVCMhSakx4LdkqK+zjpEnrg8o3Ql2uR6o520o5
	yRXEu7RSuVymWXGjTwdIy3Pnab9TOGLuieIfXFg5ZA5WvVD5A843thA37lDEFwGOvEVpV421C75
	nwd3mZB0uvBtF4bwrt/ChE43Rztf1AxWdzzy2YiYpbvFB1U5rMRa8YTOEKGppXP41WYGhXndYpS
	gdHyuRmU6c79XNACPW0XsHg4+neQrddH1SCQsaaWGtjQc
X-Received: by 2002:a05:6a00:9197:b0:81f:c6d1:d84e with SMTP id d2e1a72fcca58-81fc6d1d95bmr8377941b3a.42.1768977481003;
        Tue, 20 Jan 2026 22:38:01 -0800 (PST)
X-Received: by 2002:a05:6a00:9197:b0:81f:c6d1:d84e with SMTP id d2e1a72fcca58-81fc6d1d95bmr8377917b3a.42.1768977480517;
        Tue, 20 Jan 2026 22:38:00 -0800 (PST)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa108c23esm14027114b3a.8.2026.01.20.22.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 22:38:00 -0800 (PST)
Message-ID: <21b3f41a-d480-4eb1-a02e-c2ae411f3dd9@oss.qualcomm.com>
Date: Wed, 21 Jan 2026 12:06:50 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] of: factor arguments passed to of_map_id() into a
 struct
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260121055400.937856-1-vijayanand.jitta@oss.qualcomm.com>
 <20260121055400.937856-3-vijayanand.jitta@oss.qualcomm.com>
 <CAO9ioeXLJK6fvriRA9RZs8cWcBdv4fgw8VG1_LqLDfc-5hFQZQ@mail.gmail.com>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <CAO9ioeXLJK6fvriRA9RZs8cWcBdv4fgw8VG1_LqLDfc-5hFQZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BKa+bVQG c=1 sm=1 tr=0 ts=6970744a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=P5lMq7c6Yv-mBqOtWncA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: QSUPDGLfY_EodghiTVLWokQoxm0C_ZNm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA1MyBTYWx0ZWRfX52bqP3WGbRWG
 xpJy0hZKnJqsv7ExuCh5MC0YgNz93wJSqxOsPg2dloZyO/8rw2VWQ7kFbk2lyxJoqrm10jusFh3
 w9h0mVsD9sh7Bdj9HMKXst7kcHqEmsIwVnX/+GRDrVZqIN+rgFnvitR1Ej9J1G4oP9IjBNHhLUz
 VA/+C446W6BAnp20usP5s3AjZdf6QijRhEmBlOYaJLS3JrRjTE8WPuqy8l/Uzli86B6Qez4culB
 Lgb+bHJ1xKF6z4X4GOGly4LTliiAtC2P9s+DtvtHah1n4OU/ztwaEimEzPbBs4b2aLkLLvJ3yqF
 EAUrSM4L8mIS6yRYtEOQQyp6e46bhx5aQy+cvKcGwMheE681ynYwB3w63nz2+XxQZMRgkQLJNcg
 WZuxmlCT50NncnKqn7M4L88zYO2LjT+Yo2o/eRU3iHYFmLlsTibBetkAU7pkmPMGzwRMib+u9/t
 jlJ47+IYpZ6leCHB2/g==
X-Proofpoint-GUID: QSUPDGLfY_EodghiTVLWokQoxm0C_ZNm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210053



On 1/21/2026 11:30 AM, Dmitry Baryshkov wrote:
> On Wed, 21 Jan 2026 at 07:54, Vijayanand Jitta
> <vijayanand.jitta@oss.qualcomm.com> wrote:
>>
>> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>
>> Introduce a new struct type where the optional arguments passed to
>> of_map_id() are Currently embedded as of_phandle_args struct.
>> Subsequent patches add additional arguments to the struct that the
>> caller expects to be filled of_map_id().
> 
> Which additional arguments? I don't see anything being added in 3/3 of
> this series.
> 
> Can we use of_phandle_args and switch to of_map_id_args when it's
> actually required.
> 

As mentioned in the cover letter, this change prepares the interface for a
follow-up series adding multi-map support, which we will be sending out
shortly and which extends these arguments. Keeping this in place avoids a
subsequent rework and keeps the overall transition incremental.


Thanks,
Vijay

>>
>> Suggested-by: Rob Herring (Arm) <robh@kernel.org>
>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
>> ---
>>  drivers/cdx/cdx_msi.c                 |  2 +-
>>  drivers/iommu/of_iommu.c              | 12 ++++++---
>>  drivers/of/base.c                     | 37 +++++++++++++--------------
>>  drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++--
>>  drivers/pci/controller/pcie-apple.c   |  4 ++-
>>  drivers/xen/grant-dma-ops.c           | 20 +++++++++------
>>  include/linux/of.h                    | 32 ++++++++++++++++++-----
>>  7 files changed, 75 insertions(+), 42 deletions(-)
>>
> 
> 

