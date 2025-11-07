Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994512D8760
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520062; cv=none; b=fFX1Y9Gt2hwydCWBqsRnV5J/9chWXjJQp8xTYNyBrHE3NoHFB7IW/+B2giGmjqyMJYudJn6U8lenjC6Rsd9Kjbp8sF1IgS8YaUuSiKZ7Nx/PdilakprogCjaI6DzSXubf8pgDpQ3Lk8HMz6+uYO+qYkQ1nMuu7Y2Bi5XjVjisdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520062; c=relaxed/simple;
	bh=9ihomJcdzMlqUxpOAoozbesot84OU3iYnyVg59ka2h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiJRL/Ka9otJUFBiJjRDMa23Ikovi7ILCtiICpeBrxAo7emT+39G3hJ9BeArzWUtG4nVU1h7xjjOqkJEKr4yhcCtRhAQFxGomUnvfIRL7MPUdVTWTtNhf76IE2I35MTupzi4KbCwVX5GKD3J9pMTx6txgBGyBdjkmqK6Hd/aumQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UV+xmNhw; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UV+xmNhw"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4e4d9fc4316so6023161cf.2
        for <iommu@lists.linux.dev>; Fri, 07 Nov 2025 04:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762520058; x=1763124858; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9dnAfHO8i/KYJkiCOYppyzpEdu6RpKbs1p1aPTZkM1k=;
        b=UV+xmNhw4qA5yVGObon5Oyhs7LrU3QtA/ZTqhECzCIDyfWkdxAQNDVaM2beBeH5eVh
         S790QSZmqvG6OHiaJb6FYZhf1GMVBuGS3gghPb81z5f7tPmWNt5YF0Ri9EkfLeig8eY+
         iaXLcwS9tM/9IEXmQse7oc8olLr3SptvG8ub4wsSb23+JuKkPnyRuA+HR3lDcHWpShFp
         0yU14I9Ub0NBybI3Jn4vwIg0qF5bnYmIc9LbBP9w6ZCi4qFbMKhFKXxC7sSzdiY5rH5J
         JBywP/S9CO2U4XX0vhHa/cM7UzUWPz0VAYuWE1tKz01smo2WktmwNAx32qp6bUHqUlpV
         xIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762520058; x=1763124858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dnAfHO8i/KYJkiCOYppyzpEdu6RpKbs1p1aPTZkM1k=;
        b=Pf+D2MMegcQhlCm8IlMv20VL6I5ynD7zhdzyZF4eCq6X1G0cBciJfyteQ/dnSqobJe
         2gV5iB6hJTNBvZoIYDNnzQkqRn0LuCGwx6S/peh9PsybdQnHPDbZCpKUbo4eT81c//Zw
         4W+36v22i/OLSfrXOnlvfoqgnu0CUTUK7i4a3Olt2iOeatOGV8rkpk4wkxZZBHVPwnjf
         DgOXz+sJh6bpY2tGfvcDGRKIdzzVIkpboE5YjpLp+YOyJW635tqF8Cl6bM0CGVhNJi+q
         MEYdEd/z9QvMObWTsynjmB+yoiJAkjPKdnhjKKq0+YUBMMsyMtAxjphKUYK+IIZEqy61
         SypA==
X-Gm-Message-State: AOJu0Ywc/MFUfv3lmaS2kY0Z7nmLUZxhgub43CUVnrQ/G8QXGoGetY+V
	F99Zo+WsYY+Oa0fTbk/EwFYd3wFh1Y6WNJGiPI/RrW21CKlLGj261Cg4H7/nfWI9Qso=
X-Gm-Gg: ASbGncsuO/DTXngBFlpUNbGnBIO4xfgm1Nu3K/3IvRIZeAZ3SeZP6/GSnNYmuIMrkU0
	1R4r1RKy4w2NxL5lCx8IQrd0mx/tPBIcQvrb3B63bcFOGMION94Yjv8CMVEFX31eHR0dZ5KTQEJ
	qRYl0hY0EdcQi1fQ8Nz21GxDhbETJWRjkoXLdx3sIZu62Dmd/HNFzajZoJsLEvC3X0D+qKE+UH4
	6d1NiDvOgyYIOMOYjbAej+UBEfo8sBaCSSfZYEJ8mnZ2O+W0K4GM9EN2gTaBZ36SgQ0tvAwb2nP
	ghHTb2T+VkBk/5q5pzFMKSmtpac9Fvr21XEY8PcgrndNKMvverTc/5wmnG3swZoa0Q4dHfmJ3OM
	DhMeDxbQuSezAtVicJsQ7LL/QdK5GvPX8IOwhO+T0Llxgso/XdT4W1A0c2YJkZfs74QzNgBdlJB
	Uc0+nMIkm1CmsFw5kpp6fYSG5/MjJrbbkauXoqINwXM2MRtQ==
X-Google-Smtp-Source: AGHT+IGA66AV0haBXQu8f19fLfBmH0ZQoB8IASgfsT0yBpQE9xCMaY7CQY2kajYY+Xnux41hly8RYQ==
X-Received: by 2002:a05:622a:146:b0:4e8:ad2a:b0d8 with SMTP id d75a77b69052e-4ed949abe66mr35785681cf.30.1762520058362;
        Fri, 07 Nov 2025 04:54:18 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828c5101sm40660146d6.6.2025.11.07.04.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 04:54:17 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vHLyr-00000007mZY-0tQa;
	Fri, 07 Nov 2025 08:54:17 -0400
Date: Fri, 7 Nov 2025 08:54:17 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH] iommu/iommupt: Fix build error in genericpt unit-tests
Message-ID: <20251107125417.GB1792527@ziepe.ca>
References: <20251107104701.237041-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107104701.237041-1-joro@8bytes.org>

On Fri, Nov 07, 2025 at 11:47:01AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
> 
> Fix the include of iommu-pages.h in the KUnit tests for the IOMMU
> generic page-table code to make the tests compile again.
> 
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> Closes: https://lore.kernel.org/all/9844d4cb-f517-478b-9911-b6dc1a963b8e@leemhuis.info/
> Fixes: 1dd4187f53c3 ("iommupt: Add a kunit test for Generic Page Table")
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> ---
>  drivers/iommu/generic_pt/kunit_iommu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
