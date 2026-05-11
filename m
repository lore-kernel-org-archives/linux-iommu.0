Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B43D3A8FE9
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485867; cv=none; b=Ur3g2Yu3GKj+vuh9S523clipfOwX9RH8rMouUIbh1yLaN+jWUGGxC5lr6Px1BdSCsW8nU7kYAk6PcZ1j36GmPkQphbhlgwnPic7578XrgykeMdUmsoeruKkFUO9Q0L+mwRiG8SY/toj8k/qC9I1fiF20fja5fiQxcRkOgqIpgI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485867; c=relaxed/simple;
	bh=tHIXSOunozidGdIMlroeOvd9P2ZDwEgxwugKBkH6hyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpyPOIiGy/W7aUTgxlWp2ce0GewhyUokZP4Opu66rYT/sLYPKxInX7iZhIW9PhR3aF2cH875HNdbCKO5JhAdtFQQ99nysD/U6GnpNzGwFa6ieIafjcp4EWaOKzExq9mfKIuJRFLkqFFymxWHQdUQQJhpl418ae4IIjCXBQHffcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=51VfHJdG; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="51VfHJdG"
Received: from 8bytes.org (p200300f6af1d9600f5faa5cebd6c042e.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:f5fa:a5ce:bd6c:42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6D4B61C3E81;
	Mon, 11 May 2026 09:50:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1778485853;
	bh=tHIXSOunozidGdIMlroeOvd9P2ZDwEgxwugKBkH6hyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=51VfHJdGt0an419Y8AneALOHXvQW0cVyTTmceDKtey13MadjNwAjSsCoYspikgPhV
	 nYRCtBpKqXTSL5yWEYWo9V7r3S3sEN5bphglWOYq3zXU4jPimVWXmb4GoK+U4gpZb6
	 rwsIOZXRNUw3DbcaZzTyBKuXzWOEHW8bJqSGSOc/Ld7S4aYPxJ4i3doQwYgqMdpDBv
	 y2G2ncwlfkAAHKyNYURUQKaTL8XdoWgxRgigeTA+8T/WFlOmLgVhV0SsBsN7BAkozC
	 1Kxg60xEKb6ojnqAvf3ivgWjEhYxhcP/O8ZNSa2rrUkTsws3LsWtqifCHmD6do29ro
	 OZ/WRviE5pf2w==
Date: Mon, 11 May 2026 09:50:52 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Eder Zulian <ezulian@redhat.com>
Cc: suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Remove latent out-of-bounds access in IOMMU
 debugfs
Message-ID: <uzgsmssbtoclvw4qb3pl24piqz42jj5gsh747aify5ketd4fkk@ay5cntrt2z4r>
References: <20260410125550.187398-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410125550.187398-1-ezulian@redhat.com>

On Fri, Apr 10, 2026 at 02:55:50PM +0200, Eder Zulian wrote:
> In iommu_mmio_write() and iommu_capability_write(), the variables
> dbg_mmio_offset and dbg_cap_offset are declared as int. However, they
> are populated using kstrtou32_from_user(). If a user provides a
> sufficiently large value, it can become a negative integer.
> 
> Prior to this patch, the AMD IOMMU debugfs implementation was already
> protected by different mechanisms.
> 
> 1. #define OFS_IN_SZ 8 ensures the user string <= 8 bytes, so
>    e.g. 0xffffffff isn't a valid input.
> 
>   if (cnt > OFS_IN_SZ)
>      return -EINVAL;
> 
> 2. Implicit type promotion in iommu_mmio_write(), dbg_mmio_offset is int
>    and iommu->mmio_phys_end is u64
> 
>   if (dbg_mmio_offset > iommu->mmio_phys_end - sizeof(u64))
>       return -EINVAL;
> 
> 3. The show handlers would currently catch the negative number and
>    refuse to perform the read.
> 
> Replace kstrtou32_from_user() with kstrtos32_from_user() to parse the
> input, and check for negative values to explicitly prevent out-of-bounds
> memory accesses directly in iommu_mmio_write() and
> iommu_capability_write().
> 
> Signed-off-by: Eder Zulian <ezulian@redhat.com>
> ---
>  drivers/iommu/amd/debugfs.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied for -rc, thanks.
