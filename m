Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E80253B58;
	Tue, 18 Aug 2026 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069499; cv=none; b=qIyLehGfgrRvR5Q+I9bTDKQI9gyH315pPbM4ZFxEzbGrXJnH6o/OlthbXxxCmSuFiu/g9l+ETlRNgkgKMdK4uxnbP8yXjyD0JkS58O91DJpteRXyvSN8hC6/2lsgW0wIRWs5kQ/9t4ee6HujbMYL2hGHVhnOHfP66bhaSBmVLvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069499; c=relaxed/simple;
	bh=FaQBrjficfnhbo6d1Zc9WarY6xZ+J/pjNJYHyN+f9Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=laH7bzckq2zUcxpI+1UkmPLlEdlkhx3fTzN8Ad0VC34ezyfsx8O0KgxuD+mdjydiSQskqTYKfqPXDHiLKlpzTuxGmbcpiF4EYya/0NU3kaYqo9nv0ug6wO8v+WX6cfl7T+82kjgrJ+cHO18Xdma7/7/85K7In7a6xQ6QgqwLIp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=Tno4qEeI; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="Tno4qEeI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=k+mutLmqF7YJwLjxm7xAk2zMZy0GTxUSjKC7fhTsZno=; b=Tn
	o4qEeIyGCiG8GbVFuHBCi1HvWtK7Yn3exE8EPsf5erax69jW/kpgAEJnqs9yTGggH1qGWwUJnwNeD
	Z5GEEa9LKQCjvcxx/lq3upG/oEiDWSfRTHlL1sE4vZeUDa8/V2K5pDtEhROW+hsz1RXXqO3g98lZ+
	Jfzup81+zgSiBleUDPqSZf+56zyolO+dp+Pnj+NFVL7H6sM3+l6i5x3gELn/1hysFiXaoUI2GTNbz
	9pbijUbMxmtdSV+Sg6faQ9np+VA5JJKz7LKNINXEnyHbaeYFvvYE1Dhi3xLFf02F2MLpYzBaXWlbm
	CJuh2KIJTR0NT5MUYAsxYK5of/wFfYjw==;
Received: from [2601:18c:8100:a0e0:5a47:caff:fe78:8708] (helo=fangorn.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <riel@surriel.com>)
	id 1wwLga-00000001TR7-1K5P;
	Tue, 18 Aug 2026 15:25:08 +0000
From: Rik van Riel <riel@surriel.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	liam@infradead.org,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	ashok.raj@oss.qualcomm.com,
	jgg@ziepe.ca,
	kyle@mcmartin.ca
Subject: [PATCH v5 0/3] iommu/iova: convert from rbtree to maple tree
Date: Tue, 18 Aug 2026 11:25:00 -0400
Message-ID: <20260818152505.1057922-1-riel@surriel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Occasionally production workloads at Meta run into the linear search in
alloc_iova() in ways that cause real issues. For example, when enough
CPUs at a time fall into the linear search trap, systems have been known
to get stuck for so long that it causes soft lockups.

This series indexes the iova ranges in a maple tree instead. Its gap
search makes alloc_iova() O(log n).

struct iova loses its rb_node and shrinks from 40 to 16 bytes.
The maple tree keeps its nodes outside the entries, so total memory
use ends up about the same as before.

Patch 2 handles the one thing the maple tree does that an rbtree does
not: erasing an entry can result in the need to rebalance a tree, and
allocation of maple tree nodes.

iovas are freed from atomic context, and GFP_ATOMIC allocations mean
the erase can fail. When it does, the entry is marked IOVA_DEFERRED
in place and the struct iova is freed. The marker keeps the range
reserved until iova_drain_deferred() retries the erase.

Ashok Raj asked on v4 whether the marker store can fail in turn, since
the WARN_ON_ONCE there reads like error handling for a case the comment
claims cannot happen.

Code examination shows that, with the current maple tree code, the
IOVA_DEFERRED maple tree store will never result in an allocation,
and cannot fail. This series adds a test case which allows us to verify
that maple tree property continues to be true.

Only a corrupted tree, one no longer holding the iova at its own range,
can reach a store type that allocates. The WARN_ON_ONCE is more of an
assertion than a recovery path.

Liam Howlett's "maple_tree: lock checking and clean ups" series adds a
WARN_ON_ONCE to mas_nomem() for a GFP_ATOMIC store under an external
lock. This series is external-lock and GFP_ATOMIC by construction, so
both stores would splat if that lands as posted.

Liam, is the intent to disallow that combination, or to flag callers that
cannot tolerate a failed store? The iova code handles failure on both
paths.

The code was written with Claude, and nitpicked by myself. Don't be shy
if there are more nitpicks remaining.

Tested with the KUnit suite in a VM, including with PROVE_LOCKING,
DEBUG_MAPLE_TREE and KASAN enabled, and on an AMD Bergamo system with the
IOMMU enabled. I know of no way to reproduce the linear search soft
lockups at will, so that scenario stays unverified in practice.

 drivers/iommu/.kunitconfig |   6 +
 drivers/iommu/Kconfig      |  16 +
 drivers/iommu/Makefile     |   1 +
 drivers/iommu/iova-kunit.c | 544 +++++++++++++++++++++++++++++++++
 drivers/iommu/iova.c       | 561 ++++++++++++++++++++---------------
 include/linux/iova.h       |  21 +-
 6 files changed, 901 insertions(+), 248 deletions(-)

---

v4: https://lore.kernel.org/r/20260624030853.2340880-1-riel@surriel.com

v5:
 - subject prefix iommu/iova:, matching the file's history
 - put_iova_domain() takes iova_lock across the tree walk and
   __mt_destroy(); without it lockdep reports suspicious RCU usage,
   since a MT_FLAGS_LOCK_EXTERN tree checks the external lock
 - explain why the IOVA_DEFERRED store cannot fail, and check it in
   test_marker_store_needs_no_node()
 - deferred erase is now patch 2, the test suite patch 3
 - rebased onto v7.2-rc8
v4:
 - reduce the size of struct iova to 16 bytes
 - simplify the (hopefully rare) remove_iova GFP_ATOMIC failure path
 - test case for the deferred free code
v3:
 - switch to maple tree (suggested by Robin Murphy)
v2:
 - clean up selftests (thanks Jason Gunthorpe)
 - drop the search-with-alignment, since most iova requests should be
   of similar sizes, so the worst case behavior is unlikely to hit
   once ranges are excluded by the augmented rbtree

base-commit: ad8d485e665829ecbf3c97b22ce251f8ff5f8037
