Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F089C3093B5
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716620; cv=none; b=pNdaMsvph+JsaT7xBPoWtXRhlHuTC8xsuBdlphMu1whorg1e1DXYlAinQdi37mrhMyJXT0HIFcRDCBVtmv25MzUmkLD0ntATg899jh8PCWkJUBWyd5l9dcR6AQ/O8SVVIl0y0rx5/ultci07stqkykJklrrmv/UKLStKZl42njg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716620; c=relaxed/simple;
	bh=pvBux9MrnlAMWMFa4Uh7+3qgqbfiM2xGpKsmVCsmNyM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dggBuDtkhu/bkrAVs3pDhOo+nU1N1+t4ivBXg/QYPWay1pTJ02tfC4DJOciYHepXU2gjY3tb3lhy+w/Q61woO57KeffiRyZdTtDqbIlpDT2a1riDTnuNyCuMxgOfBHmFTB07znRFwrGdEvTgPH/kIONzXU4qNPuV54F9sJvjkpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zk3NlXqZ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zk3NlXqZ"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b9090d9f2eso9927131b3a.0
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716618; x=1765321418; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0rRMYSJaIx0qr3vb82dfybhkCQZzRoj8+W9ZBsbF5AQ=;
        b=Zk3NlXqZQp4H4Jya9fA/mJ1kvmI3WvO/JgLqGTsiDHlUqoHvfyyNF5pfy5iX+mxLZi
         3WTQLCYxZooXoDewSH9M5nExf5+aEUw4b7IfCqQuU43icdKrTnyqFhjFgn7Y0hp9jKGz
         h5eTxhW2dQ+P/cCFvJVQpvOhrDsLeb+Ph7hEFIaxn3EDJUiFQYPHHAxdF6ZA3Is0la6M
         o2gpAJH6QI9JGgpsvVDiDfD5E5gIPuknRsrbg9IyutJGl23o5f6r1PynO4J6H/wwRBKo
         evqyMX4zRReHsx1J5NOypDll67uBqcsgDrvvqTuQXG3OqPflRkmCgmHTIe3LJuOgGdWW
         JgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716618; x=1765321418;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0rRMYSJaIx0qr3vb82dfybhkCQZzRoj8+W9ZBsbF5AQ=;
        b=K4fLBITlDI7T5zmdgpECh8PZMcrb64iEqeRsQRlAX2slTvZhbRXidcC2pLBfl5s9FN
         hiczY6CtUadiX+wIXOBFT8NhcNt3WnHP12g1zakKqYGAbddNHaf3Pjit+g993vwqKMyV
         D1F8butvvW7Uokthr+cKPYwpFVSrBrWwB+9ZZYu2oqqds03amryrF2Z55C7TzMqoItmr
         IwkzkMi1mruQOwHfYozQifCpD425bfp2omsklwLkt9uydBNoYh/3qySxh16zWUegQffW
         qo2e4JnEsOM8/+P9besLmeCy6yAJR4+mBNXd4qgMkDuGd3YaKxXTlwk3nOwVdGTr4q2S
         JH5A==
X-Forwarded-Encrypted: i=1; AJvYcCWJQOrbKcVtbT5EDhjMMTj41EM9CS2H2EBY6aBCLa6VYxQNJsHZbxn1POS6yyRf6v2FQ+I27g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyF8QriBx5TpXxHj3fyB16/VlXF5Q9j3QpOvK4BY6MkCf2Sk+KC
	plLT49lXZWVqhijldNOHh62vNoEkg7CEDYTOsMELCJjDDLA1bWfz65hLGdb9UQkhNid4QKvYg8B
	FrGiH3M5MIQjzPA==
X-Google-Smtp-Source: AGHT+IESTY8l5ddrDwVhJ/K1t5B3qZeQchQ/+iFaGXMixSxBU4Vhr8vdBuXurh0T7DhxTKKU+YN22LfKABc7gQ==
X-Received: from pfbfc31.prod.google.com ([2002:a05:6a00:2e1f:b0:7b7:8636:7b21])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a24:b0:7b9:ea7a:9cbb with SMTP id d2e1a72fcca58-7e00dfd6852mr173441b3a.19.1764716618194;
 Tue, 02 Dec 2025 15:03:38 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:52 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-23-skhawaja@google.com>
Subject: [RFC PATCH v2 22/32] iommu: Implement IOMMU FLB retrieve and finish ops
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Add implementation of the IOMMU LU FLB retrieve and finish ops. During
retrieve walk through the preserved objs nodes and restore each folio.
Also recreate the FLB obj.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/liveupdate.c | 48 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 5780761a7024..0dfa03673178 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -14,6 +14,17 @@
 #include <linux/pci.h>
 #include <linux/errno.h>
 
+static void iommu_liveupdate_restore_objs(u64 next)
+{
+	struct iommu_objs_ser *objs;
+
+	while (next) {
+		BUG_ON(!kho_restore_folio(next));
+		objs = __va(next);
+		next = objs->next_objs;
+	}
+}
+
 static void iommu_liveupdate_free_objs(u64 next, bool incoming)
 {
 	struct iommu_objs_ser *objs;
@@ -98,11 +109,46 @@ static void iommu_liveupdate_flb_unpreserve(struct liveupdate_flb_op_args *argp)
 
 static void iommu_liveupdate_flb_finish(struct liveupdate_flb_op_args *argp)
 {
+	struct iommu_lu_flb_obj *obj = argp->obj;
+
+	if (obj->iommu_domains)
+		iommu_liveupdate_free_objs(obj->ser->iommu_domains_phys, true);
+
+	if (obj->devices)
+		iommu_liveupdate_free_objs(obj->ser->devices_phys, true);
+
+	if (obj->iommus)
+		iommu_liveupdate_free_objs(obj->ser->iommus_phys, true);
+
+	folio_put(virt_to_folio(obj->ser));
 }
 
 static int iommu_liveupdate_flb_retrieve(struct liveupdate_flb_op_args *argp)
 {
-	return -EOPNOTSUPP;
+	struct iommu_lu_flb_obj *obj;
+	struct iommu_lu_flb_ser *ser;
+
+	obj = kzalloc(sizeof(*obj), GFP_ATOMIC);
+	if (!obj)
+		return -ENOMEM;
+
+	mutex_init(&obj->lock);
+	BUG_ON(!kho_restore_folio(argp->data));
+	ser = phys_to_virt(argp->data);
+	obj->ser = ser;
+
+	iommu_liveupdate_restore_objs(ser->iommu_domains_phys);
+	obj->iommu_domains = phys_to_virt(ser->iommu_domains_phys);
+
+	iommu_liveupdate_restore_objs(ser->devices_phys);
+	obj->devices = phys_to_virt(ser->devices_phys);
+
+	iommu_liveupdate_restore_objs(ser->iommus_phys);
+	obj->iommus = phys_to_virt(ser->iommus_phys);
+
+	argp->obj = obj;
+
+	return 0;
 }
 
 static struct liveupdate_flb_ops iommu_flb_ops = {
-- 
2.52.0.158.g65b55ccf14-goog

