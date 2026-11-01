Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793514064;
	b=d39F/qc91BcUnXjMMWtnxIM1KroXB/bcYoIdT/z6utoSERYfU7s4X+3INWETik+ifbVC
	 Jydd+eb7D6kJ/G8UdeirD4B7undfO1vLkEhGV++l1xU3XesssGv9S6F+KSSXRqEQx1mZj
	 rpgA0M96vM9sijeAHytyRicdRZYT/r413QT5gS3ix+AAtEMLXVqnRJ5PD835jph4Ac2DZ
	 SdOOv102joBifEQndkdoNgtc/qxPUQlDbli/U7UqBONNLu4hpnwM/A9zqKBC3UQajWTzp
	 p2rbzGDlB1QreHqED56SeGWNDJoe1MtbKL1oX6b7hOvWWLQwJjkdglzOG1tN7pKhcKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793514064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=yNCcoeaVZu8l86yYhX5AKYZ61AL1GukvPzV1U2a1bGA=;
	b=i5X1FakWGSAnvfnsPzFHqbJbajRSrRMvzwDSXe+ZY0lM4osKCTN1pIDE+ER5JgmWOIka
	 RHxtgqMeXjDYMTmJ8cyA3tFH5kKYPAThE/mTAo0xuFEPqtk4e/qhV33ulkMWy8KDXmWSm
	 258+Zg9G0ofuN0csS/jsgCXCaEUShlR763AJlkVXrkkNNxrC2bXYqa47UE7ovm28k0M+F
	 TOfjy5GXG2I7lSrFQbicjj2Q5DLXl5AUK3A5qDwV7mTvjvRCXXCh/wxY5F7CxcEZAwn6G
	 8yy3/ixfsQrztMaa1VWFYE6wGY89JUQSIm5Y+5JKpTq2tLuDkEGfFTPv9l5hRQUSUog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QPjLzCZK;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3254D606A324
	for <iommu@lists.linux.dev>; Sun,  1 Nov 2026 06:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3254D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QPjLzCZK
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1aa0fb7f157so3103801c88.0
        for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 23:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793514063; x=1794118863; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yNCcoeaVZu8l86yYhX5AKYZ61AL1GukvPzV1U2a1bGA=;
        b=QPjLzCZKR2kOjxO/UONN/qFCb3kt7Z+RH3aQ6ZaH+JrZq1AtcoCkibuW8MjipmSKtT
         gfGw8+fFWCHTYxXMP7ed3jaOT7LNomBGi92YEH5uM5tfnSsX/+PH+Rz4OqikXCAOLEU/
         YWeekBZmiutb4yIPfAaRscvTh3647AdXNRXEpe2oTnFjnRbCS9DtAHuA0MQxQkbHeSiP
         lu2l2C9tXXtCHblNZRrRn/alFj9muDiGpdSRidythmrEaE9AZRu0h4YLfW7HB0vtoSjL
         VgiD5bVlHCIXHKNzvj74Dd6JXoCmQaJ91bZpO88LtKww3zRQg0S6ujH0gO9sjmv/YQW3
         mfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793514063; x=1794118863;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yNCcoeaVZu8l86yYhX5AKYZ61AL1GukvPzV1U2a1bGA=;
        b=v3myG8mjaluOGJjZH7guHYl4juU8fwCuOPiFFiqeomKc5deY8puAN/h4hVa5q+GBlJ
         6iQmj4MW+MIxxTEhJpGzyCH5br7FfankNaNRkFdJrXktQRZfDCuCGfUBWxCbtaLTHoDy
         urzfo6BxUELi/tgqvZRS3SqdqhbRkwZin1Z0Wf9Mb5f3zHRTt/kOfCMZu1LL3ttWEnJS
         EQe7yU0B1+6cHDrTQ0sJAW8ukrHDBGwrN4ZPYsM5cc7Tx/NYvcjIRBnfC/dfBanZIbgL
         6Nu7jeThjVXgcNB9zJ7/nMqP/43hehf0OB9uQ3OQ7uC1BY8J+uElMi8xc5IAm8CjKAFF
         FCiw==
X-Forwarded-Encrypted: i=1; AKwUvByNePHY8DOAEFkMXlKW6r2oSJ46v8NkFA7miVcIFuinOp1l51Q6izYn9K58G9zMGWSVKu+NtQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJM2sMei+wyH5uvU1xlSrdY+FtAC+xOosStsFiZ1qnog2s3TgG+
	tqm6E1LLFh+cVyUjRyqSEq+tg9mshdsE2HFgt7KkPRehR1Yw/Z9toCw8wGf1o3THwgnyPtgvJ7+
	vtzKHFAPVf9rc1oQuTJS8gVUaPQ==
X-Received: from dleb6-n1.prod.google.com ([2002:a05:701b:4246:10b0:1a8:bca:6c0f])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:418d:20b0:1af:16c4:d06b with SMTP id a92af1059eb24-1af16c4d07emr4745927c88.10.1793514062994;
 Sat, 31 Oct 2026 23:21:02 -0700 (PDT)
Date: Sun,  1 Nov 2026 06:21:02 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261101062102.1000477-1-almasrymina@google.com>
Subject: [PATCH v1] iommu/amd: Prevent spurious IRQ disable on high-rate GALog MSIs
From: Mina Almasry <almasrymina@google.com>
To: Joerg Roedel <jroedel@suse.de>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On AMD EPYC (Turin) hosts with AVIC enabled, passed-through SR-IOV VFs
in KVM guests log interrupts targeting non-running vCPUs into the IOMMU
Guest Virtual APIC Log (GALog) ring buffer and signal the host via an
edge-triggered IntCapXT MSI (AMD-Vi*-GA).

