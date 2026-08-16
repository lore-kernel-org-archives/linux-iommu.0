Received: from shrimp.cherry.relay.mailchannels.net (shrimp.cherry.relay.mailchannels.net [23.83.223.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DD8EEA8
	for <iommu@lists.linux.dev>; Sun, 16 Aug 2026 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786905835; cv=none; b=Hg4uvGAbx2HhoOKloyGmeG+ugRYjJCQqElggAzCMfpmHA5opn39k0QUWY7pn87xeO2gAW4z7w1I4OeEAjgD4XD9qqU2PriCLggjRpJ6z8mdj/EXEwm3enw4+3nOEqdJ8qGcdGExj3xG7SPlIzEqBewwhK3EA0hUw/pG7aThsKwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786905835; c=relaxed/simple;
	bh=/5yCpVEIlajHNvqknqHhjtLAFagZxXHdBltcoCEGeGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hEYrq9g/gpVINgnP8o3AW1YpiqtDuft2SeSnFnK9Pkcmmiz8vMUbWTWhx8EWkEI//csmgwDdGi28i2K3zeioa9QirJMZjEUMx0CSjVF/VTCattoZKrC9I3qxC1JXC3p4j2dPwSjfqeq3AZcjTzx3sUSWRl5jSLrawZoF6ihZh58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=XwpfICwH; arc=none smtp.client-ip=23.83.223.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="XwpfICwH"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CA4C23813F2;
	Sun, 16 Aug 2026 18:43:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a243.dreamhost.com (trex-green-6.trex.outbound.svc.cluster.local [100.117.164.83])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6E534381C9D;
	Sun, 16 Aug 2026 18:43:46 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Illustrious-Desert: 1a451da904de3a89_1786905826709_1622132530
X-MC-Loop-Signature: 1786905826709:3721856623
X-MC-Ingress-Time: 1786905826709
Received: from pdx1-sub0-mail-a243.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.164.83 (trex/8.0.2);
	Sun, 16 Aug 2026 18:43:46 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a243.dreamhost.com (Postfix) with ESMTPSA id 4hNPxY6FpGz105D;
	Sun, 16 Aug 2026 11:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1786905826;
	bh=9N1Kee7xXdbVwk21W5EBt00QsMqDcgkTTBoFWW9yguA=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=XwpfICwH4qB62kb2qkg0sVfza2SaWAP7TyQyOOXHhyjdXgqkijpWe7voaLXsKR5RU
	 WNmakgKP3yrD+RC4lAjGJexB/N7ncs1BkfeQQMgRi52xPiwQu/4f8dCiUKFII9c+ir
	 qmeiabtvRzC4nyrMR5vKaC8zGq1rWjRlKSf1/joBVfvl3XnN6oUB6WfvyWLjUtKhqg
	 6GuuSNAqk9EzJWNQ7WI+GoaJ1QMYhwyrQZabNMbvm6gWt2sYGNnkhOC9Qe3Xzb+Qvo
	 AOo30CYhisKnb3k3QR6vykYgCQFlCsrEUfBszt7xguj1WbxFOtRxHAU+lP+9Go4w+W
	 Q9nd2U67HBBKg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org
Cc: mcgrof@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH] iommu/iova: Clear the slab cache pointers when destroying them
Date: Sun, 16 Aug 2026 11:43:39 -0700
Message-Id: <20260816184339.420285-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both iova_cache_get() failure path and iova_cache_put() destroy the two
slab caches without clearing the pointers, leaving them dangling with
iova_cache_users at zero. The next iova_cache_get() then re-enters the
respective block, and if it fails early enough to reach 'out_err' before
re-creating both caches, it calls kmem_cache_destroy() a second time on
whichever cache is still stale:

  BUG: KASAN: slab-use-after-free in iova_cache_get+0x216/0x280
  Read of size 1 at addr ffff888001b9fdc0 by task swapper/0/1
  CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.2.0-rc1 #2
  Call Trace:
   <TASK>
   dump_stack_lvl+0x53/0x70
   print_report+0xce/0x620
   kasan_report+0xce/0x100
   __kasan_check_byte+0x36/0x50
   kmem_cache_destroy+0x1b/0x1c0
   iova_cache_get+0x216/0x280
   ...
  Freed by task 1:
   kasan_save_stack+0x33/0x60
   kasan_save_track+0x14/0x30
   kasan_save_free_info+0x3b/0x60
   __kasan_slab_free+0x43/0x70
   kmem_cache_free+0xbe/0x3c0
   kobject_put+0x14d/0x280
   iova_cache_put+0x8e/0xd0

Clear both pointers after destroying them, in both places.

Fixes: 84e6f56be9c6 ("iommu/iova: use named kmem_cache for iova magazines")
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/iommu/iova.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index b710e5ad37e2..0e8ea04b824f 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -984,6 +984,8 @@ int iova_cache_get(void)
 out_err:
 	kmem_cache_destroy(iova_cache);
 	kmem_cache_destroy(iova_magazine_cache);
+	iova_cache = NULL;
+	iova_magazine_cache = NULL;
 	mutex_unlock(&iova_cache_mutex);
 	return err;
 }
@@ -1001,6 +1003,8 @@ void iova_cache_put(void)
 		cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
 		kmem_cache_destroy(iova_cache);
 		kmem_cache_destroy(iova_magazine_cache);
+		iova_cache = NULL;
+		iova_magazine_cache = NULL;
 	}
 	mutex_unlock(&iova_cache_mutex);
 }
-- 
2.39.5

