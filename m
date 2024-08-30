Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12744428
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724976421; cv=none; b=H/zxULZmNxOHhtmlp4ZWRlMDOT564nanOjcC6nAg9OlxhIRD4yAt+esAggPKzDFFir0uzXZ2FLhjIz9k54bsbckMsGuIMlVFaPQSHX2fAhEEO8OawzkTOop7TfZrZX1QaoW7uCSqHGd7CNp30jA/suUpPIDccl+uGnt/PfuE9Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724976421; c=relaxed/simple;
	bh=ekWTG7/d1P4AW4E1uazak78B4RD7Q/Tj6QvztD36+Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbhGcp29LfoqdIkVUIAo+zBY6qQS+EoEUs10STcta68MRIp4EXtXJPBaD0yVXKYoMTW3Xs+BydvqkBK47M0yhRnEfoTE1X0UIOKbO/+638cKsdcPVafP/X/2pYzm1NDZ41+b4ky07DBjsAKM5SiAwa0bTWKUPFdY4pWQNbxtqZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1AF1uFYX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1AF1uFYX"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20260346ca1so80925ad.0
        for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 17:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724976419; x=1725581219; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CH2Pi8SMqp3gS5wKObxmRzPk6xOgKWcjSeyPAWsi+OA=;
        b=1AF1uFYXaq46BvmDWx2dIxPemWRxBdYIBj8QAbBnAY/dz4cwZ9Ih8DppxXbUM82bx4
         mQMztjyY1j84hkz8S+FNG3wZaG+4C6VV5nfA5hiiYtSY4ToY72lK7QsSFVYdrCRkQ5R3
         XC9psibDqDZeOcqj0qPZkM8l6ix/4LGCTwMZup4rNq/pL9v+c1LqGjVDHqyvhoylMt4P
         20tgVYFapYh691zHqMucKopOX/cFZ8Um9eOGFc7d75ZfGUo6211aPIck8U5W3XN4s9B6
         wrbGmfLzh6/Yt44+9VAgiisurCjuEM04Z/wsE0XV4B4L3ITmpMly6HWRP3/YWf6kA9Mf
         M25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724976419; x=1725581219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CH2Pi8SMqp3gS5wKObxmRzPk6xOgKWcjSeyPAWsi+OA=;
        b=dJyl1rPet2ekWP5Kg0WDU0Qoer/4WZMCpVLUwthmSwzXr8xH3ZvnhWVj3QyfdH/9yx
         PPfEoDCSpnC7WpycK+ndykt9z+9JyQ7cJKO54qqoHFI1wNn8ORjXCdEdBkHSaT5JSevZ
         L6AGTtaFlq19sP3XFs3fiPLjJI0NC1crltKcW9BX9si/x71UrOrI4HTBLMS/jJxrGRHZ
         VpzMgZdOLLlFg/8R4UAYnmsBs0gWt3ot83e/ctNGWZW7SnN8cLr2GELgreu+QGYH5mW0
         F/BuEB2iWKtZfo6eEFGRD4QSb3iSOIPL1TrAiPVK9wHIoMwKCBxGuCZyn6sIhsJSV1Nw
         uyzA==
X-Forwarded-Encrypted: i=1; AJvYcCWUujnMfizh4LPeg2IPZZ7G3r6n9k6LPtMwEenchyfhGDj9qm4+Px1LfjdeoOfO6J1eW3jjog==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhrET8fDtMV0zgYDhOM5zT/KebEloHXAG70reR+ghRnY9VgENj
	YE+NIM86sJPL/bPSvABP8+k+B+vJ/p1ZKzuqVJkeCoixUR24vxk1EDp4PDLSQQ==
X-Google-Smtp-Source: AGHT+IFY7FQQ9earDMMg7EBxXQ7e4vy7cABrDtBLQXzzURKaV4VetyJpkCnOBf+Gy2GaQG/ifyjMCg==
X-Received: by 2002:a17:902:c949:b0:1fd:74a8:df75 with SMTP id d9443c01a7336-20523972218mr1318505ad.16.1724976418776;
        Thu, 29 Aug 2024 17:06:58 -0700 (PDT)
Received: from google.com (202.141.197.35.bc.googleusercontent.com. [35.197.141.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e575c4a0sm1666991b3a.201.2024.08.29.17.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 17:06:58 -0700 (PDT)
Date: Fri, 30 Aug 2024 00:06:51 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: Adopt arm_smmu_event in
 handlers
Message-ID: <ZtENG42cpYrvSugF@google.com>
References: <20240827193026.3993039-1-praan@google.com>
 <20240827193026.3993039-3-praan@google.com>
 <ZtAFAs86+iTmEHKo@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtAFAs86+iTmEHKo@Asurada-Nvidia>

On Wed, Aug 28, 2024 at 10:20:02PM -0700, Nicolin Chen wrote:
> Hi Pranjal,
> 
> On Tue, Aug 27, 2024 at 12:30:26PM -0700, Pranjal Shrivastava wrote:
> 
> >         /* Stage-2 is always pinned at the moment */
> > -       if (evt[1] & EVTQ_1_S2)
> > +       if (event->stage)
> >                 return -EFAULT;
> 
> Should it be named to "s2" v.s stage?

Sure, will rename it with the next version.

> 
> > -       mutex_lock(&smmu->streams_mutex);
> > -       master = arm_smmu_find_master(smmu, sid);
> > -       if (!master) {
> > -               ret = -EINVAL;
> > -               goto out_unlock;
> > -       }
> > +       if (!event->master)
> > +               return -EINVAL;
> > 
> > -       ret = iommu_report_device_fault(master->dev, &fault_evt);
> > -out_unlock:
> > -       mutex_unlock(&smmu->streams_mutex);
> > +       ret = iommu_report_device_fault(event->master->dev, &fault_evt);
> 
> The iommu_report_device_fault(master->dev) call lost its mutex
> lock. I wonder if it could be unsafe to continue with that dev
> pointer.

Ack, I agree, responded with [Patch 1/2] in detail.

In summary, we need to avoid the following situation:

1. The evtq_thread gets scheduled
2. arm_smmu_release_device removes the `master` & its streams
3. In the `handle_evt` we dereference `master` which has been `kfree`ed
   (also, we don't return -EINVAL in that case as we ideally should)

I'll add back the `arm_smmu_find_master` in the the `arm_smmu_handle_evt`
along with the locks. Nice catch! :)

> 
> Nicolin

Thanks,
Pranjal
