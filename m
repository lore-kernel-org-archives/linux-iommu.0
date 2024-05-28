Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3D613D8A2
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716935836; cv=none; b=T4REwcSfEsZZLIW17J2DRX0YJ6FNpz1RVIXS7oLn1DRseEohnxcMCBnhp/wrUJmaP4jUr6WNcF5jCodCKe6D2BKztnHQSU0qPLam2QvrlORfuEpFYLaKvjiz4wuFAyqtE5Y5Ch9gCKSCjRM1Ion3YH6O0VkswtseZdf0P6AVuwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716935836; c=relaxed/simple;
	bh=BC8JJs/dfarzqgavH283Dblh/XbAoaZ6TQ5/Uxi7+Lw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V73DbK5mDtMaJ59AxyYMfgUCRS1c3GTLRiL6Yc+iOoJBdZ/4MLTiDh+fCURxFxEy9ZEDucgt79Ugqs+p1TY5qISpCsJFHIbMlCvGev1fnTRdAtq1D9AS1AUgK94/b7lpP3YLtvhy4J1/66iBnFR/ss8Ym7W1AO6sKWZI7qT5jZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RV5CM+QJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RV5CM+QJ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SAoggL016945;
	Tue, 28 May 2024 22:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ookP0/kzKDhDMbio5n96o6
	7pINF0m+F40acNwXfXZQ4=; b=RV5CM+QJ69hrDi8Pp+YTjSVUyQWnlPJp8IXcBd
	dIYOdioZts7clmsOzns8j2DV+WZVGyqF2Vtx0MxR81irxfhvy4ABHpPh1W2g5su2
	yAA85ByBG4pg4UeWrvbyvnsnlvjECcedybk8xrqsRlmnsjcjusUWC96wXnpF99BT
	N0dETxYaTyCFViwhBfxI0BuypiQHyuNkPeUMZveiiQxkKUC/0c8Celfk4FUKtB7E
	aNZOj83/rBm6Kafs+LAfgby2DOCJ8y0PCArAosGLaos7gPptUUVbdDpntclaSV16
	qPdDTe/ngNTIDlTaY7t5KYVBAHXQuKqogBa4ILN6kL3ej8Tw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0pqc6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 22:37:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44SMb7WN012676
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 22:37:07 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 28 May 2024 15:37:03 -0700
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <robh@kernel.org>, <saravanak@google.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <catalin.marinas@arm.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kernel@quicinc.com>,
        Oreoluwa Babatunde
	<quic_obabatun@quicinc.com>
Subject: [PATCH v6 0/4] Dynamic Allocation of the reserved_mem array
Date: Tue, 28 May 2024 15:36:46 -0700
Message-ID: <20240528223650.619532-1-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vPAZd4bH6ddOoyuvxV39ZwXQe_nrwL1i
X-Proofpoint-GUID: vPAZd4bH6ddOoyuvxV39ZwXQe_nrwL1i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280168

The reserved_mem array is used to store data for the different
reserved memory regions defined in the DT of a device.  The array
stores information such as region name, node reference, start-address,
and size of the different reserved memory regions.

The array is currently statically allocated with a size of
MAX_RESERVED_REGIONS(64). This means that any system that specifies a
number of reserved memory regions greater than MAX_RESERVED_REGIONS(64)
will not have enough space to store the information for all the regions.

This can be fixed by making the reserved_mem array a dynamically sized
array which is allocated using memblock_alloc() based on the exact
number of reserved memory regions defined in the DT.

On architectures such as arm64, memblock allocated memory is not
writable until after the page tables have been setup.
This is an issue because the current implementation initializes the
reserved memory regions and stores their information in the array before
the page tables are setup. Hence, dynamically allocating the
reserved_mem array and attempting to write information to it at this
point will fail.

Therefore, the allocation of the reserved_mem array will need to be done
after the page tables have been setup, which means that the reserved
memory regions will also need to wait until after the page tables have
been setup to be stored in the array.

When processing the reserved memory regions defined in the DT, these
regions are marked as reserved by calling memblock_reserve(base, size).
Where:  base = base address of the reserved region.
        size = the size of the reserved memory region.

Depending on if that region is defined using the "no-map" property,
memblock_mark_nomap(base, size) is also called.

The "no-map" property is used to indicate to the operating system that a
mapping of the specified region must NOT be created. This also means
that no access (including speculative accesses) is allowed on this
region of memory except when it is coming from the device driver that
this region of memory is being reserved for.[1]

Therefore, it is important to call memblock_reserve() and
memblock_mark_nomap() on all the reserved memory regions before the
system sets up the page tables so that the system does not unknowingly
include any of the no-map reserved memory regions in the memory map.

