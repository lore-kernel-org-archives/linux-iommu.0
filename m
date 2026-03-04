Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483DD3644A7
	for <iommu@lists.linux.dev>; Wed,  4 Mar 2026 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614684; cv=none; b=OBF0/PQwr2y72qYAiCYTZnJ+kmCBuM03VTtT+VYxotIO4+9D4aAwPRJel8EXwKH0QnZndFgRn9bzEXNxtnIjGYoTwX2aJ7o44kE5hCl6rV8V6umXPRgCE/pzPp2Co4oj05zRnLzDglH8TYUyyzQJVILBPtE7GNwOqPMdBwoKcwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614684; c=relaxed/simple;
	bh=YNyzheyMXouN8Lf/ico2jv5x4+uFyMuodyQ++FAMW8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIBoEHTaVKCPs0PPV82/N4j0AHFJjJCz2pd3Mth+/U+PezhKXpqf4JLoLvIotjV8rtF5czEAcDVYNFyKU4Ldr9keGQKL5ZTYdAkPD+MAyZDb6QBe793dByHOrKjq0D16GZ+ynaYMKsDUIRV0PnpNRnfgrYKNl8pZUIOafAZXAm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uk0rvhxu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V3G10Lv+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uk0rvhxu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V3G10Lv+"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245Si9o1422303
	for <iommu@lists.linux.dev>; Wed, 4 Mar 2026 08:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	niOuDWaqN4TxIlYkrKh6EztHOaj9yjtzNsL8ODj5nqM=; b=Uk0rvhxuuWKguEN2
	F5lDCz0rki4FrqwhkyE5Z7ESRTqyzzZl3naodJuBH98RNZtitzWyTC5JucEXC2Ul
	/GpGkxS7fPJU7Z5oI2g5g0rSbffff6oSI8rP+CwtoEoXRaGkAWc5+g1auXJKBjyy
	kWdh71oLAFD0AWTal03j2F/f+kIt/efFRqmAzBkvqoG6BTCdmvdD81QNlWMzeWHG
	vCWJXRuCyEC5U3p+NBsecVWLT6BzuAjmcEruLQ9poFn05lGcNBcCxPRCeJGdLDRU
	tpzU61KR7idevCJZFiICZIVo8J3bERB4SBu5USMWvwnLjz7+/nHC19atHZgqVSD4
	+jA8Mg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpe8u0r5x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 04 Mar 2026 08:58:02 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70c91c8b0so553759985a.2
        for <iommu@lists.linux.dev>; Wed, 04 Mar 2026 00:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772614682; x=1773219482; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=niOuDWaqN4TxIlYkrKh6EztHOaj9yjtzNsL8ODj5nqM=;
        b=V3G10Lv+u7Z3McyoOORo0nicI3pupYg9fRC3X4cjazAejHz89xeBgecHuVmZK5325h
         m/WGLVUcySsq+DfYS8QGtJ3FLTMzxU7nQ1KCt0S54FhSxgjQEZ8n/kAWXsly/SeQAlA0
         5rc8Faa03dju4AfOaStkX/FbPDkL4nTeS0mz9w9lnl8Yj2ZXsc9DLyVwg52AHARjfaTI
         mqzP2OYzjwNlSuSib3/psadYwvDD36gXAebKjSBoPuHlkwM85bvTY7p5ur5mmX4aUefj
         7F5rRpJm6pP9q94Ofuatmc48wkDvA/kUFdWdsJeWoWkiBXkWpOXxhEbqyiNbcUx3O1Nu
         dV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772614682; x=1773219482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niOuDWaqN4TxIlYkrKh6EztHOaj9yjtzNsL8ODj5nqM=;
        b=tdmR5PkMDi9iUVHq8Uv7tyVbucHkVxdOPBmMF/uPZv1PWrrTAosyjoHYTVh3dneDcK
         JsSG2nAe/GghO2uW0yldjK9YNRLWKVHI8sCwL4MtbPL0cHasaA1TDC2uh7dzfejRTsNq
         0zbY6C8ftgb1SeV/GNQZTOq/1Dzl8Bg3FcJjit11dz5qzcvw3lPYnUkynvOYCf46+poe
         MbSSjoTyxeN57xTZxvXk0Bq1+OVtthdKHXA1Eu5GzMm6fkVgd9D1vbrTaTixu7/bfAQY
         c182+Rj49utfItrMRx//vFNEWT5yNSMB4djO6ty3YjhNOqJMQmbpdyrT0jwr+7xPYjdw
         Aqeg==
X-Forwarded-Encrypted: i=1; AJvYcCXhMjtC4N4colaes/yhx30NTsJGZbt3E6mdFiBoWEFL4pEtjnRCHq1lbkz8pnpj/J5CMDLJxA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3EMXpMV2rnAMadVjB4DCHO2etnSvvqEGKiONdxD3S7eQLjY+0
	Vdc/201SXi5ZbWy9oAUxnJS+npE0622PNFxhLoYBLo1vHG/OcNspaccw+unni+j1wR6+0EBe69t
	o2qYJ0hMYssYMbZNjYm0jQqw8ejEe7mIMjAH7sCCKrIH7rs4PNWKo5rsTBQ==
