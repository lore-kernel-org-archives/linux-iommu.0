Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E60D3AB273
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597290; cv=none; b=OnpmvHW0AOQph85pvUPiCbsS4gfkSBmWwJXxg6rCyow2vymzx6Vl7qCGGVTJ+cOxAqkE8xW+27+pVz1SMLaOjfm5Bk7KBBf5dde1qtw5k6YBT7MHoKT5yf/0CJ/LcuNdKtq/dNabwl1dGIfsCISInK8Y8CKMYbRSSeDd0JEMg7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597290; c=relaxed/simple;
	bh=VqiZ8kNwgyZT1T7foVFsSLZBWEZ/w4HCqD6vFQ2562k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AC2PkMWd/5ExzP4K30NiwQ2Lf/eHkiozBjg65a1EjYTtw1WO72Mfd7A3tU2cgwnUlXbuuRcxVBUN5AeUk73IT+Rq9agsgHZFxqcoU7poOvRE1xQdmg2itR9M4nc1ef8x4NW37TtMfd1b7p4SfRFhBcPaOVcTXgAtP6DZEDiw0Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ScGNx+AR; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ScGNx+AR"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c32faa62so19535865ad.2
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780597285; x=1781202085; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=niiDq+FrdndFbib0XcxUBpiQEuQyYsWQAOjlvRNMMQM=;
        b=ScGNx+ARvXOxLk7I7fRdqV44IjAZwjGPCRlMirOJO+0mTFo0OB4G91B3/wtP9IQPbb
         pXFgCLWdkHy+fcGrGPTAin7mKK4Y8ReZeSqmdXg57kQFdDD0MR7rD5r2Vxp6LBnw1KNK
         zpdAjTw2xJVJ3F5bahQG/n14RW7aDOWr+i/aaYeKeXOmRqFY4ugv/gvBWWUJv/MZZAeM
         5azwDfX8UdPP+e5X3epfbsuVr0AUM8jo0WmAu74F3nYox6Pc5duJ/Gl6a3u9TZPyjay5
         FF5WsriJOzOEOreF0gnftYYk0WUJ575rT1DgiGu48sR4dG+CJgnVnyT4Wv0xtN/8xuU/
         qzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597285; x=1781202085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niiDq+FrdndFbib0XcxUBpiQEuQyYsWQAOjlvRNMMQM=;
        b=rX1kw/0fExXzbKvr+5Ny36t6iNS5ZfKA8iUgei8gqSHcqJ9tACDQf8JZ3HgV9sgtV7
         EGNMZGQhyfJOs1oQI5HPSOkIjz/yHGij+nS3FsfJ7kV+w07XjUWwZuxeoedwd7xEd6Bw
         0e/M0ZrqhhKICxce3rEOrvn2zk/6xnHlShZENcK4jjMtaf9DF50tNNzUqxkvig++4ou0
         Og3cksF610r4pdrT3F6Nohuoa0pcM8wCFmE/B3r4W2Q2on+2FWIfXjzWx6mj05Lg2GdH
         mHrCsdb7W5QSeslTLM9wOqKtGd9kiE0P3qKrYJSi3qR56lRsj+A6v63XjQjxdns+1wB5
         JWEQ==
X-Gm-Message-State: AOJu0Yxx3Tf10+52yws3mWfIJj2bIwmgJrXvR86BGclhKcOHAkueJ6Ra
	YErvZq0QdUm5KchN0RG7p3gnzprdxZrvg509PxVJs2v7dPDflSQNmJnUYH+b3l8ew9fQfFJIu8w
	lOQ3/suewfYgYG4r0ez2wEsXExGtrjMWOcQM1g3G7f35AkuGlJ7+CuM+yoLmtptBtc33cS7O49/
	Ddo9kpvjrDaY71e42KbXQ5sKVxE1okYA==
X-Received: from plbjz14.prod.google.com ([2002:a17:903:430e:b0:2ae:41d1:278d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e74d:b0:2b4:5aff:de60
 with SMTP id d9443c01a7336-2c163fa48efmr102370015ad.22.1780597284995; Thu, 04
 Jun 2026 11:21:24 -0700 (PDT)
Date: Thu,  4 Jun 2026 18:21:14 +0000
In-Reply-To: <20260604182116.3179005-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260604182116.3179005-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604182116.3179005-3-praan@google.com>
Subject: [PATCH v8 2/4] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

While every PCI Function that implements ATS has an independent ATS
Extended Capability structure with a Read/Write Smallest Translation
Unit (STU) field, the kernel manages SR-IOV ATS by requiring the IOMMU
driver to configure the STU on the Physical Function (PF) before any
any Virtual Functions (VFs) are created.

Currently, pci_prepare_ats() bails out early for VFs, assuming that the
PF has already been correctly prepared. However, this creates a potential
mismatch if a VF is subsequently prepared with a different page shift.

Update pci_prepare_ats() to validate that the requested page shift (ps)
matches the STU already configured in the associated PF. This ensures
early detection of incompatible configurations and maintains the kernel's
policy of consistent STU sizing across all functions associated with a
given SMMU.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 679a3c3c1d54..9cb23780093d 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -73,8 +73,12 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
 	if (ps < PCI_ATS_MIN_STU)
 		return -EINVAL;
 
-	if (dev->is_virtfn)
+	if (dev->is_virtfn) {
+		if (pci_physfn(dev)->ats_stu != ps)
+			return -EINVAL;
+
 		return 0;
+	}
 
 	dev->ats_stu = ps;
 	ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
-- 
2.54.0.1032.g2f8565e1d1-goog

