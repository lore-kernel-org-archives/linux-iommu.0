Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AD01CC884
	for <iommu@lists.linux.dev>; Tue,  1 Oct 2024 20:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727815987; cv=none; b=IgikfrlnYMK6L9fHI+xvCDlk27NP7A0cIAj/Gwdqqk9/WmVhhgig4aepsZv7vh3Qw40yljGFLm7mEDhl6MbfzPi/oNO+l/S2UQnt44+wcBZ/uPz/LtSiCx9ZtFzy39QqI0GOaCNpLeegUO+pRsQ5ibOq6ylxKTdIy4nCSa8iv10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727815987; c=relaxed/simple;
	bh=BTh6WoMPx5bVmJ6kSbQzXBMCaD37+iGzvFsvxy8v7mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RX5H+UdZ/vlDzAFOhhucAXbN5daXytGvEO6OmoNwbwPHOfttVz3EhzqkLJy8+hL99V3I6uY720U+otAgO4BAsk+zhW8YOigub26MOkwfPE17g2/7M2GhZhmz6x/bzQvP9u1tMSQ0CfFWNvkIPuOb1g8CJaoTPXUh9KjM8rhgM3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NBhmVmu8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NBhmVmu8"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b4a090f3eso16555ad.1
        for <iommu@lists.linux.dev>; Tue, 01 Oct 2024 13:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727815986; x=1728420786; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OBoqcdCMPQT5cy2nGAVWAbu89NM4fCY726aenHiDLnQ=;
        b=NBhmVmu84y48Q3KTGM2Y/7S1a8Wxk+p5oxyNk3hfubMaW7c8Y08LQiF/oBDcG+tbBj
         c3vMWU9dEgXQLZ37LQP7nIkqGK8PUHVwfcRqXj3CXuI/wHbvybsJStFOyi5/QQycd4mU
         Zx/pcEl8bOpaDEILy8+VtSvXkAc6cUGrEPI18Yk1gypUytKkvQQUeoRbo6mY12BQrbKW
         hj4QMUwZoBAWnvxppjLmiKvfyRkftCdaoKc6eWM9D9OA27dzmWPjspWlePP0GH5u24/R
         adOK5U099FtoLqCmmo2i0zitCKNTrqVAzwGQuabkZutyWt8+ctgPSjzxBb0hozmS2/0F
         cdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727815986; x=1728420786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBoqcdCMPQT5cy2nGAVWAbu89NM4fCY726aenHiDLnQ=;
        b=K2pKia75JFurScVtzZOxzANBZNKi+3g/qBchVSL2y3N0K/dwcCdJf0L972gIx7hP7I
         Fan03SGmDAzAuwl+l+tsDXPrvodSYMq/BlO5AKPx0zxS7w5vC9qjApXyx4YJV/Wk1SdS
         9CIlEHeXEhweyQii3wUZ+1bMPT55fo2EkwVxC7i6zf7BRuh+zJB1XBlIQvefCzNZzt/p
         3NyMCs6dz40kYflXUd3vDjcaRfI/Ohi6E7rEVuIeWCze2korY6KOcqcPLqaazUT2ohEV
         q9J0mf1nvxi0p6E1EZodewGBMGAtycj4LqeEpEt1Pnuu2e8JAxI3k2ekta0LIa3XSKCc
         fvzw==
X-Forwarded-Encrypted: i=1; AJvYcCWXr7CZMtqk0ptl8raxib0GNPHlEscLb2sJ3nkiyGMvpJm7t0P9H887iDoz1BP+RefoK2yglg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywi/78HzpsY7AJqXoMRe30vXhFvGzkeRzwVgnWxK7BdCa+wWEQV
	8dlGJw//2GebVHitw2ZPZyFp0dICNvW8pDXR0jp1uaPhdU89PhDJELjOK5wU9WP3D5ttbKo5sjm
	Cs4FC
X-Google-Smtp-Source: AGHT+IFQkAWz994+jqKGg56eC5BL586pB3xueMt10Dcf4lJy7x9j8dKzjnkZkNhD3sBRMIgtdddAdg==
X-Received: by 2002:a17:902:ecc5:b0:20b:51c2:d7ac with SMTP id d9443c01a7336-20bca35f040mr132745ad.7.1727815985181;
        Tue, 01 Oct 2024 13:53:05 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264bcca6sm8551133b3a.78.2024.10.01.13.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:53:04 -0700 (PDT)
Date: Tue, 1 Oct 2024 20:52:57 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <ZvxhKfUtXse9Nqxs@google.com>
References: <20240928005143.2378938-1-praan@google.com>
 <20240928005143.2378938-2-praan@google.com>
 <Zvr4vmU7u2BY3MLM@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvr4vmU7u2BY3MLM@Asurada-Nvidia>

On Mon, Sep 30, 2024 at 12:15:10PM -0700, Nicolin Chen wrote:
> On Sat, Sep 28, 2024 at 12:51:42AM +0000, Pranjal Shrivastava wrote:
> 
> > +static const char * const class_str[] = {
> > +       [0] = "CD fetch",
> > +       [1] = "Stage 1 translation table fetch",
> > +       [2] = "Input address caused fault ",
> > +       [3] = "Reserved",
> > +};
> 
> s/class_str/event_class_str
> 

Ack.

