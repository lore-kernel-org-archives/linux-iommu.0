Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795478343;
	b=auqAqNIDSFz7TDl7Zq3SE5Mwjgg/n/ksPNtNORIvwoA0E/We/3K2rhPDSOa745SRIRMj
	 MT2z5xA0QrXIokSTOKntHcnW2HI+z+H1XWxm3C/tV4GetbppjZ2f7wuPaqDW530VJTZes
	 vmVAJGEisgHmZwR84PFaePgURQxM+y3a/wAHXeIY9KjU/z+FDQ3Da3Hog5POM4RVeDQQU
	 C6V17oHBfZ7QmEyB8j5VqVLalY7TM5DGatg7WlxgQyBk4QxePZvFED/s2WRtQjdJD2sXH
	 IVhPklDZFT5+ZnoSqd1oc/9YRZU6KM8rqAdijcU5HGq8OHrtKlZ8+/Fen81sUbngs7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795478343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1KEZlJHY2iJZV5bGkgX8FT1FWywheNVCNg2fp4w3t8o=;
	b=VLZDGdQABMgsSy+mSQ1O3Mi0JnLYEGQBUH/uPyB3EY6Kzdz/3ZfW96pQukVzLT4933H5
	 R/gq1LjX7kUVNWmmmRHVgJbtjJWv9qMDDC9pUC5Zttv3K6rAyCQ6V+McnTHkNdu27JtfV
	 wTw28f6iFRtr+ULxMZ0DZX/IT9lq1ZE/EqLbLoHcib0HW5pi6aQhG/nxqY5LlWNVaYwj0
	 JGlCd0zR4N7ZbX/Ls0zekPB4dXJVTeVDHq+yAQtUUSPNMmrmRx/QyDzSXLspm8xPaKbh0
	 mYFzaHqkfB62si0XWufSlmBE9BhF89APYICxwcXvMDE2e+2kQWFZEzFGCDlzSJRa6LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=imBAzJjA;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACB2606A327
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 23:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ACB2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=imBAzJjA
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-49465892f7bso2816916f8f.1
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 15:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795478341; x=1796083141; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1KEZlJHY2iJZV5bGkgX8FT1FWywheNVCNg2fp4w3t8o=;
        b=imBAzJjAQD+KGJGhv6mNam8K+jcfJUZh3G45ncLcpzgxKzMlJMX33TA7Wr2TOFqAt2
         MZ01R4s3XZZ6thu68bpb3Fs8OPiSRZT+YSTj0JuKRNcIZwHgSUSiwOTSD0Z/d7z558mD
         +9onTj0gAOlNf4gPmg+5gZ2CtZoaolRxwY82g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795478341; x=1796083141;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1KEZlJHY2iJZV5bGkgX8FT1FWywheNVCNg2fp4w3t8o=;
        b=vnpBXru07F79HXLRfXNiIDqvM78rOw3i/Uz20JB7AzX5rtcAJaHD9RZrKU8V/qmAFU
         gUi9gZ0vXKGgSLC0y6jMReFmn7Ve+K4JJfPJXq5dD+IZYLwcjBqslxRIPoGkzbnxUMLz
         YqkovS9hKRbcGAqTrdxZydJIK7a4K5LsjgqZZTOGYpOKMNZHInBslKQOv3e/vJ5q1n96
         YY0fMUnuZ7tebwoA+4YEFL6c4dhw/oL9uRp7vpvA1OGn26mWN8CFtO7pNMM9Pt82Thg3
         GRep7fcDDavvrjvhbUqw3uGcW+33GZxPlryS1hQ8/krTYErXDly2iirvImcBtrevfuva
         4/4A==
X-Forwarded-Encrypted: i=1; AL+hErH15/dpwYE4ofdtBa9CvkWn/kZ7dmil12IAoin/c3VlULDtEZmkGz/KnbMNZ85XXy+4fIkEGA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9ZH4Z8ioIJf+Qn2R0zNR7T/mmaYkc6+6Aq62135j2p4kQmPWiT
	mCDi+lcKUocwRyqRofeUdcQDMvibClZrXI7vIeJDudI+aNte9lGeVeVD0cWI7OXHhg==
