Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB04620E023;
	Fri, 10 Jan 2025 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736515804; cv=none; b=NFdF0NEz4Y3jz8J9zoi5Ik8RyYIZxfD0fAviX+QqYTpd6TYk+B2gYD6UykgKR2DI88O/bzBw7yjB4A0h4AOw/lwjsIuyJtPejBaPf00qhwEuCn35Sd55lFitOHVuxP5qIC0/IE6jpIx0f4mD2NOMpzYtFQshYlFLhJIKddyFkEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736515804; c=relaxed/simple;
	bh=5C4ZtgRDxqr9qSuURkK6QNcOIRV536fVjqYDChheTFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PVv2Z0caFcjEOxr5Dyxtaq37Z+OkHCKjMRcaXhufpR0Q/lpdxx6yI6ZULapuY8JYN1Mjfybw2nUEPAopGPbNtwljOz1IP4hMTwf8HmTnQWucGFt2yTTtfM1No6gQE+zsuUQDGkPu1oYgGBwThfuCSyZhxO6Fqkv5kms5yfOoIGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HOIt6ESE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HOIt6ESE"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A9sAsu027967;
	Fri, 10 Jan 2025 13:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2Z9LJ3RXC8Zn5fQ8mt7kySq1gfbl4M8FWYlANQPAOQ8=; b=HOIt6ESEgK+n3fXg
	MmUIL//u6JIqZtcuuem9fTfuAgItj4TOAnRPvfp09YdusM9rqppfiJWyosYgv71q
	GcOsuraZex6OmkMMNYorHnI5EFuxclHaZfhQAnuVXjaJsBsa7QK4SLmuKiylxVNt
	pBwyCIsXo3+CFoWmFoK2JDgXr1TSOd2hWolkGF6xAR/8twV57TIqdycDtiF1S9Ft
	4QZ60QxzNpvVdTzGo228CMV2eA633OKTYVOsaZSoWtV9lSDgT6aP1+NiCNWTE4D5
	ccgrMH6QrKN5hEkcuMWFrkRRWl8L9+DEOEmnSMToYE4Onndd3MdJpH3U8xQjk7Bg
	GoICCw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4431as0j5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 13:29:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50ADTrd6026891
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 13:29:53 GMT
Received: from [10.216.20.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 Jan
 2025 05:29:51 -0800
Message-ID: <acc57f57-6eb5-4d55-bc36-33624051eec9@quicinc.com>
Date: Fri, 10 Jan 2025 18:59:48 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] iommu: fix wrong DMA ops for iommu device
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
CC: <joro@8bytes.org>, <jgg@ziepe.ca>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20241213150415.653821-1-quic_charante@quicinc.com>
 <91d15d11-ec53-4ca2-a385-9fa69d861f2c@quicinc.com>
 <20250103153434.GC3816@willie-the-truck>
 <e8fa02bb-96b7-4010-92c9-7e1eb485a551@quicinc.com>
 <20250107113126.GA6932@willie-the-truck>
 <cb2db54e-37e8-495d-916a-4e63c67019bb@arm.com>
Content-Language: en-US
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <cb2db54e-37e8-495d-916a-4e63c67019bb@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qDCwT6KVc9LX_hEYn9riQ69pEmhYAjry
X-Proofpoint-ORIG-GUID: qDCwT6KVc9LX_hEYn9riQ69pEmhYAjry
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100106

Thanks Will and Robin for the response!!

