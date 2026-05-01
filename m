Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8563A6EF8
	for <iommu@lists.linux.dev>; Fri,  1 May 2026 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777634439; cv=none; b=j0ozc1eFpB9vIeqLI+MDg7/xcXhCYgPAPsX3EjcSmlSyugbuPXyQIx9O5tFWNL+3tUB42p7hGf1S879ylJ+MFfpNDG0pNmPoE+Qv0MESrmkkLMiKbylupcWZZkUPCHC+6GY+Qv17RCbGP89t4kRFgyrmrmW1xktGykkZmwQaFC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777634439; c=relaxed/simple;
	bh=hDWBK5NoJKy+6Kx7m6iUjizTKOjBwxg/U8Mh0br2RZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VcAcPslipsKSAF0WBGdFdfz8C1J9ymGcR6gonklXPQxZxw8XAYGYuGmpELkOUXcjxmaH9PR4AVq6iohO6oM8rgdmAz+8OsbKpBWgwYto2uN3+6mFOnk++qjlKn2HoNmh+CQ49vkEJtYIGilOkb89YaR0aB/deWal7cMyxxeKA04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l82ZBOkC; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l82ZBOkC"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48a5523fd53so8377255e9.3
        for <iommu@lists.linux.dev>; Fri, 01 May 2026 04:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777634436; x=1778239236; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vwSpZfMSAme8K1/Tu2WzVQA/LKpXv4XDkU/OYSLP8lY=;
        b=l82ZBOkCINeoqgBW8yPimuRnl8dVXBMHWmehFtBgjLk1neQy4S+tFMVpPwMK8qRfoh
         4kuKyvxHLu2Hv1Zc9I6C62ca/0ykN6jTH6p6dsI41U4UwYieSb7AWqedZF1ESOnPHvxk
         ReM+waKScsMQCJsawAVp6emWTsMT07fPEUJ2wxJu4ciYI/vkDwDNW+9yEiDkxgtIg03Q
         utuqDUg+mrLh2PPIhCq/82Chc4a36jsyFQZVlW+TVpJ/FkRUPrl6EzGsDz2IiurUdwSt
         2kuMlRAC0NHmjbmD9rdWNgqAOf0VMm7aqpsXape9DN3pqzVpJykeTtP55KIaFpXrSwMN
         oT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777634436; x=1778239236;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwSpZfMSAme8K1/Tu2WzVQA/LKpXv4XDkU/OYSLP8lY=;
        b=cVYix42+XjAEOQQkrC7tfbsQ7DadpxU/OVU3ga690Yy0lvdQQhQ2vbgor69JaWuBuv
         a9t8ecm6hUePOCHgjhMBU8/e3/WCVQ7hUKHUJ0ALw2p25e8XOhav8EI3GtFrJHyTqMWQ
         Maub8yTvdqbaJna8hCCXfPyY5jAK7Fp1E4pvJ8fV8H4/dCHhHjs+MHdKeibFuZANZipl
         ThojMay0AXJrlnyvkuaB2F9LqvzFPdkIZbCsPyJKCLvwApADIg6BgwWpF8hj33MlnqJz
         W9B/k0faNyOh3HeElRxZxMPNBJhyMGdUKxpkEQdcKbCH3lnzer+0HacNIEqZcBFiXF3d
         FKGQ==
X-Forwarded-Encrypted: i=1; AFNElJ+mUNya9IoHaJPA9sWUTOd5Fttw0lq3GHazIZmJVBDaiWgD3aCTIudDzwOiKyt4NosRyhJtXw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4L6Nic1GvTp+fYPlAtf3OKw0yV4tSAm3GYsFidMB+3wpjO9nn
	gQFCpIZktFK01pUtqaqCcJBhqG3HGHNpe4UB8gSsT656F947lt1LG2gMBGhQdUwHtTj7nZqEv6s
	un8dHqxxOmq0Uug==
X-Received: from wmbjn2.prod.google.com ([2002:a05:600c:6b02:b0:489:d74d:f20])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:64cd:b0:487:243f:dc3e with SMTP id 5b1f17b1804b1-48a83d6e17cmr115589325e9.6.1777634436116;
 Fri, 01 May 2026 04:20:36 -0700 (PDT)
Date: Fri,  1 May 2026 11:19:27 +0000
In-Reply-To: <20260501111928.259252-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260501111928.259252-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501111928.259252-26-smostafa@google.com>
Subject: [PATCH v6 25/25] KVM: arm64: Add documentation for pKVM DMA isolation
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org, jgg@ziepe.ca, 
	mark.rutland@arm.com, qperret@google.com, tabba@google.com, 
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Populate the section for DMA isolation in pKVM with the newly
added KVM IOMMU and pKVM SMMUv3 driver details.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 Documentation/virt/kvm/arm/pkvm.rst | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/arm/pkvm.rst b/Documentation/virt/kvm/arm/pkvm.rst
index 514992a79a83..46e5c553646b 100644
--- a/Documentation/virt/kvm/arm/pkvm.rst
+++ b/Documentation/virt/kvm/arm/pkvm.rst
@@ -77,7 +77,24 @@ Status: **Unimplemented.**
 DMA isolation using an IOMMU
 ----------------------------
 
-Status: **Unimplemented.**
+Status: Supported for devices behind SMMUv3 supporting dual stages
+of translation.
+
+With ``CONFIG_ARM_SMMU_V3_PKVM``, the hypervisor will take over the SMMUs
+on the system and provide an architectural emulation to the kernel SMMUv3
+driver transparently.
+
+If some devices are not behind an IOMMU or behind another IOMMU architecture,
+DMA isolation is not supported, as a driver must be provided for that.
+
+DMA isolation is enforced by dual stage of translation; similar to the CPU
+where a driver can register their ops through ``kvm_iommu_register_driver``
+and implement ``host_stage2_idmap`` to shadow the CPU page table.
+
+This implementation trusts the systems firmware not to allow the untrusted
+host kernel to bypass the SMMUv3.
+For example by resetting the power. In that case, it is the firmware
+responsibility to save/restore the SMMUv3 state.
 
 Proxying of Trustzone services
 ------------------------------
-- 
2.54.0.545.g6539524ca2-goog

