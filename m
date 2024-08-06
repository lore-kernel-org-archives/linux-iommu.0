Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258904AEF5
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959937; cv=none; b=akDHjQKCtOuzOPkP3QU5NZ0/T3E8/XDQP4g3NBaBwLFCEyUjfDvaJ3xtH8SCzkgD3k0NU3qZm/DBDTWtY5aeBGGZOcEhjuTO5LmoUYf70PIZwYg9lUFMvWcRkXdQQZk12fEAy/5kV2LthmE0mp4y3R/Aue03X805+VlQavjt7ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959937; c=relaxed/simple;
	bh=2FH/dOOxWxJKfqWSoqpo4ZQuvYPtOzy40WjN5wZ2RMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZwmNhyL0qybDbXZp6MAC0zeCJNvM7yIyPAzr3Lys4UlyecemuexBINOf48pj8J47jPsu9+ifqW4hOs+sMpBwOeK1OHR1WxW9SzcYUrzk0gEOsZ9MdKj4xpXrUg4IWgBKb5M/ijkTJ19A88IxgnifTIwnzmGZoU/J0+0d/gYgGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2G1/E5aO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2G1/E5aO"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc4aff530dso296075ad.0
        for <iommu@lists.linux.dev>; Tue, 06 Aug 2024 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722959935; x=1723564735; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ9q+lL80ph0zqMaur0WSQg7aHVpr9HBiqm7INAI3+k=;
        b=2G1/E5aOM5L6VBL5xGos/0BD/Duc8C9o3kB9trHM5Wbne0Es92pGAupEur9+0k7ajB
         1qANvC8va9yP8PkW87K7vIGxnMl93/+ZTo5AEK2PaeoWIH1/IgNI6jnjcd82OALdX9je
         PF5vGGuWTNwQeaXo1cZQ1q4E4Qy+YzgU7zHjNGuwyJ5P5j7Xx7mVmuHHhGeFa9PNQQKZ
         FlpIgyNYogcwrzft6xBbnCMti/EBGBWdv93eZ4XqFZIAlmZih1e3CU/nMe4DfVdmumeP
         GfZpgPZbz0tXRYnxATjQKh4zJAMx90y7vK3Hz8H5dEXvywgSchNFa+lkE537vcO1dDmj
         4IBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722959935; x=1723564735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJ9q+lL80ph0zqMaur0WSQg7aHVpr9HBiqm7INAI3+k=;
        b=GkUncnvcWJQWUa0OiRU+MymJJ9BRRqHJX1p4/PHOW0y3v++/1T8uE6uY7SiaYalnwT
         ekbtLdyN/JGXVKfe7XNPU3W6/3NwDI1tAb4xQgZ+2vS0Hd34pHt7smGdyREpGl+cXfmV
         gTckLSQoVSDmHMafRs0N6MET0+6nfCfDUBQv7QgOsf1/yyP1565aRIf6k7YoCU+Zn4Vc
         Er3AEtCodO6ee//lWncyPAKKczoK50PFf6IWTR/Q27UHuSfRwxOeUOIaHo0XqeNqDQIH
         baiaZo0zISqzdL2VnGKtGiXNg6LYkK81mE57801PGfyiZEIJKm3xIbiVu6tjZbHCkki2
         ma6A==
X-Forwarded-Encrypted: i=1; AJvYcCUAUcnYgPk1B8V5mbR5CsF8we4c14e4dXoayKSxcJyogqRM6nsmpknTctMpeLCcxlITDXKT7w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBYTHjv+nQKCCC8fXekSR6TpkOlTZmg83ekCkRshwC9CSjtQky
	363bdt3bPKOodycNCnfx+x0RzEVoRMKK1eu2Tbftmie7GGEDN9RVBjJNScG8hQ==
X-Google-Smtp-Source: AGHT+IFAA+OF+sdoWF8GkRc3c8mBACflHchrbE/s0/v0yDpm4IdT2wPJ77Y/eswakR4oHgS78+KCjg==
X-Received: by 2002:a17:902:da8e:b0:1fb:563:3c25 with SMTP id d9443c01a7336-200767948b6mr3826775ad.18.1722959934955;
        Tue, 06 Aug 2024 08:58:54 -0700 (PDT)
