Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7B230C60E
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765362559; cv=none; b=WawTodtjkzxulJLON27/qQccyDri0mcRn8oojjuEP+9/hfYjQOw42BFOKQp8QYcYt9usqHjrMa917g6z6Ku4/m3gN13popUJajEvxZceEsR0dnatSmx1Aro97SHPtYlPd2n6ShMDXqAULYWIxWTHRGHYyTuzm7YwDaopF1TW/qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765362559; c=relaxed/simple;
	bh=2/1E21ovLQ+e0CS7XiKOatLWNHMbg0n7QwuDflqrvo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=na+eLsNJaexBUJEXJ57WlquJWSL/3QrsjA3ER8vyRnyM5ugVh50UtLhf6TB+G38OttEJOP9vXQl7dWD1keTXwk1m+H7kKdN1G1T5C0BzUw2s7fePKom2xzuXgt8DUA5R+dWnY+GHA+luQ6ijKx6Ri51JDtlAinzVsqrc8t5bQ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JmHyzB3T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TAhAeFc8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JmHyzB3T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TAhAeFc8"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BA8edMs2493994
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 10:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V7TB6TMdAII9r17Pf+/IOs9Lkjovh8q5VwbcbSGWBWk=; b=JmHyzB3TP5sjEnBQ
	5hvEh+av/Rb9oC5mlQRnmk7h0L0CI3NqGs0NfGLeQvvvGaiaIPxNnbsuemrge1zn
	DXl785Hh+METIUDlEyKn4NHNVwcT1xfJ0jYrAAKtqStOyvpEiNLwbH7JfzalkpgJ
	Hnq4UdmgQ6hdMPQNLqZXsNF+zRtm6TU17RyrCgwoESFOIla8DddGS4lS48XQD4sg
	kvbsjeiVVNUNee2va8RQ2TLx95WBoc3qVyt/3tgHLVVLL5eVItHzeF8lLchYxKyW
	NBNe0pOSSRJWkJZIWynkusCgGF+Fkp7y7I/fNrtHOEQmrLra00iM79210rwUt613
	U6HHbw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ay1xws0nk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 10:29:16 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7c7957d978aso7530354b3a.1
        for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 02:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765362555; x=1765967355; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V7TB6TMdAII9r17Pf+/IOs9Lkjovh8q5VwbcbSGWBWk=;
        b=TAhAeFc8De/xm5OsvqN61HlddW+ufG4HGr9ZO8nw2fEiCqp8qyZ36X4ulmK4etwWm4
         KEg9phb1UhErqHLn6k8M7HJMxMKweZJp/Cp8QidHh22TRfzsIg/MEDkAG48JFFhnw9Fn
         p1+8jiAz5CWKlO3P9u5HCSZomdHel13f4WADTXl6NCZf2Qc7pvsPL1BTj/lBSKvDsNIh
         cbXrdgcO2bYCjNLrMeKxLte6z8fGWM5PH15Imz45T4Xzfn2/nifeg0D3UGXF77j0aAo9
         iWHuNyzcEqTpEsl1TyMNNUEUWIsMaIzSw4SBmstJvYzK3TTykM+G5kNbrnrEQE8mcVxr
         omEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765362555; x=1765967355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7TB6TMdAII9r17Pf+/IOs9Lkjovh8q5VwbcbSGWBWk=;
        b=MQhuFpCf7YVLpdpDr87i22My2ik1bfSBKjRvAJd99qiMUaVCgf9Bpe1ne18MqSVtq9
         g9pWNuzv626aWYcsVfTfq4Gi2DusUHb7FOQ+S7/BGz4bTl8sXglud874tgjh9P3uuoCI
         KWDO+FrUlY8xb2FSxvqb565K1XYW5rTz6C6SIQIGfDek/uaOTVb+LTS6Wy+e1pRpmmeF
         vkYuUazH6CDr58/0LO8v2kDBEXDEG637+29qcsNjymn4w8jf8d/glz72kd9XueErmU3K
         9HHESXLh77dVtWRjPqTaWvYj6KntPQEe5acMf7QMJIuqanVQjCJRa7E4X9mVmDgG/PQj
         Papw==
X-Forwarded-Encrypted: i=1; AJvYcCVtJVyUG2q5mrG5uYYu3BT2aE6wO9ZGTXu3r4etd6bcxZj8zEe7hvIlOSkVve+koU0xRtATVw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxy3M79DG3sgdMW/5mUqol9mXYhDd1BGphy67P2w1fTm3ajRIUN
	sJO4wmWbk7kzYkrmkBd8hrR6XdurfsOYBXQcOwyqpt7IxlEi5Pb3QbFXpwtYw/ZF2m67Ftoj0iP
	YXXA92EnNyRla0VA3EJ9ZKAic0ZW6gg0xqIZiaESjroXyot/po59hxBgGMA==
