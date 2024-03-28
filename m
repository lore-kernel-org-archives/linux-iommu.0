Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DF045957
	for <iommu@lists.linux.dev>; Thu, 28 Mar 2024 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711604252; cv=none; b=oxYHmMl41r82tYH+TWn8AdvvTa0Axgg5jPG6Yr1iQo6iLoIE+CxGHVGIt7y+YPZk8mrccvyIiTrCB/R4WD5N0bNuYpGyPOBG3ft7HE74mw2K8hZ1ZG+PzXf3iJh4HW4oDWwTaM1lGVLkDi6528EZMVN7/aD7nsfcL7+d9/XidX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711604252; c=relaxed/simple;
	bh=zA0sQ5lqjv7OoNTN8I18ArieYI10QoG2cgk6L4+07+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChvXXQ8WTD1Q1GBspL26FEwZd5gO0icpSAG/bvbrZ4IX2HWbG8QJRxNJVqbjQPFdMamaS7eTGMfnf8XVoiiQRA3KJ5HPPIXhbKlSNt9GdbPK7YitDHypm5x9hL2e/OMdJAU6Qd0eHLzNXF7D8luAR/JdrH0TlJSDcmfyiH3QVtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=RiYCCzYb; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="RiYCCzYb"
Received: from 8bytes.org (p4ffe1eea.dip0.t-ipconnect.de [79.254.30.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0C11E280F7D;
	Thu, 28 Mar 2024 06:37:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1711604242;
	bh=zA0sQ5lqjv7OoNTN8I18ArieYI10QoG2cgk6L4+07+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RiYCCzYbspGp7fe3esU7bz5KgcNmqh0aBu6sJ9P0wovHaJ3RLqtZ8N7TOTLcnhW4s
	 h2Dy3/ETTyVOjqd8Htc67YZC30DFUVA/ddEnECJlHw0YqLlaIcCFsRGt+74wT964sO
	 lcHzrq7WtIE97ubvmb7HdANHbjE995Cq5ecB2HZhR00E9DX8vWoqAbPM6zPYHGGko9
	 vBchvqAl96K4zR4JE1iVyy91HX1vESLZXy55F5CW5A1rkPf6uuiT7WxH1mWBSXJ+kk
	 k5wYLA1fSVn04ecR0J0noO2IWRq3Zt8nNgePYwF43sJBDnkI4gFom3PhPl7z3h/Rpn
	 pL7gmvp8eQwaQ==
Date: Thu, 28 Mar 2024 06:37:20 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Fixes for 6.9-rc
Message-ID: <ZgUCEIpXB_7rDoNz@8bytes.org>
References: <20240327181310.GA11801@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327181310.GA11801@willie-the-truck>

On Wed, Mar 27, 2024 at 06:13:11PM +0000, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-fixes

Pulled. Thanks Will.
