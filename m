Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5F739DBC7
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776438204; cv=none; b=YreS+Go2eTO6acQQs+lRRWar3KD9k7RJ74IMqF883oHUlV6e5y8JsCNbnmBIS+EOzzstK801bJX6r3UYHjemyA4ZSalg8tW/pp5jKCBvHJGu6skgmXqgT5P9bw0doj/6yeJlfBS/qmlJtPTWK44wjDqkyiVo74nGaLU3adUyicg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776438204; c=relaxed/simple;
	bh=9R8L9pnEC6/7D0qx0eTa9FTB2bGqiw8EzNmDTrkkM7o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YYq5dCPCGau0WiJy2V62n7vJsXZTKdGg7F6tum7GBmTDLzshLROo10Az2hrcyIBGmFOrh9q3xJUw8uRAI8IfE+SvXQ+PB6HGwPeotzWPLuNB6CakCr+bmWPcsCFvW7uLqkGZkaTnIO0KnFEGiPGrkIAVrNn0QAaqhaAunNkarFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kfko1gwp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FzbL8Q1Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kfko1gwp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FzbL8Q1Y"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63HEcMnj1092073
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oFw7s4390u02QSe6dzeniTny7yN1q34Z7uu2sNp1DC0=; b=kfko1gwpf+VtV+3y
	64tEFrq5mtt10P0ADLXlvcmSqCRLBHXDt5ACIPGiZqG363Aa2d3tR0FL+ddm5wqR
	Q6C5mhhPzWZhrDMP8mOfRMnDoqQsA2mXo82Vm5Ra+5/zzrV2ay/HyYoRc6p3v8K3
	9kFca3ckIk1XGNCpolG6evdGkhD3TWwXQK8oFmQANbRblJRihxgsNTmELr4z2559
	QGLH78DHintV/ntlLW9ma9A9jivkmwcbjz6UOLeAb81zdFUOVQzFeoCErffAGXOT
	mXpUWuZSX6OaXnU6m4Z1y6gfhvQthi9E/GiG0ju4zEE3HEX4dgPm/L6ELsSvaUOE
	C++vhQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk227vmfq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:03:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b4654f9bb6so9358025ad.2
        for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 08:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776438201; x=1777043001; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oFw7s4390u02QSe6dzeniTny7yN1q34Z7uu2sNp1DC0=;
        b=FzbL8Q1YPNHdQ/mN3Pj6ieUxBm4mdAwNzXVWzkHIPtXUF8NRPeKhQp+llhd5nrP6cJ
         UhQg/nOee+nPCr3BiUCCsGJTS9wikEZ11v2Zi9DQ8E4FslaUHf2Vxf9rrQa4pjKpaAiF
         hBHmfSo39KRqPhJrJCCZ9xTBzy5l8PGupTTNl8I2V7WPzJPLFVBWLENfxf62EN0jEsgd
         7kp6Wh/g1KXeAYumjxcYBvx+ordc7Dtl1T8KvJfRw+0ex5CPjMoyapyM3GbbvD9KErav
         3m3fy/sfTGWSzPRKjnmejfKsIJk+z+OsvbqZd4YVxN8Ztm7QfEVIE5+f2wiJhTDbhBth
         wMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776438201; x=1777043001;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFw7s4390u02QSe6dzeniTny7yN1q34Z7uu2sNp1DC0=;
        b=P0rtK1Omx8PCdBOaFKfuePDBKKt9HbSBJjkSQdY9aSUWryCqEcUkRcvwKmBfrKIhNY
         Ze+pbbbAMcHrGQRRffQs87P4khxdpTtlY89XavYsBIvztVEa8mZoWESK053TTHtkIphC
         LAAqJoJltCNFxhiYlHChMMjNYucvYcUx9Cq1GL2hSi7tzwVmskr+/sSrGHw0Z0hron9M
         pw09P3kDwUKi6drKZ63VHi5RPTdgPlorU6iGt12HiCyxGZhisi2iWS+tL2Mq5mlEE8gn
         UJULD9tO9936Fobr8irW/x4cfh2tMLkSRfgA/HQbmYC5n3CuNQjPHLxID4BbuNHoWRYN
         YJjg==
X-Forwarded-Encrypted: i=1; AFNElJ/D5Ucmkx89xs3RiivEF9TR9HcxnVYJcV490uQDK8JBby/sT61aP5iv0BFlbuOHycpE3aUwyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0AdUY+1MCOXhptPuqOdZzZu00RGcDvO+s/2MxaMVPg1fenTDy
	se3xuZ+mzG22moK3+qjND68SZfYGl3c7ClaKbgVbnNSXRxDi3pGkVt3GgVg3PjRiuDfXnxUTTyv
	8zAmR6N4wiSJ7kWXjO99TbbhjZIntnPBV7RwkjPEGURgz+Wk6m8HUgjSqKA==
