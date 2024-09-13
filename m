Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868CB39FFE;
	Fri, 13 Sep 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240197; cv=none; b=GHwDClu3FnwZ9nIBM6tcuDKhhzS+pPI7H3yCe0cELkUn0D07VbIgbrBHHTfTzvU+4t2B0+ICTVey6igP3xCa76MIxkywc3F9m1pPZhqVHHSC1TR480xCyWfdKtgMjf7OxYk3LYUCESko0BKBEDMDnSj3F9qTOAnnjHfh+/fHu4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240197; c=relaxed/simple;
	bh=znU+X4tFxwxnviR4AYXtN1Sh+JSn9dROBTL9XaILOKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWUARPY6RT4+ShoimWAnhz2TUe6CbJTkO0FIlyo8UWV4VCyk1Y6g2UBhEQpXzAdWJljsXYD9VgLM/OTWPPw6OnNjanliUOisJ95SsgZFNYGOydrfkjMoOcG63bOX4gCuc/5j+VnjaROZ42hTZ4Ggc1KyJqFmehAKLx0WRaBKpjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nGd4CI0V; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nGd4CI0V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x/8EgQj4KxZ9gUl8jGT3nxlXQiSyXCD0NOe989Q1/P8=; b=nGd4CI0Vcf4+UnTwpy63g9lkdt
	Q8WyoobXi5sNYkGmdcjuPJAmEq9cubAp0Zjgfyi/t8iMICdrIdHvt5CvTDLGkoelSeAy5sBI/q1F3
	SYZjT97JhT7JsEez1AYh+T58Nzhh/Qw5HiNJ3k2juGbeXKZ8QgQJT7+N5nxCltJ8jpgTpAxhLcn+d
	zUEL2efANwIrRxe0iMrfPf/y+ZLzQ53vjVdD0W7nfXxNOe6HDdivUMEWdW57/bJiF2bXK148A0ADm
	rnqV6BjzJHQhr8wc+DEK5Hyt92z1Gz2SWuqkbFEHyP3yrWvshUjc5eF9edBqApaPEbBG1P109NTCC
	+W7IqH1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sp7vf-0000000GhkV-1nsY;
	Fri, 13 Sep 2024 15:09:47 +0000
Date: Fri, 13 Sep 2024 16:09:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, alex.williamson@redhat.com,
	eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	zhenzhong.duan@intel.com, linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: Re: [PATCH v3 1/4] ida: Add ida_find_first_range()
Message-ID: <ZuRVu088KuMbtqsm@casper.infradead.org>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
 <20240912131729.14951-2-yi.l.liu@intel.com>
 <ZuMEsybAnOi_uSfY@casper.infradead.org>
 <a24aad52-3da6-49d3-9df9-f418fad36434@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a24aad52-3da6-49d3-9df9-f418fad36434@intel.com>

On Fri, Sep 13, 2024 at 07:45:55PM +0800, Yi Liu wrote:
> > No test cases for the test suite?  ;-(
> 
> let me add something like the below. :)

That looks pretty comprehensive, thanks!

Acked-by: Matthew Wilcox (Oracle) <willy@infradead.org>
