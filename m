Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70728265CDF
	for <iommu@lists.linux.dev>; Tue,  8 Apr 2025 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114163; cv=none; b=Tw3GybLuPh/TZphF6k8z5X2WSrHP8EoSqaKbxNnjrxBy1TxNNtYrsmo8fxZYeJ8yfN9pajW9fUkCQ4Y2cyDmD5AB9/15wivvjKuQbjHSJXLa8a71K0RMIDsDiAD+zxRMLEwprHWJt8fMuSyY3eGPB3txQyQ9cJNj2ldgqjmpI1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114163; c=relaxed/simple;
	bh=tpHAquJG4Dkb66PrhDikfbFF6dS5Oa2U69jSk8hSrEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbHH2e7XfVpEgMlEyxy6w1ZPs9XWaX0TDElLZG2arKdR+iPh2N3Igtbi9McnU8pWHb8vMRpPqQXYAkcfy12dqL0ZJAkCHsu/a8/0g9ZhmfIFmsrpTTS3QtCEHZLdH626Qo9B2vpkC8YMC8c9qtRp4FqSVdeSxzRsHiOoX6aj1b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ulbcwv8u; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ulbcwv8u"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47688ae873fso53495601cf.0
        for <iommu@lists.linux.dev>; Tue, 08 Apr 2025 05:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1744114160; x=1744718960; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EvZTf+A2Tig+IRGHQAjPjWtgFVFDb9fydbEYyz2o1UM=;
        b=Ulbcwv8uZw5WHPObOnRJGpe7J5EnrUJ95cwfQvcdlEQsCElPwn0ShRUKPpZQa9o9fo
         P+/uzgzEj4WPmYSI+FM0m4WqvMiFjU40BWdhwyGKuNpB7+WnVNVR6x9j4/+YpK/AEQ6Z
         Z9oPDqkMooflNI2UVgom7M+rZed+O0qgkgbZDoY//39otJ2mXD6o8wL5wAISyEN5bC15
         f237kQiTnqZux1aPy1LPMcza1al+tzTsyZt+H7wmP+w/i2/MDafueJk/Q63Y5kklJN5u
         7hcocq9piyRij71CiuxcyMYKEP+gjVmEcxgj5CFNiOX90jgEco37AmWAB17QD+/utwyP
         2hwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744114160; x=1744718960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvZTf+A2Tig+IRGHQAjPjWtgFVFDb9fydbEYyz2o1UM=;
        b=qNQbaWryKjc7KYVguh8C0UkaC0WJsjO4SCuV4vwDF23GeiOGvPyn1xq9QpEGr7OyVp
         10B7lyujGhhDSFom3tsGBiblvb5XCwVhpIEhWm9jIViJpaZXgAu2+0+TLu+xbqrF8p6Q
         R6vbisKWmrMa6H2NBnF0rtFkJ59mtnfY5ayAj/Q3aMc3Zhx3FEbF77qf3PFbzq2G9wWJ
         vJuBEBR6WsdugELTsB0Fda1I55tuh43/XIak8H6UmW6OaiHEov0EV5qMDEOQRCLxoqvt
         t047nIPoTvY7e48SXTkLufeV1UKxnELrt1q0f3x+hhJRG2lJ76aAcHXgsiVcWTqhpXmx
         HvRw==
X-Gm-Message-State: AOJu0YyoSd2lHizPRJI+LIHFtAqiKa1w/b49F3KZxc0Rx3O7rVLSAr0q
	9BtazKrhuiGyLddp56m71/Jmas+VA0FTy4+GszpJK4eMCip/kW/b/+KYnslhE6c=
X-Gm-Gg: ASbGncukxJ+UtcQTzQBBCXOatAcQccy1FzuGZoEQxZZQXIjBBi6EC65FNiLSkGcdp9H
	hTiI675mLQfvGqZLf2QZNkyxDMhCSUuD35gcAES0NDroWWFq06dNP/5s7bP2CKFggTPr8hgee4I
	BvTPHZ8ONAVtdN0mwTbP0wJEIq8893veBKqsBknlDwhrn1CWt16WuePOqRjZLNbtEPlW3aIhQzk
	6CNp+B0sy5+Ih5sKPC1MI4pZrv0secZHXNvn1zRWwbVymMswbsktiaN0FDqW33Ia4p0+ZxmIAye
	pUX8ueFqmeIITnegX6qfqzP3pz2C2KEEr7jeK40psH5r4n8FZMPlBEXr/NWnGkN2yYSyZpCdo8X
	RqfLg3Q2y2oPWKJnj3BQ8ww+P2ZqXVd++Ew==
X-Google-Smtp-Source: AGHT+IElwz6ZYvtcmCNJZ23hEjFuxJMkyHm7q2gsXSKL95/zDdGVqmGJmKoKERZUukK8jrmOAgtPdw==
X-Received: by 2002:a05:622a:394:b0:476:77a5:3104 with SMTP id d75a77b69052e-47930f6f3e1mr204130021cf.11.1744114160142;
        Tue, 08 Apr 2025 05:09:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b088544sm77395201cf.45.2025.04.08.05.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 05:09:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u27lX-00000007fyn-0hJN;
	Tue, 08 Apr 2025 09:09:19 -0300
Date: Tue, 8 Apr 2025 09:09:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, nicolinc@nvidia.com, jsnitsel@redhat.com,
	praan@google.com, kevin.tian@intel.com, ddutile@redhat.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add missing S2FWB feature detection
Message-ID: <20250408120919.GB1727154@ziepe.ca>
References: <20250408033351.1012411-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408033351.1012411-1-aneesh.kumar@kernel.org>

On Tue, Apr 08, 2025 at 09:03:51AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Commit 67e4fe398513 ("iommu/arm-smmu-v3: Use S2FWB for NESTED domains")
> introduced S2FWB usage but omitted the corresponding feature detection.
> As a result, vIOMMU allocation fails on FVP in arm_vsmmu_alloc(), due to
> the following check:
> 
> 	if (!arm_smmu_master_canwbs(master) &&
> 	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
> 		return ERR_PTR(-EOPNOTSUPP);
> 
> This patch adds the missing detection logic to prevent allocation
> failure when S2FWB is supported.
> 
> Fixes: 67e4fe398513 ("iommu/arm-smmu-v3: Use S2FWB for NESTED domains")
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This should go to rc

Jason
