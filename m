Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794880485;
	b=D2doz3rirzpuxveF7Er1L9EH/iuCBzvnHH4hreMAFh07gpvm7lpFVxX+zazNK2vTSpQ1
	 tyCO6Pl4BE5iN3XNF1q4fW3skzs/ZfmziN6tsXtz+5no+YRZY3WqggmHf5xphMgEEJMwe
	 wkqWOGjsMl70ZUWHZOQD+RX1QxO8lbxTvCk3vhxeFfMG9/y7Gw087P8o6XL7OHQ11C+Sy
	 Kmou7BYQHuvLlBoUv0274bLIwZ1lQisXZTZrqx81ZiP2Mw1avzF7kV/JLk/BqrdUeaHiR
	 ayimVshG87kZaf0MfqwEIQFyVwG9ALhhfIG7XNqyfAsTKctzwIBPTD0eaZNV6B4Dc3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794880485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=elkgCBj7aFay/OU9BHM3KC6ZUvNspwV9FYqesvpWo0I=;
	b=T188OQdZC7M9H82GYZcpWPkyRstzSHFRWIm9Ci7hVj9kt8bJka569CUrer/YE7pRpCsP
	 UvU1mlfa+Tb4on156fkWwk1HkD6UlPPr0V9/RLLRPoF5fVA7CTlPlaVvBJzqQxRItcyoF
	 gwOruo1FwTtX+1iflo3SQ9EMMuUUcHuEubI69NG1sXwqIQIUKLG4ioDV1iiwkZQPF+SRy
	 6WsP5RnySUNp+uUe8qFk0jh/nUmMXSyG+F+Aj9KAYXgeebcmpr7Y/NwAnJHKhn1/5TBOE
	 oEsi8EhIyBmmfsqhRxi8hM/sBUXET9rFOqVJqu0thtUwdM4aykm4AnlJVcz7avhat1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H13vkSqc;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA143606A32A
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 01:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA143606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H13vkSqc
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36e90071735so629121eec.0
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 17:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794880484; x=1795485284; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=elkgCBj7aFay/OU9BHM3KC6ZUvNspwV9FYqesvpWo0I=;
        b=H13vkSqcdHsP/+pmTrdc0gKh2CNPbm7L82U1WLTq91esK2JOW7AZis5V5BZ8YpDPBq
         MhmKbgp95jLeGOfrp5/Q0KYoRFrLNKNCmdpMLFPv7OYHCfMUZ0j0fXCalC3niiQZgR+c
         CONUzDfxWhcUlkXiLrmOxfcp7rafoMLjLZiANn2TlpfMdfUOAS6V2rUOvzrXBsnc3QUm
         mpV7uTaxpUVUvT08KJMdD45QRjCcsARXf6n3f+q4ZULxRgwb89BTKrSzp7FEHE8L4z6j
         hjF5oMkxXIxcVZf6rb9V6z0wnxU4BrGA5YoQEb+M5P/xzjEt/e2ETjnvaNyNJ++vJqLC
         6xRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794880484; x=1795485284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=elkgCBj7aFay/OU9BHM3KC6ZUvNspwV9FYqesvpWo0I=;
        b=BGvGinXzQFHaMj9sx3gfsbhZS2zZYz39T7KHksoszGI7U67u+TIcr6aN+tf3nGAfXn
         HRSqQdFDSZtOrp9dYfr1jC3O5jOkD2eUEu4qwYNGQEpNEo7zR3Uk7t1D4UZTVpjX7oFj
         PRK0fp4qWVjwhbDvOJqVA9N00AxQPrI/pVQCE7jvvxAB4k+z/G3a8dLykXG4tHFxI9NY
         XSGeDIpTUn0lBUQYh8bUD6HWJ8i3lUGcatCv7lZuxB6wXT7XE0QHss1MrhslSsL4eLoq
         h+1aOzjKTv3pkuwEJ6b/wtbS/B0VRA/dCq8OYdmZzEfUvf1QkerYmtV2inYt6iHfv3Eg
         f/1A==
X-Forwarded-Encrypted: i=1; AL+hErHqYJ8n8ZUl1Vl6sDWJ2L2p2j/+7mGhlX6P4QbE+VqDg0xdILaqTho+Y5PpTmTUUcpbit8g7Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z9tLeYqru7eHOZo51QrwnJ88XGMQJjJvEta2jEULqonHHLSxM7w
	amXZKDmqV/Yswtl8o7qoy3TMuCz5rHvVv7xQiaWq1KrT5XMpX89TYCru
