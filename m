Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC38342CB5
	for <iommu@lists.linux.dev>; Tue, 19 Aug 2025 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640349; cv=none; b=gaZoYcqEB1UbUxDC1N00VITSR8NDN+GLKCsxaQ7Vj9NYzF5Qtv6JPnrpVQkNGnPkrv1lL8yiPm4x0lrtAmYK+M2mC42fTJyv4aRq5apr7C3Hn8sbMsZjKSiYjkgjtIlqqXS8knqfJTQFITeqMrP6XYAOx2DcszlsEH8BBMCDASc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640349; c=relaxed/simple;
	bh=iu6gKl2CIH0Do5wVBqGs+FISYJXVfUyFEZp0ZLhFP2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=thn/2sp/HL+15RDjrGQPcf7Wp8uRbW4LbOxuPdhPB31aHH2PeUUGSb+QfUn2iS/lYWt+QAwHhLHvQLOXF3i3KAkk0jE3z+U9QhSNSTtkvDnMM4d6oHendw6gOOftLqhn2E3Ig0Ond1asEKqK9Jyiy61VXMiBrSSEeZUFIYFHEIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2AUI2A4b; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2AUI2A4b"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-afcb5f59d9fso22737666b.0
        for <iommu@lists.linux.dev>; Tue, 19 Aug 2025 14:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640346; x=1756245146; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+DG7jBXGZxGQ4XuCOpRWmsZ2ZfXC/o78dYhqpKpX0Y=;
        b=2AUI2A4bMECT9HapJLtfqlOlVjNp/A9xtW4yFTtg++eWZDJym2nRi1Rx9yBOvC0RbQ
         TWiE8pTn3Jn6atTvVBvA5A8h2fmNfgF2aXjKrnjZnxpyoU51CNQy02c1UvV9jkX2kDnw
         vseuFtGj9rsgOxK5ylE/C9JKdOO6pBrTh98mlGOauNnWxXEIZven61kVQMBreqIspKUq
         kVsSsFR9yfgt35kaNgL1LzQEzyrfsJf6B5RcCM9R+ORS3S3gZNLJ6zpFilgZNR4xU4VA
         oapaTLHumiKvtpnCmR4btDsVW2x/HJj+Cgpu6mOl6Y6dPoWDm2GdDDi7m8momZXad0iE
         HHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640346; x=1756245146;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+DG7jBXGZxGQ4XuCOpRWmsZ2ZfXC/o78dYhqpKpX0Y=;
        b=DtnjAMxjRUtqzZdOZI9CXBed9IgnYDkZGMpXDD4NdVeQr/UDMh9Q7Sg8o7m6vN5jo2
         F2qt2dHPqdcvtwDROmECpENu7UbjftNrLiR7SCcgS81Ejh0VEXvHgu5DLGrwdKU3ilCj
         NydgMXDzYh2j8tF/hINWmpZGDNsUyHmMlTXn3KZAL2zNH2RpGNXKlGps8AnGoszcUfyA
         827G6jZzcEO1eVDYtYw7kOiPdmtmD+jJSiEshVwly/ag/SnYQ1sFlLN1FRVGCndRn+D1
         SmgANvoIT061P2lPo4uwvfCeKLMo6VU5MfYnyfDVwsrE/toS5oEOsAl8SSSWlP+zmOk6
         sivA==
X-Forwarded-Encrypted: i=1; AJvYcCXINO75fJa+lw8B4NrFLXelNzhFQWmh1SxPudbTxXgkIeAlGQ6C7ihC56hy9bFjuDYc6a8Xuw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7voju60uS/pjZA0BJ8U/jEP4Qfw5P8n+7dRMHVro741AprZ+D
	CmhLLNACewMSrhIfyOeGah+q6A/xQKsrZ2BodFgaZYQ1owz2B7WiNeURks1ZEEQlUq7viot7LUB
	ETUUowlcaEmIpcg==
