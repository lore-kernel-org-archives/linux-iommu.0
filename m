Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4138B355F51
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773171249; cv=none; b=b2gjJKcuiWj9BbJK21GLtXbmwb+RTdTsZAj0OZaLbjG/71vjB9ezvRYYb+1cthBYkGRVjPggLER79qjXSkO9NFOQu0MYGS5rzHDbV3QFTcGTGXmCy56xvAb3CbNYQcudRuXk0dTsjKNzIY6JrCMER86dzm0vT4tqL46Kf2Cvu08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773171249; c=relaxed/simple;
	bh=L12BluinyjkXyqIU2kYvAjopMSiSYL6fkPARo8pB4dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnKsVJury4LDVoliyZkhRywNMB1szMsfkVbtx3++ern8pH3EIV1mJSAr95ghl+/7NpE6rFrzaLDiW2a3DEXFdoe3IwUz5UPvKWbHQuJnUkiQcVQYIuXOfCaD9ymtmwzuAQQ8vJ740rSMia9bGLGVYWiTOt+mA2SsG3KomsApi88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t7XGOyq6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7XGOyq6"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2aea4ebb048so2365ad.1
        for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 12:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773171247; x=1773776047; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXGSMdyPLPak8eP7BVwmVxBskx1z5iRhXJhm2M1XFP4=;
        b=t7XGOyq6VxuEWqNIkIuzd4o8c41UItJOCOaU/JUF69aGfqOtLp5iVJ5LVIbFB0t3RR
         DDCjJFFsN90F6qmyR/z6LwiIgqUpvkU+91XRMfvVXHiMwoaZDzF9q7haT1RWPfkflD7E
         9axDvXjlwLCu9gZI0g9xdjpFEhcyY5rF11yb6HNOiT2vfSIRua9V4B77hSJEsVX4R2JY
         4ZLuDee00NPYZJlurPE96Pn4SXdvrMobwQ7w4vv1TId2nZFOtchdIUf9/3QvHQwgNj4D
         VbX1RTH+5O49khuttNwyhEfHIdXH18YEcNNbmduRar+iLavwepkMObM6R8wyjiIqTzqQ
         GNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773171247; x=1773776047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uXGSMdyPLPak8eP7BVwmVxBskx1z5iRhXJhm2M1XFP4=;
        b=rpBJ0eIcY+Z8mkhveYoaertGcYeAO9aNAJCGDYuGGOODg4PVAcD0jG8axXvSp9LkKQ
         bPBa4cbMti/OVG6ly3zg+xtOZpGEIDebSRSUWPTKzCK9B5Y1Q0/R0p7K2hXMpJ/x35rS
         Vw0rC1sOpZmUq2o3jl7wZ1ZwzVOtFBEEm2M86CJzEHV3NiNvSa0spVUGBcQbuhMwlu52
         7f9/YxHtfB4cPz2jtkS99jpVg7U1xmmAddoeJfY1o4Jk2EKhYnFQOoCzfr5ZRHcW9auH
         JkGEm2pteD4UK2PTRoWIEP5dulp8uHNvoeX6eIgEXvDLO39u1xLg2vsm8FnqXIwFCUIK
         1C/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfncsXW8+4l/QlsMTv4qYQHWllJXAkAmTqHdSCf/JLx3Q+WyE4z6525rpFs9yGQNrvYPB9BA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxsUMguiQP8tuEsvXJlCvltJLL+Uugv6xroqqGa0jTQ0IK8aLI
	mN47jaxjvr6yYB8lzt42b1RDJVz+KTl9sl7CaTXBuux5Iv25QTvoIAhP/nNcG0kThg==
X-Gm-Gg: ATEYQzxVdoaNxEseqew2/MZCGr5uVx8f3LpgxDAqRuB4FT1/QYLPAhjyVu/xEh9SMwC
	PWynoOgYBwwwGoArUbyQnmmww0ueR1WKk0aBKoIT0mV5wbblzusJLwJdU7LYJmYkzPDhyrlnpcn
	k5Wr5OclGihG6em7tKazJ/kNv4ic7CGSbNRS00ildJYIaqHU14WuNZIPBUGpWn3stMKC8T75JEV
	NkfIGOYbtgXEaKRyMj5BhQfUMCFj0HlcNAziE3uBcjOT6NjcEN0t0H/mnFecm/QBpQOMJZblG84
	xyJTjSUzHjXD7bnmruXmAU8E0E0hGDEcU6cSDVZL5NgOBXmTy2EHTIsMWJhZgb7QeiFS7r//iqd
	vLzlA7D2EnJ35zbSsRuJYpSY/TcZR5DgOb/uZtfM2quqZ1uPb0J6tfBel34CFo5e/8l2pFs5L6+
	+ujsvTFaeMqQ95vtpOoINakhOi1Jks5WsWhqA9YraX8M8MClkIb8xkTYRDNw==
