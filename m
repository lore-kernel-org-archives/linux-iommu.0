Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF39416419
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719907373; cv=none; b=r4pz4KSg8/RELZ/bI/rAQtl2VgP16x7Op1svX25bEBU0x0rwgwIKCAKntsrD7Kr2jET3VXkhRo06gVjkKDuCI9gIP4f8iVaUCTp5cRVlxfLTuaQSBWOGRFFNsjG1i/bNAN65pe1gDdUrCwMeHIKeNCqLySe695H/UHqLPYfjOf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719907373; c=relaxed/simple;
	bh=ea/Oc802VzXIU0k1MZ3Me4XR7Z2SDUDuW/2gLVMx1RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uf1wx7XSeRMUSSkjsIPQZ7VNIaSH7QMryde5loV7znvbbKhzZCfFv2637DIJifZI4MmGdfTIc6iQUdlxqw2qkKy/T2lhNwYFgPVNQlc36NpNYcYtiXV1ONC6uxU1M6l1l9gXyVdatXiGcUGkg+3WhhaETmbEvT0ZHilyrk9IWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mMgjDu9V; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mMgjDu9V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mfqr68m+CniIpESBVwW0zyAqCSNDHfTJ9qkJeqQXluE=; b=mMgjDu9Vcu2NbRUxXe5aawGYYH
	lHI4wFgOn9sZG3QLt0fKsvsnYH4bcADKZELYQxGf+65xadh/QQzDWzTLrqsOLo4SeB0mOyTp3bCEk
	OGKXadXmcDhtkyr3Zxg1QhgBlsH83M6yeapM4JZycBAJWyaCNdfS8DVOuP41Tu8ceXvp54braRqF+
	o2omstuKf6LjMGwFxJgorb+3yyOt7a4BZm+ORrnhwEmXgm5JzdnTHGzvlJxOSo8YkCXniOxwjvQMs
	b/ib+G7F6ZWfzt26R0i0PZKJ5OlVszVVbqSwJNDShAABKH0SNQqA2jHkY/M0huBsyLXXTUw4Y37BG
	rLAJef5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOYTT-00000005wBS-1Zi8;
	Tue, 02 Jul 2024 08:02:51 +0000
Date: Tue, 2 Jul 2024 01:02:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev
Subject: Re: lack of permission checking with intel-iommu?
Message-ID: <ZoO0KxkU_JNO0av4@infradead.org>
References: <ZoOwc7O5W0PUeja5@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoOwc7O5W0PUeja5@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 02, 2024 at 12:46:59AM -0700, Christoph Hellwig wrote:
> Hi all,
> 
> we've recently had an interesting case where a device unexpectedly
> modified a dma buffer passed to it.  On AMD systems this caused iommu
> faults because the buffer was mapped read only (DMA_FROM_DEVICE), but
> on an Intel system everything worked fine as the IOMMU did not trip up
> on the device writes to that buffer.  Any idea why that could sneak
> through?

Sorry if this was confusing, the permission checking is of course about
the device reading from a buffer mapped read-only for the device
(as that is what DMA_FROM_DEVICE is), which on intel still allows it
to read.

