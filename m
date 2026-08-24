Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7C4417BF8
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574250; cv=none; b=WCkMbcRS8d6RtC5itGEOLgXWpyCJ1YhcCZXEL6iWj394IBjizoYU1c+Hi23GNFjntotL9of9ELhR872xu+QsYnkgCsrYlw/RAXUbpuxTU+Te69qFGmIuq7dbhKVykg+/33MCzSykAEK94eUjAELMVXjfoopBqmEyOa+ReW0QLOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574250; c=relaxed/simple;
	bh=jNseeDVtVzJoGR3jltiSHFPzw1Eo1RyIpEWV4IRj9hk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VHdZTufjJ5hS+1tut7xM41WG8GTZm4RPOhQQ+TK1le8atbRnliNCZiFMfsIqg39YvRF3ajU1hxLjDlTyhQnpvFyMrrUsUFOlS8pjg96CmW3ojWI46xJQ/+hK8MwL6h4xTo+LBo5s5r0rnk+LGhL52PUSlDx4yxmbKFt7ASBH5X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rM2Tn6C6; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rM2Tn6C6"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso50669945ad.0
        for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 05:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787574247; x=1788179047; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1mNxTLZ/5W01v+NT9cSmg670gp92Y4dFCPueiXmeaNc=;
        b=rM2Tn6C6jZFBN/xvgaDhiKcJfx35BtaQL1G6zSVUuGf0S39er1sJW4nnFY7ceA4k9w
         q6fEInd8uOoLw20O0Y6LQqHDhC4k4gzgVxjUxSbRGeDpoInDMI/bMW1j/5WS61zc71of
         7nKJTn0nvS8zV6NwDce9+untRBpLYq2hpY0boBo45BuyhibvnfSVEGRBW42jVen0APo5
         7GHhBjR/pfGJkVI0cfI+OOa06v0DA3eC5pStxbjpeenaNHXRxCkrXPFjd/biaBIdo2hi
         +BC/7tjqk2EX39ezg/jOBNkJIWxgcLJbfYe6Ure7B24+fEnOgmp/+wP27FU3AoiIPSud
         zcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787574247; x=1788179047;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1mNxTLZ/5W01v+NT9cSmg670gp92Y4dFCPueiXmeaNc=;
        b=TJBO0REPr5GuVBJszoykw1gbfIo9bokJ8qI4ObvOWDnXw0KYMkT7J3Zj1qOKhlHro2
         FC9wq0Pj326xhJOtIN/iBaHUiCgvZsTFqCCn74nARG1oLKrpeoacLDHtvp23xfwG0C1M
         d455kh3AI0a8TfrYPCyw1rq8m1bVlFQwH7ggWQFzCCZnSeyUpVPOqmNKKwSEmLfli9Xz
         B2eijsAySIRbpjMLT7TucjfoLiDwFd7It5CvOLW0UD77StMeo/IGx+YsggVNXBbnz5hB
         uRTWmE3BOMv6CwCZef0+wObkCT5b70P6hjqe2o5/33ueJtqCZ0DxG+BRjOjWLyhODoJy
         iGHQ==
X-Gm-Message-State: AFuF++l+OIOMtNC4p1i5jq/tiKToLf6/l/lvnBBS6NtF59EWNWmVCmQA
	Zb8EYSR4BRa6I4QHZZfOhPaeWj5fWmse9bAEuR7gsXfKC052diPtBOE0dPXxl6NUuK3laChJl7M
	icfIFzY6Wp0mpOOOyClH3drvQPEmAc0fOVXY3TRIFuDwrReBEcdrnhJYEIbalinu90BPsJ7csXL
	zCP2KcWQ8qp82XQLY4VLPupm096gh7mA==
X-Received: from pgbgc27.prod.google.com ([2002:a05:6a02:4b9b:b0:cc1:5076:bfcd])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a10a:b0:3c3:8d86:9856
 with SMTP id adf61e73a8af0-3cd3013d226mr39966076637.14.1787574246476; Mon, 24
 Aug 2026 05:24:06 -0700 (PDT)
Date: Mon, 24 Aug 2026 12:23:47 +0000
In-Reply-To: <20260824122347.1588592-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260824122347.1588592-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260824122347.1588592-6-praan@google.com>
Subject: [PATCH v3 5/5] PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Baolu Lu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Currently, pci_prepare_ats() internally calls pci_ats_supported() and
returns -EINVAL if the device does not support ATS. While this provides
a silent safety check, it conflates support detection with configuration.

Update pci_prepare_ats() to wrap the internal pci_ats_supported check in
a WARN_ON(). This mandates all callers to call pci_prepare_ats() only if
the function supports ATS.

Update the function documentation to mention that callers must verify
ATS support (via pci_ats_supported()) before calling pci_prepare_ats().

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 96efa00d9743..f18c06b73eb2 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -53,7 +53,9 @@ EXPORT_SYMBOL_GPL(pci_ats_supported);
  * @ps: the IOMMU page shift
  *
  * This must be done by the IOMMU driver on the PF before any VFs are created to
- * ensure that the VF can have ATS enabled.
+ * ensure that the VF can have ATS enabled. Callers must verify that ATS is
+ * supported by the device (e.g. via pci_ats_supported()) before calling this
+ * function.
  *
  * Returns 0 on success, or negative on failure.
  */
@@ -61,7 +63,7 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
 {
 	u16 ctrl;
 
-	if (!pci_ats_supported(dev))
+	if (WARN_ON(!pci_ats_supported(dev)))
 		return -EINVAL;
 
 	if (WARN_ON(dev->ats_enabled))
-- 
2.55.0.766.g2966f0265a-goog

