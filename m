Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E369D4F7CDE
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 12:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893993; cv=none; b=u/cCkKQwMlGOODNKw05njGSFpsP11xPEU+WNWXIB7C50GTLbz5ZzWMTbaxog9yex0WBrEyrvtZfJVal3qG/AvLMLnwP9pShoyaiKtxVhXBYgJYfPQb/hBDYPYdJfOgDNN2vVJC89I+nXrb6LaJlyeJsMXtT6FT7YWKTiYoMI5b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893993; c=relaxed/simple;
	bh=s5emk8cFtirRGCseiGygX//y5idLtVzc0HzJCE1i+YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txu5kZGiq/FOWd77GqL5ZXZUoHIZr28gC4cDQACeJs0e7qakkKsDGI7OtsmnKaVipMkPDw9Yg3DCxoJ2qmRTQ2RCxNg61unSuSJdvL2MNwDuyybwHtfUE8RlI1CcBu2rDWjaEFsBw74PcMikxA/urGVQJJJmdrlTytzSU66w9Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=WJ2QbgCb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="WJ2QbgCb"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c02782159so1763526f8f.0
        for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 05:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1791893990; x=1792498790; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n9uGCpvQermHDBtNBPxInsuZtK4DVOzfBsyPIO70t8w=;
        b=WJ2QbgCbK6kF08OyMUi9Vih6JSg1ViMg/0T8ucrESh0HmiFsbYk0Y7VcUve6xaYKtk
         /YCZ4sNbTfcRyrPSHkYfHnrlGL7e6rydbAXSGtJiaFpdrdKK5Q16XbvZHdGS6NGNc3ZA
         jFSkyTNSK4gsqnFDR6rBozRk3MrvL0PsXlSJs8YgQa8y9yn44tcBdqT3yDiPINuwP7a6
         Xi6Ydc2VAwgW9ozO2cECqITrH0xgBUlfXUpfnhA4pPeuQxspTWc8Eu6HQg37ZHWBLu6N
         Cw/+toRCQO23giSWupV1Y2W7yhxC007M9glaQOA5YgXdJ9GZPcuLnnJ6nMgUXzW0qyTA
         lNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791893990; x=1792498790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n9uGCpvQermHDBtNBPxInsuZtK4DVOzfBsyPIO70t8w=;
        b=xqu4960G9M4WUV9KxUBzaX3s7e950ASq4wBn7exGAIjOd/asue9Q2mlI3m/G6dofuk
         h575y7BiL/hx4urU3Xdwe3UY8bcWoSpHkZAw3GQqM5a/jPuLDLmT1uUrrKJOlWlOMWvZ
         1YsqIujTWNE81rNT16CVCajbekOJZl3tQjnJcsh7bW7kJpxpta1y3KMZhH1c5LGdBYXJ
         Sbsv7zRxVXF7rDL5Ln9FKPf5pmjtcI9u7IjzzJ/Ukw2PC0PpYkErv5bGcSt7uF26PkAm
         fI6+xmk9tUmNAzQ1cNEp66/QjCudCNWfNdjFTfmRwr7piEmX3OuTefEE9uHRi+4dQLEi
         X0Ag==
X-Forwarded-Encrypted: i=1; AKwUvBy1bdzH7iORPCNs98Y9gqLgYKnxEmw2wxyYA0z6m8vD/Phuk/i3+GnU3qtkavtHRyb0Qb8YLA==@lists.linux.dev
X-Gm-Message-State: AFq9FYILIemgKm3FiEGrSu6CqZ5dAEhjgRLpbQwuNUieuYL211hJPnbK
	Gcpwo4aSWP/cf1GErmsgin0CwEpPzVTbzZPjEjKH6i+h7bg7ijcFn+BnxTJzbGpV1YE=
X-Gm-Gg: AYBFou1JbEtbu4m5KYc0aK/wHrFRHH5qVyKRrOOxCcaIPmrHRKQvk4eAjzZAi8N7c3H
	HngMtj2YtHm7ik/BExonvJNqR+wPNOQvrdO2uLOD2++ZrF6f48nGu2k3stqq74PuMQsAkDy/Faa
	EZu4bdh1/pdQXqlLuZNrL7DtWLQkmNx7d2i6KS7NxOh0hOyjp5ZsbTANxTSKT0yB9r2Wxt1JS9u
	kcYeCCcpeNmWnHDyW3VCztEbMnY8iS1joU/Nw1fbbMZg+9BVw5Mk5b7XEzUKbIg2dtWq++l/Ugm
	0/pPW/tro8sAoqZ+zrbFI3JsOgUvu9AXGmUeGYIUYdcHY7XNg9pJZUQq+mxlduQCLs8/HVRWDDK
	8qF02WQKOpUSAxbcFfwEDhSkZm/8XbgrUt3HxjxSziy30zwUWQe2yY6u4uxS6g3tvkD4rt1XwIG
	vo+nT+dNvPleVO9r7HDQoyJnPIjxCzHUT921e1r+a6IZjtf/uOkyZbUx2IYlN3CXQZxnq3aboCF
	zHtv/Pq+fw=
X-Received: by 2002:a05:6000:4288:b0:488:6ed9:b11d with SMTP id ffacd0b85a97d-48dbacf554cmr22783078f8f.52.1791893990090;
        Tue, 13 Oct 2026 05:19:50 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:26c8::3dd:3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc5e0asm4806155f8f.50.2026.10.13.05.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:19:49 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Sairaj Kodilkar <sarunkod@amd.com>,
	Ankit Soni <Ankit.Soni@amd.com>,
	Baoquan He <bhe@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH v2 1/2] iommu/amd: Program device table when kdump reuse fails
Date: Tue, 13 Oct 2026 13:19:43 +0100
Message-ID: <20261013121944.4060097-2-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013121944.4060097-1-matt@readmodwrite.com>
References: <20261013121944.4060097-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

Commit 38e5f33ee359 ("iommu/amd: Reuse device table for kdump") made
iommu_set_device_table() return early in every kdump kernel. That is
needed when the previous kernel's device table is reused: the base
register already points at it, and on SNP-enabled systems the register
is locked.

But if reuse isn't possible, early_enable_iommus() falls back to the
freshly allocated table and calls early_enable_iommu(). Because of the
early return, that table is never written to the base register. The
IOMMU keeps using whatever table the register pointed at before, while
the driver writes entries into the new one.

Only skip the write when the previous kernel's table was reused.

Fixes: 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
Cc: stable@vger.kernel.org
Reviewed-by: Ashish Kalra <ashish.kalra@amd.com>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 drivers/iommu/amd/init.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c07c3a01b978..0572e1a674f0 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -409,7 +409,13 @@ static void iommu_set_device_table(struct amd_iommu *iommu)
 
 	BUG_ON(iommu->mmio_base == NULL);
 
-	if (is_kdump_kernel())
+	/*
+	 * A kdump kernel that reuses the previous kernel's device table must
+	 * leave the base register alone. It already points at that table, and
+	 * with SNP enabled the register is locked. If reuse failed, program
+	 * the freshly allocated table like a normal boot.
+	 */
+	if (iommu->pci_seg->old_dev_tbl_cpy)
 		return;
 
 	entry = iommu_virt_to_phys(dev_table);
-- 
2.43.0

