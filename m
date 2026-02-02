Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC59C37BE9C
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770048326; cv=none; b=toHNuC5mlGachZvSu20WOMEpipotdDxqmVGIRnrR6jgNbkTYJT6N1a4amXKhe1lrNeZYC/pXIP3KZlYm3BuMM6Ql8xjHGEYFkWbQDZuboRltKvY07dKDYJlVov4PGD65OGfbumz15YqxEGatrWS0aAXvPv2rnT5al4c56NfhdKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770048326; c=relaxed/simple;
	bh=SRmq3Vfx7IcmSSZrIB2TSX++ZYsD8PDQLx12pxpzILo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBh6jYWKDIpdcw8aPqIeR9PgtD44ZiozZydpQtduFRqkXbSmAMn9fR/hLNYG5IIs7lz4tKpYBj6q9iI+bEwn/H2gBbRGBmUkt8oxBIXaCicaY2x96qDQ4PGBxRJCqxXzO3dPcWTxX+ghgisDhXLKIorU3DSRnfCScZw6zeceANg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=f1znT4Zd; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="f1znT4Zd"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c7120353f1so470192085a.3
        for <iommu@lists.linux.dev>; Mon, 02 Feb 2026 08:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770048324; x=1770653124; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FyiZAQSI+ZSAS8saUY3SpaGjhrrnFQnknRI9pS+CzKk=;
        b=f1znT4ZdDq7Cja36S7KPKshEX8iFg0FYk8T6eaES85cubczIYScW7XJTLx+0IIOiZC
         KY91+w/4Kr14giw3Py1/6KcF+DJGVsw+5XkH/Nh0MR+JNggL+/jCexzKuw+MSf7fOpIX
         8MmhfiWtW99FY/7E9eD92pAvbB00s4KYpspDEom90Vl8Pt1nlBq6XHriywWtrfcypge2
         Xgdby/5UN9dtC8ZbL0GZXgl4pJ89+VZC0ayI61QjCq/iAp9nDRkZu2G8JF5g1GLEEi3z
         yr1Mju0P5uuWl9ybBh/CxqT9cQ85bi5+d9LhjhbTfGY+FCNYI++Rhz5eZl9ICWGgSI1M
         2atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770048324; x=1770653124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyiZAQSI+ZSAS8saUY3SpaGjhrrnFQnknRI9pS+CzKk=;
        b=O9fDN1p3S9lHciGVzSOlUFoAu033S9ZfT0V83gmTaLQHKz1uUPBVCuueZ1PH1wuMMr
         IvSm+LpShTTzv6sNEa5qrvMefgg4n8eW/Wam8TTaSa8lJub62sI/qDq0bFBtXMTMS6Y6
         POZjPXTc6ppeos3tIoOJvWKN39h7eab3TCgpgN81xhc42WFNG0b+flJEwDFJcaQimaBQ
         /vBTXuav6x3cTN6t5Kq92fuevdVNplu2wgc1ulSOCidpOBuhS+SD3KSBFVJnraEUDMkl
         jjckijirJ/A0QtmHDVrAQ66MzWmKKqy+jZAWkDDNgEb7Ixi4y2xDPuvrz7xH2m5nLH1v
         XaKA==
X-Gm-Message-State: AOJu0Yx3WiJnsKtXBrIUaw2DoIJANE54x/U3Cz8W7gMHnVEIEMC3ETAg
	COnlH+oEio3jH3WY0gh8L6tUgHRg1+YdtPfmkGoToGPt6sSnd3ve87lx0+sIu6hMo3U=
X-Gm-Gg: AZuq6aKaWkvr0Ov1JZE1uroABnU4PtKs76X4PiOdU2rqGroaH0UuuVEeFOXGLMpp55i
	FW5NvStBWdUwxrPOeSOw5/9/jPL79Qok+dvLM5Kjh601BTB+4XrY109ijnOuqh0OKJwJtcRSuAp
	XaHk5cEkG6IKApnSIkPGmhpXpooQdWwgzdAchOUu52sB/Xk0fXTxt0dx2h7gFExJzRfgd+ofvj3
	r7ztDKxNmgBXSDOx5nHrtDUTvIM2l/LgrjmUDcxuUSxPm8EkcnlYVfggGzMyD6kOt7cik2/MOyD
	Biv/Ejn6jZ2Qkur4n+9Zw7QVPZFaGcPR28KDXh8S9+OvmeA5N1rqk4VD/hx/5ahKZS3aEyM61tu
	p4tplBikgismcGixPMTfKwWiYHhWhFNINQe1kSs92R1UFTmV2DgUPLAAFvnVFwm4FuoWbOMn7K1
	Arw11iEJZaHmKcOxDhFY5SsuEPPMuTgiaYTIfArSUU10v4rvGwOPsYwhkkSpa/FTompgw=
X-Received: by 2002:a05:620a:1987:b0:8c7:f62:228a with SMTP id af79cd13be357-8c9eb35ab2fmr1439654985a.74.1770048323668;
        Mon, 02 Feb 2026 08:05:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375eb4dsm115773786d6.46.2026.02.02.08.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:05:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vmwQU-0000000FZuh-2VHe;
	Mon, 02 Feb 2026 12:05:22 -0400
Date: Mon, 2 Feb 2026 12:05:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommupt: Always add IOVA range to iotlb_gather in
 gather_range_pages()
Message-ID: <20260202160522.GJ2328995@ziepe.ca>
References: <20260202095458.882560-1-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202095458.882560-1-zhangyu1@linux.microsoft.com>

On Mon, Feb 02, 2026 at 05:54:58PM +0800, Yu Zhang wrote:
> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
> index d575f3ba9d34..3e33fe64feab 100644
> --- a/drivers/iommu/generic_pt/iommu_pt.h
> +++ b/drivers/iommu/generic_pt/iommu_pt.h
> @@ -58,10 +58,9 @@ static void gather_range_pages(struct iommu_iotlb_gather *iotlb_gather,
>  		 * Note that the sync frees the gather's free list, so we must
>  		 * not have any pages on that list that are covered by iova/len
>  		 */
> -	} else if (pt_feature(common, PT_FEAT_FLUSH_RANGE)) {
> -		iommu_iotlb_gather_add_range(iotlb_gather, iova, len);
>  	}
>  
> +	iommu_iotlb_gather_add_range(iotlb_gather, iova, len);
>  	iommu_pages_list_splice(free_list, &iotlb_gather->freelist);
>  }

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This should have a 

    Cc: stable@vger.kernel.org

It is a serious error.

Thanks,
Jason
