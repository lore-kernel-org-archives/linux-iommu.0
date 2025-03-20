Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EA51F8739
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742457533; cv=none; b=gsyQaOmBrRT+rPghqsoTacKtoeanqAjT0ky6lyIbyNGxIy+EKK25A9koXLJQaK5KbDnVgnDiJz+FXLHmGZbxiGW5trAyA8bC6JiJITdTQRKVHtrHSuRjkZgLX2mhw/ekIEGPwBc6J5eOHFTZp6uZlTbLfg1gwfpzEeJFshU+wDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742457533; c=relaxed/simple;
	bh=//jdBfnXwxoZZQ2/rQLQjvxB+8O3hzDtgcpEsDOaSFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQsPZTjI8SydowS5q23syAsYMjw6wNjRNkK6L9si0O44+GIOqoZGnEc4nOtqUBW1i+vi6IpM0C+HlDLjlmdoBxyF0HyInIj/P3oYld4mEvJilaM6fBy1hwU2gqJhMkUGWR3aEey8HpDM1vgJnvRPWsZDDMrnaYIEarUkBeaYiSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=aP+qd4UW; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="aP+qd4UW"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4D23243205;
	Thu, 20 Mar 2025 08:58:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1742457524;
	bh=//jdBfnXwxoZZQ2/rQLQjvxB+8O3hzDtgcpEsDOaSFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aP+qd4UWA/ptWrgYN0yl9WJNgNxr6zQkaY4qJCrqxnVFSjDX4+dHy9o467D+Fc2Mr
	 PKouyAiZ7KGNXkipmD9vdHKH4LBqzPJqbhmmtlK8HtIWdK36EBk4L4+0briIhkLp9z
	 zx9XexvVs4ekH4ZIocTRMlxHms7IrxiVwOhnCNvcNiyk2NsIYcfpMJLYXdGJpUO8qM
	 Hp/SPk2FW14d7AEZJaOkYxBx9AzQZIXM9iHtaKviS51/ORxZWRsuEpq+Z1goSx8P01
	 wpoGdn0LTpli76eLMMP+YLTSDqieqBStvAR5CIjM+QKnE1a+XVAHYZjKfbFAQq8pvR
	 MqhU9uuXCig3w==
Date: Thu, 20 Mar 2025 08:58:43 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, heiko@sntech.de
Subject: Re: [PATCH 0/3] Rockchip IOMMU fixes
Message-ID: <Z9vKs63e1s73MauO@8bytes.org>
References: <cover.1741886382.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741886382.git.robin.murphy@arm.com>

On Thu, Mar 13, 2025 at 05:31:03PM +0000, Robin Murphy wrote:
> Hi all,
> 
> I was expecting my DT probing change to flush out issues, and it seems
> some weaknesses in rockchip-iommu were the first to show. The first two
> patches here get things working again for me on my RK3399 NanoPC-T4
> (with a console on HDMI exercising the VOP MMU), the 3rd patch just
> finishes the cleanup since I was there and could test it.
> 
> Thanks,
> Robin.
> 
> Robin Murphy (3):
>   iommu/rockchip: Allocate per-device data sensibly
>   iommu/rockchip: Register in a sensible order
>   iommu/rockchip: Retire global dma_dev workaround
> 
>  drivers/iommu/rockchip-iommu.c | 61 +++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 35 deletions(-)

Applied, thanks.
