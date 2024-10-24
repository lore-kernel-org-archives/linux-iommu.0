Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2621EABD2
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779293; cv=none; b=eWy5RoBX65jR8epp2EbndPVT7Tegz6KuqitsHl+TwZltu7Lnp4G2ZzxGAB52Ewhdj/MSvWcYhWHnzo432zsJh/VfMZroo9BWOFSGWiNPcWnYjV0PE8Q7CtSPePBmbC+6g9xud3OSe6/xQ5PcLEGRj0Xq4EUdoYQDgts+SloeFJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779293; c=relaxed/simple;
	bh=ji+1mIom0A2Dw6E250Ssm/EC2Chx9eSKYKgdY8WGbwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXWaqb5uOFsRcLGVLxCrZ840IOmYtbLS/EZxrY0ObjdWay3Pcwkm883FiIW4NecUZ9rsRGwlxpwOWaLmaF5oVYDf/nqNIazxhDnMJ24KTXY5sl3IgLNmALDavDPdq62psR/LPYw41L4H6ZHYdbWrPb8tR1s+8kDB6wYxvm5H9S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZqHCSeiF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZqHCSeiF"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ca03687fdso123165ad.0
        for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729779290; x=1730384090; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C+K2J6jP8PbdJSf5t25dfnLhcU5BvbpjktDsSwebV2o=;
        b=ZqHCSeiFO554/YAhkktdHKxpOeiBEI3pTTOfghj1qkzAXvlHCQlvU36j9SL7opVb95
         Y5R1Nr04VKNTf3N2RzyL/Y8DGA5DiCQ+MgqqRM+iojkux3o88lJ4ztYoQ/G47lUaCEAV
         T3WoPoVkBvSD2VWZNIQKiqAV4jEU7HfqmXcnoeE9vE/HcgKnRuuDT6JtdGImJqQWGvTL
         JsdLkDgBOPspeRxFaeBXVkdAwgR/WupD71Faai4sXyrqXZB45Ki3hj5i7sX5ULsJ0kzf
         L1zaOya3GkXBgbyAQboB/IBvHD+v7EPxfr9xFLM2A7lG3IY8lNoSqScAa8IfhQag7fr5
         cHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729779290; x=1730384090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+K2J6jP8PbdJSf5t25dfnLhcU5BvbpjktDsSwebV2o=;
        b=uY4ELXboTGLiHm5gT0ehJ0YT/qGQXmgOnsVtXYQ/njpy38dr/utUNuWqXBdaqoCKmr
         ouYcoGKCEXrZQ58UtBsfSKjK6V0GB4P3vjMHRYpRsDaRYuEkna0m7Sg4lqEk8u4JIyIw
         6rE7p6X3xXM0qPIlG3wHtDAQZ+JHy6DU34F4UQSzCEWe5s+u1548ZWWXLTfdAQrh7Ua/
         XTe+IgwSSO7HvTIHb240ewleC1o6/VrR/G7EzKGA5FZOM8mFTlA82cuvuivzOJp5nMDe
         B6n1C37aDCrU1KHM+xtyNupDbYCINdcPvnz3mGomMkR8vlYLtsKdVwnnerpH7JFPpUEK
         +vbw==
X-Forwarded-Encrypted: i=1; AJvYcCVigc9bU29aN/1kXR5AFlOhkLkuvekGtWRtsjRUEwYZqoOmT/CPOEx96rMm7ICqJMDYfZE14g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyl//9PdERXOcfbOWk8jffRs2n6Gre7pW2yHfRoLUWmhNlz1C8y
	rpK5jLhRHBfLnWrOT3fYlJ6xkBrGGxOm1LjUXwoPVXXKF+f+nuB4PLe0yFUHtQ==
X-Google-Smtp-Source: AGHT+IFUKQrlHVnjyyvvsKKcDXtRKiGFZ7Vxhoq2fe1EYlRM6HWDgBB3h6DoYMp0MR0yqc6gV1mN6w==
X-Received: by 2002:a17:902:f542:b0:1ff:3b0f:d61d with SMTP id d9443c01a7336-20fb5fafc2bmr2784635ad.24.1729779290023;
        Thu, 24 Oct 2024 07:14:50 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee89cdsm73157455ad.11.2024.10.24.07.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 07:14:49 -0700 (PDT)
Date: Thu, 24 Oct 2024 14:14:42 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Will Deacon <will@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 2/3] iommu/arm-smmu-v3: Log better event records
Message-ID: <ZxpWUp8O6QXEe9xv@google.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-3-praan@google.com>
 <20241024131511.GH30704@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024131511.GH30704@willie-the-truck>

