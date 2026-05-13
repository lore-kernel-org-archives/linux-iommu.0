Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E80682866;
	Wed, 13 May 2026 02:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778637799; cv=none; b=Efo+Cmtqipk5WoL0joEPEeRJFY+K5KOkGP0rC7SaTj8ZxA+1d4FdaiW2sXrlV1W4NjHsMuMRI1eNXoRZyIf5ueZV3Uk6JMxwJ6PfmWTaEt9HfMwi4Qa/jamoO8LO2qL3SMHNSK+DpZRZvYv6GzY6ppfXxbUDESIJ9uF6Mxke7nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778637799; c=relaxed/simple;
	bh=O8gskHSN/sNNUFdFEb/q5LST6B6nwuSIihS6D+arHIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JkRuE4QB7/NIPF5ca1+tGhaK9llbAPpmNYlFOlw8r4MbO+z9yQpuIt+ThJbmDtyz5E88lSIPME/XkeGV8BxaoZ7VjnoP2+j9QTygrb/gmsKhyUklKI4fYTfAUjqv43YUs6ZFh4EzQA6gsTLTaf+732O0TAARlwOILEnLNPDnFyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=hSUqV8cc; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="hSUqV8cc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=O8gskHSN/sNNUFdFEb/q5LST6B6nwuSIihS6D+arHIU=; b=hSUqV8ccO3YVekQQl66zi+lTJg
	OEPrg5qPI6o5+jCAqXw7PlBBrbDWPSmS0C0OyMEWULit2Ym9Kq/m2MTI1Y6fUORUCZJ73f502aQpe
	gIzDmK4/gHOZCn/+wrzJVmLjFh84SRSqbAo4lQjqsNx5Fw3xqd4yW5sDfoNAwGELcDMDVrrtSkZ24
	rOtWF1La8ac/cHwAE4dlPovFpjwOVeSjq505vnFIT2h33r1xn58YU/wSTIIQaoVBHgHljkdkP4prd
	N8Y5Klw5/+cAitFIuEnaTS8QV/IsNwPnz9Xca/Ph3tfmcY7SV7NIm59prgfwZBOf8RjOmE0fgYF8F
	bAKXF0Ig==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wMywG-0000000022e-3Znm;
	Tue, 12 May 2026 22:03:08 -0400
From: Rik van Riel <riel@surriel.com>
To: linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	kyle@mcmartin.ca,
	kernel-team@meta.com
Subject: [PATCH 0/5] iova augmented rbtree O(log n) alloc_iova
Date: Tue, 12 May 2026 22:00:17 -0400
Message-ID: <20260513020304.1528751-1-riel@surriel.com>
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