There are two ways to define how/where a reserved memory region is
placed in memory:
i) Statically-placed reserved memory regions
i.e. regions defined with a set start address and size using the
     "reg" property in the DT.
ii) Dynamically-placed reserved memory regions.
i.e. regions defined by specifying a range of addresses where they can
     be placed in memory using the "alloc_ranges" and "size" properties
     in the DT.

The dynamically-placed reserved memory regions get assigned a start
address only at runtime. And this needs to  be done before the page
tables are setup so that memblock_reserve() and memblock_mark_nomap()
can be called on the allocated region as explained above.
Since the dynamically allocated reserved_mem array can only available
after the page tables have been setup, the information for the
dynamically-placed reserved memory regions needs to be stored somewhere
temporarily until the reserved_mem array is available.

Therefore, this series makes use of a temporary static array to store
the information of the dynamically-placed reserved memory regions until
the reserved_mem array is allocated.
Once the reserved_mem array is available, the information is copied over
from the temporary array into the reserved_mem array, and the memory for
the temporary array is freed back to the system.

The information for the statically-placed reserved memory regions does
not need to be stored in a temporary array because their starting
address is already stored in the devicetree.
Hence, the only thing that needs to be done for these regions before the
page tables are setup is to call memblock_reserve() and
memblock_mark_nomap().
Once the reserved_mem array is allocated, the information for the
statically-placed reserved memory regions is added to the array.

Note:
Because of the use of a temporary array to store the information of the
dynamically-placed reserved memory regions, there still exists a
limitation of 64 for this particular kind of reserved memory regions.
From my observation, these regions are typically small in number and
hence I expect this to not be an issue for now.

Dependency:
This series is dependent on the below patchset for proper behavior on
the sh architecture. The patch is currently being reviewed by the
relevant architecture maintainer and will hopefully be merged soon.
https://lore.kernel.org/all/20240520175802.2002183-1-quic_obabatun@quicinc.com/

Patch Versions:
v6:
- Rebased patchset on top of v6.10-rc1.
- Addressed comments received in v5 such as:
  1. Switched to using relevant typed functions such as
     of_property_read_u32(), of_property_present(), etc.
  2. Switched to using of_address_to_resource() to read the "reg"
     property of nodes.
  3. Renamed functions using "of_*" naming scheme instead of "dt_*".

v5:
https://lore.kernel.org/all/20240328211543.191876-1-quic_obabatun@quicinc.com/
- Rebased changes on top of v6.9-rc1.
- Addressed minor code comments from v4.

v4:
https://lore.kernel.org/all/20240308191204.819487-2-quic_obabatun@quicinc.com/
- Move fdt_init_reserved_mem() back into the unflatten_device_tree()
  function.
- Fix warnings found by Kernel test robot:
  https://lore.kernel.org/all/202401281219.iIhqs1Si-lkp@intel.com/
  https://lore.kernel.org/all/202401281304.tsu89Kcm-lkp@intel.com/
  https://lore.kernel.org/all/202401291128.e7tdNh5x-lkp@intel.com/

v3:
https://lore.kernel.org/all/20240126235425.12233-1-quic_obabatun@quicinc.com/
- Make use of __initdata to delete the temporary static array after
  dynamically allocating memory for reserved_mem array using memblock.
- Move call to fdt_init_reserved_mem() out of the
  unflatten_device_tree() function and into architecture specific setup
  code.
- Breaking up the changes for the individual architectures into separate
  patches.

v2:
https://lore.kernel.org/all/20231204041339.9902-1-quic_obabatun@quicinc.com/
- Extend changes to all other relevant architectures by moving
  fdt_init_reserved_mem() into the unflatten_device_tree() function.
- Add code to use unflatten devicetree APIs to process the reserved
  memory regions.

v1:
https://lore.kernel.org/all/20231019184825.9712-1-quic_obabatun@quicinc.com/

References:
[1]
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/reserved-memory/reserved-memory.yaml#L79

Oreoluwa Babatunde (4):
  of: reserved_mem: Restruture how the reserved memory regions are
    processed
  of: reserved_mem: Add code to dynamically allocate reserved_mem array
  of: reserved_mem: Use unflatten_devicetree APIs to scan reserved
    memory nodes
  of: reserved_mem: Rename fdt_* functions to refelct the change from
    using fdt APIs

 drivers/of/fdt.c                |   5 +-
 drivers/of/of_private.h         |   3 +-
 drivers/of/of_reserved_mem.c    | 247 ++++++++++++++++++++++++--------
 include/linux/of_reserved_mem.h |   2 +-
 kernel/dma/coherent.c           |  10 +-
 kernel/dma/contiguous.c         |   8 +-
 kernel/dma/swiotlb.c            |  10 +-
 7 files changed, 208 insertions(+), 77 deletions(-)

-- 
2.34.1

