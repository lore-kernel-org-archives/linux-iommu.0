Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7162A8F68
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 14:43:39 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-57656330b80so4279941eaf.3
        for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694616218; x=1695221018; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cb1rZ4s+6dRMYh0tisSZ/LO5NUgj9HSaQpkQjtgbHf0=;
        b=W7YusUU7pa12TK4GKb+zmL+U/mB1qISAj88k4BmuYKnMIFtVbKa328cmm99uVvSnXv
         9N0r5u/s24D+r/7axHjwZR23Dl3QMWFohu3SBmcQPb22DrC9mjX53D7WUAaF3dPJpm70
         YFf8aSLMkdBSVaSRzoYofGEWxt/PNCcyeSDcgiyKYu7gwUAUwKQVH0G8cAwynS4uCnna
         uCfwmzs9ggCyEbDAIxX4TLc1dXgLfbNDWsaNYGd7R7VKHl9oaQyw6aIqyXaoN1F6P5XS
         3BtICTZ6HoOvPhW1/AGe94W0fOkv98S7P5USIiRXVgUcZLqQcW3h4oEXIWKm9yvXN1m3
         Ig4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694616218; x=1695221018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cb1rZ4s+6dRMYh0tisSZ/LO5NUgj9HSaQpkQjtgbHf0=;
        b=JTHX8EOen9Dk1FFQJ5PAqkDhu9u9/Bc8ObSN4A9z432LtPs9vw9tqH2GBUCKLea1qi
         +CcwoS2yD2zBN/Z9cCIzya2vPnxx3+Gz3tLrYUhQ4cozP9i49eF2oWTaRWra2XyU5oeB
         prVogVPu0CcVTr5NCXC9SkJ5BH+Q1C40dBAMN2NJntTsiwttl6gyiSqsHUrU3HPsKJTn
         89YtzzypDrpSk8vXC/7vSLjadTg6JZw+17w0LpjIqkN3hMzKGwG1O4S36iyNBVqt6v/V
         qYIfQE9jPnWVJtIGLvShPDWKDbQPzJYv58IsqPZOK63kvapRW49wrjkZjzZ0alQC6GYA
         5XJg==
X-Gm-Message-State: AOJu0Yz+5RGANx5poMQV1b+4I1+VaUkCpEPmcmQRtW/uoxAQ/5CLS73+
	9vrexkNoBycDkSso64bIZbZRpA==
X-Google-Smtp-Source: AGHT+IHXviG1OS3OMalD0mzQXaHRtU13BPJKpM1ADQ21ti2G4OY6arVXjRzEQJeWTVFHzmfhvJ42Zw==
X-Received: by 2002:a05:6358:c1d:b0:139:b1c8:a28a with SMTP id f29-20020a0563580c1d00b00139b1c8a28amr2620514rwj.0.1694616218392;
        Wed, 13 Sep 2023 07:43:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id v1-20020ae9e301000000b0076ca9f79e1fsm3954395qkf.46.2023.09.13.07.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 07:43:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qgR5d-003egP-F4;
	Wed, 13 Sep 2023 11:43:37 -0300
Date: Wed, 13 Sep 2023 11:43:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 04/10] iommu/amd: Introduce per-device GCR3 table
Message-ID: <ZQHKmdp4QWK7ETlZ@ziepe.ca>
References: <20230816174031.634453-1-vasant.hegde@amd.com>
 <20230816174031.634453-5-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816174031.634453-5-vasant.hegde@amd.com>

On Wed, Aug 16, 2023 at 05:40:25PM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> AMD IOMMU GCR3 table is indexed by PASID. Each entry stores guest CR3
> register value, which is an address to the root of guest IO page table.
> The GCR3 table can be programmed per-device. However, Linux AMD IOMMU
> driver currently managing the table on a per-domain basis.
> 
> PASID is a device feature. When SVA is enabled it will bind PASID to
> device, not domain. Hence it makes sense to have per device GCR3 table.
> 
> Introduce struct iommu_dev_data.gcr3_tbl_info to keep track of GCR3 table
> configuration. This will eventually replaces gcr3 related variables in
> protection_domain structure.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index eb32df5371c4..1c4672ed90f4 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -530,6 +530,13 @@ struct amd_irte_ops;
>  #define io_pgtable_cfg_to_data(x) \
>  	container_of((x), struct amd_io_pgtable, pgtbl_cfg)
>  
> +struct gcr3_tbl_info {
> +	u64	*gcr3_tbl;	/* Guest CR3 table */
> +	int	glx;		/* Number of levels for GCR3 table */
> +	int	pasid_cnt;	/* Track attached PASIDs */

These should be unsigned values since they can't be negative

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
