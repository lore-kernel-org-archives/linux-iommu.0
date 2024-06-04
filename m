Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670A5145350
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501957; cv=none; b=A6Tl0oGvmYbISi7TEWk6gTRUu6LShSBA4V50JqfWBQ7Wn5OgOBmlKUTwtS5RA3qjn57f3mZyCB8fHqFNVT463M/fhY6LiwhNj01QoY6oRPLCJOuXVXDsSnlYh0jPN+TuN7CE67c3B6KD19n78djfR41vb3XBCg30fD4gSeMFkEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501957; c=relaxed/simple;
	bh=ZbQPMEGaavCbZlw2bBVGXiC2roeAmgW++Ht673K5p0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0Ql5DY/aYQh+o5IUIRbdG6zuHwJWc068ccOevgEl3+KqQzxYcObDZGaMMKKUQCDxpok/6uqXQBRwTG+fypkrWFD0u9eADkOD471IeFwqiKDLJ/xkoafr5Vh3JY5acOiwmofsY9uVdfz+NujEXI++eRRbJ3UbOAHnrpPzr2eZiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=pIlEmUB0; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="pIlEmUB0"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6A8971C7AB5;
	Tue,  4 Jun 2024 13:52:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1717501955;
	bh=ZbQPMEGaavCbZlw2bBVGXiC2roeAmgW++Ht673K5p0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pIlEmUB0/IwzBzpRPBng3UKnPlOs1q2Mgt/vZqeX9EtPdvdtB7pSahDg+PW+7KAlH
	 gTdkTx9fpgB1FELs5eMCLqEvGAIPPU6JChTvMvw/ITdeR5LkGkZK901Y3IAGkjOBOW
	 Wki07H2NkjFvZOrNgGkh84cLeymm1Gp1zim7MHo43oX+qwuTvi3tp4yoJSnn4xIUM6
	 PB1X91Pg8+acrdgzPon1DaHPWlU1S9/u1H84ctfwOc+EsnZw4dcSBu1D2psHKytJ0u
	 LM8AIa+ckMhvSH4eQjyffIhk1SNvOhgvmmFjwqHCGRHqMUTANC7m2SaDPKgJp9QlGs
	 U6rI++dPUNa7w==
Date: Tue, 4 Jun 2024 13:52:34 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux.dev,
	will@kernel.org, linux-kernel@vger.kernel.org,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] iommu/dma: Fix domain init
Message-ID: <Zl8AArc94N6Tkmhw@8bytes.org>
References: <721fa6baebb0924aa40db0b8fb86bcb4538434af.1716232484.git.robin.murphy@arm.com>
 <jrzrf3vz2rhcrwazsxuljuyhru4mstyzuhjx4uawcfmjlmvipd@lu6usxz22ved>
 <02ebbb90-84bc-4d8c-a7aa-94cd78e0a2a5@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02ebbb90-84bc-4d8c-a7aa-94cd78e0a2a5@arm.com>

On Tue, May 21, 2024 at 04:14:50PM +0100, Robin Murphy wrote:
> Joerg, please shout if you'd like a resend for that.

No need to re-send. I applied with the correct commit-id.
