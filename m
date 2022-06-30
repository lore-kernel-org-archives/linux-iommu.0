Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA34C43334
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 09:41:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26B626132A;
	Thu, 30 Jun 2022 09:41:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 26B626132A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BEtpPsj3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6c8IdiFivNa5; Thu, 30 Jun 2022 09:41:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C19DD61328;
	Thu, 30 Jun 2022 09:41:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C19DD61328
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5967C002D;
	Thu, 30 Jun 2022 09:41:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 841C7C0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 09:41:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 59FB98456F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 09:41:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 59FB98456F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BEtpPsj3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tcqt-w1Kbh7G for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 09:41:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 913218452F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 913218452F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 09:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656582071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FbuvANh9DPr+4RMnaRBYz0BK2bY3nTN9q2d37QGk4z4=;
 b=BEtpPsj3N2wA9a1O9mMXYi3ORv0RTugNqibquyu9kOgg7MlCDsbK0qyXJt3tVyK2a5kRZo
 xketj6cn5jjlbQxA//DQtXElqRl8KO3czIFTvl+GkUBjfU9pbSNWFBlOmgAaKWMMjXrmx9
 OwCbfaMe1wB3poA6gxRPhUdzFGX5jKA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-498-awS35iiSPmGd0csI-LWKIg-1; Thu, 30 Jun 2022 05:41:06 -0400
X-MC-Unique: awS35iiSPmGd0csI-LWKIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 601DC811E80;
 Thu, 30 Jun 2022 09:41:06 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C3DC2026D64;
 Thu, 30 Jun 2022 09:41:04 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, jean-philippe@linaro.org,
 jroedel@suse.de, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, rafael@kernel.org, lenb@kernel.org
Subject: [PATCH v2] ACPI: VIOT: Fix ACS setup
Date: Thu, 30 Jun 2022 11:40:59 +0200
Message-Id: <20220630094059.1204283-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, jinl@redhat.com
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

Currently acpi_viot_init() gets called after the pci
device has been scanned and pci_enable_acs() has been called.
So pci_request_acs() fails to be taken into account leading
to wrong single iommu group topologies when dealing with
multi-function root ports for instance.

We cannot simply move the acpi_viot_init() earlier, similarly
as the IORT init because the VIOT parsing relies on the pci
scan. However we can detect VIOT is present earlier and in
such a case, request ACS. Introduce a new acpi_viot_early_init()
routine that allows to call pci_request_acs() before the scan.

While at it, guard the call to pci_request_acs() with #ifdef
CONFIG_PCI.

Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Jin Liu <jinl@redhat.com>

---

v1 -> v2:
- guard acpi_viot_early_init() content with #ifdef CONFIG_PCI
- do not call acpi_put_table() if acpi_get_table() failed
- change declaration order of acpi_viot_early_init() stub
---
 drivers/acpi/bus.c        |  1 +
 drivers/acpi/viot.c       | 26 ++++++++++++++++++++------
 include/linux/acpi_viot.h |  2 ++
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 86fa61a21826..906ad8153fd9 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1400,6 +1400,7 @@ static int __init acpi_init(void)
 
 	pci_mmcfg_late_init();
 	acpi_iort_init();
+	acpi_viot_early_init();
 	acpi_hest_init();
 	acpi_ghes_init();
 	acpi_scan_init();
diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
index d2256326c73a..647f11cf165d 100644
--- a/drivers/acpi/viot.c
+++ b/drivers/acpi/viot.c
@@ -248,6 +248,26 @@ static int __init viot_parse_node(const struct acpi_viot_header *hdr)
 	return ret;
 }
 
+/**
+ * acpi_viot_early_init - Test the presence of VIOT and enable ACS
+ *
+ * If the VIOT does exist, ACS must be enabled. This cannot be
+ * done in acpi_viot_init() which is called after the bus scan
+ */
+void __init acpi_viot_early_init(void)
+{
+#ifdef CONFIG_PCI
+	acpi_status status;
+	struct acpi_table_header *hdr;
+
+	status = acpi_get_table(ACPI_SIG_VIOT, 0, &hdr);
+	if (ACPI_FAILURE(status))
+		return;
+	pci_request_acs();
+	acpi_put_table(hdr);
+#endif
+}
+
 /**
  * acpi_viot_init - Parse the VIOT table
  *
@@ -319,12 +339,6 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
 			epid = ((domain_nr - ep->segment_start) << 16) +
 				dev_id - ep->bdf_start + ep->endpoint_id;
 
-			/*
-			 * If we found a PCI range managed by the viommu, we're
-			 * the one that has to request ACS.
-			 */
-			pci_request_acs();
-
 			return viot_dev_iommu_init(&pdev->dev, ep->viommu,
 						   epid);
 		}
diff --git a/include/linux/acpi_viot.h b/include/linux/acpi_viot.h
index 1eb8ee5b0e5f..a5a122431563 100644
--- a/include/linux/acpi_viot.h
+++ b/include/linux/acpi_viot.h
@@ -6,9 +6,11 @@
 #include <linux/acpi.h>
 
 #ifdef CONFIG_ACPI_VIOT
+void __init acpi_viot_early_init(void);
 void __init acpi_viot_init(void);
 int viot_iommu_configure(struct device *dev);
 #else
+static inline void acpi_viot_early_init(void) {}
 static inline void acpi_viot_init(void) {}
 static inline int viot_iommu_configure(struct device *dev)
 {
-- 
2.35.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