X-Received: by 2002:a17:902:f710:b0:2ae:4e8e:954e with SMTP id d9443c01a7336-2aeae7082d4mr4705ad.5.1773171247142;
        Tue, 10 Mar 2026 12:34:07 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae34d873sm382665ad.42.2026.03.10.12.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 12:34:06 -0700 (PDT)
Date: Tue, 10 Mar 2026 19:34:00 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>,
	will@kernel.org, joro@8bytes.org, bhelgaas@google.com,
	rafael@kernel.org, lenb@kernel.org, kees@kernel.org,
	baolu.lu@linux.intel.com, smostafa@google.com,
	Alexander.Grest@microsoft.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	vsethi@nvidia.com
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
Message-ID: <abByKCl4xZlgF74z@google.com>
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <a5ff7a43-ea52-462d-a316-d3a6c08410e0@arm.com>
 <aanwTQtMMplXY3du@Asurada-Nvidia>
 <20260305235252.GC1651202@nvidia.com>
 <03461707-783e-403a-86fa-ae7a5107fa30@arm.com>
 <20260306155646.GI1651202@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306155646.GI1651202@nvidia.com>

On Fri, Mar 06, 2026 at 11:56:46AM -0400, Jason Gunthorpe wrote:
> On Fri, Mar 06, 2026 at 03:24:20PM +0000, Robin Murphy wrote:
> > On 2026-03-05 11:52 pm, Jason Gunthorpe wrote:
> > > On Thu, Mar 05, 2026 at 01:06:21PM -0800, Nicolin Chen wrote:
> > > > That sounds like the IOPF implementation. Maybe inventing another
> > > > IOMMU_FAULT_ATC_TIMEOUT to reuse the existing infrastructure would
> > > > make things cleaner.
> > > 
> > > I think the routing is quite different, IOPF wants to route an event
> > > the domain creator, here you want to route an event to the IOMMU core
> > > then the PCIe RAS callbacks.
> > > 
> > > IDK if there is much to be reused there, especially since IOPF
> > > requires a memory allocation and ideally we should not be allocating
> > > memory to resolve this critical error condition.
> > 
> > Yeah, sorry, for a moment there I somehow forgot that we can expect to use
> > ATS without PRI, so indeed tying this to IOPF wouldn't be appropriate. And
> > given the general difficulty of trying to infer what went wrong and what to
> > do from the CMDQ contents alone, I do like your idea of trying to return a
> > new kind of sync failure back to arm_smmu_atc_inv_{master,domain}() so that
> > we can take any defensive action from there, with all the information to
> > hand. We'd just have to ensure that if a large set of ATCI commands needs to
> > span multiple batches, every batch must contain its own sync (since if some
> > other batch of unrelated commands could get interleaved in the middle and
> > issue a sync that then fails due to someone else's ATC timeout, everything's
> > likely to get confused and go wrong).
> 
> Yeah, that all makes sense to me.
> 
> The batching issue is scary, we definately can't allow an ATC
> invalidation to be pushed without a SYNC that localizes any failure to
> this specific thread, or we can't properly disambiguate the failures
> anymore.
> 
> My feeling is when the sync "fails", it can bubble up the error and we
> can get back to the invalidation list processor which can then see it
> failed to process an ATC batch and take an appropriate action.
> 

+1 just saw this thread (replied something similar)

> > The fiddly thing then is that we might also have to be prepared to "handle"
> > CMD_SYNC timeout by manually checking for GERRORs, in case the whole
> > invalidation is in the context of an dma_unmap within some other device's
> > IRQ handler, which happens to be on the same CPU where the GERROR IRQ is now
> > pending, but can't be taken until we can complete the inv and return out of
> > the current IRQ :/
> 
> IIRC didn't the PM patches propose to add this anyhow?

If this is regarding the runtime pm patches, I've tried to address the
Gerror issue (pointed out by you in v4) in the v5 [1]

Thanks,
Praan

[1] https://lore.kernel.org/all/20260126151157.3418145-9-praan@google.com/
