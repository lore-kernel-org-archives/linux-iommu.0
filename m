Received: from mail-m3268.qiye.163.com (mail-m3268.qiye.163.com [220.197.32.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3DE431A50
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768427; cv=none; b=T1vaQZtmHv/oWMUvlQhP86ULk71PmXHuR+ODKXsDoIJi52n064obD5aT/PO1+8PZB2Tt8YJgeSNB8L61SLx9gCCEF39xU73eX2h+v+KQQ4QILJ4NOyOMONySRkuB65WnpWmkzJWHD2/ujs0W/Ue3PXNL4egmBF5hShQf99HIN5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768427; c=relaxed/simple;
	bh=talLoTtij+UAkEmWW9J4GgHZ/+d8CSO0ec8BjSHv8F8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VcFBTkXLRVBPUJayS86jhoVM2ODNlmS5SVOouz2jYTzqjTRvsHuZGUu5PEIqR72caRZJEMU0ZWGGVqblTqa1+SI5/I68IEb0asttjckh4qu0c+HGKqHz0zArlYW/0Tz8u0tf0GLI8/I5m3rRsUM/rEYOvJ38E8xE6dIMKmr5CSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com; spf=pass smtp.mailfrom=resnics.com; arc=none smtp.client-ip=220.197.32.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnics.com
Received: from localhost.localdomain (unknown [115.204.15.233])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4cc44d0f6;
	Mon, 7 Sep 2026 13:44:23 +0800 (GMT+08:00)
From: Ruizhe Zhou <zhouruizhe@resnics.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Ruizhe Zhou <zhouruizhe@resnics.com>,
	Christoph Hellwig <hch@lst.de>,
	Frank Li <Frank.li@oss.nxp.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: dma-api: require checking DMA mask setup errors
Date: Mon,  7 Sep 2026 13:44:00 +0800
Message-Id: <20260907054400.1088151-1-zhouruizhe@resnics.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa07a656e9c03ackunmc3184f181a2d46
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTx9CVklKSEpOSxhJTRhMTFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSk5VSUtPVUpOVUlISFlXWRYaDxIVHRRZQVlPS0hVSk
	tISk5MTlVKS0tVSkJLS1kG

The DMA HOWTO says dma_set_mask_and_coherent() cannot fail for
DMA_BIT_MASK(64), and more generally for masks wider than 32 bits. It
consequently recommends calls to discard the check for return value.

The generic direct-DMA path does accept every mask of at least 32 bits,
but that is not an API-wide success guarantee. Backend callbacks can
reject wider masks: ibmebus_dma_supported() and
xen_grant_dma_supported() accept only DMA_BIT_MASK(64), so a 40-bit mask
fails.

Even DMA_BIT_MASK(64) can fail when DMA setup is unavailable or
inconsistent. For example, dma_dummy_supported() rejects every mask.
acpi_dma_configure_id() installs dma_dummy_ops and returns success when
the DMA attribute is DEV_DMA_NOT_SUPPORTED. DMA configuration can
therefore succeed while leaving the device with a backend that rejects
every mask. The PowerPC legacy IOMMU backend also rejects a mask when
no IOMMU table is available, and the default IOMMU path rejects
conflicting dma_ops state.

Failure is therefore not limited to an unsupported address width.
Ignoring the return value could let a driver continue with an unusable
DMA backend.

At the same time, failure of a wider mask does not indicate that a
narrower one can succeed. Clarify for DMA driver authors that they should
select the mask matching the device's actual addressing capability, call
the mask setter once, and treat an error as a DMA setup failure. Update
the examples accordingly.

Fixes: f7ae20f2fc4e ("docs: dma: correct dma_set_mask() sample code")
Link: https://lore.kernel.org/all/AEEA1wBuK97oyrSN8q4l4KpK.3.1788520536000.Hmail.zhouruizhe@resnics.com/
Signed-off-by: Ruizhe Zhou <zhouruizhe@resnics.com>
---
This follows the discussion linked above about retaining the error check
when removing narrower-mask fallbacks. Is there an invariant that makes
these failure paths unreachable for drivers calling
dma_set_mask_and_coherent(), or should the HOWTO retain the check as
shown here? Feedback from DMA maintainers would be appreciated.

 Documentation/core-api/dma-api-howto.rst | 39 ++++++++++++------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/Documentation/core-api/dma-api-howto.rst b/Documentation/core-api/dma-api-howto.rst
index e97743ab0f26..a28be86666da 100644
--- a/Documentation/core-api/dma-api-howto.rst
+++ b/Documentation/core-api/dma-api-howto.rst
@@ -237,11 +237,11 @@ device struct of your device is embedded in the bus-specific device struct of
 your device.  For example, &pdev->dev is a pointer to the device struct of a
 PCI device (pdev is a pointer to the PCI device struct of your device).

-These calls usually return zero to indicate your device can perform DMA
-properly on the machine given the address mask you provided, but they might
-return an error if the mask is too small to be supportable on the given
-system.  If it returns non-zero, your device cannot perform DMA properly on
-this platform, and attempting to do so will result in undefined behavior.
+These calls return zero to indicate your device can perform DMA properly on
+the machine given the address mask you provided.  They return an error if the
+requested mask cannot be used with the device or if the device is not capable
+of DMA.  If a call returns non-zero, your device cannot perform DMA properly
+on this platform, and attempting to do so will result in undefined behavior.
 You must not use DMA on this device unless the dma_set_mask family of
 functions has returned success.

@@ -264,23 +264,24 @@ The 24-bit addressing device would do something like this::

 The standard 64-bit addressing device would do something like this::

-	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64))
-
-dma_set_mask_and_coherent() never return fail when DMA_BIT_MASK(64). Typical
-error code like::
+	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64))) {
+		dev_warn(dev, "mydev: No suitable DMA available\n");
+		goto ignore_this_device;
+	}

-	/* Wrong code */
-	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
-		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32))
+Failure to set a 32-bit or wider DMA mask must not be treated as an indication
+that retrying a narrower mask can succeed.  Drivers must select the mask based
+on the device's actual DMA addressing capability and treat failure to set that
+mask as a DMA setup failure.  For example, a device supporting either 32-bit
+or 64-bit addressing would do something like this::

-dma_set_mask_and_coherent() will never return failure when bigger than 32.
-So typical code like::
+	u64 mask;

-	/* Recommended code */
-	if (support_64bit)
-		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
-	else
-		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	mask = support_64bit ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32);
+	if (dma_set_mask_and_coherent(dev, mask)) {
+		dev_warn(dev, "mydev: No suitable DMA available\n");
+		goto ignore_this_device;
+	}

 If the device only supports 32-bit addressing for descriptors in the
 coherent allocations, but supports full 64-bits for streaming mappings

base-commit: ab2704c2a884028fd12d455cf27a9585aefe2961
--
2.27.0
