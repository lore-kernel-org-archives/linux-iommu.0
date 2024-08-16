Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7CB1AC8BE
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831152; cv=none; b=hNx4L9AO3JA1nNUYKjeZW2cKifaZzw3seJF6GKQ02TApUQEsAcMmaR4hn+VxL543TSUybYbynk4nZV1Dki7N0lJqgu1PRbGSWnEiX74Pj/9cme3Bg9DHX25bP8FsgD9bKMQn/u3tOH1UyWF5FIZJfdx95DWiv34HJIZCRDGohfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831152; c=relaxed/simple;
	bh=oFkXkF6k0AMWCygG7eCMkCYcrPeDG0xM4/avwpNAwnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q7SW02QzrJgByfHA8yMnBq0bfr9h4vDEMqIXu1mSpZcl/nxgZ4jVwthcjszcErJC7+yZ0xGIbZc/VpmoBFQIPUUF03ItVFQWFtdits/SDjEEbdKxtYGGh3kvUi5BKDg7PNCBOeX1zd2aq4iAKLciI2DnGxDno5L9O7vO4lqwTwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nqQDACkH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nqQDACkH"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47G8ZSdX008624;
	Fri, 16 Aug 2024 17:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n8T21CC3e/EpyKKVAlbp5NLBH4+BCsDSkWJuMPtGQUg=; b=nqQDACkHUfu5aABe
	XPt0taeSwwzJHkZerdacr1elF/mEtbxnkfOCUOYP6IIQO522hxv2rp44QGo09eo/
	DFGuBhYbw2rGwpUl0Ko24+JCH+d+Sypi9hi3UCW5CLcJlIM73OaOXiXM6g8Oxlpi
	Yz2u3HOhmgyqmFC+xCwbbmmMO2Eq9n8K9ieFOPa43e5nx/wnKUBF7XwZ31T/eWDB
	a+GG4vvUcANOgoMneJQQFCdwh7aAowD/m+fkF27Q8yQjXWJoHRz3FgmDiG5kMkx4
	7B0sSLcNlGm2toUqPjWwVVArm82ia292fWDmHSm4RQTaKgPDeGMrhgOGLLjwGO33
	oqPv4A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4123cuhbgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 17:59:00 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47GHwxLj031342
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 17:58:59 GMT
Received: from [10.81.24.74] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 16 Aug
 2024 10:58:58 -0700
Message-ID: <d9ed421d-99e8-48ad-89df-73b86810d502@quicinc.com>
Date: Fri, 16 Aug 2024 10:58:58 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] iommupt: Add the basic structure of the iommu
 implementation
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Lu Baolu
	<baolu.lu@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, Christoph
 Hellwig <hch@lst.de>,
        <iommu@lists.linux.dev>, Joao Martins
	<joao.m.martins@oracle.com>,
        Kevin Tian <kevin.tian@intel.com>, <kvm@vger.kernel.org>,
        <linux-mm@kvack.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>, Ryan Roberts
	<ryan.roberts@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Tina Zhang
	<tina.zhang@intel.com>
References: <3-v1-01fa10580981+1d-iommu_pt_jgg@nvidia.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <3-v1-01fa10580981+1d-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6ESBk1rwWBdEpyQb42AxsyOP7FX6_mj6
X-Proofpoint-ORIG-GUID: 6ESBk1rwWBdEpyQb42AxsyOP7FX6_mj6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_12,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1015 mlxlogscore=950 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408160126

On 8/15/24 08:11, Jason Gunthorpe wrote:
> The iommu implementation is a single version of the iommu domain
> operations, iova_to_phys, map, unmap, read_and_clear_dirty and
> flushing. It is intended to be a near drop in replacement for existing
> iopt users.
> 
> By using the Generic Page Table mechanism it is a single algorithmic
> implementation that operates all the different page table formats with
> consistent characteristics.
> 
> Implement the basic starting point: alloc(), get_info() and deinit().
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/generic_pt/fmt/iommu_template.h |  37 ++++
>  drivers/iommu/generic_pt/iommu_pt.h           | 166 ++++++++++++++++++
>  include/linux/generic_pt/iommu.h              |  87 +++++++++
>  3 files changed, 290 insertions(+)
>  create mode 100644 drivers/iommu/generic_pt/fmt/iommu_template.h
>  create mode 100644 drivers/iommu/generic_pt/iommu_pt.h
>  create mode 100644 include/linux/generic_pt/iommu.h
> 
...

> +EXPORT_SYMBOL_NS_GPL(pt_iommu_init, GENERIC_PT_IOMMU);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(GENERIC_PT);

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning when built with make W=1. 

> +
> +#endif

