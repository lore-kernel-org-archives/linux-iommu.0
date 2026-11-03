Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709045;
	b=FzDk1mcHKMxT5z8Qw7Kdacl2w6pQC+ph/ikxDiSvQNeNIx5lyTCMLv0QvsXxBzlfz/jq
	 5PM+DXQDUNJq0+lYYjQQcPxMxqxnEVv/UrNeUpXetV6bJelK4dGFeSQDeZ18HvkvphMY9
	 WYGe7FoTn5bhqYOg5nGD3F1+00/+Nk0jU8j7CYtjCjtG7Eu5RtpJuURHDUxTEYMfQYDsB
	 /ju8ZiwfEk+kIpaGVYSaHqn8g2aJnyf1DNBdWRQd1QGsEZbQmtOiPVcZ3ySIz7AhnUMlo
	 4ozqd+6Y+RJiSoBJZXEtFEN/Z2oEluuTtPEIasSrUGY8nIGJCqTygb901pLWaih02bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709045;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3stn33i+P1qmHkcgrQZUldUGXQHr3+ePFZUQhGyd6NQ=;
	b=G6A2YQDGGJXhEtNPhwJbeiZfzOTsMI3RjJ8B62y+l33ZP4ZbboPYBsZMugPj5g/ur0T0
	 OHxiwI3A1gKKX6BhvolBzTnC/a5v0u3TFxO6Jkyb6lO5iXbdfjR43sCpiDS0xErz4SVud
	 ys9TwLKin+nyFeh0aRIZWa0/jSHa3/sKlAF8kmXmRFX/dlfmeYXLQKtRlo2Y9/Wrpt3+X
	 zztzNC3IjnoZoYfy1A2+uI8C0L+00bk/pi89bkukruagYUVetiMzWZtFh/1BEdyGICzsp
	 g0QdMfPi+yp2zjaSgnhp8YQRAVO4GyzOFaiGqvoeG0PpqnxpyCyj5L+dkOlE4OuCB1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=R8qTMSG9;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=CSxAyefu;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4946060850A6
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 12:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4946060850A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=R8qTMSG9;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=CSxAyefu
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A39Q7Ju377391
	for <iommu@lists.linux.dev>; Tue, 3 Nov 2026 07:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=3stn
	33i+P1qmHkcgrQZUldUGXQHr3+ePFZUQhGyd6NQ=; b=R8qTMSG9Jo1m2QojutdH
	XJLRV96rFWy9GW5tG5iuvsd4hHGxLpqwvTm38k5XW8dzy2KJLDLZzrskcSdKrGOD
	6cZwuq9BwLCi4nXpMr3ZYo+1o/6pci/2O5hiPSY121RNPzbzLItNsg0OHhYhXXTn
	NegkvRPI88GReBdqBp1YprLGsiYTEfWoKmAFWZAUa5HLLO+rpm6zCmhV3w34fE5g
	ykaw62RgQd7NCCYP/+Z4uvP9G8PDWrv+AYo4mY8xtSWR4+vAzbYZckrC/kOVLapR
	8eumUah4tBH/z5sUZulu8gxpK6f9vm3RyhJbhLBiNe1xGHbWdcurfKN5emr6Cqff
	gA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hq1ufm571-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 03 Nov 2026 07:30:43 -0500 (EST)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7cc0418036bso567616137.3
        for <iommu@lists.linux.dev>; Tue, 03 Nov 2026 04:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793709043; x=1794313843; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3stn33i+P1qmHkcgrQZUldUGXQHr3+ePFZUQhGyd6NQ=;
        b=CSxAyefuaWRMyEXOP+e+REqTh78Leo4K3qteOy7p5U3tcudnEVRZLf57IogM4w2IsE
         rDB55n3sU6c5guj8YmuWgg9eMErpZ/FWo48kgG6ykz9scZhGGaSnr7+wEeh7rXOXeZJw
         Vyt46PF/qJXYhtDtEclbESFNb/Pr52T0LEXBExzwk2I8rreyTsgKlaySJ7HRfy/jt3zq
         F1AV/145kqi7V6Gx6ZO+e2w4IpqmJAvFpA9EuE6xT8xHAbnhokIKy/QHXBcQUisN3HP0
         GrMWorw6g01WeWjQTBi1KW1ljpFJ2NRASN5Z+YwAH86Vkry8HWE7gOviPYQrmi93BNEa
         0HNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793709043; x=1794313843;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3stn33i+P1qmHkcgrQZUldUGXQHr3+ePFZUQhGyd6NQ=;
        b=gICEZgLRHk49rvikI84J8l4mFfgDEzj8AxF6NGbrFQw8+B71Z3JBxVMMnVNlA5KDy0
         lMNj+fSCBRWs04HFnAL3up4qq1iWURk0G6XLayWkIbvWeNFazigpwnqedB+KMEqbv0/O
         xzQcILVgB7jDdXsx/x0pYHiThKBDfnqWI/E3QjpLVRj9Oy8VdjNskHUArSoWNSeaB9VK
         5Ge8LE/irvJXVaBqZep8tl1v34EVIissTYAXmDbVexfSYkfUfCOTwy+9KoYOa/FJaxAt
         W8t4zsx2fQJud6luVjyg+8Dsc8LUPhLHVo7NMG3Shv3SeHponnhdmaE/CpzKLyoZi8YG
         118Q==
