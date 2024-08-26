Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4683182C60
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656622; cv=none; b=DYNsc3m+tny2SzXxdfJU9ibcRpKwQRc2yBGc/T/5r61ja6Ow6zuq4189KeRIJSrTjcca0iHyhHPq9uVUqpEBgJGDr4TLQSL9yi1SbX8EgAVmkbVGKwRpzQh0JnoNFiO6ZCEMC73Wx+TBhLayez8pfBhoDkhVQZ4rvA4iU0X6MmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656622; c=relaxed/simple;
	bh=nkaV0XfZaGR8p4drm8Z0uuSWaFZNEisvVSIAR+WDUHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HVaiRIntJL3jlmPUH4RxwUANTBmS8ww3H+kKqIkWhOc0F3U9dqP+0zusgEbNbDmdov5xz936KgiWrdk1mfRlrPcrs5BZWObTxZM9fV/J4xg9xEClrNNscIg9G1l07HMG0PvnNraDHG8XrPGNaamSjUf/nBNpvvKLD5sjyYXDH0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H9P9vJ3a; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9P9vJ3a"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b46d8bc153so76180297b3.2
        for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 00:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724656620; x=1725261420; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BRShtYLZmJBPJSHqgx4PDt4rvJ58jLkk96vd1/jbIvg=;
        b=H9P9vJ3azC4f3oju9v1cuEeSJ87YQ1wKlZYQyp+r+H+AWK1vO47b8RkA5jAOhBmwjG
         88inANynlM80IhY1gGdUFmVRk92yRdcjvdC5eP+ZwTCATJ3/cqsBbER/F02YzEUdn5ue
         3av+OFoCmKvLpMMnNPlgsKq1xCRalIkih7gnRFSkJG0fu7NBN+cjCP9KB3bvl12oV1FX
         LxkgeX/FELsSJgIhrmtsZk4s9Zai/H+an7CUmklhhGVWaiDVCwiMq5Ofjurb0xqGvsMV
         QfwlPdHc0KUuCpQC00+kZhiGrnYCHuGoM1aylV2Y8hzsPcZKutcVI2n7zRNngYYN7TNr
         9MgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724656620; x=1725261420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRShtYLZmJBPJSHqgx4PDt4rvJ58jLkk96vd1/jbIvg=;
        b=NR9vpw9+IpRyNLXBCB8Br4vCuVF1WBl3TDY+Ej9v+787Tnc+Td1LZlaFQhVvoPqZDh
         yFVehEPmBmFTa3HnVD98qkYWZbvJVJuuyzOWATS+VkuY51p8KPu4DjMewO9kNRRWglQH
         RWQyp0eZxjVJrtUuuY/RK+qKNOobFf3tVR00E2oUtrcv3Xwg3ObwYT4QXK/Idzk6gXOJ
         mfrCOOW35vb1nnA5wGMRJONNWADeHaIEkEfH5lrmW04H9qp4zk8lRrm1P/DuE9R9ajlW
         YZFQGiadaENKiD4WfPK9KKgvYhr+qru696WEX2DBpb4hRsxVRuUQtgE0ew3JK+9k1AS0
         ikOA==
X-Forwarded-Encrypted: i=1; AJvYcCUxquYJrL+o0eCAU7EZ6A0GbFjjdXbNMHPVqSzjYSiSkhNjMjwJQ3cFt8YFxwqMGhnG5jzJeg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5b1uHnJcJZEQdIRQsRkXZHuH93UxZAdX2xL+66Tl9sU9FsHfb
	IFODgfQAfoHJXMgZvkKrD5OoBcX1KukcpyskCOEOc/LXdtDDNkqj6V11umiIJX6Qh90c/imvqko
	AB/agOtQerEeAmw2lEA==
X-Google-Smtp-Source: AGHT+IFvc8OHSGEhjIEIYer2jfp9QrAbi6exBOTouXCSVWGbyUY3HkgdonvtEDMyxk52fnOPsWuReZ1tNXp20tcu
X-Received: from manojvishy.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a05:690c:2b8c:b0:69a:536:afde with SMTP
 id 00721157ae682-6c627d07c73mr623137b3.5.1724656619604; Mon, 26 Aug 2024
 00:16:59 -0700 (PDT)
Date: Mon, 26 Aug 2024 07:16:39 +0000
In-Reply-To: <20240826071641.2691374-1-manojvishy@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240826071641.2691374-1-manojvishy@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240826071641.2691374-3-manojvishy@google.com>
Subject: [PATCH v1 2/4] iommu/io-pgtable-arm: Force outer cache for page-level
 MAIR via user flag
From: Manoj Vishwanathan <manojvishy@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>, 
	linux-arm-kernel@lists.infradead.org
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	David Dillow <dillow@google.com>, Manoj Vishwanathan <manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"

This change introduces a user-accessible flag that allows controlling
the system-level outer cache behavior for mapped buffers.

By setting this flag, the page-level MAIR attribute will be forced to
use the outer cache, potentially improving performance for frequently
accessed data.

Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index f5d9fd1f45bf..31dd6203db96 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -471,6 +471,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 		else if (prot & IOMMU_CACHE)
 			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
 				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
+		else if (prot & IOMMU_SYS_CACHE)
+			pte |= (ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE
+				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
 	}
 
 	/*
-- 
2.46.0.295.g3b9ea8a38a-goog

