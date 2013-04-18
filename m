From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/2 V2] iommu/amd: Add workaround for ERBT1312
Date: Thu, 18 Apr 2013 18:02:24 +0200
Message-ID: <20130418160220.GA4153@8bytes.org>
References: <1366009666-44792-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1366009666-44792-1-git-send-email-suravee.suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: suravee.suthikulpanit@amd.com
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 15, 2013 at 02:07:46AM -0500, suravee.suthikulpanit@amd.com wrote:
>  drivers/iommu/amd_iommu.c |  145 +++++++++++++++++++++++++++++----------------

That is way too much for a simple erratum workaround, and too much for a
stable backport. I queued the patch below instead, which has a much
smaller diff and does the same. Please rebase your second patch on-top
of this one and send it again.

>From 4ba052102863da02db79c03d2483b6ad905737ad Mon Sep 17 00:00:00 2001
From: Joerg Roedel <joro@8bytes.org>
Date: Thu, 18 Apr 2013 17:55:04 +0200
Subject: [PATCH] iommu/amd: Workaround for ERBT1312

Work around an IOMMU  hardware bug where clearing the
EVT_INT bit in the status register may race with the
hardware trying to set it again. When not handled the bit
might not be cleared and we lose all future event
interrupts.

Reported-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Joerg Roedel <joro@8bytes.org>
---
 drivers/iommu/amd_iommu.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f42793d..de5ae4b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -700,14 +700,23 @@ retry:
 
 static void iommu_poll_events(struct amd_iommu *iommu)
 {
-	u32 head, tail;
+	u32 head, tail, status;
 	unsigned long flags;
 
-	/* enable event interrupts again */
-	writel(MMIO_STATUS_EVT_INT_MASK, iommu->mmio_base + MMIO_STATUS_OFFSET);
-
 	spin_lock_irqsave(&iommu->lock, flags);
 
+	/* enable event interrupts again */
+	do {
+		/*
+		 * Workaround for Erratum ERBT1312
+		 * Clearing the EVT_INT bit may race in the hardware, so read
+		 * it again and make sure it was really cleared
+		 */
+		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
+		writel(MMIO_STATUS_EVT_INT_MASK,
+		       iommu->mmio_base + MMIO_STATUS_OFFSET);
+	} while (status & MMIO_STATUS_EVT_INT_MASK);
+
 	head = readl(iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
 	tail = readl(iommu->mmio_base + MMIO_EVT_TAIL_OFFSET);
 
-- 
1.7.9.5
