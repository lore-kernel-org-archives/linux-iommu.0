Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A41E1DE5;
	Sun, 26 Jul 2026 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785069841; cv=none; b=fq5VGJi3E4LoeJUg8hynMJ45rLEI0BU87173tmDCITxa/HVWxNZOU0/7JMW+IVjUYD4zJxZ5YOsB/Dcrjz8s6dlHEVH8MzeOKEmanWG5CUUxhXzBxUFblOc5eLiE9HyaTNM7bvzPSvqjJvC4emtWBembitzjxfXeqKT/Rx1z3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785069841; c=relaxed/simple;
	bh=OzKGnA+YEF8DnyI47P1HsjO6elviNRPx0AzggwgUKFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBAbVvgZ5aTitGwUfosU0j1mTfixXddffdteTl1QIUaAz1bM6AhXVX9Cz+jSipBN4fUOZLtvsSL1fopUx6h9b15EPLGab8zYX5udAcsR3NskMU/13XXXTsrvAslhkt4cP2xhBkmJG1hqEZW3J5t0nL3eq7snbVL+TWW7TrYvhHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Koj5HDak; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Koj5HDak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8911F000E9;
	Sun, 26 Jul 2026 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785069840;
	bh=rgLZG4JLdm3gk8eU6+A4zCTg/+L4HRX9Lac6zEzsmr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Koj5HDakuNuDL4HXENmzkQ5WUYsEW7kfKaiufcuiwWLets4/CffkmRKoMu9gHete5
	 wKzsF6Rh+2jj4Tx4dnxRkpzVUTttkpCWGbTwGIvsBya7EnL6ThKMFVdexRN3sn0VPg
	 GF2GB8QRPdCByxHS6uDdfZGfTrVfDxOhwrWKH25Qt5BGElG+eZqoOv3/ec78k3wico
	 kB7TLYJ+5YielD+UZ6S33MotViPxPXXAOzjMrAikWTk1HGMmlm9Wt5PHcinedaGCYi
	 PtBYF7M3aut5X4U83awO5HR10eElFjSTOumpPJpc8cQE+mhu1YEvYnYr3tGmSKEX/M
	 QpXD0OfBPJ8Dw==
Date: Sun, 26 Jul 2026 13:43:55 +0100
From: Will Deacon <will@kernel.org>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: joro@8bytes.org, jgg@ziepe.ca, kevin.tian@intel.com,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v3 0/2] iommu/iommufd: Fix IOPF group ownership UAF
Message-ID: <amYBCzc2dfH8A6Mo@willie-the-truck>
References: <B474F106872C2E5C+20260718043239.3898247-1-peiyang_he@smail.nju.edu.cn>
 <B0FDD4C32AC66FCD+20260720085017.3998878-1-peiyang_he@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B0FDD4C32AC66FCD+20260720085017.3998878-1-peiyang_he@smail.nju.edu.cn>

On Mon, Jul 20, 2026 at 04:50:15PM +0800, Peiyang He wrote:
> This series fixes a UAF caused by an IOPF group being owned both by the
> generic pending list and IOMMUFD's userspace fault queues:
> 
>   1/2 Minimum fix: dequeue accepted groups before IOMMUFD queues them
>       for userspace response, then remove the check on list_empty()
>       in iopf_group_response().
> 
>   2/2 Refactor: make iopf_group_response() free the group as well
>       after responding.
> 
> Changes in v3:
>   - split the v2 patch into a minimum UAF fix and a follow-up cleanup
>     (suggested by Kevin)

Oops, I lost track of this as all the versions of the patches are in the
same thread. Please try to avoid that, as it makes it hard to track in
an email client and can also confuse tools such as b4.

Anyway, it looks like v3 is ready to go. Jason, is this something you
are planning to pick up or shall we take it via the IOMMU tree? It looks
like patch 1 should go in for -rc.

Will
