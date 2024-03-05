Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E91B7764A
	for <iommu@lists.linux.dev>; Tue,  5 Mar 2024 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654473; cv=none; b=JI2MjTZZGdXTbo6r2XrDlfUffJKR5kRFMV42lXyYUrIjhvTlc7ySUFZxF88tZSWrWvsWmmcjXlV1E3JZyUJuOvAtnPOco15pldZLZWm1Hg0wZqujb6BhsVfWgzgAJScCp4Ptr4zh++/DMfkm/EANg2m3jx+3h2bkFBaGsWRDEmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654473; c=relaxed/simple;
	bh=i7D4Hb5BeSEGKjO+OWMKB2R2RhDaBQbc8O6JVmsNh2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPU6fH4YpvNcTcaN0sJlIhxtB5/H3jnIFF7BLYH3XuFz5+B+i9jUzsNeItto2CSJtiMwvaHY86xvgYTHhvu1A/KLSR64ov9pvI/LWCN9Kcec+0FpGRGpsQ6U/3JpNkgfdyWAJ2w1+WLpEsE4dx82l3WyLrh2FGjKkJ5HhGUF1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PpgJcOg8; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PpgJcOg8"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-68fe8e20259so4359906d6.2
        for <iommu@lists.linux.dev>; Tue, 05 Mar 2024 08:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709654470; x=1710259270; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RWxN4pKFG6j7bRbmc7l28CYK9tneL9qhQLGK3Jcwa9w=;
        b=PpgJcOg8x1Kd8FEaHcrmRLdQZI/16gZl0tyzGVfS/JTStMCIqMpKtaz1UsPFhEruMw
         8NGOTlNv08xQf2m9GHZeh3UM7DgACUNPMiJkBJnuSkNEhUNTYXBITHfKT2EbsOmnM3ko
         Udv5cKwe9c3T+MPnEab/CABbaYZkJnitDMIbGMWkAiCpssEnHfzTH5mXWeK3okNuqrUH
         Qime1OWMgPr1tU4ZAxCGyzt/lDry1PoGqNIdbdO07fSvic2X+UfkADm86T7sKV5KmyfO
         U1cWd00gWRJMOGNlYVMlqOv7upMt5KhVrPztecxEeuctRz7n552WAc7AGpXyeB0ayu/P
         iC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654470; x=1710259270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWxN4pKFG6j7bRbmc7l28CYK9tneL9qhQLGK3Jcwa9w=;
        b=Lg0gzOFopStww1sZrbM4/LJpBCQBJ9Awo+zdnOV5ZLKks9TWPwunVh6McJDukwXW3y
         HWUnoPaeWMGSyX6YoKylsD3Ge/U8tUxs1uXuIAr35f4ow2YhL+ia6gPV89dT215fX2/G
         IBg++1OrniNiET2UlwlZc7v3aPoYZUpir2qhN8Ke6Kjc7seISM+RpFuOlIok5Dk/gQnN
         gGjBzxlLJV8OZu7biTBnNfRzrJxAP92sqo1OnQoFhT1m5GKAYXzQaDdVrHoraZgLDLJ0
         bZOSQSvPtHI/HAx5VXSAAKrqMjYlNUDwgIpZ8gXEXBt4+CZero6g/4P0FhQnMnPnXLSn
         1SyQ==
X-Gm-Message-State: AOJu0YwjhrlFdTTXepu/M1ZTvL84CrSxQo7R2DPbOLIzR3QU6GfyGld9
	cwGf59hrYbKv+QS+A0EQsOi5rBgvXX5QPldvXwvXHnBcmYTPHxqiwH2xWa7CQEY=
X-Google-Smtp-Source: AGHT+IH2FQpFMgxVwHwc/ztMTuLE/S9h4V0K6kFJbS5SKSkyca1Okqs8ylv6SCTpAoWTSJQjYLOtjA==
X-Received: by 2002:a0c:bf4d:0:b0:68f:3c8c:8099 with SMTP id b13-20020a0cbf4d000000b0068f3c8c8099mr2430468qvj.58.1709654470155;
        Tue, 05 Mar 2024 08:01:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id mc7-20020a056214554700b0069030a44682sm6332821qvb.110.2024.03.05.08.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 08:01:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rhXE4-00Fnbo-PN;
	Tue, 05 Mar 2024 12:01:08 -0400
