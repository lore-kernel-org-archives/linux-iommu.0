Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4CA3FD14F
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691733; cv=none; b=LVXZh8dFQHSIgQbCc1+83AY963NtPBhjnqccqg31InFhwrp/cqfbO0+RJPwAxct4iqTpgc1Jmkt4jRVvG1rHCVu6WTCYJYdJ7xsF9i99W2cn3nnavGfEN5jFrEhD7olcTdFHf9Jb5+JuAcN4LueKWQGBney/CSFQxfZOeyQBf44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691733; c=relaxed/simple;
	bh=vWw8VNMpTozvTsxTcuJrrcpVmar5XpLh1HoI5fCIVwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFhHUypJWaDAnLbUfp59/wdhxFFb94VChopf6N+xT1Ak3TIFQ16ioacYCLDNYW3omVbo1aPsiMT1igmf0t8x3ofP83fCyMeyFtrCkKjd6UF5xDytpp6WUqOUyLbh2AB7/L48isO3D6C9vtSoRTWR/qIWQmu7uBe+XlawrdhTS6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mwRZJSVh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i5L1h7LA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mwRZJSVh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i5L1h7LA"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DFds6F1242983
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:02:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1Epe/2ttfl7TZzFSqB6s3aukVQ2ELJi+udFPb9frU3k=; b=mwRZJSVhviiSAN7O
	+dPy6BYZtRqNK5TiHRlEYWwo33oPXH28KRXkO3fLIFl8oP8mqsbZ6/K/vPH2g4FP
	iY+aLQ8esUm0nbCHaBB9H35iSHTWjrN0PaDJIkOyxA+wOZNy0KyDnl0INvZYlAZc
	HtMCLt04bs18rofVJ73OYiOakldLt5OkhpR+RHih8NHAkWvFyZSBrvML0sNeYrC4
	J53WCLZCEARze3+WCsT/fRdasYHjx7C0Co8E6TO77OcVUQyLy6DT7Pts+VUwfC0Y
	ng219d1ASQCrh1wtdPjFWHkDYB/G7KXGk2kiWWf8vD2I5X/ieQ9iliYVxeirHJTS
	6YoOyQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4v4trb9p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:02:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ba718173d1so120913625ad.0
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778691730; x=1779296530; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Epe/2ttfl7TZzFSqB6s3aukVQ2ELJi+udFPb9frU3k=;
        b=i5L1h7LAqmSfdO2N6gQNTrC8BBEin4d1VukFe3QBjF3w8bQjKvAk44JzZAJKIYg6KA
         vorqUrGE2bkJrkE2BADUjJO29QqhqQl40WArwv85dgG5HksQaInBP2Fd4BipC8zF0pyS
         S6xks7T4RfPvefYVbKAI0IJ/RSxViGFs7ylsr1GGliLdzfOcpHQQwC7y2c4wijoRNkM7
         YLS50KJg2fKS2AhxHnayordFBxgxI1wYqK1BUr7AGiO93Iq6NqIj9+qP0nG1wh6MbzQW
         Y22j5wK/Y7/7XK1XFv1B1JsLpBFMjsSxq2GE5cKkBdHgHCa8P0GhCAfjQKaEZHJ0u2Ae
         n9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778691730; x=1779296530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Epe/2ttfl7TZzFSqB6s3aukVQ2ELJi+udFPb9frU3k=;
        b=LPAMXVVzVDm+TNUK/zqM+wXz3LXrGP3eSxxcSr60lRETyDVxwRD+GXv3+ks9rQkJEd
         FqyaZUWqFR04WNCYkuhA7lXwmtPszbGjmDDQv/ZNeSd5iRRxlAscs80vKV4JDQ4m06OZ
         WQYO9cFYCOn/KiEl1oorJbNMX470tnUDxeu3Njh5iqQ7NCFl2X+rjtVbBXXAX1oPhbLe
         A+uvEIzzNwNQLxgjs/aq0lPYRc2sZDedHnHO/0hX+iVwYFvomBVbDUKJURl8XspoTOpP
         SiSKnAwrxdjSzy8Ji0fNt+K/8rUq4ewzB2Y+/WOJzyuSubZIbb9/+l7q+GiftbuGEH7a
         YuLw==
X-Forwarded-Encrypted: i=1; AFNElJ8nPU9DOKZXd9FtyRJA+iZONh/HETUqi64A5LQ+5cmgwAMjktu9LQFSpu6GShpW0R34VuDO2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgmQ1V96WprNbuOwl6HCGxb30vsa8507TSTo9d7VPIZ0gqUI/H
	eM+0/b5lplYNxX79026xF+lSqXmHg5qMP9mlRYmizhc7unv8GLeTrCeYSW5e6qISjt7zaTwQmvZ
	r0D4gtJ1ta5NYpxE32LSbmbOTMt8HNIO2eV4TiSj6/P4Gou63/rIHjDlsEw==
