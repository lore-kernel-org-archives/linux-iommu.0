Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E76D202F8E
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 08:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191846; cv=none; b=ooSHD/pFS46FchSdkqNthCf504eKJu7bUg5d2SbBLqvwfi9/3CA92TEuDF7jbE//LLM1uRJ5Os6raLJ1tslKnpk61oqSsk6gn4K9BApzkpNwrAOscbj586kbqedstUjxmb1xHxvJJm2UL26p8iVCjbebg28x82hWR5klNLwRVXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191846; c=relaxed/simple;
	bh=wwhCGVSTBuszCIkhkHAr5sc29TXCridB5fyWe2bkSKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvwaBGKI9xY00/c/5qtcMU1wZU+nCzXwMBwd82r6g5m72reXxGvtscymLKYxVq5rGvI/CAyvUAwkYaNRg0XWuzHK3u+Oz6uROcVDEZW0KCe1yNXPoCJYLJ0aW59DoguHnxzWNZ0qAkQvFH0uS5cv77wfRewsR6BkVAxAFal2S10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=gQRd+3lz; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="gQRd+3lz"
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9F2912A8D41;
	Tue, 29 Oct 2024 09:50:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1730191843;
	bh=wwhCGVSTBuszCIkhkHAr5sc29TXCridB5fyWe2bkSKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQRd+3lzySpeHfTYfqhxFoytqJfq5gL1Ii9Gx4Cgj2E+nQlkLnqlKvtnyRZP6zLO1
	 QCyoPiovjSR02R8exkMLF8zwcrX3xX+f5/7Dnihk7Q68TFJ7QyfS8E0q8GV3/oRNnQ
	 kcyd/laR5AHBN9u06+vrJntBbzpjcmZzhuBM4PEJd3y7fn2eb7SEcqVbs9eDId3eTV
	 GwE+bWIhenH541nAu+HWwuTAEmEy+QRccXuoI60RTO7ky3LnaMNH/keEWFwNSB5cjZ
	 jHRRipHV+JcmbFArZUOzbee5Q3R+CDRPlPXojd33oDDRBCmqUZAeiYRc+iufbUeZAx
	 QKTjaTz83EKew==
Date: Tue, 29 Oct 2024 09:50:42 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] iommu/sysfs: constify the class struct
Message-ID: <ZyCh4tsUadd2g6QB@8bytes.org>
References: <20241018121725.61128-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018121725.61128-1-brgl@bgdev.pl>

On Fri, Oct 18, 2024 at 02:17:25PM +0200, Bartosz Golaszewski wrote:
>  drivers/iommu/iommu-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
