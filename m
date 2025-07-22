Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1D86AA7;
	Tue, 22 Jul 2025 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753207134; cv=none; b=gy+B4g+gyD0oRUHvU6bVYhGY3JytohuZ/FQZ+eNLrhZRXhf1m6UOxzUa6jRJHRecahORgqI6EYXCPtg6RqiinvWcJv99RDeol4nfsJLQnYPpeZokYtLXxLPmxh268chs3ZuXI98mIGH/kXvea/EvGZ7fPq3UUkr3SscAkNyidE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753207134; c=relaxed/simple;
	bh=ylvcBPJABXu+03i7ZBNq0T1cr0K5TTIgIEk/FSCIqFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2q9pF2nAMPSfH3gLbUvMRBnMEeT5TyohSUOHTuKsaUayUYn4EqZMQoMq+MV4AyaVqPE3NKMOxPIttAK45tY4i+25uv0LRoQ01ktqCQs4YAVjO50c6+Z7WIn7ZlVdO6obTGZbFkQ4LIuY+bIP9vTIH/+txgEVwvNvh+ao8NSW2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCBvuJj9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCBvuJj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78607C4CEEB;
	Tue, 22 Jul 2025 17:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753207134;
	bh=ylvcBPJABXu+03i7ZBNq0T1cr0K5TTIgIEk/FSCIqFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uCBvuJj96KFIfGI/9p6ZoUxKgRS9QbKmh/Q82dxC5SEcgS0CfTeu2LHXqnoW1cnkN
	 h/Lw4rTVj0ZgE1mm3VHd/QSf4c3jYb5RdxEkghw6vrf2tbtOpgzIp7YomaZ6Ws7eAS
	 RE5y89Sp8+E6oBnI9Tdv1WU/oGOryyOd39vZKIcoZtsRpkBXcRS1Db/rNYT4Z6gCKP
	 HcGHXGmWwHwBuOczTqb8uSvSMcmElh1At8fEFAe/jArQMlP6VPK2KiwbJFUdcVHcXf
	 Tkrhtj2gtWwGyqGuEqrdzQv2rBhgwoh1qGHrgIUqGd24Mrh1lfdgHkjoSlgkJQoGI0
	 4693sn5RV7hkw==
Date: Tue, 22 Jul 2025 18:58:49 +0100
From: Will Deacon <will@kernel.org>
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
	robin.murphy@arm.com, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: replace snprintf with scnprintf in
 dmar_latency_snapshot()
Message-ID: <aH_RWQ_YqlydOkKH@willie-the-truck>
References: <20250722131117.2739-1-ImanDevel@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722131117.2739-1-ImanDevel@gmail.com>

On Tue, Jul 22, 2025 at 09:11:17AM -0400, Seyediman Seyedarab wrote:
> snprintf returns the number of bytes that would have been written,
> not the number actually written to the buffer. When accumulating
> the byte count with the return value of snprintf, this can cause
> the offset to exceed the actual buffer size if truncation occurs.
> 
> The byte count is passed to seq_puts() in latency_show_one() with-
> out checking for truncation.
> 
> Replace snprintf with scnprintf, ensuring the buffer offset stays
> within bound.
> 
> Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> ---
>  drivers/iommu/intel/perf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
> index adc4de6bb..cee4821f4 100644
> --- a/drivers/iommu/intel/perf.c
> +++ b/drivers/iommu/intel/perf.c
> @@ -122,7 +122,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
>  	memset(str, 0, size);
>  
>  	for (i = 0; i < COUNTS_NUM; i++)
> -		bytes += snprintf(str + bytes, size - bytes,
> +		bytes += scnprintf(str + bytes, size - bytes,
>  				  "%s", latency_counter_names[i]);
>  
>  	spin_lock_irqsave(&latency_lock, flags);
> @@ -130,7 +130,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
>  		if (!dmar_latency_enabled(iommu, i))
>  			continue;
>  
> -		bytes += snprintf(str + bytes, size - bytes,
> +		bytes += scnprintf(str + bytes, size - bytes,
>  				  "\n%s", latency_type_names[i]);
>  
>  		for (j = 0; j < COUNTS_NUM; j++) {
> @@ -156,7 +156,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
>  				break;
>  			}
>  
> -			bytes += snprintf(str + bytes, size - bytes,
> +			bytes += scnprintf(str + bytes, size - bytes,
>  					  "%12lld", val);

Should the check of the return value in latency_show_one() also be
adjusted so that 'ret <= 0' is an error? I couldn't convince myself
that the string in 'debug_buf' is always null-terminated if ret == 0.

Will
