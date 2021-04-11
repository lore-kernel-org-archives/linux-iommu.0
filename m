Return-Path: <SRS0=/53O=JI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007C9C43460
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 11:13:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D05E611AD
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 11:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D05E611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43140839CF;
	Sun, 11 Apr 2021 11:13:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j0gxmNmgDur4; Sun, 11 Apr 2021 11:12:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0A48839BD;
	Sun, 11 Apr 2021 11:12:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8975C000C;
	Sun, 11 Apr 2021 11:12:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 550D1C000A
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 11:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F60140386
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 11:12:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ugL-1w8k04zV for <iommu@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 11:12:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5FE1140385
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 11:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618139573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VZ5ZgqkLKGzZ6mZcaLAP7WgqAO/FhHDbjCu61E17AlI=;
 b=Q6jshScRkg03K8KhCPXDs26Qadk36hUyLsXSZQPMWVg4rL/o60CLtvTLQEhiumW47MHsg+
 o8B99VJnNvsel9FDAoX12P6vHWmVtbbquXGH1/VD7hoPi2Lvzh4iLPfLN9wgrM+GkekILK
 EhExRGFvpxJD1LNp5sSg1cr0wjLVe6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-Lz5o6dudMNmUzPQlCMbKnQ-1; Sun, 11 Apr 2021 07:12:51 -0400
X-MC-Unique: Lz5o6dudMNmUzPQlCMbKnQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61CFD107ACC7;
 Sun, 11 Apr 2021 11:12:48 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-22.ams2.redhat.com [10.36.112.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B064C100164A;
 Sun, 11 Apr 2021 11:12:32 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 maz@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 alex.williamson@redhat.com, tn@semihalf.com, zhukeqian1@huawei.com
Subject: [PATCH v15 00/12] SMMUv3 Nested Stage Setup (IOMMU part)
Date: Sun, 11 Apr 2021 13:12:16 +0200
Message-Id: <20210411111228.14386-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: jean-philippe@linaro.org, wangxingang5@huawei.com, lushenming@huawei.com,
 vivek.gautam@arm.com, vsethi@nvidia.com, zhangfei.gao@linaro.org,
 jiangkunkun@huawei.com
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

SMMUv3 Nested Stage Setup (IOMMU part)

This series brings the IOMMU part of HW nested paging support
in the SMMUv3. The VFIO part is submitted separately.

This is based on Jean-Philippe's
[PATCH v14 00/10] iommu: I/O page faults for SMMUv3
https://www.spinics.net/lists/arm-kernel/msg886518.html
(including the patches that were not pulled for 5.13)

The IOMMU API is extended to support 2 new API functionalities:
1) pass the guest stage 1 configuration
2) pass stage 1 MSI bindings

Then those capabilities gets implemented in the SMMUv3 driver.

The virtualizer passes information through the VFIO user API
which cascades them to the iommu subsystem. This allows the guest
to own stage 1 tables and context descriptors (so-called PASID
table) while the host owns stage 2 tables and main configuration
structures (STE).

Best Regards

Eric

This series can be found at:
v5.12-rc6-jean-iopf-14-2stage-v15
(including the VFIO part in its last version: v13)

The VFIO series is sent separately.

History:

Previous version:
https://github.com/eauger/linux/tree/v5.11-stallv12-2stage-v14

v14 -> v15:
- on S1 invalidation, always use CMDQ_OP_TLBI_NH_VA
  independently on host ARM_SMMU_FEAT_E2H support (Zenghui)
- remove  iommu/smmuv3: Accept configs with more than one
  context descriptor
- Remove spurious arm_smmu_cmdq_issue_sync in
  IOMMU_INV_GRANU_ADDR cache invalidation (Zenghui)
- dma-iommu.c changes induced by Zenghui's comments
  including the locking rework
- fix cache invalidation when guest uses RIL
  and host does not support it (Chenxiang)
- removed iommu/smmuv3: Accept configs with more than one
  context descriptor (Zenghui, Shameer)
- At this point I have kept the MSI binding API.

v13 -> v14:
- Took into account all received comments I think. Great
  thanks to all the testers for their effort and sometimes
  tentative fixes. I am really grateful to you!
- numerous fixes including guest running in
  noiommu, iommu.strict=0, iommu.passthrough=on,
  enable_unsafe_noiommu_mode

v12 -> v13:
- fixed compilation issue with CONFIG_ARM_SMMU_V3_SVA
  reported by Shameer. This urged me to revisit patch 4 into
  iommu/smmuv3: Allow s1 and s2 configs to coexist where
  s1_cfg and s2_cfg are not dynamically allocated anymore.
  Instead I use a new set field in existing structs
- fixed 2 others config checks
- Updated "iommu/arm-smmu-v3: Maintain a SID->device structure"
  according to the last version

v11 -> v12:
- rebase on top of v5.10-rc4


Eric Auger (12):
  iommu: Introduce attach/detach_pasid_table API
  iommu: Introduce bind/unbind_guest_msi
  iommu/smmuv3: Allow s1 and s2 configs to coexist
  iommu/smmuv3: Get prepared for nested stage support
  iommu/smmuv3: Implement attach/detach_pasid_table
  iommu/smmuv3: Allow stage 1 invalidation with unmanaged ASIDs
  iommu/smmuv3: Implement cache_invalidate
  dma-iommu: Implement NESTED_MSI cookie
  iommu/smmuv3: Nested mode single MSI doorbell per domain enforcement
  iommu/smmuv3: Enforce incompatibility between nested mode and HW MSI
    regions
  iommu/smmuv3: Implement bind/unbind_guest_msi
  iommu/smmuv3: report additional recoverable faults

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 463 ++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  14 +-
 drivers/iommu/dma-iommu.c                   | 180 +++++++-
 drivers/iommu/iommu.c                       | 106 +++++
 include/linux/dma-iommu.h                   |  16 +
 include/linux/iommu.h                       |  47 ++
 include/uapi/linux/iommu.h                  |  54 +++
 7 files changed, 838 insertions(+), 42 deletions(-)

-- 
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
