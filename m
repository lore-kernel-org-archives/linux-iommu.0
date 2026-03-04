Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD1634BA53
	for <iommu@lists.linux.dev>; Wed,  4 Mar 2026 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638844; cv=none; b=pRRB0qIqAO+RJkywVxO5dN20kU/0jSwCIZ6jha7FYhr5Zt+SQGsUnl/17KeIPWgrW35OHUaOBt4gCYTnYC2l4ESfI2l8RvK8eomHTAxq/XrpPBiEzWDc/FQgXIQe7SgGtc7TzVVSclb1SxgLId54T6+xUbeMnpG8B3pdPEaDBfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638844; c=relaxed/simple;
	bh=PMGzy0QIhL0vRpNSRHs+DPTQgWtI6ilhEm2+hq5tQXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXWnI743ppANe6kITBGyNDLqM6K/u45dZ6l5Ake79rRQakYP8ZEvahULd9VSNwxQZ6RQ0ZnNeU7TgvrNTUAI1UN+3wf00HRYMXXWvSAGv+re2MwSwUSuZE8yxbNCdARjx3sIwtktdMF2d9CSt751ruNH524M6FuZtUIfsPwwfiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jhhJxPqt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QCWUeaud; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jhhJxPqt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QCWUeaud"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624CJfLS152844
	for <iommu@lists.linux.dev>; Wed, 4 Mar 2026 15:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BseyVlfG6qNLJh0pukGQEsnvFe0Y0lazqGGE1966Oz4=; b=jhhJxPqtA5CNygZ1
	hhZPBB3+4LkVrZ/2IrBlz01xpPZcQf7s7oC6SjIYsfGt8t75ZU9MVDVsyiG9iTuQ
	bKbHZHBud3w8ByFGzdYcbYGOD224Zhax+1lNSdGpV9M5OM3uB9CEl3/pbRnTjw6k
	2q1h7PP0/lRyiPHDH6ny9TD6TtNPsEmKMT6dzB3SuT2MiED3CnhKb9ZdTb9gJfFi
	DswqfsBt+T0jxAjHZYnGTIMWJ1zmZmvATvbSZDU80IpF8t37TWHENSC94fqaUHHx
	omg7a7zBtVUVXRqvPFp/z5iSGrjmLH1fH1UTplpGUVFFHhPepOMafiP5CNI/1/Zh
	kTEgsg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp3tvm5wj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 04 Mar 2026 15:40:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae50463ba8so156774225ad.0
        for <iommu@lists.linux.dev>; Wed, 04 Mar 2026 07:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772638842; x=1773243642; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BseyVlfG6qNLJh0pukGQEsnvFe0Y0lazqGGE1966Oz4=;
        b=QCWUeaud6/AAnNivORjoR3odQugYJVIzjeJv+pq9Lo9H0kWJ8h7aTuUqoFmlLWhlpt
         27N1kgdZ3pHkFscjVSIjUOsEW1J1LJsW+TDiAPvxIsHyoPletr6ypXkOMDQ2GuexYyHa
         YnhS2x65afP4JS0as8OsBSg/EKWZ1N9ZC9TwWfh1X0qsBjO4y5Yiyg754CLxtujjNq68
         +0PyJZCAYkgQbcJuP7s9l9zyH+3et50fpPHhidWPhSLn0af6bEg3t+5Rh9aQZEJTM3KJ
         7lJyYplPzNNNlydM8fZCvm2Pq0LayrZBo3hBek9O2fXQs7xfsCN60pZVFYFx/vuiYdlz
         tzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772638842; x=1773243642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BseyVlfG6qNLJh0pukGQEsnvFe0Y0lazqGGE1966Oz4=;
        b=EbEyo63DZ0Bk0CwJo0nOMKUGUY6bN0eadGOh8EmE/iFiDz/Qylmvoz5h7CUeCj5kQM
         KT8enzSyvsp3NgHsOS0HxX3z/4JxlehLaTW/Bz8B1WL+q8LrRhwbanFH6XG2TsLuA2Im
         YaqmJRO50nHYRBkKD0HrsshW5zNyrvuecYV2ZZJHS4MOGelIoz+snIKr1/DDZstXcjyO
         gCNWBxfTYyMP99Ff6x0xrPffSvzVajLjGeK9ZD3i8b+S5IVU/25aw9ahRPnr2sA06XW3
         n/V2szLYKQ8ZmIa4ENXng2jbLrkriSzR05+AK28vnAPYH42LVpoglsnbAEtA9ANcugHN
         g7IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo+i9+tFIDfXXmJ3vYHDDbfYbzj3Hm37UI2gzKLlG8z6OAqQaRBN3vlnPUvb62OXLzvnG7ag==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxm6rvHPkDzvnbJDv0QdieTZak3cgzXJ+p7jJ3IRfddskcYDre9
	xD2mz/7PWEWJ2+3+aQvTCCc+j2Vac8gPGh/k+y/I9LNgv59tntxFq5O1IRfAE6rsUsRV/LkwyuN
	FDYKmqsISGSlX267xLFt1uPDdBOwpg7o9p68lYo4pSJwXZ3KBbhmMP/ZKWA==
