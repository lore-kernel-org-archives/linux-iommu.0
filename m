Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E6C29B8E1
	for <iommu@lists.linux.dev>; Sat, 10 Jan 2026 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768038785; cv=none; b=uOy8aUmo5k0cc9ZC44iYLDpXSJg23U883lcIQ2jE3ar7sBqLWFFyfcDoDtOAcDIpS6akka0huRSgVe3m8XsvH+v00p33oYq7XTlowBtQpWp+u+/IPNS2Xs4Ahi+1vyAbEygb5uy713yRRY2N4pvYagJa/l/mR3iutP4vAvRoFSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768038785; c=relaxed/simple;
	bh=8f2+IkGXwyU7O3VPRSlueHN7/p5N+Fr7AxEkYHrqvh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1xeKH27U/K9EkZdHbuQcaa06iQlIX5b+z/VsyoVCmzmAgkAD5ReaLB8OPyXHfoYJwwzbG4oTC4EZXxFnwclDb8ruRvOTFXoSSkOo2da/GST+M0NTYCt9LyGZWDPBPCi3TTlZJnmEFGVIZ7G+Ww63sfN2KymFoSUzpLTEWXHQc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=yoiDrFVL; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="yoiDrFVL"
Received: from 8bytes.org (p200300f6af1d9600dfc71246d978d903.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:dfc7:1246:d978:d903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 61A745ED0B;
	Sat, 10 Jan 2026 10:53:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1768038781;
	bh=8f2+IkGXwyU7O3VPRSlueHN7/p5N+Fr7AxEkYHrqvh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yoiDrFVLI2g7ITJQIFUgZo5GKLHt1TXSh+HKM2bHlpEATFs3zLxAycUoCSktsw5+M
	 m9DJ087QRHaxMvAUmrRI+0FNhIq5Ss9mD582PVPzJAZJXbKDqTViRZ1DfkR7frOinF
	 yPJfDuoZKnpyY3gB4krZijiB8i1ZkhoZxc82OhJy/qP44TvlxhePGwXLWJhGqlKnZB
	 9pDzITnoCE7YZFnaw75HbH+6eTnkxucmkpKj8u7vBIUFV+2QCykzPUkVW8zllWLnPv
	 ePyCUW8/l0hsnar9iSvV3Zc0eEv0B6Y0ejc4P0kwv26F/Sz3fqdp7WO9lom6oZ3JDC
	 XlgtPKTfgyDag==
Date: Sat, 10 Jan 2026 10:53:00 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net, will@kernel.org, 
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, 
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	rppt@kernel.org, xiaqinxin@huawei.com, baolu.lu@linux.intel.com, 
	rdunlap@infradead.org
Subject: Re: [PATCH v6 0/4] iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
Message-ID: <hf3gfmaq673tvz6lc7mgip3m4y4o62b3nyqlofas252qr5776y@6oekozsrwea3>
References: <20260109171805.901995-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109171805.901995-1-smostafa@google.com>

On Fri, Jan 09, 2026 at 05:18:01PM +0000, Mostafa Saleh wrote:
> Mostafa Saleh (4):
>   iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
>   iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
>   iommu: debug-pagealloc: Track IOMMU pages
>   iommu: debug-pagealloc: Check mapped/unmapped kernel memory
> 
>  .../admin-guide/kernel-parameters.txt         |   9 +
>  drivers/iommu/Kconfig                         |  19 ++
>  drivers/iommu/Makefile                        |   1 +
>  drivers/iommu/iommu-debug-pagealloc.c         | 167 ++++++++++++++++++
>  drivers/iommu/iommu-priv.h                    |  58 ++++++
>  drivers/iommu/iommu.c                         |  11 +-
>  include/linux/iommu-debug-pagealloc.h         |  32 ++++
>  include/linux/mm.h                            |   5 +
>  mm/page_ext.c                                 |   4 +
>  9 files changed, 304 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
>  create mode 100644 include/linux/iommu-debug-pagealloc.h

Applied, thanks.