X-Gm-Gg: AeBDievMijxfz5YulLexdfMGYAUM8DIYJQumOmq+vdf2zHDs3+HSREtzj2YtqXyxrIe
	MM7obkq3gsKfqHU0Ilr2KBGextV0pD7BkFmvfgADyAXJvuapJZWbIwYBWZMXf2n7JLD62uJWCqx
	eXICc/Vt+5623aO8RMtEalfF9LSz05eA8rlkNvb/2M8ZHGrFkGp6f3UJjtgkUeqrJQEsQz0YWJM
	k4141860zXLy7hiwquIYc6XglLyWXkTNjV1WqpsofNS/r/4718Y1PJKTfnM0HzbQcE61YbdKp/+
	uSMbv/8XTQkn1rgmrNJ2lzEx/646w+TcPuJrmEJiYmUtJnoDvCpcUVkKmIKcmR2QdrjPajqoyuv
	Atw4NtSFRdL+xKIyR4MlkppiZJZqVb5wC3CDufH3l7wBTzOp5yGE4ocr1G41unk1B
X-Received: by 2002:a17:902:988a:b0:2b4:689a:e420 with SMTP id d9443c01a7336-2b5f9e7a9c1mr22893345ad.8.1776438201040;
        Fri, 17 Apr 2026 08:03:21 -0700 (PDT)
X-Received: by 2002:a17:902:988a:b0:2b4:689a:e420 with SMTP id d9443c01a7336-2b5f9e7a9c1mr22892455ad.8.1776438200160;
        Fri, 17 Apr 2026 08:03:20 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa507cbsm23809775ad.37.2026.04.17.08.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 08:03:19 -0700 (PDT)
Message-ID: <9d97d9c8-29ef-3419-464c-2db642759d39@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 20:33:11 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH 03/11] media: iris: Add context bank hooks for platform
 specific initialization
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
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
        Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20260414-glymur-v1-0-7d3d1cf57b16@oss.qualcomm.com>
 <20260414-glymur-v1-3-7d3d1cf57b16@oss.qualcomm.com>
 <3vuensoscjzsjuh7c5e3jff5cej66iwboiau7vhnpvtmqevexf@ouox5cize3fn>
Content-Language: en-US
In-Reply-To: <3vuensoscjzsjuh7c5e3jff5cej66iwboiau7vhnpvtmqevexf@ouox5cize3fn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE1MSBTYWx0ZWRfX7CUmakAkmWk9
 kVbBKty8hPx9TXegupT6f01OF9HL43i2VR9foTvuJakrZVQILpcRD3eZlFPQESpOXBkpZYc71Fz
 HxEbVTaNSYgjeOs0UFBi4fPvL88kJeY6Q5mfYfd/aD3DbVQAYIgvgzJ21R64GUC32DfEalqntUs
 OpOrbuaBzcR/0WOfYA3FYpGeOm/ndY6xS6sYk2dDKQH2W8OWdTiCA5RLDmjJMrF0BxIdW8gKFP+
 GamBKA1enBk6nDlWEytFpeB+eno7PbAVXWd7DPjirdI+llJiMKLzQgJKpG4GqzSqxx8TZBRzrFW
 DE7/onl0Xdhz43MGJiFxnu5xh4BF5nJjcaQN4hPb/U7ZuR92+h5uwklvc+jwYplRC1g60agTT39
 w1vvdpHitWz8yeFYXa0vZ11A9j88Md0uSVxi52LTxwDYzJJbhudjNlSs1b2BcB0XDj/J9aF9ASD
 EP9LFOLdCFYVeOIJp6w==
X-Proofpoint-ORIG-GUID: NMDwnOy5Sqw1fnx9ib4nVJpx-kFsrK4N
X-Proofpoint-GUID: NMDwnOy5Sqw1fnx9ib4nVJpx-kFsrK4N
X-Authority-Analysis: v=2.4 cv=Iuoutr/g c=1 sm=1 tr=0 ts=69e24bba cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Gxg087mSlOwoK-wMwRkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170151


On 4/14/2026 8:46 PM, Dmitry Baryshkov wrote:
> On Tue, Apr 14, 2026 at 10:29:59AM +0530, Vishnu Reddy wrote:
>> Add init and deinit hooks in the platform data for context bank setup.
>> These hooks allow platform specific code to initialize and tear down
>> context banks.
>>
>> The Glymur platform requires a dedicated firmware context bank device
>> which is mapped to the firmware stream ID to load the firmware.
> Change the order of paragraphs. You should start with the definition of
> the problem rather than putting the cart before the horse and starting
> from the solution.
Ack.

Thanks,
Vishnu Reddy.

>> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
>> ---
>>   .../platform/qcom/iris/iris_platform_common.h      |  2 ++
>>   drivers/media/platform/qcom/iris/iris_probe.c      | 23 +++++++++++++++++++++-
>>   2 files changed, 24 insertions(+), 1 deletion(-)
>>
