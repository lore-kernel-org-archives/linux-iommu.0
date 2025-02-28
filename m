Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92262580D7
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748932; cv=none; b=HJFmWXyjDTgRr9AhHKl76g/W/0fbwOH2Vkm5UCXvLOAygwCVh2yaLIZ27RUNNDBm+EecldoUX0NUZapDbNO+5H5pZqMhnYMCUZ94hFOlGausGh5YxjAoLqzQjtGzXpARXRHKdh1BE1oy3Xa/8j4+jidcL1OLwCZihNxS865v398=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748932; c=relaxed/simple;
	bh=4mr0hexFtp0KEt1s94IiDSIvYFhtZ1lr1JnXh5ewSzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=pvL7gmfbLxaIGa5RNOF955V4B8O+eqzXZbLM66OJdJAB1qNsm4v7CFlBUXYpmAYvHlncrR+l5xsEM/870bAf6edWKA5ZBRLhmt84X+IVX9aVkybNvp2PXS+CgIMwb1sZ6yJIxixQGL/Z4ruYtk0z3dyS573yWNL1yQWLkTQazIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=g2hu81R7; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g2hu81R7"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250228132207euoutp0173409a8180c9594f9e0fba2ed9da1e3e~oYe0iLk3c1962419624euoutp01V
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 13:22:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250228132207euoutp0173409a8180c9594f9e0fba2ed9da1e3e~oYe0iLk3c1962419624euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740748927;
	bh=mkTqnPxM6lVvuaP5UJLxWvWCBLiAF7VVUCUjv2SOOiE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=g2hu81R7E15Phr0yu+WEAjFcYzDRyx7K+TDVQNBEDp/kN0KbPD49/U9KyBDgli6BR
	 EIIli2mvM1FVBl4l950FZRoTlOgVEUD1asnlz6QhJdssF0NseGAP+d7YaYkckCrSIY
	 6xYYUHVNiviARcZOM8IuHPEJL42fCBVrPPOyrtmc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250228132206eucas1p1f0133fc8f2d394bac8e5ad7c1765e097~oYe0Y4Mg90039400394eucas1p1h;
	Fri, 28 Feb 2025 13:22:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 18.BE.20409.E78B1C76; Fri, 28
	Feb 2025 13:22:06 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250228132206eucas1p1c1563d36e726c3d766da1ac164b83eb0~oYe0BVS0O0968109681eucas1p1r;
	Fri, 28 Feb 2025 13:22:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250228132206eusmtrp260711fa9bfa86331683ed5bd76963d45~oYe0Au6Fk1004010040eusmtrp2F;
	Fri, 28 Feb 2025 13:22:06 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-90-67c1b87e3e86
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 70.4A.19654.E78B1C76; Fri, 28
	Feb 2025 13:22:06 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250228132205eusmtip1d75e9e9d686a42ee0777c6e46d792723~oYezJAjGN1320713207eusmtip1k;
	Fri, 28 Feb 2025 13:22:05 +0000 (GMT)
