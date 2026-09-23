Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64674EB85E;
	Wed, 23 Sep 2026 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179042; cv=none; b=qchiLEyQtIeBGldAMpZbx8FITzByBS/rA//0h7CRkaYobfbjNnyz5Bl+a5ZtKU7gJpl5/kinvCJ2V4cfZLn9bFz9s0WaNiiDY/wFfGB9MPkQ05ImP+GwYS+tho3/ale9EVbFGo82ylEpLEvnSifNmlU6iBCiFkj/fupkvgNLM4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179042; c=relaxed/simple;
	bh=dH1zh7QkL5jIxgg6r/MNhC42g1LfEW7PADxJ/Jd2GVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ov1XVBL9MJ2Oe/bmPBijGWxZdIMyuNfurkbGEIE8kcbd0sAO8uk2py5Rznb2zvI8XpKXHmWdpfB96QpdrlRADxOsDlZnF8rB9ENiCrUWClWzVwumwdnR3GNeb30AdJz4H7hbR3T0togm8lbg9k1X9RxAtw6SNeAyKadl17nm5m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=El4Zf1lk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="El4Zf1lk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D101F000FF;
	Wed, 23 Sep 2026 15:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790179039;
	bh=4P0k3hiKGkpk1Fi1QdfvymEGAMVjJIDevylceiC3XnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=El4Zf1lkzCwXQ1+o2MLB2VmC3YE1om69fiHU41tHfctUSij3bfIWxCcUcd2fwlH7+
	 eJUymQ0VGc/4/3ZpNgw+flxz/v6SoBqs/mDE0qGc2jES7+RKw8PJ1ll2hInOUJ+FRV
	 2WfyL4bRk1oj5Kyo0FXCGw/bYmfOgn9R4ogfk2j80bFZ2RSJxEOj86q3Y2m57dgk+T
	 F8BJB8svO+7DvEdUXYshAcbg6NvFNr3VOhUxMN2QJWRMEZbZVtU+nkvAnmZZbQgXL1
	 ZKjezw1N5ZwVOTWUS2IMkZSOT8FCuclWXdcimT+F9lrH2x8mZagysE5MKfxpCBLHHN
	 qzIFw5ZLkYNJw==
Date: Wed, 23 Sep 2026 10:57:18 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Yong Wu <yong.wu@mediatek.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: iommu: Describe MT8195 infra IRQs
Message-ID: <20260923155718.GG27237-robh@kernel.org>
References: <20260921232716.3134140-1-robh@kernel.org>
 <bef176a0-7b13-4753-9d9c-494a0bf04cea@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bef176a0-7b13-4753-9d9c-494a0bf04cea@collabora.com>

On Tue, Sep 22, 2026 at 01:45:05PM +0200, AngeloGioacchino Del Regno wrote:
> On 9/22/26 01:27, Rob Herring (Arm) wrote:
> > The MT8195 infra IOMMU has one fault interrupt per IOMMU bank. Require
> > the five bank interrupts, named bank0 through bank4, for this
> > compatible. Keep other MediaTek IOMMUs limited to one unnamed interrupt.
> > 
> 
> Why are you introducing interrupt-names, and why would that be a required property?
> 
> I disagree - interrupt names are not necessary here.

I agree. Not enough review of this one on my part.

Rob
