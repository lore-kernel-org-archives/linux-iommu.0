Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AC723A9BD
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 05:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780550555; cv=none; b=Xcq7Gm8rHxSX48647NBMJtFuZRIs8sPJgCVVliQUTkyg1QOoHlg1XeNAJfMDcP4JC2PmRS2Pwx+dYqqEdcWQ8sVpC/8Dy0RhEHZzWG7/2dTjRdwwoBeFHM3mpyII/8jKTZLY3yqHzGP7wta91X60Uvh2v+RCpzXzueFfXIq3Qr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780550555; c=relaxed/simple;
	bh=nSVP0hjf/94PXAvWtt46EmkkqHdos3NIt1wmoREGLY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nR6mVIquWPOpBiAo/UIudXdORghlROd+KDRcwHSDrvMSKusmIwej1bFe404TSEIqEo6bJUIA4ylpRpEPxli7YH9u3JA5iRypG/CJvSyCw8e02CsD4QlNklb7IHXvblDG0a7fLE16V5UE5LR9OGNq7Zt86GAWtMDZqZcFU0WV2rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J9eawuin; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J9eawuin"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf2d865383so47115ad.1
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 22:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780550553; x=1781155353; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kt92/T/ew+FoBUCV9JwGPlixqsptuzo1rSptMNUtFGY=;
        b=J9eawuinXyJiWweGnqfauv2hxTlbejApqcglIM4T+B5knG1Qn0ZHS4VJH2CfhMQ0pn
         2LwUlf89SjVt6kKERsDyS8FwINEpAZwxs1mw7g92zu5/AX7LpRJyjX9dx1UTbDSWJdAI
         j26sLdC9t/5yBQbXcx7nZxZBvN67pUpUN8fmi9Qw4P/QA04VLODfsqD94ao2Fgs9jVAq
         yUj2rojznqGA2UvQRdZ0C0o+iY9ZxWBA22UFw+7aFLnlxUU39HxP9aMUAurnW7jC9Bu2
         YiNOdfMlDIVPOij6hDFJoItAJCF5+G8HZI8zwLvyaH2dFVTC1Pkw/8Tz+ahkCFZi+znI
         orMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780550553; x=1781155353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kt92/T/ew+FoBUCV9JwGPlixqsptuzo1rSptMNUtFGY=;
        b=hJE/uRpC/BNoJU5pLnsi8+On+uBKmNzhnns+riddfKSgbmjEas8TrgHdqoFZ0L5Q3u
         8fqB+GH8swx0nrNzhDCnTYNSwmue5ZUAt328anUYC3LCptr+j0MJmd4y5JL0JeBawxFv
         wa3oYpk+SJpCpeJHDqXg6h9Dh5v0pjbNm+ttLNrH7wGcSFo95qkALfNXP0ff59JIP7hu
         bEwf+vFJLCC2IKsPbwfgMj/3UF6kGE8fukdM7iFJnn+dWjGzuBt2qOLRH/GWfGfkTliV
         ch04FRRA255UjAWAD9uTbvqEqen0hEmksOLpms+z8Vylz8lEG/2ueA0NhtxqQq1eDjiS
         IHAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Oo8MDDnvMxj/XL8SilNwFRE4YdCtCh0r9yMxwcCJoi7S2aOfkKsU7gg0sybKWRAY0tfpfxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYfJ1WFZTq0NaR38MYLQh2XvpJ7USuNC3J+AFB14jV4d6gP4ey
	XdfCRYNT6YBNnc4/tCJUWSEfEmcU73LG46vvaYETGOki/TKEeVnMAVzcPq7JSTnGZQ==
X-Gm-Gg: Acq92OF1N3T80OVd6fb9rl+4ZLGa6I9NmTVbj7k/cDlMVx5hJk00Z7BVwHgn1TGNcCc
	UdAs+waM/wjX/BuKLrnbmSUo/x2Drz5NDsulAIOPqtZH9z2kjHSfPeOM9i/NJFusTTV1OE/nz/X
	G+mSSrpvQc6cwFWf2mHW3QQbTz13//mAhSCkEJEts/pjVXrgoXv/srdRdNojM93zPr8xMV9s6q1
	z2a3zjW5YTBj12MZ3KqZQEdYCa9a/7/2WNzX9roDAcLvGzg9EvJd16LUIo3shZWFovtPIo+hiC4
	+KAyPJTYNqAkEzC6OiUc/2E8PBMl8CXex3FMfhIKmMMB/F3kalEqUIYZ0fbZ2ZgxuxV7/b4wCMX
	esJd+m0FfyZ/DRXKYxAlQm0O/AoeTaw/ewjNaHUjOf7RFpPjNEyqcj4SYr+GpqPeIOHOMt1nE5y
	onAtUXykNdI2fB1v5GRV8Vvz/zbzA0L0DyVnXjERak/992aQ74CE5Sv8nhOOaOkc+Pfg4hn/Q=
X-Received: by 2002:a17:902:f790:b0:2c0:c3ac:fdf9 with SMTP id d9443c01a7336-2c198b295acmr2052415ad.14.1780550552540;
        Wed, 03 Jun 2026 22:22:32 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649d2dfsm43367335ad.75.2026.06.03.22.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 22:22:31 -0700 (PDT)
Date: Thu, 4 Jun 2026 05:22:25 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v7 3/5] iommu/arm-smmu-v3: Fix a UAF in the probe_device
 error path
Message-ID: <aiELVKlSTOEptU0O@google.com>
References: <20260601143644.2358771-1-praan@google.com>
 <20260601143644.2358771-4-praan@google.com>
 <DM6PR11MB369078B4E5BC3C6514A99AFE8C132@DM6PR11MB3690.namprd11.prod.outlook.com>
 <aiAr_YZqVwijXyQ5@google.com>
 <20260603145903.GC1170766@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603145903.GC1170766@nvidia.com>

On Wed, Jun 03, 2026 at 11:59:03AM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 03, 2026 at 01:28:29PM +0000, Pranjal Shrivastava wrote:
> > On Wed, Jun 03, 2026 at 07:31:38AM +0000, Tian, Kevin wrote:
> > > > From: Pranjal Shrivastava <praan@google.com>
> > > > Sent: Monday, June 1, 2026 10:37 PM
> > > > 
> > > > Clear the iommu->priv to NULL while returning an error from probe_device.
> > > > 
> > > > Fixes: a2be6218e649 ("iommu/arm-smmu-v3: Improve add_device() error
> > > > handling")
> > > > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > > 
> > > probably add a note that UAF is theoretical at this point.
> > > 
> > > iommu_init_device() calls dev_iommu_free() right after @probe_device()
> > > fails...
> > 
> > Ack. This is just to prevent a UAF against future refactors. I saw the
> > intel & amd iommu drivers doing it and felt this is missing from smmuv3
> 
> That is just pointless dead code, the core code immediately frees the
> memory this is NULLing
> 
> static int iommu_init_device(struct device *dev)
> {
> [..]
> err_free:
> 	dev->iommu->iommu_dev = NULL;
> 	dev_iommu_free(dev);
> 	return ret;
> 
> I would remove it from the other drivers not addd it here..

Ack. I tend to agree... I'll drop this patch here and request Baulu to
drop it from his PR too.

Thanks,
Praan
