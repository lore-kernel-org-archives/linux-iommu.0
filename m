Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795134198;
	b=W9T/Tvi7/aHoMENGLsix9XS5w55X//lMZGjp1/uSk5GlhltRSDueOpLDUQVEURdV3fFn
	 r+3I6+sDy2NTRFQsHcn3vgWbSpJNj/19zWJWcbKy7659vPWQObaElFffcGos4ZVcmKWMS
	 TovQC18vb60d2dySgge2ezf36W0pjTkTlaVmcN9mFyAC2BP1qYeGCG/DuyXdhPpe/BGv9
	 3Y1/o4GJ6Yjs1TZn3GxXwq+CDKn3IWIDvKIELNY2m5uI16m8rINZ3A3QVDveG6NBrre3T
	 TLKycr8zYHCjuB5bOc5B0FfWPVP2BzPuhDl8hnv+KdlU2Jf5dQA9a1RzxpMQVthgA/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795134198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=RhGQm/UF9vMhWbFcBfDkOgWYLiWfHuOG+Gc7mXjwfx8=;
	b=klsnxDTgYtFzccM9VCqvdjCla6wwMaCS232XRZze82jcGwHCR0BBXA8tRuGUgiSf69Fs
	 AcBmVrHh/efv/9tRnvOR6Xwe55ZeklCHx7GKH36EOCqnaHyI0bvodMsx393qiZsPHT5kL
	 Z6V9J/LvnmDs70YOxK1MYFYF4GigqjsOa9OUAPR9xcue7Dj1sXG/B2P5Jh4hJLGk/tcrE
	 6C/wc2ukzgqyc+GhTZO0yNiDJvR4WOzR7rn1783bswdRBqRsBFraYrIjL8DLU2EqroQhN
	 vHlCQRTLWhKvegl8c41NwlI4B3npC8MVNzU5GsAROjQujf8CNITYLjS1Zf5UHeHAQoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--digonzal.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mi51hXRq;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDED760A2609
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 00:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDED760A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--digonzal.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mi51hXRq
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-16bc6f3fdb1so238950c88.0
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 16:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795134197; x=1795738997; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RhGQm/UF9vMhWbFcBfDkOgWYLiWfHuOG+Gc7mXjwfx8=;
        b=mi51hXRqH34qOw0RaPP/0PMFjk26AU2itxUlbHKUjLVlCys9N/7pF5i/U8oCXrTEE9
         dsJ8a22uZh2//RyKh/O7SlP/4ipE7+Bkteipou1Q/PQOzbSBKnTWb0dv4/jvyX1g9C3l
         3c7UgCOPUPEmjgValBWRoB0UUl3dA9qWHcRH61mWwkE4Dt1e2ZtR74YkBdOaFeALoQpQ
         yEcv6VeB9yBeZkxiXhFl3vOK/vtHL96Ea2lXeXxavRt5Wlswc2SEXQaKmYWyWWGsTCR+
         //FleTtPMGAI6RH7hbrhSX+aKYMryJ4EOWhNb6D4bibXVzYNjNItSpkuRHTbgcxpK09Y
         josQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795134197; x=1795738997;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RhGQm/UF9vMhWbFcBfDkOgWYLiWfHuOG+Gc7mXjwfx8=;
        b=msdMCQarpJdx5OQatOP4eRQhGUm926i+oWnC/HCYKNnHMh1vT9wuo7HFL46MdUYjdz
         bK8rwnO2abSJouazN/OjvXJRE0jVjQ1Z5VL6e5v2mr/s87JgyoS4dWulDofbpLmS+dvP
         oI9Q7sSjPNST/bTeGhhWrZpVU/e5XZ6VewweVh2Uwr6Ph4+N5Apx5MnhY9z5kDq/fC79
         KfhhvvTj9Q73t4R+o2EZ8cTx9rZiU0bk0KRIpL/0+NiOlOhXufYDC9gyAH3wvjzgg/mj
         6la0pEx0Gio4LQ6UR5+bSMKWtJ7q97L34J/ume2rxTxcwBlxc8+zIHzUlnGQX5fp/uL8
         VU9Q==