On 1/8/2025 6:07 PM, Robin Murphy wrote:
> On 07/01/2025 11:31 am, Will Deacon wrote:
>> On Mon, Jan 06, 2025 at 06:46:08PM +0530, Charan Teja Kalla wrote:
>>> On 1/3/2025 9:04 PM, Will Deacon wrote:
>>>> On Thu, Jan 02, 2025 at 04:09:46PM +0530, Charan Teja Kalla wrote:
>>>>> On 12/13/2024 8:34 PM, Charan Teja Kalla wrote:
>>>>>> Race between smmu device probe and iommu device probe is resulting
>>>>>> into
>>>>>> wrong DMA ops used for the device.
>>>>>>
>>>>>> bus_iommu_probe(P1)                  of_iommu_configure(P2)
>>>>>> (from iommu_device_register)        (from insmod of a driver)
>>>>>> --------------------------         --------------------------
>>>>>> 1) probe_iommu_group()
>>>>>> (Fills just dev->iommu_group
>>>>>> under iommu_probe_device_lock)
>>>>>>                 2) iommu_probe_device():
>>>>>>                   (acquires the iommu_probe_device_lock,
>>>>>>                    but since dev->iommu_group is already
>>>>>>                    set, it just returns without
>>>>>>                    allocating the domain.)
>>>>>>
>>>>>>                 3) of_dma_configure_id()->
>>>>>>                    arch_setup_dma_ops() gets called for
>>>>>>                    this device, but returns with the
>>>>>>                    error message:
>>>>>>                    "Failed to set up IOMMU for device;
>>>>>>                     retaining platform DMA ops"
>>>>>>
>>>>>>                 4) device probe is succeeded where it
>>>>>>                    can now setup iommu mappings using
>>>>>>                    wrong ->dma_ops
>>>>>>
>>>>>> 5) domain will be allocated later
>>>>>> and fills iommu_group->domain.
>>>>>>
>>>>>> Step 3) and 4) denies iommu device from using 'iommu_dma_ops'.
>>>>>>
>>>>>> This issue does exists on 6.6 because of commit f188056352bc ("iommu:
>>>>>> Avoid locking/unlocking for iommu_probe_device()") without which 2)
>>>>>> returns only after filling the domain under group->mutex, thus no
>>>>>> issue.
>>>>>>
>>>>>> With commit b5c58b2fdc42("dma-mapping: direct calls for dma-iommu"),
>>>>>> ->iommu_dma_ops is removed altogether and iommu api are directly
>>>>>> being
>>>>>> called under "use_dma_iommu(): return dev->dma_iommu". Again,
>>>>>> ->dma_iommu flag is set only after domain allocation. So, If
>>>>>> there is a sufficient delay between steps 4) and 5), issue is still
>>>>>> exists but that seems very narrow to me.
>>>>>>
>>>>>> I am thinking, setup of the domain before returning from step2) is
>>>>>> the
>>>>>> way to fix this issue. Can you please help if you have any
>>>>>> suggestions?
>>>>>>
>>>>>> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
>>>>>> ---
>>>>>>   drivers/iommu/iommu.c | 26 +++++++++++++++++++++++++-
>>>>>>   1 file changed, 25 insertions(+), 1 deletion(-)
>>>>>
>>>>> Just a quick ask if you have any comments for the below. BTW, in
>>>>> internal tests, when we revert the commit f188056352bc ("iommu: Avoid
>>>>> locking/unlocking for iommu_probe_device()", it is helping.
>>>>>
>>>>> I can share more details If the below is not sufficient.
>>>>>
>>>>> Thanks in advance...
>>>>
>>>> Can you reproduce the issue on 6.13-rc5? We bodged some of the probe
>>>> code recently:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
>>>> commit/?id=229e6ee43d2a160a1592b83aad620d6027084aad
>>>>
>>>> and a better set of fixes are queued in -next.
>>>
>>> Yes, we did try a better patch from Robin[1] and the issue is still
>>> reproducible.
>>
>> Did you try the -EPROBE_DEFER hack that got merged?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
>> commit/?id=229e6ee43d2a160a1592b83aad620d6027084aad
>>
@Will,

We just tested and the issue is still reported with just the mentioned
hack that got merged.

May be I will try to convince again with more details about why this is
a race and why the -EPROBE_DEFER hack you mentioned will not help.

S: SMMU device probe in bus_iommu_probe().
C: SMMU client device probe in of_iommu_configure().

1) S: In probe_iommu_group():
	Fills the client device ->iommu_group under  iommu_probe_device_lock.
But iommu_group->domain is not yet allocated because it is a 2 step
process from probe_iommu_group.

