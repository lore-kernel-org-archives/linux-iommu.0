Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593123;
	b=vgaFze3QytQVfCAbstJocKvJbmH6o+IkqPdDHUCwPV/VGn4saCQWoCUR/dvHqH6YIdBZ
	 pn4YpClgfDTGixMqP2xs06s9P/PfrUJpbOOjFHbaTjC3opsN8fwPLircAfAiAeXtWIZag
	 7/hm+wNWZkQqE1tAc5GGDtc4Dr6YUP9YLBb3KZ+pNrnDlIm9d7wZ5OXukpXsJWVPVC7Ea
	 Cw6grCSDkj5dBS9litA1rLzMlZ9Gf38WeCxPeh0JLNrKQxZJWNPKBfn7dBNo1QDrrqR2M
	 acEIjKHw12AguKaROQxt7e5MfCtIpBGVNUV7Ya5kWNMPtufihrZnYs+Ka9nVWAcxfLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=QazYBGvrND8GI8lJcSkyL4fj9MMsXahwbNAM7/zrdo0=;
	b=qGyr6KhI3aOO+BhqxCfKgFjaBsqlEFmdnTEd4GzHDVXorYwZMdnz+Ncwha0QoMkmGoUk
	 l0V5TH/R1fB5krJ5p4SJOVlgYAx3e/n3VRl/8HPTkJ9HZ7XhMpN3mAyiynLBI3t0deb/S
	 XEoUfhSIzSMppKyyrRoz/dKI9MuvSycWw0kzZ+tyZP1/66m9Bv/IXTqosrFYbRxeuCEah
	 phZaDz8BYUKFUabxpEfvmK2NezjOzKh3Bg4U1H29erbPtE8Ewg7aNzBowx54LL+19mPT8
	 Ct4wVN3uZMdiZntIBca3NUpdD6vKfqMaMj9ljKlvwVEQd1COU+8TKaaetQ0A/MjcDrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="RPlsU+n/";
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A5D606A31E
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 14:32:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49A5D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RPlsU+n/
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a01ba12198so13543205e9.1
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 07:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792593120; x=1793197920; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QazYBGvrND8GI8lJcSkyL4fj9MMsXahwbNAM7/zrdo0=;
        b=RPlsU+n/cejqbAnltVpn2kCvEsdwRQRs4unsNvm59AMN4Ii568b+9010TUyibtMFGS
         xETrsGP/p3nLMIvks+5FHPfR7gBMnMDuQkpNcPEnvOhGnSgl1dT/OLIzEATu3iPIO8wO
         tMhwoN6278rB4azJm1EeXOWziktHur6yirJRpuJc80osdu+2F+4urSFJtUiq1PP6CUS9
         WRVBnG8Zow5i7B1Hp/Tl8Q0tk7t/QcbpP6SBMRe2M3Imr6NJqjBDt7P2Za7ofATalbvI
         gbjD4Dtn0dj9J4+QqTQUKosvIAbCRyl4k+EJyubXcS60FlmnD1pXkJglmbZEHWt6xfni
         GGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792593120; x=1793197920;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QazYBGvrND8GI8lJcSkyL4fj9MMsXahwbNAM7/zrdo0=;
        b=VZEPXLjjEqzpU+Ry6x80/VS/T1FubIDIOlmgZycZEfKrgHXkix7jkcKb8s1krcHRvb
         0JPbPMggp0PCCf7x/5docv6+6vD/75yJ+YYDY9e9zzqtqz3Hyraad6+IqJrPq6Ufj9Ih
         hD5q5QcCfTp09Q0gO0D5iQO5zXywX5mEkmIK+Sk4jjW9XstQC9Nrbiv4ykuSmSYYLGES
         wY9jWOP/50YFd/rzDLOSOj0g2BqxiWzcd6RQ5b6+wBqAff6NL2d9LQehfVifZhFTOSHv
         rZmDtzPgc79y04b5BwxARQxuO9LeAE/2u226QzgkBHAKVlvISxxNQv4yyfaqLC5gYN72
         /BIg==
