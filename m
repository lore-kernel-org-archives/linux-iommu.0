Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932693;
	b=A7jbGixBcqgMRGPAIZTDw6knJ6EHKpHlJyxwFF36Vdf62Kvvy+MKd2hzXG1qkX2lfU0w
	 TNokCHYdCejpLeU0hcF5j9mB0h+4PN9p4vIzjKuIW+hrggB/OcQqcHnSRoJ2fv86iQQQM
	 B9xdkLffP/uL7wRlMkbxeWaNMjpJbJSEXNpiMgffv/zKFMuhBg+7MYvhRLRgrgvDP5k0u
	 mZL1/haTyFLgCkavuSxqQiJLiNZUSK3SGoZhdRQWbTvybIJhg/iqUYsIH3GH+yWoLpg8k
	 xsxrTXTpIk68G5YDhi8g49voXgRnu9jMQkfY3874UdqyqT+vWhtDUfDQcL0GEeadGgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932693;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=T3Mhl0Vqz4AuhABF36OZze4u1FZDWFRX6ORovKiY0zQ=;
	b=5cJXDZ30aCEBMOf+8cbDMN12OQdgTad5RVUADBvx+6D78DSSKB44fCYsAB4CUSyyKMY8
	 /aHNMDlwUIFoL/UNNrqSYTWTZgEJ47Ro2mPvGs3grzwIHYdcIgsUOXtzhMsGBE4awvCOq
	 UMsdRQ8kPK382QmEOZEbvne9tHgZiNx5MIR5cxO+OTjbPsu3aaW26XZGFNtX8w+/ftQ7K
	 St7nAjqJp/kmn5QLMDTYi8l0Rd5yz9P09tPKdmXMU+y6s4fq12+oSnYpvirip0KuSfguh
	 +oG6Y33pHqyDClTJekrABwW+Mpu/4j4HfgT+tltZhua7ShO3k55NS2p9mat+Q0rDH0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TOQ8+lCU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WxNekRGl;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB939606A32A
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 16:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB939606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TOQ8+lCU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WxNekRGl
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQNU61141636
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 16:24:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T3Mhl0Vqz4AuhABF36OZze4u1FZDWFRX6ORovKiY0zQ=; b=TOQ8+lCUML5ZO5h5
	H/qF60e2dPbCcKHoYulEN4H55jM5yHe+56cu9z5mHWHJvDpenV3Nx8kiTSJ6jQHp
	bhh7xA0QexaksUp3Rqqb1lIlzXljRLnYmuNw7tWpcyiizbcPqOpo2hqTwloA5g6s
	IaovTRep/vtw6UMFwr6B2eV+EAwdQm6qYPEAvPTlxQHd1lzS1wzhOfJGBzi8jOAE
	rPdLUBbDbWn9VxP2HR6YRcotGmxxAwj7RiauSqrxOxD/Vqk7a9jikwbX8PWixTMc
	cqAGMcFJYiWnFHqMIe6wY6jJAjQr1q2n9s9/tDRnM9QAfNxNVyXdUyiCFV2xKFtj
	DC+G2A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0s9t0cg0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 16:24:51 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36a3451ea93so36200eec.1
        for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 08:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794932691; x=1795537491; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T3Mhl0Vqz4AuhABF36OZze4u1FZDWFRX6ORovKiY0zQ=;
        b=WxNekRGlXmvMGoCQJvnvwtBv2gFhz9ENUYP2+ULRGxscELCp8AHF2GPgjD3f6Cj3vl
         0ZvDijBjelNcWG//lFw9Z+9Tz9bMBQOTvXjOQw8A4UUzAD4iAwhlcUE4EihUDwvnQHPV
         o6G6M4NzONyb2Op9OMEf7G3xYxrh4bjMRX3zFnDQAOoUEDri3azZ4XAlx5f6ZONToLSX
         xbk+aXGCv+JwXkAM/HzKQeWW3Zaozm4y04y8/Ae61P+0IE5/YzGXu8FbYXRdZxXHeUIQ
         IouIKq3zBIP8B6yqZTEeLYFin0Vwsha89htonnkbCTesyUl51EcMuXSDF2oVI62Zf0cs
         yBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794932691; x=1795537491;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T3Mhl0Vqz4AuhABF36OZze4u1FZDWFRX6ORovKiY0zQ=;
        b=mXbcGOGweF+j4JCqwdSVpFT/sRjp+aYeCUBCpUX6IB1Ip8Tjs7V95C2kcY7RHKwgRn
         73/WlB3JOjpNxe2DhhW0Ugf2X7hLnsw5AD6R4VvZEETWLAF224PtJ2KHO4MzgRZHMTFb
         x5rY8Vl3Gwhp8e2kbH+ZSfiKU1Lt6d4Iam82zMqoxIlFtpQiPQiSvXgEEN892cTRm9HP
         g6BDPfk0g4fILwM1HDlQ4kGAoKJBiMMl5C8gdfdjsP3xoUpqj8PMxr6dWcRO2TDGF9i/
         c1RchayiDtt/EM0PsEbt1SaZrMffAiWEAkcfgWGNdmyj/Ya6NVkyoNN0FwQbDMlwb0xo
         97vA==
