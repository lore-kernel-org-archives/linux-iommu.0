Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418A234D4F5
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768996462; cv=none; b=GlLlTZHK29lLWbO4KAjlAtWPnmYKsHTTsp5TMHsSyID116yNGZs/MefH+4DRTWhvEHkTOvmppNEwQwYjGXnMwC2L1FGIBuUrjPPMB3vbnbO7Qe+Dn3KNEJYdaR9Hfm0sEpdSvKLputNOEnttIegcoItL+zp6ZALO599lhVTU/DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768996462; c=relaxed/simple;
	bh=EHnoo6jsWKMh3RwGK+x0GrMu6SJ4jIy6xOR9GwEQ6CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NP7t64dofFLnE/0pmU3qDUrFrHjSu0ub64Emmu7+gVyHHs1DRrqkTAlKBjl1KpWJKHHeG6YoGBmOl9IWlR1B4nrYlBVh9b+Q0BPZk0T2dQVm5Nx3oDcRKwJr/jY+Kl10/JYuTWzzo3+U6anWVU+wfNxXOmeH0nxUGRBeTPaXcU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=NKJZCtHU; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="NKJZCtHU"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3B2FB1A268D;
	Wed, 21 Jan 2026 12:54:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1768996460;
	bh=EHnoo6jsWKMh3RwGK+x0GrMu6SJ4jIy6xOR9GwEQ6CE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NKJZCtHUJI53ywbSRKz+BAeVcA/rpeZUWA7m+TgaMBgFefYc7Ht6L6xas7eZcnotX
	 pbP2TPR/lDUrp2vwBBQ1ugibuiRT2CTazgktOEHUn/D8Cg/GBVNAMXjQTYjgznNvFH
	 rujktX34V/R5exHXsaTq0Cwmst/ar8VBkgbbFJ72gBQU38T0Aoemj7mibtXBfEcBo8
	 1UDac/gTZQ6x51vKqz1OwpSER6QSUpq2mdwmDRcbbNIrErn7wyZuwhPDXjG2TL9WaI
	 86ePOCjup+gexdCw7AQc7dd4E6WUHADWnoU0RngN4RVROMLLcYa7yIW+06F0KXDwdr
	 AaZPr6TIXx7oQ==
Date: Wed, 21 Jan 2026 12:54:19 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: will@kernel.org, robin.murphy@arm.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	nicolas.dufresne@collabora.com, p.zabel@pengutronix.de, mchehab@kernel.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org, 
	kernel@collabora.com
Subject: Re: [PATCH v12 3/6] iommu: Add verisilicon IOMMU driver
Message-ID: <25htwrdapwwvumlaqlu5oywcnnbss5kjyvnv6cxrx42q7mfhuw@wyagcnc3scgf>
References: <20260114100922.149187-1-benjamin.gaignard@collabora.com>
 <20260114100922.149187-4-benjamin.gaignard@collabora.com>
 <3082a454-31dc-42a2-85a6-0fd0c87bf31b@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3082a454-31dc-42a2-85a6-0fd0c87bf31b@collabora.com>

Note that I stop taking changes for v6.20 (except fixes) by next week. I you
want a chance to have this code in 6.20, please make sure a v13 is in my inbox
by tomorrow.

-Joerg
