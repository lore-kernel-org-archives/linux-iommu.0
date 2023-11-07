Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99512FE3A
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Gi2MLks/"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-66d093265dfso34643986d6.3
        for <iommu@lists.linux.dev>; Tue, 07 Nov 2023 05:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699364210; x=1699969010; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9/yW7c1xa6nIA3+GLb6NnQ5+oMgi4PIcCBCSESX0iZA=;
        b=Gi2MLks/bhKffnBGMk7QvT+VpDx77pmsHj0DyIMxvKLOwdrZlas4AdNA9qAidNkKRc
         D70KsDpYFBqu8NfZMyO8FPBwVm3R9CO3K0/4Ii7ebNuaBlNF/DkpgqjrlFAnM2iVWBm3
         DftanF/g7EQrIn4raMnrVIMKFNAV5f0ZM7bF/B1YskrLKZJ+yfFL4qPuryyY8pg9cFw0
         H7x7lceBSJqNPJLWjpJHLV8Nx1PQieq1pVNwwS3Uf5u0WjN7/fuftKZCT6SGBWFAeB02
         xGZ9NemkOvusx72BWhHgfMtWLLJS8gCCdrZ3tbvJo7eKZmeEQFlnEyfcLueXqlZqI/0b
         pnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699364210; x=1699969010;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/yW7c1xa6nIA3+GLb6NnQ5+oMgi4PIcCBCSESX0iZA=;
        b=VDQL9anOBII/5o03Ka2tzUc6WHO9VbdmC0Hv4y3MSCJsCF03GFEfXxgaGGn1dQLd+Z
         W8egRTdB8xzR2S8zXy0DL2K+VYVm2S8yyt+A7Ceqfmz6vKwDGKmat0XFEcaYbAwHHiHM
         bJezlSlofd8h8aHtH2AulRlZNlEhQXjfBoA8Xt7hlVNWurYHhJwmRqAEeMe/yv3P149W
         1KI7m6QQ88Egdn820hHZJIdDNnK88/ell1MtWHcwdvUXu0YFA0Qc75OI3zvbCWBBmCbe
         sc9cQTyLsWJGAPiulXxCgup+L+RsK4dqLgSIQ53aoCFeMMZ1FHA38Dx0MIDELBkNxqxJ
         9hGA==
X-Gm-Message-State: AOJu0YxiOyyzX+NUC0LOvLdGexwTmaJ1IVI9UwJwK2f4U0Qa/kJUq7bI
	oJeYyFQlRJ6immnkPZce0SbF9g==
X-Google-Smtp-Source: AGHT+IH5T2QYGIZTQQ4qjm1lIsBHE3MDgVtccFMJPFfsIk4AVGoH3OwuafGLshaxPxhasOftQ3BUMw==
X-Received: by 2002:a05:6214:20e8:b0:671:d2a5:316c with SMTP id 8-20020a05621420e800b00671d2a5316cmr30123208qvk.42.1699364210553;
        Tue, 07 Nov 2023 05:36:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id jh17-20020a0562141fd100b0066d23395d27sm4341680qvb.123.2023.11.07.05.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:36:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r0MG9-001Vlt-Kf;
	Tue, 07 Nov 2023 09:36:49 -0400
Date: Tue, 7 Nov 2023 09:36:49 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 03/12] iommu/amd: Introduce per device DTE update
 function
Message-ID: <20231107133649.GC4634@ziepe.ca>
References: <20231016104351.5749-1-vasant.hegde@amd.com>
 <20231016104351.5749-4-vasant.hegde@amd.com>
 <20231106175456.GS4634@ziepe.ca>
 <63fbb300-fd17-13b4-323f-fc65fc8d1c45@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63fbb300-fd17-13b4-323f-fc65fc8d1c45@amd.com>

On Tue, Nov 07, 2023 at 12:17:54PM +0530, Vasant Hegde wrote:

> > Where the caller functions would generate the DTE content instead of
> > having ste_dte_entry try to reverse engineer which caller is calling
> > it.
> 
> dev_data has all required data to configure the DTE. So I dont think introducing
> another structure is necessary.

Again look at SMMUv3 and understand why I changed it from trying to
deduce the DTE from the dev_data into having a arm_smmu_ste struct
instead. It made eveything much cleaner.

Jason
