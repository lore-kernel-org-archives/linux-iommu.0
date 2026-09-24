Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330803A9DB2
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250840; cv=none; b=lP3pxGgfp1wwuPaPGg7a0+fCVpssquCEy696kExOf5fKdXvbbLu4M6STsJQQqkFHvJC9yrbKtBOeREBAKF8DKlZx6eOBbBjuRR8E/wt4UNmethEww7ZDpqOUeP81KhumdTY3xyzU3l2h6oC62wLtgygXFRLKPn6JyDKWQ8lqW8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250840; c=relaxed/simple;
	bh=mdsFrPdEsb+V6LfjSVlRSimyPe+x8E4CTNfJZCg9d0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZGHabF+H+2MDf/QzeJdzDLhcw7UH4da0YrhFmBqgwHwqRZHdA/zp6UrmCGscwVrJSpbnMPsNL0rX07M6k2LXJQFPSCVVDsF8kJBZuORDgGR20Zco98h1/yw77VbsTqAAmCt05QXY2hA56Fpjxj2/pv+aGjHKKbJEfyZN3tVks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00e4ccc4fdbbd66590.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:e4cc:c4fd:bbd6:6590])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 33C6A1C7465;
	Thu, 24 Sep 2026 13:53:58 +0200 (CEST)
Date: Thu, 24 Sep 2026 13:53:57 +0200
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Federico Parola <fparola@amazon.de>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, nh-open-source@amazon.com
Subject: Re: [PATCH v2] iommu: Finalize deferred attachments when mapping MSI
 pages
Message-ID: <arUPRMvP6TW7BzLk@8bytes.org>
References: <20260910150517.95239-1-fparola@amazon.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910150517.95239-1-fparola@amazon.de>

On Thu, Sep 10, 2026 at 03:04:47PM +0000, Federico Parola wrote:
>  drivers/iommu/iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.
