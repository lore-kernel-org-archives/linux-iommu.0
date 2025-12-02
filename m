Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51892FD668
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764658497; cv=none; b=VR3EHC6txAtzssWmVX1zqE5TWrKI+k0hDgE36vsXSKQJeiqYM0x+kxwvS88UrXr83wGUbtjThuYa9EumkJDl8qKTErfAgbrwzT6gB4/zYxhAUiAbSj0ckQ8dDqj+WP2UszVnyLLm80AX6GBigtiDuICLTiwO+o1FkRFreRjsDV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764658497; c=relaxed/simple;
	bh=MFtxmIFFIX/mIzJYmrdf6PNdSBetj/enrg8nGxDBprc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfPfReLTFnctiYaXk0d78yB5EdjoVqmUd/xdK1X8nC1JrNuI1HhmUkbtDS7LcvcxT3ejmSGzgsacGIE2EfhcTrhbCMpxUzvDcp1lzMTb9ZO6oJb8ooN6cjVpNr6Z7kP/BLw7vy0K8aY2KqPBQssEF7c+iUEc8HJ3mQujn745C/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bLNh7lhO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TkMDKS+7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bLNh7lhO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TkMDKS+7"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B23iuFC979200
	for <iommu@lists.linux.dev>; Tue, 2 Dec 2025 06:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	foSQ4s+N0Lrk9DxVWQCN2BFZwRi8jbvinMpgh1jOiG0=; b=bLNh7lhOX1lDxv61
	nhWO1KrLqleF9siuA/XzbfNdg7TNT9zWizgL2yTlUxy8wPW2OZLrJ+c9sFYXLLgG
	DeIPwVICvWqQML/WZNWi4X+gfrC4T0YwaTL4s1TJI1Zui7ey/U0urvHwSSe32Kpi
	lOYqXbZcFhOVGmBzjizCjo6k3KRD9ImsMAQmJyUyQXbc662TtFuVYEdoEWUQs3rF
	XNXcqeo+B0Z40NICrCfVwdlPaUrT0w/xDTpvRNa2eb0GXh2KCLmd5pNgafu68NGb
	1IfB1WfKWDGc0PEkyAdBmlrzoW1/1QUPmpK+5lTsyYsLDUQpknINbhT9hfssse3p
	dlBdXQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4asgpkt1ex-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 06:54:54 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2a45fea6efbso6932946eec.0
        for <iommu@lists.linux.dev>; Mon, 01 Dec 2025 22:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764658494; x=1765263294; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=foSQ4s+N0Lrk9DxVWQCN2BFZwRi8jbvinMpgh1jOiG0=;
        b=TkMDKS+7SJWm3vrZB/ZNHELIpLPwFcyD3cS3S2bNG9ggOs99dVTdecynUxBBpx/BzZ
         2Sjayfd/hwZmg446Ty69Y2luTlBIEeu7o5wx4gHutc0BeZJ9k8JK/R28D9SetDlFsk99
         otB+740WkwJIpmo5jroWNzhZn1grv9Jmy8u00TZyddGqdGOWqThYKRcFFtgGT18DlW7U
         p6td3Vd+Wt5DTkpqYT+xjI+u88H5y7W7es6JD66L7okV6z1kCfaMyVO6QKdUifZcBVef
         8fqzm+KhrmPjBduAAgVjL7INAa8awZrowq2KdzIblvPGJiysnKIztG5KqAw9C6hWltQ/
         v43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764658494; x=1765263294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=foSQ4s+N0Lrk9DxVWQCN2BFZwRi8jbvinMpgh1jOiG0=;
        b=QBGpBsJaZhEwkp0xwm14Apb2zYsnJbTz5XptZeIfPH615/9eC9qgZeyJ0h1jPsggum
         m2tXtg7WQlAkXAY2Tl9EO5Umbwlp5EUFB8H8pT0oCGegomH5NUsVheJMqUlMF0xiZ68I
         u2ZhXq3A1MKG9EDUUKfUfKl/L7vDjo5ekARsNEjSUZGB2tR7YPx53Ib8pj6jNt0B/SRC
         SAXaY/+5DcsvpxcFr/UrOOdOLYX2x3wxz9ab+PyxQQFpegRirwDKWYkIVPSiEZrz0SgC
         wamI5EoSp9XP525HJQytrLuwiGip9QFgrw/1ERvCRiA5d754bMepPfTsFnborrjQ587Q
         4CAg==
X-Forwarded-Encrypted: i=1; AJvYcCUpQXrWcGs9YfplkGgJJEEB8hQ6byqIyuAb9vX/u5VC66w8HyeGKgHjwBxETrzaFYM5n3CKvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZCK46ZYu9vUquFZqZeXhghLFO3K2Fl5m3wcvPslyIHQhf9nBF
	J/KtXZ0R8NTbcqHw1pqmWDMiw1GsIPcI6B/2uok8Pv6KjshfmINNrVKVuN8mYSn/1GwVPEQx6ot
	TuCl8HR5Nv840/7bdAljwax0WEJYbHrByo8IWdktIC+4Wa3GnJjbc6FxHPA==
