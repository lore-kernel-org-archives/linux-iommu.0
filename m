Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2825019A2A3
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887858; cv=none; b=Q2xrUVxBQymEsaN+8pW3nylOzSxD081TTBAxlaaM1meDV8hZy6ghdjptVf4/lfm+9fB2Ma6pBPtuUZtTrxYYtGhHLrt1tTzDC6pBiQzXLjDzOzRrlYYTnBmYdP4mAgGyuocJtPIIWC065ZjoLiS+9G168RjCcyNAi4+V4LC0u24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887858; c=relaxed/simple;
	bh=cdaxMQHwiQp02RsJxhWqOH/Kr9ylSgpEHgYFtxYe1Xg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kVBwxhSbzSmuVzYhicrAn0onzlBJqF4sSZnmynXpBAWjEkUxe3cr8SnSx94fojXKgYV18tzjoosDgBD2Zyrk6ChU6ttaWy9c6nGqLawZdbgRNLcYPNAB9uFUadxacHFuBwLk1Muf0VTLE4wApuc9GEXaQFdAgXsOIrTjFTjTKNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uwup8fbe; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uwup8fbe"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so6011620a91.1
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788887856; x=1789492656; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QgPugb2YkxnKi50b7v+3nkhZYP2FraFhAVSvIFRbVA8=;
        b=Uwup8fbefuMYdCwU12Ppqbe34S5BrkqoWahRPk3GjPXb9rMoBKXIe9iG0OIkT7z0qy
         4z/mcOh5kVH3iTh0I/YP/8r+4CDF7QPiTV7SAvJIB1vMm+N6ko5lxOXu/kC2C+zobZxP
         BcteS15OfJ9eIL7JLlf8ACq2z/w0vQCsJp0XU9KRnIzZDD18YuDepFINhsAWdRSkus8Q
         hKgCziz4CBzOG5xgm5n9jRqpyYE9Xd9WaMPBVEaXXR/mEMCJ+APgTEsrlUwwCuG9JKzk
         0I0uPBdeYcJzMMmoJSQ7kYy10rUHxykDQKIGTWLVMPWi5Elb4Kks8p/yW8zovYpruL6n
         6t3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887856; x=1789492656;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QgPugb2YkxnKi50b7v+3nkhZYP2FraFhAVSvIFRbVA8=;
        b=CoyKLKjcSiDUQioeeHu9l4DagwLcgKdMZTomBW6/5fLyfuu6GGZU0fzOZ9ijxWNVlg
         m2805xpbUJ+IG6clTZUJ1u6roKdzVVpmkO7ygBv5Te0yMTOMiUlArmYTZs+lS2whvm8m
         BjfQ9GvAURV4oDasjiotoV8kxo/HmfgOoRwnKcIh4bqdh8GAlGvwSkrjvMIMh8ZGDHKm
         FSQfT5TSDe/1rTLjqPd8GcF28URYsw0JQg8yLUous/WXibDmQjAx9bE6XLkKDBHplrc0
         OZF3v8ZTPYWZ7qDa9NL27QlFcox9Mz1zMkDzaav+WJ3/QoRRwwVN83wtyQoikXJQy0Ow
         NzeQ==
X-Gm-Message-State: AFuF++lNCTryEapsnzfAXWjBCFZHhB0t8RElidJR+iYyI++WOuOLr+m8
	lFeXhw8iobDQH2TuD56RnxygMm8XKzRmC/O9/Q/8X920MhYllugSfB8C2n4KQqddX/BsarLA6mE
	eFReh7cfHgv3qslHuAeCJ+AmOKyQzTxC4MIRwVyaTql8aSLctZiwPFD5wOMmeMOXFLA7nPeUvZW
	RRbIEb+2Iv+tEwFlrnJpjEpaQH0TtbwQ==
X-Received: from pjboy12.prod.google.com ([2002:a17:90b:448c:b0:39b:9a5d:65b0])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5807:b0:398:9be9:ab8c
 with SMTP id 98e67ed59e1d1-39b26229bd7mr46877613a91.17.1788887856115; Tue, 08
 Sep 2026 10:17:36 -0700 (PDT)
Date: Tue,  8 Sep 2026 17:17:05 +0000
In-Reply-To: <20260908171712.356645-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260908171712.356645-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908171712.356645-10-praan@google.com>
Subject: [PATCH v10 09/15] iommu/arm-smmu-v3: Factor out arm_smmu_handle_gerror()
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>, driver-core@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

The GERROR register's state might be lost when the SMMU is powered down
during runtime suspend, requiring the suspend sequence to handle any
pending errors before the hardware state is lost.

Refactor the gerror handling logic into a helper function. Subsequent
patches will invoke it from the runtime suspend callback after disabling
the SMMU, ensuring that any late-breaking gerrors are logged and ack'ed
before the hardware state is lost.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a8166e75db0b..98af7c1fac94 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2406,10 +2406,10 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
 
-static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
+/* Lockless; must ensure that there are no concurrent callers */
+static irqreturn_t arm_smmu_handle_gerror(struct arm_smmu_device *smmu)
 {
 	u32 gerror, gerrorn, active;
-	struct arm_smmu_device *smmu = dev;
 
 	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
 	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
@@ -2452,6 +2452,13 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
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
2.55.0.979.g7e5102b832-goog

