Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E5B1DF269
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 06:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751007122; cv=none; b=PxF6HXi3srdLqSHL+0H/y/YLJVE+2wYJmgxRbfZfm854z1/Ca3PgMHFHQ9Uu7URu6nT+0zOJlnWG222ZW/iQ7ovJaGGoJqFNEftQyDJBkhvTde9OPoSVPjEOPHb3ZP9cXKD5Zzu/r9VzWnRpVJRH1/8b2bNVCLVM4vCTcoXDUjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751007122; c=relaxed/simple;
	bh=J6roTKu1LZFed1xB52SQWNskYxrd2HsCYTIfh1PHGS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRr7qv9wEOHpACDsq1Y6CW78GKyhEEfecapLK9sUGWIFErmQMq5WK2It9orDsKFKOLrge4u0kin77ri+VPpJSNl5puS3Ageur4aJD6Ydo+GT1NA+pm/BY4d917Q0CMcI3pfHSjVuZDDn2CQjHe/8i3zxpfqOCdTgd15rRUFlX6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=xDmlrwrZ; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="xDmlrwrZ"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B25884D686;
	Fri, 27 Jun 2025 08:51:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1751007118;
	bh=J6roTKu1LZFed1xB52SQWNskYxrd2HsCYTIfh1PHGS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xDmlrwrZJLnxdDF37cRxA6WNXwJcDvP47zLr6qKal0uun3CiexSQN/esm0OAPFsHR
	 6Dy6EaWro3884mCYqwXcZoO/HgERTM6/ObzNUiZQa1XwmCUitrKq3F+9xNORNuXyDd
	 QjzXpMnxE08a99hYtY6oS14X/4Xk3SLj7kn7aYDs/Dd1EoXx0A7X1qcTuZnVnE6Xyn
	 Iw2BCNSx4BeZgTH/bp5eCGl0GApPcO6rxHE1ChmbMLsj+NC8Wnrh/FgHQVc5/rSTiY
	 Yma4ArUbPUe1V/YWe4/ctjfQS7AVsYgJYvwKTJoG4YeGGNQ8YHn4VW2wi93924u6A3
	 LJc5xdWZUtLZA==
Date: Fri, 27 Jun 2025 08:51:57 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, vasant.hegde@amd.com, joao.m.martins@oracle.com,
	suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] iommu/amd: Support for HATdis and HATS features
Message-ID: <aF4_jfApBmuZq5aB@8bytes.org>
References: <cover.1749016436.git.Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749016436.git.Ankit.Soni@amd.com>

On Wed, Jun 04, 2025 at 06:13:23AM +0000, Ankit Soni wrote:
> Ankit Soni (2):
>   iommu/amd: Add HATDis feature support
>   iommu/amd: Add efr[HATS] max v1 page table level
> 
>  drivers/iommu/amd/amd_iommu.h       |  2 ++
>  drivers/iommu/amd/amd_iommu_types.h |  7 ++++-
>  drivers/iommu/amd/init.c            | 47 +++++++++++++++++++++++++++--
>  drivers/iommu/amd/io_pgtable.c      |  4 +--
>  drivers/iommu/amd/iommu.c           | 15 ++++++++-
>  5 files changed, 69 insertions(+), 6 deletions(-)

Applied, thanks.
