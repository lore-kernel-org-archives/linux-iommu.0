Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C4DC433DB
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 20:00:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15F064DA4
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 20:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15F064DA4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7A2D486C1A;
	Wed, 27 Jan 2021 20:00:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ovh0fQVNzZ+g; Wed, 27 Jan 2021 20:00:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B1DF186C0E;
	Wed, 27 Jan 2021 20:00:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3718C08A1;
	Wed, 27 Jan 2021 20:00:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA26EC013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 20:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 98F89861F0
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 20:00:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZQOC8W0wI2Ch for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 20:00:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 73099861D7
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 20:00:21 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D7AD64DA4;
 Wed, 27 Jan 2021 20:00:20 +0000 (UTC)
Subject: [PATCH RFC 0/9] Possible set of VT-d optimizations
From: Chuck Lever <chuck.lever@oracle.com>
To: baolu.lu@linux.intel.com
Date: Wed, 27 Jan 2021 15:00:19 -0500
Message-ID: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Cc: isaacm@codeaurora.org, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org, will@kernel.org
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

Hi-

This collection of patches seems to get the best throughtput results
so far. The NFS WRITE result is fully restored, and the NFS READ
result is very close to fully restored.

	Children see throughput for 12 initial writers  = 5008474.03 kB/sec
	Parent sees throughput for 12 initial writers   = 4996927.80 kB/sec
	Min throughput per process                      = 416956.88 kB/sec 
	Max throughput per process                      = 417910.22 kB/sec
	Avg throughput per process                      = 417372.84 kB/sec
	Min xfer                                        = 1046272.00 kB
	CPU Utilization: Wall time    2.515    CPU time    1.996    CPU utilization  79.37 %


	Children see throughput for 12 rewriters        = 5020584.59 kB/sec
	Parent sees throughput for 12 rewriters         = 5012539.29 kB/sec
	Min throughput per process                      = 417799.00 kB/sec 
	Max throughput per process                      = 419082.22 kB/sec
	Avg throughput per process                      = 418382.05 kB/sec
	Min xfer                                        = 1046528.00 kB
	CPU utilization: Wall time    2.507    CPU time    2.024    CPU utilization  80.73 %


	Children see throughput for 12 readers          = 5805484.25 kB/sec
	Parent sees throughput for 12 readers           = 5799535.68 kB/sec
	Min throughput per process                      = 482888.16 kB/sec 
	Max throughput per process                      = 484444.16 kB/sec
	Avg throughput per process                      = 483790.35 kB/sec
	Min xfer                                        = 1045760.00 kB
	CPU utilization: Wall time    2.167    CPU time    1.964    CPU utilization  90.63 %


	Children see throughput for 12 re-readers       = 5812227.16 kB/sec
	Parent sees throughput for 12 re-readers        = 5803793.06 kB/sec
	Min throughput per process                      = 483242.97 kB/sec 
	Max throughput per process                      = 485724.41 kB/sec
	Avg throughput per process                      = 484352.26 kB/sec
	Min xfer                                        = 1043456.00 kB
	CPU utilization: Wall time    2.161    CPU time    1.976    CPU utilization  91.45 %

I've included a simple-minded implementation of a map_sg op for
the Intel IOMMU. This is nothing more than a copy of the loop in
__iommu_map_sg() with the call to __iommu_map() replaced with a
call to intel_iommu_map().

---

Chuck Lever (1):
      iommu/vt-d: Introduce map_sg() for Intel IOMMUs

Isaac J. Manjarres (5):
      iommu/io-pgtable: Introduce map_sg() as a page table op
      iommu/io-pgtable-arm: Hook up map_sg()
      iommu/io-pgtable-arm-v7s: Hook up map_sg()
      iommu: Introduce map_sg() as an IOMMU op for IOMMU drivers
      iommu/arm-smmu: Hook up map_sg()

Lu Baolu (1):
      iommu/vt-d: Add iotlb_sync_map callback

Yong Wu (2):
      iommu: Move iotlb_sync_map out from __iommu_map
      iommu: Add iova and size as parameters in iotlb_sync_map


 drivers/iommu/arm/arm-smmu/arm-smmu.c |  19 ++++
 drivers/iommu/intel/iommu.c           | 131 ++++++++++++++++++++------
 drivers/iommu/io-pgtable-arm-v7s.c    |  90 ++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c        |  86 +++++++++++++++++
 drivers/iommu/iommu.c                 |  47 +++++++--
 drivers/iommu/tegra-gart.c            |   7 +-
 include/linux/iommu.h                 |  16 +++-
 7 files changed, 353 insertions(+), 43 deletions(-)

--
Chuck Lever

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
