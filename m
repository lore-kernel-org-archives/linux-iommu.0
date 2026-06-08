Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB423EAB8
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914438; cv=none; b=mekYeL2N+LP+N4DWpU7j8Eb738Jszl1uMTTcE22PUeIQbskCb0+pjhv1JHU85SNot2IAGwJZYc4fgtCHKMZOvNW+Enb/sfAhtwn6kx6DLHo8TVCO2bw8EtKWcP9Yo0x90mjpJk7yvxuQykx5DSPOCqC0KDBmLciaPJerTbzF0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914438; c=relaxed/simple;
	bh=vqGYOyZ/CKCoJXA5G4nX1aArmwlyTudasFqGj1P9K1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkUEEgEhgeA5MdeqY4a+jxxDolUDpmw+7hygrzvhewmtFThFHl3BQABdnbUDt4x1WkldQewDsg6UElRtUafdHd/BSAzDgEXGfrDZrCq8l4TwfnAOtHX8BpaBBvtgZWM+7LvaTcSqIHkbyjc8DO3TYyVfQZ841O/9GXQXjdYKb3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GjMyUA4A; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GjMyUA4A"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1380104f31eso23218c88.0
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 03:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780914436; x=1781519236; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b4M7oLkbEYpMFnDXvWy4q+ZCA9NW6fdqs7xW4QLchcE=;
        b=GjMyUA4AoOd339KvYWSELXlXx60Sjfz5nyl+yuB/1aVyORqaNWK+clhz0tvRyXVrtp
         JGFbX4N7OD0qu+LIHaXxSKv9+JM4aBSPogTvDqhU2BrOEXmV+HdCt/Du5ZASRVuM/dwo
         WwY2MS44x2iJY9m1+4JIHRsLydOx19Qpx3dbCinsm2d8Ue4rcZj6hcq1qb4cKY3ucwp/
         OaluJyoI/TCLAv/dC1OBBWqF8O2rouiB8N02XyLMWAUH3l398CPW8q0myM5cWm5YXvj3
         bOoMsy1nVF68o32dGt3V6LLgZ9j8RaAcmv9g7fucTm1L2VCNLUUT4cyt7+rXdJPSvV3L
         WoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780914436; x=1781519236;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4M7oLkbEYpMFnDXvWy4q+ZCA9NW6fdqs7xW4QLchcE=;
        b=cDVzu3iCd1HnkidpbwhiRfdQGqCYgQGTLFfQ1j169FXvIy5ppbfnzwLnkVgsjkskP/
         PHrCMK6wlexWhmLs/KK6b2BWdLi7TJAgTqUD3MKAtkmm0/HBtQtYUq/sja7BBMnqJOEi
         /t7gyWQ4iBayp/9whnI2qTR6z62PS6I1Js3zktbdxrIkcyEKAm4pDCdACbeBRAlHr/AF
         ccfFAwds2lfzu5zGBsO2GBHIoIMymJWcJLYQmBIs5/yrsf4ok2dCAk9JtoQxee8oTMEO
         ch8b8bnOLtj4rFh4L161Gq/d+ul4KwChecHlqeEpYTTkpLapeFv40v2SVYBcJgXDeAZh
         ai3w==
X-Forwarded-Encrypted: i=1; AFNElJ+4aUkPFunRDu7wheSF0q7jgLu91b4u9JuHdvjhrjmFWwZrA9wAre9U5oIeA7SZra4i88jYcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoADz1qgs+bLbAvOw5ZPT9BCliD5ZLOsu+rggAdsqWdUq3Uzvc
	8ekIl+XfZ0fpYUXuqFiu7v83c3SCjLIAwxH53EV2r36c2PD1+gexvomK9QTr2iTijA==
