Return-Path: <SRS0=6QSB=IH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8CAC43381
	for <iommu@archiver.kernel.org>; Tue,  9 Mar 2021 06:22:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 665A0652A4
	for <iommu@archiver.kernel.org>; Tue,  9 Mar 2021 06:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 665A0652A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 399B640158;
	Tue,  9 Mar 2021 06:22:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lHQE-0KVqHi4; Tue,  9 Mar 2021 06:22:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 253AE40166;
	Tue,  9 Mar 2021 06:22:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12006C000A;
	Tue,  9 Mar 2021 06:22:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08A4AC0001
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 06:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC33749999
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 06:22:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YmXwF_R8YEAR for <iommu@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 06:22:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A0954489E0
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 06:22:22 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DvlSc1YQGz8vRm;
 Tue,  9 Mar 2021 14:20:32 +0800 (CST)
Received: from DESKTOP-7FEPK9S.china.huawei.com (10.174.184.135) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Mar 2021 14:22:11 +0800
From: Shenming Lu <lushenming@huawei.com>
To: Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Eric Auger <eric.auger@redhat.com>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux-foundation.org>,
 <linux-api@vger.kernel.org>
Subject: [RFC PATCH v2 0/6] Add IOPF support for VFIO passthrough
Date: Tue, 9 Mar 2021 14:22:01 +0800
Message-ID: <20210309062207.505-1-lushenming@huawei.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.174.184.135]
X-CFilter-Loop: Reflected
Cc: Kevin Tian <kevin.tian@intel.com>, Christoph Hellwig <hch@infradead.org>,
 lushenming@huawei.com, wanghaibin.wang@huawei.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

The static pinning and mapping problem in VFIO and possible solutions
have been discussed a lot [1, 2]. One of the solutions is to add I/O
page fault support for VFIO devices. Different from those relatively
complicated software approaches such as presenting a vIOMMU that provides
the DMA buffer information (might include para-virtualized optimizations),
IOPF mainly depends on the hardware faulting capability, such as the PCIe
PRI extension or Arm SMMU stall model. What's more, the IOPF support in
the IOMMU driver is being implemented in SVA [3]. So we add IOPF support
for VFIO passthrough based on the IOPF part of SVA in this series.

We have measured its performance with UADK [4] (passthrough an accelerator
to a VM) on Hisilicon Kunpeng920 board:

Run hisi_sec_test...
 - with varying message lengths and sending times
 - with/without stage 2 IOPF enabled

when msg_len = 1MB and PREMAP_LEN (in patch 3) = 1:
           speed (KB/s)
 times     w/o IOPF        with IOPF (num of faults)        degradation
 1         325596          119152 (518)                     36.6%
 100       7524985         5804659 (1058)                   77.1%
 1000      8661817         8440209 (1071)                   97.4%
 5000      8804512         8724368 (1216)                   99.1%

If we use the same region to send messages, since page faults occur almost
only when first accessing, more times, less degradation.

when msg_len = 10MB and PREMAP_LEN = 512:
           speed (KB/s)
 times     w/o IOPF        with IOPF (num of faults)        degradation
 1         1012758         682257 (13)                      67.4%
 100       8680688         8374154 (26)                     96.5%
 1000      8860861         8719918 (26)                     98.4%

We see that pre-mapping can help.

And we also measured the performance of host SVA with the same params:

when msg_len = 1MB:
           speed (KB/s)
 times     w/o IOPF        with IOPF (num of faults)        degradation
 1         951672          163866 (512)                     17.2%
 100       8691961         4529971 (1024)                   52.1%
 1000      9158721         8376346 (1024)                   91.5%
 5000      9184532         9008739 (1024)                   98.1%

Besides, the avg time spent in vfio_iommu_dev_fault_handler() (in patch 3)
is little less than iopf_handle_group() (in SVA) (1.6 us vs 2.0 us).

History:

v1 -> v2
 - Numerous improvements following the suggestions. Thanks a lot to all
   of you.

Yet TODO:
 - Add support for PRI.
 - Consider selective-faulting. (suggested by Kevin)
 ...

Links:
[1] Lesokhin I, et al. Page Fault Support for Network Controllers. In ASPLOS,
    2016.
[2] Tian K, et al. coIOMMU: A Virtual IOMMU with Cooperative DMA Buffer Tracking
    for Efficient Memory Management in Direct I/O. In USENIX ATC, 2020.
[3] https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210302092644.2553014-1-jean-philippe@linaro.org/
[4] https://github.com/Linaro/uadk

Any comments and suggestions are very welcome. :-)

Thanks,
Shenming


Shenming Lu (6):
  iommu: Evolve to support more scenarios of using IOPF
  vfio: Add an MMU notifier to avoid pinning
  vfio: Add a page fault handler
  vfio: VFIO_IOMMU_ENABLE_IOPF
  vfio: No need to statically pin and map if IOPF enabled
  vfio: Add nested IOPF support

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   3 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  11 +-
 drivers/iommu/io-pgfault.c                    |   4 -
 drivers/iommu/iommu.c                         |  56 ++-
 drivers/vfio/vfio.c                           | 118 +++++
 drivers/vfio/vfio_iommu_type1.c               | 446 +++++++++++++++++-
 include/linux/iommu.h                         |  21 +-
 include/linux/vfio.h                          |  14 +
 include/uapi/linux/iommu.h                    |   3 +
 include/uapi/linux/vfio.h                     |   6 +
 10 files changed, 661 insertions(+), 21 deletions(-)

-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