X-Gm-Gg: Acq92OFszx9ooESDhqw3qoa/zF95Afh76By6T23//XGTm/jMAuixHzL8kEazOZsdKvE
	f268UdtFEaoewkJXsLgg6v7C7uAuFChF2rF3nNEf30Q8xxjkLo6u9OiOltWwHX56A4ffDq6jGAC
	OhCzFauJeaFdB1h5x3oPC0RuM8us8WCrN2fAhJ6M20eEb+QLBlRJGCkdiqV0eKBvNh//G0KzJdq
	cbefqexUHRgY5AbcZQq8ZPuwpZ1pXc67tv0sbnlX32OTef0X8huk+uA77QDbAZUbsAl7fKWSl/x
	cqC+4/d2JZa0sm3d8Tos9oWSmRobenOgqktTbwrAQIh3i9f4C7Sm9UZCRDMuYk6uO4P5wlYNb5t
	0mZOIlUjJkRsDC8pb9ZJRCoT6SsSzNR5VFojRqUxBFEW/K+34kMGj6hRRMsdaX5EZX5U=
X-Received: by 2002:a17:902:f551:b0:2b0:4fb6:85ce with SMTP id d9443c01a7336-2bd30210db5mr41157455ad.21.1778691728355;
        Wed, 13 May 2026 10:02:08 -0700 (PDT)
X-Received: by 2002:a17:902:f551:b0:2b0:4fb6:85ce with SMTP id d9443c01a7336-2bd30210db5mr41155195ad.21.1778691726554;
        Wed, 13 May 2026 10:02:06 -0700 (PDT)
