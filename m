Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7143815F0;
	Mon, 18 May 2026 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127656; cv=none; b=t8gszFDg5b+w7HJg8a6Xibo0vAteyMKwNYlUzi75trPvgIgZsPh944CSZZufX9YUdDZJ6WZUJabHC30pG2rAwh2fCu++dnQ4xlSCqWhLGDE9e76YB9B8gxsw+W6sUYnbh1F0N+S+bLUKIaOFVonFSPn/WtHaRxvtd+HaO8XLwmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127656; c=relaxed/simple;
	bh=/U3NQ3nQXwTjsO3h17JbJ66lxfaWDEmPxwsr1W8uqes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ool8dbbhRTrly47NjYceoV5vZePj5S4zusPnziTsiimqyUtnyQLjo4DfwKfXReyR+oe3/wX309FI04XjWm/BDVfytJXmxbvFs1rDzfPPJUR1UmUmnoewUtj6hVFZzrp9dfqCk/bEsFtzJOFVHankBR2wqBxYv+EImYZX3Dby70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=WIvR5Qhe; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="WIvR5Qhe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9COQVoW5LacuWONgKgu13n+ganwj5CzyuByJSrhngsI=; b=WIvR5QheIE9xmec0XbWcC89JU7
	WFt7S6BpoEihpUzC9pNow/zvekQRO/i5UJsoS72aexbveqCgWLLYkFtkXX6OO2CwCY7o4qQqmvwyx
	ZF1JsqFdpmKh5mOowQVa7k3agjKKkh4bFL3Zu9xvlZbUQpwfcRb2yRJz7v7Om19Eur9NACsgL2lV8
	eu/VwXr0YMEdTYOp7L4qfy3ayfN2IRU2QDfp2EFFC2GsWVJqFzti1JlZxDnGSCUocf1x6/2dPPMJ1
	NiI1UKkY8yfAiQRLn21pO+arwA5lX96gnoW+5IVbGAAmCxHIYgD945Y8lX1q9IKXr+Cog1DLbzrNs
	NJeJaGTQ==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wP2Lb-0000000006g-3AiF;
	Mon, 18 May 2026 14:05:47 -0400
From: Rik van Riel <riel@surriel.com>
To: linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	kyle@mcmartin.ca,
	kernel-team@meta.com
Subject: [PATCH v2 0/4] iova: switch to augmented rbtree to avoid linear search
Date: Mon, 18 May 2026 14:05:03 -0400
Message-ID: <20260518180545.2286608-1-riel@surriel.com>
X-Mailer: git-send-email 2.52.0
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

This patch series turns the iova rbtree into an augmented rbtree,
which allows alloc_iova to also be O(log n).

It also adds some self tests for the iova code.

The code was written by Claude, and nitpicked by myself.
Don't be shy if there are more nitpicks remaining.

It was tested both in a VM (running the selftests), and on an
AMD Bergamo system with IOMMU enabled.

Unfortunately I do not know of any way to reproduce the linear
search soft lockups at will, so I have not been able to verify
that scenary in practice.

Based on 5d6919055dec Linux 7.1-rc3

v2:
 - clean up selftests (thanks Jason Gunthorpe)
 - address Sashiko concerns
 - drop the search-with-alignment, since most iova requests
   should be of similar sizes, so the worst case behavior
   is unlikely to hit once ranges are excluded by the augmented
   rbtree



