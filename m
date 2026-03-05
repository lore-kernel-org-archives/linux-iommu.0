Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BA537475C
	for <iommu@lists.linux.dev>; Thu,  5 Mar 2026 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713444; cv=none; b=JtocLqCQba1J+XmzCt6w/lpOLFwvJ00g6rQAk4dWX6GqLHHz6cjWHMmrRrF3ZWRZ8fAfhNtEb60iPNAvqEqBgjuDwmoZYDFZJcQWuKX1u8I1mihwO4KWb8Zn5H4msaTIVDDiunVV33hHelayL7/hbpqNjkUoQdi50GwH0f62irU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713444; c=relaxed/simple;
	bh=Mi/di9u/oE49SDz0n2llheT81KKh8sJE3C1SJjld07o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEidbkQ89YBvg5uQn2LBJYFl/LUPd27C1rsv5M82nDssvNHv3dnpHiWXNpKi7CbC8xZfQS72v0OmLguxvUhXvMC0NWHv458aw8w8sqrnfXrbRrO0AwlDRfiMOKbVGDH2nIU+98NGEyVMvvfM2zygo1TNzpn20BfjsW2X/EAZVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZRCppE/n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A4BGaiaj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZRCppE/n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A4BGaiaj"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AFliO1783481
	for <iommu@lists.linux.dev>; Thu, 5 Mar 2026 12:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4X+oK0hBfEQ9a77QBjKKA6JUp6Tb001pf1lNXF0z5io=; b=ZRCppE/nPWBIE+A6
	RKBhh6CrfMo+XuEV3g2gqqjLqFjI50slmBf/Hh8EGFsdIIeek/9FOPb+laUn/wcd
	vjh9og/kbFrMiCZfMdTiL/+hhmgpzP517lwObkNldff1NJkx/1jFt4+UnmAx+qPj
	UCmWvuND3O+iXMiOgY7LRTJYrj4jEMM5ITdOZhcKHQrMhyAyzxYeyZxqjnXIri4W
	J5uVLRk9lv4taDmFWfHhgSX6R3IEC5MvgACC8EARfhEiPmNNV0S2Xw2KfGzBLJol
	CrksPK82CQt/WHCwyy25HUWqWbqHHEYTle5fsZLv3kpk4giK6jA+qbb4XJHFzxAE
	zLqcDQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq1pk1nm1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 05 Mar 2026 12:24:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35980a994d6so24981587a91.1
        for <iommu@lists.linux.dev>; Thu, 05 Mar 2026 04:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772713441; x=1773318241; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4X+oK0hBfEQ9a77QBjKKA6JUp6Tb001pf1lNXF0z5io=;
        b=A4BGaiajnYn2BO4oxZu9MPANSYI6yj6uRWpEPuhnqx76r86f9IONn95kuJs7S7HAVY
         H5xrj4ZS/GMt0w2jnammYzdzly8G6mWY8cjWQhJ4HpNNc07qT8wuZlQejg/MHI4b/mj8
         8DRy5YYzb/pcGek0iPFVbbeAz2BOJ1HPy/p5u9WXrzoejpNdKHKZgnSZYCw1Fo7R1iBG
         5ukCkoM/eCjcnwHLBsWG3jZ8AI5MajXb8F2ha3ZqBonosefbanl0wymf5Ex+9va+VGvN
         iCw1J1wfhD19CHj7FavlVbNhXQT9LanZ0r/iNJVAlLot1YC1yPt4rZX9bUSLS4kEXbak
         kASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772713441; x=1773318241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4X+oK0hBfEQ9a77QBjKKA6JUp6Tb001pf1lNXF0z5io=;
        b=rNurKhxcCgsa7pzRGpdN/Q+UtUiX9Ej+4keV+IwDkr0H2zn6dx+uLxQb0RZoRw2I3F
         Hspq7XO5BzYoGlAF4VcrIoTq+MusSnxkv8CN67aQ8LZV7Eg4fu3xJ2i+b7z8TgdnMUnY
         9EYz2OKgqwc33wxl2ULmDUYWYhydoj0EpgYBeUAbmeAhZMGMxv5MJeiO2P5rjnPzYVHs
         LpvHowNtutAue4SIWfqca1aaUb5wSnmVkmtJubttZIloyhM7hFPbPPgRfTTvq7XP6ZJa
         +1nZQjgWE72oimEjbjgzza3vGI5LbWb95CbGeCxzdpqXxe+5NMe8MLVVDB8LEyvbo/NR
         so6A==
X-Forwarded-Encrypted: i=1; AJvYcCWBlT+Nzatb+88S2AnPbpUPQjFsZMYqF9RJ6Sp2McvuSrMiu5J/Fw2Mokykm/Qvz55O8PzY8g==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywc8FjdZi3+H2jbb6q923IAfWXzKKldvSrwE4wqY5T/ICyQS594
	XBNpYB8m323cxaIhLyITtRpBw1V2T2AUCEHEIj52GMOZDlZStcSngtoFZ7qNBtUvfUDAcD/wYJI
	vZPrFrVihmNXpRrEdsm5ann61wL3BfMX82QePHD/b0PN0xIxQNji8y/rfzQ==
