Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286943;
	b=BGX/kx7toYLqA20XkOWfvpOIjlNsIWteKYLuW3+M4tGjqCidFVNQ1aaszQKbpRO7R01B
	 1iZ+8dsSiDzGa0QFgF/vDUFhjH4p+ZyBO9Ajxvp3zivFJZctLGKObhuWq38lk9LoAZbez
	 ncF8i+ee0MT5GqSFt8rA3n5vwOViBRrOL5OU8ZO0kWaO93ZAPaFiK1C78kZREZHrmkpDM
	 47ckisNS2btNkXYzeXOCvIHdvxygIJv2Vl/d8iG4o5EGqXkTcXIVQbO6aGkBrK8l6fKw1
	 VIN7gATkfAOQuHteXtxlY5lVCKIlA8mLoSf7viRV9rfo8r6FXU4HEtH3lJ9ebj4rw4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=3seM7JJG/qIc4h+h1T0VWvSmXn/fwRDakjk9Gf7qDBQ=;
	b=bQiXmbowhFnf3NoHTUBGML7+iCywAf3OndeJ+lYS43ITGjfru8qp855hnQziFIK0Ec1h
	 Nx+lQ7KppS6H9b9ygLjDAxTWJig+IccZuokoF3jWBAIGL79S4bs5T0++l/02cNIKCVY+0
	 h+J7+cWlofnt/ucwgQfdIEJeIevJna4IOD/KF4jT1ui7+b0XoaBY8LqjleVB8X9Q4vgBC
	 5MIohKiKKPG5BjjI5YmYAPhykjgTBJfjdbznW+hs34pLVF/p4Z+6seqoZYQA33rjrVWUS
	 MR53WKC05SU+DkuKs4AoszDG6fOQY2ufRdzmb/fRC7DjtvBdaMfI7rqEUogGK49Zgxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="o/JndY7O";
	arc=none smtp.remote-ip=209.85.208.70
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7708E606C932
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 05:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7708E606C932
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=o/JndY7O
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6b570b713cbso2126881a12.3
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 21:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286941; x=1794891741; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3seM7JJG/qIc4h+h1T0VWvSmXn/fwRDakjk9Gf7qDBQ=;
        b=o/JndY7OG9PipOCmTX3js+iM/OSW3s+QggXKL9k697YeAjcFybas1KNW7HRgoS1PYt
         OBxhsu3Je7Wy6xZkH5Z+0DAb1qtqh0cO3gLpwNHHtLHjifXF/YuWpUvyr/GaHy4bq5ZG
         CqUYK9SVlQKchVjb+LnrN9lcXU0V2JjbzyjFgKaquNhQjjEN4FGP1KO6ibCIx+gxaGey
         uAt8H9wOjMWUbPrlvunMb9vke19hLRAPShlguIJJBvQMJArdqYxZ1IGFvPPubLavMZRF
         NE3TA2oZaSc2NU+PX+05OVuh0O699WCq0/3BDmRvi8uvjwc/U+iEMQXBhUlNEIKGwz/9
         ENYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286941; x=1794891741;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3seM7JJG/qIc4h+h1T0VWvSmXn/fwRDakjk9Gf7qDBQ=;
        b=YIqr5rUn/Ggi1o5XoGxY95h9Wdx3xhY+xSZtZCgxw7HJi3iLfbzZbOUE/QIsOlvh2X
         +hyxoBWNykKrG44T8G11fuOZpyn8kd2J9K7N5rc+cGVoTx7a8N4KdfKBYxF5h2qyI5HY
         9v+eF3SH+GWcFKxduUhpfv8gGuKBzZJl2qouBHFKTKTytbcpdzEDIgpeW2/tyig+kAZ0
         Vd3H+T87YzRMW5TIpzKsNw/DjOp8DR9m4ocjadzorNsxug0xab8pZxf6P5VkpLsPkEHE
         5DAQ77gfuJYrulAPsaKr7vtjcpFwPm3nX4Lux8epULUdMT8rV5tg/hf3BPD2hCMKlUTp
         ufjg==
X-Forwarded-Encrypted: i=1; AL+hErHbAgnM0XZGcKYk2P+EOxV/QgrOL2X+w13oR+AdruU33PlBHle4l2kaJr5DIScEXySnBGzbLg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/0Gp6p9c6+G0Br6GJOqxP0sy4joY5eC6kmnG0gd7JNlJ9u5tOb
	2TXdM7miXndKprFCO8JaEeYkJTMBf47Zcj4VrxpW7Zslge+eb+7+AYxyvsLBTBDPKMMyI+wTcSB
	rSkUVcJbOnyH/UM52MQ==
X-Received: from edl8-n1.prod.google.com ([2002:a05:6402:4248:10b0:6b1:a845:1d31])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:d896:0:b0:6b7:2969:a2b4 with SMTP id 4fb4d7f45d1cf-6b756aeeca3mr787329a12.39.1794286940631;
 Mon, 09 Nov 2026 21:02:20 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:57 +0000
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-15-tarunsahu@google.com>
Subject: [PATCH v4 14/19] liveupdate: Add feature header to struct luo_flb_ser
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

Precede each serialized File-Lifecycle-Bound (FLB) entry in the preserved
FLB array with struct kho_ser_hdr via DECLARE_KHO_SER so future FLB
metadata features can append fields to struct luo_flb_ser without breaking
compatibility between adjacent kernels.

