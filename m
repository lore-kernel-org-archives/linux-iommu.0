Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05C5C433EF
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 13:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60C28408F7;
	Thu,  7 Apr 2022 13:00:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LoTFe67ANeiJ; Thu,  7 Apr 2022 13:00:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9D0D24094B;
	Thu,  7 Apr 2022 13:00:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6929C008C;
	Thu,  7 Apr 2022 13:00:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E9F8C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 13:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6CC0F80BEC
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 13:00:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KlqLcxhgEj4n for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 13:00:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 991C780BAB
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 13:00:17 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KZ1b45ycRzBrym;
 Thu,  7 Apr 2022 20:56:00 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 21:00:12 +0800
To: <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
 <alexander.shishkin@linux.intel.com>, <lorenzo.pieralisi@arm.com>,
 <will@kernel.org>, <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
 <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <leo.yan@linaro.org>,
 <jonathan.cameron@huawei.com>, <daniel.thompson@linaro.org>,
 <joro@8bytes.org>, <john.garry@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <robin.murphy@arm.com>,
 <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
 <linux-perf-users@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH v7 0/7] Add support for HiSilicon PCIe Tune and Trace device
Date: Thu, 7 Apr 2022 20:58:34 +0800
Message-ID: <20220407125841.3678-1-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Cc: zhangshaokun@hisilicon.com, liuqi115@huawei.com, linuxarm@huawei.com,
 prime.zeng@huawei.com, yangyicong@hisilicon.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Yicong Yang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yicong Yang <yangyicong@hisilicon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

HiSilicon PCIe tune and trace device (PTT) is a PCIe Root Complex
integrated Endpoint (RCiEP) device, providing the capability
to dynamically monitor and tune the PCIe traffic (tune),
and trace the TLP headers (trace).

PTT tune is designed for monitoring and adjusting PCIe link parameters.
We provide several parameters of the PCIe link. Through the driver,
user can adjust the value of certain parameter to affect the PCIe link
for the purpose of enhancing the performance in certian situation.

PTT trace is designed for dumping the TLP headers to the memory, which
can be used to analyze the transactions and usage condition of the PCIe
Link. Users can choose filters to trace headers, by either requester
ID, or those downstream of a set of Root Ports on the same core of the
PTT device. It's also supported to trace the headers of certain type and
of certain direction.

The driver registers a PMU device for each PTT device. The trace can
be used through `perf record` and the traced headers can be decoded
by `perf report`. The perf command support for the device is also
added in this patchset. The tune can be used through the sysfs
attributes of related PMU device. See the documentation for the
detailed usage.

Change since v6:
- Fix W=1 errors reported by lkp test, thanks

Change since v5:
- Squash the PMU patch into PATCH 2 suggested by John
- refine the commit message of PATCH 1 and some comments
Link: https://lore.kernel.org/lkml/20220308084930.5142-1-yangyicong@hisilicon.com/

Change since v4:
Address the comments from Jonathan, John and Ma Ca, thanks.
- Use devm* also for allocating the DMA buffers
- Remove the IRQ handler stub in Patch 2
- Make functions waiting for hardware state return boolean
- Manual remove the PMU device as it should be removed first
- Modifier the orders in probe and removal to make them matched well
- Make available {directions,type,format} array const and non-global
- Using the right filter list in filters show and well protect the
  list with mutex
- Record the trace status with a boolean @started rather than enum
- Optimize the process of finding the PTT devices of the perf-tool
Link: https://lore.kernel.org/linux-pci/20220221084307.33712-1-yangyicong@hisilicon.com/

Change since v3:
Address the comments from Jonathan and John, thanks.
- drop members in the common struct which can be get on the fly
- reduce buffer struct and organize the buffers with array instead of list
- reduce the DMA reset wait time to avoid long time busy loop
- split the available_filters sysfs attribute into two files, for root port
  and requester respectively. Update the documentation accordingly
