Return-Path: <SRS0=bP0W=WC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74412C31E40
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 23:16:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4896D20C01
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 23:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LfRTCxlq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4896D20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 016D0E2E;
	Tue,  6 Aug 2019 23:16:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 43905CC6
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 23:16:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
	[209.85.160.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BC97789D
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 23:16:18 +0000 (UTC)
Received: by mail-qt1-f195.google.com with SMTP id h18so86464077qtm.9
	for <iommu@lists.linux-foundation.org>;
	Tue, 06 Aug 2019 16:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=6NUFqlMBKMBn5vDhbmYDSPrCJfAHH+vuZmJm73vmPZ4=;
	b=LfRTCxlqNIR4uH7LAgvFKd3/HUW6EIX8oEHk8vRJZDXfu+MODxUjSc0mwQLjdlj1r5
	TdBQZiQ/h32bzsTmZvXIlzRhFHn0mmy0idj25YbeDts1A24fsEifBIe3NP5hqVvkvhrR
	nWWVKtWYfgjQk2Um2/MKR8gMUgvqui+DvGzyTcwS1oxYmThfLcGfOjUwJchzx5IQFtkm
	39y5spX//3k4QzhKIKnxJHNlnrtBxmpACeuwQvwhJuooM9+kRZCHN9wt4AYFAx6mZGXI
	dWzRId28bdIuuoDxYm8FkG1fzostiVkDLyxOWPmcJ25bAgDrnqB6r/Lbc3/r/c8WbtlX
	CAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=6NUFqlMBKMBn5vDhbmYDSPrCJfAHH+vuZmJm73vmPZ4=;
	b=JTwr9jSF8adkvf69qTgDDONLm6a4v/GBF5NdKpguMIVmECmWwwBNd0eRf5y3QVQ6Ox
	A1FV+gATihN7BLn4UOEhT6BUDEP2CXTPP8C/l7iEEbchkVlluGGjVE7keES5z0wekhHE
	Why64JA/68Qv8xRpmwjguYq48t/JsJudJTua+YJV+KuOuVc5Sl1to5zzT4cdSmaysbDI
	bh6xja4ESEpwWUHqSDVtNTDHqVWp3c7m/XBGoHUXitY5rk7YPwGREaJyEfLhMiqOQD1q
	XM3UrTQjLdlQ/RpTN8H43JozrhJPB56cYm7sEKMeOX8zDoaZvMNw4BG2q6+QcVZ1eVRu
	lgTA==
X-Gm-Message-State: APjAAAVM/pY3YQ8vJJrJUmb/R3kW/wsvkHvVpTA6XS2T4GPUZx9zFW/y
	+zjzc05wGQsCG/nTUflo3CPm7g==
X-Google-Smtp-Source: APXvYqzyRI5TBbiUa5tyo3mkBzAmzYq9JR3/ocS4Z9Tm5ZTYPwm7qYeGZqLl/Ddc4+CKmoOUg5XVtQ==
X-Received: by 2002:ac8:270e:: with SMTP id g14mr5557862qtg.65.1565133377937; 
	Tue, 06 Aug 2019 16:16:17 -0700 (PDT)
Received: from ziepe.ca
	(hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net.
	[156.34.55.100]) by smtp.gmail.com with ESMTPSA id
	y9sm37771754qki.116.2019.08.06.16.16.14
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 06 Aug 2019 16:16:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
	(envelope-from <jgg@ziepe.ca>)
	id 1hv8gg-0006fA-Hu; Tue, 06 Aug 2019 20:16:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org
Subject: [PATCH v3 hmm 10/11] drm/amdkfd: use mmu_notifier_put
Date: Tue,  6 Aug 2019 20:15:47 -0300
Message-Id: <20190806231548.25242-11-jgg@ziepe.ca>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190806231548.25242-1-jgg@ziepe.ca>
References: <20190806231548.25242-1-jgg@ziepe.ca>
MIME-Version: 1.0
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	"David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
	Ralph Campbell <rcampbell@nvidia.com>, Dimitri Sivanich <sivanich@sgi.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Andrea Righi <andrea@betterlinux.com>,
	linux-rdma@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	iommu@lists.linux-foundation.org, amd-gfx@lists.freedesktop.org,
	Jason Gunthorpe <jgg@mellanox.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	intel-gfx@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Jason Gunthorpe <jgg@mellanox.com>

The sequence of mmu_notifier_unregister_no_release(),
mmu_notifier_call_srcu() is identical to mmu_notifier_put() with the
free_notifier callback.

As this is the last user of those APIs, converting it means we can drop
them.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 ---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 10 ++++------
 2 files changed, 4 insertions(+), 9 deletions(-)

I'm really not sure what this is doing, but it is very strange to have a
release with no other callback. It would be good if this would change to use
get as well.

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 3933fb6a371efb..9450e20d17093b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -686,9 +686,6 @@ struct kfd_process {
 	/* We want to receive a notification when the mm_struct is destroyed */
 	struct mmu_notifier mmu_notifier;
 
-	/* Use for delayed freeing of kfd_process structure */
-	struct rcu_head	rcu;
-
 	unsigned int pasid;
 	unsigned int doorbell_index;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index c06e6190f21ffa..e5e326f2f2675e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -486,11 +486,9 @@ static void kfd_process_ref_release(struct kref *ref)
 	queue_work(kfd_process_wq, &p->release_work);
 }
 
-static void kfd_process_destroy_delayed(struct rcu_head *rcu)
+static void kfd_process_free_notifier(struct mmu_notifier *mn)
 {
-	struct kfd_process *p = container_of(rcu, struct kfd_process, rcu);
-
-	kfd_unref_process(p);
+	kfd_unref_process(container_of(mn, struct kfd_process, mmu_notifier));
 }
 
 static void kfd_process_notifier_release(struct mmu_notifier *mn,
@@ -542,12 +540,12 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
 
 	mutex_unlock(&p->mutex);
 
-	mmu_notifier_unregister_no_release(&p->mmu_notifier, mm);
-	mmu_notifier_call_srcu(&p->rcu, &kfd_process_destroy_delayed);
+	mmu_notifier_put(&p->mmu_notifier);
 }
 
 static const struct mmu_notifier_ops kfd_process_mmu_notifier_ops = {
 	.release = kfd_process_notifier_release,
+	.free_notifier = kfd_process_free_notifier,
 };
 
 static int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep)
-- 
2.22.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
