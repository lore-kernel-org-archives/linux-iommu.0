Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED628E8
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408791; cv=none; b=aWefvvQHlGRvReDCZWOUAaedb67HJEwnAf2KAMdMZBM7J7PQZu0u2sb9jYxHwLayIijW1/tkt1KG7fI2RxN4qBHV17auHWbwX0fq8gOs1B7058Dn3YUVHS/pMm92mOAIK7dIAqiTt65bKMsCzb0tZrwsrsyYcb9hkI6z/WLQNzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408791; c=relaxed/simple;
	bh=JYp+fyknPW8dimBPN339BuKak/diiWfixerUQ6rrTKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UBpz1Nd7Lm3WhN1wE/0+U2/J5ahTY7GQ9jBoSRE2exaQSATvDP95pb/ylkbFGsYHWiSlw5vtK0Z8jCEuFf5zNXPyqYcVktwK2R0p3/RmdtZ1aOlg0YRDgAHx2/VtrNeGWAw2dqyGSKxK/dpG+XWr2e4NHR2ZZqv2IEba2ce4BZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iiniXS9t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iiniXS9t"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49V9ET8d020425;
	Thu, 31 Oct 2024 21:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ttpBt+TvrTplOEFw0OZQmZ0OXUZGOnJ8+0DNKAJghII=; b=iiniXS9ti44rDGeU
	K3iU1qFgzlGxRtHGG5YP+CTFibAoUgsNByAQ0PPcAzo2dmrfWvLy4EmZ4yYk2NFR
	rUX7c+NWxRCJMQQXRwJ/ZvhDStVA1NnQl4LNJma9HTcg7bx9LYl4SJ+m299fNC8B
	5mvrKfTuWs9K4uPC5gkAsdyANNxQ5667VFXVqk4///caBWns5UimPNgd7oFMAwxU
	l1R1Xgc/uMQNqnwDNcnbjEYVOYiohvm1ke9Ha9GJ4Z+UOS87i0N2O2o2kltGgeMs
	YMy4KVFyOmfekG3bnixl49LCg9nIKO5FA2dZct4KeLs54TGn0HH8ESeZuzPnDpE5
	UZWFvA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grgus0aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 21:06:10 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49VL694b009191
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 21:06:09 GMT
Received: from [10.71.109.85] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 31 Oct
 2024 14:06:05 -0700
Message-ID: <8c987a26-d499-4ceb-905e-750bb24fcb08@quicinc.com>
Date: Thu, 31 Oct 2024 14:05:58 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/2] of: reserved_mem: Restruture how the reserved
 memory regions are processed
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: <robh@kernel.org>, <aisheng.dong@nxp.com>, <andy@black.fi.intel.com>,
        <catalin.marinas@arm.com>, <devicetree@vger.kernel.org>, <hch@lst.de>,
        <iommu@lists.linux.dev>, <kernel@quicinc.com>, <klarasmodin@gmail.com>,
        <linux-kernel@vger.kernel.org>, <m.szyprowski@samsung.com>,
        <quic_ninanaik@quicinc.com>, <robin.murphy@arm.com>,
        <saravanak@google.com>, <will@kernel.org>
References: <20241008220624.551309-1-quic_obabatun@quicinc.com>
 <20241008220624.551309-2-quic_obabatun@quicinc.com>
 <CAMuHMdUXj4QiSKdhf61xdDeu94=Hv0BXuCxykDpQwdY81_h2vw@mail.gmail.com>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <CAMuHMdUXj4QiSKdhf61xdDeu94=Hv0BXuCxykDpQwdY81_h2vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jENReLuDKfucV4YzQeUetUH7khIbXGBL
X-Proofpoint-GUID: jENReLuDKfucV4YzQeUetUH7khIbXGBL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410310159


