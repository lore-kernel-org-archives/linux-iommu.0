Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0AA1D5CE5;
	Mon,  6 Jan 2025 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169397; cv=none; b=lEjelbyoPVZq7PsHjWXAOorB7VeIsSvhgdwqR4Xw8l0/5LLFzWZcsmwLX3eWQ56iIStNNMQY/ij+j/HmJIv+sjbbyxvm7ayOFM6LebvOFD3XAcoAkEINfEkkANBzdQVJt6XhgzSr8mUrd9r0w52NCIvMCYLMgs63r9CwM0b19TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169397; c=relaxed/simple;
	bh=npx7aCXP/tspYW9iylyFl3RNgV54jVSGgG5Q17oWJQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G55KC3wNJUYe0DClUmu9QQbBaek9vRgG/U3al9WvZhOp4JukMabDgBHrRdmJD8PcvWKhW4ZpkxKdPMOJ7uJGBC27fEWk+QV++fpM4tzjxxuwyl6l2Uk+5HOBK9uM7lmo/7owl8eLF4DrhFUkec9jhmQPi/P1F5vqol5ibe85sag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QfajyE7r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QfajyE7r"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5063Xb0h016390;
	Mon, 6 Jan 2025 13:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q9zk11ew5+GOYnID16Y3ypoe0TwgLOgUuAa7vZfLpus=; b=QfajyE7rMzRSNuvN
	PUsjwPCKgqcmFKKfvYwNj2XnZYdi6W9mpbu6pBXKksf6LRnnsb6KmL/zIEpTdwLz
	GbDThOAw1ff4DVhYbgYEoOIpFenwtZNSR9RGjoUW1WUx9C0XfCD6PGvF6E9tIoZy
	V3hWMHINXv1hA/G+whAHUARjpcr7YOqqWPKWLMrbaYLtaMvs2CGdCqKe6MWgALFW
	Nt42oYUOB4sielibiO4PSkOrWlqprYTjRpPB8wL+W6FsOlyR8gK9dw5egI07FcL2
	90XMLcNhgkS6INjnC8lzG2uN+pqtXaDwfjmVhheRvjawgUYxmrooX339UmD+TCPM
	qiCFiQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4407ck14v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 13:16:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 506DGDqA024260
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 6 Jan 2025 13:16:13 GMT
Received: from [10.218.24.190] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 6 Jan 2025
 05:16:11 -0800
Message-ID: <e8fa02bb-96b7-4010-92c9-7e1eb485a551@quicinc.com>
Date: Mon, 6 Jan 2025 18:46:08 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] iommu: fix wrong DMA ops for iommu device
To: Will Deacon <will@kernel.org>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <jgg@ziepe.ca>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20241213150415.653821-1-quic_charante@quicinc.com>
 <91d15d11-ec53-4ca2-a385-9fa69d861f2c@quicinc.com>
 <20250103153434.GC3816@willie-the-truck>
Content-Language: en-US
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <20250103153434.GC3816@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3Ae0ZQLUNeGXQ-87exUPsZ0zbU2rFC9j
X-Proofpoint-ORIG-GUID: 3Ae0ZQLUNeGXQ-87exUPsZ0zbU2rFC9j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501060118

Thanks Will for the response!!

On 1/3/2025 9:04 PM, Will Deacon wrote:
> (Please try not to top-post as it makes the thread hard to follow)
> 
> On Thu, Jan 02, 2025 at 04:09:46PM +0530, Charan Teja Kalla wrote:
>> On 12/13/2024 8:34 PM, Charan Teja Kalla wrote:
>>> Race between smmu device probe and iommu device probe is resulting into
>>> wrong DMA ops used for the device.
>>>
>>> bus_iommu_probe(P1)                  of_iommu_configure(P2)
>>> (from iommu_device_register)        (from insmod of a driver)
>>> --------------------------         --------------------------
>>> 1) probe_iommu_group()
>>> (Fills just dev->iommu_group
>>> under iommu_probe_device_lock)
>>> 				2) iommu_probe_device():
>>> 				  (acquires the iommu_probe_device_lock,
>>> 				   but since dev->iommu_group is already
>>> 				   set, it just returns without
>>> 				   allocating the domain.)
>>>
>>> 				3) of_dma_configure_id()->
>>> 				   arch_setup_dma_ops() gets called for
>>> 				   this device, but returns with the
>>> 				   error message:
>>> 				   "Failed to set up IOMMU for device;
>>> 				    retaining platform DMA ops"
>>>
>>> 				4) device probe is succeeded where it
>>> 				   can now setup iommu mappings using
>>> 				   wrong ->dma_ops
>>>
>>> 5) domain will be allocated later
>>> and fills iommu_group->domain.
>>>
>>> Step 3) and 4) denies iommu device from using 'iommu_dma_ops'.
>>>
>>> This issue does exists on 6.6 because of commit f188056352bc ("iommu:
>>> Avoid locking/unlocking for iommu_probe_device()") without which 2)
>>> returns only after filling the domain under group->mutex, thus no issue.
>>>
>>> With commit b5c58b2fdc42("dma-mapping: direct calls for dma-iommu"),
>>> ->iommu_dma_ops is removed altogether and iommu api are directly being
>>> called under "use_dma_iommu(): return dev->dma_iommu". Again,
>>> ->dma_iommu flag is set only after domain allocation. So, If
>>> there is a sufficient delay between steps 4) and 5), issue is still
>>> exists but that seems very narrow to me.
>>>
>>> I am thinking, setup of the domain before returning from step2) is the
>>> way to fix this issue. Can you please help if you have any suggestions?
>>>
>>> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
>>> ---
>>>  drivers/iommu/iommu.c | 26 +++++++++++++++++++++++++-
>>>  1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> Just a quick ask if you have any comments for the below. BTW, in
>> internal tests, when we revert the commit f188056352bc ("iommu: Avoid
>> locking/unlocking for iommu_probe_device()", it is helping.
>>
>> I can share more details If the below is not sufficient.
>>
>> Thanks in advance...
> 
> Can you reproduce the issue on 6.13-rc5? We bodged some of the probe
> code recently:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=229e6ee43d2a160a1592b83aad620d6027084aad
> 
> and a better set of fixes are queued in -next.

Yes, we did try a better patch from Robin[1] and the issue is still
reproducible.

IIUC, these patches are trying to get valid smmu device, during the
probe of an smmu client device, by traversing proper 'klist_devices'
happening from iommu_init_device(). Please CMIW.

But this bug makes iommu_init_device() to completely gets skipped.

static int __iommu_probe_device(struct device *dev, ...)
{
	/* Device is probed already if in a group */
        if (dev->iommu_group)
                return 0;  --> driver call returns from here.

        ret = iommu_init_device(dev, ops);
        if (ret)
                return ret;


}

Regarding the testing, we work on Android that is on LTS kernels, so, it
may not be possible for us to try the thing on 6.13 and this seems a bug
on LTS 6.6 kernel.

[1]
https://lore.kernel.org/all/0952ca36-c5d9-462a-ab7b-b97154c56919@arm.com/

Thanks