X-Gm-Message-State: APuU4Z9jDVOtbXc7XV7ixi05lG07opPCNbbzC0orjPYpXUOYjUwmbo1b
	o8GEplsGifXB3+GJVepEL6/SRK7klr0gVvfnjlQ7MjYPs+LJ1B+my+XRfjucSwngLmUzSvHqUrX
	x/0w6FG7fuIiS9fvfFi4n5KNeDRGI+G+o3XrR+6RWoydjbzUiPI2Z
X-Gm-Gg: AYBFou0T70KOJXUgmtX/O2AYiwg7i++C+3qa6Gf1bSIY1ci5NGl9VTkFfdem9o029CK
	FGckqyPtBdt5xa9iSAce3hQaZdQkIqadCStjVlWucXCky9HaiAoNU2YT6MRug5rxTHDh9hm3Zlx
	i9s523IB4VVk+oOazOHuSiOcDt2bbdc4PsSMq+zjZES/Dnmc+DRCw1qYkSba4X4vENvalSle92H
	hKF/C7XHYSkdikdifEVHqGnFrE6OhX7fwVvavBTX9gCrHIELm8zeGf6188hBPmeNhtn4ITnQMV9
	FDeWf4H/dUoZgJUVOfF7uPDzj700tsocQKs0pjmF2C/AmdMkNLW9HeL3EwWshvimuCPzfOmGzwl
	O7oiRaxpoMbFnAjfTQdM/3FEetPEaeIUctZBbGjUMGaTbCUek/HYrxv60dGEMpLz1sbtuyrpMTO
	B58sX4l23NVQxKlbg8lt6mqA7/bI2m4UjfyM0=
X-Received: by 2002:a67:e70a:0:b0:7c4:a0e4:1a79 with SMTP id ada2fe7eead31-7d0726cfedfmr4269705137.19.1793709043269;
        Tue, 03 Nov 2026 04:30:43 -0800 (PST)
X-Received: by 2002:a67:e70a:0:b0:7c4:a0e4:1a79 with SMTP id ada2fe7eead31-7d0726cfedfmr4269647137.19.1793709038045;
        Tue, 03 Nov 2026 04:30:38 -0800 (PST)
