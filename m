Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C03B0AE4
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698512; cv=none; b=AsEujOllZlJNdeepxm0d+FPwEO221TMFWafIble7xQoX+O+vGAeCUFO7vEHMvZTkTO3WZzYRVjGhxvo4x6trVdclfoH3mYAPeoe1NnMNXAqmHZW7xRXFtBg30M5y/G7QfXBKsjbx1C0PcK2ibwLQgufcuQak/cBoMZDaVhGes2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698512; c=relaxed/simple;
	bh=f90icsStwuTiYS+TRLmFbYa1N1i/jNkMOXo1pnh14Tc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HhQjZkit1ZKmB+uDN2y4EUxnbsYb453khmcnw+vpxVutlSiCr8w35zfLBxrGBZDumaihq/FnL3uD46Jdmzk+O+VI6iX1nVrCktMnwm48/ELvaWcW1Fn6Ensih736VY2fLDBtzA42LC450HD55m0Oq3D1luMCEBA5Ser6WtGKsck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m2qNgidR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GKv0iNRz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m2qNgidR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GKv0iNRz"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DGArc22524315
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 18:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PdDYhB3ETGgG2OyYi3uG6KABgHH6zfI8kJ8591RPyfI=; b=m2qNgidRHRM0A8j/
	+n/C0hJC9eU7xSpqpD95nrTfbpCyv7rz+zRZyMcqR3/tQXm9UgAFXKVv5juLUuzp
	w7NtVF0mdyHgbx+5GJf4LgnhpW39Bv29OXGoC+42DEN+GKQQRaEQ4eMb/n/t5MVN
	5SDHKv4ooYkTwJsOCB9Sune4jtfZ0KxbxTlftorB4AjCNfbMTztOaSOxIb+P6rHw
	XRouq2vpIVRa6TjSAYjd3Qwcwblpw9SCmUp69Nxz9e2tohvHCAhSkWhr4X7KL7Eg
	UYwJLJ7LjKmtqPrSatwcwYAIp5eRdV/7pDqtPrh9ebba7/P+bWJ72eRfy4H9rJfe
	gbJkcw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4vkjgq5b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 18:55:08 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8292a9605aso2005199a12.0
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 11:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778698508; x=1779303308; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PdDYhB3ETGgG2OyYi3uG6KABgHH6zfI8kJ8591RPyfI=;
        b=GKv0iNRz2tGK6HNqGtLHlFaMy95SeloDduLHD7BR/aIvV/xhzZF6GHIkz/DYYo5VlM
         JO1I98wu1KKVXqrvUNsG+/YuXKgyTtcs1kYPwYVzA9ElaJZMgNxFMZKWOPnrrJ2yI9Wr
         sXLPZDU/YiR8tKYaC4vNmMq7FMR7d+WDRFN0TpZMhMiM6Y3e5iKhMWF03YcmHLb+qbGF
         ixQfCoOxgQZOwy/s1mTScX9bj2BzG3DT3ln6ao4emVLyQ3bq7kvNaYZLG+QU0pQcfB4C
         6dUzaWZ+Pwbvos7Ol7kCq8Ksan8+E3W43VyPztOI8cqqm+TMVW/clXKxlvYIBmuMeOo4
         hHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778698508; x=1779303308;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdDYhB3ETGgG2OyYi3uG6KABgHH6zfI8kJ8591RPyfI=;
        b=i7bwk3BiFGUW58x+S8V4zV9skt7ifSUbIb8A7+VMcrhajqjaqnWoS9OxTDv90uMtvK
         PdazwEkXItaSlzAA8CJdRd3yVoaKRa/dZ+h6iMwhqzvf3hj8/6RA1dBzon/UHVRJwup2
         9EMT6R9Est/o3Pj7XFzRDp3eFm1QN6BwIS53Q2tdcgLBg0AF6GT98tM3gaisIxDDQbsQ
         CewXsgtumZ6mojug2DUIXhyoNq7D5sOROLx3eAwssmftsP3AE1ZZ+6BhjxkyR1zUwUYI
         IjljZ01LqDn3eub8YYlyCSg7ukMPVx4YW46T662BIPUbhoD8uLVWlQozQ++TH3aHE2f+
         RMOA==