On 10/29/2024 5:41 AM, Geert Uytterhoeven wrote:
> Hi Oreoluwa,
>
> On Wed, Oct 9, 2024 at 12:08 AM Oreoluwa Babatunde
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
>> These regions are processed and set aside at boot time.
>> This is done in two stages as seen below:
>>
>> Stage 1:
>> At this stage, fdt_scan_reserved_mem() scans through the child nodes of
>> the reserved_memory node using the flattened devicetree and does the
>> following:
>>
>> 1) If the node represents a statically-placed reserved memory region,
>>    i.e. if it is defined using the "reg" property:
>>    - Call memblock_reserve() or memblock_mark_nomap() as needed.
>>    - Add the information for that region into the reserved_mem array
>>      using fdt_reserved_mem_save_node().
>>      i.e. fdt_reserved_mem_save_node(node, name, base, size).
>>
>> 2) If the node represents a dynamically-placed reserved memory region,
>>    i.e. if it is defined using "alloc-ranges" and "size" properties:
>>    - Add the information for that region to the reserved_mem array with
>>      the starting address and size set to 0.
>>      i.e. fdt_reserved_mem_save_node(node, name, 0, 0).
>>    Note: This region is saved to the array with a starting address of 0
>>    because a starting address is not yet allocated for it.
>>
>> Stage 2:
>> After iterating through all the reserved memory nodes and storing their
>> relevant information in the reserved_mem array,fdt_init_reserved_mem() is
>> called and does the following:
>>
>> 1) For statically-placed reserved memory regions:
>>    - Call the region specific init function using
>>      __reserved_mem_init_node().
>> 2) For dynamically-placed reserved memory regions:
>>    - Call __reserved_mem_alloc_size() which is used to allocate memory
>>      for each of these regions, and mark them as nomap if they have the
>>      nomap property specified in the DT.
>>    - Call the region specific init function.
>>
>> The current size of the resvered_mem array is 64 as is defined by
>> MAX_RESERVED_REGIONS. This means that there is a limitation of 64 for
>> how many reserved memory regions can be specified on a system.
>> As systems continue to grow more and more complex, the number of
>> reserved memory regions needed are also growing and are starting to hit
>> this 64 count limit, hence the need to make the reserved_mem array
>> dynamically sized (i.e. dynamically allocating memory for the
>> reserved_mem array using membock_alloc_*).
>>
>> On architectures such as arm64, memory allocated using memblock is
>> writable only after the page tables have been setup. This means that if
>> the reserved_mem array is going to be dynamically allocated, it needs to
>> happen after the page tables have been setup, not before.
>>
>> Since the reserved memory regions are currently being processed and
>> added to the array before the page tables are setup, there is a need to
>> change the order in which some of the processing is done to allow for
>> the reserved_mem array to be dynamically sized.
>>
>> It is possible to process the statically-placed reserved memory regions
>> without needing to store them in the reserved_mem array until after the
>> page tables have been setup because all the information stored in the
>> array is readily available in the devicetree and can be referenced at
>> any time.
>> Dynamically-placed reserved memory regions on the other hand get
>> assigned a start address only at runtime, and hence need a place to be
>> stored once they are allocated since there is no other referrence to the
>> start address for these regions.
>>
>> Hence this patch changes the processing order of the reserved memory
>> regions in the following ways:
>>
>> Step 1:
>> fdt_scan_reserved_mem() scans through the child nodes of
>> the reserved_memory node using the flattened devicetree and does the
>> following:
>>
>> 1) If the node represents a statically-placed reserved memory region,
>>    i.e. if it is defined using the "reg" property:
>>    - Call memblock_reserve() or memblock_mark_nomap() as needed.
>>
>> 2) If the node represents a dynamically-placed reserved memory region,
>>    i.e. if it is defined using "alloc-ranges" and "size" properties:
>>    - Call __reserved_mem_alloc_size() which will:
>>      i) Allocate memory for the reserved region and call
>>      memblock_mark_nomap() as needed.
>>      ii) Call the region specific initialization function using
>>      fdt_init_reserved_mem_node().
>>      iii) Save the region information in the reserved_mem array using
>>      fdt_reserved_mem_save_node().
>>
>> Step 2:
>> 1) This stage of the reserved memory processing is now only used to add
>>    the statically-placed reserved memory regions into the reserved_mem
>>    array using fdt_scan_reserved_mem_reg_nodes(), as well as call their
>>    region specific initialization functions.
>>
>> 2) This step has also been moved to be after the page tables are
>>    setup. Moving this will allow us to replace the reserved_mem
>>    array with a dynamically sized array before storing the rest of
>>    these regions.
>>
>> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> Thanks for your patch, which is now commit 8a6e02d0c00e7b62
> ("of: reserved_mem: Restructure how the reserved memory regions
> are processed") in dt-rh/for-next.
>
> I have bisected a boot issue on RZ/Five to this commit.
> With "earlycon keep_bootcon" (else there is no output):
>
>     Oops - store (or AMO) access fault [#1]
>     CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted
> 6.12.0-rc1-00015-g8a6e02d0c00e #201
>     Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
>     epc : __memset+0x60/0x100
>      ra : __dma_alloc_from_coherent+0x150/0x17a
>     epc : ffffffff8062d2bc ra : ffffffff80053a94 sp : ffffffc60000ba20
>      gp : ffffffff812e9938 tp : ffffffd601920000 t0 : ffffffc6000d0000
>      t1 : 0000000000000000 t2 : ffffffffe9600000 s0 : ffffffc60000baa0
>      s1 : ffffffc6000d0000 a0 : ffffffc6000d0000 a1 : 0000000000000000
>      a2 : 0000000000001000 a3 : ffffffc6000d1000 a4 : 0000000000000000
>      a5 : 0000000000000000 a6 : ffffffd601adacc0 a7 : ffffffd601a841a8
>      s2 : ffffffd6018573c0 s3 : 0000000000001000 s4 : ffffffd6019541e0
>      s5 : 0000000200000022 s6 : ffffffd6018f8410 s7 : ffffffd6018573e8
>      s8 : 0000000000000001 s9 : 0000000000000001 s10: 0000000000000010
>      s11: 0000000000000000 t3 : 0000000000000000 t4 : ffffffffdefe62d1
>      t5 : 000000001cd6a3a9 t6 : ffffffd601b2aad6
>     status: 0000000200000120 badaddr: ffffffc6000d0000 cause: 0000000000000007
>     [<ffffffff8062d2bc>] __memset+0x60/0x100
>     [<ffffffff80053e1a>] dma_alloc_from_global_coherent+0x1c/0x28
>     [<ffffffff80053056>] dma_direct_alloc+0x98/0x112
>     [<ffffffff8005238c>] dma_alloc_attrs+0x78/0x86
>     [<ffffffff8035fdb4>] rz_dmac_probe+0x3f6/0x50a
>     [<ffffffff803a0694>] platform_probe+0x4c/0x8a
>     [<ffffffff8039ea16>] really_probe+0xe4/0x1c8
>     [<ffffffff8039ebc4>] __driver_probe_device+0xca/0xce
>     [<ffffffff8039ec48>] driver_probe_device+0x34/0x92
>     [<ffffffff8039ede8>] __driver_attach+0xb4/0xbe
>     [<ffffffff8039ce58>] bus_for_each_dev+0x60/0xa0
>     [<ffffffff8039e26a>] driver_attach+0x1a/0x22
>     [<ffffffff8039dc20>] bus_add_driver+0xa4/0x184
>     [<ffffffff8039f65c>] driver_register+0x8a/0xb4
>     [<ffffffff803a051c>] __platform_driver_register+0x1c/0x24
>     [<ffffffff808202f6>] rz_dmac_driver_init+0x1a/0x22
>     [<ffffffff80800ef6>] do_one_initcall+0x64/0x134
>     [<ffffffff8080122e>] kernel_init_freeable+0x200/0x202
>     [<ffffffff80638126>] kernel_init+0x1e/0x10a
>     [<ffffffff8063d58e>] ret_from_fork+0xe/0x18
>     Code: 1007 82b3 40e2 0797 0000 8793 00e7 8305 97ba 8782 (b023) 00b2
>     ---[ end trace 0000000000000000 ]---
>     Kernel panic - not syncing: Fatal exception in interrupt
>     ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
>
> Nothing really stands out in the kernel log, except for a delayed
> initialization of the reserved mem nodes (they are the same
> before/after):
>
>  printk: debug: ignoring loglevel setting.
> -OF: reserved mem: 0x0000000000030000..0x000000000003ffff (64 KiB)
> nomap non-reusable mmode_resv0@30000
> -OF: reserved mem: 0x0000000000040000..0x000000000004ffff (64 KiB)
> nomap non-reusable mmode_resv1@40000
> -OF: reserved mem: 0x0000000044000000..0x000000004403ffff (256 KiB)
> nomap non-reusable mmode_resv3@44000000
> -OF: reserved mem: 0x0000000044040000..0x000000004405ffff (128 KiB)
> nomap non-reusable mmode_resv2@44040000
> +earlycon: scif0 at MMIO 0x000000001004b800 (options '115200n8')
> +printk: legacy bootconsole [scif0] enabled
> +printk: debug: skip boot console de-registration.
>  Reserved memory: created DMA memory pool at 0x0000000058000000, size 128 MiB
>  OF: reserved mem: initialized node pma_resv0@58000000, compatible id
> shared-dma-pool
>  OF: reserved mem: 0x0000000058000000..0x000000005fffffff (131072 KiB)
> nomap non-reusable pma_resv0@58000000
> +OF: reserved mem: 0x0000000000030000..0x000000000003ffff (64 KiB)
> nomap non-reusable mmode_resv0@30000
> +OF: reserved mem: 0x0000000000040000..0x000000000004ffff (64 KiB)
> nomap non-reusable mmode_resv1@40000
> +OF: reserved mem: 0x0000000044040000..0x000000004405ffff (128 KiB)
> nomap non-reusable mmode_resv2@44040000
> +OF: reserved mem: 0x0000000044000000..0x000000004403ffff (256 KiB)
> nomap non-reusable mmode_resv3@44000000
>  Zone ranges:
>    DMA32    [mem 0x0000000048000000-0x000000007fffffff]
>    Normal   empty
>
> Reverting commits 00c9a452a235c61f ("of: reserved_mem: Add code to
> dynamically allocate reserved_mem array") and 8a6e02d0c00e7b62 fixes
> the issue.
>
> root@smarc-rzfive:/sys/firmware/devicetree/base/reserved-memory# ls -l
> total 0
> -r--r--r-- 1 root root  4 Oct 29 12:37 #address-cells
> -r--r--r-- 1 root root  4 Oct 29 12:37 #size-cells
> drwxr-xr-x 2 root root  0 Oct 29 12:37 mmode_resv0@30000
> drwxr-xr-x 2 root root  0 Oct 29 12:37 mmode_resv1@40000
> drwxr-xr-x 2 root root  0 Oct 29 12:37 mmode_resv2@44040000
> drwxr-xr-x 2 root root  0 Oct 29 12:37 mmode_resv3@44000000
> -r--r--r-- 1 root root 16 Oct 29 12:37 name
> drwxr-xr-x 2 root root  0 Oct 29 12:37 pma_resv0@58000000
> -r--r--r-- 1 root root  0 Oct 29 12:37 ranges
Hi Geert,

Thanks for reaching out and sorry you're seeing this issue.

Please can you provide reproduction steps? I tried booting up
risc-v arch with qemu but did not run into the issue you are
seeing.

Regards,
Oreoluwa
