Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C9D35DA69
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790320806; cv=none; b=G6UM+PpcepkJW2DXud5I99OZvCiYfabbtKV1V8QI6U0Udfzrz9tONjjG9H78Lwjk/Cllgsoyss8V/Rz6iQtQARK8DLWXeeIsoX57pd7SOB7jIMIB/NlkOmRrfja7J4N1GwGuEzTkMMdIsPZ3SFqb9szBoqn3jL+QumNWk8tpFUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790320806; c=relaxed/simple;
	bh=XKMMPA8Bwl5kY5YuUnk3tw05uq3rMEfe/JStFyIHads=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=io895JrtBWMx7hjM29WYQ70QIQ0M4MS3yOLQCQeKeMCu0++pXkjqN8E7B3YmiuzxjWMNwiuO++79lrECak2dAAiq7xgRiRwCRlS3iXhurJ6iufauAAapV+k3FFRyznV9iBvQ0S0wQAOlHKstuaEHJUF47ZVXqoMWvlqW0bVdbC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a000b03c3c046b119f0.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:b03:c3c0:46b1:19f0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8E2571C7759;
	Fri, 25 Sep 2026 09:20:03 +0200 (CEST)
Date: Fri, 25 Sep 2026 09:20:02 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	"open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>, Jatin Kataria <jkataria@netflix.com>, 
	Boqun Feng <boqunf@netflix.com>, "Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Message-ID: <arYf3iJW7hfTua__@8bytes.org>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
 <20260924225018.GB16465@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924225018.GB16465@ziepe.ca>

On Thu, Sep 24, 2026 at 07:50:18PM -0300, Jason Gunthorpe wrote:
> Why does the GPU driver have to request this? Why can't the iommu
> driver know that this is a special device that can use this magic fast
> path and then auto set it when identity is asked for?

This is a layering violation either way. Either the IOMMU driver needs to poke
into device details and their relations or the device driver needs to poke into
IOMMU details.

This is not perfect but to some degree unavoidable with these highly integrated
SOCs.

-Joerg
