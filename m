Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9096718C345
	for <iommu@lists.linux.dev>; Fri, 15 Nov 2024 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659549; cv=none; b=LNcr66KTt1EOCz8tm7kvj5ale59xfcJzKxXR0al0s3X6KVPb8VzW5cj0hhGQzUgJBc0f2CH1/s6Bb89pusJlfAlSnzbvt/TapmorGwXVrxLb4frGO7pmnVm0coyVouEpZ169MyFZCnTM/WDIxwaKWURcKa3u9mQyxgytiJPTabE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659549; c=relaxed/simple;
	bh=ddyxbqxMF4oFoUnh8kdfqjS/EgpzWIB8AfoREuHj214=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smHppRVs8VnZ4+Ogelh7M9UDeGZ8mdsEOl4OawdgRepmspLkqorLnvjWOCJXquvtD7yuMWzXREzcircUI/NoVlcsHaMcedJvdVS8QvHRVoliD5bNdEmdP+hPVwU2JgaCcpboFcnwwzcvrsOcmUM9qLmgo9Wq5z82WhnwxfpkFKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=F2vwKLTn; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="F2vwKLTn"
Received: from 8bytes.org (p54921e31.dip0.t-ipconnect.de [84.146.30.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 014DE2C1435;
	Fri, 15 Nov 2024 09:26:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1731659180;
	bh=ddyxbqxMF4oFoUnh8kdfqjS/EgpzWIB8AfoREuHj214=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F2vwKLTnRedZtouBv7ykR8mVjofKq/jjctu8ciEhMsAxCR/rScmyH+Uvqor2b7qfu
	 Omz7FxHMijGktUpxZocWS1X2I+SP3bRoYzuSq+VFxZU9CbUHOGgIgYiEysX30c7uKc
	 NIJ/f8Id/s1JBmXCphPlJpNidMcmiesQ4FG1MtSaXt/gJEAxR1ZFQnReeG3VD033OF
	 FuEBXfAXa6lebusYJs1bwvVgFEQXQhQo8v1RSbNCBNMF3voS70+e8j+yj671riozv7
	 SfBDB3TobT/NGDoLEC8Shd8spTjbNLigVytSDleNd+gwjxijUSXBKVIusk2hm8gFUU
	 tzoDm/T87s4fA==
Date: Fri, 15 Nov 2024 09:26:18 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 6.13
Message-ID: <ZzcFqvfa6BoFBiE0@8bytes.org>
References: <20241114171808.GA24017@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114171808.GA24017@willie-the-truck>

On Thu, Nov 14, 2024 at 05:18:09PM +0000, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

Pulled, thanks Will.
