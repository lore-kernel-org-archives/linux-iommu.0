Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FC514E2E6
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719908710; cv=none; b=hy5vfVTpCB3PIgPObGfe7XrTH6m0wMd4j/OSA6CJ3qFrbAdPar4OuWH5ne7S+P6TdfF7z2qMbEmVmO7OAZvn/xlEPPjEEQXV3BH3uW9OSEGXiQt6wOuWYYqMIsw7kwcDg+4/jRSbk7AJq79OxznEzddgEYBm71fQO5LTl+sd4o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719908710; c=relaxed/simple;
	bh=nezZaLRQYKczeydaQVqwYcxuR4xq/S/obPHGcjVEAuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzpWk0tMzDyA0taMLppCT+UcB+pJwxj1YyR4zOYcjK378pIhRjfGXBE73Rx/QcGesoEeG9i/Jy1Tld64vpWWh5iaZ+59dS4D5Frm+Qg2M/NZorcg7EooaaN29caPWzycoi3Kj9AlUHPqBBz60sXcrdrQc7AYFSZo6OeDpPHuYjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YvTBKuHH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YvTBKuHH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pDGFpacpgz1Bc31NNapEENaSRx9tG+czkWJu3wz5AHc=; b=YvTBKuHH/XUkl0OKjpxhDFwZfy
	0Qo0M5b48lDsTbkVwlwtapKMyL7e6LKhroDnxk2oLzJrSXhCPEbHIO9yLkAHkFjVDGF3HmnXegMSR
	03aYXgOKmcp0yeE/dvzxypx0sxYdGlQT9ChWHR9/idl1pyKalqz2Izk1vJdhMz7PAvXaNJ5UCn4yt
	aL2pNFEIIXuhgFLfC5qc1jbhV9lbL61yTm3CZtNqbRmMoRGrlg5Bgd4io6SUw2/W61Qm3BIiNt7b1
	wib2CRbPbPiOZS8usFJxuna/HVTkdoCcHx6Nyy86ekpXxBjDmn/nwsBrQujPUVUY5BCtrakL1ZN9g
	+4tmm2ag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOYp3-00000005yxf-0bdG;
	Tue, 02 Jul 2024 08:25:09 +0000
Date: Tue, 2 Jul 2024 01:25:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev
Subject: Re: lack of permission checking with intel-iommu?
Message-ID: <ZoO5ZeYtA6qLIs21@infradead.org>
References: <ZoOwc7O5W0PUeja5@infradead.org>
 <ZoO0KxkU_JNO0av4@infradead.org>
 <4d84afa1-e2ce-4e1b-8fe3-1d3fb0db2ba0@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d84afa1-e2ce-4e1b-8fe3-1d3fb0db2ba0@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 02, 2024 at 04:22:25PM +0800, Baolu Lu wrote:
> Is it about IOMMU blocking "device reading from buffer" or "device
> writing to buffer"?
> 
> The intel iommu driver might use first-stage translation for kernel DMA.
> It seems not to block the "device reading from buffer" if I remember it
> correctly.

This is about device reading from buffer it is only supposed to write
to (but doesn't).

