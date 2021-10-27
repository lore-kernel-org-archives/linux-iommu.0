Return-Path: <SRS0=XM0R=PP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF0DC4332F
	for <iommu@archiver.kernel.org>; Wed, 27 Oct 2021 10:45:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C16610A0
	for <iommu@archiver.kernel.org>; Wed, 27 Oct 2021 10:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 17C16610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C47104019E;
	Wed, 27 Oct 2021 10:45:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d-EkcM04Zm16; Wed, 27 Oct 2021 10:45:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5965B4013F;
	Wed, 27 Oct 2021 10:45:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BFADC0019;
	Wed, 27 Oct 2021 10:45:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3E7AC000E
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 10:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C7964019E
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 10:44:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WyYqmJuLrb83 for <iommu@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 10:44:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F4C84013F
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 10:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635331496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=J5wkNJA4/lA1zpS1Ea7vtbcReRVBjOp0e4WxjwmsxNM=;
 b=XfD0WeBydhiAEpHO0oLN4K2i6XXPc7CtJHw91VVMzI80tNAgJzAdbAjesiZnc6BGO17e2c
 SpbngiNjZnLq+Gl2pZSaAOmJtu305b+2AfqsuOA1ZpTp5opbkpNQ1TqQWhu8F/TTKV6RvB
 wpTqvFhZw2IQMFZJzxxbmEQLJ7soMws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-kAK16uk_N5C6alI-CsSs_g-1; Wed, 27 Oct 2021 06:44:52 -0400
X-MC-Unique: kAK16uk_N5C6alI-CsSs_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCC5A19200C0;
 Wed, 27 Oct 2021 10:44:48 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95422100E12D;
 Wed, 27 Oct 2021 10:44:32 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org,
 zhukeqian1@huawei.com
Subject: [RFC v16 0/9] SMMUv3 Nested Stage Setup (IOMMU part)
Date: Wed, 27 Oct 2021 12:44:19 +0200
Message-Id: <20211027104428.1059740-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 maz@kernel.org, vivek.gautam@arm.com, alex.williamson@redhat.com,
 vsethi@nvidia.com, zhangfei.gao@linaro.org, lushenming@huawei.com,
 wangxingang5@huawei.com
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

This series brings the IOMMU part of HW nested paging support
in the SMMUv3.

The SMMUv3 driver is adapted to support 2 nested stages.

The IOMMU API is extended to convey the guest stage 1
configuration and the hook is implemented in the SMMUv3 driver.

This allows the guest to own the stage 1 tables and context
descriptors (so-called PASID table) while the host owns the
stage 2 tables and main configuration structures (STE).

This work mainly is provided for test purpose as the upper
layer integration is under rework and bound to be based on
/dev/iommu instead of VFIO tunneling. In this version we also get
rid of the MSI BINDING ioctl, assuming the guest enforces
flat mapping of host IOVAs used to bind physical MSI doorbells.
In the current QEMU integration this is achieved by exposing
RMRs to the guest, using Shameer's series [1]. This approach
is RFC as the IORT spec is not really meant to do that
(single mapping flag limitation).

Best Regards

Eric

This series (Host) can be found at:
https://github.com/eauger/linux/tree/v5.15-rc7-nested-v16
This includes a rebased VFIO integration (although not meant
to be upstreamed)

Guest kernel branch can be found at:
https://github.com/eauger/linux/tree/shameer_rmrr_v7
featuring [1]

QEMU integration (still based on VFIO and exposing RMRs)
can be found at:
https://github.com/eauger/qemu/tree/v6.1.0-rmr-v2-nested_smmuv3_v10
(use iommu=nested-smmuv3 ARM virt option)

Guest dependency:
[1] [PATCH v7 0/9] ACPI/IORT: Support for IORT RMR node

History:

v15 -> v16:
- guest RIL must support RIL
- additional checks in the cache invalidation hook
- removal of the MSI BINDING ioctl (tentative replacement
  by RMRs)


Eric Auger (9):
  iommu: Introduce attach/detach_pasid_table API
  iommu: Introduce iommu_get_nesting
  iommu/smmuv3: Allow s1 and s2 configs to coexist
  iommu/smmuv3: Get prepared for nested stage support
  iommu/smmuv3: Implement attach/detach_pasid_table
  iommu/smmuv3: Allow stage 1 invalidation with unmanaged ASIDs
  iommu/smmuv3: Implement cache_invalidate
  iommu/smmuv3: report additional recoverable faults
  iommu/smmuv3: Disallow nested mode in presence of HW MSI regions

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 383 ++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  14 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |   8 +
 drivers/iommu/intel/iommu.c                 |  13 +
 drivers/iommu/iommu.c                       |  79 ++++
 include/linux/iommu.h                       |  35 ++
 include/uapi/linux/iommu.h                  |  54 +++
 7 files changed, 548 insertions(+), 38 deletions(-)

-- 
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
