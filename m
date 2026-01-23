Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143736FBF;
	Fri, 23 Jan 2026 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188536; cv=none; b=No37jtSNcUVqWHfFF7FlgnCeva1JmUDMsITo87y5IWIuCCwyE3hO1ZvK3cYOSSPx7/P3kqhq3S3nOFiGJ5oXZ2jaKpM2LYtUVqbKAXsVLbXIUFQLO2liZ5KQRRBEiafay40LPjvNjqHiLSHdZMcE1y9yFzLUQLEEg4tIukFtCI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188536; c=relaxed/simple;
	bh=TEToB2Qr35odS2hMmcpVhS46OELbEb52jc8i5sBbYlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5odygLliq/m3YDOCO03/8D4HjXTtjkSZkV1pRERFhiEmX1A0sYpEfFED4WNtLoyKtecVcNy+VaeU6aM1FMTv93npCthcXGkHFgJ9SeGw32KOQqzxCMnYyXUcOmiXkrdhZQOhqdAyYTeqYKbBzbGm/Wcc0Hpw+MAJvy0+ftZaas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+eMucAE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+eMucAE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E97C4CEF1;
	Fri, 23 Jan 2026 17:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769188536;
	bh=TEToB2Qr35odS2hMmcpVhS46OELbEb52jc8i5sBbYlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+eMucAEoSaKnXOVwMjQDzZksnff94Bxjyfhb3TC3ZSp88VpZfJzZ66ThH9ynNbrT
	 9UlS1jV9WXAkQdbVCfQTUNsNjPFxkQQqU45XppqAH4KgTW46y/QHSQcgzG0o77E9P8
	 vaOihRreWcANwFTokDyKrigYkPrCqxI66riH0cZ3hq6rXDSdYCrKGGbCLzFym82ifs
	 2REPouXnxCP9GiOthoFCIJIv0gsJtkeWeitPInOZofyZ+ykSAk1rZ5axwCHy7z4V6b
	 +UTa5ik0MIZk8VNrv1cKxsdE+Pada1KEGHq+USsJpTzHArxdyFbvHrQazrbqRmbNIs
	 2kHeqTo7d5Z/g==
Date: Fri, 23 Jan 2026 17:15:29 +0000
From: Will Deacon <will@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>, robin.murphy@arm.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, nicolas.dufresne@collabora.com,
	p.zabel@pengutronix.de, mchehab@kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v12 3/6] iommu: Add verisilicon IOMMU driver
Message-ID: <aXOssVvBPZ0LQ4Au@willie-the-truck>
References: <20260114100922.149187-1-benjamin.gaignard@collabora.com>
 <20260114100922.149187-4-benjamin.gaignard@collabora.com>
 <3082a454-31dc-42a2-85a6-0fd0c87bf31b@collabora.com>
 <25htwrdapwwvumlaqlu5oywcnnbss5kjyvnv6cxrx42q7mfhuw@wyagcnc3scgf>
 <4e0de2ff-4616-4e49-a419-1bdfb03e1430@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e0de2ff-4616-4e49-a419-1bdfb03e1430@collabora.com>

On Wed, Jan 21, 2026 at 02:52:07PM +0100, Benjamin Gaignard wrote:
> 
> Le 21/01/2026 à 12:54, Jörg Rödel a écrit :
> > Note that I stop taking changes for v6.20 (except fixes) by next week. I you
> > want a chance to have this code in 6.20, please make sure a v13 is in my inbox
> > by tomorrow.
> 
> I have v13 ready but I'm waiting for the conclusion of the thread with
> Will to send it.

Thanks for your patience. I just replied again on the other thread because
I still think we need to add some TLB invalidation on the unmap path before
we can merge this.

Will