X-Forwarded-Encrypted: i=1; AFNElJ/X2KmaD9WjOc0FoOMU10f3GTfMfgpDo9zq8p7kjZQ0Wxyg1ZtDCkwx8F5FAodbavnXIeZcmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVtuKuadUr+Oo7dAdcRBOQIFkBlEvMBoQ+C8xwFSokpn9aEfGW
	vFCirNjU9afnThyQOml4OqQRoK03edhITKEVzL+0lNJQ6XUo4X3pfaP5xNmYgbJDzDfpp33PPTW
	CtDuVKVAXbIii15kG4vvkGcdeEnC+PkAdO1/M+yFO51pG18zhh6n3RefExg==
X-Gm-Gg: Acq92OEllqYIN6uZn2j4dw+M24lXlxSFVS9UGlBJ2asFZxohf71G80sOkjscvWxtZUe
	Ru0gZ+W3i5WmsZV7KWe5WFphXx7SEIYkOkEGj5phuyNCrUAqRIdF/reH/UZBWaXmdrHRdHsYKmh
	tJph9UT8Xk3084wrJrxVibuaXmy6SZG0bAshT3It3dGlJNHI9deAZAeI57X61tiep8Q1n8i6nbo
	QkK1kSxef/dHFutvPQB2YuLqjaGu5BXt2bi1nlr96twbY+xt1O/wPNz0zOupOAGy90Qr8J1u5KC
	cQCixw87CVNqTnHPRrz/ziYwl6uGoJVgMYVfObr8PflMxBzGMESMJ97hlXm4rNoatdFqUG4F1U0
	eH6rPAvgL9WGYK/yYQbVTWxZPuzhzRPlGq2IceqGXHsuOjroX/fGyG4cJyOK6HGo=
X-Received: by 2002:a05:6a00:810:b0:837:42a6:589d with SMTP id d2e1a72fcca58-83f0568612amr4387530b3a.11.1778698507471;
        Wed, 13 May 2026 11:55:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:810:b0:837:42a6:589d with SMTP id d2e1a72fcca58-83f0568612amr4387489b3a.11.1778698506919;
        Wed, 13 May 2026 11:55:06 -0700 (PDT)
