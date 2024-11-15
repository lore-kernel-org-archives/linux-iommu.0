Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCACCA5B
	for <iommu@lists.linux.dev>; Fri, 15 Nov 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731676431; cv=none; b=FE+sOM+ReU7lFpDbKP22ZFaJzWBpOYKzviWkNdyWLqPb4nuZJzZhID5dCKQnplzYMbHP1QDkTzcE/UIAJMbpJIvcxguP5NAe7UbznDlJMT8L2rhE0N0leirLswVN76eKR6ZdxMtmHCT7OgD64JSdfBUeiIdHDsLRelt/euBlbFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731676431; c=relaxed/simple;
	bh=A2vKp1nZSIega3Jq1rmw6c+bbsfPHIGL8vdFiHL/1qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUp3t0QyoqQTUiBTZllfUdYLkZtvi2b9cQELR4Gb9pvopERZWlqQSF5Cewpb3kLFL3AmoJrQ4MEMB+kilXC+wVGHeO/VuQQMz3fMc2J+yypy/kINONdF9I+kmN+vfJrLaQ/2cEPoL7tgRzTRTpdGaXXZc9bODYq2ANgfqkfguHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uxxb+5Hm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uxxb+5Hm"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c87b0332cso123385ad.1
        for <iommu@lists.linux.dev>; Fri, 15 Nov 2024 05:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731676429; x=1732281229; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dDcQZwaUuM184JVlQG6/OECnnb2N/MHVT2Ls7yiNc+A=;
        b=Uxxb+5Hm4S/RQe0YYbb/xJwhqcH8+BeYEb5Yt/WELY4isyanFp0wQGdDKY39ej3bet
         uYyt2L+9CxcBJIByJXJ/GvkTFYjA8BdDYPDJeFEnw8pG96vamMrrgrI9552hcetvdGhN
         dMrvIqB2p0jtM2P0JxCDirUH+CaWeOuDDCr2NEUJFgc9lqW8joTKCaPll9ni7EhHXQar
         K0+at45li9onnO493Mg2CjmpmaojYJCqh4IBdl6/Prtq+nG6hkscNEhyk1J0DK8eA4oC
         ppd1uf240Ef6PUXJ4HqHmBbbaWSJHTfcG4LXkqVAsVozKh6R2PELl7HUgebsdMZ0n3B4
         lBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731676429; x=1732281229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDcQZwaUuM184JVlQG6/OECnnb2N/MHVT2Ls7yiNc+A=;
        b=np3ZETqCIacVAy5UTw+HXtuoOF9+Sl4M2Ock9AxjHODcKfF+x3TbL5hVMxvvgqI+0K
         W1sIqz3Qf02B2ZKlrpvntxsvB7wmBL7Hgld1cVIFml+6PDPWjFYneMasSkS/9Ix3mz7S
         DaoIIiqk0U9J7T2jXDasW1WF78NJhEgZoigDMneYSuv9TzKjQp29czkYeMdDXmt1XGqi
         fU0kfm7Vlb0TN7YIMBdpR0IHlT5wojiiQXIxZzB6vmOwvLf0O3zjHnpmHVGiI8ySIxZ4
         2yKjvNL+KKI6a5HhrMNa1qrVZj4UtLzEYs3eN7nob3Puk8JuJnStQPfi9BZGJNw9I/UM
         pg0g==
X-Forwarded-Encrypted: i=1; AJvYcCUCqdy9ZiJiWsEnvya6lWg3ngg38DrCJRGBIPKP65o/qkAPNFeOZ1HAQMrMKqVLpP+PJGZhFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxK9HmiCwGFQ/eWK4ug13CJnHzL4rE+K4cfNFs2bPf9lvI7ATpS
	Ehc73lZvI753whBmXKdUQSssvLbo3jOUrjCtxSvyUWi3h1PeHMCDdMv2FsKd0w==
X-Gm-Gg: ASbGncuJDR5X0UIfP6mF2b97xQUrABy0Vgjq3m05y2A4/bky2xnJ4VldmCe3uUlpetH
	C0P34rgzIbfQ+hgoCH9h3g2RGg1QNxCwmaUEwjNwGGlb3t4QiBU1ZrbhKe50l76VMNxk8/EAqoq
	HDaNFdf0zQfx1NdJnH7PRHmu4QOhIvue1q9XZSEz9Hol7xmpWxcSWjaP06eZG0xs/9n8hKgUwg1
	t8hglAwmn/XldivBw3Esk9RrAKHdOa+9ZRDEa1/PYumXZD0nI545qJzVi8D3LkS2tQOjXscTzZY
	EC/tZaDQ3Mo=
