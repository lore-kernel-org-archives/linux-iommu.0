Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685B1C4727F
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 22:55:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 070D4208B6
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 22:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070D4208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 82B9387696;
	Fri, 25 Sep 2020 22:55:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZLJ6ZXXJzdUY; Fri, 25 Sep 2020 22:54:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 943D18768F;
	Fri, 25 Sep 2020 22:54:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5938BC0891;
	Fri, 25 Sep 2020 22:54:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C875EC0859
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 22:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B017486DA9
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 22:54:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pPs2CHPxXYjp for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 22:54:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7AEF386DA6
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 22:54:56 +0000 (UTC)
IronPort-SDR: cWxMnCxaMq3bFoQj2gw8/Hcm30iqhM8Ztu5TC/d0po3xAhnKrZcRAt4HhsrOE6gMZQUo2sqByw
 kJFuV6+QphwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="223263427"
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; d="scan'208";a="223263427"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2020 15:54:54 -0700
IronPort-SDR: vGqYM0y2LvvNcoXpZ6AJQYIWOV2sKR4XBvUMxnwA2zvkYFkq5bxmSM146jgNUoPmAP9WOGNxf0
 Ot6aRPaQwVkQ==
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; d="scan'208";a="414103890"
Received: from araj-mobl1.jf.intel.com (HELO localhost) ([10.254.96.12])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2020 15:54:54 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: iommu@lists.linux-foundation.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/1] pci: pciehp: Handle MRL interrupts to enable slot for
 hotplug.
Date: Fri, 25 Sep 2020 15:54:47 -0700
Message-Id: <20200925225447.28582-1-ashok.raj@intel.com>
X-Mailer: git-send-email 2.13.6
Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
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

When Mechanical Retention Lock (MRL) is present, Linux doesn't process
those change events.

The following changes need to be enabled when MRL is present.

1. Subscribe to MRL change events in SlotControl.
2. When MRL is closed,
   - If there is no ATTN button, then POWER on the slot.
   - If there is ATTN button, and an MRL event pending, ignore
     Presence Detect. Since we want ATTN button to drive the
     hotplug event.


Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/hotplug/pciehp.h      |  1 +
 drivers/pci/hotplug/pciehp_ctrl.c | 69 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/hotplug/pciehp_hpc.c  | 27 ++++++++++++++-
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 4fd200d8b0a9..24a1c9c8ac78 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -155,6 +155,7 @@ void pciehp_request(struct controller *ctrl, int action);
 void pciehp_handle_button_press(struct controller *ctrl);
 void pciehp_handle_disable_request(struct controller *ctrl);
 void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events);
+void pciehp_handle_mrl_change(struct controller *ctrl);
 int pciehp_configure_device(struct controller *ctrl);
 void pciehp_unconfigure_device(struct controller *ctrl, bool presence);
 void pciehp_queue_pushbutton_work(struct work_struct *work);
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 9f85815b4f53..c4310ee3678b 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -227,6 +227,7 @@ void pciehp_handle_disable_request(struct controller *ctrl)
 void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 {
 	int present, link_active;
+	u8 getstatus = 0;
 
 	/*
 	 * If the slot is on and presence or link has changed, turn it off.
@@ -275,6 +276,16 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 		if (link_active)
 			ctrl_info(ctrl, "Slot(%s): Link Up\n",
 				  slot_name(ctrl));
+		if (MRL_SENS(ctrl)) {
+			pciehp_get_latch_status(ctrl, &getstatus);
+			/*
+			 * If slot is closed && ATTN button exists
+			 * don't continue, let the ATTN button
+			 * drive the hot-plug
+			 */
+			if (!getstatus && ATTN_BUTTN(ctrl))
+				return;
+		}
 		ctrl->request_result = pciehp_enable_slot(ctrl);
 		break;
 	default:
@@ -283,6 +294,64 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	}
 }
 
