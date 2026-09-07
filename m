Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4978448D87A
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788784666; cv=none; b=eYUM4XtnBVX7veq8Ch0xHDipuRYWHzo1mazBkBqTcZ4dbSi7pUbL7syobA9a6WpNMHArabxQkgVU1GfOrE19surrZEMhFFqxLJO9UnDS4PsSNEMxFjQ5Nm1hnNE6a54IXAAktaTAK9YHy/W/4AxKJYyBJ9bBzqx1TWif0mkJiKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788784666; c=relaxed/simple;
	bh=u1HCoryUvUamRHRurn05UhtJvMgi2u95SB3zP+hEaF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czXg7qUOjHuq2Xg1TxTTXkIi11Fk1f9hbQeh+zHarkl+4EpyOSwaZRkCMYFdO5/c1w33msh6wTZTXxlqBcEwVyCB92lXlXqq1cAWRhm0sAwqt+4u0GlLPimI1Ebj+/OuU4PXNwMtuaZO6Nni9WJKuFEZ6N7fPSu+6iq68PaWgSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af085a0015db8e28914752a6.dip0.t-ipconnect.de [IPv6:2003:f6:af08:5a00:15db:8e28:9147:52a6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 631AB20A08B;
	Mon,  7 Sep 2026 14:37:44 +0200 (CEST)
Date: Mon, 7 Sep 2026 14:37:43 +0200
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Will Deacon <will@kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Do not reallocate GA log buffers on resume
Message-ID: <ap6wBSv3MpUYDTBb@8bytes.org>
References: <20260819032349.20354-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819032349.20354-1-kmehltretter@gmail.com>

On Wed, Aug 19, 2026 at 05:23:49AM +0200, Karl Mehltretter wrote:
>  drivers/iommu/amd/init.c | 5 +++++
>  1 file changed, 5 insertions(+)

Queued for -rc, thanks.
