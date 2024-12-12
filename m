Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB842210FB
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026711; cv=none; b=P5jT/B8oSnH/lMhJB9d5RuWc7R+LIHfrSv0dsD6aEoczXO9rl2OrkmblIkl0eP/Wz3RyJg73nYGCKf0F3WIQLSob9HLfsl4cFNqOlZrvGy1hcxsqGAUFNGH/QevgNgCaUF6NI5oq+d65bNdRxZ/v3AbsZlNZtf50jWL4kBwprIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026711; c=relaxed/simple;
	bh=RigQSl3gYtHUND7WnM8WqyROz8rALOea7rQDuWDs2Ew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c9Pj+AL4qyEJr/L9QSrhdeAKSJBIMBfUqubwBnVAdoNiDuPMI6SlzdC2VmpQUmYwR4MmCdhAqxfgskus3yiNqGIKXSIk9SBVBASu0/dhUdPXbtisl4eoZ7CeSTPXWN8EYjtIZZQL6bOVmCM1P77ox8d5/8pNIlnysTK+g7UQf8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bR+m2o/i; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bR+m2o/i"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-385e03f54d0so429503f8f.3
        for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 10:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026707; x=1734631507; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kvcwClhLv6xGoczW4PJAIpjHHqg4M8M55H3dQR9JizI=;
        b=bR+m2o/iwYJkpa8AwrqOHS+m8N/tgwOhqZ2A2JoPcp9LmEtVZXGoClDXehaxVsfjiB
         lkwaoJSq8mgL0A1ztLbQTx+BHPD+X4zDzQcR+UHNq+CZ6NbEk7v/BrJUYF43wjRWTKvA
         LV0/nekXje5owzxz8rzLCPsq0U38T/Dydhhcl0UuBD3eXPULIP77N1ytOx5ipjsD8BIl
         i1xr33RHUI/2oIhBbJzr1ScDMYeQTpIKsaBgE9cdmjfhSg9qP7lVTlkrfVMpaXGK29Dp
         nI6ew5z+HN0XgYhrwaKcdJZOVyPLdlT3fF0+DMa4OmJLLi8JG9x/EuFLy0/Tt58Powoe
         geTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026707; x=1734631507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kvcwClhLv6xGoczW4PJAIpjHHqg4M8M55H3dQR9JizI=;
        b=m7eTd7j0G2A904DCCtua2Zt2RelsuPY9QGnBU5d45ow/IDR1v+3i9ctZEKXYvlBKI8
         YMvVbX0CD+kd7zM2fmbLqz+OnviUGL+cvXoyaNkBtbM7HCHBeepcxL2yYDrNbWO/x1bf
         U0oABaiMTXwzT2IBFdOkLk/lSDXug/OhJhjqJzP22/vSQ3TU4wBBjnUVq5rvDjeY0c4m
         ULUy0lT/RIgHZzsm0bsXgK3fnVop8hHuECTem+7zlEydviBSxflBGamUYDf5vrTpK/zl
         z9GoDrd59eiHiih0m3+pKhk33O31asS4ZoIH9RPWSoupSeXJzdukNmi8JL/0C2SiTDN8
         W+lQ==
X-Gm-Message-State: AOJu0Yy00XXWEw5xOpXLoiya7v8B9CqaqEdJKz3qBB9+GmIIFLCtovVb
	rLRqDhWOCBoCC4hj8Lll9XYZ5yN+G99V5237FT+OnxeMAqvTme6TRPZyWtppWRJc7ntJyI4AuFd
	G9XC7TQCUU3nZeJyHIbQWaClzPhQwQZEql7KI2DGBnvDU3K33xk0g0Zhk9bQfUal1Ymn5/rnV8o
	okY1U732Yw+qFREf6kHvIyJ5bj0QfRGVYh7i7qhB6zJA==
X-Google-Smtp-Source: AGHT+IE10scUEuEcCRD+5w6H2L6RFmN8j1xObFtBxLC8p2WLtJlxovv9B58XfdIQzXv891vozkqFrRDj+yh8bw==
X-Received: from wrvj17.prod.google.com ([2002:a05:6000:1bd1:b0:386:3835:9fda])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:280d:b0:385:ec89:2f07 with SMTP id ffacd0b85a97d-3864cea56c5mr4112209f8f.32.1734026707185;
 Thu, 12 Dec 2024 10:05:07 -0800 (PST)
Date: Thu, 12 Dec 2024 18:03:35 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-12-smostafa@google.com>
Subject: [RFC PATCH v2 11/58] KVM: arm64: pkvm: Add pkvm_udelay()
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org, 
	robin.murphy@arm.com, jean-philippe@linaro.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, vdonnefort@google.com, qperret@google.com, 
	tabba@google.com, danielmentz@google.com, tzukui@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add a simple delay loop for drivers.

This could use more work. It should be possible to insert a wfe and save
power, but I haven't studied whether it is safe to do so with the host
in control of the event stream. The SMMU driver will use wfe anyway for
frequent waits (provided the implementation can send command queue
events).

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h |  3 ++
 arch/arm64/kvm/hyp/nvhe/setup.c        |  4 +++
 arch/arm64/kvm/hyp/nvhe/timer-sr.c     | 42 ++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
index 3b515ce4c433..8a5554615e40 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
@@ -143,4 +143,7 @@ int pkvm_load_pvmfw_pages(struct pkvm_hyp_vm *vm, u64 ipa, phys_addr_t phys,
 			  u64 size);
 void pkvm_poison_pvmfw_pages(void);
 
+int pkvm_timer_init(void);
+void pkvm_udelay(unsigned long usecs);
+
 #endif /* __ARM64_KVM_NVHE_PKVM_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 46dd68161979..9d09f5f471b9 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -356,6 +356,10 @@ void __noreturn __pkvm_init_finalise(void)
 	if (ret)
 		goto out;
 
+	ret = pkvm_timer_init();
+	if (ret)
+		goto out;
+
 	ret = fix_host_ownership();
 	if (ret)
 		goto out;
diff --git a/arch/arm64/kvm/hyp/nvhe/timer-sr.c b/arch/arm64/kvm/hyp/nvhe/timer-sr.c
index 3aaab20ae5b4..732beb5fe24b 100644
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
@@ -60,3 +64,41 @@ void __timer_enable_traps(struct kvm_vcpu *vcpu)
 
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
+#define pkvm_time_us_to_ticks(us) ((u64)(us) * timer_freq / SEC_TO_US)
+
+void pkvm_udelay(unsigned long usecs)
+{
+	u64 ticks = pkvm_time_us_to_ticks(usecs);
+	u64 start = pkvm_ticks_get();
+
+	while (true) {
+		u64 cur = pkvm_ticks_get();
+
+		if ((cur - start) >= ticks || cur < start)
+			break;
+		/* TODO wfe */
+		cpu_relax();
+	}
+}
-- 
2.47.0.338.g60cca15819-goog

