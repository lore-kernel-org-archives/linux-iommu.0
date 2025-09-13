Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0F71F03DE
	for <iommu@lists.linux.dev>; Sat, 13 Sep 2025 06:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757743850; cv=none; b=HiqQVzv3GRBDSppaa+x/5SgdK725l7kixQblvR6q4fWNz99+prCvOa5tEammyazMnUb7EX4YWkBPIpBBX70R6Uyo8ohJDgtKjSKlvvlUalA/Z6osI2tOXrCN0TNHd5872lA6hte6Nn+SKxBA8hwUz/FeCv5rlpV6nEfawAWlQnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757743850; c=relaxed/simple;
	bh=+wvFGS6uqzkckuB2AHW2uu89uyY0X7k6QNEhSYv9PuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWF+c/O0cSZ3wxwCof3FittyvS6VUbcEAwkHgFf6goVQ878g+t0eEt2a17EwBacyrHAS5DYVmtG5nhR2hfSAGBV55WT9gqXrh9SM86vvjW5CJNdX+/Zs13jWjjva97cOAt729CewWcvm6SEAt1k3kUslcoKHrdAf6YLQ+Lm86lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=dLk/m294; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="dLk/m294"
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3E9F650666;
	Sat, 13 Sep 2025 08:10:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1757743848;
	bh=+wvFGS6uqzkckuB2AHW2uu89uyY0X7k6QNEhSYv9PuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLk/m294COsltbcegL91FhTeiyIPMhux6X3wolTYRCeY7QJ+ulDEODnQFoWPtl2BQ
	 VlncaRWLWE+pn/R6isQaMDY5xPT0Z+1GEX7+a4Ym+rjE3+FIbHIvd8ZWgl0OHMgxYP
	 caiLksSbEQN2qvlEXbEtyExe6veLbft/OSv5skQXJI7/+M20xac+4SYnBNbnROEVnK
	 9ku6rCvOB0gq0tkN4GZ0YoKcWYuTY+MiD7TuOBrEJHngRcUp5uhKriIHfzvDNsnb4O
	 6WXdVVtE7zuP6atIQxwGBiCwxLaoqFEeQRXhPTfFaHCWaiG+YSn6fefeyUVjMDGxLB
	 iJwgUPyh8CCZg==
Date: Sat, 13 Sep 2025 08:10:47 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com, 
	suravee.suthikulpanit@amd.com, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
	stable@vger.kernel.org, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH] iommu/amd/pgtbl: Fix possible race while increase page
 table level
Message-ID: <sizw3br3mzal4o5vej7njvnjxsd5ego37zw6ejsh5fufxdr36n@ubrpt7sxsn3d>
References: <20250911121416.633216-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911121416.633216-1-vasant.hegde@amd.com>

Hey Vasant,

On Thu, Sep 11, 2025 at 12:14:15PM +0000, Vasant Hegde wrote:
> Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Cc: stable@vger.kernel.org
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Can you please send again with a Fixes tag?


	Joerg
