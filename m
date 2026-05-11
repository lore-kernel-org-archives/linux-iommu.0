Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EE23D667D
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518653; cv=none; b=IdN8Dp6ITtgWKoUdv0FR74k/1XiH9awGKztqD8jS4c+F3IfoVEqY3hps9kaB3K9B+MHjJ3rgC7nQbKhhBs9fkdPg1xQuP+Cd1jQGwmMswLPIZEXQD3vz5x1YeTvxnUss3jdFScs0JkE5XGeUCjeNM+jhPHTItTwpb/go0EfsG/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518653; c=relaxed/simple;
	bh=VnHiJfx142B58IpFylvev/lRuynYHUQkjQAHCeY8M3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCox1PtFgip25QSonKiRuKdNUkPfnQeUohMudzDox15HUvc1aXs0Ha0ULTmMQKChb6UHJqnu8btnbtfoJTZFU06nDe1LY6mYbIyQSSw0cv+N1AuKyMxqftS9b/Q2PtypNfkYbwoceSA5SgqWmaHyFJ6nj5iPEjt11F4ZIIiFBmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wVnyXZF5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVnyXZF5"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b46da8c48eso5965ad.1
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778518652; x=1779123452; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PpEgExornEUzjACbfp1Aw7jdjLQiS5zPgVdT6OuYaoA=;
        b=wVnyXZF5zvBhjZBefzHuWW02CEmg05IBWAyrjQuaST25DzbgIjiAi2I8APgPCUiMEa
         77VB/C2oFMsry2lwWom5fSrJ/88XbU+VJAvQhehHW6mOJCjm6EhdZW3pvo39u18NF3Rr
         nX84SMVDvod/IqiBe+rIf/haRJEXInB7KVvsyPsxJbfsvL3h6t5F5pdwui9qm7Zvbv33
         nZ4kue+MhIIpWjx/5I+d6iNQ4vUIpqW6DttLVoU1LK+REyfiu1pxNaxo80tCFXGrm/27
         LFfF4LDDbWN17nitnEwczk6/yBK4r/oBWXXozwq3l95mFr94AI7vpUBvXJlS5qxnRRbR
         5D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518652; x=1779123452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PpEgExornEUzjACbfp1Aw7jdjLQiS5zPgVdT6OuYaoA=;
        b=XXWSQfXq+ydo7NtLqsPVB6CPs3z1I+3zPadfyVeeSPn29tDmTtdn5WH7iIIkoGgYLb
         UkKBsOkU/C125oUO7Zu73uXNvGbZMILJQgwTEQfg3w9bTNjpJJsWQ3UYJxy8Jzkkr1A7
         P+xXmUc/psSU08RQ/cKR4P7ibydyVDKNBiaF2u93CKY8FwDQnwGI5W9/OdV3WAAtdh16
         P+6b9OfLi6+Zsg7Ue2FT2V0I1i771iyIMm0nrHRQWKe9KeHC6sOsaSjVHqzC2LcU5Pkw
         9JXo2VvsinqsIYMJR0gnGwtccjbz3ALpLl/oTxyRxKr+LZdLJxCCQkBoJ3/2cQBoh9Gt
         GYNQ==
X-Forwarded-Encrypted: i=1; AFNElJ9C/GCy7tjqphQviDNxLpVLchyOpq3vp6ozt9A+RLU72G8h7xSihG8p8kCgalgtFXJGx/5x5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfFCPGOeRCFAj7BKgu0i9M1mAKuw7TG+3vIPEWzDixlQW3arDX
	R6oKFBjXLCOQCsUNlYQESmLoHJzx/K61q3z3FG4xawJEsEc4WcpFLwzp3aF1Z7Ovki91Eqfco7P
	+6MRaBg==
X-Gm-Gg: Acq92OFfL7RQ8Cr48Nx3XdBDL6YhfXu4mNmpOro9515X9xTEZPkp/gzQAN/otfSE+9R
	S+yNLyfSiTx+JnBwF4C2xvaEhWWbl9e1g6rmRE8N1i0uOitLgr/DoWvZ8Oebg5xQs1dXE2vEqw6
	Iryp8ioAywVhdeG6GTDfOIjHoK/tFh8iJuItZYAPNBnKo0ScybuS+didpgvUKweihyYE2w9rL8k
	LRHgXCOhvSVb9TOW1W24dgy1YGAKp8MqGm0325R8eoli09myQMhAJxtyfmbpSs4v/LvUnoNQ8Gr
	DUV+FxwfFxp3lVzafJJKoSEq0KJ5q202phVQna/+8mFWzN/ViclGuu+tZKhwKv0EJhTcjsNQO4y
	zpOJnOxAeTAkdYkFgdwWLa7GbF6ikSgjbOWIwe2VZdnPFNpWDD97iDcYs4z0JyquQ76upkJ2h3P
	CCqy3hTNxALlF36nt/Mi6ONisSG/NFaOGAsMqCZhnq4vqlcnQ5k2TGMlCZ4DIUCm8Km9yn5RbYv
	jEcb04=
X-Received: by 2002:a17:903:3803:b0:2bc:ac76:c1ca with SMTP id d9443c01a7336-2bcfe66bfb3mr22375ad.2.1778518651266;
        Mon, 11 May 2026 09:57:31 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d4050dsm104246425ad.31.2026.05.11.09.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:57:30 -0700 (PDT)
Date: Mon, 11 May 2026 16:57:24 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <agIKdIQ2iurD_9J3@google.com>
References: <afpdm5lfIeWptxOh@google.com>
 <afpwCIjQXwfImPXm@google.com>
 <afsN9jrsfuigV+DM@ziepe.ca>
 <afu5Y55W5oj70b5v@google.com>
 <afu69hAtkRlI1GJd@google.com>
 <20260509171451.GG9285@ziepe.ca>
 <agHGaJfwPr7-F1z2@google.com>
 <20260511141607.GN9285@ziepe.ca>
 <agH-rkumGS1vX4dv@google.com>
 <CALzav=dVPBx-kVhZF2KbCkWCxoufr3eGU4Mtv10FFofW9jtsGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=dVPBx-kVhZF2KbCkWCxoufr3eGU4Mtv10FFofW9jtsGg@mail.gmail.com>

On Mon, May 11, 2026 at 09:30:49AM -0700, David Matlack wrote:
> On Mon, May 11, 2026 at 9:07 AM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Mon, May 11, 2026 at 11:16:07AM -0300, Jason Gunthorpe wrote:
> > > On Mon, May 11, 2026 at 12:07:04PM +0000, Pranjal Shrivastava wrote:
> > > >
> > > > > Thus the quirk should cover the VFs too and also disable ATS there.
> > > >
> > > > I observe the quirk does apply VFs but after the VF's iommu attach
> > > > because of how the pci_iov_add_virtfn() is written:
> > >
> > > Ah, that seems to be the issue then :\
> >
> > Yea :/ we need something to ensure that quirk orders don't impact sanity
> 
> I haven't read through this whole thread, but I think this patch is
> related to the issue you are discussing:
> 
>   https://lore.kernel.org/linux-pci/20260403222750.1215002-1-dmatlack@google.com/

Yup, This should be the proper fix to the quirk issue. It moves the ats
quirk from final -> header and makes ats_init quirk-aware. I'll test out
this patch. Thanks for sharing it!

That said, I think even if we solve the quirk timing, pci_enable_ats() &
pci_prepare_ats can still fail for runtime reasons & the arm-smmu-v3
driver should check their return values for correctly tracking ATS state

Thanks,
Praan
