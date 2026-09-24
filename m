Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46042D2486
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257816; cv=none; b=pj5vFiCy5sVQvnurvSJYXm3B2pv5+j+wa8iJNjArCPgnLqkj29n2mYTnjAYMWHX4xEFVi45didpoJGdAq3jIy/ypB9Ko2JnAEZP+u9zS4Yd1aNdV2RyTc2teNrdzeqMCvV6yLtrlLJZpU7jJAaSZ0H2wlm9R95dJEms9VGgEJsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257816; c=relaxed/simple;
	bh=sqM2pxBLcwso9L/qvvKnD+uuvUbt/tXp5U0EdDxtYvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8CvNgK25d7sPpEF3ry6/Ds7qmcIsYEcw40QxVWoZTwkaU8FbdLwXpCfvPauDsbQDyyupOwjuGWgn7UBB+BnkgT544b/izGYnH5fug1yXziWe4HO4hOPKgTCl8zJ0ao9yUY58TtMTpTz/Poz60jigsl95SDRnyjldXp3oUSqNF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00e4ccc4fdbbd66590.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:e4cc:c4fd:bbd6:6590])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id EB1931C7465;
	Thu, 24 Sep 2026 15:50:12 +0200 (CEST)
Date: Thu, 24 Sep 2026 15:50:11 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>, 
	"Hegde, Vasant" <Vasant.Hegde@amd.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>, 
	Jatin Kataria <jkataria@netflix.com>, Boqun Feng <boqunf@netflix.com>
Subject: Re: [PATCH v2 0/2] IOMMU Performance Optimization support
Message-ID: <arUqeEMMaqtJhery@8bytes.org>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <arUMU5QGhb34exFV@8bytes.org>
 <BN9PR12MB51460F3605E485C66760735CF7812@BN9PR12MB5146.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR12MB51460F3605E485C66760735CF7812@BN9PR12MB5146.namprd12.prod.outlook.com>

On Thu, Sep 24, 2026 at 01:01:59PM +0000, Deucher, Alexander wrote:
> IOMMU tree is fine with me:
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> For the series.

Alright, this is now applied, thanks!
