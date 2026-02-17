Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C796338584
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771335833; cv=none; b=YsMPQQ0P225NaDYOrfiD4oDeWI1JDS5EPSxihYm/T2Zbx7ysLuQq/dC5QW5npUveQhROc5UA1FoPqLwmM2zmC34Ydc2UTXpfesvSSGsSzkuClSHwY4n2BCmWJ/zthXHXshatE/QMppf4fZdvtj3LQJQOngYBBmyAGeDUXDj3yOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771335833; c=relaxed/simple;
	bh=En5rcXsu0Sg3nwqT6oI2lc7tr410B+YGJFZy+mJPGrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UR61turSjugbB/gkPLhb7LjEel/pcDUMDz6mHcUr+kFrq8DR0kmZJIB+WsoIA6JJo46sIc10cw6kAflTtUeg3QZtdUFESqcRfH4fzre++csm8244GDefrZQtSFOebOCmfYRhHw4JwYfmOI+UEFiAZhHhOaxtKAYQ2UMujHBJPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B+eExs9p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AIoFLpsi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B+eExs9p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AIoFLpsi"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H93XiD287946
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 13:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0FIlG1kC6o/WTPSLRgURjMIM1d/Naj5KT0hsIvFpSLA=; b=B+eExs9p86C1dHeP
	B68eEXvrCm/BEIaDYxHDdNawbT3HYWomtDHiPRE6MUPCxaZFl1p0VK4ozUXAxbF7
	ULTPouUYBCJj/MQpx9Q3+5Xz+yskXREgxZZCqnmNA5k5G/NpgLMP/TdHe7sgTOMM
	1T9D0fkuS6HZSR8f+9X26tf6/DBifaaU4sjRZDaJSUCNtPszAwTj3n9heMkPltWK
	c1s+7a/TiD+zcDjOXkckT1cR2omQYNiJ/F+zEygdER9myp9NylNfK0vcXvEo9TXW
	E9RTcjvRAQ1rEcs5Mxb8b1gAkz8uTFcsl6ETIodcaC2nu65diBvakIv1Ns7HzV/k
	kfhwww==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6nrtgnm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 13:43:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a79164b686so56199015ad.0
        for <iommu@lists.linux.dev>; Tue, 17 Feb 2026 05:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771335829; x=1771940629; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0FIlG1kC6o/WTPSLRgURjMIM1d/Naj5KT0hsIvFpSLA=;
        b=AIoFLpsihnWwjuWZglbFA92yMe/HAnZ3kxhdMB6oVz4OPyhkkt+XzXTQ/sJqdRyM2B
         ytX6gNJ6fMnBjuhfT3H4fTRCageGMTa7QIhB2iA10aZ0KYWJTfCCKkzZpCTxhQsDzWzj
         fOH7vXrbnpPiedXZiCxh6kZtOdlzg8lMDsc3gxoxEgwKYBzerwTO6s8aiVezk7qwXAwF
         HkLZdT2nCm6STpwtFEJ4jp0FHyUSDl9mk0Dk64EkY7y2TqNQXB42zeJiUQIz0Y4AJImi
         +Kl+3w8UMaVmGThbzybmFFWcwnwfazQi7PHL875KDTsEfcQHYuRVtU1SPw9U+7bdvKJE
         KILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771335829; x=1771940629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0FIlG1kC6o/WTPSLRgURjMIM1d/Naj5KT0hsIvFpSLA=;
        b=ptIlHm/QEn1qYq/AarPmHnvD7w8EEZBj1J2ThBrU9iZU+U4ByCzhg4jRodgm7s9VW/
         E3rZetfnDtvWDaGNMVdDa/ZiUqcGdC7YFrUJ9LGuGANnUYZD3HPFBaDsMeLgqM+O1gD6
         KoPj77ECDynN+z33sy5FOU0mqE+clPEXxziILyhxmWPRzqHIY0FiP1sqUu9vvtoRD/5u
         Dj9XRhhBhJsU6fVLLvx3pHFuphPnrwtZ6onvFmemmkuwFscfYcdbl88eou/+V0uYuq+j
         CgWfi1E/NLXM/6j5eZSoGxiyB8bsx/u1YeXvczKAbxjfIh1FyB5w3yNlz5mFQI55PSZx
         VMEA==
X-Forwarded-Encrypted: i=1; AJvYcCUv6KplWod27bO+UL+J8zVQLtpjwmeF7Dn9sHPC9A7gdytYIDivG6NGptI5AR7KGg2egLEH1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxozoAzht4eiFxbDl6Uf69a7NE4EJME5x2OmOjs0BtFH+mSHiAn
	b3KkRHq8JvHlCtbO1y+QDl1zD25pEiKg8lrjQWAqRR0seKSxasGPXvaNF3Yu2JfTkcehJH9GyZc
	E6VVIxa4x1V8+3MAVnrSuJ8tgVBZi2wQjJ1Dh7668AQQnGbK1zQndyUuk3A==
X-Gm-Gg: AZuq6aIKZM4Q230nzHzM6XKMPA1ziY5Uvj4hlBtNje7He7aJVmFJIp/Q3MCWNJyx7k/
	FD5FbuAbMcuZBjSdQP+LiyUdrZ+Ppu4HE1fMy8TiKSfOEBoAmTDXUmBey6yeu9YhZpWgycCmknV
	KP0Y+7LRed2r5pC5JWU/lC4eT5IKyedd8IQLeNKLJT6P3ZBWu5JMcDIUCw5aZZtz4h8xByaRjHi
	b8uFSS5Nw7HIV+rcV1ZwczkRT4/xICcW3pe67Sl65SlLF2iBgeC2CW5iKDgaf/XlPWnkvjm9kZb
	zGGiWeth9maviFBs4oSAz+UrUR2acgH5TlbJQokfi7izGdJ7e9ibug4G9GCbusGrdUVkNNClz/c
	hw2uLN2ZIpSUyAmMNWPAWowkwPGHL0u2Sku+PSM1raV/lESP4KiNkbQ==