X-Gm-Message-State: APuU4Z/GboReF3Igu5MOJIa9Qpqx4Ccc15U0+HJ2rQsD+9MLCeBMr1mB
	zPal+8eCwG5LcuOZSLL9KkLfI3c8oXoL52u7iBtsM3LVdMn+H/4gzmv9TwOL0+yEgmUF1asTBzk
	dkUpJRCgXcXYVMiq2IhyYXKMbvg4XZLljfaveZaaASe1JD/002nqnPnZ43Q==
X-Gm-Gg: AZFdTZcIEfc2tan+z6fWIBMjj3qxbJOxsxNinSDrp8C1aLJLRMU0r4bNA2PgPWDFsrf
	1f1xec731xhhcz7gmxzQPHvDvD+CrI/v/NTn13iNbVbJrwSZeNiubGdluEp6UEYYh+mDGlW2MCC
	K0k+uazWsUhIk2+hiEjtthKBHo/4Eh6YBbrAKGgWmRKatPNqfgrBDUIePSjb4GxBubhdz6TkbDS
	G/dS32VoPaG90GQdof/qHh6YrsV+shw/s1vl+NGB7kRmiMyt2E0yfCBVQhRF0UFKd7ys80HeNJf
	CJGOHa5hwRDTIAsNsAVYpAiDx3Q4KgqnYvwF+smj3NUfybFAU+hqA0ygDbBU6EPhKrNs8ZOHUzQ
	g1qVIJJfpdMoytGm3wdQIMqYhilpRBmfZR8zW2Y+UkcMdX1jv70S6xaIlhAkgplWxqPRti3wbWC
	JlFg==
X-Received: by 2002:a05:7301:d189:b0:376:2ddd:2ab1 with SMTP id 5a478bee46e88-37963660405mr14266823eec.4.1794932690876;
        Tue, 17 Nov 2026 08:24:50 -0800 (PST)
X-Received: by 2002:a05:7301:d189:b0:376:2ddd:2ab1 with SMTP id 5a478bee46e88-37963660405mr14266785eec.4.1794932690165;
        Tue, 17 Nov 2026 08:24:50 -0800 (PST)
Received: from [192.168.0.6] ([183.83.140.41])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d269asm48642584eec.23.2026.11.17.08.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 08:24:49 -0800 (PST)
Message-ID: <ce05d74a-58d1-f605-44c1-ceb9b9d8b9d4@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 21:54:39 +0530
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 4/5] iommu/of: Require reg for iommu-addresses
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Joerg Roedel
 <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-4-5c0f72083e52@oss.qualcomm.com>
 <3e4b6491-2b58-4b9c-90ad-0912f47cb217@kernel.org>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <3e4b6491-2b58-4b9c-90ad-0912f47cb217@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: r86-p2LuvdLfMmCpfWjFNahn4uPtMLxN
X-Proofpoint-GUID: r86-p2LuvdLfMmCpfWjFNahn4uPtMLxN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2NSBTYWx0ZWRfX9FSkOCfENozn
 7wtxsYmffw5rL/Ih6plilGCIL/qPWIYs8K1cr5pF/O6DMwZXH47/Kq8i/wl/zctJGE/0AWDRPLZ
 KVxGZ+WOD2dfErsFIBN7JwyMiYwX1WNaLxhIfWNexyEIu8OBUiUPNV50qM66/wklvjI532Yu68U
 rROmjj8nMqVFe/cgxs7YSFFtKtHFIfUyHrpgmQhps0t/OdcgqaqZCPDCV1POzdEeSJblywTPMaF
 aSuCLCq3wewG2T9OXzCMzj21Rq7YCvV9lmosYHHVU3pYbkU+63ldpnOHYKYIU1wFj7xpWCwYTUd
 3OY6leeLjkk74Zzia7FQ4aBXjfUJH5Oyg8uO1dzarJ0yVpJwuQwmXw/ibLahATZU6VmJe57IaqF
 1gGQ9UwPhwEwL5YVGyeLvs2Pdq4tyyfO7QxkDMTJg6ANkAu3jpE5kC4zu3SsTIF5EkYoXygbJpD
 NGAP+sQw1G+fTmLfoqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2NSBTYWx0ZWRfXyt/KgKfWX+St
 8u3FjmNmruJl39HMJFNBiIBYEsN8vIIDwNCMuEkV9Tgm1AWLjE3VOx0qjmLm4cYHaukMlfgTFHN
 72hZMI4wWsw9cFiyJ8UB7xJoVTzlvsc=
