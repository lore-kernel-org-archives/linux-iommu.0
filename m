Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D9AC2E0;
	Tue,  3 Jun 2025 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748969532; cv=none; b=JmIqc2AUMfKZfih+NnFAB7uNZI/VWI0NGL+rgPNhUitnZ27nbzCLCQcSj+rWwtsB6mzX/KwD0wtR5Wzh3luL7pSyT9Du0o7JjVRtkgp5z2AFSrlfZbkamn03cvUxKmOdrXI9Xqwu4jklekV7JzBIFLVVVl4cPlNu4Gkgr7xGzNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748969532; c=relaxed/simple;
	bh=BEdyI613Wia/ZTJv8cLxtkDLc3JEgRwZIE8nbEtxdp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9sepzqJ/g87FZPIAwG1vahEKyngMqyJmDdRyFWWwWl3pv8zy0/96LHQLlazMgVN1QNQdFAB7yGESjKalNpDJ3utt/qBlLoKTcuSw06k81QhzwgLl93T/e5tZ/9/6U/ZNj9C9BaR+9ZDsg0lxsrhuZANibyzwdOBCV6DN78w0rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=jI7LWKBk; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="jI7LWKBk"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id 29FD660029AB;
	Tue,  3 Jun 2025 17:52:06 +0100 (WEST)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id DIpdyDOjBGPF; Tue,  3 Jun 2025 17:52:03 +0100 (WEST)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [193.136.128.10])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 472AA6000239;
	Tue,  3 Jun 2025 17:52:03 +0100 (WEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1748969523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pW986tRbkWUUWIgebSvT0wxSNc6gzHLIJHoRP9TXW4Y=;
	b=jI7LWKBk6xn6Zpi/utxZGLBrjTitzKmTpgQQyRjSjWXKAKgjoWBd68bXX8ayMia3giLsEQ
	MtdsIDSHIBqf8AHxEOldBHfkG4vCmTyl2ZS9A3QevVWS+B/PB1ad+hSCISHaSklaPARP52
	3+cIaCSy2hMC/AgemzLr2oT6XDquCl4=
Received: from [IPV6:2001:8a0:57db:f00:3ee2:38aa:e2c9:7dde] (unknown [IPv6:2001:8a0:57db:f00:3ee2:38aa:e2c9:7dde])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 2506C36008A;
	Tue,  3 Jun 2025 17:52:02 +0100 (WEST)
Message-ID: <46ef896e-9b73-437f-bfa9-4dcae5089028@tecnico.ulisboa.pt>
Date: Tue, 3 Jun 2025 17:52:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] EMEM address decode error when using Tegra210 media
 engines
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, jonathanh@nvidia.com,
 baolu.lu@linux.intel.com, jsnitsel@redhat.com, jroedel@suse.de,
 regressions@lists.linux.dev, linux-tegra@vger.kernel.org,
 iommu@lists.linux.dev
References: <62e7f7fe-6200-4e4f-ad42-d58ad272baa6@tecnico.ulisboa.pt>
 <20250603153257.GB407166@ziepe.ca>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
In-Reply-To: <20250603153257.GB407166@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/3/25 4:32 PM, Jason Gunthorpe wrote:
> On Tue, Jun 03, 2025 at 04:06:47PM +0100, Diogo Ivo wrote:
>> Hello,
>>
>> Commit 50568f87d1e233e introduced a regression when trying to use the media
>> accelerators present on the Tegra X1 SoC.
>>
>> I came across this regression when testing the branch [1] that leverages
>> the NVJPG engine in the Tegra X1 for decoding a JPEG file. After commit
>> 50568f87d1e233e we see the following error messages after submitting a job
>> through the TEGRA_CHANNEL_SUBMIT IOCTL:
> 
> Maybe this?
> 
> @@ -567,7 +567,7 @@ static void tegra_smmu_set_pde(struct tegra_smmu_as *as, unsigned long iova,
>   
>          /* The flush the page directory entry from caches */
>          dma_sync_single_range_for_device(smmu->dev, as->pd_dma, offset,
> -                                        sizeof(*pd), DMA_TO_DEVICE);
> +                                        sizeof(pd->val[0]), DMA_TO_DEVICE);
>   
>          /* And flush the iommu */
>          smmu_flush_ptc(smmu, as->pd_dma, offset);
> 
> It is the only mistake I was able to notice.
> 
> But I'd be puzzled - I'd expect bigger sizeof would make it slower not
> broken.. Though your crash sure looks like either missing cache
> coherency or a bad PTE construction.
> 

With this change there is still an error:

[   21.794016] tegra-mc 70019000.memory-controller: nvjpgsrd: read 
@0x00000000ffffbe00: EMEM address decode error (SMMU translation error 
[--S])
[   21.804409] tegra-mc 70019000.memory-controller: nvjpgsrd: read 
@0x00000000ffffbe00: Page fault (SMMU translation error [--S])

the difference being that we only get it for one address compared to the
previous log.

Diogo
