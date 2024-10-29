Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B8D2038D5
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191780; cv=none; b=m9HZMiK3KVBQcrhyvvSsBRCMqJydQrMOC3GPLaE1aw0UwcQY2Xh2QmEynRv5JTEPXg7gpPIzJb2SMktPHrnvvWr/xBMDsZOANNG6eiZUiI1jUHrA4XkWsE8UjF0mQvnBiWgBaRMX10AmJNRcT0SnSyp0PkPaFKGD7G2K8+YwvJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191780; c=relaxed/simple;
	bh=t4F6EkQzc+Tx2dGrpH/0oshPhSFvIj0HR4NfuwzqRJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OndGot+lGh40kjEGQ8ZpWA1utHgnmhjtvECEbOutzhU57gCSKFWDwIpBD2dvwKcctx7hWsgxRvSacuqXqn7v5+mWHeZY5f03oRwaOOsEAWd3+saqJKf4R0IOgZGEBfTtDiJQOJEkZ4EATTADE8yzosqyzsj7h/SQ7wGDFE06/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=aUQ6xfw4; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="aUQ6xfw4"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D77FF2A8D41;
	Tue, 29 Oct 2024 09:49:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1730191778;
	bh=t4F6EkQzc+Tx2dGrpH/0oshPhSFvIj0HR4NfuwzqRJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUQ6xfw4G2fAmph3fMFdnFmV5d7IVswiGPxXeaXX/I9SmikyU2MAAf+y4Isth8Y5K
	 p21a5tZ9rsQN0CxRZso6IVwby5zEOcH2BVQpWpR9rDow9TEbXHCS92Z+0aheRh471F
	 xHWeF+1O85Qp+VWsrNNEHC2kW6wmlznAOKjfdfyX494GntCf2fDENFo2kxeRU2udOd
	 zTifyhsLLwcopsEVsl7OaOng1N2eL6IcVYq8qymV4U36kJb5amFqmOiZ4p0BD607Hm
	 qoqV9iL1vxQfocKm3vi1TXeIE060idIsNLCclyrLXHabpebwZBZ1UagunS4H0Aie/g
	 uuXtwG4E1t3hw==
Date: Tue, 29 Oct 2024 09:49:36 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Konrad Adamczyk <konrada@google.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Wojciech Macek <wmacek@google.com>
Subject: Re: [PATCH] iommu/mediatek: Add PGTABLE_PA_35_EN to mt8186 platform
 data
Message-ID: <ZyChoFmaID6aGQT1@8bytes.org>
References: <20241017112036.368772-1-konrada@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017112036.368772-1-konrada@google.com>

On Thu, Oct 17, 2024 at 11:20:36AM +0000, Konrad Adamczyk wrote:
>  drivers/iommu/mtk_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
