Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA293D88F5
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367568; cv=none; b=qCCJACs3IgJi7b6w+eO8tZwH+UocgQr98irKNjrn8bCjg6GV6048S46yvNu5b2lHR4HEi8VliysNY3um4i2Ive0ZybRtq9WF8jO1O8z+8vA+r2kHm92O0tq0ZLiqLv0SoaWyUmh2PvP9Q3eLDgfOJOMNCCd+5vIcDwM3UXPamZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367568; c=relaxed/simple;
	bh=MF6Yl0cb4sJbEESk0My1jj9Kp3v8QAV6KskeS18l3tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIgOhuL//KqFCbzLzFxeXm0+XE9y0kk4OQws77dJa6rSgFZBH7MFYrsvuRiY96o/lJGIdP2kujYvD8yU33QFdZ3/s4pQV5RabvRkSoUA+FC1mLBnepIImdvW30xX6+QqrRE3piLGLJyi377HPQVWv2yO0E04zVcW9RJqPYgnrRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bb5E48/W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iltmlMlt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bb5E48/W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iltmlMlt"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S67iYD1625050
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 09:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MF6Yl0cb4sJbEESk0My1jj9Kp3v8QAV6KskeS18l3tw=; b=Bb5E48/WHkMcUQN5
	qTc3Y2bO0rNm4QpiICkyhIxbVSQZ7j87CTqWYfkkF3R6sehoF7awpWWV0dpH9v3Q
	JZYe/+Cl3SngRS20Qzim4iVJk+oyj2/9NJRgKXl2Z9aRZ7+kPjw5I/ZYEdZruxuE
	AmjeivTQxK89DsB00ofLhTOta1/BPjbXjx9n7+iki7em6ZV1teecxIaJ1Q6oYT3c
	/90b+TqoDUChueM7Ohao1+8nyv5ZO8n9crkSR4MRqeprSoviufuyGH69G596DCuk
	3OyXJA48gVW3zbsxnGDVOay/GDcK38kKJcK9mNJ0qRnaWwIDQ2OKNhMSa6FsyBLO
	5uLtLQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtgmsa64q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 09:12:46 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so8573544b3a.1
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 02:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777367566; x=1777972366; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MF6Yl0cb4sJbEESk0My1jj9Kp3v8QAV6KskeS18l3tw=;
        b=iltmlMltvQtKbC7vq5NEsJJ/fztYXFUgUaAhgIvqUtf8xMQxysBgm7yHsNtIrZvmQX
         yyAYlwDVNQzcWJWw3SOO5ZQCSE0PTohqr9S7x7idCF9BeXkhfquqO5/6d9uPuL3Rqz5W
         3RYDbxLpQpHOKcdFy2aRRPOtFC0XTx++SxU7SSVHH0EE5HcHm3zsPjFmTy67mp0u6Pc5
         qrZXOybIi7vvI/nKgr9edLzVo4Mpq9LcaclQogvegCirRAj77p2eZXY/h0tZWZ/TCJnk
         YaQ4iIoJm/Hu0MosF7qUAcbmuE4KrBsv9z9kPinLh6l22LBd+tNLB8sGkEcJsXG0cFuJ
         wewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777367566; x=1777972366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MF6Yl0cb4sJbEESk0My1jj9Kp3v8QAV6KskeS18l3tw=;
        b=HbLoEB86UI7jLkCityJZJq65mRpnGeEvlVwc0uLP1r3Pi5elsSXu1c6rivrYMEMNvJ
         1hLRfcZAaWH/o5thzirrLmeliSx+kLNlRhMLmgKjm378TP+yF1n8znUGWWb8/16gWbk7
         OGZR4XsmXgzcLVrstPkwQw5yKgAtylpmriDfQGhuJxke3dxPUBRfVex19QvDCcBHp7vT
         gK0pILR1+a6u/w0azqql9HOu8Zh67i0scMlT8HDGoqbhs7JB0FRUkC/DEEtUAJWtDcaE
         fvq5yfRX4tphs/Y883vgxNgUoM/Im+ZJKQVCbYLHtqaKSeP7PTI9j0tfAFBTQxTm7ncP
         30uw==
X-Forwarded-Encrypted: i=1; AFNElJ8v/vDnxpXBxibWIXt1bPK2csI8LlScw1+nLar194O4NGA2bKGggCAFzLSX5UVxsBBI/lvypA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkG7FuuedvCjzO3jUApv0xd2LbfAmqMFVA35q1Oc+XH7WZswcc
	h4xrb7s+4+kRWREiVrAMfNoSSnq+KO8EvOK75OdrAsIPocXYmYRV0F/vNUnSjAxJ1YnxlGPg3fQ
	VeSy2x5K+gZYr+PzlN6W3kcaXQ3+xCUVvP2F8fyTmizNkIiMyuGcRS43TnQ==
X-Gm-Gg: AeBDietiZqD6hUjj0IYJwRVn6+i+j66VRWRnbtRvD/zDrkZizVzQBLuojx6LiTuFWO2
	hVOXc42fnWOk8tg+z2Skowe0TkA1go3bDLVEfG4ulTrLsybaobCkGG3gFMjRe4aKllPA0bAb1ap
	fEWTMIRUjRKbc2KNThOOtFAL5Cp1sDasQHBuxSph6v0NLMTp+sqPe8wQX3EtnZaBrITE/hl4rlP
	7gipgFRl2tVJ3bMR7EGdI6fOmNcufeLy/gQATplRiSXpwyXF5mdPosnpu5QojX4VvleVl7f6KSg
	1r+kS5S8QoKEcMGbjh65OELNPSNIktolhR54K0MuF8mA5FYqKui5R4mOud7FZZVTq32llBfs2b3
	Wa6MtqPheFPN9RnZcgmf0HKLXHwONXXwyRBUosMzCWK1O2O2ZCc+J3kXCRDd3SAR2
