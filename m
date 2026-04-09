Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD64A3D9DB2;
	Thu,  9 Apr 2026 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754096; cv=none; b=cICYEKUQxGDNb/QV0RxatcKaAgY1WPczU86aQnCquYeT4UOyDW+GuyT8e4dvhVxZzy2ZEDCZ3WPASyO0IDLWYevYAFs0ZUN3GrYHXKAtVyeWEDOGx6SsT1tcNAa2Fap5UhaEn81mRUjUgThrX3Vr41qAODIFAwnxzZS3SLeZoBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754096; c=relaxed/simple;
	bh=c0iJStf15XP+4JtSRQ7hKXLa0tkvnKxl9g9jdgvro30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hoFdZQME16MLQ+TGKzjO+Sz86dlzEQl5aH58V/ShtSS7tppSDEqx4TQENnHTAkJU+3IJLnEwD0bEJAwe3Jr5rb8VnnOmkdD7oSpKnNScrFC0gB5IggwkxuPu1lvAzjeoUs0ubE5ZkzBuJVT31S4yCDYQNflcGWcCl5pynkOfZdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=lZElwxon; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lZElwxon"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=5Uq+q5uItiSkphde+VWfWRqw47bwG5/KFpd7ZFuRzjs=; b=lZElwxon6Etn
	BEzk2K1zJa49Msu+Y+zNOPH85cIb2t5/9nUJoLi7n4nA9WLKYNb3LXN9PRTwKZIJywPdteDFEmHzS
	v63+BfL5Mn/QykT2j/bMsTl34iY/fW/tWTDvFWcK/4N0PDeLQVHf7HhwvIUiMQTtulourQxg9I5tY
	DLKWAiR6qd/TQmGLZC7ZEw87qscIiWkxW7XphREjjY67xWT+5TWoS5AnO/YpnVi8+cR3SeVXuas0F
	x8eWX9sA+neO0TBsNoSZWvF1pFBYqW3N7ZRoCvumEw4K2k3/foKuuDS3qXsMa7N0N+HpYZuLQ2pvR
	TdPMKkWRnbUoJ5RQ4wW65A==;
Received: from [130.117.225.5] (helo=finist-alma9.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1wAsiS-00CYGt-25;
	Thu, 09 Apr 2026 19:01:15 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Konstantin Khorenko <khorenko@virtuozzo.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Subject: [PATCH v2 0/1] iommu/generic_pt: fix GCOV build failure for amdv1
Date: Thu,  9 Apr 2026 20:01:16 +0300
Message-ID: <20260409170117.2014479-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260402141012.1437095-1-khorenko@virtuozzo.com>
References: <20260402141012.1437095-1-khorenko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a build failure in drivers/iommu/generic_pt/fmt/iommu_amdv1.o
when -fprofile-update=atomic is added to global CFLAGS_GCOV.

v2: Use __always_inline instead of disabling GCOV for the file, as
    suggested by Jason Gunthorpe.  The root cause is that
    amdv1pt_install_leaf_entry() is "static inline" (not __always_inline),
    so GCC may choose not to inline it.  Without inlining, the compiler
    cannot see constant arguments at the call site and fails to eliminate
    the impossible branch in FIELD_PREP().  Forcing inlining via
    __always_inline solves the problem without losing GCOV coverage.

v1: https://lore.kernel.org/lkml/20260401142020.1434243-4-khorenko@virtuozzo.com/

This is part of a larger effort to add -fprofile-update=atomic to
global CFLAGS_GCOV to fix GCOV counter races that cause crashes on SMP
(posted earlier as a combined series):
  https://lore.kernel.org/lkml/20260401142020.1434243-1-khorenko@virtuozzo.com/T/#t

That combined series was split per subsystem as requested by reviewers.
The companion patches are:

- net: fix skb_ext BUILD_BUG_ON failures (sent to netdev) [1]
- gcov: add -fprofile-update=atomic globally (sent to gcov/kbuild
  maintainers, depends on this patch and the net patches) [2]

[1] https://lore.kernel.org/lkml/20260402140558.1437002-1-khorenko@virtuozzo.com/T/#t
[2] https://lore.kernel.org/lkml/20260402141831.1437357-1-khorenko@virtuozzo.com/T/#t

Konstantin Khorenko (1):
  iommu/generic_pt: use __always_inline for amdv1pt_install_leaf_entry()

 drivers/iommu/generic_pt/fmt/amdv1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.5
