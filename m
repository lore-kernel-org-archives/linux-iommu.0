Return-Path: <SRS0=j2S/=HZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7D3C433E6
	for <iommu@archiver.kernel.org>; Tue, 23 Feb 2021 21:07:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5158664E7A
	for <iommu@archiver.kernel.org>; Tue, 23 Feb 2021 21:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5158664E7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 15FCB43022;
	Tue, 23 Feb 2021 21:07:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2CdqeE0G4CSM; Tue, 23 Feb 2021 21:07:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id E995043020;
	Tue, 23 Feb 2021 21:07:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF7C6C000A;
	Tue, 23 Feb 2021 21:07:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2610C0001
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 21:07:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 83FF482499
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 21:07:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qJc0OvYa8iRH for <iommu@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 21:06:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A581782451
 for <iommu@lists.linux-foundation.org>; Tue, 23 Feb 2021 21:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614114418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9kNr7EDAQKPU8oHDhoTScTG4mkskUA05gLxOGxePE1A=;
 b=QMV5Vux2U2NN1NVLvXNq/sbqxVlmQY50yc+YZRoDSX2sERZaTmcjT8EzsWl2QznVXVJs59
 YQEYKlEnT3OW/aN8bEw6HSRrtC/or++hy50ma993A5cWQJ4j/MqewXud5IgXRvZq2RO8sH
 kXf5J6pCj64TzOgfpLcc3yi6VKOMYXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-Eq7_OEhDPGm7tTbforqMow-1; Tue, 23 Feb 2021 16:06:54 -0500
X-MC-Unique: Eq7_OEhDPGm7tTbforqMow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F05880196C;
 Tue, 23 Feb 2021 21:06:51 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-34.ams2.redhat.com [10.36.114.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8286D5D9D0;
 Tue, 23 Feb 2021 21:06:45 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, will@kernel.org,
 maz@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 alex.williamson@redhat.com, tn@semihalf.com, zhukeqian1@huawei.com
Subject: [PATCH v12 03/13] vfio: VFIO_IOMMU_SET_MSI_BINDING
Date: Tue, 23 Feb 2021 22:06:15 +0100
Message-Id: <20210223210625.604517-4-eric.auger@redhat.com>
In-Reply-To: <20210223210625.604517-1-eric.auger@redhat.com>
References: <20210223210625.604517-1-eric.auger@redhat.com>
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

This patch adds the VFIO_IOMMU_SET_MSI_BINDING ioctl which aim
to (un)register the guest MSI binding to the host. This latter
then can use those stage 1 bindings to build a nested stage
binding targeting the physical MSIs.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v11 -> v12:
- Share VFIO_BASE + 20 with VFIO_IOMMU_SPAPR_TCE_REMOVE
- rework returned values

v10 -> v11:
- renamed ustruct into msi_binding
- return 0 on unbind

v8 -> v9:
- merge VFIO_IOMMU_BIND_MSI/VFIO_IOMMU_UNBIND_MSI into a single
  VFIO_IOMMU_SET_MSI_BINDING ioctl
- ioctl id changed

v6 -> v7:
- removed the dev arg

v3 -> v4:
- add UNBIND
- unwind on BIND error

v2 -> v3:
- adapt to new proto of bind_guest_msi
- directly use vfio_iommu_for_each_dev

v1 -> v2:
- s/vfio_iommu_type1_guest_msi_binding/vfio_iommu_type1_bind_guest_msi
---
 drivers/vfio/vfio_iommu_type1.c | 62 +++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h       | 20 +++++++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index b4057ce809b0..0e6af4fe8c3d 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2655,6 +2655,41 @@ static int vfio_cache_inv_fn(struct device *dev, void *data)
 	return iommu_uapi_cache_invalidate(dc->domain, dev, (void __user *)arg);
 }
 
