Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34867C43461
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 09:52:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0FE36144D
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 09:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FE36144D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 72AEC400D9;
	Fri, 23 Apr 2021 09:52:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8fHhQWjAnnq2; Fri, 23 Apr 2021 09:52:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5E8DF40602;
	Fri, 23 Apr 2021 09:52:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3315CC000F;
	Fri, 23 Apr 2021 09:52:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDBBDC000F;
 Fri, 23 Apr 2021 09:52:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB03940602;
 Fri, 23 Apr 2021 09:52:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qZOByano3fI8; Fri, 23 Apr 2021 09:52:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0EE3640613;
 Fri, 23 Apr 2021 09:52:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94D261684;
 Fri, 23 Apr 2021 02:52:49 -0700 (PDT)
Received: from usa.arm.com (a074945.blr.arm.com [10.162.16.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6D48D3F774;
 Fri, 23 Apr 2021 02:52:45 -0700 (PDT)
From: Vivek Gautam <vivek.gautam@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
Subject: [PATCH RFC v1 11/11] iommu/virtio: Add support to send page response
Date: Fri, 23 Apr 2021 15:21:47 +0530
Message-Id: <20210423095147.27922-12-vivek.gautam@arm.com>
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

Add page_response iommu ops callback to send page response to
the device that generated io page fault.

Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
---
 drivers/iommu/virtio-iommu.c | 47 ++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 08f1294baeab..6d62d9eae452 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1778,6 +1778,52 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 
+static int viommu_page_response(struct device *dev,
+				struct iommu_fault_event *evt,
+				struct iommu_page_response *resp)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct viommu_domain *vdomain = to_viommu_domain(domain);
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
+	struct viommu_dev *viommu = vdev->viommu;
+	bool pasid_valid = resp->flags & IOMMU_PAGE_RESP_PASID_VALID;
+	struct virtio_iommu_req_page_resp req = {
+		.head.type	= VIRTIO_IOMMU_T_PAGE_RESP,
+		.domain		= cpu_to_le32(vdomain->id),
+		.endpoint	= cpu_to_le32(fwspec->ids[0]),
+	};
+
+	if (vdev->pri_supported) {
+		bool needs_pasid = (evt->fault.prm.flags &
+				    IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID);
+
+		req.pasid_valid	= needs_pasid && pasid_valid;
+		req.flags	= cpu_to_le32((needs_pasid && pasid_valid) ?
+				   VIRTIO_IOMMU_PAGE_RESP_PASID_VALID : 0);
+		req.pasid	= cpu_to_le32(resp->pasid);
+		req.grpid	= cpu_to_le32(resp->grpid);
+
+		switch (resp->code) {
+		case IOMMU_PAGE_RESP_FAILURE:
+			req.resp_code = cpu_to_le16(VIRTIO_IOMMU_PAGE_RESP_FAILURE);
+			break;
+		case IOMMU_PAGE_RESP_INVALID:
+			req.resp_code = cpu_to_le16(VIRTIO_IOMMU_PAGE_RESP_INVALID);
+			break;
+		case IOMMU_PAGE_RESP_SUCCESS:
+			req.resp_code = cpu_to_le16(VIRTIO_IOMMU_PAGE_RESP_SUCCESS);
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		return -ENODEV;
+	}
+
+	return viommu_send_req_sync(viommu, &req, sizeof(req));
+}
+
 static u32 viommu_sva_get_pasid(struct iommu_sva *handle)
 {
 	struct viommu_sva_bond *bond = sva_to_viommu_bond(handle);
@@ -2155,6 +2201,7 @@ static struct iommu_ops viommu_ops = {
 	.sva_bind		= viommu_sva_bind,
 	.sva_unbind		= viommu_sva_unbind,
 	.sva_get_pasid		= viommu_sva_get_pasid,
+	.page_response		= viommu_page_response,
 };
 
 static int viommu_init_vqs(struct viommu_dev *viommu)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