Received: from ?IPV6:2a00:a040:199:85d9:1574:610d:e406:d9d4? ([2a00:a040:199:85d9:1574:610d:e406:d9d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80333sm26747161f8f.32.2026.11.03.04.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 04:30:36 -0800 (PST)
Message-ID: <7651371f-c3a2-4f35-b817-6ffb32d6587a@columbia.edu>
Date: Tue, 3 Nov 2026 14:30:34 +0200
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
Subject: Re: [PATCH 1/2] iommu: free dev->iommu when iommu_fwspec_init()
 cannot allocate the fwspec
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jpb@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261031-iommufd-folio-dirty-v1-0-2cef66d2d6d1@columbia.edu>
 <20261031-iommufd-folio-dirty-v1-1-2cef66d2d6d1@columbia.edu>
 <7e209fb2-4bda-4207-9109-c67c8df41e05@arm.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <7e209fb2-4bda-4207-9109-c67c8df41e05@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0OSBTYWx0ZWRfX8lcogI0QZZJk
 WqOl2/A3LWb5D4HNCs9nWso7V6YDYapwJm3vFkOk00VN8nnt5Vig/aenXYkzt+L89NWiXk85C1n
 SHZjC3DNW9IWHN5rR88be8znraZXFCmmvr+3f+U/886+hUqcjgW2M04rQ7HPUAISsAXngMfOc9P
 kKu0/lCEviqGTPLp6ZWtM0xr+t+NUp+QQy9PiKnyn+z1gg9PfipYVWNMzVTxI9E/jWSOD0keKMt
 9OVQIC3z4mPYJJv4EicKel7Erf3a/4RcRsXHux3Lon0AES/ABalgmetiSPAvFel6mQc9jaGwLuT
 3XFxraOAXGMZ5Cp3mhmh0mNeWPU8WTv9iukcldBRFCJxZ0ySVjmEuZYiW3lZTxvvR6f4cMbIgDa
 HUGu6shs1Vhy61Ma7OtlvgJCKUgSTrdmQvze4nMjQ/DDyJLf3AR/Hx8T1SXNeEPHxQntRq7O5Cr
 6/GSz+momCncVqSQMng==
X-Proofpoint-ORIG-GUID: waVIk0twZtYdHlAst-6rpyA_382_zvHL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0OSBTYWx0ZWRfXzLJx8LCMNVuq
 UAPoeyDlFgEFa1Vwu+XnGREYRw9IEDnvAX8678AUGF1LI+XH7qzUxDHFBm6930+tQXmf3GEzLN1
 PwPO4aoZwpu6tEX75UWtKUwscYyg7Bd8y8RUni6HJXWNZY3PLgmi
X-Proofpoint-GUID: waVIk0twZtYdHlAst-6rpyA_382_zvHL
X-Authority-Analysis: v=2.4 cv=SKfXx+vH c=1 sm=1 tr=0 ts=6ae9d3f3 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=PdLWhGWvWCS_fz1MqksA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11954
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=10 spamscore=0
 phishscore=0 suspectscore=0 bulkscore=10 lowpriorityscore=10 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030049

On 11/2/26 11:51 AM, Robin Murphy wrote:
> On 31/10/2026 8:33 pm, Tal Zussman wrote:
>> iommu_fwspec_init() allocates dev->iommu with dev_iommu_get() and then
>> the fwspec. If the fwspec allocation fails it returns -ENOMEM but leaves
>> dev->iommu allocated, and it leaks.
>> 
>> kmemleak reports it when iommufd_fail_nth injects the allocation
>> failure:
>> 
>>    unreferenced object 0xffff88811c138b00 (size 192):
>>      comm "iommufd_fail_nt", pid 783
>>      backtrace:
>>        __kmalloc_cache_noprof
>>        dev_iommu_get
>>        iommu_fwspec_init
>>        iommu_mock_device_add
>>        iommufd_test
>>        iommufd_fops_ioctl
>> 
>> Free dev->iommu on failure if this call allocated it. iommu_init_device()
>> allocates it before calling into the driver and frees it on its own
>> error path, so leave it alone in that case.
>> 
>> Fixes: 72acd9df18f1 ("iommu: Move iommu_fwspec to struct dev_iommu")
> 
> No, the bug is clearly the early return in 2a918911ed3d ("iommufd:
> Register iommufd mock devices with fwspec"), so fix it there please.
> iommu_fwspec_init() has always been designed to be called in conjunction
> with iommu_probe_device() which handles cleanup appropriately. All of
> this mock_device hackery not using the proper probe paths is enough of a
> pain as it is...
> 
> Thanks,
> Robin.
> 

Thanks for the review!
I'll change this for v2.

- Tal

>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> ---
>>   drivers/iommu/iommu.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index cd1bca7ede9a..69be8819e05d 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -3074,6 +3074,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
>>   {
>>   	const struct iommu_device *iommu = iommu_from_fwnode(iommu_fwnode);
>>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>> +	bool new_iommu = !dev->iommu;
>>   
>>   	if (!iommu)
>>   		return driver_deferred_probe_check_state(dev);
>> @@ -3088,8 +3089,11 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
>>   
>>   	/* Preallocate for the overwhelmingly common case of 1 ID */
>>   	fwspec = kzalloc_flex(*fwspec, ids, 1);
>> -	if (!fwspec)
>> +	if (!fwspec) {
>> +		if (new_iommu)
>> +			dev_iommu_free(dev);
>>   		return -ENOMEM;
>> +	}
>>   
>>   	fwnode_handle_get(iommu_fwnode);
>>   	fwspec->iommu_fwnode = iommu_fwnode;
>> 
> 

