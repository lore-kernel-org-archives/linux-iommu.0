Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B2F199FBA
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271379; cv=none; b=nk9qvZ+1zGa4hG4pkiMx+mXG+nAg3UtR9AR6MTBJbMqBtrtgitJenQkwaLBJ6NhAbh91F4UYnv+b8rishVQrGFTcVEmSxJ7wZCgqREs4RhnWEGSVe6ECCi1+ubQ/z1s2zkIXioI+K82kgvyvDDdCHeXx0KgLfV7o399N3HV2hMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271379; c=relaxed/simple;
	bh=lTpldD4eL76NbvK555N/Xx2Kd24uIcQoPu7MsvhV6l0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Uam6wnU81ddTPCTSO2wyH6L6JFZbZDwSSOqblVJsIr895eYiODK1kUilMj8zQhOQ5JB6yXL1wE7+bhYP4FBhsJvodQUPs2tWcLi2/yQ+8dfarlWJbXQsaazqmK28V2oGHoml6NqN/8jtP1Fqauha+Ad0c5tkPIe2SMO9fcyvVTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NVT7ywPo; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NVT7ywPo"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b9b1900bso1981674f8f.1
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 06:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774271375; x=1774876175; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NfzC67OFUc9pr0Vnc62IO92SI4BJtFnpHt3IPGw5yvg=;
        b=NVT7ywPoj0V2emDWGylXL4AeHNvbhZEPA9ovEsNg2GLrG7yToEULKRhEtN8wyHUBAA
         oODrM51FY1DOa17S8VRTAedfY3g1LZfNX2bJwX/kxwSINct2qAbrqlQiQuTG4zuYiLs2
         j6KD6o59lZA+Ocu+pIhiCtfYn+RZuyZQsC9lOvAdhSwepv4nW1JolqrQGqDGvEDZrCKn
         gfkn3hL+5u3feasMhbCX3q9BSceks/gHm7239tlWb6hjmjsILJZYLOn4ugMwkYrB4k82
         jfXRBRzaoCxUlAMh+B9N4IgxWJXXc0yfM5Fztas21KrnU2xnJNj9nRB/byVZNyCUDf94
         /6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774271375; x=1774876175;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfzC67OFUc9pr0Vnc62IO92SI4BJtFnpHt3IPGw5yvg=;
        b=Cgm9g0L5rw82W6bt6k8y+aGL1aY/vAcQ8q1/368vIGLf0rhqKD3VOZAPhEsWmrZ+ts
         6DoOnlBK5nfQY6atlLuVJ1OpZKaHRT2gkFEPQtRSPvR3J/qw+L17p8T19u+XvzS2PJCk
         pAUGe0fB4Q7xsyld8iM+ACLW9xNMO2kainH3V2IsNYS0Ixy3Jv5uvPT3+GTO65dkOx6N
         zMqNFXwTTDO0r4qMQ2dBZcs9OVNkYbwEYxRBBZhbNNqW6FOdIP1nDzSqYJddmKJc33RM
         rtLk9QGyovtyUYyBJ61V7tZGTTn5opwk56yhx/k8FUofmYybkJJNiPBkN+dkOYYqcg8h
         kVUg==
X-Forwarded-Encrypted: i=1; AJvYcCXmvPvQstlsZQYj24kFW4yc7ma4Rz5Lzq+OfyfkXQpvTqomDOBxEtnQE06u236CKasmUC6lNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzA5Mz0I5xHt1ZYJXgjwOduVPEg8RJdfC2UownQVqMYM4WAKUo8
	56gqDOXDroRhB2zO3Q+8VPBxIjUJZ6fyyGJffiA3UZVXSb2Z4qJGUlFJrZpEJfRKyjs=
X-Gm-Gg: ATEYQzybxYto+P8QQOubnIUi9PgD4sBB1e4nlWIy7c8A0lavqZtmkxzJiSUUURQtx7W
	EXdJLUAm0pMTlsnIXBueQZR4ijlULO45J8iChEi8H/iiBCwSiWcspzfQLH/L6MzYtYWNbUrZe3x
	LwN4fB+q11HM+FuCKTIVGtr3AzrfUIKqWc4hz4OKYoafyDm1HAb2TdStMKJRhL9lJDa+gKtfdKU
	iOYFIhMYCTdXPnbqFa1bGY2cCf1kFYZ86HNsjivcVsSZUzVDIXTsXQ4RtUtxPq5GduQZJKWAxHw
	ns3EG9P6lQHGMUCUsLtxKoBJ51gaKjYlzZLqfLVDqMrdg9md6Mba5egypVOFR3uGmZeKjLqKjxp
	dowx2gWZ7fVNE+FDm3KpCIeMEVeN0zcq+pDorjIikXtV/ylwT8efWySVxupkWRZ6v1vHgMtIOh/
	msZJPPYXWjsY18V0ESMumqJTw4/rfLkCnRqhw9Su5RlxCYrdfZSiS0wE9lr4VMvSLcwMgJekJ8k
	5/In4UScBvkqxzfqQ==
