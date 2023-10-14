Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D027E
	for <iommu@lists.linux.dev>; Sat, 14 Oct 2023 00:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="knTMTpxD"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-66d0252578aso14079546d6.0
        for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 17:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697241802; x=1697846602; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1pu4GPKVHdVAz2d7eDY4KT/eGDlYfuZ16MfTjdAOYmw=;
        b=knTMTpxD7lX0Xo4KmBDbcmvlVojt7pckqQqWzusYMO+2vtNfd08102ft6+//k2Or9r
         asG+pzMqW12vXd5Lhy1GSLQZIANUyGHuEzCWlFUfA2T2mi3JU6KoHKuJ3LjgC6IDq7EI
         GdWeP4YsO/TBtWuSv1Z5DCaAJsl9wJijxROpa5sNh5fdXP3ur12oChIbjfcfirrEfIq6
         yYAEEuXXKOA7topyz7xIXVfvW0m6XzSwfmZMIhc/t7D0L5OXnUzz/w/fIHd2ddGax7Ai
         kMHmiHP2wTjKp6pZu7109c3fp72bTUVMvoM7cslF9sJgzzcC4Du1BOFTPzISFn3HRctu
         +ExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697241802; x=1697846602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pu4GPKVHdVAz2d7eDY4KT/eGDlYfuZ16MfTjdAOYmw=;
        b=i6YZrZl9kuvmfFRuGGjh/pykpy9HDnPI4gSPojPsuM3fkgl+Ylw00XiA6IUUZ/KuCO
         fCwjrxJU7nkIhwnB+LlwSQqPQtckn//qN7O2PDV657yJGquLmPmV7UBRL8C8DyuEBGyR
         Dg5dGxcoxkDrDyQ9TB5ibs12DvLZN9U8QwyxYOShExlY3hopHNsvHe5C4sOPSutGuAtX
         ecWL9+bgI6OLlZX/TRGY+YztbfeUb2ekHbhx7bC3m8UYjqlgR7xrYuc4gjOi0y94fHId
         NoGVfIA+DqwVJTdhl8ZFEpiohWSY3rXPxSWIPSHfNRAK/7ipzYorR1RKS0N2f/s8gZK/
         vH8g==
X-Gm-Message-State: AOJu0YwkeTgvFnW9oTUdQ1E+EwX+I3GEMgD1WB7k3GPULhCmZgcYdN9E
	aSMjuzaMbHCjTOLf6BHIVdKpUw==
X-Google-Smtp-Source: AGHT+IFXKpnhZIF3r+jb1/NGjuk/3ZXchiBGhzijmn+1NKrsV3KuT4ItUUZVh6nhRwWutOErHx+78Q==
X-Received: by 2002:a05:6214:cae:b0:66d:1d92:c694 with SMTP id s14-20020a0562140cae00b0066d1d92c694mr6175065qvs.58.1697241802137;
        Fri, 13 Oct 2023 17:03:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id j28-20020a05620a001c00b007756d233fbdsm1058544qki.37.2023.10.13.17.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 17:03:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qrS7k-001Xz2-S8;
	Fri, 13 Oct 2023 21:03:20 -0300
Date: Fri, 13 Oct 2023 21:03:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Zhang, Tina" <tina.zhang@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v7 4/5] iommu: Support mm PASID 1:n with sva domains
Message-ID: <20231014000320.GC282036@ziepe.ca>
References: <20231012030112.82270-1-tina.zhang@intel.com>
 <20231012030112.82270-5-tina.zhang@intel.com>
 <20231012134310.GI55194@ziepe.ca>
 <MW5PR11MB5881ECF6757B0211A18B208C89D2A@MW5PR11MB5881.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB5881ECF6757B0211A18B208C89D2A@MW5PR11MB5881.namprd11.prod.outlook.com>

On Fri, Oct 13, 2023 at 09:57:30AM +0000, Zhang, Tina wrote:
> Hi,
> 
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Thursday, October 12, 2023 9:43 PM
> > To: Zhang, Tina <tina.zhang@intel.com>
> > Cc: Tian, Kevin <kevin.tian@intel.com>; Lu Baolu <baolu.lu@linux.intel.com>;
> > Michael Shavit <mshavit@google.com>; Vasant Hegde
> > <vasant.hegde@amd.com>; Nicolin Chen ^C-cc=iommu @ lists . linux . dev
> > <nicolinc@nvidia.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v7 4/5] iommu: Support mm PASID 1:n with sva domains
> > 
> > On Thu, Oct 12, 2023 at 11:01:11AM +0800, Tina Zhang wrote:
> > 
> > > @@ -1188,15 +1193,26 @@ static inline bool
> > > tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream  #ifdef
> > > CONFIG_IOMMU_SVA  static inline void mm_pasid_init(struct mm_struct
> > > *mm)  {
> > > -	mm->pasid = IOMMU_PASID_INVALID;
> > > +	/*
> > > +	 * During dup_mm(), a new mm will be memcpy'd from an old one
> > and that makes
> > > +	 * the new mm and the old one point to a same iommu_mm
> > instance. When either
> > > +	 * one of the two mms gets released, the iommu_mm instance is
> > freed, leaving
> > > +	 * the other mm running into a use-after-free/double-free problem.
> > To avoid
> > > +	 * the problem, zeroing the iommu_mm pointer of a new mm is
> > needed here.
> > > +	 */
> > > +	mm->iommu_mm = NULL;
> > >  }
> > 
> > newlines after all the }, between functions doesn't checkpatch complain?
> Checked with checkpatch but didn't see any complaining.
> 
> > 
> > IMHO this hunk should be moved to the prior patch.
> In this patch, we switch to use mm->iommu_mm. That's why the iommu_mm initialization is put in this patch.
> 
> I think I met some problem about my mailbox when I was sending this
> new version. It didn't cc iommu@lists.linux.dev. Should I resend
> this version again or reply to the patches with
> iommu@lists.linux.dev cc'd?

Tidy the nits and resend a v8 if addresses got missed

Jason