+void pciehp_handle_mrl_change(struct controller *ctrl)
+{
+	u8 getstatus = 0;
+	int present, link_active;
+
+	pciehp_get_latch_status(ctrl, &getstatus);
+
+	present = pciehp_card_present(ctrl);
+	link_active = pciehp_check_link_active(ctrl);
+
+	ctrl_info(ctrl, "Slot(%s): Card %spresent\n",
+		  slot_name(ctrl), present ? "" : "not ");
+
+	ctrl_info(ctrl, "Slot(%s): Link %s\n",
+		  slot_name(ctrl), link_active ? "Up" : "Down");
+
+	ctrl_info(ctrl, "Slot(%s): Latch %s\n",
+			  slot_name(ctrl), getstatus ? "Open" : "Closed");
+
+	/*
+	 * Need to handle only MRL Open. When MRL is closed with
+	 * a Card Present, either the ATTN button, or the PDC indication
+	 * should power the slot and add the card in the slot
+	 */
+	if (getstatus) {
+		/*
+		 * If slot was powered on, time to power off
+		 * and remove the card
+		 */
+		mutex_lock(&ctrl->state_lock);
+		if (ctrl->state == ON_STATE) {
+			mutex_unlock(&ctrl->state_lock);
+			pciehp_handle_disable_request(ctrl);
+		} else
+			mutex_unlock(&ctrl->state_lock);
+	} else {
+		/*
+		 * If latch is closed, and previous state is OFF
+		 * Then enable the slot
+		 */
+		mutex_lock(&ctrl->state_lock);
+		if (ctrl->state == OFF_STATE) {
+			/*
+			 * Only continue to power on the slot when the
+			 * Attention button is not present. When button
+			 * present, button press event will process the
+			 * hot-add part of the flow.
+			 */
+			if ((present || link_active) && !ATTN_BUTTN(ctrl)) {
+				ctrl->state = POWERON_STATE;
+				mutex_unlock(&ctrl->state_lock);
+				ctrl->request_result = pciehp_enable_slot(ctrl);
+			} else
+				mutex_unlock(&ctrl->state_lock);
+		}
+	}
+}
+
 static int __pciehp_enable_slot(struct controller *ctrl)
 {
 	u8 getstatus = 0;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 53433b37e181..5a4b5cfbfe48 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -605,7 +605,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	 */
 	status &= PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
 		  PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
-		  PCI_EXP_SLTSTA_DLLSC;
+		  PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_MRLSC;
 
 	/*
 	 * If we've already reported a power fault, don't report it again
@@ -658,6 +658,12 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
+	/*
+	 * If MRL is triggered, if ATTN button exists, ignore the event.
+	 */
+	if (ATTN_BUTTN(ctrl) && (events & PCI_EXP_SLTSTA_MRLSC))
+		events &= ~PCI_EXP_SLTSTA_PDC;
+
 	/* Save pending events for consumption by IRQ thread. */
 	atomic_or(events, &ctrl->pending_events);
 	return IRQ_WAKE_THREAD;
@@ -688,6 +694,13 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 		goto out;
 	}
 
+	/*
+	 * If ATTN is present and MRL is triggered
+	 * ignore the Presence Change Event.
+	 */
+	if (ATTN_BUTTN(ctrl) && (events & PCI_EXP_SLTSTA_MRLSC))
+		events &= ~PCI_EXP_SLTSTA_PDC;
+
 	/* Check Attention Button Pressed */
 	if (events & PCI_EXP_SLTSTA_ABP) {
 		ctrl_info(ctrl, "Slot(%s): Attention button pressed\n",
@@ -712,6 +725,10 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 		pciehp_handle_disable_request(ctrl);
 	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
 		pciehp_handle_presence_or_link_change(ctrl, events);
+
+	if (events & PCI_EXP_SLTSTA_MRLSC)
+		pciehp_handle_mrl_change(ctrl);
+
 	up_read(&ctrl->reset_lock);
 
 	ret = IRQ_HANDLED;
@@ -768,6 +785,14 @@ static void pcie_enable_notification(struct controller *ctrl)
 		cmd |= PCI_EXP_SLTCTL_ABPE;
 	else
 		cmd |= PCI_EXP_SLTCTL_PDCE;
+
+	/*
+	 * If MRL sensor is present, then subscribe for MRL
+	 * Changes to be notified as well.
+	 */
+	if (MRL_SENS(ctrl))
+		cmd |= PCI_EXP_SLTCTL_MRLSCE;
+
 	if (!pciehp_poll_mode)
 		cmd |= PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE;
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
