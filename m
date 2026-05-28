Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B2227EC7C
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 07:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952086; cv=none; b=r54Sx5KpIBFtHFs/4zaJ/d7p71cxGTMbfogNqRpARt/exDrJM31EKvF2tPmxJah3jExGQDjfz0IDEDButC2jxYbc8SiS9FcRatgda4TxgI0J3O5EFW6dI/VZAr9ftZAR5lQQ+7u/Rft1lRWZ8Y2l2Ad99MMIGPO+dJZjJ9tWDyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952086; c=relaxed/simple;
	bh=kNIWDqV4SY6fBpLdgqVQI1H22bn6s/T4zvwSf9O1RyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjM7lKYzrx4nZFdAH9I/9IOeZ7EfGwr91PfoIiKZRl5AaG9G33n1M2nuHcvMSY1uFS7fIs1LJwoJtlWOnG4g3S2pYSbv/mybLRuAKeQKsLa3FY+4yhfNXRmG/2tFGmkUX0tR5gx+xDzoc1c23FAlIq5U0gXdU5qfEqlwRfwDt0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc5001a5b4667a2accba1.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:1a5b:4667:a2ac:cba1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5CE6C1C6014;
	Thu, 28 May 2026 09:08:03 +0200 (CEST)
Date: Thu, 28 May 2026 09:08:02 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Will Deacon <will@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, 
	stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] iommu, debugobjects: avoid gcc-16.1 section
 mismatch warnings
Message-ID: <ahfppCn5z7Fcog9F@8bytes.org>
References: <20260513145425.1579430-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513145425.1579430-1-arnd@kernel.org>

Applied for -rc, thanks Arnd.
