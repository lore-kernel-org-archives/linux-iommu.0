Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ED02F0C62;
	Fri, 23 Jan 2026 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168238; cv=none; b=tTsGOXjN3uNqPoxIR0GJWfdcmcLurGUUvmR7mF2bZgAc4eitFw9j/4iOg6ocDfsqikmNgU2t8mP8oJlJIK8hsTpfeV/GEJzImffdYZI3MU5AifXV+aVfk6VkhbjURLY6JujVF6h2CL45xieSgHSf2cynX03VTJJSnFjwnDtwylw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168238; c=relaxed/simple;
	bh=O/QiE8ztQa1L0+JEIcZKm3FM+4fU4Nk50Mx8Z2fDz8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sq4NY05lG/ESe9ip+GDJ9uYPd1FzZa79YCQmRv+f0K7tknItHFn5GYI4QWdq1RJlwNNcfp7wLUZiCn3NBqf5rmCgMKeVVQw+qmx6YZvpJaL9DOg+pPsClVuP9RJxrwHv+CeUx3IWyep53fBQ8S4GFHZWjJxHbTWtPLkEg/aJjEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=poxXH8Ju; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2VtaYW8l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="poxXH8Ju";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2VtaYW8l"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769168234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CjdVJdQ/IABvMOcQXDTDdk9VdzgWv38Ziq5uuwivQ4U=;
	b=poxXH8Juzhh/LvvgoJlDLDfmFjwjoAZ0xoL4FdtQial3IXo/SHBzV1KdhIzmjvPeGR+apP
	tfu9X26fxBnESmq42mHE4wIrhJJdURooCkqyWKQZFmmpsEt2LNYOt8xYjzgNdpd8LXtLWU
	G4Di1veFIy9qCWlo8JfJ9y9woZ0KUcS0td9ZsPZHEhZydm+rpcEybfn4Knyjzqft70A4tD
	2/6+v70+AxcTsLrOyFGqykJDSY5LpdELDXxU84GQBffumkdOp0KF+6FVqPCdZ2UpvLe30o
	y5UdhrLxArEQWu+5f54/ZohWWBX9+V/AjsSOhCmQ2T3Ux3jGwExutbIq6QLPSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769168234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CjdVJdQ/IABvMOcQXDTDdk9VdzgWv38Ziq5uuwivQ4U=;
	b=2VtaYW8loa030Jn7qETkR6GEqiyE8Qu40VWtGV5rY8OSbOWkMEC5nmchKdwFLlTWFEn44D
	gpI2ROjv9Hlt2iCA==
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	iommu@lists.linux.dev
Subject: [PATCH 03/21] iommu/amd: Use core's primary handler and set IRQF_ONESHOT
Date: Fri, 23 Jan 2026 12:36:49 +0100
Message-ID: <20260123113708.416727-4-bigeasy@linutronix.de>
In-Reply-To: <20260123113708.416727-1-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
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

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: iommu@lists.linux.dev
Fixes: 72fe00f01f9a3 ("x86/amd-iommu: Use threaded interupt handler")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
index 5d45795c367a6..bd577852618b7 100644
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

