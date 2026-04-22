Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865F12E06E6
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860628; cv=none; b=mZrfxlS9dg0UX5xvoTP7sPShqlizfgilDi8yCqf7vm7jSAA0SVdsvmx1cqXTVJ2TmDKcvSbfJdm9TJeIvMAciQV5ya2gYk73yHYHE7/VvTKq3dn70Go06KJrFT6lOPDbeONlWyBfNRplKDTCEgRod6HDinV7nyiiJINzEWqHmfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860628; c=relaxed/simple;
	bh=pVJ6cANGcN25YtqSeKdTVIeklNNy+hpCbQ3KF8k6W4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6DvgrWCp+Q56C8vf2i/eizHH8tuOecjMN4bhhiDeAc+bD+oqEiHAdhJD8JJf6sLuIpPy9qsYp3Br9/u00T6mcdQBpv7e5so6Pgxlm/0gYV3WbCZFFAX8v9KtZucWM+i6jpvgsdeIE9szGWpmHP0rMlNTrNEGBbm9dEdlzba26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MJxA2pfo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJxA2pfo"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b46da8c48eso383825ad.1
        for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 05:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776860626; x=1777465426; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+QmP/Ol+JVAPgZ+wXRpBdCSp0qwEOMd8twdiX8iudJk=;
        b=MJxA2pfoALUIphknZaCx3KIogG2bGMr9Rb4l8EpQeMskvmDXBh3O4wDU0C5DUXDi0q
         RgHDgod/Vy2FwdIwKQyjtFK2AuVa9blkCgkBt/x94OVGoQD+hF4xhtYUOvqkikdapVoR
         WeRmLiC43LO4lT+EZyi0iw5nqpMmEAvYjzRdL/ayrnC+wbayv/AQzHw5ZWbam7uITbB1
         7ta0MLJvWocqzfWmkHtZfjak8XbnA1Z65bHWmZAK39N9l67AgarjJ5kUjxjfwfd6dT25
         80pkFiHMz6Zpf5K/mcjlqXaTP1XYg54YwmPbWlM385fMW4kyCuXd8KvLtJvZIHwbilHr
         5tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776860626; x=1777465426;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+QmP/Ol+JVAPgZ+wXRpBdCSp0qwEOMd8twdiX8iudJk=;
        b=KDPxDMwc5qlKRf/Fhnmd8crmHyq322ODbU9/9iT/fQuI0qBDhX+bJ5npyXw6p82IzF
         3AdWeOBRWIo8d7nES2cviNNaTwlna12HVyzhvcvlUyVIWJ67IsHQrSZ6g8LT8GW5vu8b
         ohCkiitCxpd011vE2DID3jlkh1pOZqCrCjhj3KGiHrZG081aB1n+MY3+PkPuKMnQ7nQi
         F6N9ewGhkrAMLyf/il6zCfdU4zC0SNavyV0V6i6K7RBkGKIUEEid01/lSBuADG1gcuBN
         wC2APGCa5FHStL2iCO8ILtBjQD0jO6s6p87+G+Gxa5Yv8Ti/+c9T8+eLuEQkOfdr8KvP
         KD5w==
X-Gm-Message-State: AOJu0YxFWwHyTW7ofnk5+tm1n/lr9yW7M0TqJwx95D8BXyM6luvZZtUA
	wdmafGoEq/1wb2a/jNXBG83xxx0bI41PQxcdnaMZJfK+OctLnah9+Dgqc3tQ27lklw==
X-Gm-Gg: AeBDieshTkkNRz9+sz0GPOYI4HnKuq3QP3Apwhedrag12InhY+5E0Dgd4+i6OyTRwar
	pUxfRwJIAd0RtfWluWiaPT5J/5DdIA7oIJv59II0vFkSxUYjcVz/uQm3iyDbG44cgNeEk7/K8QJ
	bUy2POuihYjFH+Bw6AwBXZrZWv39b3jsnIaVbAXCczN6RwjetQQ2T1celIjT/jbmL+kaH2DqSDy
	3EGHT7LOpAolSbzeaQZjOjRwe7w/E+/aKb7Q7wvhv5c3nhug70w7dkk60tknam3aFpOgwKu1017
	QvWXi3qxhgUQvGDZIbTpxeV2j6C1Wi8TQ/VBzDw4qTUHUvqDCQYzpaGWl673OG/WKVUsTn6RSQG
	szOc/lWxcCX7LbO+Ul896+9cXGRjDOsk8YDqQSQng+r+1umo6Ymo1ZzGqv2fNoE8Ae6XY3y9so8
	Z6b/Rmc/Y/k3HM06P/g9qDeKPQkgwk6UzXgPF2dPNqAxZWDWMroqcPFwqJeJiVjHPESFnAoX8eL
	9Lr+xk=
X-Received: by 2002:a17:903:4b4c:b0:2a7:4151:2c74 with SMTP id d9443c01a7336-2b6030443acmr12794275ad.16.1776860625870;
        Wed, 22 Apr 2026 05:23:45 -0700 (PDT)
Received: from google.com (174.188.87.34.bc.googleusercontent.com. [34.87.188.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981992sm20526951b3a.7.2026.04.22.05.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:23:45 -0700 (PDT)
Date: Wed, 22 Apr 2026 12:23:39 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>
Subject: Re: [PATCH v6 07/10] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <aei9yzeTt8zvTHGp@google.com>
References: <20260414194702.1229094-1-praan@google.com>
 <20260414194702.1229094-8-praan@google.com>
 <CAE2F3rA-M2czg8uz5+Gjrwk6LPvXUb2EJEFwy_QnSm1ZaDiprg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rA-M2czg8uz5+Gjrwk6LPvXUb2EJEFwy_QnSm1ZaDiprg@mail.gmail.com>

On Tue, Apr 21, 2026 at 08:46:12AM -0700, Daniel Mentz wrote:
> On Tue, Apr 14, 2026 at 12:47 PM Pranjal Shrivastava <praan@google.com> wrote:
> > +       /* Clear the STOP FLAG to allow CMDQ Submissions */
> > +       llq.val = READ_ONCE(cmdq->q.llq.val);
> > +       while (1) {
> > +               u64 old_val;
> > +               struct arm_smmu_ll_queue head = llq;
> > +
> > +               if (!(head.prod & CMDQ_PROD_STOP_FLAG))
> > +                       break;
> > +
> > +               head.prod &= ~CMDQ_PROD_STOP_FLAG;
> > +               old_val = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
> > +               if (old_val == llq.val)
> > +                       break;
> > +               llq.val = old_val;
> > +       }
> 
> Can you use
> 
> atomic_andnot(CMDQ_PROD_STOP_FLAG, &cmdq->q.llq.atomic.prod);
> 
> here?

Ack, I'll use atomic_andnot_relaxed(); for resume.

Thanks,
Praan
