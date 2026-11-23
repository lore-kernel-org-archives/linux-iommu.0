Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795478348;
	b=Bcp7UI/MHygleesOb/lSWwKqrTImZFsuOhtJ8ee8ekPFFzt/eRIcGVrO/i2E7SHPyU23
	 flOHn88R03Ee5CbwYLNQIzbDJyYJjtCEGe/9vi+wuv8uWdwteV9Bhg6u/kDDlcLC3/oJS
	 W1JinK0lq8lXvkX/1S5i8n/0BKI0nix5i5HNLiEz+O5NkXLx8uw38chh4hsezx8aTA05p
	 q01BcTprgm1j24JXVGHcSDzRqr1Lx0q/vJqKWbP3mB7PGyj8iGmEtHVajfDSzDi9NzS6b
	 MPCUkyuyK3T9A+5xRxLylLBC44mLBpTx7X0APe8pl4jELy8CfJ80Fj7eSHvAXR7hy/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795478348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7b/nDdeo9OwJ/1BWB36V3ny12dy1Q2mSpSFSLOSLpW0=;
	b=kIFNXtQEXnGcTJYGd4ZPQQxH4gEBxhlLxNsCB58zrHt5rfH7M5Uv6xfVRkT620t3QRzi
	 hDyaV6rX2eo7nVw24P2ERuafY8D1uP9xwkn0wu5m2cs2wy64lmTSMglTGMxEKBnhfaM/M
	 eDMDWcz5HdMqZSISKrqnbAwD10biMwu2yGT5I6rRY6bOdubChIB5UVFACNIe6WzV8sLO0
	 SID0f/2+jDNBOTRf82m7P53MhQij3KFSDI0iTbKlHFuuQj/ab+AkoqEbx7HSYBMoEaDsA
	 SvX8zmoylIBVS7p8L4hefDdMswVu8OaCwyCDd3mpz0RpQsTbMvL4Wckvp58wQ2vPnlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=eB7kGJfd;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231B2606A332
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 23:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 231B2606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=eB7kGJfd
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso37519335e9.1
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 15:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795478346; x=1796083146; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7b/nDdeo9OwJ/1BWB36V3ny12dy1Q2mSpSFSLOSLpW0=;
        b=eB7kGJfdiHIhj7W/1tIPL3r2MAAcHQBAEfoAQuTk7t8QPuwXJXvlyr7/BmKxZsgsFX
         Iq4qo7X+I/iWaZ+0vkTfILlBRu8JE0uUvxQKrPpZFRM3HWL6sK3p+MHkGYkzaZ8qC6HA
         aq/UEqooLTBeo2VlWsYLOPH7qNa0goiWnG4pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795478346; x=1796083146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7b/nDdeo9OwJ/1BWB36V3ny12dy1Q2mSpSFSLOSLpW0=;
        b=cIslHQHQixq4ETYUG+jrHnAnorL5oYMFmF18vGmbsDSENtrOtlg0KKxkmv0+Cj+FrB
         9/G3MnHs6YEagdSlNq3mck02OAODF5K/iGjlCAmSSW4xQg9HH7DBFO4QTQr50rUQZzT6
         StRbbPjg4lQpTuaqcZuMEMurRbC4K92mBtlOEhwC/9LS0bSbWSFmZZd8UQDAikJh03aT
         PupwoIGP+JAHG0A5UzPXREMHVmQVL7Chi2ZbARsLuCpeOxCKRn9IzcKEpLK32yLkAJGC
         HXJTtMheDYgpmvjZMWwO9DR5JVyIYM0aY82pw0TJOeMycecJAG8jRUOkSU9Gar5FTI40
         e5Vw==
X-Forwarded-Encrypted: i=1; AL+hErHDMDcCIVCue1IkUwOykalS8bxf1ETwg1K/wRwbs+qr1uc2iJRBjY23BeAC/3WkvtbMlenang==@lists.linux.dev
X-Gm-Message-State: APuU4Z9lCivAd+wS5VM/Fc5RXCHL4ozbysPTXVUL+8gh9DBaJc44eeND
	2hUdd/OeHd4CrfHon4LVXNupBV6AvR54Km1Wihic2GjzM+/TbBHcEKN74YWFzp1icg==
