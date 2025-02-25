Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF3F2698A8
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493693; cv=none; b=GvkW8OGfsGhOcUyx5Sm+AUJxWUEmIVNUObMFLt7VGPMEjFi8icHsa5ltR4pGNJF58AKNeqIdJPFC7x48sZ+UHmP8WZOd1rzfM4jzubIfcXaQTeA6VSoXiiZn3M8PEP12iI03vTCXs28fDVPqCp6cziOCsbi/YUATRpfuYLuCStc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493693; c=relaxed/simple;
	bh=R9n/ArHqni9zktdFxsi4hKG5Ex4uziXnb9yUMJUoeWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhXUqIUxz56KsRrPyJ55xNlPf5WDzeC1XoPrzMlIqA102pYxjgMoLdaGfXpWCXPqQEpTYJ2EYVQapBnkR/hJpPsJaEYI4JMRNImFgenMzCVMb30yTFLbJ74bxhVN8XLLv62LwHbXxfpPFc3xFsQ1/MgetpDYruilc4+jRnHiaMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KiGDLcD1; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KiGDLcD1"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c0a1c4780bso563592185a.3
        for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 06:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740493691; x=1741098491; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=llgyPrMLww2eS4eBQ3D27Zcc0eSqYQ7+H/wwOcXCKLM=;
        b=KiGDLcD1niTI3mDDc2nxVghqnV84QlErF8lSdquhYl8nFs+zafvouvnguaKQItPPN0
         5GMdFh4zDrRW+/a45TszG2dR9QM7QSPie2GjSmcTZUs3E2yNtx2kDxoXG7kzfWBUpRPg
         vKs3nnn1BqUlAwz4wSTNYARLbbdldCQjbaFePA9AMRFZ2Bk2o7CK1up15n44V9xfUwUq
         sTltkxPi2Hc6kqRr0LwriVne/1KCRz4sVIxy4sZbn4xbOQB3sTuSkFz1d1mWqUWcAk2p
         hMPCyTzjFTnYm4B+TtgcxnIZSLVtq5emtZtBeapUaau7ltwUG6wNUAZT0xpWpQL0aLOr
         4tGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493691; x=1741098491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llgyPrMLww2eS4eBQ3D27Zcc0eSqYQ7+H/wwOcXCKLM=;
        b=s+g7CcTFE9CkreEbpUnB/bd1SPdEOOF9r6O3BOYfz590d3usDCxn1SAT5q35CLeanT
         ZwfKzTyfd3U0kBaxKoLVNSwCAlou/DIut+wRDup25Lbds66t7kNcVhTQ6aNk7IKsSEky
         Lia1cAZMev79SmwU49vlOIly3ps24WQQfjtQ4KmdlRi1qoLPBD5sBPCsACHwSeYNm9lo
         XMygdu26sPJdK4bzSCGW/B0x7JWXYxpTOjEwLDf97lsK9BIZyr/zKDi6+aM3TPykdlYo
         4ZjpRSu4xhBmu/E0EYoTXyvHk7ip8ykeFm5xj38UHVIkj9MpyYse21CfnsNspn+MkI0c
         M9sg==
X-Gm-Message-State: AOJu0Yy6/RI/v4Eskp3jJ9+tPOzZa5cYlvW+NN62oS8rf7hLYtrmWwZm
	NErl9ED5PnqJeiZcsWF/0EqiHTi7rI1nIE8yw3eFUhMTWBQVyIkL2SvDBWb+UPImra6873GSOpf
	Z
X-Gm-Gg: ASbGncuPQjRdMV3n7c9mlo9emfRi3vewIgEXY7R6GPu8vYIpsFjiSyKi6zT1LHyAbAL
	Xrdy6tSQWmNsOxEOx7GrEXwDRH2SDZEf3tLk/gHl+i0lbCKB2jkC4f1k7X1vudnURLohOAHbDOp
	vpn9P3+05G7Y6ttOP6n1GZayhQdPV08thNcfih3R1PVWmsKoK/KRHwviacaUwYruU9qzx0GMUpt
	0kPmDXSnERhNkp9f48C/hk6hk578+IKqLSJk6/AtdrkYmXW5VhgMCdSwHKOQwSKmMido6xgVxpa
X-Google-Smtp-Source: AGHT+IEyAPyeaHCiVtY2VOFvlyj9FP180j2SrXYJaxq/9j0l3KiudDR1OrvaZJssJxSHjiJeYbw0MA==
X-Received: by 2002:a05:620a:2699:b0:7c0:80f5:41c with SMTP id af79cd13be357-7c0ceefe9e4mr2229788785a.15.1740493690840;
        Tue, 25 Feb 2025 06:28:10 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c299eecsm113363285a.1.2025.02.25.06.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:28:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tmvur-00000002T4q-3QFW;
	Tue, 25 Feb 2025 10:28:09 -0400
Date: Tue, 25 Feb 2025 10:28:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 5/7] iommu/amd: Fix header file
Message-ID: <20250225142809.GG545008@ziepe.ca>
References: <20250225105345.52143-1-vasant.hegde@amd.com>
 <20250225105345.52143-6-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225105345.52143-6-vasant.hegde@amd.com>

On Tue, Feb 25, 2025 at 10:53:43AM +0000, Vasant Hegde wrote:
> Move function declaration inside AMD_IOMMU_H defination.
> 
> Fixes: fd5dff9de4be ("iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers")
> Fixes: 457da5764668 ("iommu/amd: Lock DTE before updating the entry with WRITE_ONCE()")
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Oh weird that happened

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
