Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A73E748D
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991285; cv=none; b=cPObYgMc0IdPSrIV1D06d869Y0dL7hpIvMeUvmxVgWarn57s9Mh7d3xpiAbD9DACzLlZCdaP9FyS1fW/Q1XElBWyuf9AIfrqwDDnLI68SlQICFv3LNnub9hN37bzjUHTlYiJxgJPmQ2mupENUacxBi0VPi9y1ARtmUCr2JHZaEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991285; c=relaxed/simple;
	bh=qNY+5NSaCAJYNalWulvIs88Q8iSOGCHW0wnlJOF/CkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4Ff1r3aSiOeZf3K7o60Kqz8YkCV3cxNfJYvYfAJMuxX0Q29ILKX119milvPaxTsK+uD3XkjQ+j6JpOWTrG2GeR1eGjc7fnGQUWfTRkwa6E4Vp5TNx7zEe2L4/SRvqNW6oJ1SPktlNYQ/0bQtzY9OzwQ45Vw31ZfmYS+68rJWQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=idlrTZUU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="idlrTZUU"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b3d1a77bbso62375ad.0
        for <iommu@lists.linux.dev>; Thu, 03 Oct 2024 14:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727991283; x=1728596083; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L4ETA/oZHNQ8ZYrD1eF7OuF/od9qN8JKOa4YFKcaMO8=;
        b=idlrTZUU4NIVIL3vAFR5Rp/2PN0zW4tcCo4Xq4B0XASbNDIPxssIx/aZZbUbg81jyE
         l4fdqGBGSxpQI+P6sCqfRbD9dG3Tbok7VqyBSDqtgN1T5Ijl5+Au/9kCxkpdnjZk0LPH
         /2PkTIii2EJe8L8MW8hIS1bgZWFNEozVGosM/NPzRsstFnUJoyoFwZ6OZz9oW9kD1BYF
         StQuuNRfZJfsth14soUqeszeSlxB2uZBaPSTnQA5S3UgNC1C4aPDryyU3GyekwoJuzsG
         XDtyCkfksFSWFxCB1dtq4prp6tkcU9lpZ56dobKKnXRFh9kyQ2UAnyVdo6JUwBfnKuEz
         BoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727991283; x=1728596083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4ETA/oZHNQ8ZYrD1eF7OuF/od9qN8JKOa4YFKcaMO8=;
        b=WUUFXXmxlJCskwqpbQ2CvaI1G9HKhi18fm79xaKvrZLoQmOH/xEMkYEMraprMcTvv8
         2GkJT4IbNs7NSWyvaUjDTykZ+sFbK6bHG2EWYgZC+E1cfJDJjyOwTeo3msdlP5pZA4nW
         l03aja/SPTf3t8m0aW+iughK8iCfSXFAfYgRWUOYydOC5oilvklG2oCXGS1PW/9IUJ8r
         STw97ECRUcnLTvIYsc+u7pPBmst16iIzMGfaBOKG/v2E9Pj76epcXoufZSStf2qW1cOp
         0DqS72RLagVhjmpbe7Ong89AVAhIPG0ynILNZG6fxBSYyT81X9k+6xKyViAfWhjDoK+A
         Jskg==
X-Forwarded-Encrypted: i=1; AJvYcCVTQXQchnvuQGNa069zy9UbdHWOz46qv/XuZulS/JfxQhCKVedDJU6pRnyn4h9Cx0q5dja17w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxva6G6WVpOt1Ri0gwMdK2VEXakzDm0NHsfAkFs9ABovG9StUmU
	nFdu1AQM6czwtX4/F8diHQvzYkOQQ3Z4s4NAJbdcJ02kMTQVBAxG5UFk3mZFTA==
