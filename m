Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51B057EDAB
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887849; cv=none; b=qzMwvpeVAqvJyg9/qooHX1KSPHvAPptw0KJrkZHSDzbvfXCEiMN/9tIAE1l1GAMtdB9U4UbhYZ/EqexztaP1bkaYrNk7PVOAPdAbBS4PiKmdO8J2W8q3G/uy58XdyGYypp6pZVEsqboCRwd5ITQoiSEu/1c1OsuQLvOXrAv52wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887849; c=relaxed/simple;
	bh=EeYRFuvs47t7QOAuP3JxTQjUsoFMrh6fRaikF9pBwaU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o56bNFsvwT1qAYJgyPfQDqt1GPLqXSUbE8bJV/Z8rPYZcmtut+hA2tATAQOrjzwnRIqGbuX38tIPi/7W7YLCK7FLPInbgV76j66Tb1ZDCSu0dm/7Y4BQIhAyQL2HnxLeFnuAOO+aAQcVsijl+iV+31p5w36GtIw/jwduLb0VbVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Upb9TR4L; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Upb9TR4L"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86261e66700so706904b3a.3
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 10:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788887847; x=1789492647; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jmQT3ZxOmdEiP4LKePsQlSnKUdnPc41UVBmmgnCjG8M=;
        b=Upb9TR4LuFB0zPapn0cm6x8AKqnieQ1/AxWc2QbAEYHSTaqtPoIlPhaKETlM+//qgf
         kQcOEWQovO7YXw6EjUk4d9XB4Grh9jDHgKYwtywRGP4SNG2pVVJ40vWVC3HoJ2kWU725
         mr2AZ8AVsoBLI/hB/KcaRF7E+sPYOF3O69MH0bTzSJs5pIRPI1gOCguSEsyfKtA7lTr/
         A+76jVfSlmHz4Rq4k3xgYbCcwOHsj9jnybQB5+RcVPRCQwg59P8vqCM+upGPxHz8R0oT
         NOmgVi0czGDDGcoLBD8TwCyUTlXflLvjSd6pTpmMbQpzBgRqh3YGkbdXR4BJI9TvvXG7
         crCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887847; x=1789492647;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jmQT3ZxOmdEiP4LKePsQlSnKUdnPc41UVBmmgnCjG8M=;
        b=ILEMSVnIteHBJb0yTaOYb9MsyzBU9rAB/J4PWF9bEB6HFI7baIREABLV9m++cdeYzM
         oNibqZsfXyvqqi4Z+jvWaA51pOGJs6JkwzbkyxjSS4UN3Hk6HGb0NPNLRgJQsexuB3GW
         Idjcd87YZ27g89qOXNqbij152U2+uV3tL/Qm4CbO1NnsJbI9nzcVimxlkOpjt8IAr7Ai
         tX82RvLr04zhZZUJhSnL8vkxcQuFNAJ29uscpD4KRXYcQRhP1dTTGdEqM88l6PIO6Lt3
         vljtsySLa0zctzW/WPIQEtofQW8TFx3yifl0nbziJ9+nXTV3c/kVwfGN6lxrbQHgqtv/
         4euQ==
X-Gm-Message-State: AFuF++m7x7jf9GmfMqZt/JMWiJH2V/Nwe+w9tGZSPb6xrB4OpeJB5bjG
	B2QzuLrmFMDjmZXijWgo2qpSFaXsYg/6BYrKcfNj9VUG0c4QfdruTXq3WEDL20tFCoQsOdrrZ8k
	dDIuBQP8u52tFm3A3/cSoj92UuHmIFE/jN2y7IzEfRJiIuhn0jvCR6n66IupNuXAOqYkJPwxIc1
	PLpWQUQwlRGAgAeSUzAfkiaYcx+cRlEQ==
X-Received: from pfbhw1.prod.google.com ([2002:a05:6a00:8901:b0:851:d12e:df63])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:338d:b0:857:73e2:9104
 with SMTP id d2e1a72fcca58-8616be5fd03mr41477096b3a.20.1788887846875; Tue, 08
 Sep 2026 10:17:26 -0700 (PDT)
Date: Tue,  8 Sep 2026 17:17:01 +0000
In-Reply-To: <20260908171712.356645-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260908171712.356645-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908171712.356645-6-praan@google.com>
Subject: [PATCH v10 05/15] iommu/arm-smmu-v3: Add a helper to drain cmd queues
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

Before we suspend SMMU, we want to ensure that all commands (especially
ATC_INV) have been flushed by the CMDQ, i.e. the CMDQs are empty.
Add arm_smmu_drain_cmdqs() that drains the command queue using the
arm_smmu_drain_queue() helper.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 27 +++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d809b625f7fb..dc2fc02b5163 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1028,6 +1028,33 @@ int arm_smmu_drain_queue(struct arm_smmu_device *smmu,
 	return -ETIMEDOUT;
 }
 
+/*
+ * Lockless, the caller must ensure that no concurrent command submissions
+ * can happen (such as during suspend where clients are already quiesced).
+ * Polling until PROD == CONS ensures all pending commands in the queue have
+ * been consumed by the hardware.
+ */
+static int __maybe_unused arm_smmu_drain_cmdqs(struct arm_smmu_device *smmu)
+{
+	int ret, err;
+
+	/*
+	 * We skip cmdq locking here since this helper is only called
+	 * from contexts (like suspend) where the caller has already
+	 * ensured that new command submissions are fully closed.
+	 */
+	ret = arm_smmu_drain_queue(smmu, &smmu->cmdq.q, true);
+
+	/* Drain all implementation-specific queues */
+	if (smmu->impl_ops && smmu->impl_ops->drain_queues) {
+		err = smmu->impl_ops->drain_queues(smmu);
+		if (err)
+			ret = err;
+	}
+
+	return ret;
+}
+
 static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
 				   struct iommu_page_response *resp)
 {
-- 
2.55.0.979.g7e5102b832-goog

