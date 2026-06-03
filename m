Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C76A3F1668;
	Wed,  3 Jun 2026 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780457839; cv=none; b=AbVyrs0N1P0PDu4CmmBrcaCO09Vtp7Ndd9KbDD80Dbie5sOlPTYXyHj4eV3rCN2kttJk53MHZavE7sL7GE9g9qL+TzAKnYzO49Nd7x6ZBk7FBrip+1VGjzP+iMzQNBWR2vaW+EKqJA45eMTHqpdQtZUmc2y/VRyn6dM5gh6klZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780457839; c=relaxed/simple;
	bh=Uml/O6dmPVE5Z+7Xvu0sKKlW3fBXOWUb5CB1ls8UJZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mCj48v8ZptNb7BTqX5WRP4vzUtwUyumCEyxf65tahCAN7rt0OJjzJZL38djgqsl5qIUt/87nxYZMDmP0IpyQh3wOfXat/w866ioRcKLeFpem9pV+Cr5wBl8iGP5BWQvGbm0DOeiludDAbaYkMy4zK/KSoGYexVFVy4JYWi62k90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=UmuAYlXD; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="UmuAYlXD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hp4dPXX/NyOG5NcNqb7qVHvycKwIaCRQLQJnraMCOXc=; b=UmuAYlXDk+VMU3XFIeaP5zfqOa
	5wRYwn09ijDjZzkp3ZkgsR+mGCnbIMyZXlLFLiBPVJgQTQOHJdqFE5OqtpwwE0r6UDQxP2peflBSA
	RjGdf8nm+g9PxNx2oRiY9vxTNKgfuMfRhY5efuuEUmiTelF/mQik0UPaTHKniP5d93oE2L2Rdzfw3
	zrc8f7dzZSGhp/lf1UK5XCtnK2s/79GcFZzU41DZVyRrYforPybEqvwz9uLHw5C4yE8PGrnUo9gws
	V7eUTizkFxfKJsrNPTuVJ5eRlrTdjv4ltFqVenu8juEt2eDhLvn/qYc9BrIDvAwX/YZClNu1+AcU6
	8Zv8OoIQ==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wUcPg-000000002VG-16b0;
	Tue, 02 Jun 2026 23:37:04 -0400
From: Rik van Riel <riel@surriel.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	kyle@mcmartin.ca
Subject: [PATCH v3 0/3] iova: use maple tree for O(log n) allocation
Date: Tue,  2 Jun 2026 23:35:45 -0400
Message-ID: <20260603033653.4144138-1-riel@surriel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Occasionally production workloads at Meta run into the linear search
in alloc_iova() in ways that cause real issues. For example, when
enough CPUs at a time fall into the linear search trap, systems
have been known to get stuck for so long that it causes soft lockups.

With the old code, free_iova, find_iova, reserve_iova, iova_insert_rbtree,
and remove_iova were all O(log n) already. They stay that way with these
patches.

This patch series uses a maple tree to index the iova ranges.
This allows alloc_iova() to have O(log n) complexity, while
memory use stays about the same as before.

It also adds some self tests for the iova code.

The code was written by Claude, and nitpicked by myself.
Don't be shy if there are more nitpicks remaining.

It was tested both in a VM (running the selftests), and on an
AMD Bergamo system with IOMMU enabled.

Unfortunately I do not know of any way to reproduce the linear
search soft lockups at will, so I have not been able to verify
that scenary in practice.

Based on 5d6919055dec Linux 7.1-rc3

v3:
 - switch to maple tree (suggested by Robin Murphy)
v2:
 - clean up selftests (thanks Jason Gunthorpe)
 - address Sashiko concerns
 - drop the search-with-alignment, since most iova requests
   should be of similar sizes, so the worst case behavior
   is unlikely to hit once ranges are excluded by the augmented
   rbtree


