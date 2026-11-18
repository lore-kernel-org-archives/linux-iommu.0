Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021533;
	b=XOB1vqiyf+d67GXWl3hofPvsOkcddH0VSzMX/VAr25Poi5WTyvaEk/yjTkbAnM3UdQya
	 h8nm7xkw4PPgNDcwo/q02unzwEJAcVPS/MsEUFk5gTxCajskRZzzgArr3qcaOl2DolKyY
	 nAxN4FEkZHIuE9qu/F0XQiPfsM5Qy8EaHpoCi1ENZEPCiE28XxdIsODgIaLLp602UjAXS
	 kCdQ4V230bRXhjvUo8wOB2QsOfdz86tv0sluJP/5LOZDzKHYvNYFTN64Aq+2NbyFHXdQ1
	 knOS1bkRQ9SUuoARbNNIpdPXu8nWuDCwiq+xIu7r4U/F9P4dzaUT/j15dJ4D3MVu0Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021533;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=I/lMXOtz4EWJJKG0P4frA8Ehhog3XZ0EjDEz2sNipZc=;
	b=PzJouQzN4725uPbFH34waXbdr92LY5L0NxSNU3FNUso1J5lmHb3hwXkvbfeOpo0iyR3u
	 r8Fx3Ug3/2OUBdX3lX5vWLNR1bjiAF1m3aTP4pCuyjY7vegUFGeKFFKoU9EhEJtoIpLGH
	 gRwhpGMKm5b+RMa7/ge1Km5LCytxHhLukKnXho2VKHz2Vu31s3eCZkXtozEpFTNlPj6op
	 qG9lB5ud1KMY0VKiMkMeYK8Jqa4Oh2RtFawt6CoLo3r3m03QRtcPmJ55jxDSTLpx0hiKc
	 VkRA4ZH1NjTsYdQQXTo4HVYraMdQX3/ezOHdQ95GKWbEmEnEVl0k5rXAuaVBOGcFdSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ImR8mc7u;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=La3oHVO4;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B8E606A335
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 17:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23B8E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ImR8mc7u;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=La3oHVO4
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIH3k3O2421339
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 17:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I/lMXOtz4EWJJKG0P4frA8Ehhog3XZ0EjDEz2sNipZc=; b=ImR8mc7uO2A2P6cR
	TjbIuNgUkEF4WR51XuokFFlfMYru6HZBwpUzGoYaEIbRCS8L7utLI1/1Cgr1wVl1
	/vbc5FSt1g23CbX5o1qd6Vcr+Cgx+AIsRn6w1+kdMBy3csmTbey5V2XWUVkfLP69
	U6NHmsqrYK6vcNhiIzcpZUuSnS/hMygb7dN1t9DXmtcdaEqDjKjX1GQ5wDSvrg3i
	lrAsh7K+zMPxeYvHMuMqUoi3yRd83foswWJTDPpFLjsHakX8FN41ZtOLU7rxJf33
	YFYbZtn40KEef64Pa4d9/lO+ZERp4whyy3bcYPJdYTM87+Ynm+9x/B/GO3urbEj9
	JAoa1A==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g3b80a1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 17:05:31 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b3a348a6dbso2427471c88.1
        for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 09:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795021531; x=1795626331; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I/lMXOtz4EWJJKG0P4frA8Ehhog3XZ0EjDEz2sNipZc=;
        b=La3oHVO4sYNNgeUfYbzSaMbQCFUtH8vXLi67kTzoM5Nzwypqm6S23QJx7kRxg6yQtO
         iRheIgNchsGKCtt26QFFYcP11EOCFyct8MOlqdG+eqfTPAfX6eAd0mXixDHeydLMFpsB
         u3cUaRttogpjEJXSSUr+x+QwIaj6tgmC2Y+Le242CPOIZLqMRXPrrucupY0VAW8191gg
         86hJWocLdBxIsyZ7+uwnufQpANELj61Crm3XmVIlqyX8Rn4L/YX/joFs4IE8Dlg5Yxkl
         c7H6m8af+bW3hSZixYJ3KxstTdfz36BHt+Md9cG2MblPCUaUWv78WGyHThbjUU7RoHnz
         wWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795021531; x=1795626331;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I/lMXOtz4EWJJKG0P4frA8Ehhog3XZ0EjDEz2sNipZc=;
        b=GA8au4/yqsr2J8H3Vkl56Q6/t1rH90HCyW5DuwgeFLaNLF2OWW7x9iYBus8HyeCpGp
         UmiajL3ZkojItAGGS8uY/p+JhQcrB2vn4cT3v3X7w6wa+miZJWfJNdP45fcnPdeBjOFU
         C8mILW1Q3uWxoaZyIY32VIJ8TqInto1VSW+5rF8yShMD9si8WuycXOgsdt8+zb24z50R
         pn4l7izm/JQLlSD0YQp16BUqddWt9VJjStFjOOfUCMmQ1jDLf9ozfhxm+rOI1o1lIwsU
         vKQW0ejGTiyVIcURjn9YhFNNJnNP29fI4Qg8miRRkStJ8uNMa4ygEYRrYvaQ6EVaRA6p
         AmkA==
