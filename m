Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505141;
	b=LX+2heJ/saFzWstBPk8U82fd5hFRgEXAQRBAnHygnJRUeD4YUTe4dTleugta+cppMhau
	 o8uXWr1yRVjBoVgKmFyAAzuibgF87ssB5hZ6wxdTmECMlX4l84YNegRL3oldGUu+/154A
	 yqcaKuISv8W5JT2K8Wd1jAnekUFyKjfpxb1zVl16KY808AIipTDxNzcHYQx0O2dMAlCkt
	 JkHKJTHKRAkFfbAxyLAW/jslp2DxbBhcENBF9e9C0YfOHYm7q63Lgp0QcOyofzdeDSxHp
	 JVjrmXxU2f8utQ3rkS45d3bgh/AhR1VDHdccD2H6n8oXuy3YwzeOHnpeuW9FHcp1iOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jkLumwW0F/yIPW3a3VULflIMMv5oMLlwkuByskuyIMU=;
	b=B21gol5YigMhdIJRL5biQNtNxblwozkA58MtqJwAtHwmtVMKvBLfeBmbgGTqRgOX+P1n
	 HrE7mYMsiHvvTElPbnGAIkSqfm4+fnZsr4mWwvX0/q6wtoc3h/+VXF5rtDmk9p8AULDCD
	 byoWk3dZMnmw330brbWs2L+Tcc4OYGHJ927dIWj2pj7eK6DXe1gotDvECLDvdDlJPxazF
	 ryta+awfE3rWuYTq3/H6gEZj06yUM9moU5R3YIN1UBnqM4TXFHgjjs/6yJKnrIeJM+OiQ
	 HQNFwLD3GRxZvhtDNZY12w/ehob/ObplrJ8qCA+Aarns0mDjXBzGeENiO25owLCQMLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F0Fe4+mQ;
	arc=none smtp.remote-ip=74.125.228.9
Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F62606A31A
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 14:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18F62606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F0Fe4+mQ
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cc1631a57d2so656018a12.0
        for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 07:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792505140; x=1793109940; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jkLumwW0F/yIPW3a3VULflIMMv5oMLlwkuByskuyIMU=;
        b=F0Fe4+mQnfO59yuOxIfZEs5TVxvXYJQrGWGMB8icMR2pyN0Cy7rzjNPe1IB8ADU2JA
         SCgGJW7qfbpOY97QHIAopkVT9UxEt44cobCAfDUoErRACHSLmgO95lti1Mnfqvmd4eEh
         RffzzLo/jD6GhtkG/SpmpXs+//NUyaBO/0E63SEbonMuWSQQAVuxttBY3jOt95fn2EA9
         mk1puZmU5BMwrlXxGEMc9mF80b5fA8C0HbqqCM/5SMzUX5J06axDIhDszl+t/93Pps0O
         UAU1oD8BNa4gM6R5WMa2/iOQ6K7bSxweZs9y73DAzs/ZKuMw0o9B04d59lvOH6a9AGKU
         O7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792505140; x=1793109940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jkLumwW0F/yIPW3a3VULflIMMv5oMLlwkuByskuyIMU=;
        b=h8pJd69OCTLrYkfsG6qHayVoyGNfI51pzMllwOuT5AwUNyglZi2yBklD6KMn5m5Dms
         RPlj6/EgoQXsjD30FJBmFe7dsRBIU2SrtwLfV0y7lZknRAPVok04ja6PwVH55JISvcDI
         MbTFgTZ1qwwB76qlUt4JNyfHTJIXxSKqllwjEX3uV3g4vgpkaqVkx4eysh7FS5O9Ih+5
         ObnsrKKxDYTrAhLmGpafB6NVTSqSaMASw0cBHpZQraMjgI/ulXGKYjp+7rQ4SaDf9Z3B
         t/z5i0JHhqjZM3aOh1do6d96mwcxpMlhRRf4TlQrKegHHfXqB6PWTMVX6aPuJIIO2WC9
         XnjA==
X-Forwarded-Encrypted: i=1; AKwUvBwnKqoclODyRIFK2NDHm+YybNpvkX0CpOde2Zv8kAOwdptdsAsm9RJN6eyRjbqvIJsKQAQBVQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJJcBSJCCVgbTCRP4WM8vaLO+m0fh12afSIvnVeCACCU1LrTwMC
	kjtGj5LSweoM9RDycGKhkZAd3Nlye1ER3EQI5hkJIA8o8tqsRYCQw/qd
X-Gm-Gg: AYBFou3TepE5DUUKNOgJiaoWlLQ6JFRTUVijBC94W2CzzkuTKchQn6NNKjaJc9O5rU/
	vAJP5RSq3Jp6thDBvDf2nAoLnhZfahnQU9g30EGYibknUECiA2h2qAKerIba7951Bkn5tDBsAjI
	YWaXi7U9rfY/Dekm79gYXqap/NXhZ+kWkxVng8g7s0IiJGomUMvjJiDhhOVIikVqK8LvhXVAxgq
	XY5l4u1sR+NqVuclh2kjFpfl7xT0JgjnMIw9UIe1RblxdPdvdYR59uz4KCLrNxHKnFSMeM43tbD
	q7HcqNdF10SVDYm+xgvyHm4SS5sVeptXjZ3yuHYm5WMXEnCYZIkAqRTvHEpddE0WE/hML1hY+yM
	o12hypp1FaXnMGdhpmrWZjQ6Mw9ppgmnNXw3N4FsVAAZF0jij9rIEcu1XaUfE7obci5GIhu/jSr
	PfJc/HN1m7iW23mbpmzX8Gy2GjBOjr8byd8/ibArPi025iqa3yDXEgaL5qlbJTjdw0KP4Kvn7RO
	eZXIBQxycTZb19VnwNdaqVAwqN6ufEO
