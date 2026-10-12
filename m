Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC31D47ACD6
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807465; cv=none; b=d83WFD+OK/Qi/a2UDT5byhgqnnzFZ7A/qgYWwPmWMSQcP1BCKUlukouLfAsa3jRvt7rHP5sAlhGv8x2n3wvlvOrXpWwFQt6HKyDaahQYeMOErYwGPrVHEFEpOPaAWvSn4S0dqULxvwYlMPZjOHgtKFBPgKIPNpFV9mHDA5nNJnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807465; c=relaxed/simple;
	bh=a97eitSQlYdigcawlcd8+/c0hBgHCxsubwLctE3uf8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8rI7p9Axdkm68s19k0HbS09U+wxWDmUXx1fzYEJ1dF9au6xttT4nstadfrlh4BqFCVI+i2uyPDzZt5W0SRcFPpSV1KUC+LF7o2mkPrMjUt0sVythKo4vXoljmx/hbRcNiruG3+25dS+CSP1fSvmi/73tidIj2Dy7/uUnygk6/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5D7F96732A; Mon, 12 Oct 2026 14:17:37 +0200 (CEST)
Date: Mon, 12 Oct 2026 14:17:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@linux.dev>
Cc: Adrian Huang12 <ahuang12@lenovo.com>, Christoph Hellwig <hch@lst.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Jiwei JW10 Sun <sunjw10@lenovo.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [External] Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors
 based on DMA optimized limitation"
Message-ID: <20261012121736.GE29954@lst.de>
References: <20261006120248.147654-1-hch@lst.de> <8cf8a8ea-c9c9-434b-aec6-e361280a88a4@linux.dev> <20261008123724.GA22096@lst.de> <TPZP295MB0013C6E51C73799E49B8EFF4B3922@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM> <2007f03b-2c76-4c36-a0bd-0ce99d1a01a2@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2007f03b-2c76-4c36-a0bd-0ce99d1a01a2@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 12, 2026 at 09:42:04AM +0100, John Garry wrote:
> And now we seem to have a conflict, as Christoph wants block size > IOVA 
> rcache limit but you find it may cause this soft lockup.
>
>> 2. Another NVME with mdts=5 (maximum data transfer size = 128KB)
>>    2.1 The issue does not reproduce regardless of the 'bs' configuration
>> 3. The condition '128 KB' is identified because the IOMMU scalable IOVA mechanism supports a maximum transfer size of 128 KB.
>> 4. IOMMU pass-through mode does not trigger the issue with the 'mdts=10' nvme disk.
>> 5. The issue only appears with high-core-count servers
>>    5.1 Reproduced servers: 448-core server and 384-core server
>>    5.2 Non-reproduced server: 128-core server
>
> How long does it take for the lockup to trigger? Pretty quickly, I guess.
>
> Does changing the number of CPUs affect throughput (before the lockup)? Are 
> you using just a single disk?

If the iova cache locks up under a perfectly normal workloads it
is broken.  We really need to fix the code there.