X-Forwarded-Encrypted: i=1; AKwUvByC+FLRV9pfjEPrgym7dcwnWw/sFIG6wB0e7aochTdAPc0Hc8UY3agWowz3UUGMCJztk59LPg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLzNhLMNkqMQnkbNU24Ldstk9Jyg9sgj4kciQyW7x1eGj68nTdr
	9rt1jr7nVRLJZrdc+hLFDVpcEvivSuSzqVgqSH3AZt6vDLW3xCboIJQ1wLwhjHvFpvDAdjK/dRE
	yyUplAl4xNijbl+W/joMgYQ==
X-Received: from wmdp11.prod.google.com ([2002:a05:600c:5cb:b0:4a1:fe70:d25d])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f91:b0:4a1:a7f8:c124 with SMTP id 5b1f17b1804b1-4a1fdd0c00bmr46588075e9.7.1792593120273;
 Wed, 21 Oct 2026 07:32:00 -0700 (PDT)
Date: Wed, 21 Oct 2026 16:31:54 +0200
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261021143154.2638232-1-mclapinski@google.com>
Subject: [PATCH] iommu/dma: Allocate flush queues on first use
From: Michal Clapinski <mclapinski@google.com>
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: Logan Odell <loganodell@google.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"

iommu_dma_init_domain() allocates the per-CPU flush queue of a DMA-FQ
domain upfront. That is 10KiB per possible CPU, so on a 224-CPU machine
it costs 2.2MiB and ~570us per domain. Since every device gets probed at
boot, large servers pay this for hundreds of domains in pci_iommu_init(),
even though many of them (PCIe ports, CPU uncore devices, ...) will
never do streaming DMA.

dma-iommu already copes with a flush queue appearing on a live domain,
as the sysfs DMA -> DMA-FQ transition does just that. So only allocate
it on the domain's first unmap, from a workqueue since unmaps can happen
in atomic context, and use strict invalidation until it is in place. If
the allocation fails, downgrade the domain to IOMMU_DOMAIN_DMA as before.

On a 224-CPU Sapphire Rapids server with 431 IOMMU groups, this cuts the
time spent in pci_iommu_init() from 330ms to 83ms.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 drivers/iommu/dma-iommu.c | 78 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 1f624f241ac1..e61cd016b424 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -56,6 +56,11 @@ struct iommu_dma_options {
 	unsigned int	fq_timeout;
 };
 
+/* Bits in iommu_dma_cookie::fq_flags */
+enum {
+	IOMMU_DMA_FQ_REQUESTED,		/* fq_work has been queued */
+};
+
 struct iommu_dma_cookie {
 	struct iova_domain iovad;
 	struct list_head msi_page_list;
@@ -74,6 +79,10 @@ struct iommu_dma_cookie {
 	atomic_t fq_timer_on;
 	/* Domain for flush queue callback; NULL if flush queue not in use */
 	struct iommu_domain *fq_domain;
+	/* Domain to allocate a flush queue for on its first unmap, if any */
+	struct iommu_domain *fq_lazy_domain;
+	unsigned long fq_flags;
+	struct work_struct fq_work;
 	/* Options for dma-iommu use */
 	struct iommu_dma_options options;
 };
@@ -330,7 +339,12 @@ static int iommu_dma_init_fq_percpu(struct iommu_dma_cookie *cookie)
 	return 0;
 }
 
-/* sysfs updates are serialised by the mutex of the group owning @domain */
+/*
+ * sysfs updates are serialised by the mutex of the group owning @domain. They
+ * only ever target a domain of type IOMMU_DOMAIN_DMA. iommu_dma_fq_work(), the
+ * only other caller, acts on a domain of type IOMMU_DOMAIN_DMA_FQ and only
+ * changes it to IOMMU_DOMAIN_DMA once it is done, so they can't race.
+ */
 int iommu_dma_init_fq(struct iommu_domain *domain)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -363,6 +377,48 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
 	return 0;
 }
 
