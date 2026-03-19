Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0841934575A
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 06:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773900951; cv=none; b=iAOzWA+hrlYFIaeALO+JFLIGTCKTGpqZVYt+l8IB8Upe5MEnkLW4WQpsa+EgENnfwzKWSE0bap0sQtZLoPQD+YvhhBFafMTYaiSwkkD7/6N7EIjc9fRQUfikSjL7k8fJmkt7efmnK/hjHnrL9GFvuY8lbmWVG6jHq8awX/IV2fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773900951; c=relaxed/simple;
	bh=2DHIOR/xu0FQ/B1GFdC6D07OnelCvpt03qpXdP8Z//s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GUu7f5zfc7lsUhwNNMMCfEPOQNID8jbDaV9pzEZCxFwXfx+THO3ODnh/lM/naEGljunKP6235KtM52+s7d9uet2rT6VGUeZeXaf13C1SBV0aApJ8FtSZmvBm/dB03bpP97d2/s5hfPtUYF5ZSLED6vfPsR84MXt1xzVnih6anpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+v5aLou; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+v5aLou"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82a07738118so439156b3a.0
        for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 23:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773900949; x=1774505749; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsT73j4cLvpq8BjBjqE6tomVf3siHf2xqAbxNaDSyB0=;
        b=J+v5aLou/aXuVK8hMz9nkGT6mDsdMnEUJeukBR4hckop3zMfumxjtqODVipss6WfX6
         0cX+sfdoP+/pQBNziBWocQAbZ6ICprX05XkFs7JcH5nrGE7RU+aEGwl7Mk84p5j5GdSz
         i+At1YffReTlTChFv7lm9JtTqAELvBTAdMEXFGZJ0yVuBZ50IwUI3GRdbnhGpwFPHc7+
         DsBVuYlteI8zWH8ikngWGxArAAZ4hhorkfd4apCqnkXtoNeH3AhEEqp/ukLgm5vIxgSY
         S9fL+WRsLaSfpq+LoOUGERxt+ehuW9aDWnayRGlIcLKXZQ4pF+37rSdT6FfzUdJR8/gh
         cLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773900949; x=1774505749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NsT73j4cLvpq8BjBjqE6tomVf3siHf2xqAbxNaDSyB0=;
        b=eiFPhCMJJoG4dKp6fyuU2l5kZc2MzLMkc0B5sZ3zpnldwa9mIguY0APQBBnWlcbN8W
         uIN7hAuaHV/dONGi1R6/8TXlYF6o3yLpNBO3SfFBrhHrQWVhtRF4LGTDqY1sh0+1/T/r
         3Dc5aIUh7ybk+ZllfgHD+fZt+kOu+bwr+B/EaOAgBIbE5t3I5LVwmYD4nJaprGUe0AIJ
         HPmIgck7/O7YMxs2/iMtWbARIRQ1j/7MZ1GBgddu3cC3l7uodE2l9ceD7jKgpwUIMz3t
         +5BWr5RNJTD6bxMCoo5kYMk1kRIK0ARC3xENbNBciBuHeFlOcsf0bvUmInUoA4keUHhL
         zc9A==
X-Forwarded-Encrypted: i=1; AJvYcCVYx7rC7X4fMfwpg8+kSksrgNyaP68Co4IcQrDyfXuGVwENc4DwZwx7xR1HZXMdRGjTieQhNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXslv7eoQKJGY7bYJJvAngq2nlyh1TxyaG0ia0PgPcQrSRON5U
	wmChKZ6fg/A9m+ShaFTdvA68WiV5SCWRbT+w08jo7EqxDOm7PyLnMWzIzHE6Pdte
X-Gm-Gg: ATEYQzz3ROIR8mven5V0ubPtSJyHthdFUSj+6e3aNdsMltxdc/mHR+0RlB7j0gbSW2C
	17Ct5v6KSWbraYWE1fWw+B0kvbqkPsLhJCZ3fOy3m77ipjqj6+tXL4uyIbJW6zGTvGobP9NqLvZ
	YnzMNav7VMWuO+0F+A4lieAbXw9feK08Gh51hy4MI2esC7oGOqopFWyJl/xFR2ZY0LffcU017Km
	6TJfL+SRPeEcOrhemKjWE+STvDpUiyv9qEhhWoW2pXc46si0ZxHIwp0Ad9t0/1w5wEicRPH9ws4
	5Fo8OGG2x4tUjWen+osX4idB0RYzCbYf48O+xEjAsvYK7JhLhsZtAB79yfJO/V8Kc+xlDPGoxeF
	K/q71SY8/6YOGZF/7wJfafnzxGVNiQPJIqM7qo/JYgTGVXdkEKiG5s2yLVbU/q9DXWYvP3bfst6
	tEKiks4x5ZlxDqnsi2xSlWxLfoV8y5NLav8D7TywGI9Vvcn1LqUJcXfcgHrX1h0dVbNhqdOIYmr
	ntfqvQa8qk3cw==
