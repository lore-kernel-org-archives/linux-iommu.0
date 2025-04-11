Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A205E1ADC69
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744355795; cv=none; b=hbRNqBJd0QvadqRaV7KknI/zK/ykhHyb2Lc781o0TNBp7DzNmsKt2czbhtZbo0wAvPWcZdm6hO4sV1Ey8vk2oxtzj10KCM++hnXMz2g/T2MnOWHcg24XnSDGPbHakQcNcGwf3G/BqrOD8sd2ZkLIGr9fYWuwKVvcGZ04zyTEQ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744355795; c=relaxed/simple;
	bh=T9N7HsEod40hczRSGHHXWyVVmwWi7nWUSQgVyyI1B+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRUtnnBzznDAwf6GEWA+gMOLLA824CHat/EZWxckwYNQDAWm3i1XHA+UvtD3gV9M2CjPZbID5tJqGpjeNuShqmCRDDYaS4XmjvKpW8Td96kBTuUHd2QPWd++wVmt3DJU6f7xVedmJ/uQii1bv7XUufi/N2MQkO/vtru5fpo3l1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=iuBs48Ez; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="iuBs48Ez"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8134A47D5A;
	Fri, 11 Apr 2025 09:16:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1744355792;
	bh=T9N7HsEod40hczRSGHHXWyVVmwWi7nWUSQgVyyI1B+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iuBs48Ezo2/n/fXFujKGAyTTV7eh/GfVGNSqT/d34Z/nTswcQoemPgKoqh/T0fEqs
	 SDgY3SRGeRiWfiVoTzwx3w10Lvc/HjvdVpjCnChdiQLxlaqMkkXJbLVmb46QRcH1Qa
	 xienq7fTbwVqsUg7HKvz/AvOO0ah83hxwiQG5L/r8mVHwwuFvX0wq6s/wpIyOOGw06
	 edRkPzjGGxI+sCEsH6stxPqCpLm4rVLv3DlLk64wBXRHWplghZnXycA1+eyPj6raOW
	 6HZ8yfyfUtkPRxXiP+y3JPnnQnfauTrVOM9dOyXgat+QzpkTrE+LM2OmBBt7uHWng6
	 8bj01SPlJ40aA==
Date: Fri, 11 Apr 2025 09:16:31 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH] iommu: Clear iommu-dma ops on cleanup
Message-ID: <Z_jBz2p0cYqIFfFn@8bytes.org>
References: <e788aa927f6d827dd4ea1ed608fada79f2bab030.1744284228.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e788aa927f6d827dd4ea1ed608fada79f2bab030.1744284228.git.robin.murphy@arm.com>

On Thu, Apr 10, 2025 at 12:23:48PM +0100, Robin Murphy wrote:
> Reported-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommu.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.
