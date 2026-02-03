Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D171539E182
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770125806; cv=none; b=MZ4Dxo9/ovQgrmN24GgOBpODzZbrcbTgLuiKQ/sBUnExlrGZK47vRSYSdgMTv2uKk9itF285mirsHoJIzWj9PZuZY/o4BpKAoOCyOmX3YjUX1wLHgeqe0VelB3QPzLSL9sKPbHy8q1iN1SntpdAfmwzfFck8mSKJr3uk/I6uOeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770125806; c=relaxed/simple;
	bh=v5sB8af770D7WlhHuxhoIDprO/a64RNxun6PVNPiMGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PX9oDrQEulGy+aYvbliLwFpHbCZqTVcIxESQAfqXH3HfWe0ydgJ1buv5wZppOwB0fk0Ak+bMTWOOjFMaN2iVpfSv9+Ktwt7WCWW4V0Ed3XvrDuXlBLDhG24BTkUOHnkq1fOrDuwpesOcn0Jj2ihLZ+tR+xZQJhN3CRyNSZIPs/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=8QVL6Etq; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="8QVL6Etq"
Received: from 8bytes.org (p200300f6af1d96000d555eefe9f0908c.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:d55:5eef:e9f0:908c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id CADA01C09C3;
	Tue,  3 Feb 2026 14:36:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1770125802;
	bh=v5sB8af770D7WlhHuxhoIDprO/a64RNxun6PVNPiMGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=8QVL6EtqeZoFJ6f8B6qPBwTq+dtOVpQGYYRSLvnuj78az1K/Henf3U9dcDBbJJW4W
	 4Y2u9/V4k9Z00egF6mOQuHazHeflHIONtvy7AOyEOVxjFovm/8ZYpvX19819poFLdB
	 WEj4Lp3OMOqjeUlRlIli32ys7tJ0qIIbzGjLBRqU/YfmH3komqI3krF5EXTczxQDWK
	 TO85qAEKBPYPl/5C6YaH+419bBpOTyxWSb6ctfov6YKp2fLRHYsiJCF5taBhzUKpIu
	 NMLVo9lXq2AJiyUnduaIzsLuWTw4LmHpD8yeHDD0+sSTF0xtlxHBnTNkL9/Vp5JdFi
	 pbknpqLIj7bgQ==
Date: Tue, 3 Feb 2026 14:36:41 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommupt: Always add IOVA range to iotlb_gather in
 gather_range_pages()
Message-ID: <khum3zw7dw2cyoxni5wg5a4tayhhuwmst2jk6mkh4zonqamw2h@rq54ishxhfmx>
References: <20260203082934.1270789-1-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203082934.1270789-1-zhangyu1@linux.microsoft.com>

On Tue, Feb 03, 2026 at 04:29:34PM +0800, Yu Zhang wrote:
> Add current (iova, len) to the iotlb gather, regardless of the setting
> of PT_FEAT_FLUSH_RANGE or PT_FEAT_FLUSH_RANGE_NO_GAPS.
> 
> In gather_range_pages(), the current IOVA range is only added to
> iotlb_gather when PT_FEAT_FLUSH_RANGE is set. Yet a virtual IOMMU with
> NpCache uses only PT_FEAT_FLUSH_RANGE_NO_GAPS. In that case, iotlb_gather
> will stay empty (start=ULONG_MAX, end=0) after initialization, and the
> current (iova, len) will not be added to the iotlb_gather, causing
> subsequent iommu_iotlb_sync() to perform IOTLB invalidation with wrong
> parameters (e.g., amd_iommu_iotlb_sync() computes size from
> gather->end - gather->start + 1, leading to an invalid range).
> 
> The disjoint check and sync for PT_FEAT_FLUSH_RANGE_NO_GAPS remain
> unchanged: when the new range is disjoint from the existing gather,
> we still sync first and then add the new range, so semantics for
> NO_GAPS are preserved.
> 
> Fixes: 7c53f4238aa8 ("iommupt: Add unmap_pages op")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>

Applied, thanks.
