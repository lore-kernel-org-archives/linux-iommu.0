Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D2863B3
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 13:21:22 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1bda51aa6bdso10476315ad.2
        for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 06:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691760082; x=1692364882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeCZ0pK84dGELrvPjmX4/k4Jc5A25NpxkoahG8bENUk=;
        b=m+IFmrgTH5SfLaNt0/O/olWKvGxNmEcA/REiZzAEbNPDNI79TzS/Ix2Q5B7hMJtS1Y
         2QN19K8DN9P1eSZZA/SqvGevDaZxiZKZBSTtHFmXDskygZ/mQt5VOPHfxk/HzLGxxq3e
         qw1HzZf+/vuNBXQDSCy5jKkigCwcUSBviJSg9LZlWCuwILPx9gHzH9v+daBAFUPQduh6
         2xDnMc64uHJt53Wm75uD6bM18f7z1xPlLfywflC7aUNg5NM/btlmNzGcVxADmWwk/eTk
         IYDP+8oVCDr/3qQKrS4D0DR7FrSqV78oe/vnZ5pKmNAbpbqu9lWTkMd5O2yMXP941Qc7
         NenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691760082; x=1692364882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeCZ0pK84dGELrvPjmX4/k4Jc5A25NpxkoahG8bENUk=;
        b=ZAIogBzrPyPx0/yyPBaUYZfzPNPPZQ+4IElowhatKlKL7EBjDDSvrD7QgiTjAxAbAD
         4iz+SNp/oPJZCqjJMYUfBCRgS8ibnNIbgLgp2wPDSZbvRy5VDo9XFf2rvWAnTdwJLra4
         YyeBW/MyYpnOWZRnAeBt17BiYdVRucMg+7Sb/SwbmVOqMN63eeBVWYMLL0cYf4zgj0t2
         vgatFTNAvLfAnD/4la93YCFYwoNoOKA5UvIdxbQ64zqwrIBxf+Kid0VedFTUUSWD9/OV
         GpwFI0eLVuAsSifMFM7ecmxyn0niBuED1HwgdqXvxdK6/83qwclDn33uJ00HvYX/Qb8N
         iOIQ==
X-Gm-Message-State: AOJu0YzWAOGnlwgMTM36NYcFI4ZRKOxSCAQDPPoUygw+6bG2Nb5uTiWr
	ILm4THHNVq9ds/9BEgmVX3vzpw==
X-Google-Smtp-Source: AGHT+IH6/uuBrAnsOm7F4wAtAo29f7kCltyS4IXvkG7MUjDFz4rXIVhdw+TV/WovICXgJHEqV/OYXw==
X-Received: by 2002:a17:902:d352:b0:1b8:a812:7bc2 with SMTP id l18-20020a170902d35200b001b8a8127bc2mr1702926plk.8.1691760082247;
        Fri, 11 Aug 2023 06:21:22 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id bi8-20020a170902bf0800b001bba3650448sm3859534plb.258.2023.08.11.06.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:21:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qUS4u-005R6A-6p;
	Fri, 11 Aug 2023 10:21:20 -0300
Date: Fri, 11 Aug 2023 10:21:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH 02/11] iommu/amd: Introduce struct
 protection_domain.pd_mode
Message-ID: <ZNY10HmLfbmTRiiG@ziepe.ca>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-3-vasant.hegde@amd.com>
 <ZNJflxeIWtJLC896@ziepe.ca>
 <7725dfde-2fed-ad61-eb5f-358edd2df052@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7725dfde-2fed-ad61-eb5f-358edd2df052@amd.com>

On Fri, Aug 11, 2023 at 03:34:46PM +0530, Vasant Hegde wrote:
> Jason,
> 
> 
> On 8/8/2023 9:00 PM, Jason Gunthorpe wrote:
> > On Tue, Aug 08, 2023 at 10:02:23AM +0000, Vasant Hegde wrote:
> >> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> >>
> >> This enum variable is used to track the type of page table used by the
> >> protection domain. It will replace the protection_domain.flags in
> >> subsequent series.
> >>
> >> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> >> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> >> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> >> ---
> >>  drivers/iommu/amd/amd_iommu_types.h | 7 +++++++
> >>  drivers/iommu/amd/iommu.c           | 3 +++
> >>  2 files changed, 10 insertions(+)
> >>
> >> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> >> index 0d339e022572..5e89032b3dee 100644
> >> --- a/drivers/iommu/amd/amd_iommu_types.h
> >> +++ b/drivers/iommu/amd/amd_iommu_types.h
> >> @@ -555,6 +555,12 @@ struct amd_io_pgtable {
> >>  	u64			*pgd;		/* v2 pgtable pgd pointer */
> >>  };
> >>  
> >> +enum protection_domain_mode {
> >> +	PD_MODE_PT = 0,
> >> +	PD_MODE_V1,
> >> +	PD_MODE_V2,
> >> +};
> > 
> > PD_MODE_PT is redundant because the domain->type ==
> > IOMMU_DOMAIN_IDENTITY already indicates identity. It is better not to
> > denormalize the data structures.
> 
> We need to track how we have setup the hardware page table here. We can use
> `IOMMU_DOMAIN_IDENTITY` for PT mode, but we don't have anything for other two
> modes. So having macros makes it easy. Hence we have introduced new macros for
> protection domain.

I think this was immediately abused in the next patch, so I'd prefer
not to see this kind of duplication. It should describe the format of
the IOPTEs and if the domain doesn't have IOPTEs then it shouldn't
need to ever look at this value.

Jason