Date: Tue, 5 Mar 2024 12:01:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v6 08/15] iommu/amd: Enable PCI features based on
 attached domain capability
Message-ID: <20240305160108.GJ9225@ziepe.ca>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
 <20240209112930.63663-9-vasant.hegde@amd.com>
 <20240305003219.GC9225@ziepe.ca>
 <87abadb2-aa08-3a79-e1a2-4031b2c7e791@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87abadb2-aa08-3a79-e1a2-4031b2c7e791@amd.com>

On Tue, Mar 05, 2024 at 08:40:08PM +0530, Vasant Hegde wrote:
> Jason,
> 
> 
> On 3/5/2024 6:02 AM, Jason Gunthorpe wrote:
> > On Fri, Feb 09, 2024 at 11:29:23AM +0000, Vasant Hegde wrote:
> >> Commit eda8c2860ab ("iommu/amd: Enable device ATS/PASID/PRI capabilities
> >> independently") changed the way it enables device capability while
> >> attaching devices. I missed to account the attached domain capability.
> >> Meaning if domain is not capable of handling PASID/PRI (ex: paging
> >> domain with v1 page table) then enabling device feature is not required.
> >>
> >> This patch enables PASID/PRI only if domain is capable of handling SVA.
> >> Also move pci feature enablement to do_attach() function so that we make
> >> SVA capability in one place. Finally make PRI enable/disable functions as
> >> static functions.
> > 
> >> @@ -2036,6 +2038,7 @@ static int do_attach(struct iommu_dev_data *dev_data,
> >>  		     struct protection_domain *domain)
> >>  {
> >>  	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
> >> +	struct pci_dev *pdev;
> >>  	int ret = 0;
> >>  
> >>  	/* Update data structures */
> >> @@ -2050,10 +2053,16 @@ static int do_attach(struct iommu_dev_data *dev_data,
> >>  	domain->dev_iommu[iommu->index] += 1;
> >>  	domain->dev_cnt                 += 1;
> >>  
> >> +	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
> >>  	if (pdom_is_sva_capable(domain)) {
> >>  		ret = init_gcr3_table(dev_data, domain);
> >>  		if (ret)
> >>  			return ret;
> >> +
> >> +		if (pdev)
> >> +			pdev_enable_caps(pdev);
> > 
> > But here we are turning PRI on for an IDENTITY domain and for a v2
> > domain that doesn't have a PRI handler. This is not technically what
> > we want to see, the PRI capability at the device should only be turned
> > on when a PRI handler is available in the SW side. Otherwise PRI
> > should be off and non-present ATS responses should fail in the device.
> 
> We are setting up handler right after enabling capability for both IDENTIFY and
> v2 domain as both can support SVA mode.

It is enabling PRI when the device can enable PRI but before any
driver has actually asked for any PRI features. It is technically too
early.

It should be enabled when a SVA domain is first attached.

Like we don't want the HW to generate PRI faults from a VM
deliberately banging on non-translated page table memory. This is a
pure DOS attack on the hypervisor kernel and should be prevented by
having PRI turned off.

> > Also, PASID enablement looks like the wrong spot too, it should be
> > done in the probe_device() callback and stay enabled. The bit is set
> > if the IOMMU HW can decode the PASID TLP. Ie don't enable it on old
> > IOMMU HW that can't understand PASID.
> 
> Our V1 page table is not compatible with PASID. Hence currently its done in
> attach_device path.

What does "compatible" mean exactly?

The PASID cap on the device is only about the IOMMU HW ability to
properly *parse* PASID, it can fail every PASID tagged TLP and it
would still be fine to turn it on at the device always.

v1 is clearly not able to route PASID to different translations, but
as long as a v1 DTE fails every single PASID tagged TLP you can always
turn PASID on at the source just fine.

It would be a very weird design if v2 HW makes the DTE in v1 mode just
discards the PASID and translates everything with the v1 table. I'd
also wonder if the identity/blocked cases are similarly weird?

IOW, I would expect to see probe_device check if the HW supports V2,
if it does it knows the HW can parse the PASID in the TLP and will
abort PASID's without translations (ie v1 DTEs). Then you turn on
PASID support always. If the HW supports only v1 then assume it
doesn't know how to parse the PASID and will ignore it and fold all
PASID requests into the RID. Leave PASID always off.

Jason