Message-ID: <8045065f-723a-4b1f-bd89-23a1ab98ec7a@samsung.com>
Date: Fri, 28 Feb 2025 14:22:04 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: missing clear bdr in check_ram_in_range_map()?
To: Baochen Qiang <quic_bqiang@quicinc.com>, Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel
	<linux-kernel@vger.kernel.org>, iommu@lists.linux.dev
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <b84c1485-de8f-4888-bed6-3690ed108a46@quicinc.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djP87p1Ow6mG2z+ZWKxcvVRJotfXyws
	Lu+aw2bx8OcPJouDH56wOrB6rJm3htHjxeaZjB67bzaweUzcU+fxeZNcAGsUl01Kak5mWWqR
	vl0CV8auOd8ZCz4LV2y/soK9gXEPfxcjJ4eEgInEodcX2bsYuTiEBFYwShw+fh3K+cIo0Tv1
	HyOE85lR4vbCd4wwLes27YVKLGeUWD9/PlhCSOAjo0TP7SgQm1fATmJjy10WEJtFQFXizvvH
	7BBxQYmTM5+AxUUF5CXu35oBFhcWsJbY93ExE4gtIuAtsevtLDCbWSBX4sHSW1C2uMStJ/PB
	bDYBQ4mut11sIDangL3E8+szGCFq5CW2v53DDHKchMAJDonbvS1QV7tIvGppZIWwhSVeHd/C
	DmHLSPzfCTIUpKGdUWLB7/tQzgRGiYbnt6C6rSXunPsFtI4DaIWmxPpd+hBhR4lzZ56BhSUE
	+CRuvBWEOIJPYtK26cwQYV6JjjYhiGo1iVnH18GtPXjhEvMERqVZSMEyC8mbs5C8Mwth7wJG
	llWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiByeb0v+NfdjAuf/VR7xAjEwfjIUYJDmYl
	Ed5ZsQfShXhTEiurUovy44tKc1KLDzFKc7AoifMu2t+aLiSQnliSmp2aWpBaBJNl4uCUamDi
	L9n7SvVm8HeZnC2/G1XztT59nPlg2ZGWVJG9Ft/YoxdVbOlSK0v++Te0/8/9D2L3XBLEhfyt
	2xbcZPnIFVDgsPr+u8XPIrmZbxWcN322YlEy8y3bL1dObF7340FTzu+KrQdkt6gGrK0RU4v+
	Zqm7bYVHJ+9bw4WxycWKXSfjbjNZ/swqCKr4bTUlZ+v844c5F060mSNb/MMwUPndm3srWjoy
	I2+VR23nSjHdEKG6cb7V2a/9wZM4bkU+lKy4lvb835P/u+Zcu2Ai9WXDRGZJvcNyrv5PDXcL
	bE81y8xx6Sr4UNJSZ3KfY8qnIrcLX3r/PnLVTNPVTC1+sbIvYtEf/akCMwOkBbUM86WWR4Qo
	sRRnJBpqMRcVJwIAF+LfbqUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xu7p1Ow6mGxzulbRYufook8WvLxYW
	l3fNYbN4+PMHk8XBD09YHVg91sxbw+jxYvNMRo/dNxvYPCbuqfP4vEkugDVKz6Yov7QkVSEj
	v7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2PXnO+MBZ+FK7ZfWcHe
	wLiHv4uRk0NCwERi3aa9jF2MXBxCAksZJY6fW8wKkZCRODmtAcoWlvhzrYsNxBYSeM8oce9B
	AYjNK2AnsbHlLguIzSKgKnHn/WN2iLigxMmZT8DiogLyEvdvzQCLCwtYS+z7uJgJxBYR8JbY
	9XYWmM0skCsxac1FNogjXjBKfLt5mxEiIS5x68l8sCI2AUOJrrcQR3AK2Es8vz4DqsZMomtr
	F5QtL7H97RzmCYxCs5DcMQvJqFlIWmYhaVnAyLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMj
	MLq2Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuGdFXsgXYg3JbGyKrUoP76oNCe1+BCjKTAwJjJL
	iSbnA+M7ryTe0MzA1NDEzNLA1NLMWEmcl+3K+TQhgfTEktTs1NSC1CKYPiYOTqkGJmFbe95N
	269ar7z4acKPcvYHHz5Kdk15+O1UF7tLYMgJlXXWeU9a3rmJf94n2b0h7+3/o80JpiciP9yf
	/yTzHgdLLsu+O9flbk3ksuy+/iT8Q0rQrZu8V5Y6Hrk8/8zE/kCWlspEsUCZb1cOL/kgcWLb
	x/dXYqpja3JSsrZMWWHzh0Hb8X/3yR/zmjby3fBJkymZ4GV5qlRtt4x9RubJQtYtHIc/MTnz
	Tth11obFZPVcbSH7J3KXI7J2Z/Wkh+zsONGrv6tK7MzDYxI2oQvyjrxKVQlXveyg9+lord/3
	FJO4wO/xt6yrrui4Tv1sdqb/8/YDAe4CS88/7v2munPefqekV0Y8pjpOXJyvm+vn3lBiKc5I
	NNRiLipOBAD2SYC4NwMAAA==
