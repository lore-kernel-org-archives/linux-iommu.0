Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B524271456;
	Wed, 24 Jun 2026 03:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782270542; cv=none; b=cvtOma9i9FZ6q5P8MQgRIm7gLHQd0uEdX/i6nYOj4HfR7LTm9WceXkbfvzD67TgbRXNj79BiGCAWkMDVQfeWmJKmpbotp3mfmLOq5mTMb8AEikWsCvn2Wca3UtmNiJAJFgYmKOJ3o0uwEiB19AgK/1iz+etqiurkkhCjm8HDONA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782270542; c=relaxed/simple;
	bh=s4mP55O6NVQx2kslwwS+ny5SZUXNqNR1YaQeP7lJNEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YkiAYWsu7xDoyNFycm1lwDGSPfdh+Hh1S3nP6zVOydtdZRhdyFrAxNtblcdY4PEt5XUqWL4rpAVZn23lgubykMFjiglH7nYen8ZdJ9sXpI5jZHQgmOL4fd+e+tPG5gsTzOCZ/TY/s8sYS7kfKX8PKUxkw/Lh9oQcN5hqKbUajDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=ADNUlsiB; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="ADNUlsiB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RobABJpskurEQ6uTwJoJSUqeJrsXE30WjiSFO1zXmtI=; b=ADNUlsiBWkp6NoUV3ngm//crEV
	2ydBB4uI4oyufk0CFGE59LQdzb5xwKEoCKHAwt3l4USQo5gR8UhrjiJ8uscNv95DYG1eZrHR2FYX8
	sBWbbYc4h/+47fjr544V4908nsoAgJRftCHBvgWgo2FMq3m22qS3M0j/Q7zn7CrNETntezRRglS9q
	Q6HiJeemE3E/6wOrgOds+elMxqqa7a69j4qlSnxhdL95Lr/sx/b6cZ/5HRG+O940fBOyg4f4VEGD/
	dwb/lZiH9KlFj1LGJ3caUAKeQytBWAqxQlENPy5Vy7l7i/5KCo4wWw34p/gbB1Av7PxIv2TUqzp4k
	WpiXeQ5Q==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wcDyy-0000000087q-2wVD;
	Tue, 23 Jun 2026 23:08:56 -0400
From: Rik van Riel <riel@surriel.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	kyle@mcmartin.ca,
	ashok.raj@oss.qualcomm.com
Subject: [PATCH 0/3] convert iova to maple tree
Date: Tue, 23 Jun 2026 23:07:33 -0400
Message-ID: <20260624030853.2340880-1-riel@surriel.com>
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

v4:
 - reduce the size of struct iova to 16 bytes
 - simplify the (hopefully rare) remove_iova GFP_ATOMIC failure path
 - test case for the deferred free code
v3:
 - switch to maple tree (suggested by Robin Murphy)
v2:
 - clean up selftests (thanks Jason Gunthorpe)
 - address Sashiko concerns
 - drop the search-with-alignment, since most iova requests
   should be of similar sizes, so the worst case behavior
   is unlikely to hit once ranges are excluded by the augmented
   rbtree