X-Received: by 2002:a05:6000:2203:b0:43b:46b6:87aa with SMTP id ffacd0b85a97d-43b64277e1amr18640357f8f.27.1774271375078;
        Mon, 23 Mar 2026 06:09:35 -0700 (PDT)
Received: from ta2.c.googlers.com (140.204.78.34.bc.googleusercontent.com. [34.78.204.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470c239sm29651241f8f.27.2026.03.23.06.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 06:09:34 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 23 Mar 2026 13:09:27 +0000
Subject: [PATCH] iommu: Fix bypass of IOMMU readiness check for multi-IOMMU
 devices
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIY7wWkC/x3MQQ5AMBBA0avIrE1SRamriIXUYCJU2hDS9O4ay
 7f4P4Anx+ShywI4utmzPRKKPAOzjsdCyFMySCGVKKVAtvt+oaNxetGsZDasdKNaVeq6MRJSdzq
 a+fmf/RDjBy7q+fRjAAAA
X-Change-ID: 20260320-iommu-ready-check-4976863957c2
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>, Bjorn Helgaas <bhelgaas@google.com>, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 peter.griffin@linaro.org, andre.draszik@linaro.org, willmcvicker@google.com, 
 jyescas@google.com, kernel-team@android.com, stable@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774271374; l=2378;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=lTpldD4eL76NbvK555N/Xx2Kd24uIcQoPu7MsvhV6l0=;
 b=t55I53gjpaEnmHL4phC4I+QSAaGYecA0xntMB6DObcA3FXm8m3v3G7Z/pZ44CrPmDg4EYupY7
 2+TC4ZG5EZUAIYs/zpKafQyyyqzwRsarbQ0Rz4wCnYTwwXlEdzGE9DF
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Commit da33e87bd2bf ("iommu: Handle yet another race around
registration") introduced a readiness check in `iommu_fwspec_init()` to
prevent client drivers from configuring their IOMMUs before
`bus_iommu_probe()` has completed.

To optimize the replay path, the readiness check was conditionally
gated behind `!dev->iommu`:
    if (!dev->iommu && !READ_ONCE(iommu->ready))
        return -EPROBE_DEFER;

However, this assumption breaks down for devices that map to multiple
IOMMU instances. During the initialization loop over multiple IOMMUs in
`of_iommu_configure_device()`, the first IOMMU successfully allocates
`dev->iommu`. When `iommu_fwspec_init()` is called for the second
IOMMU, `!dev->iommu` evaluates to false, short-circuiting the logic and
entirely bypassing the `iommu->ready` check.

If the second IOMMU is still executing its `bus_iommu_probe()`
concurrently, this allows the client driver to proceed prematurely,
resulting in a late IOMMU probe warning:
    dev: late IOMMU probe at driver bind, something fishy here!
    WARNING: drivers/iommu/iommu.c:645 at __iommu_probe_device

Fix this by making the `iommu->ready` check unconditional, ensuring
that a device will defer its probe until *all* of its required IOMMUs
are fully registered and ready.

Cc: stable@vger.kernel.org
Fixes: da33e87bd2bf ("iommu: Handle yet another race around registration")
Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
The warning was observed using an Android 6.19 tree, using downstream
drivers (exynos-decon and samsung-sysmmu-v9).
---
 drivers/iommu/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 78756c3f3c40..e61927b4d41f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3042,7 +3042,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
 
 	if (!iommu)
 		return driver_deferred_probe_check_state(dev);
-	if (!dev->iommu && !READ_ONCE(iommu->ready))
+	if (!READ_ONCE(iommu->ready))
 		return -EPROBE_DEFER;
 
 	if (fwspec)

---
base-commit: ca3bbc9287400c1274d87ee57a16e3126ba2969a
change-id: 20260320-iommu-ready-check-4976863957c2

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>

