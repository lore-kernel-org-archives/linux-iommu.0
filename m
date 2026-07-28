Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48774156C9
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272990; cv=none; b=f8JwqYUdJGBbfZy/5+Y2uF8uJ8KgSC1Dd/12LJPVWT/Et3zSVkB5YbPxz2k3LQs0O7jWtkHGgrwppvoLSnJFG2/4BQLHNpTKHC39nIGaSiADF6BHjyAjG5Jr8+J/do5V+Lcl8BEggAzPHKreSoIUAJ71e2F/rGTtvKd/ZV+FFR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272990; c=relaxed/simple;
	bh=+o6RtrT1unHkXqeXaPFC6V6qErJ8JQ6nWv2SoZN11lM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uwhZfHl1qv2lUYAUWEK65YM9Gf+hyI3ogJEoTieWyzbW9UyZs4brZCbWc5DD8lT0mcsbnaupJ/L0PgY/3dGDlkhDwn6ydLHJQr09OjGoEaDodvJnYmYzsrtT3Y2p7C+TpBqAeimpDHxg0Fkn9jxFiIkINS1Tty2O/ef16MLt02g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lZ9VJ6C2; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZ9VJ6C2"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8484f26852dso241385b3a.1
        for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 14:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785272989; x=1785877789; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eNoqOAY4je9wBsYGW6EWEKl1ijHq+m++0XLMmlJB/BQ=;
        b=lZ9VJ6C2e7KSy/N6beLL9nevAyp0NrCkGEp3AZmpHTV7n2YmmYTSPHYkjCXgKq40Gy
         hZpKWO/Kt5hRJ/5kED7DGdh424ZxpebRYDkJaiD6TvJnWV4mb+7n26ff61LEUq9Gu/2r
         RdraRX5u1byswzLEYZ7pERms8Snfr+GKCvz3ppWAstsMlO3NDm0x/v6usd7djAjOYXQ0
         E2bUYbRoDrC5dbRQgMmos+C1Az2HnSzy5PPud/ansfbFys5wSDmtGHvd/Ip3U83HTJZW
         uqh61kCm+WJZjTXhaW1foPJkjxdOw9mXjgvWa5JPKsrYdrNCoppPxJepbCG0tNtjvE8B
         3zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785272989; x=1785877789;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eNoqOAY4je9wBsYGW6EWEKl1ijHq+m++0XLMmlJB/BQ=;
        b=lk28hgPAPj3ilK/SEq2pPhy/LdVjnZu8xwEyTT2B5RSQxqpqycVcnlzq4tgeIyNGy5
         2HXEu3LYGf9nGvQrK7YCIcGgkTJdPQHENMULuP0qngU/TebnVa/L9jlR12UKXgRAP7mZ
         aYSIORSaropuX+2St6Vb6q+1wreMqdAHVacHXi8/A014hjLnwrK0ESBMYnVkMmWJQuzl
         X0xr6JOl+uID1B46nllpvss+6CwwrJDnT1MvICsv8m6ATGf2ZYO6tFq4o2JnDU/wjbva
         doR+12cLG8dxxaaOy4rsVzVmzmA656dHtyYcoYTMZzWmN0jk4wZ5g3zlbjj7f3OPFZBx
         LZQg==
X-Gm-Message-State: AOJu0Yz2hR5jRJ0gv7PubseW0jA7YZqzATeTFf2sUWKx/dNnkQTEp/Oh
	hr8T76U5eKrhGwJNlhDUiPnZIA62fGJkpjpQ7rVREMY2ezyRr3WKn92hbmF5RPlSOKCtIUyy+cs
	6c0bhW7Tnqqum8qJkNx+YOig8hroMOr7oVcyEcfMcb4EY0brsK9rVE1TxG+uVgPX0yeiOkZoMjG
	qMIVskLmOUyy610tqzGiAzSor+1ZtCUw==
X-Received: from pgmm13.prod.google.com ([2002:a05:6a02:550d:b0:c8f:f76a:4b22])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:330a:b0:848:7071:9863
 with SMTP id d2e1a72fcca58-84e932b74a0mr3960583b3a.53.1785272988596; Tue, 28
 Jul 2026 14:09:48 -0700 (PDT)
Date: Tue, 28 Jul 2026 21:09:22 +0000
In-Reply-To: <20260728210928.1050849-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260728210928.1050849-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260728210928.1050849-7-praan@google.com>
Subject: [PATCH v9 06/12] iommu/arm-smmu-v3: Handle gerror during suspend
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	linux-arm-kernel@lists.infradead.org, Pranjal Shrivastava <praan@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

The GERROR register's state might be lost when the SMMU is powered down
during runtime suspend. Handle any pending errors before suspending.

Refactor the gerror handling logic into a helper function and invoke it
from the runtime suspend callback after disabling the SMMU. This ensures
that any late-breaking gerrors are logged and ack'ed before the hardware
state is lost.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 03b80ab0a59b..2a976f210d9b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2352,10 +2352,10 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
 
-static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
+/* Lockless; must ensure that there are no concurrent callers */
+static irqreturn_t arm_smmu_handle_gerror(struct arm_smmu_device *smmu)
 {
 	u32 gerror, gerrorn, active;
-	struct arm_smmu_device *smmu = dev;
 
 	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
 	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
@@ -2398,6 +2398,13 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
+{
+	struct arm_smmu_device *smmu = dev;
+
+	return arm_smmu_handle_gerror(smmu);
+}
+
 static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
 {
 	struct arm_smmu_device *smmu = dev;
-- 
2.55.0.487.gaf234c4eb3-goog

