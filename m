Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D9530CE4
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="c4G65bd3"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-41dd8fd947cso33975571cf.1
        for <iommu@lists.linux.dev>; Tue, 07 Nov 2023 05:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699364045; x=1699968845; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q5mE1j/bRBvcpDIaDFBF7m1TDwkormVI/staOAhY9+o=;
        b=c4G65bd3E/CfEJW7kT2OWE1g1MXJGcXVnegnv95h4LUtzPcUVy3sBFJ/IYOMVMxqiu
         OCSnzHmUPWEvWBoU9zzptfaZvJatzOlegvFH1EYlreB0FAeQ6ZnMsUqnxep5Odl+9roi
         b9AzWXV+D+KDkY9ErHVJ8Nq73zJIECIdnuCeUxwH64JpwQnqHdE6sbtfARU/xbHQF1m3
         1J8lE6WC6u9WNAZ7LqhD+wDbnpKaGCtet9RTllvLZl9tiycjVpeyylDzy55SwAWhvZHZ
         WkC0jwZ/JmRChAD167cNayOCgeD/TNbBqTKbNR6pD0gmYK/QChi5G7FQdDyS928QB+zL
         svpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699364045; x=1699968845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5mE1j/bRBvcpDIaDFBF7m1TDwkormVI/staOAhY9+o=;
        b=sXUgvWZmQKvmsBdrjz2lcuBLOgHjGZYp2vzPOdBNY9bM9LIPwsyC1GEH8c0LOWGxZC
         m3umy/s9CMYuz94vbu4m334shRcGuBwh0kKAS38yJn+EjL+e2VZb16AAQeD1j2Do9Omv
         jQqVJDIjhkddNS9fFxn2GsjW9cq0+C2fP2IB43ScFBWk3XLHkhKDf3QssmYdwpg4HxPi
         6xHHrzshcX5hO5SMTtMErfiG8DHOkxAFj5MI85XgyVJdqAGsCTW3UI35EYvAEthC90qr
         INYEr4Tpq+GfRFwAEnZK+d5/LTdrQ90xmb1eOfYrG6i8OhMMKl6n6IBQlMclPXyIsNjW
         qLtA==
X-Gm-Message-State: AOJu0Yy16K3VHla5f+Qp7QB6k3ZnKu8sy8z4RFaGJ4+jfqcMPISIb/81
	kMgRzN1IIDJi4TvfOYgcpPfsm9tYScUVmA9bIv8=
X-Google-Smtp-Source: AGHT+IH2xVUXMCTwADVW33ZWQyNtEUY3h8WKUEloZt9jm44OHk4U9+aWUi57uJvb1JTGFRt6V7Q/nA==
X-Received: by 2002:a05:622a:204:b0:41e:54b4:347c with SMTP id b4-20020a05622a020400b0041e54b4347cmr34950763qtx.43.1699364044844;
        Tue, 07 Nov 2023 05:34:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id i5-20020ac813c5000000b0041b9b6eb309sm4278694qtj.93.2023.11.07.05.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:34:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r0MDT-001Vk2-RX;
	Tue, 07 Nov 2023 09:34:03 -0400
Date: Tue, 7 Nov 2023 09:34:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 02/12] iommu/amd: Do not override PASID entry in GCR3
 table
Message-ID: <20231107133403.GA4634@ziepe.ca>
References: <20231016104351.5749-1-vasant.hegde@amd.com>
 <20231016104351.5749-3-vasant.hegde@amd.com>
 <20231106175130.GR4634@ziepe.ca>
 <4eb067ed-717b-0649-e119-fe43620d39c2@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eb067ed-717b-0649-e119-fe43620d39c2@amd.com>

On Tue, Nov 07, 2023 at 11:56:26AM +0530, Vasant Hegde wrote:

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 691c040216e3..558e0c196172 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1879,6 +1879,9 @@ static int __set_gcr3(struct iommu_dev_data *dev_data,
>  	if (pte == NULL)
>  		return -ENOMEM;
> 
> +	if (*pte & GCR3_VALID)
> +		return -EBUSY;
> +
>  	*pte = (gcr3 & PAGE_MASK) | GCR3_VALID;
>  	amd_iommu_dev_flush_pasid_all(dev_data, pasid);
> 
> 
> 
> I believe as a sane design it should first remove existing mapping (that's why
> we have remove_dev_pasid() interface) before adding new mapping. That's why I
> introduced this patch.

Again, no, all these ops are replace. The ideal driver should simply
write the new GCR3 entry with the new value in a single step. No
detach/attach cycle.

Jason
