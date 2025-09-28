Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FA82609D9
	for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086470; cv=none; b=PzBN8cmlU8/3xlHpYYBb2bJgTkLzCMNRCJMjrGZyGZakgUDFxMVnd9BXE3fQOo9L46WOXG+UDZLkmvxeRWDcHIySPZLz/cEGIsWeap07UqMUNbHD5iL39XMe7m4G6+LyAB+jQPNjdRq3g5Jk4cIyrQNEQ/KtItKfTLz0paoKUBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086470; c=relaxed/simple;
	bh=zDH31s7rsPYxIzn24EVtvl9OZhYo2h1GDjEToyCXHhU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FQi70l3TN1ePj/NbbsWjfhVhk34bGaUClLfXuXIvF2pCruZx3O4TdduIB0C06x8+kHkZeB3cmL4sqBAmQ2GpqJ7+3gXUMxKj1VyzKhBbjSorpNiFR5J0/Cgu2N4DWz0yHaK8ZB7oH22aLv2uFKZLsphxriPucRqTkXsZRfbs7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bkUumU3b; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bkUumU3b"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-780d26fb6b4so3366504b3a.0
        for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 12:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086467; x=1759691267; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKD+6rR+ZCf718VijhXNO1kt7/wJrzJ8IPqx+tgskHE=;
        b=bkUumU3bh2fqFVlIHjePqbBGOqIPPCpSZyRXKlC2+yirjq5RXiNYPeAllwquKJNtb9
         /OTAOFlNaInIFT320o8KWpl7DHhA+22z6pQpzaoi2wniK8rcOvT+ncfYA43btHsXo3u6
         uJqBJqBWzwkri1wzmPds+9jWD8aFJb95JFE9D3WCCrQc4T7gI8d1PeX+SA+/YUpwxOfI
         VAHXaEHMUR6QvC2aOsL/JHFWH6Abvyy907LSIhJJkB/l6/pzmXlYJ/Mddc5OjAGFMoe2
         yE77ZTc2lwlBaOmSOMN43m+mrqNifNK2LLgt0b0+TNeq/KGE5PcP5MP6D4UwyncVT011
         /XDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086467; x=1759691267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKD+6rR+ZCf718VijhXNO1kt7/wJrzJ8IPqx+tgskHE=;
        b=XqzIQS5E+XWwqDuG4EyEud70SNrTqw+MhI6GnZQv99OqW417qnvhlo5qQNNeHMRqoS
         1+w82VJUVD9rI0B5JPHhRy4ne0p4nFHL+Rk5JRUBkDFWuYw1KAmmxXa+iMKBON6hQ6VA
         98PH7GmjyTGGvRZ3mgQsWb4Qk6yOuCtaVF/Y19oeu56AXggE5mPel+e0PtvTSXOuEyDI
         e5FK1Zc6bh/XL1QzaEPFRIL2LL3Zxt74sgrL7lg1+WzVqxacCWktvpEIKUjU6eeG53zs
         +ZYfNHsGRESZm8YxwG706eY4rNa7aDq87eyIyPaPWYwu/lzOOUvbqiIj4B/js10MwX8U
         DZ+A==
X-Forwarded-Encrypted: i=1; AJvYcCU+HpwNYc7z4LX9D4pTU/EO5rwgAR60cOUxK0k0514ZjLsQ3bXxUvm7Oxq521lTfBCwucFuwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUOE8s8uOGJnJyqhP9mQZbCquo55MH/shUuPkZ6QOWH9mivOU/
	3cu1mCsTrTt7jf7WTBc5PtL5NyjSvESRIw1ARBtB2fsyWL/Bs6ssZ5Sj3MHApG678NJvxxbhaV+
	TT2Pd6iaAYijkpg==
X-Google-Smtp-Source: AGHT+IGttSbQUUKNc7Fj+s9+oJWDjLUfJmgHpOgznyqZWeNNRCg9RbZUUOUsFhC6DOgwPPznvL3k5goTDcPGbA==
X-Received: from pfbfp10.prod.google.com ([2002:a05:6a00:608a:b0:76b:651e:a69c])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3c8b:b0:781:2757:1b4f with SMTP id d2e1a72fcca58-78127571ef2mr4881787b3a.7.1759086467484;
 Sun, 28 Sep 2025 12:07:47 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:12 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-5-skhawaja@google.com>
Subject: [RFC PATCH 04/15] iommu: Add preserve iommu_domain op
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, zhuyifei@google.com, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Add an optional preserve iommu_domain op that can be implemented by the
iommu drivers to preserve the iommu domain.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/iommu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d23d078f7c18..40801d8eac61 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -758,6 +758,8 @@ struct iommu_ops {
  *                           specific mechanisms.
  * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
  * @free: Release the domain after use.
+ * @preserve: Preserve the iommu domain for liveupdate.
+ *            Returns 0 on success, a negative errno on failure.
  */
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
@@ -787,6 +789,7 @@ struct iommu_domain_ops {
 				  unsigned long quirks);
 
 	void (*free)(struct iommu_domain *domain);
+	int (*preserve)(struct iommu_domain *domain);
 };
 
 /**
-- 
2.51.0.536.g15c5d4f767-goog

