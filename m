Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C111E2749F2
	for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086484; cv=none; b=ZDyB4CHQcrBcWGs+h1kc45a9M64bGdLRke/TSpgkFbf6CVehBDa7nETZkn8lTvs1w7PYpVSdyGBe9URX7OUzeMHQsQ9aZtm8KPIKmDeq7YDpLoj6LmqRDw/acK5CCQrhslVGg9lh9OePYDhC7LP/VoCN5REcBqS2Lo436rJEYJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086484; c=relaxed/simple;
	bh=iu8bF1+1izo/N9nO598vTqm7TLEKTMTdaWt9KfjORTs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DQwdZ2rsQDBq/YpnT/CKH8tWg/rzwOk00J6itxif2uMkOPkhwdDQm04LLRUB+pe6B1bsPjCYrsqqdJpc5KlX4EgGhietC4/CJCQLKT7vgHGmTeIPDWoCbEzJZnc1VyCpDbQNTUnNyEOzag07TP2QEO1w1jhhW/dRASJiXA7tSY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iPFMUNqn; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPFMUNqn"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-78102ba5966so3465666b3a.2
        for <iommu@lists.linux.dev>; Sun, 28 Sep 2025 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759086482; x=1759691282; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6rIkXRuvh9+tWEFzDbEPwiqaPEAKampFFEauxRboPc=;
        b=iPFMUNqnqhuOA5JiBcTUvxf6NNXNYHAH1jzuegQvGLu0vOidKwG2UMsF8vcaZz7tQy
         bsIl+kRZm0QZHf/WFhebEpIeDU67a1s4cGI6wjJJSwe9IfkCUwgSC7Dm7b+v0FVK28tk
         wz8jl5mpI2U4pjuNeovujuapau27sNwfnVqvZ0Ji4I/eNUqkCzfpJp/CeCl7ehHoMr06
         iw5irvuIyFpi+Haps9ZeYr39wj2dwcchEzut11EsA1Ol3zkoMToHfCKhcZC5Kc8cnfK9
         XvpTn8KiZrL+kL3DgYENB16mrqgHh5nsWXhbbsgG57LpTdjW1Ffv9Au0ZNjUGz4lY3wR
         oesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086482; x=1759691282;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r6rIkXRuvh9+tWEFzDbEPwiqaPEAKampFFEauxRboPc=;
        b=nsDwhKB0BUvvV/SYYE8535hVGylinvR/PDHooezQTEc0J4mXNLxJ/GD9lW4M0JE1y0
         WiL+y4RPDwXPQegjl/c1cE1vKTYoU9QSZUfLVIABR9cAeGcHjCExcmPE3nX3z1+ITI/H
         +GspOlRnGfEsva5QK8LSKFBbFN8F6hYgP+miuHqNX9BAdlUAZr4dnEd7MBA1vK5Hfrix
         ALE+Z0uLjYTSCde65CoJl2GGdYTik3Xo85QJWPaC0fcTJZ5N9X5nGqTyZxBuk5NNqT9X
         gAfqdgGDOdO45a7Y9bPvV4M02Wg0Vyr32wBYAppRf6K3Z8ppee0KM0bOYwF5ViKuYjzz
         f1IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOaSQVh3F3nE2m2KrslqTuko4sB2Us9T8M4ZnTgQO8JnapKWk1xYpqkZ9GDc+D0HiuaWcuvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmzVMpXNT8bS07hQRm0GcmORjJnRZaEhSExLbTlS8Riv2B3hAs
	ouLL1YqMWOVvsztVXa0bEhDYXIh/9FEOy/vfJXD/JXmwtqME0f/ESf5ZPxcRxGGI2EmrbiwxYgr
	sUY9nuMnTYUYl9Q==
X-Google-Smtp-Source: AGHT+IG3DYQZH5AWOVC5jjKnDvm3R5bOqt3Kna9JyjjCIT0P03vRmnYOpx62s2gMEvWQZHaWnGO1XY6oqMnV7Q==
X-Received: from pfbhm9.prod.google.com ([2002:a05:6a00:6709:b0:77f:456b:23da])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:178f:b0:781:1e0d:a181 with SMTP id d2e1a72fcca58-7811e0da5bfmr8289263b3a.14.1759086482049;
 Sun, 28 Sep 2025 12:08:02 -0700 (PDT)
Date: Sun, 28 Sep 2025 19:06:22 +0000
In-Reply-To: <20250928190624.3735830-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928190624.3735830-15-skhawaja@google.com>
Subject: [RFC PATCH 14/15] iommu/vt-d: sanitize restored root table and iommu contexts
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

The persisted root table will contain context entries from the previous
kernel. Sanitize the root table entries by setting them all to zero.

This is temporary, the context entries for the persisted devices need to
be kept intact.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/liveupdate.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 755325a5225c..3783632cf634 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -306,6 +306,26 @@ static struct iommu_ser *get_liveupdate_state(void)
 	return ser;
 }
 
+static void sanitize_iommu_context(struct intel_iommu *iommu)
+{
+	struct context_entry *context;
+	int i;
+
+	/* TODO: Keep the context entries for the preserved devices. */
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		context = iommu_context_addr(iommu, i, 0, 0);
+		if (context)
+			memset(context, 0, PAGE_SIZE);
+
+		if (!sm_supported(iommu))
+			continue;
+
+		context = iommu_context_addr(iommu, i, 0x80, 0);
+		if (context)
+			memset(context, 0, PAGE_SIZE);
+	}
+}
+
 static int restore_iommu_context(struct intel_iommu *iommu)
 {
 	struct context_entry *context;
@@ -324,6 +344,8 @@ static int restore_iommu_context(struct intel_iommu *iommu)
 			BUG_ON(!kho_restore_folio(virt_to_phys(context)));
 	}
 
+	sanitize_iommu_context(iommu);
+
 	return ret;
 }
 
-- 
2.51.0.536.g15c5d4f767-goog

