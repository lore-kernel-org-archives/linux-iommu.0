Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43727315D28
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420654; cv=none; b=NQHN8x0JOn5ROvGq8PPfIRygZJf36n5VAkZKU6TIyH4U8u6JeNJdO7oKpgdu0msalb0dmyvsWH2jXxJ/3PyJp49BjtYzSOZ12NbAn+djapJEUB51Dz7yh4iqdiZHLo1hy25WgoDYFE1xW4rj2y70W5mQwMOMieIXKOHpJoklYNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420654; c=relaxed/simple;
	bh=aGWJlZstehGLpkjoB7+w3nJ8YhYkNbuPn0sL7tHggKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bT7KjrzTEiw0w9oSLel2tgi5IyWlTYDkFOl05SOM8pIl7Y+9CkmOXgMZhlNk84TfJXlf8qg3kqT/6qJ0i6LP2MaoFE8EFREQzSU991QB4UOIcyxwDoi1In5H9mqE/VuYy7K0/jJmhCfjL1xL8E+9ERltV4D/9rihV4Yemp9C2a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pVIttPtY; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pVIttPtY"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-509134ab2d2so21606701cf.0
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773420652; x=1774025452; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/doz3hoJDmOCMvEb7UHEWDCTRb2+6/dluUUy7y6NpPU=;
        b=pVIttPtY6tDF08G+3yg+aQGFnSU94qiP3KnYp+u11HQrOcZNfX0wBg8WJxFqxdFYI8
         27mkb0agMtiKYc2bqizpd3eK75PVEwCP6BQny6r936a9ca43RD6aEMSNq6AT1CmvBBDt
         JQiSKrQclBcSEIbXS5qcr/H0ozERbTQqH9dG78AsYFHAvEQPCYWlqSrQki5NF6A9BEpD
         0pZjD6NAphYH4GFWGQL9bjh9JQrEhcy53fflceslM0KcexbvEv9pSjIWJ8iRButShEeH
         HGc1M7RlViYihJtQmr7UOUyHIX2D77t99uwmZAS0lqwuzydwpLj2H2Ksu9WZlNz1k0z8
         6uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773420652; x=1774025452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/doz3hoJDmOCMvEb7UHEWDCTRb2+6/dluUUy7y6NpPU=;
        b=R+aDf/fele1cltlNU9+X2VIjoDESPaQxBABLnDvmpfTW/ZmS1Rjd3XYRe0dG9RpiFO
         SQPKj0DMHXqkLtloiOil6kFrWnjyH+a007WJZOpcV69V3aH/aVL86Zh/PDwB2HJNDlUE
         kSo817v1fH4cooW4fzF2J5AdQ19oNk6DhTXyAQAsbwt3MBJuQO74NC/OFX2lgC4pEqEc
         +wtqkDc0KDUnNwhovytCmYpj/PXw9mf1cAaPpH6aWurUNXNkVvukCYS4WfUlpgB9ixHw
         Fwkpt6CL+oKEeb3Lhcz7yoSC3BA6j8N7MXqGanOXKb4XLzFjE7R9/FFH5l0bXVsgq7MZ
         akxA==
X-Gm-Message-State: AOJu0YzwNX6LHcbR1lR+OpMCm3YJtF5dvkTJug9Yxi71x8aHN+MvSB2n
	vceUQXdI2PtMrhUum9oXBRjQbQ9hskjxgcoBTtrM+h14RbY6sAbCthl5nbgmxXcSu3M=
X-Gm-Gg: ATEYQzyuOgPvRUg1KsrZ53hOsk3M7mLSPUrO0pvImlaCq6Rit8Xw4dtPthtcbXDWLl7
	KjlzqWJXIhvjFGXyADPDzf8U3oDMbQwedlM1Hp0QJZpwD3GRA8RppTpqM0UUa7g7qyo+/G6+Jli
	vkG1f+MewxNXXw8qOTjUmad/yhpl8sN0MZ9A5NFMJcJH6ZAcnaL4nPha8YGmXVVojXKDlxUSaRx
	LGdFFGWZm9MlUvBKbnSRgML9m0JYTnul8QNBAMnqEuiCiy8ezFYD5kXl6clGZtpZlyV2Pk+A2St
	aDPZWE0vltFIIVUvRc9g+jXMx+D2S++k2cET+hb2/HiPk4VTDtVmvkzgFqpBPjbzM9iT0ZWgoTn
	fV0VoVW6ohwCgcZ3yM/S0r9ZO4evziz23tgLLG370NglCg34PVywbE7Vo7xGNLdfUXprpsuOig5
	yeKjUgQ/La3SRS6EkKBP6yZ2U6dLkmk5Rvx9YY898BgeBJTSzJ2JaDzBn1Asnuw4YBZB1cOWb+W
	ye95d93mLmU+ESFH8o=
X-Received: by 2002:ac8:5990:0:b0:509:2ef7:7047 with SMTP id d75a77b69052e-50957ea7dd0mr50826101cf.71.1773420652205;
        Fri, 13 Mar 2026 09:50:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5094a03556csm38152991cf.2.2026.03.13.09.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 09:50:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w15it-00000007JZO-0f5c;
	Fri, 13 Mar 2026 13:50:51 -0300
Date: Fri, 13 Mar 2026 13:50:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, baolu.lu@linux.intel.com,
	kevin.tian@intel.com, nicolinc@nvidia.com, nathanc@nvidia.com,
	mochs@nvidia.com, kjaju@nvidia.com
Subject: Re: [PATCH 2/2] iommufd: Report ATS not supported status via
 IOMMU_GET_HW_INFO
Message-ID: <20260313165051.GG1704121@ziepe.ca>
References: <20260303150348.233997-1-skolothumtho@nvidia.com>
 <20260303150348.233997-3-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303150348.233997-3-skolothumtho@nvidia.com>

On Tue, Mar 03, 2026 at 03:03:48PM +0000, Shameer Kolothum wrote:
> If the IOMMU driver reports that ATS is not supported for a device, set
> the IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED flag in the returned hardware
> capabilities.
> 
> When this flag is set, ATS is not supported and not used for the device.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  include/uapi/linux/iommufd.h   | 3 +++
>  drivers/iommu/iommufd/device.c | 3 +++
>  2 files changed, 6 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 1dafbc552d37..d85a2d3e1b40 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -695,11 +695,14 @@ enum iommu_hw_info_type {
>   * @IOMMU_HW_CAP_PCI_PASID_PRIV: Privileged Mode Supported, user ignores it
>   *                               when the struct
>   *                               iommu_hw_info::out_max_pasid_log2 is zero.
> + * @IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED: ATS is not supported and not used on
> + *                                      this device.

Same comment to clarify what this means. Does it mean ATS can be
turned on if the right HWPT is attached, or does it mean ATS is on
right now.

Jason
