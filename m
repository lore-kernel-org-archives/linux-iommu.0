Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8949D2AB33
	for <iommu@lists.linux.dev>; Wed, 26 Jul 2023 12:32:24 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1bb782974f4so2296027fac.3
        for <iommu@lists.linux.dev>; Wed, 26 Jul 2023 05:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690374743; x=1690979543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s2LZklfzdDp+HBoQ8f3f5eYwM6QVODSaMCY++3HA0EM=;
        b=RvbBId8gkUPSMzbXAsA3K90++Py252hk+BHtObsYiXv3Ywxv536LhohjdhDSHd1LTG
         sghY6ACgl+EYcBThqN7Yq9TGk+oWqg8fSIcPMWK4zEccnBbQ4Rdef8kK+BI+9BEMOzZ3
         Vq6+S2axKBS3QQ5TixDL33BGvuephxmRuWt2yXHaLxSsRd5rJpcn+AWATzhSBbGDTV3N
         tYqtdGlnLCQzXCALBlMq2XceK5LHbX59+8f6egcDGXkQEfThYN9iwX0CK17uHnFQ/UNZ
         1/haVHQE3PlVoZnQnE3bqI6NAaBTwy+QLEiUjMh5GvDjjso0FAnvBQYDF4u6Zl4qdXUu
         qRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690374743; x=1690979543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2LZklfzdDp+HBoQ8f3f5eYwM6QVODSaMCY++3HA0EM=;
        b=jTY7StTDWAdLNfOcdd/8k/TxplnJjRSrf2ne+n5VUKDQJ0Y0s8JkdnKxSfU64yycuS
         +kDBn4Wfw/I0sOoSPSy+yRHztBZ+xodsoCeQQrQSQdadtxW5i2uh/9oZkDxIyI4XUmxw
         5QVFvZYAjV/zwePU59mY6x/J7/6Dvcov9zRrdx9g8kHgpEZGbLLtWF4XQvdr4th3Co0U
         D/r9pz8m6P6R4vjUR5qoIaZKGbbXnouXZ7BYXyULF3bw44m3LDIpXB/ahX1GxXMgxsOh
         2M4yRQ7D/TfU18N0e8gj0SzFgxpIB9zLmx2j+qgFZVieVmb/+TlJy4mlKYWFkrGYhG2P
         6e8A==
X-Gm-Message-State: ABy/qLZ17ELWXozCsMM0fcpa/NGTv+9Bwzotw2YWZ2oDXac7VHahtcU9
	c3iUkDj7skRceeWdmI7PdjO8yA==
X-Google-Smtp-Source: APBJJlHGHr8eoBmQqqPKycRbhZ0B6k8y2fItPugLaQgZuFFOVYIegvg6UmeZDR014IzZGUPNUAwj+Q==
X-Received: by 2002:a05:6870:14d6:b0:1bb:3f64:bba3 with SMTP id l22-20020a05687014d600b001bb3f64bba3mr2771188oab.8.1690374743082;
        Wed, 26 Jul 2023 05:32:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id s21-20020ac85ed5000000b00403b44bc230sm4702842qtx.95.2023.07.26.05.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:32:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qOdgk-000vAQ-3O;
	Wed, 26 Jul 2023 09:32:22 -0300
Date: Wed, 26 Jul 2023 09:32:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: thierry.reding@gmail.com, robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] iommu: map reserved memory as cacheable if device is
 coherent
Message-ID: <ZMESVmkUUshDzlbp@ziepe.ca>
References: <20230725140055.12823-1-laurentiu.tudor@nxp.com>
 <ZMEP8pqztmPw3UmP@ziepe.ca>
 <c1c1f3d2-61c1-c1da-36d8-900f1982db63@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1c1f3d2-61c1-c1da-36d8-900f1982db63@nxp.com>

On Wed, Jul 26, 2023 at 03:29:47PM +0300, Laurentiu Tudor wrote:
> 
> 
> On 7/26/2023 3:22 PM, Jason Gunthorpe wrote:
> > On Tue, Jul 25, 2023 at 05:00:55PM +0300, laurentiu.tudor@nxp.com wrote:
> > > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > 
> > > Check if the device is marked as DMA coherent in the DT and if so,
> > > map its reserved memory as cacheable in the IOMMU.
> > > 
> > > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > > ---
> > >   drivers/iommu/of_iommu.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > 
> > This only makes sense for IOMMU_RESV_DIRECT - is that your use case?
> > Maybe mention that in the commit message
> 
> Yep. Will respin with an improved commit message.
> 
> > And add a fixes for the commit that introduces IOMMU_RESV_DIRECT into
> > of_iommu.c
> 
> Would it make more sense to mention the commit [1] that actually added this
> support for mapping reserved memory in IOMMU?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a5bf3cfce8cb77d9d24613ab52d520896f83dd48

Yes, that should be marked Fixes: - it added IOMMU_RESV_DIRECT without
forming the PROT properly

Jason
