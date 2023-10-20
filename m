Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E674669C
	for <iommu@lists.linux.dev>; Fri, 20 Oct 2023 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ju13qa9x"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39K4kQTq020199;
	Fri, 20 Oct 2023 08:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=As0DUL6ajPVu2B1Wb3FC7QVhiQcmASmHuGkfbnRCQDs=;
 b=ju13qa9xcxGlhTSAALSbC/vXnV3uOpFFzAONYuOxdedEtkObHtspVEAU3uCbKRpMs0Sa
 0wJek8JBh98A5eZFouUgLECs4kAp2O3en8bh6nhtOYCOvyV3dTksHYpHCkqa8+wvatXX
 FLjVGr0+aSJbZSg0snJx5Xm+MFu0PwcV+DD7vD7mUJge/UU9mmVbTTr6i9jcMPaYKR3a
 Qz/6RmUwAvMWmgLRoROHHXfnCLHL8g6FTcnQc0l3cl0FA+iKfKlfZcn1nj48kyjq8uTQ
 XxhTm788LBBidgllZIK/qhxl4Nm+VG2Sq1DZDKfBdaMbfC2i0hTmE6WTC7WBQRJYKFuK 7g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tubwksbcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Oct 2023 08:39:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39K8dMoK031725
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Oct 2023 08:39:22 GMT
Received: from [10.253.72.149] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 20 Oct
 2023 01:39:19 -0700
Message-ID: <15ee778e-a253-86e2-ef2a-9365b55ce1e5@quicinc.com>
Date: Fri, 20 Oct 2023 16:39:17 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [ARM IOMMU] IOMMU framework concurrency issue
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
        <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <quic_tingweiz@quicinc.com>,
        "Pavan
 Kondeti" <quic_pkondeti@quicinc.com>,
        "Patrick Daly (QUIC)"
	<quic_pdaly@quicinc.com>
References: <e2e20e1c-6450-4ac5-9804-b0000acdf7de@quicinc.com>
 <20231017163337.GE282036@ziepe.ca>
 <70cc8d3d-1ddf-4700-ac15-bcd74fae2b2a@arm.com>
 <20231018161918.GB691768@ziepe.ca>
 <0d6b490d-83df-76fb-f5ad-e9730fc57660@quicinc.com>
 <20231019151509.GD691768@ziepe.ca>
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <20231019151509.GD691768@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -qSLB9Gc-Q2Z-EoSEg8AYNz_Ozk8T5Jf
X-Proofpoint-ORIG-GUID: -qSLB9Gc-Q2Z-EoSEg8AYNz_Ozk8T5Jf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_07,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310200072



On 2023/10/19 23:15, Jason Gunthorpe wrote:
> On Thu, Oct 19, 2023 at 04:21:47PM +0800, Zhenhua Huang wrote:
>> In above time window (1), dev->iommu allocated but not freed, if it's just
>> accessed by client device's probing(Thread 1)..     crash happens.
>>
>> I also want to mention from our side, it's *not only seen for non-iommu*
>> device.
> 
> I see. So there are only two locks we currently have that could
> resolve that - the device_lock or the iommu_probe_device_lock
> 
> The device_lock path is what my prior series did, in your case you
> already have the device_lock on of_dma_configure_id() so you just need
> it on the bus path.

Exactly.

> 
> The iommu_probe_device_lock is what I guess Robin was thinking of with
> the of_xlate rework.. I looked a little and it seems like quite a
> thorny problem.. The ARM SMMU drivers seem to model the correct design
> using the iommu_fwspec to pass data from of_xlate to probe, while a
> whole bunch of other drivers decided to put the first half of their
> probe functions into of_xlate!
> 
> To untangle this to use the iommu_probe_device_lock the of_xlate would
> have to stop using the struct dev (ie so it cannot touch the
> dev->iommu any more) and all the dev->iommu touches in the of/acpi
> code reorganized into function arguments to iommu_probe which would
> then store them into the dev->iommu under the lock. Ie stop using
> dev->iommu as some temporary scratch pad to shuffle data around prior
> to probing. Pass iommu_fwspec as an arg to iommu_probe and a new
> ops->probe_fwspec. Stop calling dev_iommu_priv_set from of_xlate ops.
> 
>> Patch seems good to me and in theory can cover the case I have met. I tested
>> below based on 6.6-rc1 for sanity with minor changes(clean up tags etc). If
>> you're OK I want to propagate into our tree and to see if it fixes issue?
> 
> I don't think this patch can solve the races with of_xlate vs probe,
> that is just wrongly locked.
> 
> I assume my series you linked to comprehensively fixes this?
> 

Yeah, I thought your previous series can comprehensively cover it. But 
it seems based on your discussion with Robin, it needs fix for all wonky 
drivers and I indeed see lots of drivers directly call of_dma_configure 
etc... Instead, Shall we firstly adopt the lockless solution?

1. It actually closed concurrency window for non-iommu device
2. for iommu device, I checked for arm smmu and haven't seen concurrency 
case as well?

But it also needs your expert view if there is any impact from other 
smmu drivers :) For our case, it looks like to be working well..

Thanks,
Zhenhua

> FWIW I don't have the energy to try and fix all the wonky drivers
> properly so I don't plan to revisit it.
> 
> Jason
