Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78802580F2
	for <iommu@lists.linux.dev>; Sat, 31 Jan 2026 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769851397; cv=none; b=HTGIw40XjsNMVwLGpiPnxHu2q1KGZKFOJwMBtV8fuT7ypfmAk8B6wUBQ1okGHDrU2BoNYnGJQxqPdWnumOtdFPsELQ6UNJU7xZPJzgyU1FgYBvANIzMrzDVPapIu2J7tZtbErJfOuvrb45V01p9A3rUdBnDM4wgjz4/jPCO5Jd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769851397; c=relaxed/simple;
	bh=oq9EKKdg93DkudeARIZwtKEHxeGstm9HG6iU9TSazns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYfyV9aOQeuWM4zBeXd5w5uchIgkoDzxFZGZRkMIIW3BLc0UqqCcCqGujzcpWv5VQS4mMknl/RnsdRV/ILJqsWdTuTR1APisGLy9btyXQa1ZmcFi4jdrFbcah3Sr8VrP1cyKnxyucpuVoQaRhqhqAGQRsToQI0BZPmE7d+Gv1PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=386OtMbc; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="386OtMbc"
Received: from 8bytes.org (unknown [IPv6:2001:67c:1810:f051:57e6:3c1a:1909:f41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DCAFF5C784;
	Sat, 31 Jan 2026 10:23:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1769851388;
	bh=oq9EKKdg93DkudeARIZwtKEHxeGstm9HG6iU9TSazns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=386OtMbcoCIT9uW9KBmYrAmNmaWlPUrk7hOHA4+rnI0vTlSAnxSYkPrD9B9/Oy317
	 ZSjZBo1yAAqtcYgKAJ3pGMG1XML3bn22Z5+0srlen97ffG2+EP0hGkWxc1bWwjARjO
	 TzXqqymqQS51qamNH2Bkvl4ONngc4mSC+BvNRCbkukxHjdOFjDvGFYePMJlxiA7FIe
	 Kx9anYrtLNHT+fOIBOfQ17yN+CRLQMeCt8+lwvcAUpg8rCbOQxPOYCMt6qcVd+tHmL
	 GUZR1oKljzoHcH3wKN/kZS26Nu/QAqxsF9S7mFg92KeYqmdV6jAZSimQdVhyhCcrkK
	 Wq4MERPytoOGA==
Date: Sat, 31 Jan 2026 10:23:05 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jgg@nvidia.com, robin.murphy@arm.com, 
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, ncqb@google.com
Subject: Re: [PATCH rc] iommu/tegra241-cmdqv: Reset VCMDQ in
 tegra241_vcmdq_hw_init_user()
Message-ID: <x75l7ibr4o45dfdmdxlpefusks4maovaf3ugukcxuszd4dvmx3@w3hmrgo4e4qb>
References: <20260129224341.1594785-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129224341.1594785-1-nicolinc@nvidia.com>

On Thu, Jan 29, 2026 at 02:43:41PM -0800, Nicolin Chen wrote:
> Fixes: 6717f26ab1e7 ("iommu/tegra241-cmdqv: Add user-space use support")
> Cc: stable@vger.kernel.org
> Reported-by: Bao Nguyen <ncqb@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.