Compute LUO_FLB_MAX and outgoing entry offsets using
kho_ser_size(luo_flb_ser), and initialize each entry feature header in
luo_flb_serialize(). On the incoming path in luo_flb_retrieve_one(),
validate each entry feature header with kho_ser_validate() and advance
between entries using fhdr->size so entries written with a different
feature layout are traversed accurately.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/luo.h |  6 ++----
 kernel/liveupdate/luo_flb.c | 39 +++++++++++++++++++++++++------------
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 4913707ba0d3..1b660d41bb90 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -181,7 +181,7 @@ DECLARE_KHO_SER(luo_flb_header_ser, 16, 0, 0);
  * passed to the new kernel. Each entry allows the LUO core to restore one
  * global, shared object.
  *
- * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
+ * Preceded by &struct kho_ser_hdr.
  */
 struct luo_flb_ser {
 	char name[LIVEUPDATE_FLB_COMPAT_LENGTH];
@@ -189,9 +189,7 @@ struct luo_flb_ser {
 	u64 count;
 };
 
-static_assert(sizeof(struct luo_flb_ser) == 64);
-static_assert(!IS_ENABLED(CONFIG_64BIT) ||
-	      __alignof__(struct luo_flb_ser) == 8);
+DECLARE_KHO_SER(luo_flb_ser, 64, 0, 0);
 
 /* Kernel Live Update Test ABI */
 #ifdef CONFIG_LIVEUPDATE_TEST
diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
index a8dcdb8456fd..d38c223741ff 100644
--- a/kernel/liveupdate/luo_flb.c
+++ b/kernel/liveupdate/luo_flb.c
@@ -53,11 +53,11 @@
 
 #define LUO_FLB_PGCNT		1ul
 #define LUO_FLB_MAX		(((LUO_FLB_PGCNT << PAGE_SHIFT) -	\
-		kho_ser_size(luo_flb_header_ser)) / sizeof(struct luo_flb_ser))
+		kho_ser_size(luo_flb_header_ser)) / kho_ser_size(luo_flb_ser))
 
 struct luo_flb_header {
 	struct luo_flb_header_ser *header_ser;
-	struct luo_flb_ser *ser;
+	DECLARE_KHO_SER_HDR(luo_flb_ser, *fhdr);
 	bool active;
 };
 
@@ -159,6 +159,7 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 {
 	struct luo_flb_private *private = luo_flb_get_private(flb);
 	struct luo_flb_header *fh = &luo_flb_global.incoming;
+	DECLARE_KHO_SER_HDR(luo_flb_ser, *fhdr) = fh->fhdr;
 	struct liveupdate_flb_op_args args = {0};
 	bool found = false;
 	int err;
@@ -177,10 +178,18 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 	if (!fh->active)
 		return -ENODATA;
 
-	for (int i = 0; i < fh->header_ser->count; i++) {
-		if (!strcmp(fh->ser[i].name, flb->compatible)) {
-			private->incoming.data = fh->ser[i].data;
-			refcount_set(&private->incoming.count, fh->ser[i].count);
+	for (u64 i = 0; i < fh->header_ser->count;
+	     i++, fhdr = (void *)fhdr + fhdr->size) {
+		struct luo_flb_ser *ser;
+
+		err = kho_ser_validate(fhdr, luo_flb_ser);
+		if (err)
+			return err;
+
+		ser = kho_ser_payload(fhdr, luo_flb_ser);
+		if (!strcmp(ser->name, flb->compatible)) {
+			private->incoming.data = ser->data;
+			refcount_set(&private->incoming.count, ser->count);
 			found = true;
 			break;
 		}
@@ -573,7 +582,7 @@ int __init luo_flb_setup_outgoing(u64 *flbs_pa)
 
 	header_ser->pgcnt = LUO_FLB_PGCNT;
 	luo_flb_global.outgoing.header_ser = header_ser;
-	luo_flb_global.outgoing.ser = (void *)fhdr + kho_ser_size(luo_flb_header_ser);
+	luo_flb_global.outgoing.fhdr = (void *)fhdr + kho_ser_size(luo_flb_header_ser);
 	luo_flb_global.outgoing.active = true;
 
 	return 0;
@@ -594,7 +603,7 @@ int __init luo_flb_setup_incoming(u64 flbs_pa)
 
 	luo_flb_global.incoming.header_ser =
 		kho_ser_payload(fhdr, luo_flb_header_ser);
-	luo_flb_global.incoming.ser = (void *)fhdr + fhdr->size;
+	luo_flb_global.incoming.fhdr = (void *)fhdr + fhdr->size;
 	luo_flb_global.incoming.active = true;
 
 	return 0;
@@ -626,10 +635,16 @@ void luo_flb_serialize(void)
 		long count = refcount_read(&private->outgoing.count);
 
 		if (count > 0) {
-			strscpy(fh->ser[i].name, gflb->compatible,
-				sizeof(fh->ser[i].name));
-			fh->ser[i].data = private->outgoing.data;
-			fh->ser[i].count = count;
+			DECLARE_KHO_SER_HDR(luo_flb_ser, *fhdr) =
+				(void *)fh->fhdr + i * kho_ser_size(luo_flb_ser);
+			struct luo_flb_ser *ser;
+
+			kho_ser_init(fhdr, luo_flb_ser);
+			ser = kho_ser_payload(fhdr, luo_flb_ser);
+			strscpy(ser->name, gflb->compatible,
+				sizeof(ser->name));
+			ser->data = private->outgoing.data;
+			ser->count = count;
 			i++;
 		}
 	}
-- 
2.56.0.506.g506a7eabc5-goog

