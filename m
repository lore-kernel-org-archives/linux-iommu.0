Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D25A33E5
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eGYHbx9H"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-66d0ceba445so31954556d6.0
        for <iommu@lists.linux.dev>; Tue, 07 Nov 2023 05:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699363919; x=1699968719; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CV3ZpxbYmwbCYWdD+w6LCzk9lREsV+OuQ4jDQCYxX9Q=;
        b=eGYHbx9HiEv2mSAssZzNUnBAOTjSzHO4IVk3/A9A9flntkTF1+hWD8mcGVrVG8CAPq
         mF2UqApZd6tcR275yJwu9HLZxefVgKMb/StlMQNtr1mtuaj84pus8x56MIr/4Ejb0ps0
         tL354SEovqRk2vkVvt+sTiOKt/wc6z0ExeBukjPt9kqysViIJm1y3C/fDr8au19eYe1m
         CMIRkfgVgB7MpiQy1bGfvJyMJAg+30kVhXW4aOUtr+TtkwbTUjy7RyYMiTbY7i51lSul
         m5S2n7OvIYenIWK/I6xSmxZ/J2kxsDz8XvD+PzolLP3p6WSPNQ0NzExxiRGswVMmoaBs
         hPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699363919; x=1699968719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CV3ZpxbYmwbCYWdD+w6LCzk9lREsV+OuQ4jDQCYxX9Q=;
        b=iU5Fr+fgtKY38nYK5f07KCy25pYeNOQfYjtF0fvjZoJ/YEFI/bqe0rcCuPrPOFx6yN
         JIVGrPuNKfahfkTBkXCzeQnoNf3ck/NuYilfCWz0ff7mlKlHVvHgI4J0vPn3Uklg62Cj
         OZAIqxrYzdnlqsYZbCVv3DZJSpF7P8nMG3btTS/iy7Px2XgPE7kP4Fivl1ymRT3u2wY9
         8IneipUij7opwGuKDJ8K/FmEgaOXfiDqzhP9M+5z8tM5fJceFd4l6LELSd3RCWp/2hE2
         WJ/rojPdumTBhFIDcr644AJgQX1125YfOOrRzo0YuEfcSBU6Cw5lck//+O9wdAhZ60ql
         PZTA==
X-Gm-Message-State: AOJu0YyOH/uSByLG7Iy7GtrF5zRwzGSuuYJduxTrZUU0uJ+UyIfR78t2
	DD7kW46UIoENVux6XhGQy6EfQQ==
X-Google-Smtp-Source: AGHT+IFALs9Yz7GNAERbzWYmzueJYsgok1mrNA+fKggOIeB+P3Q/OKaR7trn2LKwB7mPWH323vN5HA==
X-Received: by 2002:ad4:5bab:0:b0:658:1eec:408a with SMTP id 11-20020ad45bab000000b006581eec408amr33966076qvq.40.1699363918800;
        Tue, 07 Nov 2023 05:31:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id fc19-20020ad44f33000000b00671ab3da5d0sm4300252qvb.105.2023.11.07.05.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:31:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r0MBR-001VjS-S9;
	Tue, 07 Nov 2023 09:31:57 -0400
Date: Tue, 7 Nov 2023 09:31:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 12/13] iommu/amd: Refactor GCR3 table helper functions
Message-ID: <20231107133157.GZ4634@ziepe.ca>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-13-vasant.hegde@amd.com>
 <20231106174003.GP4634@ziepe.ca>
 <d905c553-964a-b15e-19f5-1be4896a7818@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d905c553-964a-b15e-19f5-1be4896a7818@amd.com>

On Tue, Nov 07, 2023 at 11:43:10AM +0530, Vasant Hegde wrote:
> > You should be moving to a direction where the ops->attach_dev does
> > exactly one update to the DTE. It loads the new correct value of the
> > DTE that attach_dev is asking to create. All this repeated touching of
> > the DTE during the attach_dev flow is sort of a functional bug, or at
> > least a sub-optimal implementation of the API.
> 
> We are not touching DTE repeatedly. We do need to detach device (so touch DTE)
> and then attach device to domain (another touch).

Twice is repeatedly. Again look at how smmuv3 turned out, there is
exactly *ONE* DTE update per op callback.
 
> I am not confident to make change like above (i. e. just attaching device to new
> domain and then destroying old domain related data) in this series. Those
> improvements can be looked into it later.

Sure, but you need to start organizing the code to work like this with
the proper layers and division of work.

The best advice I can give you is to make it look more like SMMUv3
because that is the only example that solves *everything* If each
series moves things closer to that then you'll be in a better position
to fix everything eventually.

Jason
