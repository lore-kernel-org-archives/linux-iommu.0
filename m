Return-Path: <SRS0=3R3A=5H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A6EC54FD2
	for <iommu@archiver.kernel.org>; Sun, 22 Mar 2020 12:26:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 180A620769
	for <iommu@archiver.kernel.org>; Sun, 22 Mar 2020 12:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180A620769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AABAD864E6;
	Sun, 22 Mar 2020 12:26:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r90LEBOJpldp; Sun, 22 Mar 2020 12:26:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1B42A864B5;
	Sun, 22 Mar 2020 12:26:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC2E0C1D89;
	Sun, 22 Mar 2020 12:26:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE255C0177
 for <iommu@lists.linux-foundation.org>; Sun, 22 Mar 2020 12:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C521F864D4
 for <iommu@lists.linux-foundation.org>; Sun, 22 Mar 2020 12:26:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0W-PRf8cveVO for <iommu@lists.linux-foundation.org>;
 Sun, 22 Mar 2020 12:26:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9A585865B0
 for <iommu@lists.linux-foundation.org>; Sun, 22 Mar 2020 12:26:24 +0000 (UTC)
IronPort-SDR: WsEIIhhU1BFhe9SheUvE8dN6nogRPcccfPr3iFoTF67lFUf5AjQlRujuYB+IbSO666lCS9sRMD
 5yKSJXC+gN5A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2020 05:26:23 -0700
IronPort-SDR: oDhKabdEgKGFhpjlxoqmAbyif2PuoUrVoTpudwxrGw3kcsSiW5nnR6w8cuyypgFXvymAR4fuLf
 dUBxviObXjeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,292,1580803200"; d="scan'208";a="239663874"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 22 Mar 2020 05:26:23 -0700
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: alex.williamson@redhat.com,
	eric.auger@redhat.com
Subject: [PATCH v1 4/8] vfio: Check nesting iommu uAPI version
Date: Sun, 22 Mar 2020 05:32:01 -0700
Message-Id: <1584880325-10561-5-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, jun.j.tian@intel.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, yi.y.sun@intel.com, hao.wu@intel.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Liu Yi L <yi.l.liu@intel.com>

In Linux Kernel, the IOMMU nesting translation (a.k.a dual stage address
translation) capability is abstracted in uapi/iommu.h, in which the uAPIs
like bind_gpasid/iommu_cache_invalidate/fault_report/pgreq_resp are defined.

VFIO_TYPE1_NESTING_IOMMU stands for the vfio iommu type which is backed by
hardware IOMMU w/ dual stage translation capability. For such vfio iommu
type, userspace is able to setup dual stage DMA translation in host side
via VFIO's ABI. However, such VFIO ABIs rely on the uAPIs defined in uapi/
iommu.h. So VFIO needs to provide an API to userspace for the uapi/iommu.h
version check to ensure the iommu uAPI compatibility.

This patch reports the iommu uAPI version to userspace in VFIO_CHECK_EXTENSION
IOCTL. Applications could do version check before further setup dual stage
translation in host IOMMU.

Cc: Kevin Tian <kevin.tian@intel.com>
CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 2 ++
 include/uapi/linux/vfio.h       | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index ddd1ffe..9aa2a67 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2274,6 +2274,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 			if (!iommu)
 				return 0;
 			return vfio_domains_have_iommu_cache(iommu);
+		case VFIO_NESTING_IOMMU_UAPI:
+			return iommu_get_uapi_version();
 		default:
 			return 0;
 		}
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 8837219..ed9881d 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -47,6 +47,15 @@
 #define VFIO_NOIOMMU_IOMMU		8
 
 /*
+ * Hardware IOMMUs with two-stage translation capability give userspace
+ * the ownership of stage-1 translation structures (e.g. page tables).
+ * VFIO exposes the two-stage IOMMU programming capability to userspace
+ * based on the IOMMU UAPIs. Therefore user of VFIO_TYPE1_NESTING should
+ * check the IOMMU UAPI version compatibility.
+ */
+#define VFIO_NESTING_IOMMU_UAPI		9
+
+/*
  * The IOCTL interface is designed for extensibility by embedding the
  * structure length (argsz) and flags into structures passed between
  * kernel and userspace.  We therefore use the _IO() macro for these
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