X-Gm-Gg: ATEYQzz1AZkIjVuMDh2MTyPunzFRbOoVKvluqe8Y8+J0UlPLzN//oNXAo8Tm4Vphmg3
	ORytj1miipuYEfLpZlr42iv+21wVaNeTONmqscASCyl/RJcHxr59aQP8gOkKexi9LYwy3XtY/As
	pi0uyEcJLq/QxcJrt3WeOqck49VDRoOM/vSa9pEefSSJlrBM5KU2ozZrgZaUCU4DRdfmFp+UjXW
	rC8PvzLh+QX8VhbAruKDpna1xEZSwkyXENO8D1DjhR0uFbV/IOGVQ8KTxOy/JR2fb4X7ezAcu6E
	iMzEiO4/XIF7S9vMvQTQGeOSO62RkWC5xFKAJYCLHTQq4C0XfLb9aEvMyN5edblDEqrzoyNxcN/
	XeWBBg3uvKegz1/sW6jS62acMXPKaaSUpXlfDPMWBfEWCqozdVPIzMQ==
X-Received: by 2002:a17:902:f790:b0:2ae:4c9f:4a5a with SMTP id d9443c01a7336-2ae6aa01e74mr24774515ad.6.1772638842220;
        Wed, 04 Mar 2026 07:40:42 -0800 (PST)
X-Received: by 2002:a17:902:f790:b0:2ae:4c9f:4a5a with SMTP id d9443c01a7336-2ae6aa01e74mr24774095ad.6.1772638841774;
        Wed, 04 Mar 2026 07:40:41 -0800 (PST)
Received: from [10.204.101.56] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6df578sm202097025ad.81.2026.03.04.07.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 07:40:41 -0800 (PST)
Message-ID: <22534cad-8940-43c5-a7b9-01d002943093@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 21:10:33 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] media: iris: add iris4 specific H265 line buffer
 calculation
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
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-6-850043ac3933@oss.qualcomm.com>
 <cbwz5wtd55enswdi2zvvy3d66nsxlemyzdypheibvljnewmkax@kybx63aveepn>
 <ce80e60e-90ca-415d-83af-4fe2e86ffd91@oss.qualcomm.com>
 <hrjwyqz4r6usqvxhnsvtap4byfu2zvumji6whudda55vuym5yk@u6s4heswm4rc>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <hrjwyqz4r6usqvxhnsvtap4byfu2zvumji6whudda55vuym5yk@u6s4heswm4rc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDEyNiBTYWx0ZWRfX2Fz/mCp3sEO+
 4pvpznVF4JKHB7GLPiVkrEWQkqKdYV1lSzJkzvRI+KRgTXHt8e5XoRJrNEYey/Irg9xe4y3wszH
 c5LzfPRITyqudVrqZjgLxYU7QSS230HBsn+dkOnafw3sYBDNz/Uc8mlqfi3LxObQvZqjM6ueXCE
 iKL9Np33NST74cmu5aOv3riI2Atq7vKk/oA9Y0fB8DoFLpSOJlG8NwChR+I9MJEWwtzPtPRNZWg
 TVVay/iKZVFpyi3yF9e23aQuoothSa8ZBQjC1aIg9LxM9BLiog9f6Xg0UoYLuCPwqtLcUTPazlr
 K2clogkKWVQXr8SNAhy9LEmD54KtNs9oI97FLAdV6k1rlpQyW9xrh4uC+poIUnvQ5judcUeXwog
 gOSXduTontCs/OjGUzuTfmD06SUkoOzB/G/VC7WwYkrCCZ1U8mx5iYp2EDkEO0qRgo+MLfTJMCC
 wNoOMy4rNSIOYho03tg==
X-Authority-Analysis: v=2.4 cv=VYv6/Vp9 c=1 sm=1 tr=0 ts=69a8527b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=_JvEU8PJbtvYPaoBJaoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 6DGJoxNR0qE-pIs8HDUcwFtiNpLqcV8T
X-Proofpoint-ORIG-GUID: 6DGJoxNR0qE-pIs8HDUcwFtiNpLqcV8T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_06,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040126


On 3/4/2026 3:58 AM, Dmitry Baryshkov wrote:
> On Wed, Mar 04, 2026 at 12:18:58AM +0530, Vikash Garodia wrote:
>>
>> On 2/28/2026 1:58 AM, Dmitry Baryshkov wrote:
>>> On Fri, Feb 27, 2026 at 07:41:22PM +0530, Vikash Garodia wrote:
>>>> The H265 decoder line buffer size calculation for iris4 (VPU4) was
>>>> previously reusing the iris3 formula. While this works for most
>>>> resolutions, certain configurations require a larger buffer size on
>>>> iris4, causing firmware errors during decode. This resolves firmware
>>>> failures seen with specific test vectors on kaanapali (iris4), and fixes
>>>> the following failing fluster tests
>>>> - PICSIZE_C_Bossen_1
>>>> - WPP_E_ericsson_MAIN_2
>>>
>>> This reminds me of the commit fixing SC7280 support. Should SC7280 or
>>> all VPU2.0 platforms also use separate formula?
>>>
>> for vpu2, there is already a separate formula
> 
> It was more of "do we need separate formulas within vpu2".

vpu2/3 uses the same one currently here [1].

vpu4 seems to be using quite a different formula to consider it within 
vpu2/3.

[1]https://elixir.bootlin.com/linux/v6.19.3/source/drivers/media/platform/qcom/iris/iris_vpu_buffer.c#L313

> 
>>
>>>>
>>>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>> ---
>>>>    drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 51 +++++++++++++++++++++-
>>>>    1 file changed, 50 insertions(+), 1 deletion(-)
>>>>
> 

