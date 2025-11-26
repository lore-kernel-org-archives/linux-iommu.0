Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DEE332ED8
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764176970; cv=none; b=AND51PckrzRLPpsG8XFe4f292IVxp9NEIRwFPs5WNfkARDONvCF327Ze9RnoHWqkx0BpdWeC4h8bUB9pPYMw75r8MwwLCEm6YsXmGMoXR+tJe+Jn0Fg0DaaWbg9sY9cVid0ZTy1NXQJrdf9Qb3eI1crPv4M1C4u8R8zXIk9zHjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764176970; c=relaxed/simple;
	bh=1bo4r9aNSV9mP/9/YKDQEU0Lq2R2IPeZQhXuYEuxzoE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=ceA/eRSAaWuSkLJPgFveDiGLYzJzU57buBnY8DPQWdhmmVftOZoa0Nk3Q8aFySZpiV67jhGiD/9PkiDuED56AV1cspGk8V0SvYAA2D/oSW31I+E2TxET4dqjfhEkUvXcGd7gLZaTmALTDP46SD+HAE5IHRO7g5tUUEz9Drn+wg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=BMV8ngGw; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="BMV8ngGw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=1bo4r9aNSV9mP/9/YKDQEU0Lq2R2IPeZQhXuYEuxzoE=; b=BMV8ngGwegK2v8DYh8upY2+9Av
	FQrqsegXkUKb68o2xtrTASqSBmB7jNxFj0UcSkn+KphUJkiqBNjLsfr3qJpZPUoMWGi13mTDdu7eA
	H4w/0cDc/qd0OS29PXPDOL/34mHcl/npW08/lp8upSkfFUDJWIvSxlW1zmgRUGxxAO2u9MMGP4EnL
	RusI3ifxlU1Abmfpr6QxGwgWZ+s1A5B7eo/zucFay4gspGLEuPJVRpMw74xCl1ek9lYe89roA7zdR
	qWHk8ju0SFRJRu20ri7YiKpybMJdvAf4dE+jHT7egGnufesB+7mfiJ6JDWEyEEiOBruM8fsHfglac
	Ug21fQwQ==;
Received: from s010670a741a4a87d.cg.shawcable.net ([70.73.161.44] helo=[192.168.11.155])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vOJ17-00000006h8r-44aM;
	Wed, 26 Nov 2025 10:09:22 -0700
Message-ID: <0a3c0fbe-2e3c-41de-a481-42c130fee404@deltatee.com>
Date: Wed, 26 Nov 2025 10:09:11 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Leon Romanovsky <leon@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Will Deacon <will@kernel.org>, Shivaji Kant <shivajikant@google.com>,
 Jacob Moroni <jmoroni@google.com>
References: <20251126114112.3694469-1-praan@google.com>
Content-Language: en-US
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20251126114112.3694469-1-praan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.161.44
X-SA-Exim-Rcpt-To: praan@google.com, iommu@lists.linux.dev, m.szyprowski@samsung.com, robin.murphy@arm.com, hch@lst.de, leon@kernel.org, baolu.lu@linux.intel.com, will@kernel.org, shivajikant@google.com, jmoroni@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] dma-direct: Fix missing sg_dma_len assignment in P2PDMA
 bus mappings
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-11-26 04:41, Pranjal Shrivastava wrote:
> Fixes: a25e7962db0d7 ("PCI/P2PDMA: Refactor the p2pdma mapping helpers")
> Reported-by: Jacob Moroni <jmoroni@google.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sad I missed that. Nice catch, thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
