Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BA6358BD
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZtnI72tO"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IBOWwD003070;
	Wed, 18 Oct 2023 14:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5IVDOuSdorAVk1aB5p4OKBe7R6U7VdHn4dWixMN6gCw=;
 b=ZtnI72tOfsMZqlE23TLc1/P2CYdp0XyBUilN7SFHuu8KrIJ1a3NROy0BvTxvkdXikXsG
 IHyX0cAQUq9G5fy3mPRkbgpsJgex5IeoY07IZM1wq1qlKGFW7vzN/vuKhd3Xemx+SlFG
 Uxhn7RQHdbB9fNZExImVdetxEXsP1TCxVeRoRUIYpAXBSL958HWzy0QGEVnf4lMMbXim
 pudIM7agGuo3vA3StCshLqDB8JBR/lwv3ZJX848kyEgBrMuIRfJLHmWUX8JRFzBMWYzo
 XnEmFXpe04micr2LIc1xDTh7TX9DWm0vRggzobrvhWHkJ1pZRdfOasUI8LUbcrMr5rpU XA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ttcuv0n1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Oct 2023 14:27:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39IERvv6012820
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Oct 2023 14:27:57 GMT
Received: from [10.253.74.175] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 07:27:55 -0700
Message-ID: <fc7059e9-27e6-b3ff-f95c-801fdea1a43c@quicinc.com>
Date: Wed, 18 Oct 2023 22:27:53 +0800
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
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <quic_tingweiz@quicinc.com>
References: <e2e20e1c-6450-4ac5-9804-b0000acdf7de@quicinc.com>
 <20231017163337.GE282036@ziepe.ca>
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <20231017163337.GE282036@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: swJMlYdXX2KHL5HTLgv3NYvXX93ud87m
X-Proofpoint-GUID: swJMlYdXX2KHL5HTLgv3NYvXX93ud87m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_12,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180118

Thanks Jason for your reply.

On 2023/10/18 0:33, Jason Gunthorpe wrote:
> On Tue, Oct 17, 2023 at 07:10:23PM +0800, Zhenhua Huang wrote:
>> Dear experts,
>>
>> Saw a few crashes in our projects because of concurrency between (1) and
>> (2).
>>
>> bus notifier or bus_iommu_probe:
>> 	__iommu_probe_device
>> 		acquire iommu_probe_device_lock only
>> 		iommu_init_device()
>> 			//touch dev->iommu (1)
>> 			dev_iommu_get()
>> 			->probe_device()
>>
>> Client device probing path:
>> of_dma_configure			
>> 	of_iommu_configure
>> 		//touch dev->iommu  (2)
>> 		...
>>
>>
>> We already have 01657bc14a39 ("iommu: Avoid races around device probe") and
>> the big comment in __iommu_probe_device() refers to adopt device_lock()
>> further. Notice your big effort to utilize it, and IMO it can address above
>> issue(which protects dev->iommu):
> 
> I think something else has gone wrong here, you should not be able to
> get to any really_probe() before the iommu side has done its part.

Regarding "iommu side" Are you talking about client dev->iommu set up or 
arm-smmu driver probing? should be the latter? It seems not 
guaranteed... because 1st we have an option to disable device link check 
which creates dependency, 2nd also, for example, if we call 
of_platform_populate() in ancestor node to add child node device.. 
Ancestor node doesn't know if the dependency of child not is met.

BTW, Even for non-iommu binding client device which having no iommu 
dependency at all, the issue was also reported:
Client device's probing:
of_iommu_configure  ---Thread 1
	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
	if (fwspec) {
		 if (fwspec->ops)
			...

IOMMU probing:
iommu_device_register ---Thread 2
	.. bus_iommu_probe(iommu_buses[i]);
		__iommu_probe_device
			iommu_init_device
				dev_iommu_get
				... *time window of concurrency*  ------(1)
				dev_iommu_free

In above time window (1), dev->iommu allocated but not freed, if it's 
just accessed by client device's probing(Thread 1).. 	crash happens.

Thanks,
Zhenhua

> 
> Even with proper device locking the poor device that is racing isn't
> going to work properly as the IOMMU won't be guarenteed to be
> consistently configured.
> 
> This seems like you need to resolve boot time ordering in your
> platform? (I don't know exactly how ARM works here though)
> 
> eg make sure the iommu driver is fully registered before allowing any
> concurrent probes. Once the iommu driver is registered it will be able
> to catch the bus notifiers and serialize things properly. >
> Jason
