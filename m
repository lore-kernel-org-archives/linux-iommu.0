Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9982930BF72
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765362494; cv=none; b=EqqxtThzUexDmZ/1RJ3fEk39OVCYglCLxXk+dd3DZtxj8TVuD1deNonONETCiBLErOYVWPecf4Kaf1YWwMIPgofDM9qDprUtdrNKCBrMqAIWPyRbcg6M7+CY70EOCpYzWZwJyBTU5i2thapR0+4lDfkWwThCwBAkz8Ko9eYFozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765362494; c=relaxed/simple;
	bh=e2d1nN9vZZyxBa7Sl1GhNH2B0vSKMw5eUK6Irnn/SrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pf+IRFYrS/SwYYeZMbtyJ+A/JODhfPzKI0Y0rtyViIRyUi+clSaalJItWoexZAuvVaxhiOr7lhQiu7EX4N/vOrhYl1yvkuSswp7BFN93jcLkkguGFMvV5IhSfCtUJxxFpIkHyYAocUF4USEALUr/Hsxz9VhV+v6CfxRpDrGd61s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ogmm0dKw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TOXZfLc7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ogmm0dKw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TOXZfLc7"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BA8eevx1935184
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 10:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	exDTPs1Pi5axMsUuPr9hRXPuDYGGlP18J5d8Yr726cE=; b=Ogmm0dKwRSjdqXU5
	Bh0XR/7S2LNPUb8OHYxeOIvv5c3pRlkShporSquCKGSkabnEgAGGRxvL9jsE1iY7
	SwcmYqQVKVZl9wbWJ1pmat1uyeX7TiOOQHIeH5069TL3AtjZ3CfgPMQpr83wMtus
	ZjRqPXiR8X6Xcodi+8zVneIt2p3X3YWKI3I91agv33eiSscgl4SnzcsANWZLpvPn
	joMBpGtkf96WjLQWuYlOE0HOw/lwVOk8EsNDBE9ItDBnGkcsA78Do3AzJc5S8U5f
	sMHx7LWih/cXqU0bAFI1Y6sm7ZtvXnF7BZZtexvk8A8N8W1WDhxYGNeQStBA9w0+
	M9AhgA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ay505gftv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 10:28:03 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b9090d9f2eso11828101b3a.0
        for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 02:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765362483; x=1765967283; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=exDTPs1Pi5axMsUuPr9hRXPuDYGGlP18J5d8Yr726cE=;
        b=TOXZfLc7S7LGoXIaMk51mWdm5Po/DQUL5i1tU+vFh0zEEBYO7qnOMHFfdsW4dWLk9v
         20a0bByZZ0vE6NYLTimBDp/Zt8jvMnnQuhZOd0HU6RpzrEqdEL2tc7Ip39Vm26PWY0sJ
         mYp0r9pvnVAJJLCsJ6kKZqOg4sjCiYhP7EoDZLyShjS+wkD7JRzcRln/nlySZ1XHA16K
         tzDJzakXspnRe4c0CrirOf6m9rhiOlgQyOpu2y+N3gDJl/XTqsM2T2CZSJ3ccQKW6E1U
         6/2b9E3czxTvmdIoLYdWcG6+AFqmMXB2g8rX55vAxLaaIjqOYw0u6jxwirNaXKPBF3qW
         I4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765362483; x=1765967283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exDTPs1Pi5axMsUuPr9hRXPuDYGGlP18J5d8Yr726cE=;
        b=cMyZfZ96CO/bU+35jV5INe6vDM5R1e8nH2o68OJXl7huQP75oQbDQ99g65gi9qVlaI
         IaXeI3ezXF+PdLA+x2s2uFN3WlpipFfDY586Z5P176H2Vz3S9sxGNewXq7T7g94caQ3e
         C3olQMCyv/G7zewfqWBeJHKo+3CXbN0TeCI78Oh3Vf27qfHRUK38lFdSEDUlyoUJsppu
         lZC3UZwArDUEbm/lr2mhuy5XjbxMapWQ8QOPhPFsQBg20eTF9Q/PrB1n2Jle43c/Taak
         lK9NjFRbvcTkC2JXIV1W6NbvnqmyNbS/e4A65c9Of3Uoju7lc9zMzYYoqf8AGE5xElqh
         Wy4g==