X-Gm-Gg: AZFdTZc71gfNFVZY7q9XqeRUizfJyhtI1Vh1Q7nQ+2lSLc2ksTEJHaMs6Expn5Q/5NM
	17bt/u8/MRu+86/jETm0bIrEWym1f3Fr1+F5usLBf5dnfP9ROE5uR8vjaIHwvnvBGVBZABY2QH+
	uoUdUoCUaA+YryGT5zlRZun5q92xUjEufA3LN2mHxRKy33NMHl2WbdyHXlm9CtALyLPa8mB6b9i
	LYh8hyzNC8lCBDAVl+zy7Igle8cnkkEWmJYe6MBEUzYRJnPsdQMTVDTjGUZYW1J2Ask44UGcpFf
	CVUX2RQBqqsEVSsmBvjmbfcrocH5wEPhLMYI87h4J/MIY7h5zwYioOMIew+0cCECmnZf5rKGbHB
	TaLQ6hCS97v7SAVrliQ2uNBlXFwOH67WoUXxMaBYxbKMl45t0HjaYeetHadmy/F4Ilq1qrSZUij
	gJOSDZFtQeEEKhUecFwC9hcABLLznIZlMNeyKn2pTgAuljraVtm3vr1GEjwVtLyMK2kYR9tVpim
	NbJB0d0ukw8qWjVZl5Wgsw2bydU6ak3MFFJuOss8t/AORu9t0dkLLhQq9YFOLPqjsJhnwgVsvka
	Ue3ngavyTofBWwFUlGKA7u9IrlRj4uFoMjQ4tM1XOAgVYPNjDyWeZ/gjP+yoAdCPoTUv8ZGH0uV
	3PDxN6myr5tSVsHFbcTM=
X-Received: by 2002:a05:7300:c00e:20b0:35e:d21c:f33e with SMTP id 5a478bee46e88-379651ecb3emr20450412eec.1.1794880483783;
        Mon, 16 Nov 2026 17:54:43 -0800 (PST)
Received: from localhost.localdomain ([188.253.120.78])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332a77sm34139971eec.4.2026.11.16.17.54.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 17:54:43 -0800 (PST)
From: Qihang <q.h.hack.winter@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Qihang <q.h.hack.winter@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] iommu/io-pgfault: reject partial faults after the device is removed
Date: Tue, 17 Nov 2026 09:54:09 +0800
Message-ID: <20261117015409.25492-3-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261117015409.25492-1-q.h.hack.winter@gmail.com>
References: <20261117015409.25492-1-q.h.hack.winter@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A report that already holds a reference to the fault_param can still
reach report_partial_fault() after iopf_queue_remove_device() drained
the partial list.  The node it queues there leaks: the parameter is no
longer on queue->devices and its final put does not free partial
faults.

Reject late partial insertions under fault_param->lock: add
fault_param->removing, set it in iopf_queue_remove_device() before
the drain, and test it in report_partial_fault() under the same lock
that the insertion takes, so "check" and "link" cannot be separated.  A
partial is then either drained or rejected and freed by
report_partial_fault() itself, which returns -ENODEV; as for any
non-last request, no response is sent.  removing is never cleared,
since IOPF re-enable allocates a new fault_param.

This only protects partial-list admission; callers must still quiesce
reports for the remaining lifetimes.  It is not a general teardown
fix; the cover letter lists the paths it does not cover.

Fixes: a74c077b9021 ("iommu: Use refcount for fault data access")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
This applies on top of "iommu/io-pgfault: unlink partial faults before
freeing them".

 drivers/iommu/io-pgfault.c | 12 ++++++++++--
 include/linux/iommu.h      |  3 +++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 55a3c29..51d0d1a 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -64,6 +64,7 @@ static int report_partial_fault(struct iommu_fault_param *fault_param,
 				struct iommu_fault *fault)
 {
 	struct iopf_fault *iopf;
+	int ret = 0;
 
 	iopf = kzalloc_obj(*iopf);
 	if (!iopf)
@@ -72,10 +73,16 @@ static int report_partial_fault(struct iommu_fault_param *fault_param,
 	iopf->fault = *fault;
 
 	mutex_lock(&fault_param->lock);
-	list_add(&iopf->list, &fault_param->partial);
+	if (fault_param->removing)
+		ret = -ENODEV;
+	else
+		list_add(&iopf->list, &fault_param->partial);
 	mutex_unlock(&fault_param->lock);
 
-	return 0;
+	if (ret)
+		kfree(iopf);
+
+	return ret;
 }
 
 static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
@@ -479,6 +486,7 @@ void iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
 		goto unlock;
 
 	mutex_lock(&fault_param->lock);
+	fault_param->removing = true;
 	list_for_each_entry_safe(partial_iopf, next, &fault_param->partial, list) {
 		list_del(&partial_iopf->list);
 		kfree(partial_iopf);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ef50437..5d56e66 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -846,6 +846,8 @@ struct iommu_device {
  * @partial: faults that are part of a Page Request Group for which the last
  *           request hasn't been submitted yet.
  * @faults: holds the pending faults which need response
+ * @removing: the device is being removed from the queue, no new partial
+ *            faults may be queued
  */
 struct iommu_fault_param {
 	struct mutex lock;
@@ -858,6 +860,7 @@ struct iommu_fault_param {
 
 	struct list_head partial;
 	struct list_head faults;
+	bool removing;
 };
 
 /**
