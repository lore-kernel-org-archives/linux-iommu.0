Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97B5BA27
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729491642; cv=none; b=rgwj3/e6Uz1I248rn8heNOCCTd0Sr4s7yQgbAuiBJ433mPTCrkYMnUWMUXA7Or+iP7WHqrIQws265Y3kaBp61LDTZMK8XTH3DpUpJ8pbbdIebcuvLBskpB8C4nY4yqVMuSkwFIkkHVIfeURVFu6+EPR5+9WfikPMnDantbb7Sjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729491642; c=relaxed/simple;
	bh=C2wynG36emr4wyswY30fDoyxtbIWbqil438/FrODOHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSgceosWn5ESVH30JeqHTco36ZRLomax2Jy8cjI7vjRoLu+DtOsiB2J4qIwfwQac3oNFWPqxahJcvhr275ju1PJNE3SH79YIhK69qmHpyX80clsIT7khGep5OjONXW0URPZWZd1GcCRr55oOg3x0XqsJfB3WJE55Jr0QPe7K5Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WGp3cyhy; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WGp3cyhy"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a3bd5a273bso707405ab.1
        for <iommu@lists.linux.dev>; Sun, 20 Oct 2024 23:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729491640; x=1730096440; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+e/cI/dha9wEs4OM85j7F/dVSuAuGnQcTsMMfnUiIVA=;
        b=WGp3cyhyN5DoTunJcqCaJaZ9BBaDfXvFM/e4SMs1azhVUHOXRIxbZPk3dGhVhGcH/V
         meQ2L3Vt/BlZuVfcK8M1syTJrix5uWVSAtg55r/koPeGnUYWgBwfc6AR1LxqnXJE1/Di
         0HIWmsVrVFeT5LCm9GaUNeWpsTrniiUUhXPU4OekAWJ/PD//IhtolXCE2Ca31ISlTgoE
         QUjTgPikCQp8v/5fRKpdtuqERDKjsDkhKeW+L7bI5UKtle5vFjfrzbhWPbseNyKN633K
         5UEhe7q/5n/p0A7ezPujiUn+lOZCH26+nlzsRCP6oN7PBHwN02AVO9kL9CHvi297RN7m
         0UHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729491640; x=1730096440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+e/cI/dha9wEs4OM85j7F/dVSuAuGnQcTsMMfnUiIVA=;
        b=Gy82uhaHQR6OUvI4WX0HCPo0ne6fFWwHlHiJxl1r28+RP6KJTyaMi8WIrgLbiAGs6x
         6TgJFGAxB+NDMeelCalWCD7yo+FQGHV9zx221NLekqHqL5f+N/YkJkSibLzR5DZ9MAsj
         BgM4/jP2RN4XaGsA5P0XxcbT9SEQIzhCOGH1mDrBT873R7nxu8/OVxn5t1AaA4XuJiha
         cbaxoQOBHhaS3NM5Vwz1fvVpGynhg4n7xT5QO0OOJXchbbQbuawKkPku4TsZLmKjnpph
         v93xa50JqjjBuk5SWylr8liQwsfr+mvZrw/1FQL2Ca/VXcEgmsi7r+IJGZfnK1XnHNMI
         lBMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqbsF0rIht3dc3wzLDufhbu1Lzvzj8nEM24XK5fwlqyfpXoF/7sA0Dsy92ActiwHsRlOIm5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwsIbgDWCjU8d865g1AjfO103FcGqaVdMkiNPh5qXfCvuLzovh9
	MEvQf239RtAeZKbLV53HVf/cDCjJQSaT9xskI7YB6U0HOL69i0gayR9QKDqiuw==
X-Google-Smtp-Source: AGHT+IGK5HAFhnayUPPAr5PcHvcTz7npKPuKoCbehnf5NRJ0sxlUWMbK+qDTqzRW6e6Jn9UfjPJ0XQ==
X-Received: by 2002:a05:6e02:148d:b0:3a0:b2da:8b27 with SMTP id e9e14a558f8ab-3a3f94c53fcmr8330995ab.12.1729491639667;
        Sun, 20 Oct 2024 23:20:39 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55d216d3asm3316127a91.0.2024.10.20.23.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 23:20:39 -0700 (PDT)
Date: Mon, 21 Oct 2024 06:20:28 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <ZxXyrMEb4_8NayUc@google.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-2-praan@google.com>
 <ZxMRvtullDF+gDe/@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxMRvtullDF+gDe/@Asurada-Nvidia>

On Fri, Oct 18, 2024 at 06:56:14PM -0700, Nicolin Chen wrote:
> On Fri, Oct 18, 2024 at 06:00:20PM +0000, Pranjal Shrivastava wrote:
> > Introduce `struct arm_smmu_event` to represent event records.
> > Parse out relevant fields from raw event records for ease and
> > use the new `struct arm_smmu_event` instead.
> > 
> > Signed-off-by: Daniel Mentz <danielmentz@google.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> With some nits:
> 
> > +static void arm_smmu_get_event_from_raw(struct arm_smmu_device *smmu,
> > +                                       struct arm_smmu_event *event)
> > +{
> > +       /* Pick out the good stuff */
> > +       event->id = FIELD_GET(EVTQ_0_ID, event->raw[0]);
> > +       event->sid = FIELD_GET(EVTQ_0_SID, event->raw[0]);
> > +       event->ssid_valid = event->raw[0] & EVTQ_0_SSV;
> > +       event->ssid = event->ssid_valid ? FIELD_GET(EVTQ_0_SSID, event->raw[0]) : IOMMU_NO_PASID;
> 
> 	event->ssid = event->ssid_valid ?
> 		      FIELD_GET(EVTQ_0_SSID, event->raw[0]) : IOMMU_NO_PASID;
> 
> Or maybe would better memset(0) the event, and then:
> 	if (event->ssid_valid)
> 		event->ssid = FIELD_GET(EVTQ_0_SSID, event->raw[0]);
> 

I like the former better but I think we should also memset(event, 0)

> >  static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
> 
> >         do {
> > -               while (!queue_remove_raw(q, evt)) {
> > -                       u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
> > +               while (!queue_remove_raw(q, evt.raw)) {
> > 
> > -                       ret = arm_smmu_handle_evt(smmu, evt);
> 
> Could drop that blank line in-between as well.
> 

Ack.

> > +                       arm_smmu_get_event_from_raw(smmu, &evt);
> > +                       ret = arm_smmu_handle_evt(&evt);
> >                         if (!ret || !__ratelimit(&rs))
> >                                 continue;
> > 
> > -                       dev_info(smmu->dev, "event 0x%02x received:\n", id);
> > -                       for (i = 0; i < ARRAY_SIZE(evt); ++i)
> > +                       dev_info(smmu->dev, "event 0x%02x received:\n", evt.id);
> > +                       for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> >                                 dev_info(smmu->dev, "\t0x%016llx\n",
> > -                                        (unsigned long long)evt[i]);
> > +                                       (unsigned long long)evt.raw[i]);
>                                           ^
> Could keep the previous indentation -----|
> 

Ack.

> Nicolin

Thanks!
Pranjal
