Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1791E2009
	for <iommu@lists.linux.dev>; Fri, 13 Dec 2024 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101723; cv=none; b=eiyc/kPu/+cbTg0RTPkRoQAFHu6vIOQNYRIZ9/qYIuvj3LuinJzv7Y3NwvZpQKYo/CTTUx0bEZr5p7z2kSCMy8Z2qWGW1rSAcLl7O7c//3RR8bP3P7gYN3cmGLw2BJ12fma/QkL36aWs4rxVZwtvlh5baGH3kfuvyvvutRWbcS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101723; c=relaxed/simple;
	bh=Uq0UtrPJtkPl5YhcQm+wtG+5A3qS/qqqSSnsoug1g80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFmWVcUsCIwuFND98NKtWg0nFfZYg40AxgjD3b4HqlFJUQ2+RusH/A/Yxka2HdDmwgQuhRpujEvhQBhXuUJazhik0PAduVA6d51qQ8qHbIGV7kNin+kyCxAEZh7OgRyilUiHS+MVVu4E6wMlNxmd+KnGyQgbsU1clLDRMgLx2+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=G34Poitu; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="G34Poitu"
Received: from 8bytes.org (p54921e31.dip0.t-ipconnect.de [84.146.30.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 156E12C01EB;
	Fri, 13 Dec 2024 15:55:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1734101714;
	bh=Uq0UtrPJtkPl5YhcQm+wtG+5A3qS/qqqSSnsoug1g80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G34Poitugq5EB0y3MkQSL67jfW7YMVRsxGUllzBKy/TTycN+JL1QBMJIbib3uTRuL
	 b40TqlhNqS1udNuHQEwxre7A1Zntl5knye+rXja8Wl0W7kNbVo1oeEYEHWtM0K7r6L
	 TkqpH8xTP9yfYj2BpJu6mzOEfCuH4zzL1seft24Nf5V/ACPLXVgUarif6chXe/T0Jo
	 3AV0kD9mjZlDQwYY4OpXFd+7Oz4qboZOoECEUVKcmiU4rS9HmChGRfU4KOio1je4gn
	 h/pWoYHrJzUcUBVCT4nDLa9NkeidR8qXwDFUpziNyG9AKFQXNMToKMoESv64ARp9ap
	 m4ZepdoeG45cw==
Date: Fri, 13 Dec 2024 15:55:12 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] [PULL REQUEST] iommu/vt-d: Fixes for v6.13-rc
Message-ID: <Z1xK0Jd9K3yVrHj7@8bytes.org>
References: <20241213011752.1177061-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213011752.1177061-1-baolu.lu@linux.intel.com>

On Fri, Dec 13, 2024 at 09:17:49AM +0800, Lu Baolu wrote:
> Lu Baolu (2):
>   iommu/vt-d: Remove cache tags before disabling ATS
>   iommu/vt-d: Avoid draining PRQ in sva mm release path
> 
> Yi Liu (1):
>   iommu/vt-d: Fix qi_batch NULL pointer with nested parent domain

Applied, thanks Baolu.