X-Gm-Gg: ASbGnctc2iDrBFgLfzXfNAW0UKpdFwO4etSyB97YeWguyd+mOeX6JMdfh6tqD3koTRP
	vXjywDAJwoLdvY88hC3HaaHJH42AjfxonwYP+nKDK+pnceoqmPXxUAyo89KGRyzpXpE+aO8HPcy
	3mxPF/QXFhvP/vr2sV3LgPQfUGAsVtYnpfNvPASEOrQnkefHq6zyEu6kVlphBNCTOvNo2BUUFVF
	n5hf4/N2D+xNzYS9Sjwk1iixBjOUkNqXpURf5BgmPVKSgKGttnriHHSDYNm2GUFnFbPg5ol/wWl
	ZXtiKtr9nw66DVCXTmS0mCtPsdNTfw49z5VWXzXqjsi+5+OxzEBznVgBug6baVFdwB22uCxdhXL
	vQuDUgkOwua86cCXJh5sZyX/U2a2IOE1BITnM+CSTcvpz0Pk=
X-Received: by 2002:a05:7300:df48:b0:2a4:626d:5c38 with SMTP id 5a478bee46e88-2ab7e7c42aemr952889eec.17.1764658494076;
        Mon, 01 Dec 2025 22:54:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwtS+5CXK9Uchenjq5V8PVop7wPp/br98GZF8Rgn7RGu2+Zlt5rF78efpYSo8wSviNZatOtQ==
X-Received: by 2002:a05:7300:df48:b0:2a4:626d:5c38 with SMTP id 5a478bee46e88-2ab7e7c42aemr952869eec.17.1764658493452;
        Mon, 01 Dec 2025 22:54:53 -0800 (PST)
Received: from [192.168.1.12] ([70.95.198.110])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a9655ceb04sm51337998eec.1.2025.12.01.22.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 22:54:52 -0800 (PST)
Message-ID: <ae7e7a10-5aa4-4381-a878-101af19714b3@oss.qualcomm.com>
Date: Mon, 1 Dec 2025 22:54:51 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] of: reserved_mem: Restructure call site for
 dma_contiguous_early_fixup()
To: Marek Szyprowski <m.szyprowski@samsung.com>, Ye Li <ye.li@oss.nxp.com>,
        robh@kernel.org, robin.murphy@arm.com
Cc: saravanak@google.com, quic_obabatun@quicinc.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, william.zhang@broadcom.com,
        kernel@oss.qualcomm.com, will@kernel.org, djakov@kernel.org,
        aisheng.dong@nxp.com, joy.zou@nxp.com, frank.li@nxp.com,
        jason.hui.liu@nxp.com
References: <CGME20250806172503eucas1p264d6731c73592fcc380b0dcc21cdeadf@eucas1p2.samsung.com>
 <20250806172421.2748302-1-oreoluwa.babatunde@oss.qualcomm.com>
 <416dbaed-a68f-4edb-a20c-94cb4c53c748@samsung.com>
 <cef8f9eb-88aa-4771-b25b-2cfd1ac2c387@oss.nxp.com>
 <3b0cc36d-0f7e-4d07-949f-fce670170247@samsung.com>
 <306596c4-cc91-4500-b705-50e619e9f38e@oss.qualcomm.com>
 <be70bdc4-bddd-4afe-8574-7e0889fd381c@samsung.com>
Content-Language: en-US
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
In-Reply-To: <be70bdc4-bddd-4afe-8574-7e0889fd381c@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UBwjAI4wxL5tdZk2EatpMQ1upWULHfe6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDA1MyBTYWx0ZWRfX0abfafxD/ygM
 sj7VuTe0c77FxQl4ndoyE7lkgyrIuxmEwJOcj23JfIZy7NJBnw0s1neooV6eFpkH2mzwo/C0Vzx
 oY9IKTA4wuFhg2iAAjqZQgzvn1Z36du2eEHmS0QbdPLwqIPPsRo7xDc9VfnKywlB6KSXGtKnClO
 5fD1CKMIcGoASamKZ58l4aI4pxuoZ88MXwTz/G39HtjFr+A/Qj4JgAr/7U033Jn+yqnJfRIKLAO
 dGf9jzYt1mym/ud2ECvmIZCu0gqydIAunrp240yB6YrdHJfqvNuj3cu9ZModxrJrplBR4zIU/nJ
 MP+Rf10SWMmTKECOh741jwqw+RsRhX5HKWiXAhZwpjRiGWbD4n6lEE1gIH+fb1UYOean3/02iJf
 u6dzcng/jZKR8E1qzSFQBbW9Q2wLfA==
