Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CC44436E
	for <iommu@lists.linux.dev>; Mon,  6 Jan 2025 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736163409; cv=none; b=NYnrS/BriFZoygwChubBtLz/qXzW6y/ucCjgKpXe4ppC6NpGqH549mhKDGYzDZe2t8Kw+V0TsnDbi4/lbjW9BXYdTvQPo5QXcuEaX/3IRgye5ieS1KJJSuWHtJRUzSJeFjI9oUX3T3XnlwdZo5GiDOpGxXbAngQ3iJ/Q5rMVtm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736163409; c=relaxed/simple;
	bh=YN58tjVz70PHm/pGFOJ+/GEdu/r7pxe7tJRI2ZBFXmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZqhcgKcqwOV22qHCdjtUf9LmQo4LEvyLRGYqumI4xrr+3lM+M2ZlJFkSjhauNojpN7FfiSOQ6mSegieqmCMWVEB3FxiXihgILoy8e6KREoNchHEHjNaL9IlLxqTZIaitFkescccv45R9hYpTIpGmwGYuPShVv/DjY7tCrwm5xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=O+eZgIxO; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="O+eZgIxO"
Received: from 8bytes.org (p200300f6af348600d06e0009f19b6c7e.dip0.t-ipconnect.de [IPv6:2003:f6:af34:8600:d06e:9:f19b:6c7e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id BE4222E0016;
	Mon,  6 Jan 2025 12:36:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1736163406;
	bh=YN58tjVz70PHm/pGFOJ+/GEdu/r7pxe7tJRI2ZBFXmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+eZgIxO/FoAd8/RTShOPk8F+f5IpkpVxsuPx4+tZ/b33HJTWqYVLLffeHEUgKAVp
	 +QEWB32R5ziD8qV4vLWUSPxDPMg+qQ/S/9AzF2qFvf1QrCbkNHUYLVr33dTgPQc07N
	 sOLK2KQtkDPiOv/ftv290QVXDlkRuo1Yg5rfNjFs6piSWshM5UNgx9GHc472Usn06f
	 ZVBYORJ/SCcnS0xhJAyLXsQxLfwZwT2GeoQD9ba8uLNhOIvKMhGHmf6V4RBqfK07X7
	 4T4uaZ7osSNna3/vMPLs9C1OJTyPZhZX/giQJbTdP578ibDMzyCKSt8DlFS1NRt23t
	 BMrVvluk5MxBQ==
Date: Mon, 6 Jan 2025 12:36:45 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, krzk+dt@kernel.org, robh@kernel.org,
	devicetree@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [RESEND PATCH] dt-bindings: iommu: rockchip: Add Rockchip RK3576
Message-ID: <Z3vATdi6q83QAcU1@8bytes.org>
References: <20241231093154.252595-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231093154.252595-1-andyshrk@163.com>

On Tue, Dec 31, 2024 at 05:31:50PM +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> Just like RK3588, RK3576 is compatible to the existing rk3568
> binding.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Applied, thanks.