X-Received: by 2002:a05:6a00:4b50:b0:82c:9c90:6ea0 with SMTP id d2e1a72fcca58-834dd246ac1mr2019045b3a.3.1777367565617;
        Tue, 28 Apr 2026 02:12:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b50:b0:82c:9c90:6ea0 with SMTP id d2e1a72fcca58-834dd246ac1mr2018998b3a.3.1777367565123;
        Tue, 28 Apr 2026 02:12:45 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834dae00e40sm2480834b3a.12.2026.04.28.02.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:12:44 -0700 (PDT)
Message-ID: <6ebe28dc-b8a3-db92-0e66-3f0541e23e13@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 14:42:35 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 02/12] dt-bindings: media: qcom,glymur-iris: Add glymur
 video codec
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev
References: <20260428-glymur-v3-0-8f28930f47d3@oss.qualcomm.com>
 <20260428-glymur-v3-2-8f28930f47d3@oss.qualcomm.com>
 <20260428-nifty-quaint-hoatzin-6de65d@quoll>
 <97aa5f18-d1d5-f082-9075-a385255f2e97@oss.qualcomm.com>
 <7d775357-c7b1-4cf5-af90-012d1364e773@kernel.org>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <7d775357-c7b1-4cf5-af90-012d1364e773@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: trwfNbgiYllyQrA3Soxj-F3gn0MCubE_
X-Authority-Analysis: v=2.4 cv=R4gz39RX c=1 sm=1 tr=0 ts=69f07a0e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=H8TGg1LnFfWU2mlYB9oA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA4MSBTYWx0ZWRfXwGyxRZWeTV7w
 1U0gOiBvvR5VxZRuFj+pCo4a5KiRoTx18Zf3gtBfDDClIMFlWmP4GhRepG4DES+2x43dwiifu4h
 xIvHh0HubEXF7nuWh3Fp91aT7y0ogcc+eZN3egopwlZyNTZgHPjpxsfBOVaxg4Jy7YA/CAJYvaT
 jQsEJd6l0JjS/RViFzvQMnG+hbxJEnTqeW2VdmXq08n1kngeiLJM7isuok4ghKqvwVlXr6siz7S
 lVJGfHkp7DiDghdTGXHARQQYixixIt0JlKXqj/AjCZ5dMR0l/fF5SZx1mOC0IivAt1w6yCMfaBo
 ahSbj3bCXTu9jPJ8Hxc7lNEyklVH3MlV3m+8wQKrWDK4PiPoAhghAuz0bT0z6VDY1D61JvmnQls
 0HMgy9vfoyFq88JWJj3b/v+cvaPZuAcuWO5V/ezj1bLNlVlqDcrAIdrSCDZqCYYc1eXgd9L3/hz
 8SIGH5BHBGWTBAW4k/A==
X-Proofpoint-ORIG-GUID: trwfNbgiYllyQrA3Soxj-F3gn0MCubE_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280081


On 4/28/2026 1:58 PM, Krzysztof Kozlowski wrote:
> On 28/04/2026 10:08, Vishnu Reddy wrote:
>> On 4/28/2026 11:44 AM, Krzysztof Kozlowski wrote:
>>> On Tue, Apr 28, 2026 at 09:24:08AM +0530, Vishnu Reddy wrote:
>>>> Add device tree binding for the Qualcomm Glymur Iris video codec. Glymur
>>>> is a new generation of video IP that introduces a dual-core architecture.
>>>> The second core brings its own power domain, clocks, and reset lines,
>>>> requiring additional power domains and clocks in the power sequence.
>>>>
>>>> To accommodate glymur clock and power resources requirement, the maxItems
>>>> constraints in qcom,venus-common.yaml are relaxed. This allows the glymur
>>> This is a very confusing part of commit msg. You cannot relax the
>>> constraints. Each device MUST have a specific, fixed constraint. It is
>>> your task to be sure they are not relaxed.
>>>
>>>
>>>> binding to inherit from the common venus schema without duplicating shared
>>>> properties.
>>> That's obvious. Why would new iris device schema not use common venus
>>> schema? What is different here then that such possibility exists?
>> Glymur platform has a dual-core video codec architecture (vcodec0 + vcodec1),
>> requiring 9 clocks and 5 power domains. The stricter maxItems from the
>> qcom,venus-common.yaml takes precedence, making it impossible to accommodate
>> glymur requirements without updating the common schema.
> But so does every other device, no? So what is different here?

The difference is in the resource count relative to what qcom,venus-common.yaml
permits. Existing platforms like SM8750 have 6 clocks and 4 power domains,
which fall within the maxItems limits defined in the common schema (clocks: 7,
power domains: 4). So for those platforms, referencing qcom,venus-common.yaml
via allOf works fine, their resource counts are within range.

Glymur dual core architecture (vcodec0 + vcodec1) requires 9 clocks and 5 power
domains, both of which exceed the common schema maxItems. Even if
qcom,glymur-iris.yaml explicitly defines maxItems: 9 for clocks and maxItems: 5
for power domains, the stricter limit from qcom,venus-common.yaml takes the
precedence, causing schema validation to fail.

Glymur is the first platform where the common schema limits become a hard
blocker, unlike all prior platforms that happened to stay within those limits.

>
> Best regards,
> Krzysztof