+static void iommu_dma_fq_work(struct work_struct *work)
+{
+	struct iommu_dma_cookie *cookie = container_of(work,
+						       struct iommu_dma_cookie,
+						       fq_work);
+	struct iommu_domain *domain = cookie->fq_lazy_domain;
+
+	/*
+	 * On failure, fall back to strict invalidation as iommu_dma_init_domain()
+	 * would, and say so in the domain type, so that it is reported correctly
+	 * and writing DMA-FQ to the group's sysfs type can retry. That only acts
+	 * on IOMMU_DOMAIN_DMA domains, so it can't run concurrently with us.
+	 * Don't take the group mutex here: the group may be waiting for us in
+	 * iommu_put_dma_cookie() with it held.
+	 */
+	if (iommu_dma_init_fq(domain))
+		WRITE_ONCE(domain->type, IOMMU_DOMAIN_DMA);
+}
+
+/*
+ * A flush queue is a sizeable per-CPU allocation, but it is only of any use
+ * once a driver unmaps DMA through the domain. Many domains never get there,
+ * e.g. those of bridges and other devices that are probed by the IOMMU core
+ * but never do DMA, so set the flush queue up on the first unmap rather than
+ * when the domain is initialised. Unmaps keep using strict invalidation until
+ * the flush queue is in place. This may be called from atomic context, so do
+ * the allocation from a workqueue.
+ *
+ * The work is queued at most once per domain. Check the flag before trying to
+ * set it, so that concurrent unmaps don't all have to take its cache line
+ * exclusively until the flush queue is in place.
+ */
+static void iommu_dma_request_fq(struct iommu_dma_cookie *cookie)
+{
+	if (likely(!cookie->fq_lazy_domain) ||
+	    test_bit(IOMMU_DMA_FQ_REQUESTED, &cookie->fq_flags) ||
+	    test_and_set_bit(IOMMU_DMA_FQ_REQUESTED, &cookie->fq_flags))
+		return;
+
+	queue_work(system_dfl_wq, &cookie->fq_work);
+}
+
 /**
  * iommu_get_dma_cookie - Acquire DMA-API resources for a domain
  * @domain: IOMMU domain to prepare for DMA-API usage
@@ -379,6 +435,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&cookie->msi_page_list);
+	INIT_WORK(&cookie->fq_work, iommu_dma_fq_work);
 	domain->cookie_type = IOMMU_COOKIE_DMA_IOVA;
 	domain->iova_cookie = cookie;
 	return 0;
@@ -428,6 +485,7 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	struct iommu_dma_msi_page *msi, *tmp;
 
 	if (cookie->iovad.granule) {
+		cancel_work_sync(&cookie->fq_work);
 		iommu_dma_free_fq(cookie);
 		put_iova_domain(&cookie->iovad);
 	}
@@ -715,11 +773,17 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev
 
 	iommu_dma_init_options(&cookie->options, dev);
 
-	/* If the FQ fails we can simply fall back to strict mode */
-	if (domain->type == IOMMU_DOMAIN_DMA_FQ &&
-	    (!iommu_domain_supports_fq(dev, domain) ||
-	     iommu_dma_init_fq(domain)))
-		domain->type = IOMMU_DOMAIN_DMA;
+	/*
+	 * The flush queue is allocated on first use, see iommu_dma_request_fq().
+	 * If it can't be used, or its allocation fails, we simply stay in
+	 * strict mode.
+	 */
+	if (domain->type == IOMMU_DOMAIN_DMA_FQ) {
+		if (iommu_domain_supports_fq(dev, domain))
+			cookie->fq_lazy_domain = domain;
+		else
+			domain->type = IOMMU_DOMAIN_DMA;
+	}
 
 	return iova_reserve_iommu_regions(dev, domain);
 }
@@ -835,6 +899,8 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 	size = iova_align(iovad, size + iova_off);
 	iommu_iotlb_gather_init(&iotlb_gather);
 	iotlb_gather.queued = READ_ONCE(cookie->fq_domain);
+	if (!iotlb_gather.queued)
+		iommu_dma_request_fq(cookie);
 
 	unmapped = iommu_unmap_fast(domain, dma_addr, size, &iotlb_gather);
 	WARN_ON(unmapped != size);
-- 
2.56.0.212.g129ede20d9-goog