X-Forwarded-Encrypted: i=1; AL+hErGbMMVSne7IynvFAv1xG2FoB0q+7HXEWgpIb0T6tHxw7MX6lkNw/0QO3P639AfacYHzPYsAlg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+xC1x5CizkVxHY6di2eN6XrZ3HU0TJzNwcnUEPMl5TgFovhAMo
	x6PYs7MKD5bKwrjOxBqePJqd/OMSeilZAkrhdOdvrRmFOG/HQ6MQeOsemYLlgWwSCfwnXI3/75M
	5jAAgQLS9wvepYw==
X-Received: from dlbrf24.prod.google.com ([2002:a05:7022:f218:b0:196:1ea7:17b6])
 (user=digonzal job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:220d:b0:1ab:fe29:5055 with SMTP id a92af1059eb24-1b556865255mr1475296c88.9.1795134196559;
 Thu, 19 Nov 2026 16:23:16 -0800 (PST)
Date: Fri, 20 Nov 2026 00:23:11 +0000
In-Reply-To: <20261120002311.394649-1-digonzal@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261120002311.394649-1-digonzal@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120002311.394649-3-digonzal@google.com>
Subject: [PATCH v3 2/2] PCI/ATS: Disable ATS when ACS TB is set upstream
From: Danny Gonzalez <digonzal@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Kevin Tian <kevin.tian@intel.com>, decot@google.com, praan@google.com, 
	sheenamo@google.com, linux-pci@vger.kernel.org, iommu@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Danny Gonzalez <digonzal@google.com>
Content-Type: text/plain; charset="UTF-8"

Enabling ATS allows an endpoint to cache translations and initiate DMA
requests with Translated addresses, which an upstream bridge with ACS
Translation Blocking (PCI_ACS_TB) set will block as ACS Violations.
Because pci_enable_acs() preserves existing PCI_ACS_CTRL bits (e.g., from
firmware, a kexec kernel, or "pci=config_acs=") without relaxing them,
PCI_ACS_TB may remain set on upstream bridges.

Update pci_ats_supported() to walk upstream bridges and return false if
any bridge has PCI_ACS_TB set, leaving the endpoint to use Untranslated
addresses. Ignore bridges whose config read fails or returns an error
response (PCI_POSSIBLE_ERROR()) so inaccessible bridges are not treated
as having PCI_ACS_TB set.

Tested by booting a machine with an endpoint advertising the ATS Capability
behind a Root Port with PCI_ACS_TB set; verified ATS is disabled and the
system boots cleanly.

Signed-off-by: Danny Gonzalez <digonzal@google.com>
---

v3:
 - Move the upstream ACS TB check back into pci_ats_supported(),
   dropping pci_ats_check_acs() and changes to pci-driver.c and pci.h
 - Read PCI_ACS_CTRL directly and check the return value and
   PCI_POSSIBLE_ERROR() so inaccessible bridges are not treated as
   having PCI_ACS_TB set
 - Remove the pci_warn_once() logging and separate helper function

v2 (based on sashiko review):
 - Move the upstream ACS TB check from pci_ats_supported() into
   pci_ats_check_acs() called after pci_enable_acs()
 - Use pci_acs_enabled() instead of reading PCI_ACS_CTRL directly

 drivers/pci/ats.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 9cb23780093d..e3c78a575800 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -40,12 +40,31 @@ void pci_ats_init(struct pci_dev *dev)
  */
 bool pci_ats_supported(struct pci_dev *dev)
 {
+	struct pci_dev *bridge;
+
 	if (!dev->ats_cap || dev->untrusted)
 		return false;
 
 	if (dev->is_virtfn)
 		return pci_ats_supported(pci_physfn(dev));
 
+	/* Do not allow ATS if any upstream bridge blocks translation */
+	for (bridge = pci_upstream_bridge(dev); bridge;
+	     bridge = pci_upstream_bridge(bridge)) {
+		u16 ctrl;
+		int ret;
+
+		if (!bridge->acs_cap)
+			continue;
+		ret = pci_read_config_word(bridge,
+					   bridge->acs_cap + PCI_ACS_CTRL,
+					   &ctrl);
+		if (ret || PCI_POSSIBLE_ERROR(ctrl))
+			continue;
+		if (ctrl & PCI_ACS_TB)
+			return false;
+	}
+
 	return true;
 }
 EXPORT_SYMBOL_GPL(pci_ats_supported);
-- 
2.56.1.708.g77570a6a1d-goog