X-CMS-MailID: 20250228132206eucas1p1c1563d36e726c3d766da1ac164b83eb0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241220032532eucas1p2fafa0cbfde87d8dae47caa42c45d7ae4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241220032532eucas1p2fafa0cbfde87d8dae47caa42c45d7ae4
References: <64931fac-085b-4ff3-9314-84bac2fa9bdb@quicinc.com>
	<20241212071418.GA6638@lst.de>
	<CGME20241220032532eucas1p2fafa0cbfde87d8dae47caa42c45d7ae4@eucas1p2.samsung.com>
	<b84c1485-de8f-4888-bed6-3690ed108a46@quicinc.com>

Hi,

On 20.12.2024 04:25, Baochen Qiang wrote:
> On 12/12/2024 3:14 PM, Christoph Hellwig wrote:
>> On Mon, Dec 09, 2024 at 06:50:06PM +0800, Baochen Qiang wrote:
>>> Hi,
>>>
>>> while checking check_ram_in_range_map() I am confused by the condition set/check on bdr.
>>> If I am reading the code correctly, if bdr is set once, it would never get cleared, hence
>>> that function will always returns 0.
>>>
>>> should we clear bdr before each new iteration?
>> I think so.  Even better refactor the code so that the non-NULL bdr
>> doesn't leak out:
>>
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index 5b4e6d3bf7bc..181e244f410a 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -584,6 +584,22 @@ int dma_direct_supported(struct device *dev, u64 mask)
>>   	return mask >= phys_to_dma_unencrypted(dev, min_mask);
>>   }
>>   
>> +static const struct bus_dma_region *dma_find_range(struct device *dev,
>> +		unsigned long start_pfn)
>> +{
>> +	const struct bus_dma_region *m;
>> +
>> +	for (m = dev->dma_range_map; PFN_DOWN(m->size); m++) {
>> +		unsigned long cpu_start_pfn = PFN_DOWN(m->cpu_start);
>> +
>> +		if (start_pfn >= cpu_start_pfn &&
>> +		    start_pfn - cpu_start_pfn < PFN_DOWN(m->size))
>> +			return m;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>>   /*
>>    * To check whether all ram resource ranges are covered by dma range map
>>    * Returns 0 when further check is needed
>> @@ -593,23 +609,14 @@ static int check_ram_in_range_map(unsigned long start_pfn,
>>   				  unsigned long nr_pages, void *data)
>>   {
>>   	unsigned long end_pfn = start_pfn + nr_pages;
>> -	const struct bus_dma_region *bdr = NULL;
>> -	const struct bus_dma_region *m;
>>   	struct device *dev = data;
>>   
>>   	while (start_pfn < end_pfn) {
>> -		for (m = dev->dma_range_map; PFN_DOWN(m->size); m++) {
>> -			unsigned long cpu_start_pfn = PFN_DOWN(m->cpu_start);
>> +		const struct bus_dma_region *bdr;
>>   
>> -			if (start_pfn >= cpu_start_pfn &&
>> -			    start_pfn - cpu_start_pfn < PFN_DOWN(m->size)) {
>> -				bdr = m;
>> -				break;
>> -			}
>> -		}
>> +		bdr = dma_find_range(dev, start_pfn);
>>   		if (!bdr)
>>   			return 1;
>> -
>>   		start_pfn = PFN_DOWN(bdr->cpu_start) + PFN_DOWN(bdr->size);
>>   	}
>>   
> looks better. thanks for reply.

Could you send a formal patch with this fix, description and 
'Suggested-by: Christoph Hellwig' tag?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

