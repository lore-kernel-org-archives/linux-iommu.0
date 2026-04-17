Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D843B582F
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776436543; cv=none; b=qq2AfwFOpEpWQIBSQh1eR8Z/z3lXds3/IPcnSyUKnZpOLDwacLXwXim2GuvmoUia8J5Gh3g1lMqc71VYhmFk4t7d36mTqZ3FlEs0IkgJ78dycHSRG8p/kQyhTrnOxxE+VsmcrgB1JK/PLy3o2ZaWH8Xq26krvd8aS6IjeSJx30c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776436543; c=relaxed/simple;
	bh=SF113oFF1sMZms+X7nrIwBSd1ktumh6AlyZkr3mVNC0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YOnxeQHNdVUISyoprOy2m4/vkqBfwiZcq5uUJCmW6iXKZvstXamYNH4Xs3mQJgvFDpgi+46hOc8k15ZWIseM1PFyvaknIeG8yZCIa5cnpdhH7x1EP0xOo14D202/jCIIPhbrFXD/3L+OOivouYV3My/taDF8M6Oy2PYUu+H2RIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h20xq2ZF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FH1WHexp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h20xq2ZF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FH1WHexp"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HBitfS727598
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 14:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7akWR2KTYpymsLXO6H6kGzO/anuY1eZUeK21VlmDe+c=; b=h20xq2ZFJH7N7PSw
	QLzUhL7N+mcQaqrb2YuOHWZZRdCbAo/e3PkZHs2ijcVhfHFzhO/swObIVQMuIVR6
	gTZI9NkP6twpH4WAxrQLw+0w/jeXKDJL5ZCTQMPmO+ky/PHWpBXAYcvMAUyvocSK
	vgoA4glWUyJLS6jIdP4ZarszTZfCL+MrKl+z5uyv6onRxyiMxHhfhZ4QxNRBbda/
	b2xbnsPiURXxSlkvgK/CaBJwSSLCSugjOfvwdrAG9h0yprlvcNQHiNMglhBC5pEL
	aFR/oZOi3IuI2YrB2gbkFvGb0MS3aitBes9mHywxzs2wUNVQXRn+NcN7/4zeo57y
	FI1n+A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkfyqsnvj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 14:35:41 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35da99b90f6so1080193a91.1
        for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 07:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776436540; x=1777041340; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7akWR2KTYpymsLXO6H6kGzO/anuY1eZUeK21VlmDe+c=;
        b=FH1WHexpJd2x02I4E8fEywP5Hf87unH4FvSWLeV8jKoWN1Vj4GAo986kQYGVJpvfT6
         Z/gg+unRqG3sr3jtXnAAEpM3WdaOVhZt4EUKdGPPKYuICL64Kji262AdDKW89ArCrZui
         GynMOqNNUzAq17KELFSVnQhZ0ojBDPx1RMXx/AEtNN6AO46AGB+1Y8ghLkC2YEDzpmtq
         0SfqREkSkdzqCdK6RYEil7nxZjdcfwkAYxH7oiaH7W2EX+zgEles6R7cvei+5yUtEbwI
         ofnif1AkAlQWGSwc2lIMSK/oDWT4yFlRDSQchowdN8MAjuKoevpdwtf3LrUnKp89TaJH
         l1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776436540; x=1777041340;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7akWR2KTYpymsLXO6H6kGzO/anuY1eZUeK21VlmDe+c=;
        b=HE/0AcM80tCsKoplB+IrZgy5E+jDUIkr5gJ0sI/AgXqhF05lzghBNPxluMfxV1ITXq
         o/t2zHciafQK7EnbwSkDYAo6Nh/vuNehyokiy7p4quaaUnfx7KRmk16hIZuLXWRLT/I1
         FiMaXgBIlTB3wrgCITWjZcbmokTmBqnSseRpQY/lj6oK2TIsRNCaPZniq0pF+vUmNpIL
         NKaB0lKYl2E9wHkE6wtQZzEQf3JX6blsJ+BzV/Zabx0aHVdTbZU1bPluzWM16FL8sTKl
         dfhQ3iswigB7mOqCQFUcpJghtnH0fpPtkLzH+4i55WzQRe2/gAqd75gN7EVjh1LhIxUu
         WMPA==
X-Forwarded-Encrypted: i=1; AFNElJ/r6vXZBarCf97XNkn3t3nv3NylGl55PUzE4woRUljOqhfQbkbZ0PaTEQglYiQWr8gAUGmoow==@lists.linux.dev
X-Gm-Message-State: AOJu0YxuBy4caWAhSo4wsxIsQiid1zwbUSSkPixxBh9owTWrqZB2Cy2h
	5rnlWqbzYQcQe4m38mwaL8ofGQL32SCPqvdgGmstfKLv/je6k8lMdE80946cwTxGn8b8neYtee3
	8Kav0RQR26cFf2mGK3IolS8fNQux+aUvFCzGAI5Q7vJG3VLHQMKtuOTPSlw==
