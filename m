Return-Path: <SRS0=PWDw=5R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C5DC43331
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 11:38:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3E92077D
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 11:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="f237XEM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3E92077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1E60F2034C;
	Wed,  1 Apr 2020 11:38:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XKIthIZkGBqo; Wed,  1 Apr 2020 11:38:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D3C2E2000B;
	Wed,  1 Apr 2020 11:38:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C03C9C1D7F;
	Wed,  1 Apr 2020 11:38:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46A4FC089F;
 Wed,  1 Apr 2020 11:38:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 273A987FA4;
 Wed,  1 Apr 2020 11:38:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MCK+xTTOT+Q0; Wed,  1 Apr 2020 11:38:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 07F5487F3F;
 Wed,  1 Apr 2020 11:38:15 +0000 (UTC)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 031BVDwh025633; Wed, 1 Apr 2020 04:38:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=75nGljHVFqt0QhvENVD0hJlIui45v+CfwsYhW2bhLLk=;
 b=f237XEM4gvWf4Kr0YkFU547qWp/K/IbSwTsffiq8aHssoZzxHxIs60TGdw1y6JGpe25h
 raSeoG4yfegDaYfW1QjGQIu9CvLOR0QP194JaxefnYdftpxVcDoNy+tz4iZ0BmphN/3o
 PNI4gKNkFldy0weOOd+hFD7FUjP1seWBWQPjgmxG+8h0nDJrmtD8SN4ZPFrkMV9MqFJz
 b4W4By8Eqg2qEofT+9wbTvejvWquF42GVmOhO4B/Mmb9ESfoGNx8nbrkI5f5/atgKf1d
 up0wzSm+8TCPguAmUSlEEd+w4Zdbnmhjecj1+shqHEeJKivhg+AQpDoZ3Rns9yX/h+uD kw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 3046h5w6ts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 01 Apr 2020 04:38:12 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 1 Apr
 2020 04:38:10 -0700
Received: from bbhushan2.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 1 Apr 2020 04:38:07 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <jean-philippe@linaro.org>, <joro@8bytes.org>, <mst@redhat.com>,
 <jasowang@redhat.com>, <virtualization@lists.linux-foundation.org>,
 <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
 <eric.auger.pro@gmail.com>, <eric.auger@redhat.com>
Subject: [RFC PATCH v2] iommu/virtio: Use page size bitmap supported by
 endpoint
Date: Wed, 1 Apr 2020 17:08:04 +0530
Message-ID: <20200401113804.21616-1-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-01_01:2020-03-31,
 2020-03-31 signatures=0
Cc: Bharat Bhushan <bbhushan2@marvell.com>
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

Different endpoint can support different page size, probe
endpoint if it supports specific page size otherwise use
global page sizes.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 drivers/iommu/virtio-iommu.c      | 33 +++++++++++++++++++++++++++----
 include/uapi/linux/virtio_iommu.h |  7 +++++++
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index cce329d71fba..c794cb5b7b3e 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -78,6 +78,7 @@ struct viommu_endpoint {
 	struct viommu_dev		*viommu;
 	struct viommu_domain		*vdomain;
 	struct list_head		resv_regions;
+	u64				pgsize_bitmap;
 };
 
 struct viommu_request {
@@ -415,6 +416,20 @@ static int viommu_replay_mappings(struct viommu_domain *vdomain)
 	return ret;
 }
 
+static int viommu_set_pgsize_bitmap(struct viommu_endpoint *vdev,
+				    struct virtio_iommu_probe_pgsize_mask *mask,
+				    size_t len)
+
+{
+	u64 pgsize_bitmap = le64_to_cpu(mask->pgsize_bitmap);
+
+	if (len < sizeof(*mask))
+		return -EINVAL;
+
+	vdev->pgsize_bitmap = pgsize_bitmap;
+	return 0;
+}
+
 static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 			       struct virtio_iommu_probe_resv_mem *mem,
 			       size_t len)
@@ -494,11 +509,13 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 	while (type != VIRTIO_IOMMU_PROBE_T_NONE &&
 	       cur < viommu->probe_size) {
 		len = le16_to_cpu(prop->length) + sizeof(*prop);
-
 		switch (type) {
 		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
 			ret = viommu_add_resv_mem(vdev, (void *)prop, len);
 			break;
+		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
+			ret = viommu_set_pgsize_bitmap(vdev, (void *)prop, len);
+			break;
 		default:
 			dev_err(dev, "unknown viommu prop 0x%x\n", type);
 		}
@@ -607,16 +624,23 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
 	return &vdomain->domain;
 }
 
-static int viommu_domain_finalise(struct viommu_dev *viommu,
+static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 				  struct iommu_domain *domain)
 {
 	int ret;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
+	struct viommu_dev *viommu = vdev->viommu;
 
 	vdomain->viommu		= viommu;
 	vdomain->map_flags	= viommu->map_flags;
 
-	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
+	/* Devices in same domain must support same size pages */
+	if ((domain->pgsize_bitmap != viommu->pgsize_bitmap) &&
+	    (domain->pgsize_bitmap != vdev->pgsize_bitmap))
+		return -EINVAL;
+
+	domain->pgsize_bitmap = vdev->pgsize_bitmap;
+
 	domain->geometry	= viommu->geometry;
 
 	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
@@ -657,7 +681,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		 * Properly initialize the domain now that we know which viommu
 		 * owns it.
 		 */
-		ret = viommu_domain_finalise(vdev->viommu, domain);
+		ret = viommu_domain_finalise(vdev, domain);
 	} else if (vdomain->viommu != vdev->viommu) {
 		dev_err(dev, "cannot attach to foreign vIOMMU\n");
 		ret = -EXDEV;
@@ -875,6 +899,7 @@ static int viommu_add_device(struct device *dev)
 
 	vdev->dev = dev;
 	vdev->viommu = viommu;
+	vdev->pgsize_bitmap = viommu->pgsize_bitmap;
 	INIT_LIST_HEAD(&vdev->resv_regions);
 	fwspec->iommu_priv = vdev;
 
diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 237e36a280cb..dc9d3f40bcd8 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -111,6 +111,7 @@ struct virtio_iommu_req_unmap {
 
 #define VIRTIO_IOMMU_PROBE_T_NONE		0
 #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
+#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
 
 #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
 
@@ -119,6 +120,12 @@ struct virtio_iommu_probe_property {
 	__le16					length;
 };
 
+struct virtio_iommu_probe_pgsize_mask {
+	struct virtio_iommu_probe_property	head;
+	__u8					reserved[4];
+	__u64					pgsize_bitmap;
+};
+
 #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
 #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
