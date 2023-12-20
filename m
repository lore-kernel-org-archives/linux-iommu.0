Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8728B3AC20
	for <iommu@lists.linux.dev>; Wed, 20 Dec 2023 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Od9937e7"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BKBkLRC011366;
	Wed, 20 Dec 2023 14:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=//yXjdjobVY6iKsjEaVSxeB8eG/4WoVBJf9FsZfbe4k=; b=Od
	9937e7i/bb+5OIslolfU26mMV0SYFyTgXFZhej4tP+ziYPuztKsWXVdNC8zDw96h
	0ZL9oVJizT2M5arIFX5kGg7PvcQ6/3Yz13mwgFHk2Baq1y3gkKpXkaWvPV3JNp/o
	rlNfnbXQhx2ridR1yNlxEXjqaeq5aDkC24aoVaJUCVptxNtWGx7LwBsvUQwqTaG+
	xKLmvoXa3hijfAptZnMn+wcBWgpOc+ia1Hpgmf/cxyumwZBskoR3GiY8LFzenWBQ
	fjBkuQbQHfRbymH7akP0KdNjGKuMxuzkjo5jClWhH5EhOYMXf27e5VX79pmMu2kR
	SZvQu9amIFnNF7TMMn4Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3fa3jdgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 14:01:55 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BKE1mTo031476
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 14:01:48 GMT
Received: from [10.216.49.244] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 06:01:45 -0800
Message-ID: <c2d608a8-6a43-bd30-c22b-0a5dd9eeac81@quicinc.com>
Date: Wed, 20 Dec 2023 19:31:42 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/2] iommu: Allow passing custom allocators to pgtable
 drivers
To: Joerg Roedel <joro@8bytes.org>,
        Boris Brezillon
	<boris.brezillon@collabora.com>
CC: <iommu@lists.linux.dev>, Will Deacon <will@kernel.org>,
        Robin Murphy
	<robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Clark
	<robdclark@gmail.com>, Steven Price <steven.price@arm.com>,
        <kernel@collabora.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20231215084302.2484163-1-boris.brezillon@collabora.com>
 <ZYGcju8vsrf5YywX@8bytes.org>
Content-Language: en-US
From: Gaurav Kohli <quic_gkohli@quicinc.com>
In-Reply-To: <ZYGcju8vsrf5YywX@8bytes.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gYQNqubM2338RYIBndj4nznScGPXcEHW
X-Proofpoint-ORIG-GUID: gYQNqubM2338RYIBndj4nznScGPXcEHW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=429 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312200099

thanks for the reply, please consider these if possible.

On 12/19/2023 7:07 PM, Joerg Roedel wrote:
> On Fri, Dec 15, 2023 at 09:43:01AM +0100, Boris Brezillon wrote:
>> v4:
>> - Add Gaurav's R-b/T-b
> 
> Thanks for the re-post, but there is too much on-top (including merge
> commits) to replace these.
> 