X-Google-Smtp-Source: AGHT+IE3j6HRjW51a7wbZtrttn/jacQzvPukK4dxzXvBHbwgPjVPfDVSCJgftXH/A243bLNahICOxw==
X-Received: by 2002:a17:902:da8f:b0:206:ae39:9f9 with SMTP id d9443c01a7336-20c00dcefd8mr399175ad.21.1727991282517;
        Thu, 03 Oct 2024 14:34:42 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9dcb138b2sm1205869a12.39.2024.10.03.14.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:34:42 -0700 (PDT)
Date: Thu, 3 Oct 2024 21:34:35 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Adopt arm_smmu_event in
 handlers
Message-ID: <Zv8N6yIeNXao_Yqm@google.com>
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-3-praan@google.com>
 <Zvr8xUEHNg1GiA8V@Asurada-Nvidia>
 <ZvxjcpQCFM5SU9P-@google.com>
 <Zvx+6qBY3og8lRWe@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvx+6qBY3og8lRWe@Asurada-Nvidia>

On Tue, Oct 01, 2024 at 03:59:54PM -0700, Nicolin Chen wrote:
> On Tue, Oct 01, 2024 at 09:02:42PM +0000, Pranjal Shrivastava wrote:
> > On Mon, Sep 30, 2024 at 12:32:21PM -0700, Nicolin Chen wrote:
> > > On Sat, Sep 28, 2024 at 12:51:43AM +0000, Pranjal Shrivastava wrote:
> > > >         mutex_lock(&smmu->streams_mutex);
> > > > -       master = arm_smmu_find_master(smmu, sid);
> > > > -       if (!master) {
> > > > +       event->master = arm_smmu_find_master(smmu, event->sid);
> > > > +       if (!event->master) {
> > > >                 ret = -EINVAL;
> > > > +               event->master_name = "(unassigned sid)";
> > > >                 goto out_unlock;
> > > >         }
> > >
> > > The PATCH-1 already did arm_smmu_find_master() to event->master in
> > > arm_smmu_get_evt_info()?
> > >
> > > Maybe we still need a wider mutex to lock arm_smmu_get_evt_info and
> > > arm_smmu_handle_evt.
> > >
> > 
> > Yea, we did, I'm wondering if we really need to read the master_name in
> > arm_smmu_get_evt_info ? I mean, we can find and populate the name here
> > itself under the safety of this mutex and entirely remove that lock from
> > arm_smmu_get_evt_info as we anyway will dump the event after this line.
> 
> We could. I guess the two patches organized in the slightly odd
> way that the arm_smmu_dump_event() gets moved around in the 2nd
> patch, so things look a bit redundant after all.
> 
> I think we could do two patches like:
> PATCH-1: Add struct arm_smmu_event and swap all FIELD_GETs with
>          the structure members.
> PATCH-2: Add arm_smmu_dump_event() and put in arm_smmu_handle_evt
>          directly.

Ahh, right! That makes more sense. I'll re-organize them like this.

> 
> The master and master_name are not that necessary to be in the
> arm_smmu_event. I would keep both of them as local variables in
> arm_smmu_handle_evt and pass master_name in to dump().

Hmm, right or maybe ONLY have the master_name in arm_smmu_event?

> 
> The dev_name() returns "const char *init_name", so it'd likely
> be safe to put the arm_smmu_dump_event(&event, master_name) call
> outside the mutex.
> 
> > I'm not too sure if we should hold this lock for the entire duration of
> > get_evt_info and handle_evt ?
> 
> It should be fine for being a mutex. Yet, shrinking its scope is
> always optimal.

Ack.

> 
> > Also, shall we rename it to `arm_smmu_read_evt_info` ?
> 
> I'd probably use arm_smmu_event_get_from_raw()? Trying to high-
> light struct arm_smmu_event v.s. u64 evt[EVTQ_ENT_DWORDS]. Yet,
> no strong feeling about that.
> 

Ack. How about `read_arm_smmu_event` :) 
Unless, we wanna follow the arm_smmu_<func> convention?

> Thanks
> Nicolin

Thanks!
Praan