X-Authority-Analysis: v=2.4 cv=Vcf6/Vp9 c=1 sm=1 tr=0 ts=692e8d3e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=46YzWcEg/N/3maUrm97V4A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=Q-fNiiVtAAAA:8 a=1SuC3FrLUNVSS-YJPQIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: UBwjAI4wxL5tdZk2EatpMQ1upWULHfe6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512020053



On 11/30/2025 11:51 PM, Marek Szyprowski wrote:
> On 01.12.2025 07:31, Oreoluwa Babatunde wrote:
>> On 11/28/2025 4:43 AM, Marek Szyprowski wrote:
>>> On 26.11.2025 02:37, Ye Li wrote:
>>>> On 8/11/2025 7:07 PM, Marek Szyprowski wrote:
>>>>> On 06.08.2025 19:24, Oreoluwa Babatunde wrote:
>>>>>> Restructure the call site for dma_contiguous_early_fixup() to
>>>>>> where the reserved_mem nodes are being parsed from the DT so that
>>>>>> dma_mmu_remap[] is populated before dma_contiguous_remap() is called.
>>>>>>
>>>>>> Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved
>>>>>> memory regions are processed")
>>>>>> Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
>>>>>> Tested-by: William Zhang <william.zhang@broadcom.com>
>>>>> Thanks, applied to dma-mapping-fixes branch.
>>>>>
>>>>> Best regards
>>>> Hi Oreoluwa,
>>>>
>>>> We observed this patch causing kernel boot hang on iMX6 (armv7)
>>>> platforms if using "cma=" kernel parameter. It only happens when the
>>>> size assigned in
>>>> "cma=" parameter is smaller than cma default size in dts.
>>>>
>>>> For example, we use "cma=96M" in command line and below reserved
>>>> memory node (160M) in dts.
>>>>
>>>>          reserved-memory {
>>>>                  #address-cells = <1>;
>>>>                  #size-cells = <1>;
>>>>                  ranges;
>>>>
>>>>                  linux,cma {
>>>>                          compatible = "shared-dma-pool";
>>>>                          reusable;
>>>>                          size = <0xa000000>;
>>>>                          linux,cma-default;
>>>>                  };
>>>>          };
>>>>
>>>> The root cause is this patch moving the dma_contiguous_early_fixup
>>>> from rmem_cma_setup to __reserved_mem_alloc_size. rmem_cma_setup can
>>>> skip the cma reserved memory if command line has cma parameter.
>>>> However, the __reserved_mem_alloc_size won't do it. So this leads to
>>>> have two cma regions added to dma_mmu_remap, one from dts, the other
>>>> from command line. But the reserved memory of memblock that only
>>>> records the cma from command line is inconsistent with dma_mmu_remap.
>>>> The dma_contiguous_remap clears the MMU paging for the region of
>>>> dma_mmu_remap firstly, then create a new mapping by iotable_init. For
>>>> the cma from dts, this causes incorrect memory mapping cleared. Then
>>>> any allocation from memblock in iotable_init hitting to the area will
>>>> meet MMU mapping issue.
>>>>
>> Hi Ye Li,
>>
>> Thanks for pointing this out. From what I see in the code, if "cma="
>> kernel parameter is being used to configure the default cma region, then we
>> should skip adding the DT defined region to dma_mmu_remap array.
>>
>> I will work on a fix which does this and share here when it is done.
> 
> I wonder how to avoid adding more such checks to 
> drivers/of/of_reserved_mem.c and making this code even more tangled and 
> spaghetti-like... I've briefly scanned that code and it is already quite 
> hard to follow, especially after commits 8a6e02d0c00e ("of: 
> reserved_mem: Restructure how the reserved memory regions are 
> processed") and 2c223f7239f3 ("of: reserved_mem: Restructure call site 
> for dma_contiguous_early_fixup()")... I wonder how many reserved memory 
> regions are used on real machines? Maybe instead of complicating this 
> code even more it is enough to make this configurable via Kconfig and 
> restore pre-8a6e02d0c00e version?

Hi Marek,

There was a change which attempted a simpler approach of increasing the
size of the static array:
https://lore.kernel.org/all/1650488954-26662-1-git-send-email-quic_pdaly@quicinc.com/

The comment from Rob at the time was to revive another thread which attempted
to dynamically allocate the reserved_mem array like we are doing now.
Dynamic allocation gives more flexibility because we only use the exact
amount of memory that is needed. This can save some memory if that ends
up being smaller than what is specified in MAX_RESERVED_REGIONS.

I do agree that adding another check in of_reserved_mem.c might not be the best
in terms of code complexity, so I'm exploring other options on how to keep things
simpler.

Regards,
Oreoluwa

