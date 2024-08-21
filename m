Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFBC1422A8
	for <iommu@lists.linux.dev>; Wed, 21 Aug 2024 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724283690; cv=none; b=V1r79Bis/Nv5l5gBySpRiDpb7AC15K2Hx2sggHB93G3C13CRsRpMywCkrm4643g/LtDYadGtmiJTy6McLOxC/C1/pX8FwjvbWLPk0eaaG5EULLuwdFZA6ZNZ3pT2a0uFTKP2TGSD2/l4V6HoktuN0f6ixdXD0wDYJliHua4aERI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724283690; c=relaxed/simple;
	bh=x8Bg94Z2zsdxajcw3hSHGhloSoauODJGqMwgx8Ukg8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i5DUbBpCGUm7SkHjz9kEp4EVibsLlc7jrjHwCDOcvzuwP2HZIicc2AhRsifvCj6gQeZGCb3QlXB1ytJj0OAs9vJ7vLVhmlOh4XfEdbZWF4hjSA2WjxdOtlvccdk4DtHFFgBwPRWW7lRGv2NV/m+uMPjkG46FkKd0hy3KP+4jl+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D4WbdCQ5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D4WbdCQ5"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LFZ7cl019748;
	Wed, 21 Aug 2024 23:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0f+/dlZFqwe0oaeG97dCTtX57gT5/oAkzmFEAXls3zA=; b=D4WbdCQ520izKdyA
	2vgmNaz5BryAXT06IChx3qN2tSeGkJJim//ATBvyEW0l6R2CLrwLYL3HHcOFK5Df
	ZZATyZKDy0J0DiRvonwUKA6XBpWiD4dqUtss+b05v2exKbTdHME+4nbLS9W7MSWt
	G/O2E+yfVrCxmOrE+LE+TanAZxYVZsdozML6JYSJpq/xxv3CBWpnrr1suxtK+h7W
	ixeyVHkwjWlxbLkSv+UmTu3ElQ9FsT6Rfvsc52+mUrm2y7Hc+cM+9954i+oUz75Z
	r4VYIbnqVl/twhwREXGTgU1NnoBiG927yANNS2zoDUMAfvxSEGZRN5WzMEK8HJPZ
	tu/YTQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 415bkwaqmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 23:41:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47LNfJCB021976
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 23:41:19 GMT
Received: from [10.71.109.148] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 Aug
 2024 16:41:16 -0700
Message-ID: <3e6e8921-6d52-40e2-9124-7ab550566716@quicinc.com>
Date: Wed, 21 Aug 2024 16:41:10 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] of: reserved_mem: Restruture how the reserved
 memory regions are processed
To: Rob Herring <robh@kernel.org>
CC: <saravanak@google.com>, <klarasmodin@gmail.com>, <aisheng.dong@nxp.com>,
        <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <will@kernel.org>, <catalin.marinas@arm.com>,
        <kernel@quicinc.com>
References: <20240809184814.2703050-1-quic_obabatun@quicinc.com>
 <20240809184814.2703050-2-quic_obabatun@quicinc.com>
 <CAL_JsqL=Pc7FJJevMskvYYOoYZYCKF+db9C2Y7_cm7DZNyTYPw@mail.gmail.com>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <CAL_JsqL=Pc7FJJevMskvYYOoYZYCKF+db9C2Y7_cm7DZNyTYPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8tpH6n_CHjapxUDiO4aPLEaL2b9qXJqd
X-Proofpoint-GUID: 8tpH6n_CHjapxUDiO4aPLEaL2b9qXJqd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_15,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408210171


On 8/19/2024 3:04 PM, Rob Herring wrote:
> On Fri, Aug 9, 2024 at 1:48 PM Oreoluwa Babatunde
> <quic_obabatun@quicinc.com> wrote:
>> Reserved memory regions defined in the devicetree can be broken up into
>> two groups:
>> i) Statically-placed reserved memory regions
>> i.e. regions defined with a static start address and size using the
>>      "reg" property.
>> ii) Dynamically-placed reserved memory regions.
>> i.e. regions defined by specifying an address range where they can be
>>      placed in memory using the "alloc_ranges" and "size" properties.
>>
>> [...]
>>
>> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
>> ---
>>  drivers/of/fdt.c             |   5 +-
>>  drivers/of/of_private.h      |   3 +-
>>  drivers/of/of_reserved_mem.c | 172 +++++++++++++++++++++++++----------
>>  3 files changed, 131 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index 68103ad230ee..d4b7aaa70e31 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -511,8 +511,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
>>                         break;
>>                 memblock_reserve(base, size);
>>         }
>> -
>> -       fdt_init_reserved_mem();
>>  }
>>
>>  /**
>> @@ -1239,6 +1237,9 @@ void __init unflatten_device_tree(void)
>>         of_alias_scan(early_init_dt_alloc_memory_arch);
>>
>>         unittest_unflatten_overlay_base();
>> +
>> +       /* Save the statically-placed regions in the reserved_mem array */
>> +       fdt_scan_reserved_mem_reg_nodes();
Hi Rob,
> I'm still not understanding why the unflatttened API doesn't work
> here? It was just used in of_alias_scan() above here.
The main reason why the unflatten_devicetree APIs does not work here is
because a reference to fdt_node needs to be stored for the reserved
regions, and it can only be gotten by using the fdt APIs.

The fdt_node is needed by rmem_dma_setup(), rmem_cma_setup(), and
rmem_swiotlb_setup(). All of which are used to configure the reserved
memory regions during early bootup.

In my previous versions, I replaced fdt_node with device_node in struct
reserved_mem in order to leverage the unflatten_devicetree APIs, and the
above functions were being called after the page tables were setup.

As we found out later, those functions need to be called before the page
tables are setup in order for the reserved regions to be configured
correctly[1]. But since the unflatten_devicetree APIs are not available
before the page tables are setup, I had to switch back to using the
fdt_node which can only be gotten by using the fdt APIs.

[1] https://lore.kernel.org/all/002b6176-41b3-4888-abb1-978399d108b8@arm.com/

The only way I see that we can avoid using the fdt APIs here is if
we just don't store an fdt_node reference for the reserved regions
in resvered_mem.  But I'm not sure if we want to do that.
> The problem reported is this function uses initial_boot_params, but
> that's NULL for x86.
ack
Thank you,
Oreoluwa.
