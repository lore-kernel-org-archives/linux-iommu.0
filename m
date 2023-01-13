Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77EA2F2A
	for <iommu@lists.linux.dev>; Fri, 13 Jan 2023 15:53:13 +0000 (UTC)
Received: from 8bytes.org (p549ad69d.dip0.t-ipconnect.de [84.154.214.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 037DC262301;
	Fri, 13 Jan 2023 16:53:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1673625193;
	bh=rqSkiCNdAW1Nu68VqnoVrHG9ieUZXnhoFAexVyFJefE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qfHlZA2tc1HaeVrbA8EC2cCh/mLSbxKPuEtO/aGyLZtlPVHQ81c+kq4d2UQ+i+JKr
	 v3lHH2bKuta62NzqdXdBmz4FtaFLSjLe8j/5ndMJoBJHYTn9/cB/oavp2yJr86awkN
	 bvN6NE2E1WzWPghDhl5O3GZg3FF+GRAx4UgBK/4ilGCz/zh/Fhw0caII94CKqAM3pp
	 JM3zM7tBUUqP65EpK6vmrRp7CO1bn4MnVhnkxQ1UP0ZCfmfOSGKR3VpCzwJtpH5AGj
	 2YAip7338DjZKMfY8c05qujIC3UwGKmjy9kM+RiQF8YcL4NKplv2M8fL2kpKlLBOVn
	 82fx4NDJKKMhw==
Date: Fri, 13 Jan 2023 16:53:11 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] iommu/amd: Do not clear event/ppr log buffer when snp is
 enabled
Message-ID: <Y8F+Z6EIwkEsAk6P@8bytes.org>
References: <20230105091804.42506-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105091804.42506-1-vasant.hegde@amd.com>

On Thu, Jan 05, 2023 at 09:18:04AM +0000, Vasant Hegde wrote:
> -	memset(__evt, 0, 4 * sizeof(u32));
> +	if (!amd_iommu_snp_en) {
> +		/*
> +		 * To detect the hardware errata 732 we need to clear the
> +		 * entry back to zero.
> +		 */
> +		memset(__evt, 0, 4 * sizeof(u32));
> +	}

This needs a comment that the buffers are not writeable with SNP
enabled.

>  }
>  
>  static void iommu_poll_events(struct amd_iommu *iommu)
> @@ -736,10 +742,11 @@ static void iommu_poll_ppr_log(struct amd_iommu *iommu)
>  		entry[1] = raw[1];
>  
>  		/*
> -		 * To detect the hardware bug we need to clear the entry
> -		 * back to zero.
> +		 * To detect the hardware errata 733 we need to clear the
> +		 * entry back to zero.
>  		 */
> -		raw[0] = raw[1] = 0UL;
> +		if (!amd_iommu_snp_en)
> +			raw[0] = raw[1] = 0UL;

Same here.

>  
>  		/* Update head pointer of hardware ring-buffer */
>  		head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
> -- 
> 2.31.1
> 
