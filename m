Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E66D3630B9;
	Thu, 30 Apr 2026 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777568051; cv=none; b=YhFurqRl/nt1MJuxakigGFh/RDEo++00FfsDoAqDW3G3kJRSM8aqWXfOVq/1iU3Z1OEVdRd/b0zFTsHNVHtl9U+QW3vmCEhvTbw+RnRhlDFY3PRx31rkk0pMG5c17vBDQIid3C6h180msEvvIziTCRfYrUi3P1suwCQ+rII1Jgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777568051; c=relaxed/simple;
	bh=Xwy9ItNoNlGojpq90kIymchVb/O4TPz3/flNrOwTupw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ew2cEkEVknMxkQ5Wme98RA+JCYphejDVFXia7g8x1vmK6OPhiJzywfCEf3C0krgOv4fFaun0082CqasvrJjKlKYwSx55xGu2OwT5XvMXDk/0d4kgUKGm2xi+zfhY3U45IjqbCE9t4hxRV9mf7/o98w6AGb6/2iAIGrTaaPXz6Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qpEholPY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qpEholPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC37EC2BCB3;
	Thu, 30 Apr 2026 16:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777568051;
	bh=Xwy9ItNoNlGojpq90kIymchVb/O4TPz3/flNrOwTupw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qpEholPYTgYCq2orge2fNokL2EMDbL2YX2P8rfE2OJNUXs73S8VWCsoHjryS2S1dA
	 SFnf4o4E8U5yodujID6hE/uPAwvtCWnX/ZYTyhLi3LgReV2z2ZKfa9QEcBCrBB6HDy
	 4elycBf/ZIfaXF09TbmEubuezH53aLWf8bfuK8Rg=
Date: Thu, 30 Apr 2026 18:54:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SnailSploit | Kai Aizen <kai.aizen.dev@gmail.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	SnailSploit | Kai Aizen <95986478+SnailSploit@users.noreply.github.com>
Subject: Re: [PATCH] iommufd: Use sizeof(*hdr) instead of sizeof(hdr) in
 veventq read
Message-ID: <2026043056-acclimate-errant-c285@gregkh>
References: <20260430154100.61604-1-95986478+SnailSploit@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430154100.61604-1-95986478+SnailSploit@users.noreply.github.com>

On Thu, Apr 30, 2026 at 06:41:00PM +0300, SnailSploit | Kai Aizen wrote:
> From: "SnailSploit | Kai Aizen" <95986478+SnailSploit@users.noreply.github.com>

Again, please use a real email address.

thanks,

greg k-h