X-Gm-Gg: ASbGncso4ZJYkexqTihuIaVPt5p0S5qP9XR2PQIlTGa5vkIoCbX/HmfoHz9/sn/N63V
	xrAU03PSjhAC3AhZOQTADGP3/EuNkXwOHGn+lv/vAmcnnitjMH41OxmO84by2DXaPh2AOkImM5s
	ZC6ygwjDPJ5vijCvPBBRFeBOETIVJ08sW3UhJtmD7GasQ2et46bjF+fR/nQy8u3tOG6tX3E2MnG
	WdEWE7JJuMw/Y3DLtVtuCVQiNgsclX9jjM9Ym7hAUK6PCjbsgq/FJvSAZNS0e54KdPtg6ILfP6J
	IEvwrslwHAMBZB7MZP/Y1rxxAGNbySsFKuUGLh46O0I1sT8Nm4pnX4rhMG6uZItT8iRWLlThVNp
	0FU5YOXL5b1NFsp/5xONd/k3EuzETtqteSjrff20gT99D
X-Received: by 2002:a05:6a21:6d97:b0:366:187c:55 with SMTP id adf61e73a8af0-366dd671a89mr2108099637.0.1765362555337;
        Wed, 10 Dec 2025 02:29:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcgu9hUwcEB6rt++82LtRZjGKcJn4qKJUTbsGlXArL5j1gkGg+yRYs7jJUlmFgGE3ypWN+RA==
X-Received: by 2002:a05:6a21:6d97:b0:366:187c:55 with SMTP id adf61e73a8af0-366dd671a89mr2108086637.0.1765362554850;
        Wed, 10 Dec 2025 02:29:14 -0800 (PST)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6a2745c43sm17532079a12.29.2025.12.10.02.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 02:29:14 -0800 (PST)
Message-ID: <788d981e-7186-479c-8961-8b16482aa5bf@oss.qualcomm.com>
Date: Wed, 10 Dec 2025 15:59:07 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] of: factor arguments passed to of_map_id() into a
 struct
To: Rob Herring <robh@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, robin.murphy@arm.com,
        will@kernel.org, joro@8bytes.org, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, charan.kalla@oss.qualcomm.com,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20251204095530.8627-1-vijayanand.jitta@oss.qualcomm.com>
 <20251204095530.8627-3-vijayanand.jitta@oss.qualcomm.com>
 <75d44bf2-c518-444d-9b15-fca067e25877@oss.qualcomm.com>
 <837be315-2eca-4990-94e8-6d0765a8ba44@oss.qualcomm.com>
 <20251209200214.GA1015230-robh@kernel.org>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20251209200214.GA1015230-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDA4NSBTYWx0ZWRfX1Er0G3hcHFSe
 FZt6CLdjxQo/VrTGJ5kkadhvGsjAAShgOte7q+0zKVKlKvAU9ZO2enn0CoMSZNm5nlnwfT+CXmY
 TmjHU0F0iARQHp2rXoO6LI+AvEirriHWhufL43gGFdehHesZ6DXiCXL53sWLdcEl+v7eycTogfy
 iBzwdChzWxRRtoX2ajiGX6lMBuzqLTkrXnNzn2KvKGElgCJHjXWNfvIf68txcWPpdu633Sp6qQG
 55Elv7dtyWD4JcAxXLJK3xzp8W2vlPX0s/zoRn6Zc9Ss+scR66yjsRhZB2k1oVpPO6BCW1yt9tN
 c44ZiA0yXplMMg7wRg64g8IUustxSTvVbvVla+MTU/8datsFpLONZZ6v69vOuT4acFz2A9hny6J
 GwXjWQhy0Tu4jttEzTPhIoFLDh5VTg==
X-Proofpoint-ORIG-GUID: N94SIOc7QCZwXDS-MrsJEKBMl12PP__p
X-Proofpoint-GUID: N94SIOc7QCZwXDS-MrsJEKBMl12PP__p
X-Authority-Analysis: v=2.4 cv=F/lat6hN c=1 sm=1 tr=0 ts=69394b7c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=-qYRvQ6t_rZha5YZWBsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512100085



On 12/10/2025 1:32 AM, Rob Herring wrote:
> On Mon, Dec 08, 2025 at 07:10:32PM +0530, Vijayanand Jitta wrote:
>>
>>
>> On 12/5/2025 10:17 PM, Dmitry Baryshkov wrote:
>>> On 04/12/2025 11:55, Vijayanand Jitta wrote:
>>>> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>>>
>>>> Introduce a new struct type where the optional arguments passed to
>>>> of_map_id() are in struct. Subsequent patches add additional arguments
>>>> to the struct that the caller expects to be filled of_map_id().
>>>
>>> Why do we need a separate struct? Can't we use of_phandle_args instead?
>>>
>>
>> The idea is to use it for multi-map support mentioned in the cover letter,
>> where we need to pass additional context (callback, dev etc..). Having a
>> seperate structure here makes of_map_id() interface easier to extend.
> 
> Then perhaps?:
> 
> struct of_map_id_args {
> 	struct of_phandle_args args;
>         ...
> }
> 

Thanks, this will work. Will update it in next revision.
>>
>>>>
>>>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
>>>> ---
>>>>   drivers/iommu/of_iommu.c              |  6 +++++-
>>>>   drivers/of/base.c                     | 31 ++++++++++++++-------------
>>>>   drivers/pci/controller/dwc/pci-imx6.c |  6 +++++-
>>>>   drivers/pci/controller/pcie-apple.c   |  5 ++++-
>>>>   drivers/xen/grant-dma-ops.c           |  5 ++++-
>>>>   include/linux/of.h                    | 23 ++++++++++++++------
>>>>   6 files changed, 50 insertions(+), 26 deletions(-)
>>>>
>>

