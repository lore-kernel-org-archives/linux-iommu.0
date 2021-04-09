Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C112C43460
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 03:44:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B09D6115C
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 03:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B09D6115C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FCDC419B6;
	Fri,  9 Apr 2021 03:44:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OesPcEXHephf; Fri,  9 Apr 2021 03:44:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5969419C9;
	Fri,  9 Apr 2021 03:44:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8D6AC0019;
	Fri,  9 Apr 2021 03:44:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F685C000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 03:44:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1EB708487C
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 03:44:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oYqmH2mFnvUp for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 03:44:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8BE378487B
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 03:44:44 +0000 (UTC)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGkTF20x7znZ7c;
 Fri,  9 Apr 2021 11:41:53 +0800 (CST)
Received: from DESKTOP-7FEPK9S.china.huawei.com (10.174.184.135) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 11:44:30 +0800
From: Shenming Lu <lushenming@huawei.com>
To: Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Eric Auger <eric.auger@redhat.com>,
 <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux-foundation.org>,
 <linux-api@vger.kernel.org>
Subject: [RFC PATCH v3 0/8] Add IOPF support for VFIO passthrough
Date: Fri, 9 Apr 2021 11:44:12 +0800
Message-ID: <20210409034420.1799-1-lushenming@huawei.com>
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

Requesting for your comments and suggestions. :-)

The static pinning and mapping problem in VFIO and possible solutions
have been discussed a lot [1, 2]. One of the solutions is to add I/O
Page Fault support for VFIO devices. Different from those relatively
complicated software approaches such as presenting a vIOMMU that provides
the DMA buffer information (might include para-virtualized optimizations),
IOPF mainly depends on the hardware faulting capability, such as the PCIe
PRI extension or Arm SMMU stall model. What's more, the IOPF support in
the IOMMU driver has already been implemented in SVA [3]. So we add IOPF
support for VFIO passthrough based on the IOPF part of SVA in this series.

We have measured its performance with UADK [4] (passthrough an accelerator
to a VM(1U16G)) on Hisilicon Kunpeng920 board (and compared with host SVA):

Run hisi_sec_test...
 - with varying sending times and message lengths
 - with/without IOPF enabled (speed slowdown)

when msg_len = 1MB (and PREMAP_LEN (in Patch 4) = 1):
            slowdown (num of faults)
 times      VFIO IOPF      host SVA
 1          63.4% (518)    82.8% (512)
 100        22.9% (1058)   47.9% (1024)
 1000       2.6% (1071)    8.5% (1024)

when msg_len = 10MB (and PREMAP_LEN = 512):
            slowdown (num of faults)
 times      VFIO IOPF
 1          32.6% (13)
 100        3.5% (26)
 1000       1.6% (26)

History:

v2 -> v3
 - Nit fixes.
 - No reason to disable reporting the unrecoverable faults. (baolu)
 - Maintain a global IOPF enabled group list.
 - Split the pre-mapping optimization to be a separate patch.
 - Add selective faulting support (use vfio_pin_pages to indicate the
   non-faultable scope and add a new struct vfio_range to record it,
   untested). (Kevin)

v1 -> v2
 - Numerous improvements following the suggestions. Thanks a lot to all
   of you.

Note that PRI is not supported at the moment since there is no hardware.

Links:
[1] Lesokhin I, et al. Page Fault Support for Network Controllers. In ASPLOS,
    2016.
[2] Tian K, et al. coIOMMU: A Virtual IOMMU with Cooperative DMA Buffer Tracking
    for Efficient Memory Management in Direct I/O. In USENIX ATC, 2020.
[3] https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210401154718.307519-1-jean-philippe@linaro.org/
[4] https://github.com/Linaro/uadk

Thanks,
Shenming


Shenming Lu (8):
  iommu: Evolve the device fault reporting framework
  vfio/type1: Add a page fault handler
  vfio/type1: Add an MMU notifier to avoid pinning
  vfio/type1: Pre-map more pages than requested in the IOPF handling
  vfio/type1: VFIO_IOMMU_ENABLE_IOPF
  vfio/type1: No need to statically pin and map if IOPF enabled
  vfio/type1: Add selective DMA faulting support
  vfio: Add nested IOPF support

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |    3 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   18 +-
 drivers/iommu/iommu.c                         |   56 +-
 drivers/vfio/vfio.c                           |   85 +-
 drivers/vfio/vfio_iommu_type1.c               | 1000 ++++++++++++++++-
 include/linux/iommu.h                         |   19 +-
 include/linux/vfio.h                          |   13 +
 include/uapi/linux/iommu.h                    |    4 +
 include/uapi/linux/vfio.h                     |    6 +
 9 files changed, 1181 insertions(+), 23 deletions(-)

-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