Received: from [192.168.0.17] ([49.205.251.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f197781c7sm240554b3a.18.2026.05.13.11.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 11:55:06 -0700 (PDT)
Message-ID: <905f5677-5daf-d6e9-437f-7b928036ea95@oss.qualcomm.com>
Date: Thu, 14 May 2026 00:24:55 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v5 07/14] media: iris: Enable Secure PAS support with
 IOMMU managed by Linux
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
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
 <20260509-glymur-v5-7-7fbb340c5dbd@oss.qualcomm.com>
 <elhlmmmisecn7vylpsboiicn7dn4umrggktabyixthmevdv7eo@a4keayee2um7>
 <20260511080104.c4nhhmm2xgzm67fi@hu-mojha-hyd.qualcomm.com>
 <zaq7evuw6la6p6zcv5zgv2nuehc6yxt6xxojjdd2rdflxtk73e@wr2w2kbxamv7>
Content-Language: en-US
In-Reply-To: <zaq7evuw6la6p6zcv5zgv2nuehc6yxt6xxojjdd2rdflxtk73e@wr2w2kbxamv7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Q6Ie7G5ZIDgy8-6CV3IeMKm3Lo0GWzAT
X-Proofpoint-ORIG-GUID: Q6Ie7G5ZIDgy8-6CV3IeMKm3Lo0GWzAT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4NiBTYWx0ZWRfX/1Zv2i0pFcNE
 vdDe/TlPetBCcNt3UCgKX5CJ+WV7uJfR0/12GW1MD2HJ3MmtmYeApfaqQ49NRm9qOEdNy1mffQM
 QWSutkjd1KtEE1bO0qdMEeiuqKiykbkZuUY5Twa15zPxk3EAC9AUaD9FZQ4+XdRU7KKZJIp+YSZ
 M61pogIQ0hekmNURlvCJkWFBEsfFPMDsJPQoNciVG09S2s3yWK+LmEPcnvSyP33WuDDOEazFnFY
 gIcPu76IFUmrIz9A1cXV7Qr7ilEq+hNEap4E2w8viiyqKIbEuRdjF2dwDHBM7k60jm/A+laeNQC
 3/Ss3K/ppVUXB012HcFpPhgsu4jdJwZph6s8HDuxQ7F0TjLgP6JfbDhEzAnrQYnE2y47HCELDvs
 +keeIgYXygNmR7Gs7R7aXYUiFp1P8kFauxrcdIUkrD/EKCN6MQhO4qSyGBC/4xiex+2psySfWid
 IQZl35kBs+B7HQXO2iA==
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a04c90c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=UdqKVphAFhxg2bWZaUV5ew==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=B9MledX_AzLNtmQI4O4A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130186


On 5/13/2026 7:12 PM, Dmitry Baryshkov wrote:
> On Mon, May 11, 2026 at 01:31:04PM +0530, Mukesh Ojha wrote:
>> On Fri, May 08, 2026 at 11:20:06PM +0300, Dmitry Baryshkov wrote:
>>> On Sat, May 09, 2026 at 12:29:56AM +0530, Vishnu Reddy wrote:
>>>> From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
>>>>
>>>> Most Qualcomm platforms feature a proprietary hypervisor (such as Gunyah
>>>> or QHEE), which typically handles IOMMU configuration. This includes
>>>> mapping memory regions and device memory resources for remote processors
>>>> by intercepting qcom_scm_pas_auth_and_reset() calls. These mappings are
>>> No the calls to those functions are not intercepted. Doesn't hypervisor
>>> simply implement the SCM calls?
>> All the SMC calls are intercepted whenever Gunyah or QHEE hypervisor is present
>> and in most of the case the preparational work for the TZ like in case of
>> qcom_scm_pas_auth_and_reset() it does create/register SHMbridge over PIL memory
>> so that the TZ can access the memory and then calls same SMC call to TZ for
>> authentication and once done it comes back does mapping the PIL region
>> and call bring up sequence of the co-processor.
> I see, thanks for the explanation.
>
>>     SMC  SHM setup    SMC (auth)        map memory/resource and trigger reset sequence
>> HLOS ==> Gunyah(QHEE)   ==> TZ    ==>    Gunyah(QHEE)        === ==>      IRIS 
>>
>>
>>>> later removed during teardown. Additionally, SHM bridge setup is required
>>>> to enable memory protection for both remoteproc metadata and its memory
>>>> regions.
>>>>
>>>> When the hypervisor is absent, the operating system must perform these
>>>> configurations instead.
>>>>
>>>> Support for handling IOMMU and SHM setup in the absence of a hypervisor
>>>> is now in place. Extend the Iris driver to enable this functionality on
>>>> platforms where IOMMU is managed by Linux (i.e., non-Gunyah, non-QHEE).
>>> I fail to identify, which changes correspond to this description. If
>>> it's about the PAS context creation, could you please be more specific?
>> I think, commit text is trying to tell the Infra to support any Secure PIL when IOMMU is
>> managed by Linux at EL2 and the dependency related to SHM set up in Linux are done as
>> part of [1] are in upstream.
> Ok... I'd say, this part of the commit message might need some
> polishing, but I can't give an exact advice here.
>
>> [1]
>> https://lore.kernel.org/lkml/20260105-kvmrprocv10-v10-0-022e96815380@oss.qualcomm.com/
>>
>>>> Additionally, the Iris driver must map the firmware and its required
>>>> resources to the firmware SID, which is now specified via iommu-map in
>>>> the device tree.
>>> Why? You miss the most important part here.
>> Sorry, I did not get.. are you looking for explaination here, why via iommu-map in
>> commit text ?
> Yes. Why are you using iommu-map instead of listing it in the main
> iommus entry?

Without hypervisor: iommu-map is populated, so the driver creates a firmware
device and handles the IOMMU mapping.

With Gunyah/QHEE: iommu-map is omitted, firmware device is NULL, and the driver
skips mapping since the hypervisor takes care of it.

The main iommus entry already holds other stream IDs (pixel, non-pixel, etc.)
and cannot be used to distinguish the firmware SID or infer hypervisor presence,
hence the use of a separate iommu-map property.

>>>> Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>> Co-developed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>> ---
>>>>  drivers/media/platform/qcom/iris/iris_core.h     |  4 ++
>>>>  drivers/media/platform/qcom/iris/iris_firmware.c | 72 ++++++++++++++++++++----
>>>>  2 files changed, 66 insertions(+), 10 deletions(-)
>>>>
>>> -- 
>>> With best wishes
>>> Dmitry
>> -- 
>> -Mukesh Ojha