X-Google-Smtp-Source: AGHT+IGgr9pGsV3tOxwYY6pfmRqZgJ39D3ioRRoP4+EegvcufX4w+EwcRFExNws/54N4LuIuV5K3YA==
X-Received: by 2002:a17:903:192:b0:20c:805a:22b with SMTP id d9443c01a7336-211d09bfc98mr2443485ad.24.1731676429379;
        Fri, 15 Nov 2024 05:13:49 -0800 (PST)
Received: from google.com (146.254.240.35.bc.googleusercontent.com. [35.240.254.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724772001adsm1287021b3a.178.2024.11.15.05.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:13:48 -0800 (PST)
Date: Fri, 15 Nov 2024 13:13:36 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v5 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <ZzdJAFc_8h6LfVL7@google.com>
References: <20241112083018.1662104-1-praan@google.com>
 <20241112083018.1662104-2-praan@google.com>
 <ZzPlMlE2gpH9DQQ4@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzPlMlE2gpH9DQQ4@Asurada-Nvidia>

On Tue, Nov 12, 2024 at 03:30:58PM -0800, Nicolin Chen wrote:
> On Tue, Nov 12, 2024 at 08:30:16AM +0000, Pranjal Shrivastava wrote:
> > +static void arm_smmu_decode_event(u64 *raw, struct arm_smmu_event *event)
> ..
> > +static int arm_smmu_handle_evt(struct arm_smmu_device *smmu,
> > +                              struct arm_smmu_event *event)
> 
> s/arm_smmu_handle_evt/arm_smmu_handle_event
> 
> Also, given that these two define "struct arm_smmu_event *event"
> nicely, ...
> 

Ack.

> > @@ -1820,25 +1836,26 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> >  static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
> >  {
> >         int i, ret;
> > +       u64 raw_evt[EVTQ_ENT_DWORDS];
> > +       struct arm_smmu_event evt = {0};
> 
> I think we can keep the existing "evt" for raw and simply add:
> 	struct arm_smmu_event event = { };
> 
> So the patch could look cleaner, less the "s/evt/raw_evt" part.
> 

Ack. Makes sense. Will rename accordingly.

> >         struct arm_smmu_device *smmu = dev;
> >         struct arm_smmu_queue *q = &smmu->evtq.q;
> >         struct arm_smmu_ll_queue *llq = &q->llq;
> >         static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> >                                       DEFAULT_RATELIMIT_BURST);
> > -       u64 evt[EVTQ_ENT_DWORDS];
> > 
> >         do {
> > -               while (!queue_remove_raw(q, evt)) {
> > -                       u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
> > +               while (!queue_remove_raw(q, raw_evt)) {
> > 
> > -                       ret = arm_smmu_handle_evt(smmu, evt);
> > +                       arm_smmu_decode_event(raw_evt, &evt);
> 
> Drop the empty line in-between please.

Ack.

> 
> > +                       ret = arm_smmu_handle_evt(smmu, &evt);
> >                         if (!ret || !__ratelimit(&rs))
> >                                 continue;
> > 
> > -                       dev_info(smmu->dev, "event 0x%02x received:\n", id);
> > -                       for (i = 0; i < ARRAY_SIZE(evt); ++i)
> > +                       dev_info(smmu->dev, "event 0x%02x received:\n", evt.id);
> > +                       for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> >                                 dev_info(smmu->dev, "\t0x%016llx\n",
> > -                                        (unsigned long long)evt[i]);
> > +                                       (unsigned long long)raw_evt[i]);
> 
> Please keep the previous indentations.

Ack

>
> > 
> >                         cond_resched();
> >                 }
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > index 1e9952ca989f..abb543d987f6 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -771,6 +771,22 @@ struct arm_smmu_stream {
> >         struct rb_node                  node;
> >  };
> > 
> > +struct arm_smmu_event {
> > +       u8                              stall           : 1,
> > +                                       ssv             : 1,
> > +                                       privileged      : 1,
> > +                                       instruction     : 1,
> > +                                       s2              : 1,
> > +                                       read            : 1;
> 
> Feels odd to do so...should all of them be:
> 	u8			name : 1;
> ?

Hmmm, do you mean something like the following?

struct arm_smmu_event {
	u8				stall           : 1,
	u8				ssv             : 1,
	u8				privileged      : 1,
	u8				instruction     : 1,
	u8				s2              : 1,
	u8				read            : 1;
}

> 
> Thanks
> Nicolin

Thanks,
Praan
