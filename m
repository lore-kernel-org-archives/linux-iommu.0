Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB4A18A923;
	Wed, 26 Jun 2024 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719416909; cv=none; b=gI4tallp3qznIyWNn12hpwz3acKhpyyFwtXLMeBSXJPQj8HKEB3dWRuVFv5wHchyPuSxNzOY6ru8WuAS6BuBrwOZeHmtJFmc5ONy8zBRPqLgOd5VscFyxvlEb68e+uofsZtr2hpNY1KLdGt4ql3UQar1mTajlpE35WI7F4Z96xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719416909; c=relaxed/simple;
	bh=FzzowXyGnIPOeCOLkhjjrNoMLDhPzrwp81kcDqhZgHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Opwid5aUvKNLYc+tS4mYt4TSEjpZuXsF1hyWSvh8MToLsizy804ov/QVBC2uOCpcrE0hNUtfiwj41mvNdihO1AEI3NQaJgIaI4BP+6od/Dr+q7Y4Qu07S2wGDSpV394V5xKEGmDE/GsJzgO0SyIKRGIHFXllmbtdaN5VobqRLYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I6KpqcSu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I6KpqcSu"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfVJh029258;
	Wed, 26 Jun 2024 15:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d6IzhZJiiJo63llI9ttpBLLWYn+B921/b5BIFdB4ok4=; b=I6KpqcSurNwiqzk6
	ouHQCQgpIwR3DyHlAz9MgSsZSmY6GGDsYWGY/Q+gWw2HL0nDyiXHu+ekkKhX0fPy
	y+zgw60VmUwXenlGAqAwjq5GT52j+84bDDnr0+KuKx+QBkv3uxWO8azl/aS7MV9d
	DXbHLT+Y0WQBKB6gB8TVKmtf3bybnWeBBxZ31BLfCCtcdupVHOclQvZxeDgUJWV/
	GMVGjAVbHpyhBrTZYjCUy2rJT/5vVVmlsGRLeYEtnjssa5N2mZGOtPtp1npmIjGK
	VOupMS7N/eKtudLq/3OTcplTvaJkRpXqtMY+AYq+ZUWGI4SAKCB6XBiT9VuM4SJr
	orw9/w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnm6sq84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 15:48:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QFmDkE018812
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 15:48:13 GMT
Received: from [10.110.92.181] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 08:48:08 -0700
Message-ID: <1c65ae7a-ac35-4c80-aa06-9ca921a7c919@quicinc.com>
Date: Wed, 26 Jun 2024 08:48:02 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] of: reserved_mem: Restructure code to call reserved
 mem init functions earlier
To: Rob Herring <robh@kernel.org>
CC: <broonie@kernel.org>, <catalin.marinas@arm.com>, <conor@kernel.org>,
        <devicetree@vger.kernel.org>, <hch@lst.de>, <iommu@lists.linux.dev>,
        <kernel@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <m.szyprowski@samsung.com>, <nathan@kernel.org>,
        <oe-kbuild-all@lists.linux.dev>, <robin.murphy@arm.com>,
        <saravanak@google.com>, <will@kernel.org>
References: <202406181626.126X1Nbz-lkp@intel.com>
 <20240620001027.2326275-1-quic_obabatun@quicinc.com>
 <20240626151622.GA3139921-robh@kernel.org>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <20240626151622.GA3139921-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g3TZyqMQhSuc0Ixry-udpwaVYhV5XTxF
X-Proofpoint-ORIG-GUID: g3TZyqMQhSuc0Ixry-udpwaVYhV5XTxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=973 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260115


