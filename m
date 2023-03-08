Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA25A79DA
	for <iommu@lists.linux.dev>; Wed,  8 Mar 2023 16:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71BAC433D2;
	Wed,  8 Mar 2023 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678292305;
	bh=MxcbmAJFBs/SYZwP3KHVRqCJ7HeXBMCKu6PhXK8//Lc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pbjKz5LEZ/qSDvAGA6yFoNxADMEVBhmPAOhHz/qr9SRaohOG3DDsNa2Q2Ql93k24M
	 uKpHJ4gSwCNW6qPSWAStSeBGlBnPN6+Pi/kPtcGuyqKsf7mtmG0UsrY9nx8bXCeypP
	 XbCN9uxC/fNYdghg5zQKA9XXia230DgZsmqQwoq8aq+ie2Ul3jCIBNZQESBeHP/fx0
	 S3WKghaaofugKb+FQ/8U0LP3qRmem5g1Bx1BrHZftXCuzFOrOu/ph/KFbRl+/3e8x3
	 BVqjhOppGQWDN5VMfPSGaWryxeKWf8kdm5pbyR8ztWiv/NuaE2t/DfcWmt5gLDC7tu
	 UjLngCxoGbmeg==
Message-ID: <5093bf43-32b0-2c15-ff18-8ad16bba3635@kernel.org>
Date: Wed, 8 Mar 2023 10:18:23 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] iommu/fsl: fix all kernel-doc warnings in fsl_pamu.c
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Aditya Srivastava <yashsri421@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev
References: <20230308034504.9985-1-rdunlap@infradead.org>
Content-Language: en-US
From: Timur Tabi <timur@kernel.org>
In-Reply-To: <20230308034504.9985-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/7/23 9:45 PM, Randy Dunlap wrote:
> Fix kernel-doc warnings as reported by the kernel test robot:
> 
> fsl_pamu.c:192: warning: expecting prototype for pamu_config_paace(). Prototype was for pamu_config_ppaace() instead
> fsl_pamu.c:239: warning: Function parameter or member 'omi_index' not described in 'get_ome_index'
> fsl_pamu.c:239: warning: Function parameter or member 'dev' not described in 'get_ome_index'
> fsl_pamu.c:332: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * Setup operation mapping and stash destinations for QMAN and QMAN portal.
> fsl_pamu.c:361: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * Setup the operation mapping table for various devices. This is a static
> 
> Fixes: 695093e38c3e ("iommu/fsl: Freescale PAMU driver and iommu implementation.")
> Fixes: cd70d4659ff3 ("iommu/fsl: Various cleanups")

Acked-by: Timur Tabi <timur@kernel.org>

One a side note, I'm pretty sure the @freescale.com addresses in the cc: 
list are invalid, so I've removed them.
