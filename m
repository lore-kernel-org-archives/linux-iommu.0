Return-Path: <SRS0=j2S/=HZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEF7C433E6
	for <iommu@archiver.kernel.org>; Tue, 23 Feb 2021 20:57:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C28564E83
	for <iommu@archiver.kernel.org>; Tue, 23 Feb 2021 20:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C28564E83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01D1D83B2E;
	Tue, 23 Feb 2021 20:57:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kf8BEXruyvor; Tue, 23 Feb 2021 20:57:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF6A983B30;
	Tue, 23 Feb 2021 20:57:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBE49C000B;
	Tue, 23 Feb 2021 20:57:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67E56C0001
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 20:57:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4938C4E4BC
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 20:57:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T_AH1ojzztzP for <iommu@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 20:57:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 09F9B4E51E
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 20:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614113853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dspjyoruL6FYvLVfk5NSTgJZHzGM/NlapNw3ZfaV3DI=;
 b=dDXRyn1iILovwQMlccrdkAHryKMw9VxBMlhSoXG2CUGZ+d2hduoJK9mu02CRNuzt+pb1Pk
 gFmmdZy2QIe/zJQUz/blVgDLbo35h19Qj8oqAm8SxEVA83EjM6RYk05WgWIosz3UF/cj7Q
 Nmn+DCCF7HjPV26Si1kg49+lElPVsfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-iiKcvpHJP16wVJHD1fCK1Q-1; Tue, 23 Feb 2021 15:56:51 -0500
X-MC-Unique: iiKcvpHJP16wVJHD1fCK1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 306A3835E25;
 Tue, 23 Feb 2021 20:56:48 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-34.ams2.redhat.com [10.36.114.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6207F5D9D0;
 Tue, 23 Feb 2021 20:56:36 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 maz@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 alex.williamson@redhat.com, tn@semihalf.com, zhukeqian1@huawei.com
Subject: [PATCH v14 00/13] SMMUv3 Nested Stage Setup (IOMMU part)
Date: Tue, 23 Feb 2021 21:56:21 +0100
Message-Id: <20210223205634.604221-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: jean-philippe@linaro.org, wangxingang5@huawei.com, lushenming@huawei.com,
 jiangkunkun@huawei.com, vivek.gautam@arm.com, vsethi@nvidia.com,
 zhangfei.gao@linaro.org
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
in the SMMUv3. The VFIO part is submitted separately.

This is based on Jean-Philippe's
[PATCH v12 00/10] iommu: I/O page faults for SMMUv3
https://lore.kernel.org/linux-arm-kernel/YBfij71tyYvh8LhB@myrica/T/

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
https://github.com/eauger/linux/tree/v5.11-stallv12-2stage-v14
(including the VFIO part in its last version: v12)

The VFIO series is sent separately.

History:

Previous version (v13):
https://github.com/eauger/linux/tree/5.10-rc4-2stage-v13

v13 -> v14:
- Took into account all received comments I think. Great
  thanks to all the testers for their effort and sometimes
  fixes. I am really grateful to you!
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

Eric Auger (13):
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
  iommu/smmuv3: Accept configs with more than one context descriptor

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 444 ++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  14 +-
 drivers/iommu/dma-iommu.c                   | 142 ++++++-
 drivers/iommu/iommu.c                       | 106 +++++
 include/linux/dma-iommu.h                   |  16 +
 include/linux/iommu.h                       |  47 +++
 include/uapi/linux/iommu.h                  |  54 +++
 7 files changed, 781 insertions(+), 42 deletions(-)

-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
