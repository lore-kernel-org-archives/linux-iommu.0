Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CCC6BB50
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 05:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715060177; cv=none; b=Jrz/HSIpe7AydNFXyG2mCqIn0QjmE3aAdXwDqKJy/RAxvPatmoMaSOC8J1G+qRAlob2emCnUrhohTpV8sBj8ufJyV8/OFL4BDsDEWDia1Evxt67EbnE0rt6m0MSeFvan7AZoZaDAy6LYsqnSXWfPKyEeVRKmYMV0ue67Ialqv3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715060177; c=relaxed/simple;
	bh=1P2VbTrkd4MKGFI2HmWOgvqPu1CNUdtpUC7dSk0aT0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhV6D06DlEboNF7UMaNqDJjzqusb9PpycDmbTgOASfM0XAxFcP6aizs8BdG/iAnrTqnU4vVSmX/xyr/nxzB1JoExyVpo2mN6pPjC2cebr49woZ3pj+kEh/+YJ0OYek0ANXKV6fEdSe5zcmDWBy3iKvG941h01+27zUvKLtt26h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 66D67227A87; Tue,  7 May 2024 07:36:04 +0200 (CEST)
Date: Tue, 7 May 2024 07:36:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: mhklinux@outlook.com
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, jgross@suse.com,
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, hch@lst.de,
	m.szyprowski@samsung.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	petr@tesarici.cz, roberto.sassu@huaweicloud.com
Subject: Re: [PATCH 2/2] iommu/dma: Fix zero'ing of bounce buffer padding
 used by untrusted devices
Message-ID: <20240507053604.GA31731@lst.de>
References: <20240408041142.665563-1-mhklinux@outlook.com> <20240408041142.665563-2-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408041142.665563-2-mhklinux@outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Apr 07, 2024 at 09:11:42PM -0700, mhkelley58@gmail.com wrote:
> I've wondered if this code for zero'ing the pre- and post-padding
> should go in swiotlb_tbl_map_single(). The bounce buffer proper is
> already being initialized there. But swiotlb_tbl_map_single()
> would need to test for an untrusted device (or have a "zero the
> padding" flag passed in as part of the "attrs" argument), which
> adds complexity. Thoughts?

If we want to go down that route it should be the latter.  I'm
not sure if it is an improvement, but we'd have to implement it
to see if it does.

> The commit ID of Petr's patch is X'ed out above because Petr's patch
> hasn't gone into Linus' tree yet. We can add the real commit ID once
> this patch is ready to go in.

I've fixed that up and commit the series.

Thanks a lot!

