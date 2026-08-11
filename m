Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373503FCB11
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786431811; cv=none; b=I/TO9SsShDLPg75czBo8tw9+/4Fbe1g8L+fxCze1+qdjpdtg+InIJbwGypi8ySs5vDEDbZxCDZIg8E6UQpBbPn+nezA4b2Y0KAZwf43uQ/w5IZVY369pJFkgaCUoUTfsm5U7qNSd41fgD4vtf+yXmKbjgxmdqzaOD59nKx4FUBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786431811; c=relaxed/simple;
	bh=fKa1PocgN2utEpKDdgQhwOQ1EK/kE9bPkkdCDfUdLgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsq7hT+BAlpoxqzI/l6yjUt1ZGknhGHptmTAMR7HBtHCnTBkQk2i689pmtw3yMOWApHI4w6bwGssTqCXy5woBHCNkv+HVEmC82HW5JVcYGVh4Jk8+oJAEz/zCMfc/FYxVQ6ulrr6atckCh91cFuByUvkGSymnon3FMBJ19KM6Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B50092077CC;
	Tue, 11 Aug 2026 09:03:27 +0200 (CEST)
Date: Tue, 11 Aug 2026 09:03:26 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com, 
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v2 0/5] iommu/amd: PRI related cleanup and fixes for v7.3
Message-ID: <anrJMVVf0e-qBlDc@8bytes.org>
References: <20260811040900.8572-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811040900.8572-1-vasant.hegde@amd.com>

On Tue, Aug 11, 2026 at 04:08:55AM +0000, Vasant Hegde wrote:
> Joerg,
>   V2 is rebased on top of iommu/amd-vi branch (Commit af3b69b16383). No other
>   changes.

Applied, thanks.
