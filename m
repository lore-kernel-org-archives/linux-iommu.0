Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CED3D300A
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053142; cv=none; b=GXxJ+KXNG+d/62mk7Txt1TYe4AE8CVIqCQMPN8HH53ALg9THb+MgWDTTBM9sjN49J9QRTA9sTt4AT84d5M4OI2BmwHvlE7aZa9MCRGBh+0zqO8s1MUVWcmy3U6ZbzszO8N8q4Qd0iA0adi5fsxIV/zwZ6Ho2a1v6jrgNqieQra8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053142; c=relaxed/simple;
	bh=utNKQCvUkPmBqehTN/p5pEe6fKwGdjlepuYbZLj1XUc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kr1XjJo2bmPhUUDPRKiPO5u7CvJBd24/qIdqM8ZiN3GzraJrP5etCUPcSp5M28pdsIB1eCTDW6DlYs2U2FGfGUf7nJvqG0tRhxNEhtZXghgdpgq3+Y8GWRVT4ntAc/pCYhyl+6+JzmovqLs++ber8snkOBzHc1V6MDUljqZK6dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MlAwF1AC; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MlAwF1AC"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f9429f49cso18545244b3a.3
        for <iommu@lists.linux.dev>; Fri, 29 May 2026 04:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780053139; x=1780657939; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KwPPE5/66gX8tYQEwBiFqJ6gT9Mjq1jN4WhTwmvmXVQ=;
        b=MlAwF1ACRleu8R94XZ5s4wlxAupvn1GoEyyx/eQv95lVBXZicB3dXRmtNejuPFdvCN
         AgJhFH7te53eqizzhEsjIcOh/GzZgb/xV0Qog4EAkdRuQjGlT0YMLy5nZO2vb78gzHWk
         yLaynV+8bDDqKNWSAlTX2ZukeYOWf7axP3FWOguWwfWtBIlMsn4JQkdFlJQlsbU7PIyX
         4h2IVyhtT0gu0nJZg6pkDHEwEZ+Yv72jnB3YbBwNiGBUEvjjAIN+NNmcWhxlbminaSdY
         hRzP/QUUlM4mhCp6QuGObU0HLf3hw82lSURh5QanpllrsrMBqMSj/InZxGaUdoTwpd/K
         vr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053139; x=1780657939;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwPPE5/66gX8tYQEwBiFqJ6gT9Mjq1jN4WhTwmvmXVQ=;
        b=GJpIX3gk3UrDygY0UEX6yiNhYUACakCtadSljFZ3/JS787cvu0k7dM/61TEVdFlE0U
         5Ve5fBYS11ot+TZpdfmVYtD96zEeUfTCnOAtokFsOXCkDJE9lkPkiNFENcZr22w/SEAF
         Ng67jd58JvGKMfQZ08+hs70e5Mgj2irrauidB3r0Z8rP/WxBJ8KaGVVQUop9b+5+qF/T
         /Mgmj1pHusf3dgqP3KSXC5HkSMwZdDPOOj7+s3d0OrMd7+JMKiNs0OVQ8PHmqhJmYKRM
         rKRWI7L6Imfud2XC1RE1y3ISqKXW2d9fuVcUADu5Jlqlt34qXxiHf+9q/EVoXHVoRGeS
         3ghA==
X-Gm-Message-State: AOJu0Yy+imsxNbHm4tJXRV0WMgIBO7EuB/p0IA7kJKP3/e0n5pUM1WMp
	/CgKeAchYgIbeEvNcxk9l76wZ9wkGpjfNeNLhR3L9omskQ7msWXJ77Vkj0UH5zykznEcbtN1zxP
	FZrotz5azWXHwZRmbhVS0nfUOvXQucCbhRmbIvMyg6hcsLITWW/SZQp8LUogIskCEyC5g11PLIA
	uX9xgmnxFjomhSUm5gSzy1tJN9Ae8/pQ==
X-Received: from pfbky33.prod.google.com ([2002:a05:6a00:6f61:b0:82f:b6a3:3dbc])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:14d3:b0:842:994:93a7
 with SMTP id d2e1a72fcca58-84212a7f6a0mr2674296b3a.5.1780053138377; Fri, 29
 May 2026 04:12:18 -0700 (PDT)
Date: Fri, 29 May 2026 11:12:05 +0000
In-Reply-To: <20260529111208.387412-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529111208.387412-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529111208.387412-4-praan@google.com>
Subject: [PATCH v6 3/6] PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolin Chen <nicolinc@nvidia.com>, David Matlack <dmatlack@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mostafa Saleh <smostafa@google.com>, 
	Pranjal Shrivastava <praan@google.com>
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
2.54.0.823.g6e5bcc1fc9-goog

