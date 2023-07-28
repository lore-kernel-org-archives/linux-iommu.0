Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3FD6129
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 14:46:19 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6378cec43ddso13075406d6.2
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690555578; x=1691160378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VKcMd4qEZuYCvzgdDBdesHQqktQSHCAz+zaLLtkxa34=;
        b=dYnniCyFwyZSts8CTa1HL7K8usrEDaw0Avww7DgKyKUozvX+gjC8Dha6QWGcjZIzGR
         StFcWP0ItjVGImWDDEwmgrGxeXmKSbXo4WEhrbNBALBYXEodXz2mERokzzgaXYdrtHw8
         ftMwvbEIrQid0IjE+7xT8DsXGM+jqhmMyaIlnLV5rtoSEAGr2BGRhqh6pathseSXD/PK
         xIoEH6d5+I9eGNjJdzT+oDAPqNW105KD8OWTWT9Ea8CWcLA4Ub+UcVjrhkiNd6r3m0P/
         rZoGH0xu3wAH1vBcnRF5izW8LWw1XaR2mP3WGBJOq/Wi3lokJxrS1PH/IrRR/IwzXmgy
         sdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690555578; x=1691160378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKcMd4qEZuYCvzgdDBdesHQqktQSHCAz+zaLLtkxa34=;
        b=RQ3eneZMkQtwIMrqM9R60UvCO8b4yWmJ6wBNGaEOSlG7vJhl5DY1sWk919qxt38pbL
         fBjuLvU/jLc5J303gIn6mAeLUZAHxZ27LeIeYOSVokZtTa2rBPVPrHWrgiZ1fIuvh0Tb
         xQVfTBgRqt9/sX5lzJip0cvebEE7MvvylBcIolvtNcGdAENMVwVIbx3FA5CP0phOT0G6
         z1IiOE9fJbbiRLxmyI6XNU/QWv0TK7o5E6dSrIZOyYjWiaILu3NeZzEKoITp9bhruD15
         +gtzxzjnCDPbZSrXnXjfiObS/Rer3ZqviyXl32gjKJyxzlY+oWnfbt5XDZMGUMWlG0+/
         Wq3Q==
X-Gm-Message-State: ABy/qLZllcDeMqaSBO2QXIMtdtSxApSQSQd/1qq+BIYyYqfqRDKwybIT
	gnYSWr5VD85VxNoRaw8MnMzZZw==
X-Google-Smtp-Source: APBJJlFpUCp8aGplpqQpR70+gPBQVd6WJoYXg4lAM4PFVSNeih7HtXC0W4oMYxZTGr/2mRZ1fbfbIg==
X-Received: by 2002:a0c:b242:0:b0:62d:ddeb:3789 with SMTP id k2-20020a0cb242000000b0062dddeb3789mr2563197qve.43.1690555578256;
        Fri, 28 Jul 2023 07:46:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id u2-20020a0cb402000000b0063d0b792469sm1279587qve.136.2023.07.28.07.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:46:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qPOjR-001c04-2c;
	Fri, 28 Jul 2023 11:46:17 -0300
Date: Fri, 28 Jul 2023 11:46:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 15/16] iommu/amd: Initialize iommu_device->max_pasids
Message-ID: <ZMPUufoPxZgFwx0w@ziepe.ca>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-16-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728053609.165183-16-vasant.hegde@amd.com>

On Fri, Jul 28, 2023 at 05:36:08AM +0000, Vasant Hegde wrote:
> Commit 1adf3cc20d69 ("iommu: Add max_pasids field in struct iommu_device")
> introduced a variable struct iommu_device.max_pasids to track max
> PASIDS supported by each IOMMU.
> 
> Let us initialize this field for AMD IOMMU. IOMMU core will use this value
> to set max PASIDs per device (see __iommu_probe_device()).
> 
> Also remove unused global 'amd_iommu_max_pasid' variable.
> 
> Finally current code restricts max PASIDs to 16 bits and calls BUG_ON if
> max PASID is more than 16bit. This patch replaces BUG_ON with WARN_ON
> as system can continue to work with 16-bit PASID.

>  		pasmax = iommu->features & FEATURE_PASID_MASK;
>  		pasmax >>= FEATURE_PASID_SHIFT;
> -		max_pasid  = (1 << (pasmax + 1)) - 1;

This can be up to (1<<32)-1

> -
> -		amd_iommu_max_pasid = min(amd_iommu_max_pasid, max_pasid);
> +		iommu->iommu.max_pasids = (1 << (pasmax + 1)) - 1;

So why not

   	iommu->iommu.max_pasids = min((1 << (pasmax + 1)) - 1, PASID_MAX)

and forget the WARN_ON?

Jason
