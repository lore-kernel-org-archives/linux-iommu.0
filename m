Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8843451B3
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779748832; cv=none; b=JdG+2Iw/5RmC/eMARRKZzuthVNL1s3Y8NdJfCB03syEGtx6bXwzMSl3TbrktVuH5GtCJPNC+rYqgO5rhovffVrtolMV9lzBFXK3KEBZ6Vp9W+CaSTnStHn0DbAv1LuHuzaPOLZUeGUDSPnF9bKHPVZ8lq3uxcbs88pFXkiVRJRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779748832; c=relaxed/simple;
	bh=2RzNkKwetFofmnxT1tcNG47QenWWWU9I7On/kK57yZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZRDCw2Wch8K+d7Xw4YEhkUEy/DKKhj7ClDWlr0huk4w/44EQPBHT3GqQpN6f3vVMeuqdxelaPhWzCiTRfKvvYK96CgBmUIkUzfx36+erRfS7JpyE3bwGgecV8dRTZLwt9rRkTqz9W0LCueEPlSgBC1Lio5xpOVUYKDr0z71il5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j5emE693; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j5emE693"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d75312379so8352183f8f.1
        for <iommu@lists.linux.dev>; Mon, 25 May 2026 15:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779748827; x=1780353627; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FCNEMRfVAfQ2RnOZqQgzm8k10hADzyebYuU6fM/XQNQ=;
        b=j5emE693/DV7ujpkMxuw9RrvtkLBpLibPP/JL0O+3hM6pM3zTWjKvp7rifKtVX5lxu
         6piXZzyNs+cpqqol1bhXKHJ6bIZYjfKxS9TzVYYL+g3hKRKMe6zjmlAI57TzH7EHefut
         dJRlYQAtrWbQ7vPmyTUux2u9F5o+8iAZpgPOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779748827; x=1780353627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCNEMRfVAfQ2RnOZqQgzm8k10hADzyebYuU6fM/XQNQ=;
        b=VliF1/ZX7P1rcX1Pf4Q6sXWqr+9/UegA3Fb6ZUv7On55k7wa6u68SrSsyMpJHIIq77
         5Go0+alblOxjQ6HMaPLiMxVc6+cLCM7uszjamQoIEeTvg7nVmIlfD8uZDX1EM0L+dm45
         1U/I2VlZpS+dq5ZWR0hzKSs/bc1ASqrGIoNhA7O09S3FYKD7/vT5y15xuk9lplgujUWS
         LKskb+F1ndkKZenrG+RYJroGLkFiXOJv78KdSLebvU4Hr0t85M7Z8l/FPAMlo/GvthUX
         0ze+k2q1AZV0+S8vKWkc2gb2wbRMWsMavvKeRX5DSK+yIHzaLYegkYOntQ1MCTxeNUSI
         nyNg==
X-Forwarded-Encrypted: i=1; AFNElJ+2C9qKb0jN6+IwkZ5V3IfXsrW0/teaBnwBY7CxrmcJCFDxbkvMfft1RlPxR9JH8ucHiKbDcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyw5OdihiMDiYzJFVeQbzW/j9brIYnffpeXbbs4ssHzgM1boYoO
	aBOicINSFpkEP3nVPkyK0cXP8bPSSlhsIo4ocVvLtteMBUojspwnXzww54RmfVksBQ==
X-Gm-Gg: Acq92OFwmDXRnx8Sg0Q6CsmLl4dtoPfdS+d7zoowfpMzKQVHIHp3dAdVXIWyd0RwXby
	S0lV4kSlhRa7kgt8dRGJitZgvVLHt/Nxk1oACt5ooNFx44XPm9ZlniFcJqus8BM/rg4r+ZPtm+5
	EH8GgvZa//lhMHXetztcGSFDKQedO+jfuey+6KrFYaNOiStYThJEgYkFQNGGo95jNBhJQ8b7X91
	J9xoijUnvyTna5nT/5Po9ttB5nVB0c1SOoRWqxyqgBYBxw/xoLo04VHxwiPCUAD/E9nvMVdlTAW
	DyR/X37i7HHWZ4kxUn9J4H7fcVdIU9RDCDH7P1WBHqi47F5Yjs6mCf+UvI5C+HngtBR2LEvLBtv
	TOsxXs+zxBaYNrCbXRpDc7ofE3WK4GyJmXnB0AYC1+K5CuoD/O+fUh8AVGKmWz4+Vxv9DE7Zk29
	xLr3etqVD/FPoDM/bbbICuTsB3XJf1SlkQQ4RO6876xLAL8BIgxP6ZtrWQmiOt6ienGc2VB9iAB
	LB3T6n/+MKAlwNTjJOIzDI=
X-Received: by 2002:a05:6000:1787:b0:456:d742:8b4f with SMTP id ffacd0b85a97d-45ea315dd44mr31292058f8f.12.1779748827458;
        Mon, 25 May 2026 15:40:27 -0700 (PDT)
