Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657F285C65
	for <iommu@lists.linux.dev>; Tue,  5 Mar 2024 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646379; cv=none; b=u5DYBJmzpC8lgA+v9huOKeyAfHdb0sVzoDu3v06vhE5uwa2Nl2ECkNIN0r9Bees4xf9FnlbQ8TjgCmhmBYo1wTACjhnkwiKOWxfL0eWlxqEmVSVO5N3BzhJLBcjazohncslFYz4fuchpGgkBjqegbIAtVV4Vn8BS8FFfGcsC4KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646379; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4+Ws8+LVNnjMLz0FM4U4fE8FzjxiCZaizN5RbKfqrERo0O6x/fg/sIgdCM+CfYOFgCDtiEO5+7zcbF5ZR+UvCPGYAHzoQqKkrxZ5tDom8OtusM2C4wKtKAmtiWfdanTLTyk2Dpp5QRVGfHYgjHB7XbvkbOjSUGwCqQ5mwUQRck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1A29768C7B; Tue,  5 Mar 2024 14:46:13 +0100 (CET)
Date: Tue, 5 Mar 2024 14:46:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	will@kernel.org, mhklinux@outlook.com, petr@tesarici.cz, hch@lst.de
Subject: Re: [PATCH] iommu/dma: Document min_align_mask assumption
Message-ID: <20240305134612.GA2063@lst.de>
References: <dbb4d2d8e5d1691ac9a6c67e9758904e6c447ba5.1709553942.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbb4d2d8e5d1691ac9a6c67e9758904e6c447ba5.1709553942.git.robin.murphy@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