+static int
+vfio_bind_msi(struct vfio_iommu *iommu,
+	      dma_addr_t giova, phys_addr_t gpa, size_t size)
+{
+	struct vfio_domain *d;
+	int ret = 0;
+
+	mutex_lock(&iommu->lock);
+
+	list_for_each_entry(d, &iommu->domain_list, next) {
+		ret = iommu_bind_guest_msi(d->domain, giova, gpa, size);
+		if (ret)
+			goto unwind;
+	}
+	goto unlock;
+unwind:
+	list_for_each_entry_continue_reverse(d, &iommu->domain_list, next) {
+		iommu_unbind_guest_msi(d->domain, giova);
+	}
+unlock:
+	mutex_unlock(&iommu->lock);
+	return ret;
+}
+
+static void
+vfio_unbind_msi(struct vfio_iommu *iommu, dma_addr_t giova)
+{
+	struct vfio_domain *d;
+
+	mutex_lock(&iommu->lock);
+	list_for_each_entry(d, &iommu->domain_list, next)
+		iommu_unbind_guest_msi(d->domain, giova);
+	mutex_unlock(&iommu->lock);
+}
+
 static int vfio_iommu_migration_build_caps(struct vfio_iommu *iommu,
 					   struct vfio_info_cap *caps)
 {
@@ -2859,6 +2894,31 @@ static int vfio_iommu_type1_cache_invalidate(struct vfio_iommu *iommu,
 	return ret;
 }
 
+static int vfio_iommu_type1_set_msi_binding(struct vfio_iommu *iommu,
+					    unsigned long arg)
+{
+	struct vfio_iommu_type1_set_msi_binding msi_binding;
+	unsigned long minsz;
+
+	minsz = offsetofend(struct vfio_iommu_type1_set_msi_binding,
+			    size);
+
+	if (copy_from_user(&msi_binding, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (msi_binding.argsz < minsz)
+		return -EINVAL;
+
+	if (msi_binding.flags == VFIO_IOMMU_UNBIND_MSI) {
+		vfio_unbind_msi(iommu, msi_binding.iova);
+		return 0;
+	} else if (msi_binding.flags == VFIO_IOMMU_BIND_MSI) {
+		return vfio_bind_msi(iommu, msi_binding.iova,
+				     msi_binding.gpa, msi_binding.size);
+	}
+	return -EINVAL;
+}
+
 static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
 					unsigned long arg)
 {
@@ -2983,6 +3043,8 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
 		return vfio_iommu_type1_set_pasid_table(iommu, arg);
 	case VFIO_IOMMU_CACHE_INVALIDATE:
 		return vfio_iommu_type1_cache_invalidate(iommu, arg);
+	case VFIO_IOMMU_SET_MSI_BINDING:
+		return vfio_iommu_type1_set_msi_binding(iommu, arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index ee6747ff8006..4c82e8f21618 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1213,6 +1213,26 @@ struct vfio_iommu_type1_cache_invalidate {
 };
 #define VFIO_IOMMU_CACHE_INVALIDATE      _IO(VFIO_TYPE, VFIO_BASE + 19)
 
+/**
+ * VFIO_IOMMU_SET_MSI_BINDING - _IOWR(VFIO_TYPE, VFIO_BASE + 20,
+ *			struct vfio_iommu_type1_set_msi_binding)
+ *
+ * Pass a stage 1 MSI doorbell mapping to the host so that this
+ * latter can build a nested stage2 mapping. Or conversely tear
+ * down a previously bound stage 1 MSI binding.
+ */
+struct vfio_iommu_type1_set_msi_binding {
+	__u32   argsz;
+	__u32   flags;
+#define VFIO_IOMMU_BIND_MSI	(1 << 0)
+#define VFIO_IOMMU_UNBIND_MSI	(1 << 1)
+	__u64	iova;	/* MSI guest IOVA */
+	/* Fields below are used on BIND */
+	__u64	gpa;	/* MSI guest physical address */
+	__u64	size;	/* size of stage1 mapping (bytes) */
+};
+#define VFIO_IOMMU_SET_MSI_BINDING      _IO(VFIO_TYPE, VFIO_BASE + 20)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
