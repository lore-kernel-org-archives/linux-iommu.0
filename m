Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF703C9ED9
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585139; cv=none; b=VjIt3OV6VpMCYowRk9tovs004c2hhVeLfWForbE/9pMwejJzmRB3C44begdQxIClXTWd0FM7+EcTdz1Mhzuc2nVCSJKDNZXGWlwM9PWyaqgzFtN1ZD0kVo63cx19pdWmXAF5a/lvX17YqmGMerTv6Ni4UZONhXDIuTGCKsDD5N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585139; c=relaxed/simple;
	bh=KAa+Fk5rB7VrCaVP2BPkfqM9xpB3zX7jLktKCM3MZl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFaGTCqR/EK72VWyusM8sDilQYUge6jOyMQajnd60s3EDV4CNou3TyrGepLqi5ZkUdbvRN1aTj7+8e0Tz/WWg/937NY2XoOwrHdB25LytLIiSHkdjRXrb8FBL39reiy30O71jmdt1oQC55+MfhtrToiBjswoZIYiInoHnjGLQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc500c39e96c98da8598f.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:c39e:96c9:8da8:598f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id EFBE9203855;
	Thu,  9 Jul 2026 10:18:56 +0200 (CEST)
Date: Thu, 9 Jul 2026 10:18:55 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vladimir Zapolskiy <vz@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Sricharan Ramabadhran <quic_srichara@quicinc.com>, iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] iommu/msm: Return -ENOMEM on memory allocation failure
 in probe
Message-ID: <ak9ZYzcFWAPCjY5B@8bytes.org>
References: <20260701222411.138514-1-vz@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701222411.138514-1-vz@kernel.org>

On Thu, Jul 02, 2026 at 01:24:11AM +0300, Vladimir Zapolskiy wrote:
>  drivers/iommu/msm_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