X-Gm-Gg: ATEYQzxqmRoxMClDvEpyiu/sD9vmMtuAdkdWewgIbcgKTCyA24FwtCBPrZ5CLMHfZIv
	6lvYc/ijgXoKoPB0coqPAsVXXyaUnGpE3Kmtyux1uko2veq2M0Uw/RRMlmZ+h2e0FrIp3aaxXJA
	/IlE9q7o7rxoa3LDK+KuayhZQ1bp0vE/nkEFEiyoDsyvHWNsUB//KtB8tnLQKgw5tTmF++xpytD
	j/Wv/rXYsuX0ZHfcLjYDrfazgx9k8GYWwpSnf6DH0a9bKOUb9eO/yaowtdT4ro+fIbJzYQmC/zF
	9/x23EHJWDvTd8REMCcQ6XIr42yR0wYYzNyl+g4hoD1/Zk82WJ21Fn6e4aPVgJ0Kvilrcb79crB
	Ifv0YMU3fGEC8zLWLPnspomacy8saUnJX5/jx7819bJRcL1CRP+N6BRQVdHuiFfIFt6FzpfFBTr
	KhYxc=
X-Received: by 2002:a05:620a:3945:b0:896:ead2:a657 with SMTP id af79cd13be357-8cd5ad9dd70mr122030085a.0.1772614681691;
        Wed, 04 Mar 2026 00:58:01 -0800 (PST)
X-Received: by 2002:a05:620a:3945:b0:896:ead2:a657 with SMTP id af79cd13be357-8cd5ad9dd70mr122026685a.0.1772614681264;
        Wed, 04 Mar 2026 00:58:01 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabd46753sm5249417a12.8.2026.03.04.00.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 00:57:59 -0800 (PST)
Message-ID: <4a5be869-1b98-4b76-b483-4fa374bb36bb@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 09:57:56 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] media: iris: switch to hardware mode after
 firmware boot
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20260227-kaanapali-iris-v2-0-850043ac3933@oss.qualcomm.com>
 <20260227-kaanapali-iris-v2-2-850043ac3933@oss.qualcomm.com>
 <6fe3a1a8-46c7-427c-abb5-2e7366a43392@oss.qualcomm.com>
 <164928f6-cd29-49e4-8b5e-365f5b0a70e5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <164928f6-cd29-49e4-8b5e-365f5b0a70e5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: FJEZ40MxRFnr7iyflqo5qj-vQuMxIMPZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA2NyBTYWx0ZWRfX32nNMgYJ+pX8
 Xhf6eFGE2P/itU02TDNeWPL7nR2ODOA/rukCwcpMhKQdXHoZMk1C3wODg4wf5aQu+kOmFvRie1z
 h2uli/RHXjrgyC4dElhASbYRnPSG7ldYBaQxEVINwPqNx7llv/zTd5FU+1Ofc3JAzQCBXgthyKS
 KuiqNGiKYhQuBfCfT1UBne+3753IrDKg2hCIPmjHzTPAleXSyiW5n8dr3s6WbWzB1Cc0X/+Af7c
 nJ8zAO2dv4DfXZnp3dkrGUpw10aHe5x99jq+5b7/EbeXnluNKNUsYBAdZeeiADx84MAe3NBUvF9
 iYrxoeDsLzoJp0sAupcCmS2dCis5GG6sZja23Z2DS2RplYsL+t698Tu6wnevw31pTDIh46DVzf8
 beYXdstEzloWE/4M8LPzj4fl90vgKck+j4RdIVXEt4u+4x8eMRiO73PtxjlkFIsY147sGd0GEUt
 LQ8pkqXmYNlxHzb37HQ==
X-Authority-Analysis: v=2.4 cv=FpAIPmrq c=1 sm=1 tr=0 ts=69a7f41a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=b2WnVuVpUTZYNMXETCkA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: FJEZ40MxRFnr7iyflqo5qj-vQuMxIMPZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_04,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040067

On 3/3/26 7:15 PM, Vikash Garodia wrote:
> 
> 
> On 2/27/2026 10:19 PM, Konrad Dybcio wrote:
>> On 2/27/26 3:11 PM, Vikash Garodia wrote:
>>> Currently the driver switches the vcodec GDSC to hardware (HW) mode
>>> before firmware load and boot sequence. GDSC can be powered off, keeping
>>> in hw mode, thereby the vcodec registers programmed in TrustZone (TZ)
>>> carry default (reset) values.
>>> Move the transition to HW mode after firmware load and boot sequence.
>>>
>>> The bug was exposed with driver configuring different stream ids to
>>> different devices via iommu-map. With registers carrying reset values,
>>> VPU would not generate desired stream-id, thereby leading to SMMU fault.
>>>
>>> For vpu4, when GDSC is switched to HW mode, there is a need to perform
>>> the reset operation. Without reset, there are occassional issues of
>>> register corruption observed. Hence the vpu GDSC switch also involves
>>> the reset.
>>
>> Is that a characteristic of the hardware (e.g. also seen downstream), or
>> is that required with upstream iris only?
> 
> it was found lately with one of vpu4 variant SOC and applicable for all vpu4s.

Thanks

Konrad
