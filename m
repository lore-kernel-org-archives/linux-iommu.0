Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CCE33A707;
	Mon, 19 Jan 2026 08:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768809665; cv=none; b=VSjYAjUqtGCivxiJekEiAl4Qik2k+BzKWSmq+OwbilTz89f+2g6uXicpQKzACqRAPoxwcgsAOULE3MGjHW7OZpwkDNEoStJzGGc78x5DEVwPV+g1EWyV1xPX0Vuuw7/IJH1IRWfipCWcgBWNl1x9sFE+/OW9OFel9SJIWt72TOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768809665; c=relaxed/simple;
	bh=Esu4hAZ6HFgue4J3DwoNl2MfyWUyIt0GHSfRSJpFKGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8LTgcS8o9xqXRF1gkrdQ+J03mNnyHGg7u1GWvPB5NCcmmlnPzTyLJB1qSp95rWqyfgjstpGoK7mLlacCh8F7Hy9eIYVpsznfojVqsbrsQT1S0fbBZeHt8iAm+DEQJty+FbW6M4EaOeBx9bmoPXuFd9YraE2i/v3eEtfH8FwR7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ubq6fn6T; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ubq6fn6T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Esu4hAZ6HFgue4J3DwoNl2MfyWUyIt0GHSfRSJpFKGo=; b=ubq6fn6Thksqja2wtuOztcnsPl
	ZEVXRGcsKpuB9PFdv+U3vIHMxd/KX0dtY9Llto/E/19HhxqA50SyrDF7xuFy+rUcprfaCQzwk/Qa7
	CJOQuIkuIn4533eWlv/FzBEZRuZbwv9E5MO/MNdu2SLehHK+b5YYPt2p9Y7kHkr9v1dMG54YopTIq
	zg2OI3JLUT+Wz2Be5lTIV3rKVGyjNahTGgTs+w3DfVrWJiqsHAeMhLzKWZvIhknfdhs3jg48omViR
	/gDh98CiZBNzyUyoVIly3HBJfG6fffxBrz1C3XqcF5noayvH6hYVXEn0vLaNysH7Ew03K/jJ00apo
	RQL7tWww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhkBz-00000001X3N-3IJg;
	Mon, 19 Jan 2026 08:00:55 +0000
Date: Mon, 19 Jan 2026 00:00:55 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
	m.szyprowski@samsung.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, vikash.garodia@oss.qualcomm.com,
	dikshita.agarwal@oss.qualcomm.com
Subject: Re: [PATCH] dma-iommu: Introduce API to reserve IOVA regions for
 dynamically created devices
Message-ID: <aW3kt0sKxCw2Cri8@infradead.org>
References: <20260119054936.3350128-1-busanna.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119054936.3350128-1-busanna.reddy@oss.qualcomm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This still seems to lack an actual user.

