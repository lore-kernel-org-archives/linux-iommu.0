Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B54395AE6;
	Fri, 25 Sep 2026 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350602; cv=none; b=geoDIX1iLs+pMNKaUNw+xvBMvVxE/TrIK0RheOFTm1vaEIxGtbY9zl1Fky8luNlWZ4NB3wDZS6mlClmPH7oAaZqbrFRJGEFSjvT9PMDhh9lGh2HSxGdA6ShlOPrIU1xJm+ZRFKpuN9FYVL4dIl8BjHkc7jYNUkgTo5yG9+iijq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350602; c=relaxed/simple;
	bh=NevHYeeyT9ZUafgWCjY6Kak9YcENAr3B7oLhCBKMfvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYSw7RQRqU8AlgJKDHx9FXiiMp67IHfhS9FxH9bSM3Dir1CAjqUK+0khB2us6Cs15qt12pWDG/dap4JRHDXf1hDHFB3zs2XA+rsrK6L8wbAWiqbTUTHjs/kv6J5vROIdYolPZXPVZFAwLBu+C7r/NoiyxmdSux9+dQZoArHsqdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=UlWdXKNL; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="UlWdXKNL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UDPeS3KsTd5jTAjH7wQqYPnOP77l/2BPC3nDAy/sItU=; b=UlWdXKNL4bEfhh3dNLYxyqQhoi
	evNMj8YqERVvjzibqqueJBqM61g/u8W6Ha19QAVlyCasHGObLS2+rlS8ATPkNVRTF5fubVCjvUFhO
	3nzn+8jrAcSHjgBded2+r8IRMEuZagFNzlADnLnFIhE9oPg3ZcuyDk2IPmGQAm6hUJeqYYk3TbJu0
	QpRzS4nSe/hGjAvCHus/qu7IsPIfcaELfWJWazaHXUA0KG+84j6lBUBnlyvxZH1JzzHRI122x7l3h
	omLug+fUPTtpQ22w3t0XGia48Ouida2ZB4b9Y0FF1tEv73lX+OB8i4ZkbC0VQweOBmhLG5Q3ONb8o
	RT+sg1WA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xA7yH-005OzL-39;
	Fri, 25 Sep 2026 15:36:22 +0000
Date: Fri, 25 Sep 2026 08:36:15 -0700
From: Breno Leitao <leitao@debian.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	Krishna Reddy <vdumpa@nvidia.com>, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, Ashish Mhetre <amhetre@nvidia.com>, 
	Shameer Kolothum <skolothumtho@nvidia.com>, Yuanhe Shu <xiangzao@linux.alibaba.com>, 
	Kyle McMartin <jkkm@meta.com>, Usama Arif <usama.arif@linux.dev>, kernel-team@meta.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] iommu/arm-smmu-v3: Default queue depths to one
 page in a kdump kernel
Message-ID: <araUqf6BsJHP7BN1@gmail.com>
References: <20260925141532.1274962-1-kirill@shutemov.name>
 <20260925141532.1274962-3-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925141532.1274962-3-kirill@shutemov.name>
X-Debian-User: leitao

On Fri, Sep 25, 2026 at 03:15:30PM +0100, Kiryl Shutsemau wrote:
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> All three queues are sized from the maxima the hardware advertises in IDR1
> and allocated at probe, up to 4 MB each on a 4K-page kernel. The capture
> kernel already disables two of them: arm_smmu_device_reset() drops
> CR0_EVTQEN and CR0_PRIQEN. It still allocates both at full size.
> 
> A kdump capture kernel runs from a small crashkernel reservation, and every
> SMMUv3 instance pays that cost again, up to 12 MB apiece. It goes to queues
> that either serve the handful of devices used to save the dump or are
> switched off outright, and it is memory the dump itself needs.
> 
> Size all three queues at one page worth of entries when is_kdump_kernel().
> The queues carry commands and fault records rather than DMA data, so dump
> throughput is unaffected. A shallower command queue only bounds how many
> commands may be in flight before a sync, which does not matter for the few
> devices that save the dump. The cmdq_max_n_shift parameter therefore does
> not apply in a capture kernel.
> 
> Suggested-by: Kyle McMartin <jkkm@meta.com>
> Assisted-by: LLM
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>