X-Gm-Gg: AZFdTZf+oUyaeyhA2z81Ag6FIKbS9syLJfVkHpjGXcb6qjDto/PLn19iLcMCupGxDqs
	/xMyadaJtlqIglThLs0cIi5TgNspgKPHoxa2PaQ9vzyYSsBxaVuOZy2Eit/7mAlgKZHCou0Wqlq
	GKd0wyhcVgVXMZcipxy7Q4jCuVv89y8NErqaBjAElqeh1vEgJ3q1XXTqit4/i6c6l8OyHYroUSS
	lhb9F5yWWTDqBQpDWHWi1niIm7BdvRZTocs9tx+X7HdbcdAYfHarD6oNNkWMZtEtcKi5woS5K8z
	L5BoEF9evLnBIJAQAB+/3Lkp5ZxrL4uNWBi1GJ//Jw7QY3GBLMFupZR+s40K2RSCApzoJqxifwA
	2mENakXE6Ucgvs7eDuUgRGztDCM710QZHvzrNLFGtNuwtdfT8Xx2HDzvZ4xw+cUh/BqLRAah4Kc
	kb1D7UXk1X+6O1r1fgH63X6h8REs56M91adNr0B7P+P0s7q+xfja3Ux2sNiT1O8wlMHJmBYB8VU
	OzRqv3jCdLv1paxesdsSY5em7CTyoPmRugtyeBP88+7uZckkm2tAqusaW36onL3fnTZCSqWm2kq
	iXfz9RC2QLNQT5xDa2Xxqiza0q8I2V1YhvBK8/fCybk4f+ZupRh4sRNMQBJvBFVkQj25reh9vcR
	wT4Hkm4xz/zuKDNKqug==
X-Received: by 2002:a05:6000:40c9:b0:4aa:f8a3:3cf6 with SMTP id ffacd0b85a97d-4abb3955aa0mr26517246f8f.30.1795478340984;
        Mon, 23 Nov 2026 15:59:00 -0800 (PST)
Received: from dmaluka.c.googlers.com.com (120.142.205.35.bc.googleusercontent.com. [35.205.142.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61e53asm25727068f8f.59.2026.11.23.15.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 15:58:59 -0800 (PST)
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
Subject: [PATCH v11 0/2] PCI/ACPI: Support Microsoft's "DmaProperty"
Date: Mon, 23 Nov 2026 23:58:27 +0000
Message-ID: <20261123235845.564027-1-dmaluka@chromium.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Resending + rebasing a series which was last submitted by Joshua and
  acked by Greg over 1.5 years ago [7]. ]

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

In V11 Dmytro rebases the patches onto the newest kernel (v7.4-rc4).
Also collect the links to all 10 previous versions of the series in
one place in the cover letter for convenience.

V1: https://lore.kernel.org/all/20220120000409.2706549-1-rajatja@google.com/
V2: https://lore.kernel.org/all/20220202020103.2149130-1-rajatja@google.com/
V3: https://lore.kernel.org/all/20220216220541.1635665-1-rajatja@google.com/
V4: https://lore.kernel.org/linux-pci/20220320062907.3272903-1-rajatja@google.com/
V5: https://lore.kernel.org/linux-pci/20220325184609.4059963-1-rajatja@google.com/
V6: https://lore.kernel.org/linux-pci/20220426000640.3581446-1-rajatja@google.com/
V7: https://lore.kernel.org/linux-pci/20220426172105.3663170-1-rajatja@google.com/
V8: https://lore.kernel.org/all/20241118193024.2695876-1-jperaza@google.com/
V9: https://lore.kernel.org/all/20250221000943.973221-1-jperaza@google.com/
V10: https://lore.kernel.org/all/20260525224023.2753569-1-dmaluka@chromium.org/

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
 drivers/iommu/amd/iommu.c   |  2 +-
 drivers/iommu/dma-iommu.c   | 16 ++++++++--------
 drivers/iommu/intel/iommu.c | 10 +++++-----
 drivers/iommu/iommu.c       |  5 ++---
 drivers/pci/ats.c           |  2 +-
 drivers/pci/pci-acpi.c      | 22 ++++++++++++++++++++++
 drivers/pci/pci.c           |  2 +-
 drivers/pci/probe.c         | 10 +++++-----
 drivers/pci/quirks.c        |  4 ++--
 include/linux/pci.h         |  7 ++++---
 11 files changed, 54 insertions(+), 29 deletions(-)

-- 
2.56.1.831.g720f3f5937-goog