X-Gm-Message-State: APuU4Z87UZqM8vRuOal4f9fsn1jpQ+Xvb0bV3AVGzYVMV8lgQKxKhg/g
	JemX70tR4KXWvGoVTgJ71+LFyRB/KqghIlpL1pfvObuS9rWt6T9/h75QPFDThjKwx46fQ+loQxB
	0mMEVrH0SCykUu/DTzTQpdf1hiYkit6PWIYcanZLictEiz8sqeM/bccPGQQ==
X-Gm-Gg: AYBFou0zUlE+ApprK4xPOpDiEqrqGdz0jz3G+C5rIfsMI5LdNyQQN2spXAodyhXaVMw
	J8z48as2I9DN8IoIbVQWIKrXgslHv2Xzs1TEJUX0agKAlvYF2Poxamltv7sPiqEJjTqmD+tN7ZJ
	wHQ3Mn6m2JQwmLHzyl0B7nAE+LUtZ4AfCzz5tOZaWa5nVYkgNJswheXB5VUyVLkLZ4IU87Kbv/T
	c4y2U/FNLuCibqnSKVbYrDlYI9yDGar6+H+yah+hNpi9TmfhwkgeVGEzsNqjEgamD35rnORPzuX
	+iGshDl3eRTA+IIDgoIgExKSESW0irarHQhF1XJtixjy9mBXvdF9LtwAgY0oL2+/veZYaZPK8zf
	ZIj2ecu291Xf9VY5v8uljNwt8ttvaqacfdergdDU5TdS8ZNG6tinbg/o9/c/89TvHaWrSpnqjzT
	3osQ==
X-Received: by 2002:a05:701b:290a:b0:1b5:2de3:bcfb with SMTP id a92af1059eb24-1b543c13186mr2735369c88.25.1795021530426;
        Wed, 18 Nov 2026 09:05:30 -0800 (PST)
X-Received: by 2002:a05:701b:290a:b0:1b5:2de3:bcfb with SMTP id a92af1059eb24-1b543c13186mr2735304c88.25.1795021529708;
        Wed, 18 Nov 2026 09:05:29 -0800 (PST)
Received: from [192.168.0.4] ([183.83.140.41])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7bc05cfsm9641856eec.26.2026.11.18.09.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 09:05:28 -0800 (PST)
Message-ID: <59ab240d-57bb-c00c-5409-c22d0eda69bd@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 22:35:16 +0530
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
 <ce05d74a-58d1-f605-44c1-ceb9b9d8b9d4@oss.qualcomm.com>
 <2a282370-025b-4c0e-8a87-4d05aa1d87a0@kernel.org>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <2a282370-025b-4c0e-8a87-4d05aa1d87a0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: uRBUdtXfoDXvKWW1pZLwl5hT9Jy4id8e
X-Proofpoint-GUID: uRBUdtXfoDXvKWW1pZLwl5hT9Jy4id8e
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2NyBTYWx0ZWRfX3m+NpFOGjIbq
 bUAgCKCLrDzwleig3C941GKrrAwDraCFtQgsac+fBGRotevbDFXWlwsenQnzerpHMpuPF44H9z4
 CqZKg0fiz8QNQz4KN5ihloP9vdhu0RQ=
X-Authority-Analysis: v=2.4 cv=dZQVTnXe c=1 sm=1 tr=0 ts=6afddadb cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=jbSCbZcLpKDW+DqD08IedQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=yUPLNtyCCiW4yRupJn0A:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2NyBTYWx0ZWRfX5VRJI7C7wzMF
 1B3nPAYFuQcnmpcxeYc2QJv6uxWWIf1U0xita11gNFwvPJVHZe1/A/RPe2ji9tILz89hTYehW1l
 XZu7W16puxHhs3kke2Bww+mVTK1hesL88aCel43l2HyF5V+Jx5AWFmELyWNc4ozS8rJOzpEU69A
 kYA0JG51GilN68fwy+Ce+VJHEVHdEdP+029ivjFtsg7v3pFeQG5rNqnLXBpBwECqqGQ7Ih82ko3
 dzk+zioBLolFn8O9iJ9HlvCXvLHYbzlnTEER4ui07MN8uIgWm4qpcNU5/Y1zxbR+8UfORYpDGIk
 wmpmFnO1JoNGwmVbNmliZlkhE2nu0ZpcQVqTDpCviAh9UkUpjcWKxHMhNEZ6MRzLzT8aH6jtai/
 RxYF5ROqLugbF92/DOZAVzGVj/ButjLrIRykUq75y5IsJP02InZLXWWlXwVt8Y03lmwMuZH64tv
 57vLQF2Jeyqe+OyiEGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180067


