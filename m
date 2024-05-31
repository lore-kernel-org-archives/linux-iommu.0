Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD3B1F608;
	Fri, 31 May 2024 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158718; cv=none; b=u2VsaV/ADx/mvOYsU4SXOoCWNi+Md2+FtexBYATY0BAx4IAOPSekV+Mo4iJO0qz4LbQmQKUC76qTQOWeIsjP5+0SCHkXkVQ77BFlSlrnXDcKaXS3DQoU61mNA+FRXKwxjbEY//HPNm4tcBH4C3zcK7ObvkPsCQIpauXhGlHdT9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158718; c=relaxed/simple;
	bh=mRSN4A1Xr0MWy244nHs87T0YauWJGd9D9C7ZFJYIqkM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Hy7FmVEMDfpukNui4ku50I7vRmohoMpu++Sjwax3tLWSMEkvMrNC+WEberBH50UdyDfwdU8bYJhNiJtkwNQTxTMaNWanLkg5T5xOH+SneAqycxqc+o+nEt9M48FsLZ+lKKYCNNivZAMCWTStzASe9AWL8XloDjL+a02bb2NWC2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TqfjEPpd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TqfjEPpd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=FzSajvLdvYD4oT1Gfk0OIFaE8gbg26t3Y2yn0sPe+Ro=; b=TqfjEPpdsL0wce1/6QVLAxmNkq
	T6mk+o04utYJZX3UxmE3YagVcXqiBytpPlp3B5/jHeugJcKMdcwNt7TNIR1vPDnx7jSnRJuTTODse
	/EIwHQWNCwbV4HfRcPIsQ9UVFjppGDK+ezuYUnBr+xtq5hVpn3upTN5+obBfVeZvoPEUb5Vg5mM7r
	oLGJLIAfKJhwx5UoJtv4BXI25jURgR64cmjP9mvOk5LCg3DdWTnfPyg7FVPEnJ8PaZHYlOnaVR7GE
	0Hrr/LeuJHxs3TQ5za9i+GhPDAvd4FWo1P5S/n4L1ClCeaF2dt3cbEvmGCVLk4Kv3FcP/Qm3mL/Ac
	UdmHE60Q==;
Received: from 2a02-8389-2341-5b80-5ba9-f4da-76fa-44a9.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5ba9:f4da:76fa:44a9] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD1QJ-0000000ACXv-42zT;
	Fri, 31 May 2024 12:31:56 +0000
Date: Fri, 31 May 2024 14:31:52 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fixes for Linux 6.11
Message-ID: <ZlnDOBd2X3T4fiev@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit c760b3725e52403dc1b28644fb09c47a83cacea6:

  Merge tag 'mm-nonmm-stable-2024-05-22-17-30' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2024-05-22 18:59:29 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.10-2024-05-31

for you to fetch changes up to 82d71b53d7e732ede6028591342bdc80fabfa29f:

  Documentation/core-api: correct reference to SWIOTLB_DYNAMIC (2024-05-27 16:52:09 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.10

 - dma-mapping benchmark error handling fixes (Fedor Pchelkin)
 - correct a config symbol reference in the DMA API documentation
   (Lukas Bulwahn)

----------------------------------------------------------------
Fedor Pchelkin (4):
      dma-mapping: benchmark: fix up kthread-related error handling
      dma-mapping: benchmark: avoid needless copy_to_user if benchmark fails
      dma-mapping: benchmark: fix node id validation
      dma-mapping: benchmark: handle NUMA_NO_NODE correctly

Lukas Bulwahn (1):
      Documentation/core-api: correct reference to SWIOTLB_DYNAMIC

 Documentation/core-api/swiotlb.rst |  2 +-
 kernel/dma/map_benchmark.c         | 25 ++++++++++++++++---------
 2 files changed, 17 insertions(+), 10 deletions(-)
