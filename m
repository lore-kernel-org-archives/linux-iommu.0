Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00DB3FF1AC
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 03:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653536; cv=none; b=SliAnvpSaJhKqMxJ/pfIJWIAPDvUQoypkg4o7R9L9tSToYCaUDPY4dzSB7aiCK/hL8qs0ZcRXLDoz+/MGiplDUCBbwZQoBv3xU+B7vLGCbQ8h/b1rXJUiSTBuom3fiDo0R0dvbU/hidUI8kLJ0UbDt3wL9Og6BYfUpYEvuVDSX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653536; c=relaxed/simple;
	bh=t6s4Oe+o2p1ts8W0BX63x7TlPfAs6I5sA3X1EA+4bIY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lbcTel/ZKEQcS1SrTqi0tW+3tqvk4V5MFgZMUEgkTqGWoaexHN/w2ZHnjEym6xxLuFroR1Go+XHB6pMGAB5lfGUJ1tu4uQ+7PntETZgb0VAElAl1agpdrCoOf1GFGEgq4x265OLRaYa7QJOJSF3AhoDcV3eY29/hr1E7CzAauvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Anrom8Hm; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Anrom8Hm"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-88551591365so314606b3a.0
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 20:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790653534; x=1791258334; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mNojz/m5/pZo5fqQWuhdwjNU5hLUXAkkyG3PUmd5nDE=;
        b=Anrom8HmidE68vMConZ2PEBUJKmCuZqaSbPCWF+dXhVthVPwBphi02A20BOKJ4UzDL
         CgLsXIn9WBFc44kZnCqut7l+Vt7Xsp7SHMR3/6xd3tlUBqS8KT4v/9FtzZZBz8YmOimV
         wRNHizOi0KcZEux2vsIelEoTWOMrb20GvDhoMvQa5DLRcPXairS0kQrvHmS61ccCdB0g
         7p7Kyyg14Xyib2aDrDZSkHCgtJVtxoXiFslYWEkhb5fKDMALQkJ+66Kns+OXsshlskW5
         vifCCKMpGfBxvUoOXBaFCo548dfgdrJxnU6tJTxNHRIrxHCJ1kHH7hdgE3uN1K2e+eJz
         87SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790653534; x=1791258334;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mNojz/m5/pZo5fqQWuhdwjNU5hLUXAkkyG3PUmd5nDE=;
        b=wPgw3H8zx1ce01L/jB8V0Am/Go87lo3dXz9rtXrjEAXzDyWqDd00h6Ffwooa3oCN9u
         WY/7DnoPM5FexE/pxVqda3qWKwXa8XyMXPHVcznjTdaz7WHEN5DRWf5JLm5gXF+KlPWU
         q890CVE2lsfHAtGfaQcnPAOK+tOlQVnZ+iH2kPIDD+LpkeJcZKPkiL7BQrmmjO1ckg0a
         42o7Jrcr3qWvC2/THckzciCpstx40aGRCxjzDGYNdFGBD8DgHlYY1Wt1oMZzHAZSyIqa
         SCRuRfFZgBIbr5batj2eF/5/rz+u9lhI8vLl9iQawlxLpUlBO+tfxFc1XJVyX63y30/0
         bD+Q==
X-Gm-Message-State: AFuF++mMUUIhurHFv4NE+jvu/b14edlr9LOu7b8QvRtubJRStp6M90BE
	8HvcTFfB1xfkmjL7iqgTvaeZvlCWAQzoLeWHe6ivrpOlag8bfhMdRQ+eUaijTq0NRutpCJj8cbD
	I7DNlCI9XVSAbzArJnuYFyapsXINnfuzhu58r7o6aVkC6AiXDM5Qv5dkmGpekSg1hf/PTrtzn/f
	T3R0cbvNSkis3aC37yHcrZYdA1A1BimQ==
X-Received: from pflr18.prod.google.com ([2002:aa7:9892:0:b0:878:112:ded2])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1703:b0:878:3705:5724
 with SMTP id d2e1a72fcca58-8856314d6ffmr806898b3a.48.1790653532960; Mon, 28
 Sep 2026 20:45:32 -0700 (PDT)
Date: Tue, 29 Sep 2026 03:45:00 +0000
In-Reply-To: <20260929034510.2023173-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929034510.2023173-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929034510.2023173-7-praan@google.com>
Subject: [PATCH v11 06/16] iommu/tegra241-cmdqv: Restore PROD and CONS after resume
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

From: Ashish Mhetre <amhetre@nvidia.com>

PROD and CONS indices for vcmdqs are getting set to 0 after resume.
Because of this the vcmdq is not consuming commands after resume.
Fix this by restoring PROD and CONS indices after resume from
saved pointers.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index a394bf0f487f..c7989fcd2c62 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -567,6 +567,16 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 	/* Configure and enable VCMDQ */
 	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
 
+	/*
+	 * HW Registers reset to 0 when power-cycled. Restore them from their
+	 * SW copies to prevent executing stale/ghost commands after resume.
+	 * Note on RPM: Power-cycles can never happen when VCMDQs are assigned
+	 * to the Guests since the relevant frameworks (IOMMUFD / VFIO) hold
+	 * active PM references preventing suspend while VMs are active.
+	 */
+	writel_relaxed(vcmdq->cmdq.q.llq.prod, REG_VCMDQ_PAGE0(vcmdq, PROD));
+	writel_relaxed(vcmdq->cmdq.q.llq.cons, REG_VCMDQ_PAGE0(vcmdq, CONS));
+
 	ret = vcmdq_write_config(vcmdq, VCMDQ_EN);
 	if (ret) {
 		dev_err(vcmdq->cmdqv->dev,
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

