Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CD526056D
	for <iommu@lists.linux.dev>; Wed, 28 Jan 2026 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609619; cv=none; b=BpdMboaVxsxdyseC9W7owVpWNdvbuDuEFekwxOUGf6t0HgEqVP/hG8NBloWe7JqAGISrd9K2Zdn522JrKU8XcDwYr24Mt3MTo1kuZhOl0G5Bj0bx7AY7IjyJYG4FPDJbP6WICCE1ddC/o7xU78kSLd+h1cQZFcaKzHvldjGU2rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609619; c=relaxed/simple;
	bh=sCrXL6CUIzFFe6EXinqG/35+KSraGc8rt8GcXjsJ6mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEE67+v1vOJhDUmtB2bX3QbmiNyROtsw++q2R4lkrXWp1W6eTr+ic4Ozv2VUYV4iqAKu8FvNXMIBvzPI+YBNsVOZ/GoME8XJiMICucMQ8KX9bq3HuP7+QYiK+yAwKM5joT8gYdIuXCtHAb4/Gv+aXZVa5Kok3cOEKFgTn1LKRLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=CiY0wt9d; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="CiY0wt9d"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 278E61C0959;
	Wed, 28 Jan 2026 15:13:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1769609616;
	bh=sCrXL6CUIzFFe6EXinqG/35+KSraGc8rt8GcXjsJ6mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CiY0wt9dR4iRSimcWGHb6JKHPaS32bb2FE/PfeWiq0uyDT+pJsm2fUoVHFK42GNmK
	 CTl/MpbmU8TNn+bB6mKgEOmDExybO9ZFf/ZoPprI53mP/GHFgvtSrUOquYnmVl9Wlh
	 dDvnZVmpp7IzNbjGRU8afO2d30BTt7Z7TgMZMUKZfLvNRoCQibLdaQqIJm92bi3XUS
	 uNECv8QgGCo9UfaIObcMVVvrLqodWnFF4vH3ORDjYGPL57HbdBYHnWv2B8mdcNV+P/
	 fZ/9Key1zIMkFXeiSjei2zK0tOqdaEipXXvQipcgwyCRDo1P6Zh67Ue9g9++5Q3G0q
	 DOHex26I+p9NA==
Date: Wed, 28 Jan 2026 15:13:35 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Fix type of type parameter to
 amd_iommufd_hw_info()
Message-ID: <62hx6oa7ztdnxjd7magfsfqznp2qwordvwxyhd2kgw6rs7oqd6@uhgzcg2o3zfi>
References: <20260122-amd-iommufd-fix-wifpts-v1-1-8ee604527875@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122-amd-iommufd-fix-wifpts-v1-1-8ee604527875@kernel.org>

On Thu, Jan 22, 2026 at 02:42:38PM -0700, Nathan Chancellor wrote:
>  drivers/iommu/amd/iommufd.c | 2 +-
>  drivers/iommu/amd/iommufd.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
