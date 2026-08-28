Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D6B4519B8
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787921666; cv=none; b=bAUzN9eRL4nZx1PKM4hDldN5TXVfu/JkPDxc3I6PqqtqONkAW9LfxFh85jLlPJwoU3ICB5LPOqa0Ddnwq7ws/fMu33aTLmJY2vwOQll0N/48T89R7oH4XnDf6f4spYzhruCBkEbp03HNsujEWXO9Etr+6Fsh2mGMT1D1DCdb+Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787921666; c=relaxed/simple;
	bh=mQ3kcP+CyWgZPZ1iBtlnF8x6qcpBHJaX3wA7zCjENuI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=djLeSTw3sQ1LfOdHin5/a6JsMpBDlo56H4/feJ5ogQz1C7STE6tRqAuyLC6dyvowdf7qhGdnUJ0gJrjPspjOmnPsU2Orr66XYhnZhsupRSq2xbBdxxpg4/r+Ke5YfI1etd6Q5fChjUS4kf7JVgJIkt1/+moz5HyKGonquNlFkMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EcVhXFaT; arc=none smtp.client-ip=209.85.221.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EcVhXFaT"
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4814718d124so552451f8f.1
        for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 05:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787921663; x=1788526463; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hfku0lPz7WJB8aIdUHoXK+mnPfY4Qn0hLLaeSPnv6F8=;
        b=EcVhXFaT9GyS8ELsUHgN8HKwDrmD1+6lSTeJM9/uSVRV05T4+jfom55/gVaH7wNHIl
         fRJyWy2HzFJAb70pES02aIYjNMFj6AxpJOMIHILCb5oQC3NdCkNcoypUDSmFBxHj9Iok
         emIvu1YpOpZaQGSuUYrN30vSmsR77FZvEYpquNzCFDu7HH9Gm7c1x7MeN14vzHMTrdkf
         PM8RIwBGIbnniDoY5ib0wbLsLCkkXvZ/UVLRg9HNEcbJTnYWT7FyMGof4UGdwTkbaPnK
         lFc4mazoJKy2HpYxz73C/y/+qGkO3N6g728tWs7WpEgYtkrF7JwysikASimAiS5gPhSM
         VcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787921663; x=1788526463;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hfku0lPz7WJB8aIdUHoXK+mnPfY4Qn0hLLaeSPnv6F8=;
        b=Wb9nTVrUW+VfrWHL0bXq25kcsC+HiCJbJKG6htH/2xwcAzWfFC7i5J1uq2q6Kf4Nmd
         jKUQuvcZmRvRZ8XQwDCt0jCssMNduC5WgbVyCk+cFNqQH7vQ4nIDMY7hgSQk2+GrJ40J
         m5TBfY+LvteDDKFYPoOlw2SOLPySL+CqdFUiNFCKFezcTk/5n2nvnjGMb6jvviV0r/Kb
         V9m02CRIEAYVmTCVOLUeIrWiIQ/nuOgdfkoZ7QlAejZjxYD04sQqVQpJtlwYvQ8kOoxW
         jxNezMZ80VaVQLjGw09iCx3G5ezVaNhw6VDSnQUqWlRSNMCLiqb4PgNMgwthiO7k8fnV
         SZIA==
X-Forwarded-Encrypted: i=1; AHgh+Rps7If9RNOCAdYdnkLdW9dMaiN1uXZiP58Ysz/9ugo4iIGUJtYfD+Y8+eW9TSqTqD2dx/TQLg==@lists.linux.dev
X-Gm-Message-State: AFuF++lzY1dJ8CSIC76dez3S/tInhj69o0mNn4cbuA2ecRf37JEnnKt6
	TsR9GWJBSrpVnxIevvIj15n5TSp5LIPZ7rqMkSbS7ywUgBd0uamKGHdxQU6Fl2ZMoDVs4FwDmIg
	DcvfzmWBbaFTMNA==
X-Received: from wmqt17.prod.google.com ([2002:a05:600c:1991:b0:49b:8f1d:7d3a])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e86:b0:499:db6d:bc97 with SMTP id 5b1f17b1804b1-49b91bd43a7mr86485665e9.0.1787921662708;
 Fri, 28 Aug 2026 05:54:22 -0700 (PDT)
Date: Fri, 28 Aug 2026 12:53:39 +0000
In-Reply-To: <20260828125409.1921538-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260828125409.1921538-1-smostafa@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828125409.1921538-5-smostafa@google.com>
Subject: [PATCH 4/7] iommu/arm-smmu-v3-test: Fix arm_smmu_v3_test_debug_print_used_bits()
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

arm_smmu_v3_test_debug_print_used_bits() hardcodes arm_smmu_get_ste_used()
instead of using the provided writer->ops->get_used() callback.
This caused Context Descriptors to be incorrectly parsed as STEs.

Fixes: 56e1a4cc2588 ("iommu/arm-smmu-v3: Add unit tests for arm_smmu_write_entry")
Reported-by: Sashiko <>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index add671363c82..eae08d4d77ec 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -125,8 +125,8 @@ arm_smmu_v3_test_debug_print_used_bits(struct arm_smmu_entry_writer *writer,
 {
 	__le64 used_bits[NUM_ENTRY_QWORDS] = {};
 
-	arm_smmu_get_ste_used(ste, used_bits);
-	pr_debug("STE used bits: ");
+	writer->ops->get_used(ste, used_bits);
+	pr_debug("Entry used bits: ");
 	print_hex_dump_debug("    ", DUMP_PREFIX_NONE, 16, 8, used_bits,
 			     sizeof(used_bits), false);
 }
-- 
2.55.0.897.gb25b4bd76c-goog

