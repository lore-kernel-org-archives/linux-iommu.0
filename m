Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF021BDABF
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830965; cv=none; b=FJFaJNw/PbJkvIbxA4/801CMgfe65fySOExRXUvtfF7saAV2vOS8p7F0lupKFXNWdoG6utyY5JjuCG7H6URKMeshmIBj8PKpuHGIoOOtte7ukob1LYheQxMQRGmvykfjj9jw42DDnuaDK5lODYuZ0S72LeZ8vI4j7F0oBDNEoH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830965; c=relaxed/simple;
	bh=JS7LCLfqiF2298c7Bl5zNY/XEsRbUrBD1Hkoq4XEjLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LeBN2EyHhDB5ra+e1uq66NBw8/pZ4bNaTHdemzHIvd/CWLkh3f4Q3TIq60MJ74KLEEobOJ3knhj8AqVv5zx0GvHTUZ0/algmoOF9DFObfYnkdTBldUnyaJiDVl2vxep7+zQBjUCLIMA7Y/R6Mu0QeoskJmwvcu2LieAaOvANyJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Fpfs68zu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fpfs68zu"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GG68I7031130;
	Fri, 16 Aug 2024 17:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yq9OAduvY4S8Jeg2Pa9Vlbb2Uon6I6YSTXJyX8g/M2c=; b=Fpfs68zujjffosGq
	pJm+yg89t1zQd3+CI0xvix9M5KmhTmTYem7h8+wSDywVSNpMGUVXWry7KRAx/6d3
	u8o0yvrOLNSHAz03bxvmFdkwUOchc8hJ3Q0Kzt1Ese5GQqVOjf/2Yy6iXgC+sDGd
	OtQqIu8zZXZCoB21obqQ3FMtfmdTZL3ZobX+WWRrkWWcKZKCJaMgohBlBCXwHeU+
	YUgOkPyeRdVxQoK6dGKMJLk6lxEauuW3zpO07fTM9i9dx15jA3Q53aSlhb0YOuDl
	M1fXtz+8XuxKpcfQ38v4qopMqWldSuAPHwPV/Mx8fPUMps9jKqYc+UomdBrUYCyr
	iBQovg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4103wsb4vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 17:55:52 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47GHtplv020165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 17:55:51 GMT
Received: from [10.81.24.74] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 16 Aug
 2024 10:55:51 -0700
Message-ID: <292a7ed2-a2a0-4dce-9741-b7169402b290@quicinc.com>
Date: Fri, 16 Aug 2024 10:55:50 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] iommupt: Add a kunit test for Generic Page Table
 and the IOMMU implementation
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
References: <9-v1-01fa10580981+1d-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <9-v1-01fa10580981+1d-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZNfrWpnORYMPty3y6Lmw_WiVp1j4NNZP
X-Proofpoint-ORIG-GUID: ZNfrWpnORYMPty3y6Lmw_WiVp1j4NNZP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_12,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408160126

On 8/15/24 08:11, Jason Gunthorpe wrote:
> This intends to have high coverage of the page table format functions and
> the IOMMU implementation itself, exercising the various corner cases.
> 
> The kunit can be run in the kunit framework, using commands like:
> 
> tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 --make_options LD=ld.lld-18  --make_options 'CC=clang-18 --target=aarch64-linux-gnu' --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
> tools/testing/kunit/kunit.py run --build_dir build_kunit_uml --make_options CC=gcc-13 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig --kconfig_add CONFIG_WERROR=n
> tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x86_64 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
> tools/testing/kunit/kunit.py run --build_dir build_kunit_i386 --arch i386 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
> tools/testing/kunit/kunit.py run --build_dir build_kunit_i386pae --arch i386 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig --kconfig_add CONFIG_X86_PAE=y
> 
> There are several interesting corner cases on the 32 bit platforms that
> need checking.
> 
> FIXME: further improve the tests
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
...

> +kunit_test_suites(&NS(iommu_suite));
> +
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(GENERIC_PT_IOMMU);

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning when built with make W=1. Recently, multiple
developers have been eradicating these warnings treewide, and very few
are left, so please don't introduce a new one :)

/jeff
