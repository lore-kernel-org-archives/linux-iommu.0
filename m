Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0103E7140
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777926578; cv=none; b=mEH/+tDg5fJskALRXA/OsjATq3AwHFulRVqLLk053D5IH4XOJyWwLyiekyHV8JJRJRtkWj3P4TqFq/QJKsr71XNr6uIZ/2BNYGtTJhyhzLPuR4ndT4TYcdcfwy97swS9Sp/b29qFkKDLqAJa3kHy6lDEZlnfbUrJX4zXVsopJ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777926578; c=relaxed/simple;
	bh=tNA7+IJqWXWHTQAX4XFqapmLxhYoAQxMHXa6Fh2t6zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUUrR71+T1krLjhhlvjX4e6G63qqVYQsDhU7IbQp5sAeEaa4lY7PYQX6p7TEMizsD+ModlBPi0vdyXgJJYt+Y09hMeV6lTzIyE47iAmPlQi85SM1RGY2PG9k7GTAKqRb7WqtSJFr5F9e+NkvVDTKda4DS8cLeu5O+G+id4uLM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PXP98P2B; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXP98P2B"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b46da8c48eso7985ad.1
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 13:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777926576; x=1778531376; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T46eI6nbVTUgvYLYLSypI88UdSC6OCAU/kpKqMuxbMM=;
        b=PXP98P2B+zRo/HUPL8BulPbzzVZheETf6jQ9Cr1n8n76XC7+XrecNg4OFaO4c2Bdua
         a5bJ7V4eU74fCqsuBiBKmgXvQ1UO1m8VuwqQ0YSpCyJsWXWD13GqrJlqnWdUvs3M521S
         olyY5xmKIYixQXYdATdS4noEaXJhbJh2JTDFhibnfNzQi0Z0xUO5QHmVu+jfPQaiAkzO
         x6EQcSybuX9UJvlYzO+PRSo+wBW5HGt3sT7BxrT39jpzJhW7opx58QdA3t6QmZ/SbTRD
         knqbrB/s0XFdxMP/UOMNJ/grNSmSkXcKwBG0RN40D9zo2vMUNL2FYBa0sNVQfkWvAGir
         2M2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777926576; x=1778531376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T46eI6nbVTUgvYLYLSypI88UdSC6OCAU/kpKqMuxbMM=;
        b=nqPmGkA124m3yg44Ys2wd1ld3J0EJk0mFj4BbJWykDw4fjtWttxXddlyRU8F/g+Vl3
         SYXtyOuwdaHr8vSVIxes4EHV2j7nz7KLjjCm3P5Pc5TLiZIRguLcCQvKh/2gBV9J88QN
         EdmrXDTNS5dFXP7oX7ylZuVMM/7LczpbwlWGLH9FPjzPz/dJMMPyYW72IDpvSNGppSdH
         1bwxEBBXma0pZvDx/nqO8ebzRl4zEnk0FONoXBgQXCO209lIpU2oNJimOj3plKtmAubw
         XA4M5WF/Q5QlQzmEtjfHq3tgCCsfpoSDWKD3SioAFX1gw8MlMwj9r1GZuGIsrEE86ibM
         067A==
X-Gm-Message-State: AOJu0YzQsn1HrOSyFFPtvsc3lfMX/Ig4n7J+ho4q7t4YRDuf2OtKoGG4
	cwwkv4IFoAd6wqg8CXoAQJboKC0skGSP/05/8DhE06xoWO8WFMgbb2/UASRqapS9q2G+vnd9FD+
	yG3Q/MA==