X-Received: by 2002:a17:903:2352:b0:2a9:30d4:2b0b with SMTP id d9443c01a7336-2ab505d1726mr138802815ad.52.1771335829314;
        Tue, 17 Feb 2026 05:43:49 -0800 (PST)
X-Received: by 2002:a17:903:2352:b0:2a9:30d4:2b0b with SMTP id d9443c01a7336-2ab505d1726mr138802575ad.52.1771335828776;
        Tue, 17 Feb 2026 05:43:48 -0800 (PST)
Received: from [10.204.100.45] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a713e8bsm141004585ad.28.2026.02.17.05.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 05:43:48 -0800 (PST)
Message-ID: <b5ac0ab7-2540-4691-99b8-18d67ac63717@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 19:13:39 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20260126-kaanapali-iris-v1-0-e2646246bfc1@oss.qualcomm.com>
 <20260126-kaanapali-iris-v1-1-e2646246bfc1@oss.qualcomm.com>
 <r642meaclfme7thmb6spkna6xiuhbjuqw6x32jndjqhwqjtbbr@qkcziz3cyxb6>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <r642meaclfme7thmb6spkna6xiuhbjuqw6x32jndjqhwqjtbbr@qkcziz3cyxb6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XKo9iAhE c=1 sm=1 tr=0 ts=69947096 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=vKLMDgmPB5ZtIlX7G1kA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDExMSBTYWx0ZWRfXx+++H+vT7Cdf
 14aqa+4lM4hIlbFuHIdCZEwwlqw0B8NRsZdzi9WKlwGgGNYp6y23vb5OA7oaxzaT6tTYGeZcgg/
 rJUSp4PLpBYBryUZztN8HeRptCd9AtNSXSj0Wwc6jHPuxCFB+yZrzxnV265xqUzQtm2dGkcVBS5
 +5RY5Vi73L/k2NhMe22kcNb0u2Yd0lUIKGc0nTcFmcY0BY3oXSxiX0b3nem7T7AreZcw9THFOKt
 DBWAYLFi9eT4ZIRaeqklK58D+lf1rQD0ITzcGxwkbPAFIq1gN5O7SHug9vBvzZj50c10iWL5BkI
 9oaPu4yHrEZo+thGjDrFdUirhwRrDvk8XuQgu6j1aaV+Z/8nWj8UTZQg/eBW7UOr7Su/UtZHJuU
 OHo4k4DIFLDHYRuZhaCOq5KkAWUacthGIRHR/7jP+M178XQB2OiWaX66TtnmINjAIBdxabXUiV5
 kswYzKMOI4kryylPuyA==
X-Proofpoint-ORIG-GUID: 6GMgvlsX1bPTEEkmTklzrBWD9untF5T2
X-Proofpoint-GUID: 6GMgvlsX1bPTEEkmTklzrBWD9untF5T2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170111


On 1/27/2026 8:39 PM, Dmitry Baryshkov wrote:
> On Mon, Jan 26, 2026 at 05:55:44PM +0530, Vikash Garodia wrote:
>> Kaanapali SOC brings in the new generation of video IP i.e iris4. When
>> compared to previous generation, iris3x, it has,
>> - separate power domains for stream and pixel processing hardware blocks
>>    (bse and vpp).
>> - additional power domain for apv codec.
>> - power domains for individual pipes (VPPx).
>> - different clocks and reset lines.
>>
>> iommu-map include all the different stream-ids which can be possibly
>> generated by vpu4 hardware.
> 
> It's not how it can be defined.

Do you mean to elaborate the different entries within iommu-map or to 
elaborate the different stream ids and how they are grouped into 
different functions ?

> 
>>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>   .../bindings/media/qcom,kaanapali-iris.yaml        | 234 +++++++++++++++++++++
>>   1 file changed, 234 insertions(+)
>>
>> +
>> +  iommu-map: true
> 
> This is totally underspecifified.

oneof would be a better approach describing the possible stream-ids.

> 
>> +
>> +  memory-region:
>> +    maxItems: 1
>> +
> 
>> +
>> +        iommu-map = <0x100 &apps_smmu 0x1940 0x0 0x1>,
>> +                    <0x100 &apps_smmu 0x1a20 0x0 0x1>,
>> +                    <0x100 &apps_smmu 0x1944 0x0 0x1>,
>> +                    <0x101 &apps_smmu 0x1943 0x0 0x1>,
>> +                    <0x200 &apps_smmu 0x1941 0x0 0x1>,
>> +                    <0x200 &apps_smmu 0x1a21 0x0 0x1>,
>> +                    <0x201 &apps_smmu 0x1945 0x0 0x1>,
>> +                    <0x202 &apps_smmu 0x1946 0x0 0x1>,
>> +                    <0x300 &apps_smmu 0x1a22 0x0 0x1>;
> 
> #define the functions in the ABI, provide them in the bindings.

Ack. will introduce a new header at [1] and define these functions

[1] https://github.com/torvalds/linux/tree/master/include/dt-bindings/media

Regards,
Vikash

> 
>> +
> 

