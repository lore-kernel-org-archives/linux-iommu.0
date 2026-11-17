Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794880476;
	b=wNlOgvrZ98m4nxZjUV2OEoyQ90mlG4rjjqK+4nL/+NRHVQiDypq16btPiefIKLl4/ujs
	 NRX2J2+NpmIt05wnf8OWW8LjPfODvTT57dH7Sp/nGs1SuRIu6MP7kPFiFT0BS8y5m6jRL
	 m6hWu3PVr7BxWVchQ76rio3eyyGMP88wDj517Xg3bh0QXNWTBcFwcSsrftp6YKqEQ7KPF
	 VgZBdbM3OKOcAHoJ9QVHKE7DKQ8r0LaeK3xBY5VeQO5hfT6AoyjcIitjHwMediM9Mh8Qz
	 tiJdAFHXlQt3nN02c5TQf6c2wAll+NeHVbM2YOflHG9X0lUY0RnXVZ0k1kPKHwMmYGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794880476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FE3DBp52FZtyFrsv/66l4xMtsZMQ5Rhcv6bIeoPewWE=;
	b=M3InWC1lZkxoAoRMB6j1zHvDK7elqHG8D7E9hmOyFBhuTaSJDFCSRsNvRaztFO7IqI7C
	 HlLBY+TGgleM+j16adgVlM6oN8gEoDwCuySDPFbsJXPXKDw/q84em6Iie4Omc6DW5xTMX
	 6k17Z5qoUHTDMUjIwMdb6Keh4bF0RVoJYHcyt54oLwY80O0IBp8/WBPZJ9n2FkIVKFZEP
	 Tmix/CiFvvLn9X7aErFs5nPW+681h6BOlHUj7zmYg4j35N/1pqRnX5cvKw9UrdpA2wdOX
	 czkZHKrDbgRNd1kjmVxQnGkof0oiHCFywquiFSGglk1rDMiTH/KzWBrx4svEZqvN1AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XKwFMrGA;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164E0606A329
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 01:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 164E0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XKwFMrGA
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33bb5afa736so406527eec.1
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 17:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794880475; x=1795485275; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FE3DBp52FZtyFrsv/66l4xMtsZMQ5Rhcv6bIeoPewWE=;
        b=XKwFMrGA1vKvBr4+tLclsRBdjo0yAWa94Z/HiVmBo6X7y0YuAbdR4IY17sPVV5ny+0
         MoQJMJmU+oDkvS1tA8X5psBqNquJDDXpLMVswuHEfCqwiv7bOBFFsfSmVG76CmMhNN73
         w8Zum7ueILic7PtwoUGrbtE3tYottGyRpNeXdX4VfykYBB0njiTjbOP5kmvaH5b3s9l0
         hFK3u8pRB5d+aze4VGTdfA1HUShx1y6Dk8uSaxvCLmecGonD2YTH5hP4itZ1KgQgcFk4
         OByIzaIjX/6uyVUi2o0brYS1B1rRy4knoE+lmKvemWJ5uuXzSR9hhjUU4ZcP+xhjYyA0
         W2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794880475; x=1795485275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FE3DBp52FZtyFrsv/66l4xMtsZMQ5Rhcv6bIeoPewWE=;
        b=XZIwe9gtlPTX1F1C+zzQOLgoyPmzzwlQus1fs7Cwh0CICHEpuFNux43WBWAV2S56im
         GHpra50NdvRSdz7rOvTkgFbNmWD/otT3+uGF28bDiDjo1EIHvhmz0fp985zt99kLZHMx
         BVT8zOdLsIuaGiT57fTV77AJv++DctaWOSigEh8zmWT2QlIcvvYAD7jMfxyDHJgPOlS3
         GXcYhueaySgPf4g4lmYWkni3iqTFxo9PMS4cYDc/MCE3XNe2Wbwooq5+201kP+100vP4
         zQWwv/+2/xEQEtxeCvUMJ+iqxRvhyD3qj0LffDkQGvIElpg5h9hsq0LsU961YnqAX7dC
         Ga6w==
