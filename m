Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3403D301F
	for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 01:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672623; cv=none; b=LIRRn5Iqm0Tpe8D5bElpqNg1ym0TCARI3ik7F0vRXoO7CRTA+Me/T1P2y0lJ3l9bYKJiHzl6Lh7He9yRlHIHeJtRh4QJl4Q5h9s8t4X9ID1+b2FQL4R68ramnAAYnecbsI8BeNpgUAm8ksNVYj6J4CVzum3xKQiUs8BQ8FFFuYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672623; c=relaxed/simple;
	bh=RDhxRkj+fQC5GkdMmEU+HuM/xovB5ghQohfAA+HLkWc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hw00QXoeOW7d8lYDkT94jJ2ahTucOyn9qXfoKgrFA3+6j0fcg7fnEKNgxpgoAnZ4Pmky9M9dcQBsDBfe1eENcQpFJlb4GgjBG1Ho99DGZrA7DGSU648XAseP1vf0glQq/PhQSUnlJIJo/Vd1sXwRDY37rDxcgVeD1ZeMXXfijRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IW2AmiTs; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IW2AmiTs"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e048a801dso483683b3a.3
        for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 18:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786672621; x=1787277421; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v8ere0bszt8rYKCYre9UsvLcJK/9XFe3pK0sfX5UEzk=;
        b=IW2AmiTsmUwOeeltDUTfD5QYVBrh69Bhlfy3nuWv3XqSoGMG1ujWTX+txXq6GXT1jW
         HYka+6RAydxBO/Bz7HWOnD/6HL1DhyMGrJD42YI4Njh8GtIIIl/fz5nb3N6gnh4+Bfel
         KE5IzueGD+Vhn8/3dszzOqBz+MWqN9rlATYgjyvKHH9YK38I1NrYpQzwekrMeHhuBNLR
         BMjIcMSJtJXLBvNfN9G4NSTP4XieA82WjpeWaZpBF2yN6GZBibHJR7C/9NaAL1fDiwu6
         nCcJLWBYhwo4MXEpSlU0vt/5/s5M4kEhZUf6JzXIaq/hR7zPh0ZF0IP0bLj6dJGxmh22
         UNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786672621; x=1787277421;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v8ere0bszt8rYKCYre9UsvLcJK/9XFe3pK0sfX5UEzk=;
        b=rDqKZr3t7QPIj27X0TN5rGpe8pq6bfIAJ2vWjYNchwPVD4tJU/omf8vQqLaE/xI2C/
         Ftu7zn8+sDUuhB3hWYTLH65pupEEQ5BjZqRcA9ZuEbzPlKk+XTB3E9fn1oWfim5NqXpm
         jlCInoi3TzxyM5QOFFCU5F19eBfZgjkgxgxdGpXlalSRXu4sOfQJk1V6uJursrA+f+1l
         lEtl5juiMCk78Rv4yWDedz5iS2NeONktULtVXidmd1BLSp/ydarOqHlPjd1CGXaqJqyY
         KFj2nYNdz1nVBLCz28r03HbgTWFQphrCuHmckB+i0jtnHY9XHzUs82QMiJnC+J/sDMzl
         oJ0g==
X-Gm-Message-State: AOJu0Yw8Il/8jfog8HxaRA1TlLciRJfk2rip1u9hyuFeJwR+HF9tpk/e
	JjAio9+A5PViqgqK8R3T0hGKwswZR0GyUP5NPNL6VuAd9u8t/9slfXKv6L87C6I4gtspNH9MHBB
	LjBSuDZFsE8TgQsWt0Pn8w6uMGA9RgVNclWb/xD7U8EUOC3PILZx9/VZV29DGAtJbRyjJf23wtx
	meVIhGCNMU1QJuVCHxJV8GAVdAuIxz6Q==
X-Received: from pfbfx11.prod.google.com ([2002:a05:6a00:820b:b0:84a:37df:a3b1])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d24:b0:84a:6540:3389
 with SMTP id d2e1a72fcca58-84fddfdf59emr2209051b3a.10.1786672621113; Thu, 13
 Aug 2026 18:57:01 -0700 (PDT)
Date: Fri, 14 Aug 2026 01:56:47 +0000
In-Reply-To: <20260814015647.3370124-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260814015647.3370124-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814015647.3370124-6-praan@google.com>
Subject: [PATCH v2 5/5] PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
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
2.55.0.691.gc56d675ccc-goog

