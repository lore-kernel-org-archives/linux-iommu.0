Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424145;
	b=oa2CoU/5WYlP4Uf9y9BOp1VZyf39BzroaVDld15CB95gJW2cukf0lAmyhLy4iuwGZP3N
	 9PM8F96zfVE4+h5FHvJUGFziXNQNRo3uS6UnANb+Wt6+s1fi7VM12JnKyi7nUajwilXzD
	 Wpk63gzlZggtaNNx6g8W/qYKsIwcNFK87pzriulvROqmHxPO7uXscS+g3gTzgK4+DsSJi
	 gSCk5T8Z5XnBPzCGcYui6PHbv8DBSGB5ccmpbeo8Hk3rDv3K1FpRYYkfvKE3/Bcywknbd
	 GnlVC/4DXio9Ob5p2Ecp0V4XF6AvHGmejiBqqhx7A0CITbB+XaY+BU5dP8Jx50lEt0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424145;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aZ8iY72BDIX7Lb6nq1K3Ub9imyQBaBRIv4gacmQR40U=;
	b=Zf7UpAdvVqSO9yQtnTNfwepbyIbtx7EWQLtrlQJ7p3PHoffkBh1OWXKJpiTS8N+LbVWX
	 gYXW0UtNESFhuakGwqAOctcJ2mrTXfmngrmp3+vgQehHYq6DrirQvyFl+m62LWSN9qQCs
	 gLn+NQjjNRvCnT9asqyJoIRAV7QqEmoQsOc89wlNIWRGrjPOq4o//uND8xkNzozcVtL86
	 TTaqDwKytDTyG70uMNSjivnOI7T1nKQ7Ej8xisFH1VNU/3Q+zB8wz4j1/nQVaQFBXmos6
	 Vq7nS1qvfjXXioEyQU/829aorQwl8u0qCw1jjFIFp0BD61q3bsX+LYEzuA3lNa38kcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DB7606A31A
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 08:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2DB7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4B87F2436B3;
	Mon, 23 Nov 2026 09:55:38 +0100 (CET)
Date: Mon, 23 Nov 2026 09:55:37 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Peizhe Liu <peizheliu@utexas.edu>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Kevin Tian <kevin.tian@intel.com>, Jean-Philippe Brucker <jpb@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, iommu@lists.linux.dev, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/sva: Charge IOPF allocations to the faulting mm's
 memcg
Message-ID: <awP_epk66QlZF7rj@8bytes.org>
References: <20261012200823.699316-1-peizheliu@utexas.edu>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012200823.699316-1-peizheliu@utexas.edu>

On Mon, Oct 12, 2026 at 03:08:23PM -0500, Peizhe Liu wrote:
>  drivers/iommu/iommu-sva.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied, thanks.