On 6/26/2024 8:16 AM, Rob Herring wrote:
> On Wed, Jun 19, 2024 at 05:10:27PM -0700, Oreoluwa Babatunde wrote:
>> After all the reserved memory regions have been added to the
>> reserved_mem array, a region specific initialization function is called
>> on each of reserved memory regions in a loop to initialize them.
>>
>> With recent changes made to allow the reserved_mem array be dynamically
>> allocated, the cma reserved memory regions are not initialized until
>> after the page tables are setup. This causes the warning seen in the
>> dump stack below:
>>
>> 	WARNING: CPU: 0 PID: 1 at mm/memory.c:2789 __apply_to_page_range+0x360/0x380
>> 	CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.10.0-rc1-00007-ga46cccb0ee2d #1
>> 	Hardware name: Generic DT based system
>> 	Call trace:
>> 	unwind_backtrace from show_stack+0x18/0x1c
>> 	show_stack from dump_stack_lvl+0x54/0x68
>> 	dump_stack_lvl from __warn+0x74/0x114
>> 	__warn from warn_slowpath_fmt+0x13c/0x1c0
>> 	warn_slowpath_fmt from __apply_to_page_range+0x360/0x380
>> 	__apply_to_page_range from apply_to_page_range+0x24/0x2c
>> 	apply_to_page_range from __alloc_from_contiguous+0xc4/0x158
>> 	__alloc_from_contiguous from cma_allocator_alloc+0x3c/0x44
>> 	cma_allocator_alloc from arch_dma_alloc+0x128/0x2b4
>> 	arch_dma_alloc from dma_alloc_attrs+0x90/0x150
>> 	dma_alloc_attrs from drm_gem_dma_create+0xa4/0x13c
>> 	drm_gem_dma_create from drm_gem_dma_create_with_handle+0x24/0xac
>> 	drm_gem_dma_create_with_handle from drm_gem_dma_dumb_create+0x44/0x50
>> 	drm_gem_dma_dumb_create from drm_client_framebuffer_create+0x9c/0x164
>> 	drm_client_framebuffer_create from drm_fbdev_dma_helper_fb_probe+0x84/0x23c
>> 	drm_fbdev_dma_helper_fb_probe from __drm_fb_helper_initial_config_and_unlock+0x2e4/0x4f8
>> 	__drm_fb_helper_initial_config_and_unlock from drm_fbdev_dma_client_hotplug+0x74/0xb8
>> 	drm_fbdev_dma_client_hotplug from drm_client_register+0x5c/0x98
>> 	drm_client_register from aspeed_gfx_probe+0x278/0x3c0
>> 	aspeed_gfx_probe from platform_probe+0x60/0xb8
>> 	platform_probe from really_probe+0xd4/0x3b4
>> 	really_probe from __driver_probe_device+0x90/0x1dc
>> 	__driver_probe_device from driver_probe_device+0x38/0xd0
>> 	driver_probe_device from __driver_attach+0x118/0x1dc
>> 	__driver_attach from bus_for_each_dev+0x84/0xd4
>> 	bus_for_each_dev from bus_add_driver+0xec/0x1f0
>> 	bus_add_driver from driver_register+0x84/0x11c
>> 	driver_register from do_one_initcall+0x84/0x1c8
>> 	do_one_initcall from kernel_init_freeable+0x1a4/0x230
>> 	kernel_init_freeable from kernel_init+0x1c/0x138
>> 	kernel_init from ret_from_fork+0x14/0x28
>> 	Exception stack(0x9f015fb0 to 0x9f015ff8)
>> 	5fa0:                                     00000000 00000000 00000000 00000000
>> 	5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> 	5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> 	---[ end trace 0000000000000000 ]---
>> 	aspeed_gfx 1e6e6000.display: [drm] fb0: aspeed-gfx-drmd frame buffer device
>>
>> Hence, restructure the code to initialize the regions as soon as each
>> of them are added to the reserved_mem array.
>>
>> Fixes: a46cccb0ee2d ("of: reserved_mem: Restruture how the reserved memory regions are processed")
>> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
>> ---
>> v2:
>> - Fix kernel-doc for of_init_reserved_mem_node() in response to the
>>   below warning from v1:
>>   https://lore.kernel.org/all/202406181626.126X1Nbz-lkp@intel.com/
>>
>> v1:
>>   https://lore.kernel.org/all/20240617193357.3929092-1-quic_obabatun@quicinc.com/
>>
>>  drivers/of/fdt.c             |  2 +-
>>  drivers/of/of_private.h      |  2 +-
>>  drivers/of/of_reserved_mem.c | 83 +++++++++++++++++++++---------------
>>  3 files changed, 50 insertions(+), 37 deletions(-)
> Applied.
>
> In the future, do not send fixes or new versions as replies to previous 
> threads. The default behavior of b4 is to apply v6 of the series because 
> that is the 'newest' version.
>
> Rob
ack.

Thank you!
