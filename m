Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06301459FE
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 11:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501847; cv=none; b=FKf3m5Esd/J9pXWYCCcK8ygc6OaJtFprwef8fzjpNnJhsKiFfcEDmEubPKNK4suBRA06DUkwtg8VGdfJPegl+/gIfIQzeDM2xhoKno40Lt9xR8Q4SWX7UXE9d+9PzagQJbabng8ZRlOLAm2N3wx7VQVMBVjDAAHz/TQ7DEr7Zbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501847; c=relaxed/simple;
	bh=fV3BFykiJp52kE4KHDpVbW3pwpaJRnmS10SClWg01aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMJ7dmqrGVQCYC9D8TrfY69vdTGhCv3O57n5zrlzFHHpgxmCdweZcXNtFWQDy3L2FPZ5AW+L0hg/OM1sUkCOAdrURxvbRpfbZewJ+M9K8on1dPwXvovLmSHv8U9b9TMYRrwX4MOvBy4HOj8F15lth07zflWGGlHEav4ZECC2azg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=3OsR7neS; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="3OsR7neS"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 62B881C7AB5;
	Tue,  4 Jun 2024 13:50:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1717501839;
	bh=fV3BFykiJp52kE4KHDpVbW3pwpaJRnmS10SClWg01aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=3OsR7neSntHacV0WnO+WOG+KIgcCuGlDw8Vrg2ORGN+HBR7SoKA9g4g60xUMrOZnC
	 cwvkOZRxYlKy4tchm5ZF5YQlskne99JYEr7h91l2w/wopZU/WJAalTXPJ2RvSVLiJO
	 XVJcJzL994oAs1MBFAdtW8vkE8DehPNCU9ZwHN4P3ksA0NhwFQAKBSRdW2hpA7k75Y
	 wqONyYedm+j056R14u0f5Q7WRfb8FyVhM1X/ex0XQdwo+UAm/LRVD4irxZFO549Km/
	 3ZCb4E3p9o2RZYMsBLsoLZ8LkFlmI6xpqt2EyzWow9Rkqpka3T/9TrxEaj+6EShue/
	 AhDBAw7WMnW1g==
Date: Tue, 4 Jun 2024 13:50:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Kun(llfl)" <llfl@linux.alibaba.com>
Cc: Will Deacon <will@kernel.org>, Jerry Snitselaar <jsnitsel@redhat.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/amd: Fix sysfs leak in iommu init
Message-ID: <Zl7_jphVNJiFZ0_o@8bytes.org>
References: <c8e0d11c6ab1ee48299c288009cf9c5dae07b42d.1715215003.git.llfl@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8e0d11c6ab1ee48299c288009cf9c5dae07b42d.1715215003.git.llfl@linux.alibaba.com>

On Thu, May 09, 2024 at 08:42:20AM +0800, Kun(llfl) wrote:
>  drivers/iommu/amd/init.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Applied, thanks.
