Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7281622071
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 07:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656487; cv=none; b=sTO6P45+a8Qkkq2TjlEmN/S1UaPnLew8ob085UOh8RrPjV0BXB9/qdn4sMM+62Wr5xnAI9ElTJpe7+OG7t4bUwPR9qV3P/+8BevjDNY1OVqLm0dmzwo4K1IgUbS1Dwk3o0rBZE8ooQ8Hhzz3tpk6ZMSlGrAUZTm0TllwZva1LdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656487; c=relaxed/simple;
	bh=wACXxOya4PuJoEYcY46xJ/2dghudfkHic6V15ZzMdt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyXEw06F1lwm0cKXCcAO7xM5ecBtLmWxvrnLaVsgEobzOggb2WXtq6+Rw02RLnl5xaMZo3NA4Txlfflt2CgOBxiIU7oLnxgtb7mNd/f9YXw3Y85PDQir2Eb9H9/c8CINbuaFb6XBP0265btQBsld4HbGlYuXHYH5YuDRhk1lsM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=ulMSQslL; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="ulMSQslL"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5CCC42827D9;
	Mon, 26 Aug 2024 09:14:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1724656483;
	bh=wACXxOya4PuJoEYcY46xJ/2dghudfkHic6V15ZzMdt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ulMSQslLW2FHf7HUk8dHTfHYo86t1s3WaFGlK9gEwc5mMYBmFDZT93iFHMRFzNWMd
	 KbyA9mLA/lWzTsKLixfABgw4PKYa52ZNQuT2GcZrRphH6Y/8bsynOa/GPFJpy8/nFr
	 akcmH9HNQX8l6RHIOsCu9wKIEXbD/TWFd4yJ1Ez1Oq1JY8pqhxGNr/GCaoFAL7MbYg
	 pFuGVS3S8fThOljH8qeL2rDZGwwWHP3y2ZagD30pqPiljiPS5q8DPmMoCeYt64pFxQ
	 Q1lAeFJuQp24oXtqN7CNAR47OlHhNj2dVQznrG0bfabOCZ2iB2RsLe9mNOdErfMVDj
	 LX6ZWe4nRFbVA==
Date: Mon, 26 Aug 2024 09:14:42 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect domain ID in context flush
 helper
Message-ID: <ZswrYlqb4U3Bq6b4@8bytes.org>
References: <20240815124857.70038-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815124857.70038-1-baolu.lu@linux.intel.com>

On Thu, Aug 15, 2024 at 08:48:57PM +0800, Lu Baolu wrote:
>  drivers/iommu/intel/iommu.h | 2 +-
>  drivers/iommu/intel/iommu.c | 8 ++++++--
>  drivers/iommu/intel/pasid.c | 7 ++++---
>  3 files changed, 11 insertions(+), 6 deletions(-)

Applied for -rc, thanks.

Side note: Please send critical fixes as a pull request next time, as I
usually do not look deeply into patches for drivers which are actively
maintained.
