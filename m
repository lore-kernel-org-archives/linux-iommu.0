Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704312505AC
	for <iommu@lists.linux.dev>; Thu, 17 Apr 2025 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900285; cv=none; b=aWkziu/VT6LznmGONZZRoLg41a6mexREbKg14iP/DVYgsIlZwLT6jHvLPDuE5ho6GbZrYIdf4rJyAa+cag///Ukj1muG5rZ2ZnrnNnBoupeid2Y9qcMx+Ek4wCbOkuIfONuO2Glzrzr/K4rqSUrr0xeOFnclcyNiALWqS/Hgecs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900285; c=relaxed/simple;
	bh=nQB5PNCIQk9merMoLxRO0GWZ8ryzk5fmi6lfCG9dxUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOLAeCCcRr2JH5wXoxupM85GCFGbAfG1uetH1oJfGWvm9OYp0DaQcMt7KQXPGTRXUrXVZSE/7QiKrOMXIsZcFp4SD+yZzWCNN363/UuHvmMQ+XAd/NOB3Uo6zi2peHeUYh6PSBp5QShJ6aB8mjjcFb3tr11tGEEadHAEBWjAOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=b0jdPbi8; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="b0jdPbi8"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 68F92485A8;
	Thu, 17 Apr 2025 16:31:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1744900281;
	bh=nQB5PNCIQk9merMoLxRO0GWZ8ryzk5fmi6lfCG9dxUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0jdPbi8t6a38UxohrJnVZuQTk5GR5qX7YVExFhXYPcninjUs/wwZFDwnmq+c2phM
	 gH1tnmZjqTosilZJ/IjSi1Fz8PZxoTip0kluYoxBfYNc5SN5MYfirN1O7Nn2mbIVyR
	 +ETrvTxa1kxksAaYkkhkN0TT1iz5NQDDLG660QtH3hP2rIqNRWt6gUR1BGyF1KKIiM
	 fAck4XEIa21Ii6QTB/nnbleQNZMGOdf6Yc6jkR8p4KMezszvusxHZHjmD3x8W09oK6
	 7bW0g+vgROrKFqupw2bc3/71W6tGzUz2ImluINmi661SdKMYHh2MG3ccpdcaeEC3GN
	 Ze5+mqEH0Jt6g==
Date: Thu, 17 Apr 2025 16:31:20 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] iommu: Avoid introducing more races
Message-ID: <aAEQuNrweMJSrI8O@8bytes.org>
References: <09d901ad11b3a410fbb6e27f7d04ad4609c3fe4a.1741706365.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09d901ad11b3a410fbb6e27f7d04ad4609c3fe4a.1741706365.git.robin.murphy@arm.com>

On Tue, Mar 11, 2025 at 03:19:25PM +0000, Robin Murphy wrote:
> Although the lock-juggling is only a temporary workaround, we don't want
> it to make things avoidably worse. Jason was right to be nervous, since
> bus_iommu_probe() doesn't care *which* IOMMU instance it's probing for,
> so it probably is possible for one walk to finish a probe which a
> different walk started, thus we do want to check for that.
> 
> Also there's no need to drop the lock just to have of_iommu_configure()
> do nothing when a fwspec already exists; check that directly and avoid
> opening a window at all in that (still somewhat likely) case.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> I was rather expecting to send a v3 of "iommu: Get DT/ACPI parsing into
> the proper probe path", so I'm grateful that v2 was picked up, thanks!
> This is the difference as a fix/squash commit instead.
> ---
>  drivers/iommu/iommu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied, thanks.

