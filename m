Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F86286A4
	for <iommu@lists.linux.dev>; Fri, 31 Oct 2025 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919166; cv=none; b=Pe3fHqhtyZXOPRllmcy/iPreBCY+CRBMhqAWiai81cSNadwKiV/R6Cfyt5mEfgDjH6/1NV8uZnlYEMpbsbTEj+O3uI7bh4y79257r/0MrfnaSTG5ueRhBq42M9WcHWVsz+uLEBgOFxcTkX1Y+UdcsPe6/TUM4f2Q8+WuGUnftDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919166; c=relaxed/simple;
	bh=UgwAGEmKdjITNG+9gHd/BxzzuGXWl65DOl0uT8CW+5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElxhJGbi7aqiG1m/lTfPI/iF5oa95o0HpgAqampdpyixIqr9K6OAGmpUwwZxABxxThMqBM2ctiWPJYeOr9kzf452/7+FC1gny91HyZpihlcJ5Eo8zFROk3qBKNYjru+DzNCznDXQ042yoc2WNe6Svms4LOtBkB9HYhPqYM9qLoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbw4fqp0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbw4fqp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A1DC4CEF8;
	Fri, 31 Oct 2025 13:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761919166;
	bh=UgwAGEmKdjITNG+9gHd/BxzzuGXWl65DOl0uT8CW+5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bbw4fqp0Y7A/Sim9X1XHIaqn8vscRIFRWc0nLVyaAWJlLK209JL2bFqOIdXKtElxn
	 rjURlJliio+EoVuksvu+arYVpdFzXfyNsl37O7aDCPlXCFKZv/WI0rMS1Jg3uYqCXM
	 jg/OMevdi9TTzGvEqjynoE8fR6xs8CijABvN/tb9ZYD+w8aveKX2wO0L0yMbjrpbhv
	 drlZrKHFnm4aVY50mPxcHZZEnGGmDgq+yw/S56M8F3W8lfBxp0CiL1Hb8p+4LtPuag
	 o9dLlvkY9ngs2guME5iqNBSSaY/851RwhayHPPt8y9RrfpiChVKNFneitUNmgKAeed
	 /F3WpdBae5iFg==
Date: Fri, 31 Oct 2025 13:59:21 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: zhang bruce <brucezhang5337@gmail.com>, joro@8bytes.org,
	iommu@lists.linux.dev, chenglingfei22s@ict.ac.cn
Subject: Re: Question about IOMMU and streaming DMA
Message-ID: <aQTAuWbkYWtJ3SPB@willie-the-truck>
References: <CAJZPk7T0K51zBKNNQXw2qx9OYrPa8BJ6jQTvOM-YrxwBndPbzQ@mail.gmail.com>
 <ddb99a47-3869-4605-8404-807cdcb2d07e@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddb99a47-3869-4605-8404-807cdcb2d07e@arm.com>

On Wed, Oct 29, 2025 at 02:52:11PM +0000, Robin Murphy wrote:
> On 2025-10-28 12:45 pm, zhang bruce wrote:
> > Hello,
> > 
> > The driver invokes the dma_sync_single_for_cpu API to access the
> > current state of the dma_buffer data.
> > However, dma_sync_sync_single_for_cpu does not unmap the IOMMU
> > mapping. In this case, while the
> > driver is reading the dma_buffer data, can the device still modify the
> > data concurrently?
> > 
> > If the IOMMU mapping remains valid, how is the ownership of the buffer
> > transferred from the device to the CPU [1]?
> 
> The same way it is when there is no IOMMU at all. Consider that a
> sync_for_device doesn't unmap the CPU's view(s) of the buffer either - the
> "ownership" here is purely a logical notion between the device driver and
> the hardware it controls. It's not the IOMMU layer's responsibility to try
> to police whether drivers are making use of their own DMA buffers
> appropriately; the IOMMU's main role is to prevent the device from accessing
> any other memory that *isn't* one of its currently-mapped DMA buffers.

That being said, I wonder if something like that would make a useful
debugging option?

Will
