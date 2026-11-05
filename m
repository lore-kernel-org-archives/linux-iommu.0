Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886096;
	b=f83QftPneAT09huO8NcDOmqQkPOMEtC2Vuu/fJmRCpfwX6fPxkFPsb7GQoHTc20sWJji
	 7gNc/hBmpAj5H+6u02JLwvONTY+P/dXFiAbPV2dDXZ0uBUmaURwR7Wsd5aH8ePH9fONnu
	 7hDSSeSHhBs/WKcAzaaAhGSBk3i1ml9T0y2I6dtnsSf/wemKWMsXI8PCmae+O0Yf4Cdz8
	 nSDWlLwJPo3DzuhPKP+yRcBLJQ1/rGuWUIrmy3oUKzUQUb5fQ2H71DwoHXvRmJ2fNSm5n
	 oqgH+WdtGdB7O1a9KeUGCATykDex0CTkUclL5jAQGvilaHHrJO2sqTEJmqVNUJ5jopw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886096;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=iMd3kYBOu+TSW3dG0LvqQCxVneA1Pzgi8pIv9GsQNzU=;
	b=Ly02XMFT1j14z0Ji4DX9eKgfFIG6pFIaqqTSdCdCM9dL5V+la8Jzzt3Aowrbf4bnpkma
	 8nqhxsmlPiGORtQTJHJmd46kSpOenHNSi0u224w+lCMcsfuazsecQQQtvjpUQB7jG7qQH
	 2sR3PYY84MapD8mAXyaYKgejBV+uC6L3pxkulUhb1e/YIfxy6APJCZadngQnsky3IaKq+
	 BTv22eCjatw9iVkPnp2+bcr5oSh5sFJ6Ohyyt/ff2UIoP7IscTXPSIT/7HivbKWZYIMgP
	 E3aO/DVZUuGj0LWZZZmLltWf9oHzKZhM3xq64raEWV/zypGDNtM4YYET2pMmKc3yB9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c5zgv4O6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YHQNikH7;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C23C606A326
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 13:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C23C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c5zgv4O6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YHQNikH7
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tkK73532159
	for <iommu@lists.linux.dev>; Thu, 5 Nov 2026 13:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iMd3kYBOu+TSW3dG0LvqQCxVneA1Pzgi8pIv9GsQNzU=; b=c5zgv4O6mlrsJZlO
	cPzXh1UHezP5ML4J4r5c31GBVxZ0Ykk6w/uDPWl4toE+EZX7+bkDJecE+su/sjCz
	WZPi6cJsGi2fjYb0LqQMK5dO55ZA3d/BGLHfRikIn77zVgzsQOO8sBeVmV7gl9Yp
	H4bcZae8VebNfHWWB3kau7qQ6aR4RHE1iOAhuczoiiwc2V8uWmWODdrRjVNX7L3u
	hKGtM6ej0KYKiPa8ZaMhWizVeg8vj589RFIvEGxzr/YtsIgqOw2wg81bZ+9uzarD
	FFGYjUoXQJAG9r4bAC5rVI8NC0YdGpfWGrm2y4H6wKLXm8WRhiNlZ0PuAjnCsmYW
	tCstVA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrksq9wcb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 13:41:34 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36f26e6abe9so1109eec.0
        for <iommu@lists.linux.dev>; Thu, 05 Nov 2026 05:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793886093; x=1794490893; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iMd3kYBOu+TSW3dG0LvqQCxVneA1Pzgi8pIv9GsQNzU=;
        b=YHQNikH7vzmkHly57QArvV3ccz8bYmqyiO1mQVTDDsN/WVQ7AEqi6CDn5f+Rciz6He
         K7j9m0Uih+PW39xmob3IbH0j8TzOhwov+38z67bz4SXQ41ew6lL1skM3S6wt4Ugs4FeV
         m/Q53OBqIm0sirhkDhgmv2v8KPP4vm5gTCjDj2liOnwxXWxKIKEiB+3vGZlEy7prKa0s
         izb5Qf+jb2VqTIH/JKnlXMh0Kt2KVC2gkQbYAB/1OVr7g2anak9tkZZ2S4P3SyXuxjDI
         xJxpG3CctMBFCDLMlZeYShR4igQeSqFiqPY8xzVpLVKFE5+SECGNcGdSvC3+Mu11skWE
         sahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793886093; x=1794490893;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iMd3kYBOu+TSW3dG0LvqQCxVneA1Pzgi8pIv9GsQNzU=;
        b=H5sC1H3/Rmkz2sR+CN9ys2sRujW7q7jZdBYLCJ64uYfP8pFIcp68FAkuivGVYWgPcr
         dJlkb0054Cmagx2n5WYdAFu67YH7TXsJhx1eJ+BexTz5plx9nesFo0QBwpLkR11EjykA
         H6cTErkJT/4xqGhUHD02W0Y/q3/GOuNODYxXmdQl6kMwM1MexAqym5Oibd/pBn32xkTC
         YVZUCU/CF1Cib6LbBdF8j92qKzxZl9oGWW9ztKobXBGkCO3B7TP7u26pNBwof5YTbJdj
         GFc7F8tsXlAfyV/ptELIxo9fUYwObgVdh9kUrbIenfPi1xI6usgH0tAGRLBV5Oii8XNe
         dPng==
X-Gm-Message-State: APuU4Z9wWHPN3AwCvwyihuAJSxHwJ61fTzOFgISfepF+4VIU96bh+Vzh
	j8BaoSl9uzv9WUwB5IxqHat+2wqshliM4POqgpxwJnH2NkyDTZbLVn1G0rgEnjqXLpJFYamAS8X
	OAJw1g4ZOZoba7wCJW8xv42hUQApwMF+4G6PTOeR/tMWVzpfWESWOX0nVUA==
