Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEC61CDA0D
	for <iommu@lists.linux.dev>; Tue,  1 Oct 2024 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816572; cv=none; b=a4jHKGhLhLGXhfYfnS51R2TnsYLSShJ2ATfm2HHstd3DTS0pj/8o9QpJbo9ONFqEoKvbKrSPw+y8NzGAMd8jPAYokkkBX7p6k2qhFQkEvhsiiPkOgwpjjCfxmUGGq8kJ0pNtxhCdiPjzQ/c7X4StJ8FDJNs0DqLN8y4s2uSerQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816572; c=relaxed/simple;
	bh=UTSBBo+XodprURcYbR2xvKG3fzeUHWPbac8LlJQmWl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ik78tzroQIAWBnrGCRmBuaVIcHAtVhgen3Ku9pg/NMDquDC+pxv/NLZXLuHyfEnDa5woVQdcYept777WDTx8PvfkpPtExXpZxOEri3b6ACSThTdMxzYS3L6fR2wu47cR28CRpg4H98dRBR0pUlfQVDXrWJaUgG4QOa86zeo1e7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4YIK8m3f; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4YIK8m3f"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b061b7299so19025ad.1
        for <iommu@lists.linux.dev>; Tue, 01 Oct 2024 14:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727816571; x=1728421371; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K6lfavkTGCVgHihI/9pFimihzZ38TdrpfCqIV+z5B/0=;
        b=4YIK8m3fNNDzJwHoBMN8QLTzScI64KX/5VKsfz17FN/+gl78nLC8mS17ZT/Jyd8R0O
         iSI3BkeCt3trM4GbFWSAly48uOdrvuyNdZo2SYilmVb01gMiGSoysYvZBAaHYkNaJmA6
         6zEN82Cde+8T+BIu2/XD/y6W8Gl2LDfGpGPyO27xqcWKiFZt0paNB6eI/yWD41eKQ/Kx
         pHRM2bhSbFiDravkUUQJHxh+JTX5TyX63uCX387DgWVqiTcBoLnB0GWngmD1dN2o4Xq1
         9yb62bv0A1sKUL7HRtNA9jL2GLQ8Vd1nlUNk0Vec5ExlJkBoONHLEJx3G4+owraptQEW
         5+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816571; x=1728421371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6lfavkTGCVgHihI/9pFimihzZ38TdrpfCqIV+z5B/0=;
        b=ho9WMI/MCAnQGRTO1Jsjvv98Kdz+mjRj1x3OTTfXHXQ//m5eL5sPeury0mv9TOukyt
         qOWEWrJrElSi7JtRKh/EfZ4HZCY7T+ZpLacmOqP6+bj6FUWsNJs6IPUYpI5XvCBJzA1a
         2HNPBLe/ZjHtF/tKYX5r5kIu5FWiO8GiVK/rhLIQ9SFPkXTwJ3LCSKETEW76GhcbqN46
         CyL8o5lK5pK9CBl6jxBePwns4C/Hmy4bSbfPmBsfmKK6FvsCZOGs2kZRwkSWhbfAxDgF
         qNzPUqA9iuOj5ozHm5PLvVboJHl5Rv0wdrcNZd+NVD1rEHzO5vKtx+GZLzS427j/QpzS
         vHbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSWO6fMRWZW9x4SsPKc7cypXC81GZS+5HR3rRQbAZLL/yGtysDW5HVUsegV2ddyRgPeEVdVA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzc1+Fuq01QwIwgmvqu29+H56Dp32lt9j8u73U3eCB33wx5Bttm
	6QKFx3OwYajUpnNWjaf8R/rU2FdpKI+NX93KSOrxYgQ9gxDERwo8Rvi+XRv+iA==
X-Google-Smtp-Source: AGHT+IF/3opIKXlLNWomDQnRgjzJdY2P3BahI7InUefanRpnU1/g767+25/HBiO2MaAeZaAVEEv3Mw==
X-Received: by 2002:a17:902:da8f:b0:207:14ca:f0c1 with SMTP id d9443c01a7336-20bc6a9fe27mr850475ad.16.1727816570437;
        Tue, 01 Oct 2024 14:02:50 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18fa05057sm21308a91.41.2024.10.01.14.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 14:02:49 -0700 (PDT)
Date: Tue, 1 Oct 2024 21:02:42 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Adopt arm_smmu_event in
 handlers
Message-ID: <ZvxjcpQCFM5SU9P-@google.com>
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-3-praan@google.com>
 <Zvr8xUEHNg1GiA8V@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvr8xUEHNg1GiA8V@Asurada-Nvidia>

On Mon, Sep 30, 2024 at 12:32:21PM -0700, Nicolin Chen wrote:
> On Sat, Sep 28, 2024 at 12:51:43AM +0000, Pranjal Shrivastava wrote:
> >  /* IRQ and event handlers */
> > -static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> > +static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, struct arm_smmu_event *event)
> 
> Looks like we could stuff an smmu pointer in the event:
> 
> struct arm_smmu_event {
> +	struct arm_smmu_device *smmu;
> 	struct arm_smmu_master		*master;
> 	const char			*master_name;
> 
> Then both this arm_smmu_handle_evt and arm_smmu_dump_event can be
> slightly cleaner.
> 

Makes sense, we can read that in the get_evt_info.

> > 
> >         mutex_lock(&smmu->streams_mutex);
> > -       master = arm_smmu_find_master(smmu, sid);
> > -       if (!master) {
> > +       event->master = arm_smmu_find_master(smmu, event->sid);
> > +       if (!event->master) {
> >                 ret = -EINVAL;
> > +               event->master_name = "(unassigned sid)";
> >                 goto out_unlock;
> >         }
> 
> The PATCH-1 already did arm_smmu_find_master() to event->master in
> arm_smmu_get_evt_info()?
> 
> Maybe we still need a wider mutex to lock arm_smmu_get_evt_info and
> arm_smmu_handle_evt.
> 

Yea, we did, I'm wondering if we really need to read the master_name in
arm_smmu_get_evt_info ? I mean, we can find and populate the name here
itself under the safety of this mutex and entirely remove that lock from
arm_smmu_get_evt_info as we anyway will dump the event after this line.

I'm not too sure if we should hold this lock for the entire duration of
get_evt_info and handle_evt ?

Also, shall we rename it to `arm_smmu_read_evt_info` ?

> Thanks
> Nicolin

Thanks,
Pranjal