Received: from [192.168.0.172] ([49.205.255.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bc83101ee1sm141611295ad.79.2026.05.13.10.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 10:02:06 -0700 (PDT)
Message-ID: <b328450e-1bd5-4e3b-83cb-36ab647da657@oss.qualcomm.com>
Date: Wed, 13 May 2026 22:31:55 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/14] media: iris: Add platform data for glymur
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-12-7fbb340c5dbd@oss.qualcomm.com>
 <jfypqc5ise7uezog3lwmmrzddbsctir6ze24ma4vp4zgcuwjbf@4443jqib6nxw>
 <b6dc6b32-26ad-6f2e-dfd4-551e7fd0481e@oss.qualcomm.com>
 <wequp7ogk2az3d7yzfxn7wwlr6k5ng2jwrg6anaidseteuwlev@v47yoo4j2gbz>
 <ad875fcf-531a-49af-b58e-575185c12d77@oss.qualcomm.com>
 <j5uphbr37xxv5fnmt63g2y2ulykeyovxq2ovw5dxikswrppcqh@vrwmxccsrbjw>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <j5uphbr37xxv5fnmt63g2y2ulykeyovxq2ovw5dxikswrppcqh@vrwmxccsrbjw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XIIAjwhE c=1 sm=1 tr=0 ts=6a04ae92 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=6GFGFuPpdQFN+sW0UwB+2Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=BiA4-BlHbpJUGHtcRRkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3MiBTYWx0ZWRfXyhlW3GLHqyX0
 bUKKD0S4pcs4Fr5IWBPh/Gk6Uh9ja9W/qKlB1y4TY/QwC8+uRN3IETG1zqH2EW2cBZXBXu5pNSX
 JWSy6qWbMrvpMo0UT/vhRrbj4WjXoFCKbpLix96FX1/cwA7nfhAoiZI4Os7+Jyyl6E/24HnRKFx
 fbfwZK3UoTobFdy76BdGMqun2GuklP1qrotUnzzmnbRom5hxKFjEtz/cIX6mxcCO7pPuQgpGqy+
 +IZPT3MtsPks/jjgOLOZzQWKSA2CLPfAFqwBEdq1bC2QliX7g0RbpHK/WTjQImSwsiS9ff/Rf+j
 P2AxgcQfK07ZHi9Fj76NrAaptpi/HJH2GRuZjB/UuPVo+OW4MdPVx9U3vqBUNGLq8RVUKweXpZI
 XJ5nbP96eIApB9qxA3CsQDt5jnargXDDCTeyjPC4Tg4rCbudqV7HCPcnw77sbJ+ptgcLbuNeXVu
 iCPl8kKBzgfrgzQzTlQ==
X-Proofpoint-ORIG-GUID: RS4Z52xA09sKNHIhwdm04OYNoIRk_qIl
X-Proofpoint-GUID: RS4Z52xA09sKNHIhwdm04OYNoIRk_qIl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130172


On 5/13/2026 9:33 PM, Dmitry Baryshkov wrote:
> On Wed, May 13, 2026 at 08:00:39PM +0530, Vikash Garodia wrote:
>>
>>
>> On 5/13/2026 7:47 PM, Dmitry Baryshkov wrote:
>>> On Mon, May 11, 2026 at 09:45:01PM +0530, Vishnu Reddy wrote:
>>>>
>>>> On 5/9/2026 2:35 AM, Dmitry Baryshkov wrote:
>>>>> On Sat, May 09, 2026 at 12:30:01AM +0530, Vishnu Reddy wrote:
>>>>>> On glymur platform, the iris core shares most properties with the
>>>>>> iris core on the SM8550 platform. The major difference is that glymur
>>>>>> integrates two codec cores (vcodec0 and vcodec1), while SM8550 has only
>>>>>> one. Add glymur specific platform data, reusing SM8550 definitions
>>>>>> wherever applicable.
>>>>> This leave me in confusion. Having two cores, each with its own set of
>>>>> clocks and pm domains, I'd have expected that each core scales
>>>>> independently. I.e. if the load is pushed to the core0, it requires
>>>>> core0 clocks to go higher (while core1 clocks can stay at the low freq).
>>>>> Or, at least, the clocks would be set to the frequency corresponding to
>>>>> the max of the workloads (if for some reason the cores should stay in
>>>>> sync).
>>>>>
>>>>> However, I don't see it in the code. All clocks and all power domains
>>>>> seem do be scaled using the common workload. If my assumptions were not
>>>>> correct, please explain it in the commit message.
>>>>
>>>> The OPP core logic sets the rpmhpd level and clock rate based on the OPP table
>>>> defined in the DT node, where the clock frequency and power rail level are
>>>> tightly coupled together. Since vcodec0 and vcodec1 share the same power rails,
>>>> independently scaling one clock high while keeping the other low is not
>>>> straightforward within this OPP framework.
>>>>
>>>> Do you have any suggestion on how best to handle per core independent clock
>>>> scaling within these constraints?
>>>
>>> This would require more plumbing and driver changes, but:
>>>
>>> 	iris: video-codec@foo {
>>> 		compatible = "qcom,glymur-iris",
>>> 		clocks = <only-core-clocks>;
>>> 		resets = <only-core-resets>;
>>>
>>> 		/* or core@0 */
>>> 		codec@0 {
>>> 			clocks, resets, power-domains;
>>> 			operating-points-v2 = <&iris_opp_table>
>>> 		};
>>>
>>> 		/* or core@1 */
>>> 		codec@1 {
>>> 			clocks, resets, power-domains;
>>> 			operating-points-v2 = <&iris_opp_table>
>>> 		};
>>>
>>> 		iris_opp_table: opp-table {
>>> 			compatible = "operating-points-v2"
>>> 		};
>>> 	};
>>>
>>
>> clock source "video_cc_mvs0_clk_src" is common for both the cores. It would
>> not matter if core0 is scaled for a specific workload and core1 is scaled
>> for different (let say lower), as the common PLL would always generate the
>> higher of them.
>>
>> Infact, going with the approach of exclusive scaling would be an issue here.
>> The later core scaling command would bring down/up the corner for other
>> core, and could lead to under/over-voting.
> 
> Are the dividers between mvs0_clk_src and the branch clocks really R/O
> in the hardware? Can they be scaled to account for the different
> workloads? 

dividers div ratio is pre-fixed in nature, does not vary with workload.
Again, you need to look at the source clock, rather than the ones at 
different core. Even if they are scaled differently, either in software 
or hardware (assume for now, hw does), the source would always pick the 
higher of the scaled frequency corner.

> The commit message should capture the details of the
> interaction between cores:
> - Can either of them be turned off, while retaining the other one
>    running?
> - Can either of them run at a different frequency than the other one?
> - etc.

Lets capture these details in the patch which enables the power sequence 
for the dual core.

> 
>>>>
>>>>>> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>>>> ---
>>>>>>    drivers/media/platform/qcom/iris/Makefile          |  1 +
>>>>>>    .../platform/qcom/iris/iris_platform_common.h      |  5 ++
>>>>>>    .../media/platform/qcom/iris/iris_platform_gen2.c  | 99 ++++++++++++++++++++++
>>>>>>    .../platform/qcom/iris/iris_platform_glymur.c      | 97 +++++++++++++++++++++
>>>>>>    .../platform/qcom/iris/iris_platform_glymur.h      | 17 ++++
>>>>>>    drivers/media/platform/qcom/iris/iris_probe.c      |  4 +
>>>>>>    6 files changed, 223 insertions(+)
>>>>>>
>>>
>>
> 

