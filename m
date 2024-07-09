Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6964D13A25F
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523945; cv=none; b=rEDHeX7lLZhHfomSNY3UDEVGiC5DGFVV0+WxunXzzlP7KQRM4WxcJVa2Oevyi0KvTYfNIK3/keAmot8OVzWEFx44ibocTBLjCI/QZacrpo44zHE+52zjCxjHtb9K6LjAYpZbgfs5pb4dwIXIA9UOJNu+tKgsx+AmZ7jCHmYM+NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523945; c=relaxed/simple;
	bh=QRkcc0hh47W83wRJLKAdnrFTrF5uWtuMvFbG0s3iWaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImBgkCLbflIeFvDCB2CKzac7DsGnczHvIJYKY63F1dXoBsvFP59g18jM+6hNL7cV2YMNCdoCUlPKwgsmGY2nsWOTJx9UpA1rnt7bovI/SFRFjw6VvJySNydWFL7sDiY/62j6x0EQjD8r0oZ53CPEVIhvW1XIAjeE06eSXVJY43Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9BBA168CFE; Tue,  9 Jul 2024 13:19:01 +0200 (CEST)
Date: Tue, 9 Jul 2024 13:19:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yangyu Chen <cyy@cyyself.name>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH -fixes] dma-mapping: add default implementation to
 arch_dma_{set|clear}_uncached
Message-ID: <20240709111901.GC4421@lst.de>
References: <tencent_A5ED71472ADCAF18F59085464CBE23C12A07@qq.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A5ED71472ADCAF18F59085464CBE23C12A07@qq.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 09, 2024 at 05:25:29PM +0800, Yangyu Chen wrote:
> Currently, we have some code in kernel/dma/direct.c which references
> arch_dma_set_uncached and arch_dma_clear_uncached. However, many
> architectures do not provide these symbols, and the code currently
> relies on compiler optimization to cut the unnecessary code. When the
> compiler fails to optimize it, the code will reference the symbol and
> cause a link error. I found this bug when developing some new extensions
> for RISC-V on LLVM. The error message is shown below:

Same comment as for the last one.  I think your compiler misbehaves,
and the typical reason for that would be if you disable all
optimizations.