X-Forwarded-Encrypted: i=1; AJvYcCXMrjc9BcNzTNSbm5h8BpDE4SR2NnMg1j1DQNPpQOAVUl4bJacRKFcRp6eJ8CeOs7NHjBgsbA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxq0m+o8l38I8PJzEtr84n8VzSuf9h2rFCtfUC14YcarDmZLanJ
	RV+19o1QAJREhuIj4/B7LVRpn/7hoHacl/U9vSK0nQiEwVdrp3C7+eEWq2gYuQdHTrLUXPw7mVq
	80IQ8FYlwFCv20vWPjoNvm63MNfrPMR1qaG6CKsA7uarC43HRxUgslMdVbA==
X-Gm-Gg: ASbGncvyk+8hdvV7nB+/T/JH028yVjFbvWu+QguYIKKzWxDgYSwwMyJUzMAPaH11PDA
	ftsMhZvi5zMJ7MwjwwEdwDk24BBgwE5heqvgO1VJi3TZVdcx4axGOuPqB2Q0hb0x40EGmICAq75
	0n2f/5BHdnLThdr5aw3wpZYJGNhfEPkoBRrr9ssXAkdL3LiGW2NkYjEXG3qhrgkuzvMC8oiHReY
	VppHvPEDp72WOwInSxaW34SCVV4GIXXh1aV9tqpWo/jIMKDbAaIAzQAOeGCC4nPXfBH8rf4SD3h
	5XucjzhbNRs0zVcABTKLtInEDH63NXdHuScUggC/4iOI+abhA+GQTnZyvhCVq1Az71vojvC+chA
	wrnZ8nR9CBS/fwurmc1uongBBnht6pnlPEKQpglp0NXM9
X-Received: by 2002:a05:6a20:7293:b0:366:14af:9bbd with SMTP id adf61e73a8af0-366e36c94e9mr1810334637.71.1765362482854;
        Wed, 10 Dec 2025 02:28:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF58tN8OJbdGgwmMoMnSfMz4juKrteRK6lHmxh91+pB5s13IhU/ghOpMX2RQitlh1k6I6Up2g==
X-Received: by 2002:a05:6a20:7293:b0:366:14af:9bbd with SMTP id adf61e73a8af0-366e36c94e9mr1810294637.71.1765362482252;
        Wed, 10 Dec 2025 02:28:02 -0800 (PST)
Received: from [10.219.57.109] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e42d6e7a4csm18226994b3a.18.2025.12.10.02.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 02:28:01 -0800 (PST)
Message-ID: <a0a5cf96-70fe-4005-a100-58ae0b72b4cd@oss.qualcomm.com>
Date: Wed, 10 Dec 2025 15:57:56 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] of: Respect #{iommu,msi}-cells in maps
To: Rob Herring <robh@kernel.org>
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, bod@kernel.org, conor+dt@kernel.org,
        krzk+dt@kernel.org, charan.kalla@oss.qualcomm.com,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20251204095530.8627-1-vijayanand.jitta@oss.qualcomm.com>
 <20251204095530.8627-4-vijayanand.jitta@oss.qualcomm.com>
 <20251209201725.GB1015230-robh@kernel.org>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20251209201725.GB1015230-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: R5HsmNSlbCndGfkF2eEAU7oFVL__0obw
X-Authority-Analysis: v=2.4 cv=Bu2QAIX5 c=1 sm=1 tr=0 ts=69394b33 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8
 a=74PdOs92HACnK4lt8qIA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: R5HsmNSlbCndGfkF2eEAU7oFVL__0obw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDA4NSBTYWx0ZWRfX53bpyxZXPlUo
 Mr6FCSrIWbvQEB+wpl5AtQKL/9U8wf+wibUKRL5J9RWZEp2q8ncLGjI7VRFpEy73XMMFYB7lmL7
 ENKT5CX8ptNuXYQO7hLNLo7YhOOriszCtnuuY3fWuCnbWyq46v/uqwViGzfQKHnSnzFtJ/uDcAS
 VNEXArfN1wStFOOaXu4B2w1fT7gD2pXp9Su1YRr/aI7Kz4QMq7gJhM7RcoABLeDRlNTMtqVHm8A
 A628x7Xl5wBoXSD6idzOcEjmZPHjBxa5A9b160jsU+xmAela8kjyNJQoLuHFrspQAApUHYQVIGH
 +RLsUwwVEfPZn1AqcLCesEFbJMQ3xIDOl/k4RV7p22oIdFTDRdp2Dow7UR+Uo2UZPlBCQgelGcU
 dm92qfR9KmjBIOrXY4izRR43aFATyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512100085



