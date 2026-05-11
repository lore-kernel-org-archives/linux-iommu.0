Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8545A3BAD92
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487619; cv=none; b=VgorLmE+wxTE5p1x3mydLRhZOkuhX/VAH7Ei0vfoO2VTN1g3D0CVumdANSjmnQinDEI+moJraTBmpbljIOHaNiMKpCSv89A1YG78cUmZ21pJqUWMxzc4RvCUjyMaTMnHjyXqVC6hQYeB7qUO/wx+uZAMgploqUtKsbEI+pZ5Tis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487619; c=relaxed/simple;
	bh=8fFqOORjlMEYyX+ZnURSdCJcelZtF8M0TXlM1M8Tgzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqcCZsZDa0AxjHNTmKOXTJKZ6cHpRgKdH1vBepjX7BwukFG1R0pRr6slLrbCHXxlg7x1A6YxkOb8fLAaCuIE+aYLf/kC7jWpTUoT80H6m+V0JDyPjwDNVk3ilwFF5jTOHAsFnyWXrjHX1FhHTu/VpT4+eSGczL+qgpDRbkgX0Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=b63L9iEi; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="b63L9iEi"
Received: from 8bytes.org (p200300f6af1d960077b96a322515403c.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:77b9:6a32:2515:403c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B5CB61C3C64;
	Mon, 11 May 2026 10:20:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1778487606;
	bh=8fFqOORjlMEYyX+ZnURSdCJcelZtF8M0TXlM1M8Tgzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b63L9iEi4M2pOLwc+ESAfDuEYVS4JOLbrtTa+hwisi0AZ6+1IX2hO4UwhQjaFKomX
	 /zIgDgRhh7GlLwFH79bboZa6oYXxuxmvOpDSU2nfBiVubGmlQ1oLcH92eFosPdyXj1
	 Mx746wK5uTa1sQYFEAJu4zIZBgdhuHv6/D3jSDKxFnVMBrg/O/uyV8IS/ZyJihlL6O
	 MK5Xv1qZOm3bN+eAUO7KlDnA7icCwZHTTttWCUx4Us4IPgf6+iOTSu5D8eB6H16vLX
	 aL2LeBQHkN792zxshnKWQHG/n9rTaLdF4IQ4wzEgVOP1tl8xeiNAkamVcoeY7r/zVP
	 +uSEF+cp15JJg==
Date: Mon, 11 May 2026 10:20:05 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, 
	Naval =?utf-8?Q?Alcal=C3=A1?= <ari@naval.cat>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] [PULL REQUEST] iommu/vt-d: Fixes for v7.1-rc
Message-ID: <lmjwqvpa7de2tgm3muox2beeso2m3ja3ghhvnzhigoqn77jvep@57ms3dhfhy7q>
References: <20260509024348.3516523-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260509024348.3516523-1-baolu.lu@linux.intel.com>

On Sat, May 09, 2026 at 10:43:43AM +0800, Lu Baolu wrote:
> Naval Alcalá (1):
>   iommu/vt-d: Disable DMAR for Intel Q35 IGFX
> 
> Zhenzhong Duan (2):
>   iommu/vt-d: Fix oops due to out of scope access
>   iommu/vt-d: Avoid NULL pointer dereference or refcount corruption
> 
>  drivers/iommu/intel/iommu.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Applied, thanks Baolu.
