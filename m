Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F5933263E
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780389902; cv=none; b=BwEIj8MfCcUmHqvjZIU5Z+53KdB/vuVLS5cuo4yztgSUSqcXei9gqQyzjMHRdBrplnwPCc6MhmWJ4IJn+p/lVhUmoXcc46zFEaaqCxLebk5g/hB/obj7S+OXux8TQFw2w5ukuDi1kGOVwSdSwrVqKFDLRy5E2VNFekPYBz367hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780389902; c=relaxed/simple;
	bh=ghNxMtAGc854nep1U8taunkDnEXwY2LNC4H1CScXztY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQ68bufRkzCM2rh4KKmhE3CVjWqSF7gL/OStDNYmQZF2rWc2e58tOR5tqyGXNMUnAhynhwt37qTpwLhczDLZetoDPP5rfAQtV3ZMwd51r+5h9h3g7uBZyz11FSt7RaPx2EW/hVPPPj/5v9qgSP2pzAUEa/3F5ThcSAh2RZ1KDhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc500cd665649150e3ae5.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:cd66:5649:150e:3ae5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E1F941C6983;
	Tue,  2 Jun 2026 10:44:53 +0200 (CEST)
Date: Tue, 2 Jun 2026 10:44:52 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sven =?utf-8?Q?P=C3=BCschel?= <s.pueschel@pengutronix.de>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Simon Xue <xxm@rock-chips.com>, 
	kernel@pengutronix.de
Subject: Re: [PATCH v2] iommu/rockchip: disable fetch dte time limit
Message-ID: <ah6X68serZREQxJn@8bytes.org>
References: <20260428-spu-iommudtefix-v2-1-f592f579e508@pengutronix.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428-spu-iommudtefix-v2-1-f592f579e508@pengutronix.de>

On Tue, Apr 28, 2026 at 06:05:31PM +0200, Sven Püschel wrote:
>  drivers/iommu/rockchip-iommu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks.