On 12/10/2025 1:47 AM, Rob Herring wrote:
> On Thu, Dec 04, 2025 at 03:25:30PM +0530, Vijayanand Jitta wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> So far our parsing of {iommu,msi}-map properites has always blindly
>> asusmed that the output specifiers will always have exactly 1 cell.
>> This typically does happen to be the case, but is not actually enforced
>> (and the PCI msi-map binding even explicitly states support for 0 or 1
>> cells) - as a result we've now ended up with dodgy DTs out in the field
>> which depend on this behaviour to map a 1-cell specifier for a 2-cell
>> provider, despite that being bogus per the bindings themselves.
>>
>> Since there is some potential use in being able to map at least single
>> input IDs to multi-cell output specifiers (and properly support 0-cell
>> outputs as well), add support for properly parsing and using the target
>> nodes' #cells values, albeit with the unfortunate complication of still
>> having to work around expectations of the old behaviour too.
>>
>> Since there are multi-cell output specifiers, the callers of of_map_id()
>> may need to get the exact cell output value for further processing.
>> Added support for that part --charan
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
>> ---
>>  drivers/iommu/of_iommu.c |   3 +-
>>  drivers/of/base.c        | 107 ++++++++++++++++++++++++++++++---------
>>  include/linux/of.h       |  17 ++++---
>>  3 files changed, 94 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index eac62bc441c5..48759cf1d900 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -45,10 +45,11 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
>>  				     struct device *dev,
>>  				     const u32 *id)
>>  {
>> -	struct of_phandle_args iommu_spec = { .args_count = 1 };
>> +	struct of_phandle_args iommu_spec = {};
>>  	struct of_map_id_arg arg = {
>>  		.target = &iommu_spec.np,
>>  		.id_out = iommu_spec.args,
>> +		.map_cells = &iommu_spec.args_count,
>>  	};
>>  	int err;
>>  
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index b8f78a9e6a09..68a7d6ddba66 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -2045,11 +2045,30 @@ int of_find_last_cache_level(unsigned int cpu)
>>  	return cache_level;
>>  }
>>  
>> +/*
>> + * Some DTs have an iommu-map targeting a 2-cell IOMMU node while
>> + * specifying only 1 cell. Fortunately they all consist of length == 1
>> + * entries with the same target, so check for that pattern.
> 
> Can you show what a bad entry looks like here.
> 

Sure, will add an example in the comments. Basically it would look like below.

for iommu with iommu-cells  = <2>;

Device having below iommu-map property.

iommu-map = <0x0000  &smmu  0x0000  0x1>,
            <0x0100  &smmu  0x0100  0x1>;

>> + */
>> +static bool of_check_bad_map(const __be32 *map, int len)
>> +{
>> +	__be32 phandle = map[1];
>> +
>> +	if (len % 4)
>> +		return false;
>> +	for (int i = 0; i < len; i += 4) {
>> +		if (map[i + 1] != phandle || map[i + 3] != cpu_to_be32(1))
> 
> Why does the IOMMU arg cell have to be 1? The description said 'same 
> target', but it is just all have an IOMMU cell value of 1?
> 

Here, the check is for length argument to be 1. This is to maintain backward
compatibility as mentioned above, as all such bad entries right now have
length as 1.

>> +			return false;
>> +	}
>> +	return true;
>> +}
>> +
>>  /**
>>   * of_map_id - Translate an ID through a downstream mapping.
>>   * @np: root complex device node.
>>   * @id: device ID to map.
>>   * @map_name: property name of the map to use.
>> + * @cells_name: property name of target specifier cells.
>>   * @map_mask_name: optional property name of the mask to use.
>>   * @arg: contains the optional params, @target which is a pointer
>>   *	to the target device node and id_out which is a pointer
>> @@ -2065,18 +2084,19 @@ int of_find_last_cache_level(unsigned int cpu)
>>   *
>>   * Return: 0 on success or a standard error code on failure.
>>   */
>> -int of_map_id(const struct device_node *np, u32 id,
>> -	       const char *map_name, const char *map_mask_name,
>> -	       struct of_map_id_arg *arg)
>> +int of_map_id(const struct device_node *np, u32 id, const char *map_name,
>> +	      const char *cells_name, const char *map_mask_name,
>> +	      struct of_map_id_arg *arg)
>>  {
>>  	u32 map_mask, masked_id;
>> -	int map_len;
>> +	int map_bytes, map_len, offset = 0;
>> +	bool bad_map = false;
>>  	const __be32 *map = NULL;
>>  
>>  	if (!np || !map_name || !arg || (!arg->target && !arg->id_out))
>>  		return -EINVAL;
>>  
>> -	map = of_get_property(np, map_name, &map_len);
>> +	map = of_get_property(np, map_name, &map_bytes);
>>  	if (!map) {
>>  		if (arg->target)
>>  			return -ENODEV;
>> @@ -2085,11 +2105,9 @@ int of_map_id(const struct device_node *np, u32 id,
>>  		return 0;
>>  	}
>>  
>> -	if (!map_len || map_len % (4 * sizeof(*map))) {
>> -		pr_err("%pOF: Error: Bad %s length: %d\n", np,
>> -			map_name, map_len);
>> -		return -EINVAL;
>> -	}
>> +	if (map_bytes % sizeof(*map))
>> +		goto err_map_len;
>> +	map_len = map_bytes / sizeof(*map);
>>  
>>  	/* The default is to select all bits. */
>>  	map_mask = 0xffffffff;
>> @@ -2102,27 +2120,62 @@ int of_map_id(const struct device_node *np, u32 id,
>>  		of_property_read_u32(np, map_mask_name, &map_mask);
>>  
>>  	masked_id = map_mask & id;
>> -	for ( ; map_len > 0; map_len -= 4 * sizeof(*map), map += 4) {
>> +	while (offset < map_len) {
>>  		struct device_node *phandle_node;
>> -		u32 id_base = be32_to_cpup(map + 0);
>> -		u32 phandle = be32_to_cpup(map + 1);
>> -		u32 out_base = be32_to_cpup(map + 2);
>> -		u32 id_len = be32_to_cpup(map + 3);
>> +		u32 id_base, phandle, cells, id_len, id_off;
>> +		const __be32 *out_base;
>> +
>> +		if (map_len - offset < 2)
>> +			goto err_map_len;
>>  
>> +		id_base = be32_to_cpup(map + offset);
>>  		if (id_base & ~map_mask) {
>> -			pr_err("%pOF: Invalid %s translation - %s-mask (0x%x) ignores id-base (0x%x)\n",
>> -				np, map_name, map_name,
>> +			pr_err("%pOF: Invalid %s translation - %s (0x%x) ignores id-base (0x%x)\n",
>> +				np, map_name, map_mask_name,
>>  				map_mask, id_base);
>>  			return -EFAULT;
>>  		}
>>  
>> -		if (masked_id < id_base || masked_id >= id_base + id_len)
>> -			continue;
>> -
>> +		phandle = be32_to_cpup(map + offset + 1);
>>  		phandle_node = of_find_node_by_phandle(phandle);
>>  		if (!phandle_node)
>>  			return -ENODEV;
>>  
>> +		if (!bad_map && of_property_read_u32(phandle_node, cells_name, &cells)) {
>> +			pr_err("%pOF: missing %s property\n", phandle_node, cells_name);
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (map_len - offset < 3 + cells)
>> +			goto err_map_len;
>> +
>> +		if (offset == 0 && cells == 2) {
>> +			bad_map = of_check_bad_map(map, map_len);
>> +			if (bad_map) {
>> +				pr_warn_once("%pOF: %s mismatches target %s, assuming extra cell of 0\n",
>> +				np, map_name, cells_name);
>> +				cells = 1;
>> +			}
>> +		}
>> +
>> +		out_base = map + offset + 2;
>> +		offset += 3 + cells;
>> +
>> +		id_len = be32_to_cpup(map + offset - 1);
>> +		if (id_len > 1 && cells > 1) {
>> +			/*
>> +			 * With 1 output cell we reasonably assume its value
>> +			 * has a linear relationship to the input; with more,
>> +			 * we'd need help from the provider to know what to do.
>> +			 */
>> +			pr_err("%pOF: Unsupported %s - cannot handle %d-ID range with %d-cell output specifier\n",
>> +				np, map_name, id_len, cells);
>> +			return -EINVAL;
>> +		}
>> +		id_off = masked_id - id_base;
>> +		if (masked_id < id_base || id_off >= id_len)
>> +			continue;
>> +
>>  		if (arg->target) {
>>  			if (*arg->target)
>>  				of_node_put(phandle_node);
>> @@ -2133,12 +2186,14 @@ int of_map_id(const struct device_node *np, u32 id,
>>  				continue;
>>  		}
>>  
>> -		if (arg->id_out)
>> -			*arg->id_out = masked_id - id_base + out_base;
>> +		for (int i = 0; arg->id_out && i < cells; i++)
>> +			arg->id_out[i] = id_off + be32_to_cpu(out_base[i]);
>>  
>> +		if (arg->map_cells)
>> +			*arg->map_cells = cells;
>>  		pr_debug("%pOF: %s, using mask %08x, id-base: %08x, out-base: %08x, length: %08x, id: %08x -> %08x\n",
>> -			np, map_name, map_mask, id_base, out_base,
>> -			id_len, id, masked_id - id_base + out_base);
>> +			np, map_name, map_mask, id_base, be32_to_cpup(out_base),
>> +			id_len, id, id_off + be32_to_cpup(out_base));
>>  		return 0;
>>  	}
>>  
>> @@ -2149,5 +2204,9 @@ int of_map_id(const struct device_node *np, u32 id,
>>  	if (arg->id_out)
>>  		*arg->id_out = id;
>>  	return 0;
>> +
>> +err_map_len:
>> +	pr_err("%pOF: Error: Bad %s length: %d\n", np, map_name, map_bytes);
>> +	return -EINVAL;
>>  }
>>  EXPORT_SYMBOL_GPL(of_map_id);
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index 21bdce2b37ca..1981509c7918 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -29,6 +29,7 @@ struct device_node;
>>  struct of_map_id_arg {
>>  	struct device_node **target;
>>  	u32 *id_out;
>> +	u32 *map_cells;
>>  };
>>  
>>  struct property {
>> @@ -462,9 +463,9 @@ const char *of_prop_next_string(const struct property *prop, const char *cur);
>>  
>>  bool of_console_check(const struct device_node *dn, char *name, int index);
>>  
>> -int of_map_id(const struct device_node *np, u32 id,
>> -	       const char *map_name, const char *map_mask_name,
>> -	       struct of_map_id_arg *arg);
>> +int of_map_id(const struct device_node *np, u32 id, const char *map_name,
>> +	      const char *cells_name, const char *map_mask_name,
>> +	      struct of_map_id_arg *arg);
>>  
>>  phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
>>  
>> @@ -911,9 +912,9 @@ static inline void of_property_clear_flag(struct property *p, unsigned long flag
>>  {
>>  }
>>  
>> -static inline int of_map_id(const struct device_node *np, u32 id,
>> -			     const char *map_name, const char *map_mask_name,
>> -			     struct of_map_id_arg *arg)
>> +static inline int of_map_id(const struct device_node *np, u32 id, const char *map_name,
>> +			    const char *cells_name, const char *map_mask_name,
>> +			    struct of_map_id_arg *arg);
>>  {
>>  	return -EINVAL;
>>  }
>> @@ -1444,7 +1445,7 @@ static inline int of_property_read_s32(const struct device_node *np,
>>  static inline int of_map_iommu_id(const struct device_node *np, u32 id,
>>  				  struct of_map_id_arg *arg)
>>  {
>> -	return of_map_id(np, id, "iommu-map", "iommu-map-mask", arg);
>> +	return of_map_id(np, id, "iommu-map", "#iommu-cells", "iommu-map-mask", arg);
>>  }
>>  
>>  static inline int of_map_msi_id(const struct device_node *np, u32 id,
>> @@ -1455,7 +1456,7 @@ static inline int of_map_msi_id(const struct device_node *np, u32 id,
>>  		.id_out = id_out,
>>  	};
>>  
>> -	return of_map_id(np, id, "msi-map", "msi-map-mask", &arg);
>> +	return of_map_id(np, id, "msi-map", "#msi-cells", "msi-map-mask", &arg);
> 
> There are cases of no #msi-cells and we default to 0 cells in that case. 
> Do you maintain that?
> 
> Rob

Thanks for pointing this, I see this case of no #msi-cells is not covered. Will
add it in next revision.  Also, IIUC shouldn't we set default cells to '1' to
maintain backward compatibility of of_map_id in this case ? No ?

Thanks,
Vijay
