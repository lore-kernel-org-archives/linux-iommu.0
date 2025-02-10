Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8109221DA9
	for <iommu@lists.linux.dev>; Mon, 10 Feb 2025 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195404; cv=none; b=LgGaL39q5/x5teJfMKVqUQhnYZiYFJGqzzUtN+y9hQ8gEK/w25zegIbVyjaw7Mma1sqEVCRcA69pdBlrlGzWFms0jA5Ael73mnCmW8ezQmJCNgzz3kk6el8dtSkkDaBYnvkEBY8HUjIEXpws9Ls60UucJWN5yaPW9T53d0dv5MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195404; c=relaxed/simple;
	bh=Q8pMVPVH/swQN/oLC8egncUbTTHiJvnYXIjd5iftl/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEGa9le/cnpkHLp8A+XKul9ARiFyjXbQqj8cNZOO3CdVUuIImqlghY8WcSpC3pAjnQnV5lENSNIHiundMtJ1DWhh9NawdC/PW3wTD68c3KQe68nRMbt+3b7iLDXd3jB0nPs+22R7GpBgmW+l0xLixQ/LXPJHQx2u4Wk33qXpOuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=paaSxyM4; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="paaSxyM4"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D2DB941FE2;
	Mon, 10 Feb 2025 14:49:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1739195396;
	bh=Q8pMVPVH/swQN/oLC8egncUbTTHiJvnYXIjd5iftl/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=paaSxyM4Dzqqh5VpDUsBk4lf8T2kf5QgfJV8KyD1C8UFGCuucf5nXye9SBbmPjPQe
	 fEHU/E+jlQf4LJwlKDVA1TXlFdFOm4z6kQEN6ye+lU7mHm4BfpgQdDSAlz1Je4ahzo
	 lQvx1aOmOsZD3E4Zo5ONMpBSnCkGbtGUfaPKo7EXNgywYYC2Ca+xuB47QtN8W7lfPd
	 1GN4pUhXV5OXqwVunRJw2vev9DS+7+v7bnKRN1YgldwxF1edGT3wqBcEl4BjewG7jG
	 kFItWrN/jx9N1bEAPNrM7aXsZFj3flH2PiLTNksnArtnOkhI69b4coZtghBk5+u8ZJ
	 ev1j1EKLnlpvg==
Date: Mon, 10 Feb 2025 14:49:54 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Fix potential memory leak in
 iopf_queue_remove_device()
Message-ID: <Z6oEAnNTu7Q8yM-i@8bytes.org>
References: <20250117055800.782462-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117055800.782462-1-baolu.lu@linux.intel.com>

On Fri, Jan 17, 2025 at 01:58:00PM +0800, Lu Baolu wrote:
> The iopf_queue_remove_device() helper removes a device from the per-iommu
> iopf queue when PRI is disabled on the device. It responds to all
> outstanding iopf's with an IOMMU_PAGE_RESP_INVALID code and detaches the
> device from the queue.
> 
> However, it fails to release the group structure that represents a group
> of iopf's awaiting for a response after responding to the hardware. This
> can cause a memory leak if iopf_queue_remove_device() is called with
> pending iopf's.
> 
> Fix it by calling iopf_free_group() after the iopf group is responded.
> 
> Fixes: 199112327135 ("iommu: Track iopf group instead of last fault")
> Cc: stable@vger.kernel.org
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Applied for -rc3, thanks.