X-Google-Smtp-Source: AGHT+IH9p4RnQonIqO2IvBstcQzhGwFgVqersbPBUPhqv5wCNXWBDT/LoPiy2B89sQst64Mbf5itUgGSgohDDQ==
X-Received: from edc12.prod.google.com ([2002:a05:6402:460c:b0:61a:3e52:115a])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7fa3:b0:af9:23b:9f9 with SMTP id a640c23a62f3a-afdded25839mr293959566b.24.1755640345755;
 Tue, 19 Aug 2025 14:52:25 -0700 (PDT)
Date: Tue, 19 Aug 2025 21:51:31 +0000
In-Reply-To: <20250819215156.2494305-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250819215156.2494305-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819215156.2494305-4-smostafa@google.com>
Subject: [PATCH v4 03/28] KVM: arm64: pkvm: Add pkvm_time_get()
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a function to return time in us.

This can be used from IOMMU drivers while waiting for conditions as
for SMMUv3 TLB invalidation waiting for sync.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h |  2 ++
 arch/arm64/kvm/hyp/nvhe/setup.c        |  4 ++++
 arch/arm64/kvm/hyp/nvhe/timer-sr.c     | 33 ++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
index ce31d3b73603..6c19691720cd 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
@@ -87,4 +87,6 @@ bool kvm_handle_pvm_restricted(struct kvm_vcpu *vcpu, u64 *exit_code);
 void kvm_init_pvm_id_regs(struct kvm_vcpu *vcpu);
 int kvm_check_pvm_sysreg_table(void);
 
+int pkvm_timer_init(void);
+u64 pkvm_time_get(void);
 #endif /* __ARM64_KVM_NVHE_PKVM_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index a48d3f5a5afb..ee6435473204 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -304,6 +304,10 @@ void __noreturn __pkvm_init_finalise(void)
 	};
 	pkvm_pgtable.mm_ops = &pkvm_pgtable_mm_ops;
 
+	ret = pkvm_timer_init();
+	if (ret)
+		goto out;
+
 	ret = fix_host_ownership();
 	if (ret)
 		goto out;
diff --git a/arch/arm64/kvm/hyp/nvhe/timer-sr.c b/arch/arm64/kvm/hyp/nvhe/timer-sr.c
index ff176f4ce7de..e166cd5a56b8 100644
--- a/arch/arm64/kvm/hyp/nvhe/timer-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/timer-sr.c
@@ -11,6 +11,10 @@
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
 
+#include <nvhe/pkvm.h>
+
+static u32 timer_freq;
+
 void __kvm_timer_set_cntvoff(u64 cntvoff)
 {
 	write_sysreg(cntvoff, cntvoff_el2);
@@ -68,3 +72,32 @@ void __timer_enable_traps(struct kvm_vcpu *vcpu)
 
 	sysreg_clear_set(cnthctl_el2, clr, set);
 }
+
+static u64 pkvm_ticks_get(void)
+{
+	return __arch_counter_get_cntvct();
+}
+
+#define SEC_TO_US 1000000
+
+int pkvm_timer_init(void)
+{
+	timer_freq = read_sysreg(cntfrq_el0);
+	/*
+	 * TODO: The highest privileged level is supposed to initialize this
+	 * register. But on some systems (which?), this information is only
+	 * contained in the device-tree, so we'll need to find it out some other
+	 * way.
+	 */
+	if (!timer_freq || timer_freq < SEC_TO_US)
+		return -ENODEV;
+	return 0;
+}
+
+#define pkvm_time_ticks_to_us(ticks) ((u64)(ticks) * SEC_TO_US / timer_freq)
+
+/* Return time in us. */
+u64 pkvm_time_get(void)
+{
+	return pkvm_time_ticks_to_us(pkvm_ticks_get());
+}
-- 
2.51.0.rc1.167.g924127e9c0-goog

