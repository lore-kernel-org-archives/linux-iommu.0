Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69FB1D5154;
	Fri, 27 Jun 2025 07:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751008589; cv=none; b=aH624hrMl4J2vZgcPfnnKl4C3nAxCTOdzfCwBgLAzZSr+i3lRk1EPZDkX540rK+RyepA6vAunCckhH1/3zXDXv2pxOSLB9XXww61zLxUmIeGKbUa5hp3WmbEYsElhrnlDdwK8gQVjsXWtL4T4go8mBb7BoJKUi3vEfitAcm2ehk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751008589; c=relaxed/simple;
	bh=uBKXF6vM8NfVlqAtE7zDF6I8dzJzNc3fCBNdDoutpU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHyUlBO1MwTIPFE46qB3WKP47C5fRB6CV2/xBeEJXOKrsgfz4x5P7l0SfHaUE3PO8fb2a+0C1xhIbvrLmPnet4b8ACEW0xMZY48NIsmUE2tNLS8DNxV768R8tf6B50COvS4vzYZxqNLffnzxipwevY9LuSuDjUIx0CxlRyTOQ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=NcPb/K2M; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="NcPb/K2M"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DC8864EF8A;
	Fri, 27 Jun 2025 09:16:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1751008587;
	bh=uBKXF6vM8NfVlqAtE7zDF6I8dzJzNc3fCBNdDoutpU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NcPb/K2MNA6v5UAJKyjVIWtTDJW1lvixW+t/T5N7+COup8OWRQ43PYOax9pP703H/
	 Pfz8CHP+e5tr2GMW0rgL9g2iUic+LOy09BSquqNOVvmPtMt+F+8Jtly86xWOqnsw9+
	 IgYME6KPy6P6uzLMs2nEOWuRES3Rx6ODmue4yBK+UKKjv4txAq2fsxN+tXNHnB9E3A
	 wXoEMMmmPhAlWKfviTw/eOiGTV+vgUVffBaMLF8vinx+mWyFmZf6uo6UjqnHf9a80n
	 8RBXBnmpFdArB7D3PF4Ggr81DNf6CU0RExxWOIJreXBRTLwEYYBM4eoCZA2FQmYasN
	 v1r165GitYyxw==
Date: Fri, 27 Jun 2025 09:16:25 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Zhang Shurong <zhang_shurong@foxmail.com>
Cc: will@kernel.org, robin.murphy@arm.com, wens@csie.org,
	jernej.skrabec@gmail.com, samuel@sholland.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] The sun50i_iommu_of_xlate() function didn't properly
 handle the case where of_find_device_by_node() returns NULL. This could lead
 to a NULL pointer dereference when accessing
 platform_get_drvdata(iommu_pdev) if the device node couldn't be found.
Message-ID: <aF5FSez2w-Y3c2za@8bytes.org>
References: <tencent_889D023A2A9B04DE8D592DFE961C5893C706@qq.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_889D023A2A9B04DE8D592DFE961C5893C706@qq.com>

The subject line is too long, use something short which describes WHAT
the patch does. The WHY can be placed into the commit message.

Thanks,

	Joerg
