Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C981FC8
	for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104615; cv=none; b=e8JF7YuWNM4Fowv4olCvM1Jky/KtVX/sUCLrS9WbeGTf0pzktCJKjdn4ml1xpIxcjtMiJL4cuOzlOxT4Lp0nRBPk9lc1ypwYUJ1+Mrk8Nb5f1EcTw3Vn67x6lnmzNKbTrB06SAXnNzkDPLiCNBuDxX41KdeXuVeSKCrOxUAHsVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104615; c=relaxed/simple;
	bh=vOx157s95qoV7CPWPkAReQKiswUEhlIYBuOu1h/6aWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddtlYve/JbKEGDA1I1c/mkJHM7xI1GxPRt3yjf1/7lRN4TPzd3bXIPXhGZ70anyxJbP5PNsKSK69K14i5jx+9/ia0T9rrECxvm90fcylDMh8VURfm2xk5wAGC4m3wfOp1TSNzLLH7qeui82kx2oBt3w/N0XapjoGH5mgM2ZZ/tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 58C9D227A88; Mon, 23 Sep 2024 17:16:43 +0200 (CEST)
Date: Mon, 23 Sep 2024 17:16:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc: Leon Romanovsky <leon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: AMD SME fails boot after "dma-mapping: direct calls for
 dma-iommu"
Message-ID: <20240923151642.GA26627@lst.de>
References: <1727103770.hoytxrqcmg.none.ref@localhost> <1727103770.hoytxrqcmg.none@localhost>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727103770.hoytxrqcmg.none@localhost>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 23, 2024 at 11:09:32AM -0400, Alex Xu (Hello71) wrote:
> Hi all,
> 
> Recently on torvalds master my ASRock B450 Pro4 with Ryzen 1600 cannot 
> boot with mem_encrypt=on. Bisect blames "dma-mapping: direct calls for 
> dma-iommu".
> 
> Let me know what further information is needed to troubleshoot this 
> issue.

Can you try the fixes already queued up here:

git://git.infradead.org/users/hch/dma-mapping.git for-next

?

> 
> Thanks,
> Alex.
---end quoted text---
