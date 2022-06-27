Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBEE2CA2
	for <iommu@lists.linux.dev>; Mon, 27 Jun 2022 12:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656334553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OVZ/LcnMWPN7fhBcYyaEBqrNmBX9SmIqzRP+nADepog=;
	b=KyjqWiXGroKu2jEH9fdk/96GUqojdFBp8htaYDxTcEYMNh/vsB8MRs4kVkrmvnknC+Sdx5
	siOxP1kFsp0OqiznPix+i+q5km7cOURhV9DU0QQebmAdOLxAD9bNn++FhTGk+N7CWg/98s
	9oDwwDVAoY3JX0OdAFpX3dQt50Q0Oto=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-iOyWrtXrNTa1LhoQCw5lWQ-1; Mon, 27 Jun 2022 08:55:47 -0400
X-MC-Unique: iOyWrtXrNTa1LhoQCw5lWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61B6E2806AAF;
	Mon, 27 Jun 2022 12:55:47 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7DBDA18EAA;
	Mon, 27 Jun 2022 12:55:45 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com,
	eric.auger@redhat.com,
	jean-philippe@linaro.org,
	jroedel@suse.de,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	rafael@kernel.org,
	lenb@kernel.org
Cc: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [PATCH] ACPI: VIOT: Fix ACS setup
Date: Mon, 27 Jun 2022 14:55:34 +0200
Message-ID: <20220627125534.1035912-1-eric.auger@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Message-ID: <20220627125534.ECRDfLTJv6Kuw_ZJDI0fVcCG1BabteIxGS1RipWViZc@z>

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

Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Jin Liu <jinl@redhat.com>
---
 drivers/acpi/bus.c        |  1 +
 drivers/acpi/viot.c       | 23 +++++++++++++++++------
 include/linux/acpi_viot.h |  2 ++
 3 files changed, 20 insertions(+), 6 deletions(-)

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
index d2256326c73a..3c1be123e4d6 100644
--- a/drivers/acpi/viot.c
+++ b/drivers/acpi/viot.c
@@ -248,6 +248,23 @@ static int __init viot_parse_node(const struct acpi_viot_header *hdr)
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
+	acpi_status status;
+	struct acpi_table_header *hdr;
+
+	status = acpi_get_table(ACPI_SIG_VIOT, 0, &hdr);
+	if (!ACPI_FAILURE(status))
+		pci_request_acs();
+	acpi_put_table(hdr);
+}
+
 /**
  * acpi_viot_init - Parse the VIOT table
  *
@@ -319,12 +336,6 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
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
index 1eb8ee5b0e5f..e58d60f8ff2e 100644
--- a/include/linux/acpi_viot.h
+++ b/include/linux/acpi_viot.h
@@ -6,10 +6,12 @@
 #include <linux/acpi.h>
 
 #ifdef CONFIG_ACPI_VIOT
+void __init acpi_viot_early_init(void);
 void __init acpi_viot_init(void);
 int viot_iommu_configure(struct device *dev);
 #else
 static inline void acpi_viot_init(void) {}
+static inline void acpi_viot_early_init(void) {}
 static inline int viot_iommu_configure(struct device *dev)
 {
 	return -ENODEV;
-- 
2.35.3

