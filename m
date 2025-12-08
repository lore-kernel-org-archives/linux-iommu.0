Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228B92D63E2
	for <iommu@lists.linux.dev>; Mon,  8 Dec 2025 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765201249; cv=none; b=LLQtFajv+yPxSMnVxklEoL3naAq5C8t4DP4cY22JNC9vC4GmAOapRZbVLcEqmOlwMOOJdW5Tj086hwREnDhEgK8Q6YHTJm6XbFoSDJqN/5hq9bZ6SJ89Uyo1mn1rD5nFd6epmqGlzgFczT474Ybvlvrgf9M+t0kmbhOJrowfOsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765201249; c=relaxed/simple;
	bh=c03rWGellbVHJXYhUe7LbI0Fsb1v9e2LaGoYvPo9N9Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SlOrByTU/Pwizudj+epDnOk4ZRzXPwkivK1YSYlDZJ+MtaSPbFU2XEF2Os9Ci5zvGzdsM1HfE9EDJvPNFkAK2B3U/koZ2o9cJvIV0P5L2nLEiqZuX1H715Ac1PEx3VkCitzUhV+fYJ9QxOLGpONHg1+Lukc6Ak9iJI+XF+T7/bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S2ZPVfNl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jypuol5e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S2ZPVfNl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jypuol5e"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B88PaYi2928399
	for <iommu@lists.linux.dev>; Mon, 8 Dec 2025 13:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ng5jW/XFxY6TkKxsaL1XvkuCaD/iKRVXnFTAkSbhtgM=; b=S2ZPVfNlrJdqoRir
	iGLUEyqETeeL22xKtxba25mTF4epo1abrhUb6uWju5WlmuR257GKkMSbH1lyIJ+f
	p1QYgtd60xJrqFl58DVKR8DZdUsnkBo2IRY1HCrHDZKuKSS6+ShjR9RD2lmmeS5t
	4iBt6oULzncVqOxoAy4IFG7slTZobB0Dmna+5JXuDzR+NH3jYWZ8IptFFU4nEWkh
	OzH8KWJi2+tJtvUveiusfCoWnk7oSgO5T4Wv490v7f0xHmvDZQMjs2JfQkBZPLL3
	J1xqG+QNZS2Xzkl16GOs2M8PNHjIcyz5ixsE1Kh0jMm1xH3HJdLVYzrlFvfvN/jM
	xLwsLA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4awhaqt5j1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 08 Dec 2025 13:40:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2958c80fcabso98308855ad.0
        for <iommu@lists.linux.dev>; Mon, 08 Dec 2025 05:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765201245; x=1765806045; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ng5jW/XFxY6TkKxsaL1XvkuCaD/iKRVXnFTAkSbhtgM=;
        b=jypuol5evFgUz+28chzEbAB4DBZsmGXLL4GUp9roo3yYfom3SsmK32VgaiExRjiZZc
         t4YqCQRnnLwc2WiTwvLKIfw1Dx5B+wm4g7FmGFgYeFhuhZukj3z1NuJbYuIW/ODxgrQV
         6K3/q2foKVFj4eOf4DYRSasj4QKIBk3FQTaa+PdC0jlqp2cpZ6FrirDw3tJSbJmW8wpF
         ++4nSPZ8gc3fyjlUQ7M53ZSugp9Gf6Vabtjbpqe4snWmaQcbDg+wDCZNDvYzY+07tSTM
         Sv+0Lf3/YOcUIs8j7Gs5UebuTCYBEEjJjsYv6ykFXOXwL9Ym8xBJjouGJhmwXaxYuo+t
         5gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765201245; x=1765806045;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ng5jW/XFxY6TkKxsaL1XvkuCaD/iKRVXnFTAkSbhtgM=;
        b=aFYe10eRBK+PAqWhkvpqdh4ZAApn3jsEYZOa36zSTSNroWX8NMC6RCQhQ4nkjiNdEK
         m6gvgXAUjapDBvVjDwGsmhhE33mpx2+SawCsbG2sj6x+XYuy7xEnbWi8Em9rFCcWIL4O
         K7g/aJ1aX1cjbL5TEscnxtejcVzUneIa8Ke6+0NcfL3TLKyPU6RCHCtPjitN90fysjHz
         B01xr7awmDNjlHhpIuT27qI3CUz4FCFHzF8eafg9XC5BjwPOk57UZPNcphTfL+2U/y4U
         dQl5m8vE/dcVxG8YBpdWYzWm1wTDmx4N1ZBW7SFzTBJ0QCGxQ/WRjMwspuG5RFEVfiV6
         +Zdw==
X-Gm-Message-State: AOJu0Yy8UmggHewXqozYzN7IPMm30GFWs//6PY3MNlwBj8K/JMftVUIz
	NcVYEokRVRhMNxY93GoxXGeJj5eIpQ4bhU4BplW2fddWbNqcRifEo8upBrkYWD/x2PWK+L52Sdg
	tgxe+Z85TWDMF31OKGLMIGG0t9tweQoTpoPfuWQld62d9mLlEUWLo1OhUqw==
