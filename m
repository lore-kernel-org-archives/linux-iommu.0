Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3B9244692
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 04:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769487312; cv=none; b=Fa1bw2ORvV/xlT/TVNTC6U6RfMB+0MacIzt4yR8PZiK3PONxVbEqbmyLe7jo7QhwvCssAIcR8KMApfwaZugEJHti7kfLgRz8KdOjBRvYqidggzfQey4VqD+D3GEdh1D6H4+A0gsZLs4I+DhR07OtxoW19ZPgVavwxxewWYk7Hyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769487312; c=relaxed/simple;
	bh=xDoav1BfW2wI8Iv+YupRqR17ieEF5LHWM/T4d5wyYmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWhDovgTTxoYHJdO31kkWTFJzhBPV3aeTpGnvO5ADd7H2vMd19FDg1atSZOUIfnxDPmxdnm7tkesqVQ/bl0S4zUyxo/7+IWfqCH1nAeUVDA9C/dEu2HbjlKb9zYNkZTJpj1e6dcnrWZ9gOaUeK6iQ1Ptmljc9WhrpFDDr8ozGbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D9C3sVbt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RfLIr7nu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D9C3sVbt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RfLIr7nu"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QKgKe83912708
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 04:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yR3aK7XyKr62djQaHFknCTq+ksn7q374+TYHBAPMHvs=; b=D9C3sVbtyvzpfTpv
	v4PR7w/M2VJsuPUqxwbgtTnhbREm2J3m5t9umuRiBRCttObko820HzQkhya8qgID
	/HGeaenw8wGG3dKjCSgg7xVOXJqKwr+3tFz89FSEh65oUYgral2B1/k3CmDVPwbi
	1egLMCiXPQpmb3bpUXsJc1lTBov5aSPIskNVPCuWPvYendTLpUMjnOJezaq4FHKw
	9pHYvQJwcL8blqxKnz3gGnKBZ83opsHpTaodD+Eiqf51UvIv54htxic6/cYRjmm5
	GpNGrrYw1U0QMhlrE2DArNfmrgOrrz1vd6L+CaPPZydxzcP/f0ILhtTMcZ2wV+fl
	ZPmlDg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxew3s6cf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 04:15:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-352e6fcd72dso8167681a91.3
        for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 20:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769487309; x=1770092109; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yR3aK7XyKr62djQaHFknCTq+ksn7q374+TYHBAPMHvs=;
        b=RfLIr7nuK7u6yKNvXYQwiJrFQrwQEUyX3NhjN5h2RJmT5BG5EvW7dZfr4U2sqnQtsa
         y2Wf7Wg8mjZw5PoTrIzi2JOmhRy0Of7ipzKvBFax4J2e7h8L/tOhaVBBrNM8EPO+FawY
         PJ8uLePfzboaAjhXiY68qPWVegHwYBQUgMup7TgBVz2vniMacTxTQL/i/qiTb6wuv3N7
         kRIGIwQcJOuZw1n4lZHH5UCOaowxR+iSA1qjZVf6zBKL+1Bo5LBqV3nMzmv9MZLAFvZ0
         5vqfD4lai1VAMWfPWIBf9Axq2mz8R1C4Pj47eNv72hIVqL3cSIN9LT9XDTzxTMvJUjzC
         U26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769487309; x=1770092109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yR3aK7XyKr62djQaHFknCTq+ksn7q374+TYHBAPMHvs=;
        b=wSTAwfj55tR3N4clwiNcE0XrHjlFO0sq10/J9byUNIukFE6/+pAiufVp+7pT4VGSgT
         EVuqzWSFXZQd2uK/Y/yM+ZDr+WyT9S6cw0IvW/O5Iu2YKfLhfdPvEm+JpwWUVM6CRkAU
         AK8+5bxCCQPl8sg6gYXqdifQBk6IgJJEXLIAlBNlEx+9eKz5ZWOODNaIRvwVh29zgPfk
         rQ5qWBBoTfn8AcGTmUjyXLcVHCf1bu+AVSr47BvmhZG+1BAmc0GR53enTYWCLxR2NlKD
         bXBk2ZCqDRKmadnn1qENiU+2scmNKhSO8wa1Bf31ktauTzBmXMB64coPS6MB0V35+Q3p
         wQPg==
X-Forwarded-Encrypted: i=1; AJvYcCVrhNdaHa0xoKg0H+JwFJLuwvqEaMvDoD/LyMuKfl69Wn4mjwHRub0S3/476LoIopXdsrV7ZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzmehv+MciK+kNPrW9BS3Cpzmxp8h33Ft40UkfQpYVcexOZqsF2
	QZ3W7mGJc7f4YYwJNcs+pOwJmb6RgT1SxzwncUnWrfJPY9qXfpt6JtCstlPYIhej5Ixl56LiXSO
	1M4WD5aqqjNWNeH/w4lXNF6K37+T7DzQlE1LET0rF7Yu4ZPlgrfleZ0asqQ==
