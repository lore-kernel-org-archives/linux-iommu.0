Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE6513541B;
	Wed, 11 Sep 2024 06:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726036991; cv=none; b=SKfDU0VmdOJsWf/2PblxZ4pTkQeNG8EAtqy0fN8fu2eouN0zP6msQv0A9UjVyKzAHdKoIourXgQDSdaN8tglMLbcQNwnCm84m4jhrC1TOj+cLhE2xI09lwEnjqAuh3YlWrLDk6wA88/M3FJkaHQh1OY3OLlRm8Es9jeeEI8kAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726036991; c=relaxed/simple;
	bh=fW349gFSmtmLbIcFEoePaAvvBOhxAa3lXYuq7nC8458=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+NxcRIlHl4D9VaT60oQVX+Mm+3XGmn/OesSHN5kGToCHuMCgj4WQDrRrPZ7Lgpov0uV0WZ4go1QXQ89XPGpFgRGdUk5erG8fnY3icZKL1WHTFfZreJiBpMIZhWY6YTC+FQeB5lt9qNq/UVGGxEcaxVWasLGzsLwMeLmWXnJ3Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZriODaia; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZriODaia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C57C4CEC5;
	Wed, 11 Sep 2024 06:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726036990;
	bh=fW349gFSmtmLbIcFEoePaAvvBOhxAa3lXYuq7nC8458=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZriODaiaPIl3YmlfALtDDV9MtOoPQ2CI8bck7GjCppeuzeavHzbXYLLlog0xliiD5
	 vvf1/2CCdaV7QJ4D+PTYjiSw0I4DJlrkcPwZB7QEs8f9TbbJNNpG4J8xrkRHVvI509
	 kFKhpDb2bJUi/iv97ROEZbmnPRXwcMeduQcZZUNFHI84rPgK3Rn2E3zW2guDsGD6tF
	 zWCGm1DJ7HpGKJH7n/ebQnqRLTMKtaHOvmSUd0d+FLvHnB9XpcNrCGYUDq5n3/v8ns
	 FOdkDnfMBYWagsOxrFiQAvD0ZDFquB+1trV84+CIg7uylzr6JiGflFouF+Q0ujY30A
	 RsFgDoQ3rFPIA==
Date: Wed, 11 Sep 2024 09:43:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	regressions@lists.linux.dev, kernelci@lists.linux.dev,
	kernel@collabora.com
Subject: Re: [PATCH v4 2/2] dma: add IOMMU static calls with clear default ops
Message-ID: <20240911064305.GD4026@unreal>
References: <cover.1721818168.git.leon@kernel.org>
 <c3179690b16d790d5bfd7d0afabac9b90922ec28.1721818168.git.leon@kernel.org>
 <181e06ff-35a3-434f-b505-672f430bd1cb@notapiano>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <181e06ff-35a3-434f-b505-672f430bd1cb@notapiano>

On Tue, Sep 10, 2024 at 03:01:05PM -0400, Nícolas F. R. A. Prado wrote:
> On Wed, Jul 24, 2024 at 09:04:49PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Most of the arch DMA ops (which often, but not always, involve
> > some sort of IOMMU) are using the same DMA operations, but for all
> > modern platforms dma-iommu implementation is really matters.
> > 
> > So let's make sure to call them directly without need to perform
> > function pointers dereference.
> > 
> > During system initialization, the arch can set its own DMA and in such
> > case, the default DMA operations will be overridden.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leon@kernel.org>
> 
> Hi,
> 
> KernelCI has identified another regression originating from this patch. It
> affects the same platforms:
> * sc7180-trogdor-kingoftown
> * sc7180-trogdor-lazor-limozeen
> 
> But this time the issue is that the venus video codecs are failing to probe as
> indicated by the DT kselftest:
> 
>   not ok 184 /soc@0/video-codec@aa00000
>   ok 185 /soc@0/video-codec@aa00000/opp-table # SKIP
>   not ok 186 /soc@0/video-codec@aa00000/video-decoder
>   not ok 187 /soc@0/video-codec@aa00000/video-encoder
> 
> The kernel logs show the error:
> 
>   qcom-venus aa00000.video-codec: probe with driver qcom-venus failed with error -5
> 
> A quick ftrace run showed that the error comes from dma_set_mask_and_coherent()
> in venus_probe():
> 
>   7)               |  venus_probe() {
>   ...
>   7)               |    dma_set_mask() {
>   7)               |      dma_supported() {
>   7)   0.989 us    |        dma_direct_supported(); /* = 0x0 */
>   7)   2.864 us    |      } /* dma_supported = 0x0 */
>   7)   4.636 us    |    } /* dma_set_mask = -5 */
> 
> For comparison, here is the ftrace run with the commit reverted:
> 
>   7)               |  venus_probe() {
>   ...
>   7)   1.093 us    |    dma_set_mask(); /* = 0x0 */
>   7)   1.041 us    |    dma_set_coherent_mask(); /* = 0x0 */
> 
> The issue is still present as of next-20240909 and reverting this commit fixes
> it.
> 
> Happy to provide any other details necessary.

Thanks for the report, I'm looking into it. However, it is unclear to me
why my patch is causing this issue. The change in dma_supported() should
produce WARN_ON [1] if new path is taken, otherwise, we return to
previous behavior.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/kernel/dma/mapping.c#n822

> 
> Please add
> Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com> #KernelCI
> when fixing this.
> 
> #regzbot introduced: next-20240822..20240823
> #regzbot title: Venus codec probe regression for sc7180 platforms in dma_set_mask_and_coherent()
> 
> Thanks,
> Nícolas
