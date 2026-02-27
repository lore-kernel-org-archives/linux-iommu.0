Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5BF2441B8
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772196354; cv=none; b=MTtEJumuMjCxo8Fewh8tLCvkgy+K0YlqXe9Rvo7/btRhiqEwITECcstxCcInLq8TYvKItsXzq1gEAVVOcA7b6ZsD/E7ebU2BgdpQ+AVZYAVM8CgiU9h7K7eT2fRHsiGmJfPl0oocTcjj5wyCEL1HKYa2KQRyIQqCi++wApUkNZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772196354; c=relaxed/simple;
	bh=XYqiA+MVxyiYqtCjbATwaQe0GRWI8xti11LZmoNBBwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcje/AthSHSJFuJ1C7edSqLCrH0LUwO+fB7DtztCGwJqcu06Y9zhrdcIthz+omNhrzOnx7qI7oY4OM8DqiAHMLToLdm+BiSmE8wUU7JKMr3cQbx3bgN16XiMhjijWqYEtktxB1ZOF7y93toO5ZNt8AcRu+c3o5JTT0Lp/mF4hvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5079414BF;
	Fri, 27 Feb 2026 04:45:44 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.197.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C13B3F73B;
	Fri, 27 Feb 2026 04:45:49 -0800 (PST)
Date: Fri, 27 Feb 2026 12:45:46 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, daizhiyuan@phytium.com.cn
Subject: Re: [PATCH 0/3] Arm SMMU errata updates
Message-ID: <aaGR-i8pIO8WYH9E@arm.com>
References: <cover.1772125743.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772125743.git.robin.murphy@arm.com>

On Thu, Feb 26, 2026 at 06:10:19PM +0000, Robin Murphy wrote:
> As promised (well OK, it's not Monday...), here's a more comprehensive
> SMMU errata update since I finally found time to pick through all the
> latest SDENs in detail. Includes some bonus cleanup since I despair at
> just adding to a messy table, but that could be split up if you have a
> preference for what to base on what.
> 
> Cheers,
> Robin.
> 
> 
> Robin Murphy (3):
>   arm64: errata: Reformat table for IDs
>   iommu/arm-smmu-v3: Update Arm errata
>   arm64: errata: Sort Arm entries
> 
>  Documentation/arch/arm64/silicon-errata.rst | 114 +++++++++++---------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  18 +++-
>  2 files changed, 77 insertions(+), 55 deletions(-)

For the errata doc changes:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
