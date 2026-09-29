Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F3B41DEC9
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 03:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653544; cv=none; b=T5WHUDU6FijI+epoWar6WLSvjvNMzut9dF8z1wxAOdMz2jfhGx8pGfn+Lf+NZ/xTkgRKBcvF4ySz1c2rOAGXFkOQ4uvgPVKgxKGilk91rn++2S6RcVreyay9xFjRAgR04fwfU1/U23sxvjTdVsmmUgnKgi3t8B2Rehk9SNaNZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653544; c=relaxed/simple;
	bh=rAWcJCCi9A6gOKRWLlYQUftC1yte/SSOlRW13UF9bXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=boxdEvYzecF9ohfB5BVLIUePWyXWqJOsEchG1vEYK9X49yQfkYMtqR+xZIYPpD0t2r+jK426uj3PiOjMm1Tk1Dul26AfOTaKIL0pshTnsYcNjbc4vh2OY44FLSkJjTe4dlDV6cLXVdgWUAm+ZIejTx6ZBS7Dyfa/koXH0Ng5kWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9JoblNB; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9JoblNB"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc73895c7d5so4438581a12.1
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 20:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790653541; x=1791258341; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HWQbzPnJHI/UQ6xRoFaSMFgVnf7una/rhjMJI3MVJUs=;
        b=q9JoblNBbojPSTLgb4A8Z6jSgWJ833VfeHrLynAZVR1VTcyNKaHeptQ34KWYF4L/9B
         ZmkDVVNRnno99g2Cv1Xs2amAp7VkUXXwJN3qUnHjTF3ZS9pUzdf2EqAtblYgsuwo8mFA
         qYhT7G58dMqyJ7VeBjmbXooBNTdihFnYO2OOFFvF/5NwafOjjSixReFPS4oT+TaoNG+t
         tq1I+5E4StspQfSHsHPhf72ZiZAjA72fiPda+XTj9XxcQ8eqV0ZXN734tlQ0SlNdm3/u
         y//ZyIY4po1AM0p+H7VGRl7nbba7wTNj78XcX8QfJmeIzXxsMui4jpBPfvMk0h9f1RG7
         GEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790653541; x=1791258341;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HWQbzPnJHI/UQ6xRoFaSMFgVnf7una/rhjMJI3MVJUs=;
        b=IEOCNuRRSSJtxr/cohzqujrmfK93Pyy6wfSggO1CZ2A0H2qXagNXe61RphooBEztvW
         n9vHWxCrT8NuToa1+y0fy0/ufS5ZHYmuv08kGetS0oqhHQYgupuO0w6y7T6i6ZB15AxO
         lT8WmFDaJHHFo2vyEHUowDjOna7tFQGcBx20vcmbRyp6M4Wunjmau0G71Ry4JEz0t6p3
         mtiwn4q3MYM1doQdOtn1kcE02qLeE+mKXz3buwxle0C9lIJGH1NKEcAdoBVGPCWxEI5l
         plGSOJnCo4nYz/rM9Q8ivfe0yuOt//iCkDYLwWl1KuKN0kxaER6ifPC3Cas8VQpj+M12
         BgLg==
X-Gm-Message-State: AFuF++lqKTgrnXydc4AR56I3KQMMDqBDhNCr1yNEiu/ojFQQ/GvO991O
	OtDTR1rRSFmcM9Xh2pHd1VS6mRQp169vG2j6CnIaFYx7HIjDdHOpXWzvX8+98aLsQJVlDySYbdT
	y5vt83zfWeO0NuzdYKiPMXQYswmN3Sz56wnbEJgHdJGk9QcJDT0PKN47n6F3THQaPhpZBMGUZUW
	KJBpIELiUrhPw2DHCmb2pg95D8ra71hQ==
X-Received: from pgc13.prod.google.com ([2002:a05:6a02:2f8d:b0:cc7:4d12:8a9a])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4324:b0:3d1:e510:9052
 with SMTP id adf61e73a8af0-3de0e6f3973mr13463950637.7.1790653541112; Mon, 28
 Sep 2026 20:45:41 -0700 (PDT)
Date: Tue, 29 Sep 2026 03:45:03 +0000
In-Reply-To: <20260929034510.2023173-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929034510.2023173-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929034510.2023173-10-praan@google.com>
Subject: [PATCH v11 09/16] iommu/arm-smmu-v3: Restore MSI config on resume
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

The SMMU's MSI configuration registers (*_IRQ_CFGn) containing target
address, data and memory attributes lose their state when the SMMU is
powered down.

Introduce arm_smmu_resume_msis() to zero the *_IRQ_CFG0 registers (which
reset to unknown values) and restore the cached MSI messages across the
device's MSI domain via msi_device_domain_restore_msi_msgs().

In addition, clear ARM_SMMU_FEAT_MSI if MSI setup fails and the driver
falls back to wired IRQs, preventing spurious MSI resume attempts.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index dc2fc02b5163..7347d3ecdae8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4779,6 +4779,19 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
 }
 
+static void __maybe_unused arm_smmu_resume_msis(struct arm_smmu_device *smmu)
+{
+	/* Clear the MSI address regs as they reset to unknown value */
+	writeq_relaxed(0, smmu->base + ARM_SMMU_GERROR_IRQ_CFG0);
+	writeq_relaxed(0, smmu->base + ARM_SMMU_EVTQ_IRQ_CFG0);
+
+	if (smmu->features & ARM_SMMU_FEAT_PRI)
+		writeq_relaxed(0, smmu->base + ARM_SMMU_PRIQ_IRQ_CFG0);
+
+	/* No-op if no MSI device domain was instantiated (e.g. wired IRQs) */
+	msi_device_domain_restore_msi_msgs(smmu->dev, MSI_DEFAULT_DOMAIN);
+}
+
 static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 {
 	int ret, nvec = ARM_SMMU_MAX_MSIS;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

