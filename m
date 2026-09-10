Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD944A3D43
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050434; cv=none; b=iqhzKGV0FfnSFMId5FfsQEBNN2OcWuYEdKCgbn6I7kIAhti2hGwarAT5ySyhSMBz8Xj4anlKvs4aosemzRoBY+uePbQF2yOYSxAxvtRKKKhcoOEF0KZb6Jsc8lHvHxpgLBurmRlu1IoeMJwlkRVBLcyrOgP25cp7eLNq5Yy8UPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050434; c=relaxed/simple;
	bh=0zK3NdZdAEIF+fY7bnFJa022HywxKyfReyEg/39UFm0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f9o/csoV9+mVdLibnR+5p5H/lpyB9+5pSdYQmWG2TSR89WoGdjQ9GrNxTceT9LU1doVj4iqeY3KE2bC38qXG0bNkaO7e6kJwPJobcFOdokpWS8hpueY43pJhmVO2s3mkxe0l/yuTusLumbcrQ0kziWI9x7vYdoZC38BUGsMhPpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9+Pcuqr; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9+Pcuqr"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2dc92350888so40414515ad.3
        for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 07:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789050431; x=1789655231; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6VbiO+0ZZ336AV1ci1nySmnPdcf0jBOH8n5u+L52730=;
        b=P9+PcuqrKAf1A+ILZ+Le1BgJsu9qn1GfWGx+tzQURb/xhuuYxGEZ9h/EYR2d8NuMtb
         8msjVTvw75viKNY5Q5GK6yZYvsUxACBGJOFAc0hMpPE7xT90Jarv1CTYDWFM/GCJ9Pcv
         sBZe/ukz9gCoWVhgnMBOdqEGXe5sz8pqJ3LpU0vkMOBsZmr/9FaPCqAkOZHvxTe40FU3
         UQRZAcRyFRAS0ARp3PTtwlIAtwSNcQv4Mf4q/JtoqGNbk1jjKUGVkgySovVcJeGg+1FY
         gfn4rPBOzOuRPOVOOudagUmqAAt/yMx/Uv9YTvdulIgVmPvBNtyDYqs0+yuUFTaeYBEq
         BEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050431; x=1789655231;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6VbiO+0ZZ336AV1ci1nySmnPdcf0jBOH8n5u+L52730=;
        b=rBZnre8ww0Kr7C6XZMlhgeRqxyWtUQRjV6cwrtRqxxrdyWzlnOYh+Q7t4MOMGuSrlZ
         3dvgj7xJ2+mYiymDntEPKNGpGaGM4mmadYyww0GBRXaNtD6TCGb6U5sR7JqGeE1GKLbm
         5sWxE2avJli4Z/thTrJ/yHwpzEeybvLr+4q5exH2X2cORm3qRYbRDFrNjxkWUE9AT+0q
         S1Rv3fQU5ffpGghlULkgbj/s/7lS/XyimgCaO1VOpLMZncbuWX4JRS8e1Z1p8o45RsBd
         YZfYnHJMmxwWXMVpEN+OESa4iv7s+HLsIFm2c5UhmPsPTlYduhnqv2UR6st/a/+RR14Y
         kzwQ==
X-Gm-Message-State: AFuF++l2BD3W0UDd9uNSOQOkSRAfiADTObPSFDC/KccnU7vdw9Vo8oe1
	K/RU64W868tVPUKSJwHSofl23RPDA7/w68YsLvOko7m7gGIZFAoFtbW5QJa0uecs8pzVGiog0gL
	C76LGQoN8ug8KCXallg9vH5xYtkIgKCoAk8opJQF+r1yod0JnSSWOoH6ac2T40xVMSXututVHG7
	UKiyVTMrlp34pLMVXAJIayiAf1wk1k+Q==
X-Received: from plkq16.prod.google.com ([2002:a17:902:edd0:b0:2db:49e4:272])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e548:b0:2d9:2fc9:5706
 with SMTP id d9443c01a7336-2dd077e0c3amr105542405ad.2.1789050430169; Thu, 10
 Sep 2026 07:27:10 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:26:55 +0000
In-Reply-To: <20260910142655.3281464-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260910142655.3281464-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260910142655.3281464-5-praan@google.com>
Subject: [PATCH v4 4/4] PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 9cb23780093d..f1434f86ac40 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -56,7 +56,9 @@ EXPORT_SYMBOL_GPL(pci_ats_supported);
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
@@ -64,7 +66,7 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
 {
 	u16 ctrl;
 
-	if (!pci_ats_supported(dev))
+	if (WARN_ON(!pci_ats_supported(dev)))
 		return -EINVAL;
 
 	if (WARN_ON(dev->ats_enabled))
-- 
2.55.0.1003.g10538fe699-goog