X-Gm-Gg: ATEYQzwBrGrJGs0n44beLI5W9yyjbhoewJ5TF1J6PlZMmWiiffo1KA1NCtUGcDkRkl8
	5AxpCs5xbdOYNotNdx1/9r5osjwMcpjh+vWlGdKxJZqWTB/J2akHHAEVdb09sVlRZdat+jbHubt
	O9e48tLvydRp4VRbwCvtY8eYQEiBews4S6bHcwhpLfCw+34/h5UzlwIaXuwqq+scpCop1GAoyX5
	FR3+f4a5Bt+xgQIVWhQPw+/DCvuBfKRXbHsyumqoN/xPIswTJvRgvp4B6VnI/alFJRzjTfFXMwj
	O2KvMdQUyeZWuYJaRdK9pTRjGyig8TEakDJ00p+pTyQMTkIkGX+9CyYe3vmekvuKy2RG3zAoPpL
	jIj118eUAXxBqbGInK65hdIjN3ZwJvVGCbrCYwveGMu6eb4Pw4RYopEw=
X-Received: by 2002:a17:90b:1d47:b0:359:1821:b4e3 with SMTP id 98e67ed59e1d1-359a69e54acmr5140429a91.15.1772713441126;
        Thu, 05 Mar 2026 04:24:01 -0800 (PST)
X-Received: by 2002:a17:90b:1d47:b0:359:1821:b4e3 with SMTP id 98e67ed59e1d1-359a69e54acmr5140385a91.15.1772713440651;
        Thu, 05 Mar 2026 04:24:00 -0800 (PST)
Received: from [192.168.0.172] ([49.205.248.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359aa1ff04csm2456190a91.3.2026.03.05.04.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 04:24:00 -0800 (PST)
Message-ID: <78f874ab-14d6-4ecd-89f7-4be27720bc1a@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 17:53:51 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-1-850043ac3933@oss.qualcomm.com>
 <4dcbbd06-18eb-46c6-a52c-07a4b17205cd@kernel.org>
 <68db6d61-640b-4eef-8ccd-ab2fbcb58427@oss.qualcomm.com>
 <6a610a7c-04f1-4023-82dc-e9cdf5673d55@kernel.org>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <6a610a7c-04f1-4023-82dc-e9cdf5673d55@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cSBK2lbG9PZEA8dut1oiWsW-muidrB5e
X-Authority-Analysis: v=2.4 cv=Gu9PO01C c=1 sm=1 tr=0 ts=69a975e2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=KPiuay1jFzAquJblYynD6w==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Hr5Ahw7noa96dzT7ZQAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: cSBK2lbG9PZEA8dut1oiWsW-muidrB5e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEwMCBTYWx0ZWRfX7Tt/rYRvtOfk
 i4fpy+yP21fCGixr9hvtfDf4jMp/1v4EsgO0ScCM2tRhdG+z2Mdi/dJja8sk6B+kxsW0XQZAPNK
 g4cfdvzt3i/qNfuTSxEAeqrqskUHU0GR7FFsWezQvuu5n8V19YN3IQjHfDdXYMsN7EnlYLYhO07
 jSlZaxztIhTTfTxMIfW4DwnPYYafG5EK5OEpy2xV5ABgs6BbYrq1JZ1lPetIw+wjyhGzrXuhJ3s
 rh865xObIOxYgDGZ7dL3OlvRC/eiRWgI/DrksLVoIpV5baF0HRJyoDJHSP+8cU+qKA1zTP6lrLf
 0Vf4DwmDEBboYx3XoPM++mYTNv9Hdlz1vC/XnqU6y12Hy1iMoe6KvED0ng0lLlImuku8K3eYrJF
 1ZsFZk18zmY/9lPWo2gpSqfxxP0mj3ZFecKzAi5BUboshKbu+GoHJjMOBclLBBO3ZO03NvnkGYH
 EwzkgexripyFtIwL6Mw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050100



On 3/4/2026 8:37 PM, Krzysztof Kozlowski wrote:
> On 03/03/2026 19:10, Vikash Garodia wrote:
>>
>>>
>>> ...
>>>
>>>> +    };
>>>> diff --git a/include/dt-bindings/media/qcom,iris.h b/include/dt-bindings/media/qcom,iris.h
>>>
>>> Filename must match binding/compatible. I asked for this multiple times.
>>>
>>
>> in this case, its applicable for other platforms as well. Naming it as
>> qcom,kaanapali-iris.h would make it look like kaanapali specific.
> 
> I repeated that feedback way too many times.

thanks for the feedback. I’ll fix this in next revision.

> 
> NAK
> 
> Nacked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com
> 
> Best regards,
> Krzysztof

