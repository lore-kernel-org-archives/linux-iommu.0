Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC0AC43461
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 09:52:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4AD6613C3
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 09:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AD6613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 50A5A4060B;
	Fri, 23 Apr 2021 09:52:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jXsX5kclU418; Fri, 23 Apr 2021 09:52:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4BA8740610;
	Fri, 23 Apr 2021 09:52:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36719C001A;
	Fri, 23 Apr 2021 09:52:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3C9AC000B;
 Fri, 23 Apr 2021 09:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9089140618;
 Fri, 23 Apr 2021 09:52:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DjWjZ5pE3Vm3; Fri, 23 Apr 2021 09:52:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id D98EE40602;
 Fri, 23 Apr 2021 09:52:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FAEE1474;
 Fri, 23 Apr 2021 02:52:08 -0700 (PDT)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EBF283F774;
 Fri, 23 Apr 2021 02:52:03 -0700 (PDT)
From: Vivek Gautam <vivek.gautam@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v1 02/11] iommu/virtio: Maintain a list of endpoints
 served by viommu_dev
Date: Fri, 23 Apr 2021 15:21:38 +0530
Message-Id: <20210423095147.27922-3-vivek.gautam@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423095147.27922-1-vivek.gautam@arm.com>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, mst@redhat.com,
 will.deacon@arm.com, Vivek Gautam <vivek.gautam@arm.com>, robin.murphy@arm.com
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

Keeping a record of list of endpoints that are served by the virtio-iommu
device would help in redirecting the requests of page faults to the
correct endpoint device to handle such requests.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
---
 drivers/iommu/virtio-iommu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 50039070e2aa..c970f386f031 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -48,6 +48,7 @@ struct viommu_dev {
 	spinlock_t			request_lock;
 	struct list_head		requests;
 	void				*evts;
+	struct list_head		endpoints;
 
 	/* Device configuration */
 	struct iommu_domain_geometry	geometry;
@@ -115,6 +116,12 @@ struct viommu_endpoint {
 	void				*pgtf;
 };
 
+struct viommu_ep_entry {
+	u32				eid;
+	struct viommu_endpoint		*vdev;
+	struct list_head		list;
+};
+
 struct viommu_request {
 	struct list_head		list;
 	void				*writeback;
@@ -573,6 +580,7 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 	size_t probe_len;
 	struct virtio_iommu_req_probe *probe;
 	struct virtio_iommu_probe_property *prop;
+	struct viommu_ep_entry *ep;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
 
@@ -640,6 +648,18 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
 		prop = (void *)probe->properties + cur;
 		type = le16_to_cpu(prop->type) & VIRTIO_IOMMU_PROBE_T_MASK;
 	}
+	if (ret)
+		goto out_free;
+
+	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
+	if (!ep) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+	ep->eid = probe->endpoint;
+	ep->vdev = vdev;
+
+	list_add(&ep->list, &viommu->endpoints);
 
 out_free:
 	kfree(probe);
@@ -1649,6 +1669,7 @@ static int viommu_probe(struct virtio_device *vdev)
 	viommu->dev = dev;
 	viommu->vdev = vdev;
 	INIT_LIST_HEAD(&viommu->requests);
+	INIT_LIST_HEAD(&viommu->endpoints);
 
 	ret = viommu_init_vqs(viommu);
 	if (ret)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