Received: from google.com (255.248.124.34.bc.googleusercontent.com. [34.124.248.255])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7bceab6187asm1157647a12.59.2024.08.06.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:58:54 -0700 (PDT)
Date: Tue, 6 Aug 2024 15:58:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Will Deacon <will@kernel.org>, Kunkun Jiang <jiangkunkun@huawei.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	wanghaibin.wang@huawei.com, yuzenghui@huawei.com,
	tangnianyao@huawei.com
Subject: Re: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
Message-ID: <ZrJIM8-pS31grIVR@google.com>
References: <6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com>
 <7d5a8b86-6f0d-50ef-1b2f-9907e447c9fc@huawei.com>
 <20240724102417.GA27376@willie-the-truck>
 <c2f6163e-47f0-4dce-b077-7751816be62f@linux.intel.com>
 <CAN6iL-QvE29-t4B+Ucg+AYMPhr9cqDa8xGj9oz_MAO5uyZyX2g@mail.gmail.com>
 <5e8e6857-44c9-40a1-f86a-b8b5aae65bfb@huawei.com>
 <20240805123001.GB9326@willie-the-truck>
 <ZrDwolC6oXN44coq@google.com>
 <20240806124943.GF676757@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806124943.GF676757@ziepe.ca>

On Tue, Aug 06, 2024 at 09:49:43AM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 05, 2024 at 03:32:50PM +0000, Pranjal Shrivastava wrote:
> > Here's the updated diff:
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index a31460f9f3d4..ed2b106e02dd 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -1777,7 +1777,7 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> >  		goto out_unlock;
> >  	}
> >  
> > -	iommu_report_device_fault(master->dev, &fault_evt);
> > +	ret = iommu_report_device_fault(master->dev, &fault_evt);
> >  out_unlock:
> >  	mutex_unlock(&smmu->streams_mutex);
> >  	return ret;
> > diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> > index 0e3a9b38bef2..7684e7562584 100644
> > --- a/drivers/iommu/intel/svm.c
> > +++ b/drivers/iommu/intel/svm.c
> > @@ -532,6 +532,9 @@ void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
> >  	bool last_page;
> >  	u16 sid;
> >  
> > +	if (!evt)
> > +		return;
> > +
> 
> I'm not sure this make sense??
> 
> The point of this path is for the driver to retire the fault with a
> failure. This prevents that from happing on Intel and we are back to
> loosing track of a fault.
> 
> All calls to iommu_report_device_fault() must result in
> page_response() properly retiring whatever the event was.
> 
> > +static void iopf_error_response(struct device *dev, struct iommu_fault *fault)
> > +{
> > +	const struct iommu_ops *ops = dev_iommu_ops(dev);
> > +	struct iommu_page_response resp = {
> > +		.pasid = fault->prm.pasid,
> > +		.grpid = fault->prm.grpid,
> > +		.code = IOMMU_PAGE_RESP_INVALID
> > +	};
> > +
> > +	ops->page_response(dev, NULL, &resp);
> > +}
> 
> The issue originates here, why is this NULL?
> 
> void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
> {
> 
> The caller has an evt? I think we should pass it down.

Hmm, I agree, I don't see `iommu_report_device_fault` be called anywhere
with a NULL evt. Hence, it does make sense to pass the evt down and
ensure we don't lose track of the event.

I'm assuming that we retired the if (!evt) check from intel->page
response since we didn't have any callers of intel->page_response
with a NULL evt. (Atleast, for now, I don't see that happen).

Lu, Will -- Any additional comments/suggestions for this?

> 
> Looking at the abort_group path that is effectively what we do, but
> the evt is copied to the group's evt first.
> 
> I also noticed we have another similar issue with the
> report_partial_fault() loosing the fault if memory allocation
> fails.. A goto for your new err label after report_partial_fault()
> would be appropriate too

Ahh, yes! I'll add that too in the follow up.

> 
> Jason

Thanks,
Pranjal
