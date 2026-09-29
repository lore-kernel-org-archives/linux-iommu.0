Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB0C3FC5B7
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 03:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653538; cv=none; b=Vy3bEH5ClwBob6AcRAVT6fjCbU3eV4NG7cwrPbF/qHdOSuVPzkEp10FVw/oxx27Auq/z09uRgZ3YP/x3VDmzOgOXF9pO2o2CHOaUYafdGK8bz6g4nPp1LiWKj+2qWCWkpVA5UckvC+gE8n/Q/lnUYtaBYihmxqommpAmDHIZsvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653538; c=relaxed/simple;
	bh=fBsvcJTGySkCd+eb4363p1Jk8F2h4J7YsqmmUHp9hgU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W6GOwZRbLjxk26ZVs7iwvpex3Mk3FnE7ROCO4S9wVmv14xyb59YRkZHvT8FbX0SfuzcS8V53iPI7UOX2wGIa9Z9lWfzK3xCSGdpMSzJ+FE31LZmgQWVXX08TXcUW0WIbmN6pOz0Ua+BroRDLLFy7Sj75fkTr8AWi7RT2mZaLnNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BOQxmVHT; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BOQxmVHT"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc7361c62b9so2624513a12.3
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 20:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790653536; x=1791258336; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FTnb5gdEOwnPdz4JRroX+sFrer89MQl7kw/S2QGLtV4=;
        b=BOQxmVHTcKX5Ee2YPNap7Q33dNnVa56rkiAcxH26Z+7OK4uOURbq28Y+Pnh6CLA8f5
         aLPXr6uqpwMdr0025ugAusxt+6JOp0sdWHB1wdkbHWbpiM15r7bLqRMh3UFhWl/3i/JP
         ahF0l/62qXcFlm2E0PYOW3J/ZmZIQ5Yc36elQjtLlmXnW3jRtVmnBtz+Rv2hFcICoQIv
         VZbBXbu8rGn6GJekNeEwjyl78mSfBGQaj9/kv1c/svT0J+FaVrSxdN4oHbekTkkNpLgH
         fFH6Q+Wzgy9LUPKfNkgZivkXjynHZzbfg3CuongAutb1G57D+MIgLUOTkuQ8eFDNpjQy
         2P/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790653536; x=1791258336;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FTnb5gdEOwnPdz4JRroX+sFrer89MQl7kw/S2QGLtV4=;
        b=1N7IjNZzTNnbG0fj/dKvjKdxpg8XWu/DU03LXN7vzr50QeaFnfPvWLgk7OtDj9viHh
         ThYVr3ffzrKZCC+k3WIGVCsujCsZ3LQ2ZIvqgghWmW/rl90GfX89xLHXBOBpj7oPSpfU
         uJzHecph8/GRnK7gSBChDeNbi+tgOUosvKGPbz3WRyviq3/Cj6gxq0y1RHjFqzMqUyJV
         NFnRU88ZJUgXxGwz2bENTa868PFEKiefZxY0JEqKhTeus0CiRr/IEGAdMDGd0I5xS0BI
         N1XV/ktufHsAQtNLOs8IOsy6uX8bllF8FGd3npJkvl1S0b3n2weUrK4enOwfnp7J3XMl
         QDhA==
X-Gm-Message-State: AFuF++mE3sCBAOMsnT8vN7xNnYEKi46aRKC/vb/QdPPGVVfET+udnozl
	XqQxnVXD1ClKQaWVuFKLsNevqtr1/s5O+7i5cSqv14Qfa2+mZhUSDXxzUhHUhS47oRSY5zIlafe
	PQb0UqANcSeOtA5ga9ZEy+X5UXeV4qsT102KSlmLizSdSevP9WiFA25IvwLELNbMzBiis7jfvKW
	LswqNAncWsV77OC7HpuKysRwouOy0B5w==
X-Received: from pgbdp8.prod.google.com ([2002:a05:6a02:f08:b0:cc7:a092:edd9])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e38b:b0:3de:67b8:26bc
 with SMTP id adf61e73a8af0-3de67b82a79mr3606310637.30.1790653536063; Mon, 28
 Sep 2026 20:45:36 -0700 (PDT)
Date: Tue, 29 Sep 2026 03:45:01 +0000
In-Reply-To: <20260929034510.2023173-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929034510.2023173-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929034510.2023173-8-praan@google.com>
Subject: [PATCH v11 07/16] genirq/msi: Cache MSI message in irq_chip_write_msi_msg()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, PCI MSI caches the composed MSI message into the MSI
descriptor inside __pci_write_msi_msg(), whereas platform MSI and other
device MSI domains do not cache the message in the core, forcing
individual drivers to manually copy the message into desc->msg if they
need to restore it across power transitions.

Cache desc->msg in irq_chip_write_msi_msg() before invoking the chip
callback so all hierarchical MSI domains automatically record the
latest message. Document why the redundant assignment in
__pci_write_msi_msg() must remain for direct callers outside the
irq_chip hierarchy.

Suggested-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/msi/msi.c | 6 ++++++
 kernel/irq/msi.c      | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 80a9db417dc8..f7bedc31d486 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -257,6 +257,12 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 		pci_write_msg_msi(dev, entry, msg);
 	}
 
+	/*
+	 * Although irq_chip_write_msi_msg() already caches the message,
+	 * keep the assignment here for callers that invoke
+	 * __pci_write_msi_msg() or pci_write_msi_msg() directly outside
+	 * the irq_chip hierarchy.
+	 */
 	entry->msg = *msg;
 
 	if (entry->write_msi_msg)
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index fb5f372215bf..df460a574d80 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -634,6 +634,15 @@ static unsigned int msi_domain_get_hwsize(struct device *dev, unsigned int domid
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
 					  struct msi_msg *msg)
 {
+	struct msi_desc *desc = irq_data_get_msi_desc(data);
+
+	/*
+	 * PCI Multi-MSI shares a single descriptor across all vectors and
+	 * the device stores only the base message. Cache the message of the
+	 * first interrupt only, so that sub-vectors cannot overwrite it.
+	 */
+	if (desc->irq == data->irq)
+		desc->msg = *msg;
 	data->chip->irq_write_msi_msg(data, msg);
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

