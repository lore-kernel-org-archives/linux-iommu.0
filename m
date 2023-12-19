Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BF01C282
	for <iommu@lists.linux.dev>; Tue, 19 Dec 2023 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="yLe03hwY"
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3730B1A41B9;
	Tue, 19 Dec 2023 14:36:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1702992979;
	bh=qEiFDFyHHqNrDJIWzK/qbzc5nqK0cAHzUfi3LnsdtSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yLe03hwYW6l47DBO/sqr/tAim6QT0mU7Nb9GnX0ij5aVdEY8vQnzubJTsM46fR30H
	 XsEguQF85AMTY7eGd9J8t9WkloY2/ANkr6JKE1m1pTq+4j3Efh1ogmU36bbpcEpErb
	 OSVi4QpFq1R9qcIinBNMSddwRaBH0EgelnP2G/3w4I4SPm70BwE5BNjeJmuJ6roPPo
	 AvFr/i560QFYHvvuQcHOWPdHCMMAY594BnWZ6M6vc8zLYh5LJ6ftFMV/L6+I7JxzT/
	 GVVusK4F+fVVicepqIqKM3wEqAIAMc9mStQjy2FwTXE/RpEtLOd+vziwtY7V/4/unb
	 YQAzUQZFZHWNw==
Date: Tue, 19 Dec 2023 14:36:18 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, treding@nvidia.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH V2] iommu: Don't reserve 0-length IOVA region
Message-ID: <ZYGcUtl_LfqVOYZK@8bytes.org>
References: <20231205065656.9544-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205065656.9544-1-amhetre@nvidia.com>

On Tue, Dec 05, 2023 at 12:26:56PM +0530, Ashish Mhetre wrote:
>  drivers/iommu/of_iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.