X-Gm-Gg: AeBDieupGHoku1o9W9jwTGO4I2wTTKLSvtc+ybJu9hNiH1rixD521HxG+CH/dQnPTEJ
	v53FLX/Xfls5Q3Zf6mSVzbsIbEFg0E9+KbeWrwPepZMaSJaE+mSBqR6YKTJIS8DY+qnOUEiAvc4
	Tu/3s7w3O+3kSV8Hs+qVGtvKWrcsVFuwE4djl6AEkOqjD0RQ3gVLpUMuMqe6wO4Uvw47uhfUeIM
	sfLYdg2rE5ew5J1CA7We4J6pM1g0QbBoi9bNSdxynFoZMdeB6vzaOnm/BuZsxk0O1OqhCKAksFk
	CNsg49wNRxrfw228asbP3jRAtjmokXlZ/JicJbRDJKg3L89n2Fm7X5KKOUYZaeE5FAOTxoTO8bD
	h1YRTBVWzugD8oY2n0lDWXkhNzhaYLB6KVqAYVsVozR7VpGgLAK1p0qwxMz99tr/iDls2Cp0qJa
	2iMpoegdLRmMWwEOGBliHpy++IMU1QmdwESVDeq+sDBCXcjPsWsf+2+8Z0JQ/DZ/Pwdz53XFq2J
	EBlLNWG5QBOzawyRQ==
X-Received: by 2002:a17:903:3808:b0:2b0:d1f4:f601 with SMTP id d9443c01a7336-2ba531ac243mr204685ad.15.1777926575223;
        Mon, 04 May 2026 13:29:35 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae15fabsm111073495ad.44.2026.05.04.13.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:29:34 -0700 (PDT)
Date: Mon, 4 May 2026 20:29:29 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <afkBqQz90OLkY4IN@google.com>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
 <afkAKlu4nllduGCE@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afkAKlu4nllduGCE@nvidia.com>

On Mon, May 04, 2026 at 01:23:06PM -0700, Nicolin Chen wrote:
> On Mon, May 04, 2026 at 07:33:07PM +0000, Pranjal Shrivastava wrote:
> > On Mon, May 04, 2026 at 11:01:42AM -0700, Nicolin Chen wrote:
> > > On Mon, May 04, 2026 at 04:38:42PM +0000, Pranjal Shrivastava wrote:
> > > I am thinking, maybe the call sites of pci_enable/disable_ats() can
> > > check to_pci_dev(dev)->ats_enabled instead of master->ats_enabled?
> > > 
> > > Then, we keep master->ats_enabled as-is, so detach() can revert the
> > > nr_ats_masters and ATS invalidation entry in domain->invs.
> > 
> > My suggestion in that case would be to update arm_smmu_ats_supported to
> > check if the client is a VF and check if it's PF enables ATS:
> > 
> > static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
> > {
> >     struct device *dev = master->dev;
> >     struct pci_dev *pdev;
> > 
> >     if (!dev_is_pci(dev))
> >         return false;
> > 
> >     pdev = to_pci_dev(dev);
> >     if (!pci_ats_supported(pdev))
> >         return false;
> > 
> >     /*
> >      * If this is a VF, ATS only works if the PF has already enabled it
> >      * with a valid STU.
> >      */
> >     if (pdev->is_virtfn && !pci_physfn(pdev)->ats_enabled)
> >         return false;
> > 
> >     return true;
> > }
> 
> I think that's okay to address the issue for now. But it assumes
> that pci_enable_ats() will never change so it won't fail for any
> other reason.
> 

Hmm.. in that case, could we factor out the 

	if (dev->is_virtfn) {
                pdev = pci_physfn(dev);
                if (pdev->ats_stu != ps)
                        return -EINVAL;
        }

part into a helper and export it? I think iommu drivers could use it?

> > and then in attach_prepare we can add the ats check for safety:
> > 
> >         if (!state->ats_enabled && master->ats_enabled) {
> >                 pci_disable_ats(to_pci_dev(master->dev));
> > 
> > +               if (pdev->ats_enabled)
> > +                       pci_disable_ats(to_pci_dev(master->dev));
> 
> master->ats_enabled is redundant if we check pdev->ats_enabled.
> 
> If we add a gate here, should add to pci_enable_ats() too?

Um.. I accidentally deleted a ` - ` on that line, it was supposed ot be:

-               pci_disable_ats(to_pci_dev(master->dev));

+               if (pdev->ats_enabled)
+                       pci_disable_ats(to_pci_dev(master->dev));

Praan