X-Gm-Gg: Acq92OHkSbvNHDFk0M31z5ud90+kx3PL7Cg91w8LogrGKIX9X2g+cIMokA3ac9VdecH
	vZ86fruE5PO0osS81ZIKgqLqbnz9lqZNvr7OlFDNEKzl8yzzNLEcCiTe7DmyEoi1DHBBaaoPlFP
	21//Ffxhc/3L+PVwTskmVY5GulNXpruy+XvcxPfQn+LiTPHtHx4xhd/bdUjmAc9EZS5MTjhXXbG
	TJ805KheIHWdqCZLZ4AHWT0tpD3+ZV//ic80xx1fkt5APNDJTOhAHVza5eaPfptYtU6YB/czu2+
	HWpNlC4Um9DRzyXBAAAufG+lxpXrzn2nBdTKRG7zd6ZvWRF4SRkhxQ8jYRt32FCn5Da3WDu5xDc
	dZl2rvg1JTVwbhBah8cBJ/q6LXHDWT8YqPwTakQIjNbYGE9VdxQBbQe7QbZY4eL+PPbFDJDjyIZ
	EBmy1Kjr7qLtzHq48QMAbB42V3U2LdBzJBTwJeqchjl54VgAqkjOgfw2YFox9xQeA191ZB9Nw=
X-Received: by 2002:a05:7022:38f:b0:11a:2c18:9e70 with SMTP id a92af1059eb24-13807c516c0mr363192c88.11.1780914434891;
        Mon, 08 Jun 2026 03:27:14 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dba9d43sm15284369eec.10.2026.06.08.03.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:27:14 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:27:08 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 10/11] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
Message-ID: <aiaY_EmbRxDxSe8-@google.com>
References: <20260527221407.1756491-1-praan@google.com>
 <20260527221407.1756491-11-praan@google.com>
 <ahilX8Za1NRCH3ik@Asurada-Nvidia>
 <ahi3uY9YZZtR1Lq5@google.com>
 <CAE2F3rDeZe+w7-V6hyJtSOwCj619E5SNtjJjZ1-yu1sVdf=35A@mail.gmail.com>
 <aiEm0yuNtG3PGJ4D@google.com>
 <CAE2F3rDwx9qX3O0GQOJ-CQ1dqREKNp3vf_PkWWP+xmyEHRuOnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rDwx9qX3O0GQOJ-CQ1dqREKNp3vf_PkWWP+xmyEHRuOnQ@mail.gmail.com>

On Sun, Jun 07, 2026 at 01:17:39PM -0700, Daniel Mentz wrote:
> On Thu, Jun 4, 2026 at 12:18 AM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Wed, Jun 03, 2026 at 03:18:32PM -0700, Daniel Mentz wrote:
> > > On Thu, May 28, 2026 at 2:46 PM Pranjal Shrivastava <praan@google.com> wrote:
> > > >
> > > > On Thu, May 28, 2026 at 01:28:15PM -0700, Nicolin Chen wrote:
> > > > > On Wed, May 27, 2026 at 10:14:06PM +0000, Pranjal Shrivastava wrote:
> > > > > > TLB and CFG invalidations are
> > > > > > elided if the SMMU is suspended by observing the CMDQ_PROD_STOP_FLAG via
> > > > > > the arm_smmu_can_elide() helper.
> > > > >
[..]
> > > Hi Pranjal,
> > >
> > > Have you observed unmap storms in a real-world use case, or is this a
> > > preemptive optimization? I would not expect a high rate of map/unmap
> > > operations while the SMMU is suspended. If a client device calls
> > > iommu_map/iommu_unmap (directly or indirectly), it suggests the client
> > > device is RPM_ACTIVE, meaning the SMMU should be active as well.
> > >
> > > I am in favor of removing arm_smmu_can_elide().
> >
> > I saw some with DMA_FQ (fq_timer does batched async invalidations) but
> > the early ellision doesn't really help with perf which I agreed to in my
> > reply to Nicolin as well.
> >
> > The early checks were dropped in v8 (except for invs_array and for the
> > WARN_ON in inv_master).
> 
> Hi Pranjal,
> 
> Please correct me if I'm wrong, but in v8, I can see a call to
> arm_smmu_cmdq_can_elide() at the very beginning of
> arm_smmu_domain_inv_range(). Isn't this the path every iommu_unmap
> goes through?

That's correct. In v7 there were 4-5 callsites for these checks, most of
which were dropped. This one (for invs array) was retained in v8 based on
this discussion with Nicolin [1].

Thanks,
Praan

https://lore.kernel.org/all/ahjNYqe8hjPUQIQD@Asurada-Nvidia/