X-Gm-Gg: AeBDiet779EEQB71j3h7r1MulRTEawb+S4R8AT5HYBc/uRAc/uX6MyHQGdeiIbkUHzU
	xyK5Ng0AlkPq2VrtO0cwGFO7EzsRHR8CuYBPqwo/2F2FQZsOWOxwBxHWP5wVayT85V3yKsOvyFn
	jAi9ZYh9qZFq4ZZVkAomLoAB/kZcEOlQ6S3GEMoHmUqq2gyByRN3B9wb3PVFYhW+DEUz4ZWIl9J
	hpCo0U3Ozg4x5Bqf3xit0rwNXyWHycCum7iUAFrmK12t9+fvBhiJJJ6y37cJ4Ta/nahd8JByKQI
	YVx0VrV8t5RcRFVjXQZymukLF9hj5DwCUeLP7sdHyi/mwaJ4XdaIbcDyVZs+fLHTbAFfgsXCEnJ
	haWng0V2iPGrjxMX8X3698hUPNsLYF4E43sEsFLFdk7n9U0RhKjzs+wHH+KR/aWqp
X-Received: by 2002:a17:90b:5543:b0:35f:bddd:3860 with SMTP id 98e67ed59e1d1-361403b18f5mr3379913a91.6.1776436540226;
        Fri, 17 Apr 2026 07:35:40 -0700 (PDT)
X-Received: by 2002:a17:90b:5543:b0:35f:bddd:3860 with SMTP id 98e67ed59e1d1-361403b18f5mr3379859a91.6.1776436539609;
        Fri, 17 Apr 2026 07:35:39 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361419739dfsm2325369a91.13.2026.04.17.07.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 07:35:38 -0700 (PDT)
Message-ID: <5c04e57a-efc0-f5f9-f53c-04b9bcaa1c8d@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 20:05:30 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH 06/11] media: iris: Fix VM count passed to firmware
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, stable@vger.kernel.org
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-6-7d3d1cf57b16@oss.qualcomm.com>
 <fe1e2ef2-dece-4864-a89b-a311b3ddbfcc@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <fe1e2ef2-dece-4864-a89b-a311b3ddbfcc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE0NyBTYWx0ZWRfXwvKNG6BU4biQ
 Z4AZ9Jt9vxVc0zQpVDdU33EjWh8xBIhpQ3xXgmGSRJyZ/pb2ruFOM+RYkpTtm00wF/miGeEiPXV
 nI7lSbgCw/q3PNy5D1L/E6Qu7SaKi/YvkaYROTdA0tMur5mOQNi9oyWIan41Ux8f9LkfCMg9mly
 gjXD3yW3qgzr7rIIiMI1CPtw44WmJCx2qQleBYSVa2h6eU5h5EUcmFRj3md3pzFJkEqzBqo/Tbu
 KmxC1TpRYgTU478hd6Z3vHBQJEZFvmRo27hji6KhBTKY4Il9sVzwJVy07z2k+MuaXFp9VL2LTGD
 mF0kEIYcLBfnXk867YRL4b0+k7OzLZu05+6K8HSIWehcSJ/X/ewf+x1V5on2Ul1OXLkI68c6b+K
 qihj4P3MDmzK1Llu2F94ORy/vJjeMd/TDSklMOEghgXSZ35JZwWRDEmxMF+o8aYEXG2wp9FIKRx
 5UHdhXxe4xyitkwVPCQ==
X-Authority-Analysis: v=2.4 cv=BZPoFLt2 c=1 sm=1 tr=0 ts=69e2453d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=y21pM0OG2rRs8fqayMkA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: JmguZRsZDkU2PHC9u57RiBhsXGV9BMaO
X-Proofpoint-GUID: JmguZRsZDkU2PHC9u57RiBhsXGV9BMaO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170147


On 4/14/2026 2:59 PM, Konrad Dybcio wrote:
> On 4/14/26 7:00 AM, Vishnu Reddy wrote:
>> On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
>> the number of virtual machines (VMs) and internally adds 1 to it. Writing
>> 1 causes firmware to treat it as 2 VMs. Since only one VM is required,
>> remove this write to leave the register at its reset value of 0. This does
>> not affect other platforms as only Glymur firmware uses this register,
>> earlier platform firmwares ignore it.
> Should we write a zero there, then?

zero being the reset value for that register, I would prefer avoiding to 
write unless needed.

Thanks,
Vishnu Reddy.

> Konrad
