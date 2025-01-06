Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FC11DC074
	for <iommu@lists.linux.dev>; Mon,  6 Jan 2025 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736163689; cv=none; b=Rp4QRIGC8O0+QUtIqirBsLhXlaq0ey1io9kvr5+4oQG3qmFC9hkHZtO3K6xdWkTssm9cRkFbC8jxuXL9u3bItt7QPnBN/Dt1qYy54wD3f1oL8IkxTDArANDSdHw1Xffiuzj9CJGj0h6bK6ZBzeQLm4fpw7iGZ5dNyLEF6IozyYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736163689; c=relaxed/simple;
	bh=HPpOcyBOstzHY/jKWEWi8NLiV9WEbBK7Ub3cYghvEoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEcOElZ6pc9Gw0up72ZDaucfYeBX2uByrNa1JhCq0RK0zM4FO6o4YPMqGccGfvWxJUS0ieY61T+gybGBHYdeEnw8Qf9DN1aFsjAe4r6sghx00bM1oQTqN2+n2LYY5j0WV9SwpbEg8vzIizT7XZNJOmgelLt8khIhvSdT5CZXkfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=DvFw3Zg1; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="DvFw3Zg1"
Received: from 8bytes.org (p200300f6af348600d06e0009f19b6c7e.dip0.t-ipconnect.de [IPv6:2003:f6:af34:8600:d06e:9:f19b:6c7e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id EF31C2E0016;
	Mon,  6 Jan 2025 12:41:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1736163685;
	bh=HPpOcyBOstzHY/jKWEWi8NLiV9WEbBK7Ub3cYghvEoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DvFw3Zg1ZSzheKQ/uxRqMXOouN6EzlJrV+GzuAxy13TMzZ4KdjLXbFFDDJx4tDOcF
	 0KnlDsgT1zByimPOjHjR4IrVZmV84CruWElluADNhy2JwVeX2Cm8Avzt4QvsTaM+Q6
	 4Ivn4z3ifpClShymteN4jGjmjabo1ZQgSquKuUctjHJH73wKpobnJCUkyQnGI/D6o9
	 YsTutyYTkE3g+lci4DQSa/Iu8cugE2u3KVDI40gU5LiSsjFQZi34LNTUCBTBdR4FNS
	 i1y4D3Kzff6IvY9Gclx7hKhM1quRBIdOazyx2P5i9+6JqWND/Z/dMbQCTfQTzEwu0O
	 DGmqfpzZHPkxg==
Date: Mon, 6 Jan 2025 12:41:23 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/msm: Use helper function devm_clk_get_prepared()
Message-ID: <Z3vBY7FtglzoRtjJ@8bytes.org>
References: <20250103113059.463033-1-zhangheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103113059.463033-1-zhangheng@kylinos.cn>

On Fri, Jan 03, 2025 at 07:30:59PM +0800, Zhang Heng wrote:
> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks"), devm_clk_get() and clk_prepare() can now be replaced
> by devm_clk_get_prepared() when driver prepares the clocks for the whole
> lifetime of the device. Moreover, it is no longer necessary to unprepare
> the clocks explicitly.
> 
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
> ---
>  drivers/iommu/msm_iommu.c | 51 +++++++++------------------------------
>  1 file changed, 11 insertions(+), 40 deletions(-)

Applied, thanks.