X-Authority-Analysis: v=2.4 cv=d5xgWhjE c=1 sm=1 tr=0 ts=6afc7fd3 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=jbSCbZcLpKDW+DqD08IedQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xx2vz8YcUDPT77_BzWYA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170065

Hi Krzysztof,

Thanks for review.

On 11/13/2026 6:41 PM, Krzysztof Kozlowski wrote:
> On 06/11/2026 18:14, Vikash Garodia wrote:
>> The "iommu-addresses" property describes an identity 1:1 mapping between
>> an IOVA range and the physical memory specified by "reg" in the same
>> reserved-memory node. Without "reg", there is no physical memory to map.
> This looks like ABI break.

The original discussion was to avoid keeping iommu-addresses in the
reserved-memory, if not backed by reg. In such cases, it is more meaningful
to move that entry to corresponding device node.
Given this direction, the schema was defined accordingly and the code is now
updated to match the dt-schema. At least on Linux, I do not see any client
using iommu-addresses without reg.

>
>> The DT schema now requires "reg" whenever "iommu-addresses" is present.
>> Align the kernel implementation with this requirement.
>> https://github.com/devicetree-org/dt-schema/pull/207
>>
>> An identity mapping requires matching IOVA and "reg" ranges. Reject
>> mismatched ranges and report an error.
>>
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>  drivers/iommu/of_iommu.c | 32 +++++++++++++++-----------------
>>  1 file changed, 15 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index 6675fc900e6c2d55b34c61dc9effaeb48e24f18f..00b02c19f27e195fc36c4bc1d91253255147c9ab 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -174,19 +174,12 @@ iommu_resv_region_get_type(struct device *dev,
>>  {
>>  	phys_addr_t end = start + length - 1;
>>  
>> -	/*
>> -	 * IOMMU regions without an associated physical region cannot be
>> -	 * mapped and are simply reservations.
>> -	 */
>> -	if (phys->start >= phys->end)
>> -		return IOMMU_RESV_RESERVED;
>> -
>>  	/* may be IOMMU_RESV_DIRECT_RELAXABLE for certain cases */
>>  	if (start == phys->start && end == phys->end)
>>  		return IOMMU_RESV_DIRECT;
>>  
>> -	dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap] as reservation\n", phys,
>> -		 &start, &end);
>> +	dev_err(dev, "non-direct mapping [%pr] -> [%pap-%pap] is not supported\n", phys,
>> +		&start, &end);
>>  	return IOMMU_RESV_RESERVED;
>>  }
>>  
>> @@ -211,12 +204,14 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>>  		struct resource phys;
>>  		int size;
>>  
>> -		memset(&phys, 0, sizeof(phys));
>> +		maps = of_get_property(it.node, "iommu-addresses", &size);
>> +		if (!maps)
>> +			continue;
>>  
>>  		/*
>> -		 * The "reg" property is optional and can be omitted by reserved-memory regions
>> -		 * that represent reservations in the IOVA space, which are regions that should
>> -		 * not be mapped.
>> +		 * "iommu-addresses" must be used in combination with a "reg" that provides
>> +		 * the physical address and size of this memory region, for an identity 1:1
>> +		 * IOVA mapping to that physical memory.
>>  		 */
>>  		if (of_property_present(it.node, "reg")) {
>>  			err = of_address_to_resource(it.node, 0, &phys);
>> @@ -225,11 +220,11 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>>  					it.node, err);
>>  				continue;
>>  			}
>> -		}
>> -
>> -		maps = of_get_property(it.node, "iommu-addresses", &size);
>> -		if (!maps)
> I miss the point why you are moving this part. Irrespective to actual
> ABI break, why do you nee to check for iommu-addresses before?

It is more optimal to check for iommu-addresses and then read the reg. On the
contrary, earlier reg is read irrespective of iommu-addresses is present or
not. So in a way reading iommu-addresses first would ensure that reg is read
only if iommu-addresses is present.

Regards,
Vishnu Reddy

>
>
> Best regards,
> Krzysztof