X-Gm-Gg: AYBFou123DmVDq0becR+F/uRDKmfWCAFsz7ix61pdUOvOKsozA7g0Q1acylEWShiq3v
	GC7OLhtE05neq3R4v6lhDoJbNdae49T649Z2n9zs2LL1ym3062GWre6Zugi1Qu/dfvq0eVfGH+D
	I2YV1zto7wwHyf+ciyIQaybo9DuUGIXBROFgVLiApLESIzxpNxOnIebcnIIMFke7l61W+vIHRV3
	TQVLbn3QituzPZuTV2ocaIjdcj4GHi/se0jQVPFBjuLYH3mGTiv24KCWWjCJjd9UgImUY9iLLjT
	zpxK086T0C/yVmZgh4+0Qm2pWoW07a6muOqjveE+pWCuNuMLaaMHZzripXtR1tgPpCznAoq3vPC
	cOmVc1cfgrWe1Q4+yGvLfsluBZSRXmwJxrftM0c7CVvd2pe6VQr7YoRmECSvLMdtUyCSVWXV97D
	6Nzg==
X-Received: by 2002:a05:693c:409a:b0:369:f05d:6c67 with SMTP id 5a478bee46e88-36a42364b83mr31028051eec.12.1793886093239;
        Thu, 05 Nov 2026 05:41:33 -0800 (PST)
X-Received: by 2002:a05:693c:409a:b0:369:f05d:6c67 with SMTP id 5a478bee46e88-36a42364b83mr31028024eec.12.1793886092676;
        Thu, 05 Nov 2026 05:41:32 -0800 (PST)
Received: from [10.206.97.48] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38fe477sm15424892eec.17.2026.11.05.05.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 05:41:32 -0800 (PST)
Message-ID: <15ff1391-d35a-480a-b28d-a6507b69ba66@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 19:11:25 +0530
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] of: Add support for "iommu-ranges" on a device
 node
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20261103-add_iommu_ranges-v6-0-361f3921a133@oss.qualcomm.com>
 <20261103-add_iommu_ranges-v6-2-361f3921a133@oss.qualcomm.com>
 <f416b51a-0775-4834-9e1d-af8a72d9a1d8@linaro.org>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <f416b51a-0775-4834-9e1d-af8a72d9a1d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1NCBTYWx0ZWRfXxZJZOwD33Onv
 antvuClifoUjKlEbYLqHqVFv3V97uEdwD7rKR3PCysVAZzhad94j/4iIKwwUfdD6hvfuJPC49Lk
 r8Meev57rcEkjeJR4PPCTeLEqJhye7P5eN8yR3SkfLO62pspxPSfQXWQZsUBe/VjAKOOaf3+tZ0
 fsIMlufzLsPrhE6Z6jMVApU/u3btfcLsK6w6N0aC7VHpp8pehreewRsPIKaaxsRtfT/4cxJ0BYm
 LDvQvx/6XvLzRfwse3BYBpAqdK6OyJKG3106M8LkrWknsDz0KZv52xJFTZ9PCmCj4pQHd1caaoc
 UgKDwk1CHtg5BCUBK9lVO/z5Pdc1d1fg/N2SpNoYtsfhXejE4UelOvLxMAPwjAirrAufRFzA4Sl
 7Ne9yUf9iIFFbUPrPQc4zBMB/T5PvQTLgJKOB3qj1YyYGFKAL4LbosWuLS5UnREHUCI3A56EIIf
 RfQUjC6S4MDD4cggCWw==
X-Proofpoint-ORIG-GUID: LnEKwQlGvWtvgvYzm5IJcbmrJG4XuYFX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1NCBTYWx0ZWRfXwICh2BdekKuj
 oSFLEkQYSwKuQEgF91kfd8t+3p3DdZVfC99D0QT2/TwD0YxGLN8peTxHu27fZNfcsug6WJCBEja
 QZhtJlTcVrUUkNzaathlsXTz48VM5Fc=
X-Authority-Analysis: v=2.4 cv=CIe/zhrD c=1 sm=1 tr=0 ts=6aec878e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=r7ux6a0TY3_jL4VTlKIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: LnEKwQlGvWtvgvYzm5IJcbmrJG4XuYFX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050054

Hi Bryan,

On 11/4/2026 9:53 PM, Bryan O'Donoghue wrote:
> On 03/11/2026 15:29, Vikash Garodia wrote:
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index 
>> 5c266511db78910d6fd221af5437cecff4931c22..0428ceb50dec58f11872b4fb64e283fa8d9046a3 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -185,11 +185,118 @@ iommu_resv_region_get_type(struct device *dev,
>>       if (start == phys->start && end == phys->end)
>>           return IOMMU_RESV_DIRECT;
>> -    dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap] 
>> as reservation\n", phys,
>> -         &start, &end);
>> +    dev_err(dev, "non-direct mapping [%pr] -> [%pap-%pap] is not 
>> supported\n", phys,
>> +        &start, &end);
>>       return IOMMU_RESV_RESERVED;
>>   }
> 
> Same feedback as @ the last version of this.
> 
> I still think this behaviour change should have its own patch that 
> preceds this patch so that the logical change is clearly explained and 
> understood as a standalone change.
> 
> Supporting iommu-ranges != not mapping misaligned ranges.
> 
> Otherwise this change goes under the radar of the new functionality 
> addition.

Ack. Will push this out as a separate patch.

Regards,
Vikash

> 
> ---
> bod

