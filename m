Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429832;
	b=DoOuZ8VdbK2zzv2zOpb6pyLlcGOijAUNYkwev1XAfvmGPCSNY0nNe5wZuQ+r03+0ksSE
	 TY9sCSCGTQ90VicMkxVUh6Q+Tgs7AMLbZHwVeUrBGcCS/oC9Ya+udTqvVM8dB/k1RC0kE
	 hT1ksS0WSznS9RRXCv1icytl1HfySpMxc6+84iG4xRcUWiESDveTDuH0tEgrSjaGnZPX4
	 jlsU/XruXt1XszwrDPSyCj0AfP4ku7i/hyrGPbADojGdOcU4S70rSQtnFwQr+sPPF6Uuw
	 yuygDHgKITXke8fvZpr52V+m4+7L2wf1hZIN0K81uOD3xTEptSxyzXUvPCbEpDlhR2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429832;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HZquuzvV18riLhVL8pdJzlAV7xVd4ucIjKc24kt0UaI=;
	b=w4UTHCOwwlgiSrYzkHCAbWhPgBV8dJ0IX+yjMfFooQpKDMFIqd4aVeoltnCnglVIdB4G
	 6e5PwAdgpAPGrprAIBKGd8GrLpABB1v/pGxUyyVzClBvTz0RpUpWyxxrzMSuiCsJA3T7z
	 S0MjZOIx35MdM//27qRvwwRHMYLIY+5LEFO0LFGHCLmxaQD8c/OaFRQqVbJbGsB4wj0c9
	 7r+DyWGgJdoWNbRYLv8AGXcxwNDLee7AQxkH9R/JGrFEB11U4qmiKkVTcLGRU/MQIpSVf
	 T47htVD3D9Lo3wvUMnlw/IYAHRpPHThW8ICPctm1WOPYjaYS3TWdrilKnV5p+2up7mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99D7606A31E
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 10:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D99D7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 85EC62436B3;
	Mon, 23 Nov 2026 11:30:30 +0100 (CET)
Date: Mon, 23 Nov 2026 11:30:29 +0100
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: aiyengar1990@gmail.com
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vsi: Don't write the enable register on suspend
Message-ID: <awQVuJHpH54HAd0q@8bytes.org>
References: <20261113-vsi-iommu-disable-v1-1-94f7f44540b3@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113-vsi-iommu-disable-v1-1-94f7f44540b3@gmail.com>

On Fri, Nov 13, 2026 at 08:06:43PM +0000, Arun Iyengar via B4 Relay wrote:
>  drivers/iommu/vsi-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