X-Gm-Gg: AZFdTZc0MhGdh18uxGFhT4ZHxuPvdzoptVI2VikFB5wA+mVQ2BxL1RKTlRqlt1epXHB
	Gqq0tc/YCjv4XEZGOeb5aNju419YS8wpOwQL5D0ZBffue7qLJgCrGiS5VS/2VnVzlzyTWos0C5Q
	njfLYYFJfVUz7knaKmkXEfBlkmxUCf8YOASG6os2sPKf7MUnlCiYeQoVJFA7+CrT9orHRH1Cip7
	MsEnKXIQnfW2Xg40ogfAnsbqIQiL1YyPWXd4PwAYoNkIAgLMByjllca4lyI0iSH9ptbWda4yn6h
	yk7e/dIENjlHwsvvZJplM7eOo341K/A+ICnxKN9diyxC6cr8AKtY35qyZ8B3o7pp7vk4H4lo1Pr
	wjc7A1ZxVLm6iA9AGXWUlmujhiMImykUxm8yG4Oci2hMK1ZKD3oRye8XQCZTEkzbJOKjjEINxh1
	AdT+CN9OtfEdBS7yZNarn7aFavdZrWBrK9UMzK9o51nBa0og3uJ0337eLSuit+Dj5W5LXiuCo5E
	6yDQBDQIwPVblY41P4meg8Rqs4PDZewmpi3Bcg82y+vKSBVBQHzWbs4DxOLSS1ObTk+nax4tGQZ
	v+4rYNnHpJE/rsdx/4FcPD5dhPLpuxQPNMjGMUVuUeieqlff8Jv9v8kLhAlyQ2pFxKr8X9FYgyg
	yKDA0X/n6CJvs/6NTNA==
X-Received: by 2002:a05:600c:1d86:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4bb88922972mr271555435e9.34.1795478346401;
        Mon, 23 Nov 2026 15:59:06 -0800 (PST)
Received: from dmaluka.c.googlers.com.com (120.142.205.35.bc.googleusercontent.com. [35.205.142.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm25727068f8f.59.2026.11.23.15.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 15:59:04 -0800 (PST)
From: Dmytro Maluka <dmaluka@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dmitry Torokhov <dtor@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	iommu@lists.linux.dev,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Joshua Peraza <jperaza@google.com>,
	Jesse Barnes <jsbarnes@google.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rajat Jain <rajatja@google.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	Will Deacon <will@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Tomasz Nowicki <tnowicki@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH v11 1/2] PCI/ACPI: Support Microsoft's "DmaProperty"
Date: Mon, 23 Nov 2026 23:58:28 +0000
Message-ID: <20261123235845.564027-2-dmaluka@chromium.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123235845.564027-1-dmaluka@chromium.org>
References: <20261123235845.564027-1-dmaluka@chromium.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajat Jain <rajatja@google.com>

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
Signed-off-by: Joshua Peraza <jperaza@google.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
---
 drivers/acpi/property.c |  3 +++
 drivers/pci/pci-acpi.c  | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 8ee5a1f0eb48..77f97e5fa20b 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -56,6 +56,9 @@ static const guid_t prp_guids[] = {
 	/* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-99a5189762d0 */
 	GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
 		  0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
+	/* DmaProperty for PCI devices GUID: 70d24161-6dd5-4c9e-8070-705531292865 */
+	GUID_INIT(0x70d24161, 0x6dd5, 0x4c9e,
+		  0x80, 0x70, 0x70, 0x55, 0x31, 0x29, 0x28, 0x65),
 };
 
 /* ACPI _DSD data subnodes GUID [1]: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 1150f2fbabf4..5971ffc2a375 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1427,12 +1427,34 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
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
+	 * Property used by Microsoft Windows to enforce IOMMU DMA
+	 * protection from any device, that the system may not fully trust;
+	 * we'll honour it the same way.
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
2.56.1.831.g720f3f5937-goog

