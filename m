Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A880D17FEB
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 12:07:07 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso3307273a12.1
        for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 05:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690805226; x=1691410026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u5+tmYKU4ZQKgcl3YwoxthWwMhd6TYBPfKQWFZUIUAM=;
        b=nP1hkIbD9JDCZJ+Smc+emkgrIVlG7svFqrsJ4D23M/N68wCn11NracR2xIcl6k+oyP
         +s95TA07KZtFrMfRRlC65N+ik1XhAhkxCXklE7TY9WMVc0Hlh2aSw1unO+PW93CwIaAv
         zX14uYVqZ8YrnN9oZnZynkhXAJIRSA88av0rFRUj5tB/1hTbONEjplIOJ8pZhYRHs6Oc
         93o+z/fzyK7kqnsIthucFcfav+md0BUFJJxY4Fb6cznagfaIzdRdN655sLmMvIWEe3KN
         Lq82cmAWys8He997oUwYTjsZdnBVtlaAp5mEIPWFoQVbO471/oOHTWrG9764QkyoDIyf
         qazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690805226; x=1691410026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5+tmYKU4ZQKgcl3YwoxthWwMhd6TYBPfKQWFZUIUAM=;
        b=g4/J70JeX1MVFGXND91x/OC1e4HL18lTI9ry4U1709uhKjoAngxxOF/2odhqps9QRE
         rvEbmwx4eySPOWeRd4mWnZg5rZiwd8E9L9HRLgEE5c5UROKy6cJpUAqfNmpK+3R3nz3Q
         w7pwJlEpKJI6i3VFrWqV6SHEtkJ9G/gUeBl/bvFQ92thRf6IKk7PBosCsirS7JGDnhk7
         g5qLqDdCeT0Ne4UAzyRTluEVA0HEpKMHuQu36pGIBnJZMl47bVSu8ZCs/ZJsYvWOBqeT
         x/d1Iavr6cevNSGRim7TbBC8RY9039i0BUZrtS9UWztPz/U+HOZyxn6F0UMSxCx+V3DT
         F46Q==
X-Gm-Message-State: ABy/qLYa7N4bwgGtxoPOlbgHALNsnKyAnnPL9ch2cnacZGjI88pXqvx3
	olqT6ta1iB58jeViJkXpdo8XXA==
X-Google-Smtp-Source: APBJJlF/W+Xec2PIPBL56exR7n2jC5uWKMw/QCufUCfJYRXAh24/3Honw8zzLNYhdOlCvcwsu3Z5HQ==
X-Received: by 2002:a17:90a:6b84:b0:268:5477:811c with SMTP id w4-20020a17090a6b8400b002685477811cmr9653624pjj.23.1690805226707;
        Mon, 31 Jul 2023 05:07:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902d48900b001b896686c78sm8452037plg.66.2023.07.31.05.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:07:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qQRg0-002Ejo-IJ;
	Mon, 31 Jul 2023 09:07:04 -0300
Date: Mon, 31 Jul 2023 09:07:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 15/16] iommu/amd: Initialize iommu_device->max_pasids
Message-ID: <ZMej6GCFu6TJgOY/@ziepe.ca>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-16-vasant.hegde@amd.com>
 <ZMPUufoPxZgFwx0w@ziepe.ca>
 <b5bb3e1e-a933-a04c-53e5-bb05c3ad38c1@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5bb3e1e-a933-a04c-53e5-bb05c3ad38c1@amd.com>

On Mon, Jul 31, 2023 at 12:33:18PM +0530, Vasant Hegde wrote:
> On 7/28/2023 8:16 PM, Jason Gunthorpe wrote:
> > On Fri, Jul 28, 2023 at 05:36:08AM +0000, Vasant Hegde wrote:
> >> Commit 1adf3cc20d69 ("iommu: Add max_pasids field in struct iommu_device")
> >> introduced a variable struct iommu_device.max_pasids to track max
> >> PASIDS supported by each IOMMU.
> >>
> >> Let us initialize this field for AMD IOMMU. IOMMU core will use this value
> >> to set max PASIDs per device (see __iommu_probe_device()).
> >>
> >> Also remove unused global 'amd_iommu_max_pasid' variable.
> >>
> >> Finally current code restricts max PASIDs to 16 bits and calls BUG_ON if
> >> max PASID is more than 16bit. This patch replaces BUG_ON with WARN_ON
> >> as system can continue to work with 16-bit PASID.
> > 
> >>  		pasmax = iommu->features & FEATURE_PASID_MASK;
> >>  		pasmax >>= FEATURE_PASID_SHIFT;
> >> -		max_pasid  = (1 << (pasmax + 1)) - 1;
> > 
> > This can be up to (1<<32)-1
> > 
> >> -
> >> -		amd_iommu_max_pasid = min(amd_iommu_max_pasid, max_pasid);
> >> +		iommu->iommu.max_pasids = (1 << (pasmax + 1)) - 1;
> > 
> > So why not
> > 
> >    	iommu->iommu.max_pasids = min((1 << (pasmax + 1)) - 1, PASID_MAX)
> 
> Because some older chips had support upto 16bit PASID only.

Sure, but I mean why not just directly cap it to PASID_MAX and not
bother with the WARN? If you WARN then a new chip reporting > 16 bits
of PASID support will cause pointless WARN_ONs at boot time even
though the driver will run fine?

Jason