X-Forwarded-Encrypted: i=1; AL+hErHLbDJUI18tO1gW9hbOkYaDiueCKnsxYASemXSEiJsti/j9ySj9YY/E5+wKSyQgeXrK/zvrcg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Mjq/As4xaTPEdO+TJNKG8RT40Qdc2nyCO6IAo9hPCisbmGF8K
	FSVt2KYSiMq+RUdm9a9Jwj3OOYUAEmWlmUD7BkrMziJ+QqzN+1UhB5DL4ug02cmF
X-Gm-Gg: AZFdTZfis0Yjxge69Mct+ZEMJ5AnvygVMIaK2SqtLXWq7StiizwM8GzGUOqI08tb3mL
	DOue1RBv/HSmVecch1Y2fnbfzQ0K4aI5V2lyX7zilufrM1KSz0A/2bxsHEBWjW12qlSSWaxCYrY
	ftk2s4BmLcEr8rSNWh53e6mvInpUlMP1Vb72vG3BAW3Z46zxT0fM3Ic+WGnc49MbnUvQSzQBoib
	0ySB47CiH4qTyAdP+NzccdYh9n1uChmL82L6MB5+S1+L0DMHayxt730Bz0qh+D/MTXUqrO4jkLC
	3PNzuAyukdKE+8iZYBk1Ny8dtUK2gsnrvrMZR8vnGk3y3UL4iKpN4LgWltU0VaZNOC9Usz85+zH
	gEMakoUulzQ5zJqRePxrTOneOjD5VY1ATpdko2qga3Zx24DcxT3nwg9+tvRAtKzY2f7uL7U5KU+
	OI4wNTAPx0oN1ITdCdoGlRqPLOzQxKJ8NUWy0ThPuV32UOoQXcEEjapcSUliUPaohpT+7B0YG0G
	TzdKPfAdC7aLAVBjoNa5VPiN90tkjrVGLUzOr4EHAOR5RftEqeRrKGLGId/dnZ4cmqWB6/UpwaV
	DJhyzSifWo+CG2ovmPWaAhCPxO9Ndl5iyrTWSwE6YDeizL7oQHIRMap7O14X+SmJFjmWLELuEM+
	paQL1Qxs/KGVEnm8iQuc=
X-Received: by 2002:a05:693c:881a:20b0:36e:66d8:1424 with SMTP id 5a478bee46e88-3796047ff23mr17786935eec.0.1794880474975;
        Mon, 16 Nov 2026 17:54:34 -0800 (PST)
Received: from localhost.localdomain ([188.253.120.78])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332a77sm34139971eec.4.2026.11.16.17.54.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 17:54:34 -0800 (PST)
From: Qihang <q.h.hack.winter@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Qihang <q.h.hack.winter@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] iommu/io-pgfault: unlink partial faults before freeing them
Date: Tue, 17 Nov 2026 09:54:08 +0800
Message-ID: <20261117015409.25492-2-q.h.hack.winter@gmail.com>
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

iopf_queue_remove_device() frees the pending partial faults without
unlinking them, so fault_param->partial keeps pointing into freed
memory.  A report that is still in flight can then list_add() through
those dangling pointers.  The unlink has been missing since
iopf_queue_remove_device() was first added, but the race only became
reachable with a74c077b9021, which made the fault parameter
refcounted and able to outlive the removal.

Unlink each entry before freeing it, matching
iopf_queue_discard_partial().

This fixes the dangling-list access only: a partial that arrives after
the drain now leaks, because the parameter is no longer on
queue->devices and its final put does not free partial faults.  The
next patch gives such a partial a defined fate.

Fixes: a74c077b9021 ("iommu: Use refcount for fault data access")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
iopf_queue_discard_partial() cannot be called directly from here: it
takes queue->lock, which iopf_queue_remove_device() already holds.

 drivers/iommu/io-pgfault.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index c16ff1f..55a3c29 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -479,8 +479,10 @@ void iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
 		goto unlock;
 
 	mutex_lock(&fault_param->lock);
-	list_for_each_entry_safe(partial_iopf, next, &fault_param->partial, list)
+	list_for_each_entry_safe(partial_iopf, next, &fault_param->partial, list) {
+		list_del(&partial_iopf->list);
 		kfree(partial_iopf);
+	}
 
 	list_for_each_entry_safe(group, temp, &fault_param->faults, pending_node) {
 		struct iopf_fault *iopf = &group->last_fault;
