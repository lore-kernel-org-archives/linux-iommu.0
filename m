Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AD52C856
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z05nffpr"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d84c24a810dso4880966276.2
        for <iommu@lists.linux.dev>; Mon, 06 Nov 2023 09:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699293312; x=1699898112; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DgPfq4sYD2dJHMaRg4wXouzfH0j+FLBiHZDOabFrrYg=;
        b=Z05nffprrBIV94l/v1gVy3sv4/GXNgv5t+waXhutmBa2SUh/1gO54aSYR/tg1HElyY
         6PCx3wAqDe2mrK+5rbgHIF5TovaZWTuEuD53K25xAzVxcCXGVtl7sOQhWue9XZ6KaO93
         GWmUxHT0OoRfTb6rK9p9rNR6x5Dk1wf64VNMq3UzAUj2Tl8KMvAlwIJqYMn5qkasFXVN
         iaoWQH+lvmk9gvHKLcAdNLiCuEh5rZGtxDFiRKyNfZ6KQJr4dvf1t642bxI2yj1xaoq0
         Kkzu4zs8ubr6NkP8ZqV6PIdZ7KCmgkS5Vun3533isVa2UBMzcsP6GKONjh4NyesIbDLm
         DsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699293312; x=1699898112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgPfq4sYD2dJHMaRg4wXouzfH0j+FLBiHZDOabFrrYg=;
        b=iKlKWhz6d3T1XlQbY70V3rP+kiim1P8zL/tJ0FfjsrPI6Ez+1Ul5GwBDQojefl5HzH
         m+Uq6v6ELm96yR3BVqNuVLz6HYA7yE67md1Y9ueCiTtKUFHPECflZab4uGoKlI1dr2D8
         vClCvo9RC+MnPHJ+nmcGstlzVWah8TqTLDvC1pyxA9z9tPglVgY3Dkn3RS2VE2FUAGna
         vBeRmmsM6yv1emhZoRYta7eGFQThkdqt75aOoXhpdtXnN/ElGTuz4az9vINl5bDSANCm
         R+4DiX/p2b1outAFg2NO26i4LcWoKKkcYk9f75Don4sujuBFLFPzCgIs1shFhzOyNZfX
         PXQw==
X-Gm-Message-State: AOJu0YyR+oMis5mWfkfmgkDimBx3Dda1tklccubBnbYtdEELTIWFB7jI
	AGu1BLDk4uL9kuJksJVIVBh7iA==
X-Google-Smtp-Source: AGHT+IGvlYbzejW0YBr3R+9mjzmNjf9ndbXRq5E8xH4V0mHnn2ptAtkdRJxM7t43TYQS/4oU4TDImQ==
X-Received: by 2002:a5b:c2:0:b0:d9a:da03:2417 with SMTP id d2-20020a5b00c2000000b00d9ada032417mr27513281ybp.45.1699293312363;
        Mon, 06 Nov 2023 09:55:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id c12-20020a0ce7cc000000b0066cfadfb796sm3596863qvo.107.2023.11.06.09.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 09:55:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r03oc-001PMM-Va;
	Mon, 06 Nov 2023 13:55:10 -0400
Date: Mon, 6 Nov 2023 13:55:10 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 04/12] iommu/amd: Add support for enabling/disabling
 IOMMU features
Message-ID: <20231106175510.GT4634@ziepe.ca>
References: <20231016104351.5749-1-vasant.hegde@amd.com>
 <20231016104351.5749-5-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016104351.5749-5-vasant.hegde@amd.com>

On Mon, Oct 16, 2023 at 10:43:43AM +0000, Vasant Hegde wrote:
> From: Wei Huang <wei.huang2@amd.com>
> 
> Add support for struct iommu_ops.dev_{enable/disable}_feat. Please note
> that the empty feature switches will be populated by subsequent patches.
> 
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