2) C: iommu_probe_device() --> __iommu_probe_device():
	Acquires the iommu_probe_device_lock, and since dev->iommu_group is
already set, it just returns without allocating the domain.

	static int __iommu_probe_device(struct device *dev, ...)
	{
		/* Device is probed already if in a group */
        if (dev->iommu_group)
                return 0;  --> __driver call returns from here.__

        ret = iommu_init_device(dev, ops);
        if (ret)
                return ret;
	}
The change you mentioned will come into play iff it enters
iommu_init_device(), where it returns -EPROBE_DEFER till smmu driver
bound happens. __Here we didn't even enter into this function__.

3) C: Continues probing and calls
of_dma_configure_id()->arch_setup_dma_ops()->iommu_setup_dma_ops().
Since ->domain is not yet allocated, it just returns without setting
'iommu_dma_ops' and with a warn message of 'Failed to set up IOMMU for
device' for this client device. And also the client probe is
successfully completed.
	void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit) {
	if (!domain)
		goto out_err;
			
	if (iommu_is_dma_domain(domain)) {
		.....
	dev->dma_ops = &iommu_dma_ops;<-- This step will not be executed.
	}
			
out_err:
         pr_warn("Failed to set up IOMMU for device %s; retaining
platform DMA ops\n",
                 dev_name(dev));			
	}

4) S: domain will be allocated later in the second step and fills
iommu_group->domain.


Since, the SMMU client device probe is already successfully completed
with invalid dma_ops and when client uses the dma api can lead to issues.

>> Otherwise, you can try the stack queued for 6.14 in iommu/linux.git:
>>
>> 46b3df8eb9bd iommu: Manage driver probe deferral better
>> fcbd62156742 iommu/arm-smmu-v3: Clean up more on probe failure
>> 97cb1fa02726 iommu/arm-smmu: Retire probe deferral workaround
>> 7d835134d4e1 iommu/arm-smmu: Make instance lookup robust
>>
>>> IIUC, these patches are trying to get valid smmu device, during the
>>> probe of an smmu client device, by traversing proper 'klist_devices'
>>> happening from iommu_init_device(). Please CMIW.
>>
>> Well, they're fixing a race between the IOMMU probing and its client
>> devices attaching.
>>
>>> But this bug makes iommu_init_device() to completely gets skipped.
>>>
>>> static int __iommu_probe_device(struct device *dev, ...)
>>> {
>>>     /* Device is probed already if in a group */
>>>          if (dev->iommu_group)
>>>                  return 0;  --> driver call returns from here.
>>>
>>>          ret = iommu_init_device(dev, ops);
>>>          if (ret)
>>>                  return ret;
>>>
>>>
>>> }
>>>
>>> Regarding the testing, we work on Android that is on LTS kernels, so, it
>>> may not be possible for us to try the thing on 6.13 and this seems a bug
>>> on LTS 6.6 kernel.
>>
>> We need to fix 6.13 before we fix 6.6 unless you can show that 6.13 is
>> unaffected (in which case, we can backport the fix(es)).
> 
> Certainly the reasoning can't apply to mainline as given, since
> arch_setup_dma_ops() stopped touching IOMMU stuff at all back in 6.10
> (and indeed iommu_dma_ops itself no longer exists since 6.12).
> 

@Robin

Agree that we don't have iommu_dma_ops but I can say that same race
still exists. Although dma_ops is not used, but the decision to call
into the iommu api's is determined by the 'dev->dma_iommu' flag, which
again, is set after domain is allocated for a device.

In the same race mentioned above,
1) S: Domain is not allocated but the dev->iommu_group.
2) C: Just returns as dev->iommu_group is filled.
3) C: Continues probing and succeeds.
4) C: Calls dma_alloc/map/.... But, it won't enter into iommu_ api's
because the 'dev->dma_iommu' is still 'false'.
5) S: Domain is allocated and sets the 'dev->dma_iommu' to 'true'.

4) above is the problematic step. Although issue exists but seems to me
that very narrow to get triggered. Please CMIW.

> Robin.

Thanks.

