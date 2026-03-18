Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1872D2264AB
	for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859926; cv=none; b=JL8t8uuy/FistNRXVHaCMcx6u+fbjRL0g29VF4h/bbJUASG0TLrRaVTHwLFtX470twZ5Zhmefh4L9+qXRKecQg36WjoIqxxHdqOyopq2C1LbRIMZ5zNijYrGxuIdqkao7l7E2rGBP2JQdjE/ykXPLn/sZFtZN74zkoTI3eYNy94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859926; c=relaxed/simple;
	bh=+PoZebPl9eGyY2P4Hx8BwJJ0lFxSGwfNTcpB1F9sp9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLSTOD1yxcw9nVpgHmMXYDdvDOyDRiXN8dEopjGpRgXvw+r5mW0GjTfx4rC/KnXGgn6eiNB8sSoBVKarRO+OAByWqfma96pVhAhSTKz2y+PTK2CyhYU6Of9hkwGFgaFwRU+n38lk9qt3p1CtPdXzFykEAd4tg1vqtQoWIMSbsHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kulRyyp/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kulRyyp/"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aeab6ff148so12055ad.1
        for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 11:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773859924; x=1774464724; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rAVPuf1WmWbM7fHe7kDi/38r85UrwFo+QUAvxHpFr94=;
        b=kulRyyp/5a86z2AbUTkwLt0iGwhTrXDSDMNOK/abYdbrqFcGkIjbBshB4NhBaC0YzF
         LFuDOrc/a2ofArdOZrZ2ubmHDbQj23cJHZLJBRX8B9aqc7XDGV8mis0p1InTXXyNpzKg
         OKVkjXCIuLDrRR0/tDJ1gAWvBMMyCrwq76aW4cQ4HlwDmAlje5FZ1/wwHj+n38FdhJ0b
         gmZO3JoF/sS4GOZyuBWJ8zHGdz32CzVzKvMsfq5/ESYT9wLSK0woes8oGEv7WC8MLo7B
         n4nI/cPL2BUQyL9xrCUAglwFUUw5BDK5rHVvUfa75Ape2Oi7HbnhMcZ32sFC+zCdrDkw
         wbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773859924; x=1774464724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAVPuf1WmWbM7fHe7kDi/38r85UrwFo+QUAvxHpFr94=;
        b=lRVihkQG4jpnmzk7S8iK92lZ1+GLFB4c58rRyLv9vTf7mrutyJOYmoo4ShdEiH/tU5
         GFObUqoRkP6WyX5knw2u9jE6qO/EEVqeu7j1ISI0sqs2uQGrX01OS9DOD9bvl9De866v
         f4piePly8XRLpd/+VKY2vhZZH5CHlopiuY4BMAWy0VAfySesZI3AxcMi1TewPb5VRk21
         NGidg10lL9kxW7N5liYDzhqZwN/kGYLroCNgei9SiJcIWsQjbXiHw41cI9LSPfZeWM6c
         aTuIMRiClIaseAJ+IkU3WXyAwW7HSscGQU2G9qN5Id08yzridUZKda8vFwdd+fp52ym6
         yy1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDIWW8fM2aX9O9f+k0/GgdXag1Coxp38B8otcd58HYmQrezbMRchEZGfpkS7IxYf1eH++mNA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxqo80WDITm7vS+oT+BZu7qqN/i60Uoa562+hrlaS4Phd9d09lc
	m6m8QJLL1ZO/vIg+X8LjkfPTEvknhZD56vMOmL9UX7MkmN8ERrfRoIg01JbMmCJseg==
X-Gm-Gg: ATEYQzxbq5JOoxX0TPsoJDOGySgUS0wmtIc84mpSr6l6AsXmCIbiWJg4bBLaDY5CZWl
	e0qm6yHLI8PVttza1ypxMIFoXZBh3TBPHjccL1uD+YAriKJIp9tMfYO4SHXu9vL6heNB052as6n
	m6HjqVv/xvMWw12TdH53iCTEOl1teaQIkK0HXcG8Xz+kb3R+UBA54Q2iREzzzK5upCIwYAkwxER
	Kapdt39ws3VvsB06MxUt1+0mfNmMYmoc4FNcLaCKw+EQ7Qg2CAOoI1i0NOpyNxhqoFGdVbtownN
	VFKpYjOeecAJN/DhMO1rgt8tQKUlTynH6oTHnyqFr5CzAdS9KJdYtLAzU9uL9h+KASIfOSdLeqg
	bDdMbcBkMyR+McDYenjOzzR93CD0cZqqu8exZvgCOdQl6mPijE9N80Le1o2GpVsMPGevfWVmEQj
	z5HcsyWkfclOB/umHT04qjswS7ovGNFYNEzbx2hqWLvALqB6u6o88Vxk7n2w==
X-Received: by 2002:a17:902:fb10:b0:2ae:575b:2345 with SMTP id d9443c01a7336-2b077f15bd2mr285995ad.9.1773859923960;
        Wed, 18 Mar 2026 11:52:03 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bbabc03ecsm1760144a91.2.2026.03.18.11.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 11:52:03 -0700 (PDT)
Date: Wed, 18 Mar 2026 18:51:54 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 02/14] iommu: Implement IOMMU core liveupdate skeleton
Message-ID: <abr0SoSoy1tSQqcR@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-3-skhawaja@google.com>
 <abNH7LAj9thuGOoG@google.com>
 <abROLLfSUK8pXM5J@google.com>
 <abm09vCaAMtiQPVs@google.com>
 <abm1esL1dzN7NTC7@google.com>
 <abm4ShqPTxIujDlt@google.com>
 <20260317210209.GC2582517.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317210209.GC2582517.vipinsh@google.com>

On Tue, Mar 17, 2026 at 02:03:16PM -0700, Vipin Sharma wrote:
> On Tue, Mar 17, 2026 at 08:23:38PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Mar 17, 2026 at 08:13:47PM +0000, Samiullah Khawaja wrote:
> > > On Tue, Mar 17, 2026 at 08:09:26PM +0000, Pranjal Shrivastava wrote:
> > > > On Fri, Mar 13, 2026 at 06:42:05PM +0000, Samiullah Khawaja wrote:
> > > > > On Thu, Mar 12, 2026 at 11:10:36PM +0000, Pranjal Shrivastava wrote:
> > > > > > On Tue, Feb 03, 2026 at 10:09:36PM +0000, Samiullah Khawaja wrote:
> > > > > > > +EXPORT_SYMBOL(iommu_get_preserved_data);
> > > > > > > +
> > > > 
> > > > Also, I don't see these helpers being used anywhere in this series yet?
> > > > Should we add them with the phase-2 series? When we actually "Restore"
> > > > the domain?
> > > 
> > > Phase 1 does restore the iommu and domains during boot. But the
> > > iommufd/hwpt state is not restored or re-associated with the restored
> > > domains.
> > > 
> > > These helpers are used to fetch the preserved state during boot.
> > > 
> > > Thanks,
> > > Sami
> > 
> > I see these are used in PATCH 8, should we introduce these helpers in
> > PATCH 8 where we actually use them? As we introduce iommu_restore_domain
> > in PATCH 8?
> > 
> > Thanks,
> > Praan
> > 
> 
> Please trim your responses.

Ack, sorry for missing that in this thread.

Thanks,
Praan
