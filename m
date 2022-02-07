Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08536C433F5
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 10:31:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A29FE4031D;
	Mon,  7 Feb 2022 10:31:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WzII6JngmK-u; Mon,  7 Feb 2022 10:31:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0E5B0400AB;
	Mon,  7 Feb 2022 10:31:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DACEEC0011;
	Mon,  7 Feb 2022 10:31:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A9AAC000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 09:40:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 269674027A
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 09:40:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WApPiXbkdMEM for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 09:40:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3CB8040272
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 09:40:12 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Jsh0V0MX8z9sL0;
 Mon,  7 Feb 2022 17:38:34 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Feb 2022 17:40:03 +0800
Subject: Re: [PATCH v3 0/8] Add support for HiSilicon PCIe Tune and Trace
 device
To: Yicong Yang <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
 <helgaas@kernel.org>, <alexander.shishkin@linux.intel.com>,
 <lorenzo.pieralisi@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
 <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
 <mike.leach@linaro.org>, <leo.yan@linaro.org>, <jonathan.cameron@huawei.com>, 
 <daniel.thompson@linaro.org>, <joro@8bytes.org>, <john.garry@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <robin.murphy@arm.com>,
 <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
 <linux-perf-users@vger.kernel.org>, <iommu@lists.linux-foundation.org>
References: <20220124131118.17887-1-yangyicong@hisilicon.com>
Message-ID: <5c1099b2-232f-2dc5-7c31-18fe3343955e@huawei.com>
Date: Mon, 7 Feb 2022 17:40:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220124131118.17887-1-yangyicong@hisilicon.com>
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 07 Feb 2022 10:31:45 +0000
Cc: zhangshaokun@hisilicon.com, liuqi115@huawei.com, linuxarm@huawei.com,
 prime.zeng@huawei.com
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
Reply-To: Yicong Yang <yangyicong@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi perf, ETM and PCI related experts,

a gentle ping ... appreciate for the comments.

thanks.

On 2022/1/24 21:11, Yicong Yang wrote:
> HiSilicon PCIe tune and trace device (PTT) is a PCIe Root Complex
> integrated Endpoint (RCiEP) device, providing the capability
> to dynamically monitor and tune the PCIe traffic (tune),
> and trace the TLP headers (trace).
> 
> PTT tune is designed for monitoring and adjusting PCIe link parameters.
> We provide several parameters of the PCIe link. Through the driver,
> user can adjust the value of certain parameter to affect the PCIe link
> for the purpose of enhancing the performance in certian situation.
> 
> PTT trace is designed for dumping the TLP headers to the memory, which
> can be used to analyze the transactions and usage condition of the PCIe
> Link. Users can choose filters to trace headers, by either requester
> ID, or those downstream of a set of Root Ports on the same core of the
> PTT device. It's also supported to trace the headers of certain type and
> of certain direction.
> 
> The driver registers a PMU device for each PTT device. The trace can
> be used through `perf record` and the traced headers can be decoded
> by `perf report`. The perf command support for the device is also
> added in this patchset. The tune can be used through the sysfs
> attributes of related PMU device. See the documentation for the
> detailed usage.
> 
> Change since v2:
> - address the comments from Mathieu
>   - rename the directory to ptt to match the function of the device
>   - spinoff the declarations to a separate header
>   - split the trace function to several patches
>   - some other comments.
> - make default smmu domain type of PTT device to identity
>   Drop the RMR as it's not recommended and use an iommu_def_domain_type
>   quirk to passthrough the device DMA as suggested by Robin. 
> Link: https://lore.kernel.org/linux-pci/20211116090625.53702-1-yangyicong@hisilicon.com/
> 
> Change since v1:
> - switch the user interface of trace to perf from debugfs
> - switch the user interface of tune to sysfs from debugfs
> - add perf tool support to start trace and decode the trace data
> - address the comments of documentation from Bjorn
> - add RMR[1] support of the device as trace works in RMR mode or
>   direct DMA mode. RMR support is achieved by common APIs rather
>   than the APIs implemented in [1].
> Link: https://lore.kernel.org/lkml/1618654631-42454-1-git-send-email-yangyicong@hisilicon.com/
> 
> [1] https://lore.kernel.org/linux-acpi/20210805080724.480-1-shameerali.kolothum.thodi@huawei.com/
> 
> Qi Liu (1):
>   perf tool: Add support for HiSilicon PCIe Tune and Trace device driver
> 
> Yicong Yang (7):
>   hwtracing: Add trace function support for HiSilicon PCIe Tune and
>     Trace device
>   hisi_ptt: Register PMU device for PTT trace
>   hisi_ptt: Add support for dynamically updating the filter list
>   hisi_ptt: Add tune function support for HiSilicon PCIe Tune and Trace
>     device
>   docs: Add HiSilicon PTT device driver documentation
>   MAINTAINERS: Add maintainer for HiSilicon PTT driver
>   iommu/arm-smmu-v3: Make default domain type of HiSilicon PTT device to
>     identity
> 
>  Documentation/trace/hisi-ptt.rst              |  304 +++++
>  MAINTAINERS                                   |    7 +
>  drivers/Makefile                              |    1 +
>  drivers/hwtracing/Kconfig                     |    2 +
>  drivers/hwtracing/ptt/Kconfig                 |   11 +
>  drivers/hwtracing/ptt/Makefile                |    2 +
>  drivers/hwtracing/ptt/hisi_ptt.c              | 1124 +++++++++++++++++
>  drivers/hwtracing/ptt/hisi_ptt.h              |  239 ++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   16 +
>  tools/perf/arch/arm/util/auxtrace.c           |   56 +-
>  tools/perf/arch/arm/util/pmu.c                |    3 +
>  tools/perf/arch/arm64/util/Build              |    2 +-
>  tools/perf/arch/arm64/util/hisi_ptt.c         |  195 +++
>  tools/perf/util/Build                         |    2 +
>  tools/perf/util/auxtrace.c                    |    4 +
>  tools/perf/util/auxtrace.h                    |    1 +
>  tools/perf/util/hisi-ptt-decoder/Build        |    1 +
>  .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   |  170 +++
>  .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |   28 +
>  tools/perf/util/hisi_ptt.c                    |  228 ++++
>  tools/perf/util/hisi_ptt.h                    |   28 +
>  21 files changed, 2420 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/trace/hisi-ptt.rst
>  create mode 100644 drivers/hwtracing/ptt/Kconfig
>  create mode 100644 drivers/hwtracing/ptt/Makefile
>  create mode 100644 drivers/hwtracing/ptt/hisi_ptt.c
>  create mode 100644 drivers/hwtracing/ptt/hisi_ptt.h
>  create mode 100644 tools/perf/arch/arm64/util/hisi_ptt.c
>  create mode 100644 tools/perf/util/hisi-ptt-decoder/Build
>  create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
>  create mode 100644 tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h
>  create mode 100644 tools/perf/util/hisi_ptt.c
>  create mode 100644 tools/perf/util/hisi_ptt.h
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