On 11/18/2026 5:57 PM, Krzysztof Kozlowski wrote:
> On 17/11/2026 17:24, Vishnu Reddy wrote:
>> Hi Krzysztof,
>>
>> Thanks for review.
>>
>> On 11/13/2026 6:41 PM, Krzysztof Kozlowski wrote:
>>> On 06/11/2026 18:14, Vikash Garodia wrote:
>>>> The "iommu-addresses" property describes an identity 1:1 mapping between
>>>> an IOVA range and the physical memory specified by "reg" in the same
>>>> reserved-memory node. Without "reg", there is no physical memory to map.
>>> This looks like ABI break.
>> The original discussion was to avoid keeping iommu-addresses in the
>> reserved-memory, if not backed by reg. In such cases, it is more meaningful
>> to move that entry to corresponding device node.
>> Given this direction, the schema was defined accordingly and the code is now
>> updated to match the dt-schema. At least on Linux, I do not see any client
>> using iommu-addresses without reg.
> Yeah, but ABI is for all users, not only in-tree.

To avoid an ABI break, it would be better to preserve the existing
iommu-addresses behavior and avoid this change.

>
>
>>>> The DT schema now requires "reg" whenever "iommu-addresses" is present.
>>>> Align the kernel implementation with this requirement.
>>>> https://github.com/devicetree-org/dt-schema/pull/207
>>>>
>>>> An identity mapping requires matching IOVA and "reg" ranges. Reject
>>>> mismatched ranges and report an error.
>>>>
>>>> Suggested-by: Rob Herring <robh@kernel.org>
>>>> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>> ---
>>>>  drivers/iommu/of_iommu.c | 32 +++++++++++++++-----------------
>>>>  1 file changed, 15 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>>>> index 6675fc900e6c2d55b34c61dc9effaeb48e24f18f..00b02c19f27e195fc36c4bc1d91253255147c9ab 100644
>>>> --- a/drivers/iommu/of_iommu.c
>>>> +++ b/drivers/iommu/of_iommu.c
>>>> @@ -174,19 +174,12 @@ iommu_resv_region_get_type(struct device *dev,
>>>>  {
>>>>  	phys_addr_t end = start + length - 1;
>>>>  
>>>> -	/*
>>>> -	 * IOMMU regions without an associated physical region cannot be
>>>> -	 * mapped and are simply reservations.
>>>> -	 */
>>>> -	if (phys->start >= phys->end)
>>>> -		return IOMMU_RESV_RESERVED;
>>>> -
>>>>  	/* may be IOMMU_RESV_DIRECT_RELAXABLE for certain cases */
>>>>  	if (start == phys->start && end == phys->end)
>>>>  		return IOMMU_RESV_DIRECT;
>>>>  
>>>> -	dev_warn(dev, "treating non-direct mapping [%pr] -> [%pap-%pap] as reservation\n", phys,
>>>> -		 &start, &end);
>>>> +	dev_err(dev, "non-direct mapping [%pr] -> [%pap-%pap] is not supported\n", phys,
>>>> +		&start, &end);
>>>>  	return IOMMU_RESV_RESERVED;
>>>>  }
>>>>  
>>>> @@ -211,12 +204,14 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>>>>  		struct resource phys;
>>>>  		int size;
>>>>  
>>>> -		memset(&phys, 0, sizeof(phys));
>>>> +		maps = of_get_property(it.node, "iommu-addresses", &size);
>>>> +		if (!maps)
>>>> +			continue;
>>>>  
>>>>  		/*
>>>> -		 * The "reg" property is optional and can be omitted by reserved-memory regions
>>>> -		 * that represent reservations in the IOVA space, which are regions that should
>>>> -		 * not be mapped.
>>>> +		 * "iommu-addresses" must be used in combination with a "reg" that provides
>>>> +		 * the physical address and size of this memory region, for an identity 1:1
>>>> +		 * IOVA mapping to that physical memory.
>>>>  		 */
>>>>  		if (of_property_present(it.node, "reg")) {
>>>>  			err = of_address_to_resource(it.node, 0, &phys);
>>>> @@ -225,11 +220,11 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>>>>  					it.node, err);
>>>>  				continue;
>>>>  			}
>>>> -		}
>>>> -
>>>> -		maps = of_get_property(it.node, "iommu-addresses", &size);
>>>> -		if (!maps)
>>> I miss the point why you are moving this part. Irrespective to actual
>>> ABI break, why do you nee to check for iommu-addresses before?
>> It is more optimal to check for iommu-addresses and then read the reg. On the
>> contrary, earlier reg is read irrespective of iommu-addresses is present or
>> not. So in a way reading iommu-addresses first would ensure that reg is read
>> only if iommu-addresses is present.
> Sorry, I don't follow. What is here on the contrary? To what part?

The intention was only to avoid parsing reg for nodes that do not use
iommu-addresses. Given the ABI concerns, we can keep the existing behavior.

>
> Best regards,
> Krzysztof