> > @@ -1756,6 +1784,66 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
> >         return rb_entry(node, struct arm_smmu_stream, node)->master;
> >  }
> > 
> > +static void arm_smmu_dump_raw_event(struct arm_smmu_device *smmu,
> > +                                   struct arm_smmu_event *event)
> > +{
> > +       int i;
> > +
> > +       dev_err(smmu->dev, "event 0x%02x received: master %s:\n",
> > +               event->id, event->master_name);
> > +
> > +       for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> > +               dev_err(smmu->dev, "\t0x%016llx\n",
> > +                        (unsigned long long)event->raw[i]);
> 
> Though I know that is what we have been doing in the driver, I
> wonder if we have to cast from u64 to ull?
> 

I think we can do that? Are we avoiding potential compiler troubles?

> > +static void arm_smmu_dump_event(struct arm_smmu_device *smmu,
> > +                               struct arm_smmu_event *event)
> > +{
> > +       char title[256] = {0};
> > +       char mastr[256] = {0};
> > +       char addrs[256] = {0};
> > +       char flags[256] = {0};
> > +       char other[256] = {0};
> > +
> > +       snprintf(title, 256, "Unexpected event received: %s\n", event_str[event->id]);
> > +       snprintf(mastr, 256, "\tmaster: %s sid: 0x%08x.0x%05x\n",
> > +                event->master_name, event->sid, event->ssid);
> > +
> > +       switch (event->id) {
> > +       case EVT_ID_TRANSLATION_FAULT:
> > +       case EVT_ID_ADDR_SIZE_FAULT:
> > +       case EVT_ID_ACCESS_FAULT:
> > +       case EVT_ID_PERMISSION_FAULT:
> > +               snprintf(addrs, 256, "\tiova = %#llx ipa = %#llx\n", event->iova, event->ipa);
> > +               snprintf(flags, 256, "\t%s%s%s%s%s%s\n",
> > +                               event->privileged ? "Priv |" : "Unpriv |",
> > +                               event->instruction ? " Inst |" : " Data |",
> > +                               event->read ? " Read |" : " Write |",
> 
> Indentations are not matched with the snprintf(mastr line:
> 		snprintf(flags, 256, "\t%s%s%s%s%s%s\n",
> 			 event->privileged ? "Priv |" : "Unpriv |",
> 			 ...
> 

Ack, will fix this in the next version..

> > +                               event->s2 ? "S2|" : "S1|", class_str[event->class],
> 
> The previous flags have spaces: " Inst |", " Read |". So, maybe:
> 			 " S2 |" and " S1 |" here?
> 

Ack. I'm guessing even in the worst case we'd get to 78 chars so adding
a space should be fine?

> > +                               ((event->id == EVT_ID_PERMISSION_FAULT) &&
> > +                                (event->class == EVTQ_1_CLASS_TT)) ?
> > +                                 (FIELD_GET(EVTQ_1_TT_READ, event->raw[1]) ?
> > +                                 "|TTD Read" : "|TTD Write") : "");
> 
> I'd try to avoid that nested ternary. Perhaps:
> 	char ttrnd[32] = {0};
> 	...
> 	case EVT_ID_PERMISSION_FAULT:
> 		if (event->class == EVTQ_1_CLASS_TT) {
> 			snprintf(ttrnd, 256, "%s",
> 				 FIELD_GET(EVTQ_1_TT_READ, event->raw[1]) ?
> 				 " | TTD Read" : " | TTD Write");
> 		}
> 		fallthrough;
> 	case EVT_ID_TRANSLATION_FAULT:
> 	case EVT_ID_ADDR_SIZE_FAULT:
> 	case EVT_ID_ACCESS_FAULT:
> 		snprintf(flags, 256, "\t%s%s%s%s%s%s\n",
> 			 event->privileged ? "Priv |" : "Unpriv |",
> 			 event->instruction ? " Inst |" : " Data |",
> 			 event->read ? " Read |" : " Write |",
> 			 event->s2 ? " S2 |" : " S1 |",
> 			 event_class_str[event->class], ttrnd);
> 

Hmm, I like that idea. I'll add something like this!

> > +               snprintf(other, 256, "\tSTAG = %#x Stall = %#x\n",
> > +                               event->stag, event->stall);
> > +               break;
> > +
> > +       case EVT_ID_STE_FETCH_FAULT:
> > +       case EVT_ID_CD_FETCH_FAULT:
> > +       case EVT_ID_VMS_FETCH_FAULT:
> > +               snprintf(addrs, 256, "\tFetch address: %#llx\n", event->ipa);
> > +               break;
> > +       }
> > +
> > +       dev_err(smmu->dev, "%s%s%s%s%s", title, mastr,
> > +               strlen(addrs) ? addrs : "",
> > +               strlen(flags) ? flags : "",
> > +               strlen(other) ? other : "");
> 
> It looks to me that you init-ed them well, so maybe strlen isn't
> necessary?
> 

True, missed that, will remove this.

> > +
> > +       arm_smmu_dump_raw_event(smmu, event);
> > +}
> 
> I assume these prints would look good, yet, would you please try
> triggering a FAULT to give us a showcase in the commit message?
> 

Sure, let me arrange for a sample FAULT log in the next version!

> > +static void arm_smmu_get_evt_info(struct arm_smmu_device *smmu, u64 *evt,
> > +                                 struct arm_smmu_event *event)
> > +{
> > +       mutex_lock(&smmu->streams_mutex);
> > +       event->master = arm_smmu_find_master(smmu, event->sid);
> > +       mutex_unlock(&smmu->streams_mutex);
> > +
> > +       if (event->master)
> > +               event->master_name = dev_name(event->master->dev);
> > +       else
> > +               event->master_name = "(unassigned sid)";
> 
> Likely safer for dev_name to be in the mutex too.
> 

Ack.

> Thanks
> Nicolin

Thanks,
Pranjal