Both __iommu_setup_intcapxt() and iommu_setup_msi() register their
handlers via request_threaded_irq(..., NULL, thread_fn, IRQF_ONESHOT,
...), using irq_default_primary_handler() (which returns
IRQ_WAKE_THREAD), while intcapxt_irqdomain_alloc() sets handle_edge_irq
which does not mask edge-triggered MSIs during oneshot thread execution.

Previously, amd_iommu_handle_irq() cleared MMIO_STATUS_OFFSET at the top
of the while (status & mask) loop before calling int_handler(iommu)
(iommu_poll_ga_log()). Under overcommitted multi-VM TCP_RR workloads
(1,000 to 10,000 flows across 4-8 VMs with vCPU overcommit), new VF
interrupts for non-running vCPUs arrive while iommu_poll_ga_log() is
draining the ring buffer, causing GALogInt to transition 0 -> 1 and fire
additional hardware edge MSIs while the IRQ thread is still inside
amd_iommu_handle_irq(). Because desc->threads_handled only increments in
irq_thread_fn() after action->thread_fn() returns, note_interrupt()
(kernel/irq/spurious.c) accounts every intermediate edge MSI as IRQ_NONE
(desc->irqs_unhandled++). Once desc->irqs_unhandled exceeds 99,900 out
of 100,000 interrupts, __report_bad_irq() logs "irq <N>: nobody cared"
and permanently disables the IOMMU GALog IRQ, breaking guest VF MSI-X
wakeups.

Fix this in two ways:
1. Drain the log ring buffer via int_handler(iommu) before writing
   status & mask to MMIO_STATUS_OFFSET (clearing only the status bits
   observed set so a concurrent overflow bit is never cleared without
   running overflow_handler()), followed by a post-clear poll pass so
   entries written before the status clear took effect are processed
   without generating redundant edge MSIs or leaving entries stranded.
2. Set IRQ_IS_POLLED on the AMD-Vi MSI and IntCapXT IRQs (clearing it on
   request_threaded_irq() failure paths) so note_interrupt() never
   spuriously disables the dedicated IOMMU event/PPR/GALog IRQ lines
   under sustained high-rate edge MSI bursts.

Discovered in production testing on AMD EPYC (Turin) hosts running
multi-VM KVM guests with passed-through SR-IOV VFs where the host
permanently disabled AMD-Vi-GA under heavy TCP_RR traffic, and verified
on the same AMD EPYC (Turin) hardware across 4-VM and 8-VM SR-IOV VF
test suites.

Fixes: 2379f3485239 ("iommu/amd: Refactor IOMMU interrupt handling logic for Event, PPR, and GA logs")
Cc: stable@vger.kernel.org
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 drivers/iommu/amd/init.c  |  4 ++++
 drivers/iommu/amd/iommu.c | 13 ++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index de6db5621194..5eea9204f209 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2404,9 +2404,11 @@ static int iommu_setup_msi(struct amd_iommu *iommu)
 	if (r)
 		return r;
 
+	irq_set_status_flags(iommu->dev->irq, IRQ_IS_POLLED);
 	r = request_threaded_irq(iommu->dev->irq, NULL, amd_iommu_int_thread,
 				 IRQF_ONESHOT, "AMD-Vi", iommu);
 	if (r) {
+		irq_clear_status_flags(iommu->dev->irq, IRQ_IS_POLLED);
 		pci_disable_msi(iommu->dev);
 		return r;
 	}
@@ -2579,9 +2581,11 @@ static int __iommu_setup_intcapxt(struct amd_iommu *iommu, const char *devname,
 		return irq;
 	}
 
+	irq_set_status_flags(irq, IRQ_IS_POLLED);
 	ret = request_threaded_irq(irq, NULL, thread_fn, IRQF_ONESHOT, devname,
 				   iommu);
 	if (ret) {
+		irq_clear_status_flags(irq, IRQ_IS_POLLED);
 		irq_domain_free_irqs(irq, 1);
 		irq_domain_remove(domain);
 		return ret;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 960e1dc05ec6..ec392da008f9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1112,9 +1112,6 @@ static void amd_iommu_handle_irq(void *data, const char *evt_type,
 	u32 mask = int_mask | overflow_mask;
 
 	while (status & mask) {
-		/* Enable interrupt sources again */
-		writel(mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
-
 		if (int_handler) {
 			pr_devel("Processing IOMMU (ivhd%d) %s Log\n",
 				 iommu->index, evt_type);
@@ -1124,6 +1121,16 @@ static void amd_iommu_handle_irq(void *data, const char *evt_type,
 		if ((status & overflow_mask) && overflow_handler)
 			overflow_handler(iommu);
 
+		/*
+		 * Clear only the status bits observed above, then poll once
+		 * more so entries written before the clear took effect are not
+		 * left unprocessed with the interrupt status bit cleared.
+		 */
+		writel(status & mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
+
+		if (int_handler)
+			int_handler(iommu);
+
 		/*
 		 * Hardware bug: ERBT1312
 		 * When re-enabling interrupt (by writing 1

base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d
-- 
2.56.0.385.gac671c819a-goog