X-Received: by 2002:a05:6a00:3e24:b0:881:be70:448e with SMTP id d2e1a72fcca58-8a04d34914amr8255299b3a.53.1792505140313;
        Tue, 20 Oct 2026 07:05:40 -0700 (PDT)
Received: from HXDQXTDYHN.bytedance.net ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a04493551csm3769242b3a.44.2026.10.20.07.05.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 07:05:38 -0700 (PDT)
From: Jinmeng Zhou <jinmengzhou22@gmail.com>
To: sarunkod@amd.com
Cc: Jinmeng Zhou <zhoujinmeng@bytedance.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	kvm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: Reset IRTE notification bits on every GA update
Date: Tue, 20 Oct 2026 22:04:58 +0800
Message-Id: <20261020140458.13755-1-jinmengzhou22@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260821055611.27138-5-sarunkod@amd.com>
References: <20260821055611.27138-1-sarunkod@amd.com> <20260821055611.27138-5-sarunkod@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinmeng Zhou <zhoujinmeng@bytedance.com>

__amd_iommu_update_ga() clears GALogIntr when the vCPU starts running,
but leaves GAPPIDis untouched, so a GAPPIDis value programmed while the
vCPU was scheduled out is carried over into the running IRTE. GAPPIDis
is recomputed every time the vCPU is put, so the stale value is only
ever visible while the vCPU is running. GALogIntr and GAPPIDis are
never both in use, as GAPPI vs. GA log is selected when the IOMMU is
initialized.

Clear both bits up front and let the not-running path set whichever one
the current wakeup policy needs, so that each update fully derives the
notification bits from the new state. The only resulting difference is
that GAPPIDis is now clear, rather than stale, in IRTEs with IsRun set.
Update the kernel-doc accordingly.

Link: https://lore.kernel.org/all/20260821055611.27138-5-sarunkod@amd.com/
Signed-off-by: Jinmeng Zhou <zhoujinmeng@bytedance.com>
---
This is a suggested cleanup on top of v4 4/7; please feel free to squash
it into that patch for the next revision.

 drivers/iommu/amd/iommu.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d89e3ce97e57..3d4d44be1ecb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3962,13 +3962,19 @@ static const struct irq_domain_ops amd_ir_domain_ops = {
 static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
 				  bool wakeup_intr, bool is_running)
 {
+	/*
+	 * Derive the notification bits from the new state on every update so
+	 * that an in-place update doesn't carry over bits from the old state.
+	 */
+	entry->lo.fields_vapic.ga_log_intr = false;
+	entry->lo.fields_vapic.gappi_dis = false;
+
 	if (is_running) {
 		entry->lo.fields_vapic.destination =
 					APICID_TO_IRTE_DEST_LO(apicid);
 		entry->hi.fields.destination =
 					APICID_TO_IRTE_DEST_HI(apicid);
 		entry->lo.fields_vapic.is_run = true;
-		entry->lo.fields_vapic.ga_log_intr = false;
 	} else {
 		if (amd_iommu_gappi) {
 			entry->lo.fields_vapic.gappi_dis = !wakeup_intr &&
@@ -3990,13 +3996,13 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int apicid,
  * a vCPU, without issuing an IOMMU invalidation for the IRTE.
  *
  * If the vCPU is scheduled to run on pCPU (@is_running = 1), configure the
- * Destination with the pCPU's APIC ID, set IsRun, and clear GALogIntr. If the
- * vCPU is scheduled out (@is_running = 0), clear IsRun and set/clear GALogIntr
- * and GAPPIDis based on input from the caller (e.g. KVM only requests
- * wakeup_intr when the vCPU is blocking and requires a notification wake
- * event). This API is intended to be used when a vCPU is scheduled in/out (or
- * stops running for any reason), to do a fast update of IsRun, GALogIntr,
- * GAPPIDis and (conditionally) Destination.
+ * Destination with the pCPU's APIC ID, set IsRun, and clear GALogIntr and
+ * GAPPIDis. If the vCPU is scheduled out (@is_running = 0), clear IsRun and
+ * set/clear GALogIntr and GAPPIDis based on input from the caller (e.g. KVM
+ * only requests wakeup_intr when the vCPU is blocking and requires a
+ * notification wake event). This API is intended to be used when a vCPU is
+ * scheduled in/out (or stops running for any reason), to do a fast update of
+ * IsRun, GALogIntr, GAPPIDis and (conditionally) Destination.
  *
  * Per the IOMMU spec, the Destination, IsRun, GATag and GAPPIDis fields are
  * not cached and thus don't require an invalidation to ensure the IOMMU
-- 
2.39.5

