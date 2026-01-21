Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF658311956
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768996332; cv=none; b=BbV2lfueIZS6PMay70GwJYbM94HzMKxDyqSczAGORXyYT9n0venUJCJzqzVrRQrAo/z4guryyvfPB7jGucPF+LYpfTTDZ+J0xxMHwzzT5mDCVoEjgxQfNfC+T7EG5fjNaRrHWKL2nAuR3z764/gYLi/YeXG31JkdCSC+hpJHzJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768996332; c=relaxed/simple;
	bh=e/LSjLy480JOTxFI01dXHOL1Q7hisUSXSCINws+Rksc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnZB0ek2MGdgYJ2innJ4CVlWi4YmUt6RFy6eBrKW4nXyTB77Z7Hr9s1zXe4YWKMf9VEzPM+TkD4eBVP0VXwGFhzJrL0WyPH7Jsv/FBlyOaA2G09M2k1+kUje8lBQqbBXlrcU9VkIq/KSlg7EwLzBXbVzBwyyNbdkLJ2QXEGQ+6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=4QbZz+Ur; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="4QbZz+Ur"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 386A61A268D;
	Wed, 21 Jan 2026 12:52:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1768996328;
	bh=e/LSjLy480JOTxFI01dXHOL1Q7hisUSXSCINws+Rksc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=4QbZz+Ur+wTdgiVgjwQfU//4PR+9fqRE2V2CokJ8fBPzWHPdMSkLrGxLcRN8IGvAs
	 K4iDoYct8JcmgnNpkDM6kVWHbaCeZRBgQgQEJ+ZDdC4rjN6b4atN2tmIlkSIN/uh2G
	 Fs92BppThSWJsOzqhj2gcoRMpBHGzpb0WNOkrcbevepuNmt+H8PQU4c9MNpdAFVkyU
	 jl3EgiMBVgazb12ZF6SqRWCeduDP6hpnKlyuzaXHscswbYPgBn9jeLmO9iY/QcAP37
	 BpvO8WPu0MIrmuKaLSWYpfvsmK2k6NrxkHJDg2PdrgHkMMWHLT+0S3AstXtszkUYQN
	 Uk13cbOy/t3AQ==
Date: Wed, 21 Jan 2026 12:52:07 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net, will@kernel.org, 
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, 
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	rppt@kernel.org, xiaqinxin@huawei.com, baolu.lu@linux.intel.com, 
	rdunlap@infradead.org
Subject: Re: [PATCH v2 0/2] iommu: debug-pagealloc: Remove pfn_valid() usage
Message-ID: <p7j3zm4epypqkjmbecxzkfbyqggtbdoee5phfldjlbbxi47oti@fdxe3mt2r77m>
References: <20260120091926.670155-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120091926.670155-1-smostafa@google.com>

On Tue, Jan 20, 2026 at 09:19:24AM +0000, Mostafa Saleh wrote:
> Mostafa Saleh (2):
>   mm/page_ext: Add page_ext_get_from_phys()
>   iommu: debug-pagealloc: Use page_ext_get_from_phys()
> 
>  drivers/iommu/iommu-debug-pagealloc.c | 31 ++++++++++++---------------
>  include/linux/page_ext.h              |  6 ++++++
>  mm/page_ext.c                         | 23 ++++++++++++++++++++
>  3 files changed, 43 insertions(+), 17 deletions(-)

Applied, thanks.
