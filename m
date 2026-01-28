Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA8634DB44
	for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594158; cv=none; b=gds9TGaSo45OXaMtnr+N4rI3QbbrvGeffrYHCQkAkU+fJfv1DPEbWEEdqp0P3Gu50FOxjtY5C2kGT03kXU8Xm8DcG4E6yHPlGtS9DeWPGKCPbqvLy+Dmt23YBt6d6i2A8SyehtKv31IUJokbGRkiP5jx437Qk9yOAdK7kdnPhVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594158; c=relaxed/simple;
	bh=a8PmjOimE/57zI/f5ieyRUYuPN5myeNHEN+leOoS/c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2pR/+ws+i6tF5KUVca9dpz6/XLXFAnVgPlY19gbLlKcFyoDMrutb0I5kLI37d5w6cnGgTjepzTe/h0KcOxgJt5nX1LwM6iPPK+7KLmzLfhnYEniTYOKrfvMcSno7WR+R+JljboDZ1Kz5ywx6KyLNVTbcnab2XbL94xLVHbTM0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0EWZpln4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bo0pv0LT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0EWZpln4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bo0pv0LT"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769594155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zni2r7zu/AvwTPfuVhIq9YilbCGCckmhbNu3MIHICGc=;
	b=0EWZpln4s4OC4PaBWzPRQSOm6OKYoR4E8gD539RM2isa/0C+LELWfy7hyoex284I8Wivxy
	EBtcqP3ebp7STcj4kn3Ps65ke2qapXOLQQJwYHWP5BIOtNIYOpNyWg0OIYizuXBMgGujsA
	D4OMM0rMFkTVY1cHJcm8RvGkc2tGP2jNgWvGWCkz9FzPjXJGgfYBZM0ed91eZuPb6v2ID7
	fF2NaiXL37gSDBOQ1yU3XLUChUSBqQa9WURPotfeWuOztojzQbpBDBCdmZzjBWOAJ14GLt
	EFBckd5O6jVRwZ536K1fr6r2rxAuU/61YJIY2mQH/qgxIyA/r9rFtEI1Vvj4mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769594155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zni2r7zu/AvwTPfuVhIq9YilbCGCckmhbNu3MIHICGc=;
	b=bo0pv0LTUtjK5HcL3yxulX9wkN0230jI57qMa8V3IiJC2MPakFh9C9dsHNmbbxiyPu592n
	Fs7vUcS8KrCGAaDA==
To: linux-kernel@vger.kernel.org
Cc: "Thomas Gleixner" <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	iommu@lists.linux.dev
Subject: [PATCH v2 03/20] iommu/amd: Use core's primary handler and set IRQF_ONESHOT
Date: Wed, 28 Jan 2026 10:55:23 +0100
Message-ID: <20260128095540.863589-4-bigeasy@linutronix.de>
In-Reply-To: <20260128095540.863589-1-bigeasy@linutronix.de>
References: <20260128095540.863589-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

request_threaded_irq() is invoked with a primary and a secondary handler
and no flags are passed. The primary handler is the same as
irq_default_primary_handler() so there is no need to have an identical
copy.
The lack of the IRQF_ONESHOT can be dangerous because the interrupt
source is not masked while the threaded handler is active. This means,
especially on LEVEL typed interrupt lines, the interrupt can fire again
before the threaded handler had a chance to run.

Use the default primary interrupt handler by specifying NULL and set
IRQF_ONESHOT so the interrupt source is masked until the secondary
handler is done.

Fixes: 72fe00f01f9a3 ("x86/amd-iommu: Use threaded interupt handler")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: iommu@lists.linux.dev
---
 drivers/iommu/amd/amd_iommu.h |  1 -
 drivers/iommu/amd/init.c      | 12 ++++--------
 drivers/iommu/amd/iommu.c     |  5 -----
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index b742ef1adb352..df1c238dc8885 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -15,7 +15,6 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_galog(int irq, void *data);
-irqreturn_t amd_iommu_int_handler(int irq, void *data);
 void amd_iommu_restart_log(struct amd_iommu *iommu, const char *evt_type,
 			   u8 cntrl_intr, u8 cntrl_log,
 			   u32 status_run_mask, u32 status_overflow_mask);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 384c90b4f90a0..62a7a718acf8f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2356,12 +2356,8 @@ static int iommu_setup_msi(struct amd_iommu *iommu)
 	if (r)
 		return r;
=20
-	r =3D request_threaded_irq(iommu->dev->irq,
-				 amd_iommu_int_handler,
-				 amd_iommu_int_thread,
-				 0, "AMD-Vi",
-				 iommu);
-
+	r =3D request_threaded_irq(iommu->dev->irq, NULL, amd_iommu_int_thread,
+				 IRQF_ONESHOT, "AMD-Vi", iommu);
 	if (r) {
 		pci_disable_msi(iommu->dev);
 		return r;
@@ -2535,8 +2531,8 @@ static int __iommu_setup_intcapxt(struct amd_iommu *i=
ommu, const char *devname,
 		return irq;
 	}
=20
-	ret =3D request_threaded_irq(irq, amd_iommu_int_handler,
-				   thread_fn, 0, devname, iommu);
+	ret =3D request_threaded_irq(irq, NULL, thread_fn, IRQF_ONESHOT, devname,
+				   iommu);
 	if (ret) {
 		irq_domain_free_irqs(irq, 1);
 		irq_domain_remove(domain);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7c12be1b247f4..0f9045ce93af1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1151,11 +1151,6 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
=20
-irqreturn_t amd_iommu_int_handler(int irq, void *data)
-{
-	return IRQ_WAKE_THREAD;
-}
-
 /*************************************************************************=
***
  *
  * IOMMU command queuing functions
--=20
2.51.0

