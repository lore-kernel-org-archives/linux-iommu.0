Received: from mail.kapsi.fi (mail-auth.kapsi.fi [91.232.154.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F107515B0EF;
	Tue,  4 Feb 2025 04:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738642219; cv=none; b=A5SD5I8IL25mNFaJ7NIdC2k4KekEDhD/ld//CRHMA5lNbpQdmX7XzThomW7nrwvuNe7fL27FQ/esE+m5+++2D/GrPyBYXuHjOddpFIIiTaeio0ha6YnPnDmzO0Y7tDjj0JUTbIG2djTgjCO6B1vDbYyH+11xQ/5N6CcYKtKQW+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738642219; c=relaxed/simple;
	bh=qLo8L2lW+kMEq3SUWVXgTO7LcDx4K4hN2Vl1L8rWu2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlSn/AieG6ShVqYz4xyFM6pVybS3mDaxwHZSR/6TV+zSUzldT0LFvALUC11r7mRDAa52xCRBCRmRBjD1yf5S3j9E+G9hweDdOuItJGfhzFEs4syTorbbEbfUGRlLhKhv7+c4uwbzN234BrvpPfz2dQBZ6KOCEGNqjialA29hcB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kapsi.fi; spf=pass smtp.mailfrom=kapsi.fi; dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b=GOli/PF0; arc=none smtp.client-ip=91.232.154.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kapsi.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="GOli/PF0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cDSoQCx+YWucyUawTOd2KLxTvpzNLZU6esYxNg6b0w0=; b=GOli/PF0/fFp9urii6kmTuIldT
	D2PMvWnBsdZQfqCZAl2NtCjrykw07t4j7makJ20wOf/JXGzNKBDgO3rvUwpItw8N10PZv/hRx4gC7
	jVnXOcQS7VZLbvmwnO9pY3YoKBfmziT3DC7SSPdqKErqO7RjS7t0SvZO8TtZAzKVhOOEjvzbJH7RL
	DzijZx2c2KHgh87Lmiz7Rk1VKZtaqmZuk71UsRyzTkLIq+DoVnsdIYLcwfhN5DTfU5hww0zUISygZ
	T2mxQJ7Nnpu+g6RCgHFT49RAIAIXpR0rjsTlvgOw+7qh2Cc+Pw8TB1Aa6pNA7byS6VDMZiog9a1hk
	aa+Y9yDw==;
Received: from [2404:7a80:b960:1a00:5eaa:b33c:a197:a90f]
	by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <cyndis@kapsi.fi>)
	id 1tf9aV-00FXkK-1L;
	Tue, 04 Feb 2025 05:26:59 +0200
Message-ID: <ff901d60-dd54-440f-a0da-4b72052eafd6@kapsi.fi>
Date: Tue, 4 Feb 2025 12:26:46 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Invalid gather when using Tegra210 media engines
To: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>
Cc: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, thierry.reding@gmail.com,
 vdumpa@nvidia.com, joro@8bytes.org, will@kernel.org, jonathanh@nvidia.com,
 baolu.lu@linux.intel.com, jsnitsel@redhat.com, jroedel@suse.de,
 regressions@lists.linux.dev, linux-tegra@vger.kernel.org,
 iommu@lists.linux.dev
References: <c6a6f114-3acd-4d56-a13b-b88978e927dc@tecnico.ulisboa.pt>
 <20250203170617.GE2296753@ziepe.ca>
 <4ea1a48c-9020-4793-ac9b-b51fc289e442@tecnico.ulisboa.pt>
 <20250203174331.GF2296753@ziepe.ca>
 <a0f776ba-bfd2-41fd-8370-14818b86bfbe@arm.com>
 <20250203191346.GG2296753@ziepe.ca>
Content-Language: en-US
From: Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <20250203191346.GG2296753@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2404:7a80:b960:1a00:5eaa:b33c:a197:a90f
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

On 2/4/25 4:13 AM, Jason Gunthorpe wrote:
> On Mon, Feb 03, 2025 at 06:49:07PM +0000, Robin Murphy wrote:
>> I'd hope the historical reasons for not supporting IOMMU_DOMAIN_DMA in
>> tegra-smmu no longer apply, given that all the default domain stuff has now
>> been integrated into host1x for the newer arm-smmu based Tegras.
> 
> Indeed I do see appropriate looking calls to the normal DMA API, and
> the other mapping path is conditionalized by !host->domain.
> 
> So, why didn't it work for Diogo? Even in identity mode the DMA API
> will return correct DMA addresses and the !host->domain path will skip
> mapping them.
> 
> Poking around I wonder if there is some assumption that if other parts
> of the stack, maybe the DRM driver, are using the special domain than
> everyone is? It seems to blindly pass around IOVA without really
> checking who is consuming it.

I'm not sure where that would be, but it's certainly possible given that 
this combination of code paths wouldn't have been tested.

> 
> Christian was telling me DMABUF had some drivers that made the
> (incorrect!) assumption they were all sharing translation.
> 
> It does seem like a nice project for someone who has the hardware to
> rip out all of this custom domain stuff and just have the iommu layer
> setup a shared dma-iommu domain.
> 
> Jason
> 

This has been a long-standing project. The issue is that some boot 
chains set up the display expecting identity mappings, but if dma-iommu 
domains were enabled, they would enable the IOMMU without mappings 
before the display driver gets to run. Perhaps Thierry knows what the 
missing pieces are.

See 
https://lore.kernel.org/linux-iommu/20220512190052.1152377-5-thierry.reding@gmail.com/

Cheers,
Mikko