X-Gm-Gg: ASbGncsowEhtsMc5yQEg89AIBYHI3W7WiKDVEpKpFsVpE6e695A3Yj8yXjVxMZfjrfq
	4/vBuO/7dpMY80irsWD4cW6etOBZE2mO+uwIA1dJt8A63E1au8Ld4UJ2aY3bvT1KmgxMqEtSsRc
	NpTW3wy3KqbBsYmAv8AyZWB64p0bz4NRgJod6B0qipPIiCoKCfPJrAw6HmVtfLavtZfMHLXuBjk
	Cr3UZ6AjI/NTkwc4cVpvadW7pVi10ZDI0bO1JljkKz5z8VjAJzvFS93F6iXrwzBnP19+bSqz6g+
	hB431n9dncdYb7/rF41NvTx9gHU+13SqJ2ZKsLT187EyHcXhsGE/ALxrkmD4uTpKRyylNOot0w+
	kRvVyBX7kc+USoUUFx1qED6U7w+ZReLcRf5GExQZ7vYL4NA==
X-Received: by 2002:a17:903:1965:b0:295:5625:7e41 with SMTP id d9443c01a7336-29df57924fbmr76806265ad.22.1765201244974;
        Mon, 08 Dec 2025 05:40:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsFuiR54Gi4iuunMhcDxbWCnuzkSb4g0YincgSlJk3qleZrdBe8zXZT+yJe2Y4Hlr/EspoRQ==
X-Received: by 2002:a17:903:1965:b0:295:5625:7e41 with SMTP id d9443c01a7336-29df57924fbmr76806035ad.22.1765201244432;
        Mon, 08 Dec 2025 05:40:44 -0800 (PST)
Received: from [192.168.1.9] ([205.254.168.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4cf996sm128464715ad.30.2025.12.08.05.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 05:40:44 -0800 (PST)
Message-ID: <837be315-2eca-4990-94e8-6d0765a8ba44@oss.qualcomm.com>
Date: Mon, 8 Dec 2025 19:10:32 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/3] of: factor arguments passed to of_map_id() into a
 struct
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, robin.murphy@arm.com,
        will@kernel.org, joro@8bytes.org, robh@kernel.org,
        konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
        charan.kalla@oss.qualcomm.com, prakash.gupta@oss.qualcomm.com,
        vikash.garodia@oss.qualcomm.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20251204095530.8627-1-vijayanand.jitta@oss.qualcomm.com>
 <20251204095530.8627-3-vijayanand.jitta@oss.qualcomm.com>
 <75d44bf2-c518-444d-9b15-fca067e25877@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <75d44bf2-c518-444d-9b15-fca067e25877@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDExNiBTYWx0ZWRfX3IAzGMCnh8UA
 Xg4foJqlBhu2D5Yzpw7xfvHxC6lFaiqPFTyIADzx2GZXuq/imRvK+Yvxq3QPmz2LjHZNvlSi0o8
 nC+gZ2VnQkC2PkUo/b8J0bajXuLtP9rdoWXvh0nAIVuDM+logGA5z7tGuY0QpLw90w9WwsgBJSY
 lS72/X6qHUlnyMOmVwW6/6rRBZ5RbWDTYfxZvmR4t8kmMB3jiQLIkAdfKD05Gpse1D4zMxrWtTc
 zOZw7iFIdGiMzE1nptm3P/4U3wMNgDF23M/G8QBMsDBQ7NrvvI/wcbUUyYXzbV3d/f+BcnOQoxV
 EfFH1AU3xGRZBdf6FExSAhj7ur+WiE7XuWN7adEVlizYXIC05lnuFapKRlZyVTO0k5mv88BSacA
 VtxRcnBgvy1ri3coBl5H+CSmhJD/MQ==
X-Proofpoint-GUID: esyDmpoC3X2IbwztJkfAvJ6TwQ65it0r
X-Authority-Analysis: v=2.4 cv=ItUTsb/g c=1 sm=1 tr=0 ts=6936d55e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=qGVSFsv8/Tytdn00NEnLeQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=GBqTS8oSEQGj30kF9o4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: esyDmpoC3X2IbwztJkfAvJ6TwQ65it0r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512080116



On 12/5/2025 10:17 PM, Dmitry Baryshkov wrote:
> On 04/12/2025 11:55, Vijayanand Jitta wrote:
>> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>
>> Introduce a new struct type where the optional arguments passed to
>> of_map_id() are in struct. Subsequent patches add additional arguments
>> to the struct that the caller expects to be filled of_map_id().
> 
> Why do we need a separate struct? Can't we use of_phandle_args instead?
> 

The idea is to use it for multi-map support mentioned in the cover letter,
where we need to pass additional context (callback, dev etc..). Having a
seperate structure here makes of_map_id() interface easier to extend.

>>
>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
>> ---
>>   drivers/iommu/of_iommu.c              |  6 +++++-
>>   drivers/of/base.c                     | 31 ++++++++++++++-------------
>>   drivers/pci/controller/dwc/pci-imx6.c |  6 +++++-
>>   drivers/pci/controller/pcie-apple.c   |  5 ++++-
>>   drivers/xen/grant-dma-ops.c           |  5 ++++-
>>   include/linux/of.h                    | 23 ++++++++++++++------
>>   6 files changed, 50 insertions(+), 26 deletions(-)
>>