- make IOMMU mapping check earlier in probe to avoid race condition. Also
  make IOMMU quirk patch prior to driver in the series
- Cleanups and typos fixes from John and Jonathan
Link: https://lore.kernel.org/linux-pci/20220124131118.17887-1-yangyicong@hisilicon.com/

Change since v2:
- address the comments from Mathieu, thanks.
  - rename the directory to ptt to match the function of the device
  - spinoff the declarations to a separate header
  - split the trace function to several patches
  - some other comments.
- make default smmu domain type of PTT device to identity
  Drop the RMR as it's not recommended and use an iommu_def_domain_type
  quirk to passthrough the device DMA as suggested by Robin. 
Link: https://lore.kernel.org/linux-pci/20211116090625.53702-1-yangyicong@hisilicon.com/

Change since v1:
- switch the user interface of trace to perf from debugfs
- switch the user interface of tune to sysfs from debugfs
- add perf tool support to start trace and decode the trace data
- address the comments of documentation from Bjorn
- add RMR[1] support of the device as trace works in RMR mode or
  direct DMA mode. RMR support is achieved by common APIs rather
  than the APIs implemented in [1].
Link: https://lore.kernel.org/lkml/1618654631-42454-1-git-send-email-yangyicong@hisilicon.com/
[1] https://lore.kernel.org/linux-acpi/20210805080724.480-1-shameerali.kolothum.thodi@huawei.com/

Qi Liu (1):
  perf tool: Add support for HiSilicon PCIe Tune and Trace device driver

Yicong Yang (6):
  iommu/arm-smmu-v3: Make default domain type of HiSilicon PTT device to
    identity
  hwtracing: Add trace function support for HiSilicon PCIe Tune and
    Trace device
  hisi_ptt: Add support for dynamically updating the filter list
  hisi_ptt: Add tune function support for HiSilicon PCIe Tune and Trace
    device
  docs: Add HiSilicon PTT device driver documentation
  MAINTAINERS: Add maintainer for HiSilicon PTT driver

 Documentation/trace/hisi-ptt.rst              |  303 +++++
 MAINTAINERS                                   |    7 +
 drivers/Makefile                              |    1 +
 drivers/hwtracing/Kconfig                     |    2 +
 drivers/hwtracing/ptt/Kconfig                 |   12 +
 drivers/hwtracing/ptt/Makefile                |    2 +
 drivers/hwtracing/ptt/hisi_ptt.c              | 1161 +++++++++++++++++
 drivers/hwtracing/ptt/hisi_ptt.h              |  220 ++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   16 +
 tools/perf/arch/arm/util/auxtrace.c           |   76 +-
 tools/perf/arch/arm/util/pmu.c                |    3 +
 tools/perf/arch/arm64/util/Build              |    2 +-
 tools/perf/arch/arm64/util/hisi_ptt.c         |  195 +++
 tools/perf/util/Build                         |    2 +
 tools/perf/util/auxtrace.c                    |    4 +
 tools/perf/util/auxtrace.h                    |    1 +
 tools/perf/util/hisi-ptt-decoder/Build        |    1 +
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   |  170 +++
 .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |   28 +
 tools/perf/util/hisi_ptt.c                    |  218 ++++
 tools/perf/util/hisi_ptt.h                    |   28 +
 21 files changed, 2448 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/trace/hisi-ptt.rst
 create mode 100644 drivers/hwtracing/ptt/Kconfig
 create mode 100644 drivers/hwtracing/ptt/Makefile
 create mode 100644 drivers/hwtracing/ptt/hisi_ptt.c
 create mode 100644 drivers/hwtracing/ptt/hisi_ptt.h
 create mode 100644 tools/perf/arch/arm64/util/hisi_ptt.c
 create mode 100644 tools/perf/util/hisi-ptt-decoder/Build
 create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
 create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
 create mode 100644 tools/perf/util/hisi_ptt.c
 create mode 100644 tools/perf/util/hisi_ptt.h

-- 
2.24.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