Received: from dmaluka.c.googlers.com.com (202.88.205.35.bc.googleusercontent.com. [35.205.88.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm26467837f8f.25.2026.05.25.15.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 15:40:26 -0700 (PDT)
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
	Dmytro Maluka <dmaluka@chromium.org>
Subject: [PATCH v10 0/2] PCI/ACPI: Support Microsoft's "DmaProperty"
Date: Mon, 25 May 2026 22:40:18 +0000
Message-ID: <20260525224023.2753569-1-dmaluka@chromium.org>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Resending a series which was last submitted by Joshua and acked by
  Greg over a year ago [7]. ]

Threat model: An overview of the security implications of non-strict
IOMMU is presented at [1]. This change is motivated by “Case 1” where
a DMA-capable device is processing untrusted inputs, e.g. network
devices.

This patchset proposes using “DMA protection” to mitigate these risks.
This has the following effects, currently controlled by the
“pci_dev::untrusted” flag.

- Separate IOMMU DMA domains
- Use of SWIOTLB if CONFIG_SWIOTLB
- Disables quirks in Intel IOMMU
- Disables Address Translation Services

The “untrusted” flag was introduced in 2018 in [2]. The motivation for
that change was to enable using IOMMU to protect against DMA attacks
from externally facing devices such as thunderbolt ports. The patchset
introduces the “untrusted” flag which “is supposed to cover various
PCIe devices that may be used to conduct DMA attacks.” The patchset
originally proposes naming the flag “is_external” but is renamed to
“is_untrusted” and then “untrusted” supposing that it could apply to
more than just externally facing thunderbolt devices. The fact that
“ExternalFacingPort” is not part of any standard is called out during
review but also that Windows expecting firmware to identify external
facing ports makes it “as good as a formal standard in the Windows
world.”

This current patch series was first proposed in January 2022 [3]. It
originally proposed a new property “UntrustedDevice” which would cause
the untrusted flag to be set. In V1 Greg questions whether the new
property is part of the ACPI standard and asks who is making this
policy decision. Mika links to Microsoft's documentation of
“DmaProperty” and suggests that property should be adopted instead.
Greg objects that Linux does not have “dma protection” but Mika says
that this is the IOMMU. Today, the term “DMA protection” is used in
thunderbolt driver code with the same meaning and in an Intel white
paper [4] describing the technique. Mika also observes that Linux has
recognized several properties documented by Microsoft but not part of
the ACPI standard. There is discussion between Mika, Rafael, and Rajat
about seeking to align with Microsoft on the semantics of
“DmaProperty” for compatibility with firmware produced for Windows.

V2 of this patch series [5] again proposed an “UntrustedDevice”
property which Greg objects to because it is not sufficiently
descriptive, not sufficiently documented, and policies about trust
don’t belong in the kernel. Rajat describes the “untrusted” flag’s
current use, controlling IOMMU and Greg suggests naming the flag
“use_iommu” or “able to do DMA.”

V3 of this patch series [6] proposes recognizing “DmaProperty” with
slightly altered semantics from Microsoft’s documentation. Greg
suggests adhering to Microsoft’s semantics for “DmaProperty” and to
introduce a new property with new semantics instead. Greg again states
that the flag being named “untrusted” is confusing.

V4 renames “untrusted” to “poses_dma_risk”. Christoph suggests
“untrusted_dma” and Rafael agrees.

V5 renames the flag to “untrusted_dma”. Bjorn asks for clarification
about whether the semantics of this flag will match Microsoft’s
documentation. Rajat responds that Microsoft has agreed to update
their documentation to have aligned semantics, in particular “the
property is not restricted to identify ‘internal PCIe hierarchies’
(starting at root port), but to "any PCI device". As of today,
Microsoft’s documentation does not appear to have been updated.

In V6 Rajat updates a link to Microsoft’s documentation, renames a
function to pci_dev_has_dma_property() and uses
acpi_dev_get_property() to read “DmaProperty”.

In V7 (Nov 2024) Joshua re-sends and Greg requests a summary of the
history of discussion about the name for the “untrusted” flag and
justification of the new name.

In V8 Joshua renames the “untrusted” flag to
“requires_dma_protection”. Greg requests more information about the
threat model, what does this property convey, and why we should use
Microsoft’s DmaProperty and its semantics instead of inventing
something new.

In V9 Joshua updates the cover letter with more information from
previous submissions in this series and the “untrusted” flag’s
introduction.

In V10 Dmytro rebases the patches onto the newest kernel (v7.1-rc5)
and applies s/system may need protection/system needs protection/
per Greg's suggestion in V9. No other changes since V9.

Links:
[1] https://lore.kernel.org/linux-arm-msm/20210624101557.v2.3.Icde6be7601a5939960caf802056c88cd5132eb4e@changeid/
[2] https://lore.kernel.org/lkml/20181129155153.35840-1-mika.westerberg@linux.intel.com/
[3] https://lore.kernel.org/all/20220120000409.2706549-1-rajatja@google.com/
[4] https://www.intel.com/content/dam/develop/external/us/en/documents/intel-whitepaper-using-iommu-for-dma-protection-in-uefi-820238.pdf
[5] https://lore.kernel.org/all/20220202020103.2149130-1-rajatja@google.com/
[6] https://lore.kernel.org/all/20220216220541.1635665-1-rajatja@google.com/
[7] https://lore.kernel.org/all/20250221000943.973221-1-jperaza@google.com/

Rajat Jain (2):
  PCI/ACPI: Support Microsoft's "DmaProperty"
  PCI: Rename pci_dev->untrusted to pci_dev->requires_dma_protection

 drivers/acpi/property.c     |  3 +++
 drivers/iommu/amd/iommu.c   |  3 +--
 drivers/iommu/dma-iommu.c   | 16 ++++++++--------
 drivers/iommu/intel/iommu.c | 10 +++++-----
 drivers/iommu/iommu.c       |  5 ++---
 drivers/pci/ats.c           |  2 +-
 drivers/pci/pci-acpi.c      | 22 ++++++++++++++++++++++
 drivers/pci/pci.c           |  2 +-
 drivers/pci/probe.c         | 10 +++++-----
 drivers/pci/quirks.c        |  4 ++--
 include/linux/pci.h         |  7 ++++---
 11 files changed, 54 insertions(+), 30 deletions(-)

-- 
2.54.0.794.g4f17f83d09-goog

