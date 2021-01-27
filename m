Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590BAC433E0
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 06:22:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCECA205CA
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 06:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCECA205CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 770CA86837;
	Wed, 27 Jan 2021 06:22:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 56vY+ui-zM6f; Wed, 27 Jan 2021 06:22:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9569C8682F;
	Wed, 27 Jan 2021 06:22:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73F22C0FA7;
	Wed, 27 Jan 2021 06:22:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AAC2C013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 06:22:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id ECCDD86830
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 06:22:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fhhvg-TwIw+U for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 06:22:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 45DD08682F
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 06:22:03 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id m6so544009pfk.1
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 22:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p0UOjkRmTMwD1AsLsBqqGq4W3t7p5uLwynxQNKotm9U=;
 b=hfsu/AxsByhoVi9/dovQmsf7FplmeW4giTtzyaYOrpxLYHjqxO49D/fwguVd14YLri
 wAN7yFKObjzOtITpDrKBlGcikkyUHEiYcPfiu5w/o7eKPsWGFaWTlLPIcVwGH33qBpP+
 nM0Yc7yYDYhTCw3pBZeyuuiWpFZtOUi69e9cTxTPUW3gxt9pOHPq+lSEbIDzHgMpto6X
 dZZ0sJOyAtGfv6huYuRmMl07J/7Dp3odNwQWjl6/4pW+YgGUIpCsT4fh4tqn3ECRlVlU
 VrOrBRF2uHvljWRzzhMsR9gYf0TAnoiasz49iYc4CXrN5rRZC16+A/cdQAb/ZRkBZ3WV
 mFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p0UOjkRmTMwD1AsLsBqqGq4W3t7p5uLwynxQNKotm9U=;
 b=cFZNCYM6lTnhoHy0Li0h0yRJbgV5cpR1kMoM5dMTI4UnZrCOfziF/S+6GnguhxfDvV
 4Ci04FMaLsuSh9kA60uSWT7Y3lXcGNZCQtBr1YMxKs8UXmYUnObpOF7xPclMpydGdLGA
 s6fxR21HPYaszPJMLG93ZB/I+C4XobPhvoa1TM7iuQ8dfNyltMjUfJ9Oe2zXizWfXDtC
 UUIEUSxkxJ7L3aNGbvBLQcqgmM7kFHB9jqAOQVm1IN77E8NJTvr8h3F8PjMaftIiH9ba
 E882+NRXCK9LwMTE5DNDuq19Nh4bacVBYSv+m2V6BYX0gSjS5lgSEuWBjlwrUSGhReZs
 ccvg==
X-Gm-Message-State: AOAM532XbdUu2kdA5U6oHnJotp2djFy42HnaTjczRgQ3DAiq9jKjGOF0
 Jnc0/vXxhQEQwZTUHg8G33lf4wZCs2NAxQ==
X-Google-Smtp-Source: ABdhPJylntng4vIQz7EpDEhCRAK/XSZ+RAVN85oPYe0Cue23Sjqwoc7AjuY8T9U75OBd7KEGb71TeA==
X-Received: by 2002:a62:2e86:0:b029:1a6:5f94:2cb with SMTP id
 u128-20020a622e860000b02901a65f9402cbmr9127753pfu.19.1611728522419; 
 Tue, 26 Jan 2021 22:22:02 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id d14sm992192pfo.156.2021.01.26.22.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Jan 2021 22:22:01 -0800 (PST)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2] iommu/vt-d: do not use flush-queue when caching-mode is on
Date: Tue, 26 Jan 2021 22:17:29 -0800
Message-Id: <20210127061729.1596640-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Nadav Amit <namit@vmware.com>,
 David Woodhouse <dwmw2@infradead.org>
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

From: Nadav Amit <namit@vmware.com>

When an Intel IOMMU is virtualized, and a physical device is
passed-through to the VM, changes of the virtual IOMMU need to be
propagated to the physical IOMMU. The hypervisor therefore needs to
monitor PTE mappings in the IOMMU page-tables. Intel specifications
provide "caching-mode" capability that a virtual IOMMU uses to report
that the IOMMU is virtualized and a TLB flush is needed after mapping to
allow the hypervisor to propagate virtual IOMMU mappings to the physical
IOMMU. To the best of my knowledge no real physical IOMMU reports
"caching-mode" as turned on.

Synchronizing the virtual and the physical IOMMU tables is expensive if
the hypervisor is unaware which PTEs have changed, as the hypervisor is
required to walk all the virtualized tables and look for changes.
Consequently, domain flushes are much more expensive than page-specific
flushes on virtualized IOMMUs with passthrough devices. The kernel
therefore exploited the "caching-mode" indication to avoid domain
flushing and use page-specific flushing in virtualized environments. See
commit 78d5f0f500e6 ("intel-iommu: Avoid global flushes with caching
mode.")

This behavior changed after commit 13cf01744608 ("iommu/vt-d: Make use
of iova deferred flushing"). Now, when batched TLB flushing is used (the
default), full TLB domain flushes are performed frequently, requiring
the hypervisor to perform expensive synchronization between the virtual
TLB and the physical one.

Getting batched TLB flushes to use in such circumstances page-specific
invalidations again is not easy, since the TLB invalidation scheme
assumes that "full" domain TLB flushes are performed for scalability.

Disable batched TLB flushes when caching-mode is on, as the performance
benefit from using batched TLB invalidations is likely to be much
smaller than the overhead of the virtual-to-physical IOMMU page-tables
synchronization.

Fixes: 78d5f0f500e6 ("intel-iommu: Avoid global flushes with caching mode.")
Signed-off-by: Nadav Amit <namit@vmware.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: stable@vger.kernel.org

---
v1->v2:

* disable flush queue for all domains if caching-mode is on for any
  IOMMU (Lu).
---
 drivers/iommu/intel/iommu.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 788119c5b021..de3dd617cf60 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5373,6 +5373,36 @@ intel_iommu_domain_set_attr(struct iommu_domain *domain,
 	return ret;
 }
 
+static bool domain_use_flush_queue(void)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	bool r = true;
+
+	if (intel_iommu_strict)
+		return false;
+
+	/*
+	 * The flush queue implementation does not perform page-selective
+	 * invalidations that are required for efficient TLB flushes in virtual
+	 * environments. The benefit of batching is likely to be much lower than
+	 * the overhead of synchronizing the virtual and physical IOMMU
+	 * page-tables.
+	 */
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		if (!cap_caching_mode(iommu->cap))
+			continue;
+
+		pr_warn_once("IOMMU batching is disabled due to virtualization");
+		r = false;
+		break;
+	}
+	rcu_read_unlock();
+
+	return r;
+}
+
 static int
 intel_iommu_domain_get_attr(struct iommu_domain *domain,
 			    enum iommu_attr attr, void *data)
@@ -5383,7 +5413,7 @@ intel_iommu_domain_get_attr(struct iommu_domain *domain,
 	case IOMMU_DOMAIN_DMA:
 		switch (attr) {
 		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
-			*(int *)data = !intel_iommu_strict;
+			*(int *)data = domain_use_flush_queue();
 			return 0;
 		default:
 			return -ENODEV;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