On Thu, Oct 24, 2024 at 02:15:12PM +0100, Will Deacon wrote:
> On Fri, Oct 18, 2024 at 06:00:21PM +0000, Pranjal Shrivastava wrote:
> > Currently, the driver dumps the raw hex for a received event record.
> > Improve this by leveraging `struct arm_smmu_event` for event fields
> > and log human-readable event records with meaningful information.
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 109 ++++++++++++++++++--
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  13 +++
> >  2 files changed, 113 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 2f1108e5de51..4477cf86cb8e 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -83,6 +83,34 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
> >  	{ 0, NULL},
> >  };
> >  
> > +static const char * const event_str[] = {
> > +	/* Bad config events */
> > +	[EVT_ID_BAD_SID_CONFIG] = "C_BAD_STREAMID",
> > +	[EVT_ID_BAD_STE_CONFIG] = "C_BAD_STE",
> > +	[EVT_ID_BAD_CD_CONFIG] = "C_BAD_CD",
> > +	[EVT_ID_BAD_SSID_CONFIG] = "C_BAD_SUBSTREAMID",
> > +	[EVT_ID_STREAM_DISABLED] = "F_STREAM_DISABLED",
> > +
> > +	/* Bad translation events */
> > +	[EVT_ID_TRANSLATION_FAULT] = "F_TRANSLATION",
> > +	[EVT_ID_ADDR_SIZE_FAULT] = "F_ADDR_SIZE",
> > +	[EVT_ID_ACCESS_FAULT] = "F_ACCESS",
> > +	[EVT_ID_PERMISSION_FAULT] = "F_PERMISSION",
> > +
> > +	/* Bad fetch events */
> > +	[EVT_ID_STE_FETCH_FAULT] = "F_STE_FETCH",
> > +	[EVT_ID_CD_FETCH_FAULT] = "F_CD_FETCH",
> > +	[EVT_ID_VMS_FETCH_FAULT] = "F_VMS_FAULT",
> > +	[EVT_ID_MAX] = NULL,
> > +};
> > +
> > +static const char * const event_class_str[] = {
> > +	[0] = "CD fetch",
> > +	[1] = "Stage 1 translation table fetch",
> > +	[2] = "Input address caused fault ",
> > +	[3] = "Reserved",
> > +};
> > +
> >  static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
> >  				    struct arm_smmu_device *smmu, u32 flags);
> >  static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
> > @@ -1756,6 +1784,60 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
> >  	return rb_entry(node, struct arm_smmu_stream, node)->master;
> >  }
> >  
> > +static void arm_smmu_dump_raw_event(struct arm_smmu_event *event)
> > +{
> > +	int i;
> > +	struct arm_smmu_device *smmu = event->smmu;
> > +
> > +	dev_err(smmu->dev, "event 0x%02x received: master %s:\n",
> > +		event->id, event->master_name);
> > +
> > +	for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> > +		dev_err(smmu->dev, "\t0x%016llx\n", event->raw[i]);
> > +}
> > +
> > +static void arm_smmu_dump_event(struct arm_smmu_event *evt, struct ratelimit_state *rs)
> > +{
> > +	struct arm_smmu_device *smmu = evt->smmu;
> > +	char title[100] = {0};
> > +	char mastr[100] = {0};
> > +	char addrs[100] = {0};
> > +	char flags[100] = {0};
> > +	char other[50] = {0};
> 
> I haven't followed previous versions of this series in detail, but
> allocating 450 bytes on the stack for this seems excessive to me.

Hmm, I think we can reduce the title, mastr, addrs string to 50 chars
and the `other` can be reduced to 30? Or maybe we can avoid printing the
`stag` and `stall` fields altogether which should reduce it by 200 bytes
We can save another 20 bytes by reducing the `flags` len to 80 bytes,
overall saving us 220 bytes of stack space.

I introduced this in v3 [1] based on suggestions in v2 reviews [2].
I can revert to the approach followed in v2 [3] as well.

LMK what's your vote?
> 
> Will

Thanks,
Pranjal

[1] https://lore.kernel.org/all/20240928005143.2378938-1-praan@google.com/
[2] https://lore.kernel.org/linux-iommu/ZtAW0hVPFD6JbLTL@Asurada-Nvidia/
[3] https://lore.kernel.org/linux-iommu/20240827193026.3993039-2-praan@google.com/
