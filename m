Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F155163D
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656311; cv=none; b=DIgKO1yr4obpU7+3YCreqKPquTS9R0FLi7xvuneS9wQCtHnk9kHeAgwmMK5AIPpVvQ9CqYf8fPvdCWwMCJWlAs2wcbq489SGujQKfDD4Dwuwae0d8LjYoeVwsHCxEyvLQf8HmLs7n0J69DUEnlfraMbDva2yeNw2+gAb1p3B8nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656311; c=relaxed/simple;
	bh=bi7Z8//7vu9sLbagUtW/4VVTMRthL7QxYfDlkeCIdCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ev7NWnZN0ChwShp9WwjFDh/YZHuUDQblTQ9mCIK0QHvvchkn8x4HNzWpuvloC0nLIRgA+O9N5bm/vmSk4ufeiwq/fAQ2ret3Pi0zNxS8LJaBi3/F/7A6LyDjpS+yVeEBfhv3gWoZSZsVeqw6K9P2xaSdzXj4Kuj134tCU1xJTsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=SJ+2y0sZ; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="SJ+2y0sZ"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 232DE2827D9;
	Mon, 26 Aug 2024 09:11:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1724656303;
	bh=bi7Z8//7vu9sLbagUtW/4VVTMRthL7QxYfDlkeCIdCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJ+2y0sZPntw2N3IiFehjKpVBH/FTfVch0NIXqaQi2j1t/3nqntnHnKjzUn4RbY6J
	 ceuAdqVKlm1tc9XZj0XTmFqufob4LAQUTclgsOkEq909RVlByZ9K2BHxVyPJO7WVvr
	 LbFFcsXcx4TLeSOPF7BZrf7e48W/wyBoB1uZSlDeer30t5Tk7vnT7YBL9BaYFRJu2Z
	 GV5vnsY40smPJQ+mEeXBw9e96pQVueyOO670pQDL/9ZbeKLqy7vo85MtlNnZC+5g6w
	 GSC7mJ9t2BirLmFLPo3jbbsD+rfVRul5FaeT2YpUYlGwMSlhTl3OMGcNwYAjqQdLID
	 EbnP1GEXHysfg==
Date: Mon, 26 Aug 2024 09:11:42 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Ashish Mhetre <amhetre@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH V4] iommu/io-pgtable-arm: Optimise non-coherent unmap
Message-ID: <Zswqrmj9PcCz3XHa@8bytes.org>
References: <20240806105135.218089-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806105135.218089-1-amhetre@nvidia.com>

On Tue, Aug 06, 2024 at 10:51:35AM +0000, Ashish Mhetre wrote:
>  drivers/iommu/io-pgtable-arm.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)

Applied, thanks.