X-Received: by 2002:a05:6a00:190b:b0:829:7d31:dd99 with SMTP id d2e1a72fcca58-82a6ae7084fmr5481255b3a.38.1773900949283;
        Wed, 18 Mar 2026 23:15:49 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (61-221-208-111.hinet-ip.hinet.net. [61.221.208.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bef5ed8sm5660824b3a.57.2026.03.18.23.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 23:15:48 -0700 (PDT)
From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ahuang12@lenovo.com,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Subject: [PATCH 2/2] iommu/amd: Register PCI bus notifier when appending amd_iommu=off
Date: Thu, 19 Mar 2026 14:15:07 +0800
Message-Id: <20260319061507.541-3-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260319061507.541-1-adrianhuang0701@gmail.com>
References: <20260319061507.541-1-adrianhuang0701@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the amd_iommu=off kernel parameter is used, dynamically adding
PCI devices (e.g., creating SR-IOV VFs) triggers a call trace and
IOMMU fault events. For example, enabling VFs via sysfs:

  # echo 4 > /sys/class/net/eth1/device/sriov_numvfs

It results in an INVALID_DEVICE_REQUEST and a warning in
__irq_msi_compose_msg+0xa3/0xb0:

  pci 0000:41:03.0: [14e4:16c1] type 00 class 0x020000 PCIe Endpoint
  bnxt_en 0000:41:03.0: enabling device (0000 -> 0002)
  bnxt_en 0000:41:03.0 eth4: Broadcom NetXtreme-E Ethernet Virtual Function found at mem 381c7ff40000, node addr 92:42:39:64:ad:24
  ...
  WARNING: arch/x86/kernel/apic/apic.c:2313 at __irq_msi_compose_msg+0xa3/0xb0, CPU#2: NetworkManager/4268
  bnxt_en 0000:41:03.1: enabling device (0000 -> 0002)
  CPU: 2 UID: 0 PID: 4268 Comm: NetworkManager Kdump: loaded Not tainted 7.0.0-rc4+ #23 PREEMPT(lazy)
  ...
  RIP: 0010:__irq_msi_compose_msg+0xa3/0xb0
  ...
  Call Trace:
   <TASK>
   irq_chip_compose_msi_msg+0x2e/0x50
   msi_domain_activate+0x41/0x90
   __irq_domain_activate_irq+0x53/0x90
   ? mtree_load+0x26e/0x2b0
   irq_domain_activate_irq+0x29/0x40
   __setup_irq+0x322/0x790
   ? __pfx_bnxt_msix+0x10/0x10 [bnxt_en]
   request_threaded_irq+0x109/0x1c0
   bnxt_request_irq+0xee/0x270 [bnxt_en]
   ...
   AMD-Vi: Event logged [INVALID_DEVICE_REQUEST device=0000:41:03.0 pasid=0x00000 address=0xfffffffdf8220100 flags=0x0a00]

The root cause is that when IOMMU is disabled via the command line, the
PCI bus notifier is not registered. Consequently, the MSI domain for
dynamically added devices is not properly associated with the IOMMU
interrupt remapping domain. Even when the IOMMU is "off," certain
interrupt remapping configurations must still be handled for newly
enumerated devices to prevent activation failures.

Fix this by ensuring the PCI bus notifier is registered even when
amd_iommu=off is set, allowing the IOMMU interrupt remapping domain to
be correctly assigned to new PCI devices.

Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
---
 drivers/iommu/amd/init.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0f577534702d..5509ade0cf0d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3431,6 +3431,30 @@ static int __init amd_iommu_devices_set_pci_msi_domain(void)
 	return ret;
 }
 
+static int amd_iommu_pci_bus_notifier(struct notifier_block *nb,
+					unsigned long action, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(data);
+
+	/* We only care about the add event. */
+	if (action != BUS_NOTIFY_ADD_DEVICE)
+		return NOTIFY_DONE;
+
+	amd_iommu_dev_set_pci_msi_domain(&pdev->dev);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block amd_iommu_pci_bus_nb = {
+	.notifier_call = amd_iommu_pci_bus_notifier,
+	.priority = 1,
+};
+
+static void __init amd_iommu_register_bus_notifier(void)
+{
+	bus_register_notifier(&pci_bus_type, &amd_iommu_pci_bus_nb);
+}
+
 /****************************************************************************
  *
  * AMD IOMMU Initialization State Machine
@@ -3462,6 +3486,7 @@ static int __init state_next(void)
 	case IOMMU_ENABLED:
 		if (amd_iommu_disabled) {
 			amd_iommu_devices_set_pci_msi_domain();
+			amd_iommu_register_bus_notifier();
 			init_state = IOMMU_CMDLINE_DISABLED;
 			ret = -EINVAL;
 		} else {
-- 
2.47.3