X-Gm-Gg: AZuq6aJ9siB//tpIStnI/Wpo0jh6uEvyYMgE47X/Fetqbtb/4TM1aVSo8UNP2Onts58
	jdogSR8eok3N9NmCeGFNvWmZosVZ5hRnHuCsBRm1dzL0PvRin2y6cSTaGtM/M5t1Gxm9vJISBt+
	rAK3uEhjnmIVF4JuGClFzhEa//Gbq3bvylUCRfKr05v919AFFwjUAf9mxCAsrqRFlpHq0gmSwSh
	+DNYnaG83yHZFbN1E/Dl9X4RRx9HmYX3LXg5/viAXuQ/sgrI+CFDo2St50ch8A8Nh1mcA0A9fgw
	Ulty0ZSGkU6U7CgzI2uxjiw4fz1HvctAr42UZ70A9DWlK5gGuqmvAFsiwpRzFKxrALxe7MO1rGF
	zyN8AQX0UhpDQ4tkTvszqQANhxt+u96NaIMj+HupRNVwM
X-Received: by 2002:a17:90b:50:b0:352:fa96:5137 with SMTP id 98e67ed59e1d1-353fed5cb28mr515809a91.21.1769487309459;
        Mon, 26 Jan 2026 20:15:09 -0800 (PST)
X-Received: by 2002:a17:90b:50:b0:352:fa96:5137 with SMTP id 98e67ed59e1d1-353fed5cb28mr515792a91.21.1769487308971;
        Mon, 26 Jan 2026 20:15:08 -0800 (PST)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f612917csm931826a91.8.2026.01.26.20.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 20:15:08 -0800 (PST)
Message-ID: <def02695-0c39-4a65-859d-17ddaece7d6f@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 09:45:00 +0530
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
 <21b3f41a-d480-4eb1-a02e-c2ae411f3dd9@oss.qualcomm.com>
 <CAO9ioeU8-uQx4cJ=_nPfQ_ZJ=ZUAwwCYrehSqLw5X-YBVnFz3Q@mail.gmail.com>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <CAO9ioeU8-uQx4cJ=_nPfQ_ZJ=ZUAwwCYrehSqLw5X-YBVnFz3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YbX3jKJpKxEzXzo5nLaxU_0gdQocUPJZ
X-Proofpoint-GUID: YbX3jKJpKxEzXzo5nLaxU_0gdQocUPJZ
X-Authority-Analysis: v=2.4 cv=J8CnLQnS c=1 sm=1 tr=0 ts=69783bce cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=HnkMKtxlUvcyAqyK8NAA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDAzMiBTYWx0ZWRfX8WsUL3GUgvcl
 CGq5s225UL18k2tE9U/WHXGIf4FU0j7nJJxIxttmOFCBNuH83+z9PMEEmZj8k2cx5+pkb+EZZ6l
 MoBIWrxk2l+M6UVVoEoTWQiVjRk0lqJtR8WmDqmCFtMk29l0trFO48kKn9IJJGwtoBhCCEOWj4x
 ++YbR/pLtS6tYqtDhpvPz7XM46UI2q/MXsu1nwiwCCujG70jzUnZC7GKQoWHlPP2nYQkI9xPcjR
 LKYQm5KMEeMfRcxJCYUV2rl3udizynb0TMKxv3sDJRIpYTr9Lxls3LqcKBhKrguEOs7qfnwUG06
 FQKVWY6waYYgK093NRrHPUqaArJXPzakBIANzlqpflnDU19scauXxvscJ37RmHg4Q111KI8Ocxd
 HGoEzLlzQUrHDbFIdqGASYykyVjBHcV22tUdWTtNkrmxb+kTz8RAo3mHpbnTAxFpAfDG7OeL7TW
 0syluxCdrGEmWdS3CMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270032



On 1/21/2026 12:08 PM, Dmitry Baryshkov wrote:
> On Wed, 21 Jan 2026 at 08:38, Vijayanand Jitta
> <vijayanand.jitta@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 1/21/2026 11:30 AM, Dmitry Baryshkov wrote:
>>> On Wed, 21 Jan 2026 at 07:54, Vijayanand Jitta
>>> <vijayanand.jitta@oss.qualcomm.com> wrote:
>>>>
>>>> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>>>
>>>> Introduce a new struct type where the optional arguments passed to
>>>> of_map_id() are Currently embedded as of_phandle_args struct.
>>>> Subsequent patches add additional arguments to the struct that the
>>>> caller expects to be filled of_map_id().
>>>
>>> Which additional arguments? I don't see anything being added in 3/3 of
>>> this series.
>>>
>>> Can we use of_phandle_args and switch to of_map_id_args when it's
>>> actually required.
>>>
>>
>> As mentioned in the cover letter, this change prepares the interface for a
>> follow-up series adding multi-map support, which we will be sending out
>> shortly and which extends these arguments. Keeping this in place avoids a
>> subsequent rework and keeps the overall transition incremental.
> 
> Could you please point out patches adding more args.
> 

Please refer to the below patch series, it extends the args:

https://lore.kernel.org/linux-media/20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com/

Thanks,
Vijay

>>
>>
>> Thanks,
>> Vijay
>>
>>>>
>>>> Suggested-by: Rob Herring (Arm) <robh@kernel.org>
>>>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
>>>> ---
>>>>  drivers/cdx/cdx_msi.c                 |  2 +-
>>>>  drivers/iommu/of_iommu.c              | 12 ++++++---
>>>>  drivers/of/base.c                     | 37 +++++++++++++--------------
>>>>  drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++--
>>>>  drivers/pci/controller/pcie-apple.c   |  4 ++-
>>>>  drivers/xen/grant-dma-ops.c           | 20 +++++++++------
>>>>  include/linux/of.h                    | 32 ++++++++++++++++++-----
>>>>  7 files changed, 75 insertions(+), 42 deletions(-)
>>>>
>>>
>>>
>>
> 
> 

