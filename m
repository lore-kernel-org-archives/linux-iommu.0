Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314F74176F
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dDPacE50"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H9MaPB008786;
	Tue, 17 Oct 2023 11:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : to : cc : from : subject : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=KD4RtR5soLdEcKAZy/r+6Sm5AazALSzjGEjDvqFdx4o=;
 b=dDPacE50YEKTA98XgpOn7PyBJe6AFE5DWLaxJ/V1roDGbfamFaLKZL9P6nwZfj49eI25
 KN8U28/DcQVulacM2EbdVD8FQ2RHEl5tGEOGCmFv33Q0lrQeJ6jNz4BKAThgz2e8VjRe
 3iQZ/Z0VqJi1w0Lw+Iol3dq2+KyFUl0f7ma89PGNozuob4Gjbjg5Yshl3/7h1BQVmcTT
 uAffGAFKyBMPE9R8SIqkZgTbv0TZSHJyZXw8MiDzPupDAvX7aFMM133T5L8i5+/medP5
 jjOIqaTYkdfb8Zbtq/qn78Vrw1cCTK5RlE0GyODBU+f3Iu4ID0QGgkOOWqnyeWBG2P43 yg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsb3xsrwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Oct 2023 11:10:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39HBAcDF021751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Oct 2023 11:10:38 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 04:10:35 -0700
Message-ID: <e2e20e1c-6450-4ac5-9804-b0000acdf7de@quicinc.com>
Date: Tue, 17 Oct 2023 19:10:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <jgg@ziepe.ca>, <baolu.lu@linux.intel.com>
CC: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <quic_tingweiz@quicinc.com>
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: [ARM IOMMU] IOMMU framework concurrency issue
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: StGEoaQk9dQd8Sd-dX3UNGJgA_O_WRwU
X-Proofpoint-ORIG-GUID: StGEoaQk9dQd8Sd-dX3UNGJgA_O_WRwU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310170093

Dear experts,

Saw a few crashes in our projects because of concurrency between (1) and 
(2).

bus notifier or bus_iommu_probe:
	__iommu_probe_device
		acquire iommu_probe_device_lock only
		iommu_init_device()
			//touch dev->iommu (1)
			dev_iommu_get()
			->probe_device()

Client device probing path:
of_dma_configure			
	of_iommu_configure
		//touch dev->iommu  (2)
		...


We already have 01657bc14a39 ("iommu: Avoid races around device probe") 
and the big comment in __iommu_probe_device() refers to adopt 
device_lock() further. Notice your big effort to utilize it, and IMO it 
can address above issue(which protects dev->iommu):
https://lore.kernel.org/all/0-v2-d2762acaf50a+16d-iommu_group_locking2_jgg@nvidia.com/T/#md11b80c9e5c90ab97904f1bddecc21d97c296c0d
But from your discussion it was pointed out "which already violates 
*other* IOMMU API assumptions", because of some drivers directly called 
of_dma_configure() w/o acquiring device_lock().

Could you please provide your points of view how to address this further?

One example of crash logs, checking dump found dev->iommu already freed:
[ 0.898000][ T77] Unable to handle kernel paging request at virtual 
address 70c7e81d817765bc
…
[ 0.898219][ T77] pc : iommu_fwspec_init+0x30/0xc4
[ 0.898223][ T77] lr : of_iommu_xlate+0x58/0xe0
…
[ 0.898252][ T77] Call trace:
[ 0.898253][ T77] iommu_fwspec_init+0x30/0xc4
[ 0.898255][ T77] of_iommu_xlate+0x58/0xe0
[ 0.898257][ T77] of_iommu_configure+0x16c/0x224
[ 0.898260][ T77] of_dma_configure_id+0x1cc/0x244
[ 0.898265][ T77] platform_dma_configure+0x34/0x80
[ 0.898267][ T77] really_probe+0x110/0x384
[ 0.898271][ T77] __driver_probe_device+0xb4/0xe4
[ 0.898274][ T77] driver_probe_device+0x44/0x210
[ 0.898277][ T77] __device_attach_driver+0x144/0x170
[ 0.898280][ T77] bus_for_each_drv+0x9c/0xec
[ 0.898282][ T77] __device_attach_async_helper+0x78/0xd0
[ 0.898285][ T77] async_run_entry_fn+0x44/0x118
[ 0.898287][ T77] process_one_work+0x1e4/0x43c
[ 0.898290][ T77] worker_thread+0x25c/0x430
[ 0.898293][ T77] kthread+0x104/0x1d4
[ 0.898295][ T77] ret_from_fork+0x10/0x20

Thanks,
Zhenhua
