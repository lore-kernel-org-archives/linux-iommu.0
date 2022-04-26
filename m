Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D403C433FE
	for <iommu@archiver.kernel.org>; Tue, 26 Apr 2022 00:06:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5DCA828D1;
	Tue, 26 Apr 2022 00:06:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BP7ca6CQ5Lqo; Tue, 26 Apr 2022 00:06:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B4242829B1;
	Tue, 26 Apr 2022 00:06:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87576C0039;
	Tue, 26 Apr 2022 00:06:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52887C002D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 00:06:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 31AEF60BA4
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 00:06:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xdgr5M-Azukf for <iommu@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 00:06:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3E00A60B64
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 00:06:45 +0000 (UTC)
Received: by mail-yb1-xb49.google.com with SMTP id
 o64-20020a257343000000b006483069a28aso6117272ybc.3
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 17:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=EQ6VT6w46Hd44XRTan9TInx0ubvgoNtxDCqLgonw/Fw=;
 b=HS1HO9FzmdSJFLMep5JjzcdD/vAauAAiJdJtzVrco1UZk50LeqYCzwhWCfRJZ34zuo
 qofqkRZyy6+RFdFh2w+QDW8VSe7d6xxNp46ta/i+iF8YOjRw3+5tLbnRtaro28Cio8o4
 OiNAeSDzHohgt4vbhCl/9Wvc9F6y3USITzJ10+JX+o97t3jdebP1nHALnKme07MYlKGU
 mxH/cmQgkqRAOh5TyDU0LaZ+kzTDPONTBv2KsgkeszUMtpbaBxIlgTjQx1ZHJGgr9rAO
 X8d6uZP7cZOeMc6TODikbj71Y+Li4qUszasbi90W6haTph6MsBXtG6XPJ0xdp8YxPd40
 2tBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=EQ6VT6w46Hd44XRTan9TInx0ubvgoNtxDCqLgonw/Fw=;
 b=V4XoztQOytnW0WBExora7t85xGE57zmYZgA+c1zYuVGnkhMA0wZmnYRiXnuL1XN1U9
 VsQUi9REFdJ6y1phv1xMT22AToIodZZUNPrHiAWzB0uR3rQ6qZVLLwWWofZEfXt2/o/k
 N6xPYT2azfjqCTfCqhx0wKylf6lIcvt/LX4EkLD7W2j0SlPmPyzLENZMPrc5uJx68l/I
 mX02jdzu/Mop69IScdY2z9YgPfYVdPZMaNEZDdDRRYpsl6urEHZ5vmEHXXVjMyaoe2V5
 FiJvnpVq+NVsJ8nFlVjbUksxD/ErO08UoqASizW7nMGYZ8Ev0GiRPhUsHWKd0EjPSgFT
 9pIQ==
X-Gm-Message-State: AOAM5333hpqW5VbJLeF4usY/26YvWB5jun4v6jnV1CWZx1kpAoCkEveS
 89I5ytIHsdMSTLWrSkBgZ+rjMBt/0Fe5
X-Google-Smtp-Source: ABdhPJwNNzWNR0miZ2gObmHApAL+Qq+RPW++GHIubAxH7gus9hz33wGevQAaQAJC9bdTGWNEfprWQMSD7v1q
X-Received: from rajat2.mtv.corp.google.com
 ([2620:15c:202:201:9590:6ed7:be38:9068])
 (user=rajatja job=sendgmr) by 2002:a25:f30f:0:b0:648:6d75:614 with SMTP id
 c15-20020a25f30f000000b006486d750614mr6652624ybs.558.1650931604103; Mon, 25
 Apr 2022 17:06:44 -0700 (PDT)
Date: Mon, 25 Apr 2022 17:06:39 -0700
Message-Id: <20220426000640.3581446-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v6 1/2] PCI/ACPI: Support Microsoft's "DmaProperty"
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-pci@vger.kernel.org, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rajat Jain <rajatxjain@gmail.com>, 
 Dmitry Torokhov <dtor@google.com>, Jesse Barnes <jsbarnes@google.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Pavel Machek <pavel@denx.de>,
 "Oliver O'Halloran" <oohall@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, 
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
 iommu@lists.linux-foundation.org
Cc: Rajat Jain <rajatja@google.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
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
From: Rajat Jain via iommu <iommu@lists.linux-foundation.org>
Reply-To: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The "DmaProperty" is supported and currently documented and used by
Microsoft [link 1 below], to flag internal PCIe root ports that need
DMA protection [link 2 below]. We have discussed with them and reached
a common understanding that they shall change their MSDN documentation
to say that the same property can be used to protect any PCI device,
and not just internal PCIe root ports (since there is no point
introducing yet another property for arbitrary PCI devices). This helps
with security from internal devices that offer an attack surface for
DMA attacks (e.g. internal network devices).

Support DmaProperty to mark DMA from a PCI device as untrusted.

Link: [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-internal-pcie-ports-accessible-to-users-and-requiring-dma-protection
Link: [2] https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
Signed-off-by: Rajat Jain <rajatja@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
v6: * Take care of Bjorn's comments:
       - Update the commit log
       - Rename to pci_dev_has_dma_property()
       - Use acpi_dev_get_property()
v5: * Reorder the patches in the series
v4: * Add the GUID. 
    * Update the comment and commitlog.
v3: * Use Microsoft's documented property "DmaProperty"
    * Resctrict to ACPI only

 drivers/acpi/property.c |  3 +++
 drivers/pci/pci-acpi.c  | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 12bbfe833609..bafe35c301ac 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -48,6 +48,9 @@ static const guid_t prp_guids[] = {
 	/* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-99a5189762d0 */
 	GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
 		  0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
+	/* DmaProperty for PCI devices GUID: 70d24161-6dd5-4c9e-8070-705531292865 */
+	GUID_INIT(0x70d24161, 0x6dd5, 0x4c9e,
+		  0x80, 0x70, 0x70, 0x55, 0x31, 0x29, 0x28, 0x65),
 };
 
 /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 3ae435beaf0a..d7c6ba48486f 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1369,12 +1369,33 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
 		dev->external_facing = 1;
 }
 
+static int pci_dev_has_dma_property(struct pci_dev *dev)
+{
+	struct acpi_device *adev;
+	const union acpi_object *obj;
+
+	adev = ACPI_COMPANION(&dev->dev);
+	if (!adev)
+		return 0;
+
+	/*
+	 * Property also used by Microsoft Windows for same purpose,
+	 * (to implement DMA protection from a device, using the IOMMU).
+	 */
+	if (!acpi_dev_get_property(adev, "DmaProperty", ACPI_TYPE_INTEGER,
+				   &obj) && obj->integer.value == 1)
+		return 1;
+
+	return 0;
+}
+
 void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 	pci_acpi_set_external_facing(pci_dev);
+	pci_dev->untrusted |= pci_dev_has_dma_property(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
