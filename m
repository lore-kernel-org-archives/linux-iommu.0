Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F9826C3B0
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613285; cv=none; b=QrtTNhap/eKEFsW3fZl3Est11d0NXKRO0g6dkNrMvbQO1ChCPGhdHbmzYgTBXkj0N3Wx0Ql412qf9vjE6xw2+uJMUriOtJT5aiil5uKiNm9dL/JzmlNs2LkEwtgi/RsDdUVEGIwpRszqnlQBJHsEhxWreJwm7afRobjFDEZfeak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613285; c=relaxed/simple;
	bh=k4OjzOs5HqDQE54Gje/P6JJmRlyKFTnxD7UsdehRKro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEF/hbVKh9FZyOA7YgzQ2wSgxKu1Yjed/1mbvzS/244sLLoHTqmsDkGIRJg6pl7/UmUrxFpd+/ALxJ2orLrmzs+0KAvpD/YNOKdvZ4A9kNJiZ1lQk+8xMZSwXJFluhOpqlHdiCxZTWOGqZHcYFzixKzoe/7tp6/pRoRdMaesxAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=J5qurTXZ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="J5qurTXZ"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb5c9ba82bso365343485a.2
        for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 05:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774613283; x=1775218083; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rM4j1uhwzauDP62JWXVS9NAGhcH+EEH1SzSqmJ5ddK0=;
        b=J5qurTXZI8DJhHJa01oGxxgO0oJGOV8wIuk8aGUUkYmhOMiZfIfw73zs/qpE57sWz3
         P0bIJYdtK3OjQcTHap1rVMb3jeTfgtNZYd/+tSTgx6QcfboIte2wcOIWI7hwlzjpRa5n
         we34UwSVbztDPm3yGuDbfYbi9qmdWh8ysjMTVFe8J+LezmLIIc1NRxSrZmwNPBWK993p
         HS79OMuM2lRS9GK1MLU8fVOD9pg3VKfbilg/o5mXo1RjddqQow2rPJA2ZknZ0QYRSWvl
         2lk/Hi6Ucxz4YroDi9NGVrHSlMqkjZx6hEFurWEle9uj/u2kao64pkmbpQV7n8B8Ez1K
         sDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774613283; x=1775218083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rM4j1uhwzauDP62JWXVS9NAGhcH+EEH1SzSqmJ5ddK0=;
        b=pQAcs9vNVZ1AyH8uqxrMav7g9Aig1YJxfGUjJLdm0c+ozVs3KMF7aT3R0tPE9PNIr6
         p117v+c0n4+TZdhH63rH74herLJGO+2iVXdFJaQLZj/2tRUR2I15UxhzBEwycae60z2X
         kvKPBZbM9R9Z/jGEg9xKvoero5YSBUtuW2SIn86iCts8Yn/Nrzm370/0jMxWsX+I93Vu
         nGKJtAp6zzZpCE0sG8bX9uBDMkGpY5jya2PSoli2rr8JLYUQdJQotRqtCOEFBQ/bWEdh
         6n/Zkn6Bdo5xcOFc+9Vw9/BZEEMVbcbT1SBbQTr0qXYBA2Vbde6UO5awnL7NfEinQTPU
         7gBw==
X-Gm-Message-State: AOJu0YxtaenJ1+dLLzhZQfHxvVTUvi9EEaBa2cTzGMx3uu8itU9fNpDE
	o7pbkhYq0zg1OLHVw5yUDSsJrfCmqkOHbIuy6cad9fxGuBa+XXEG3eBU83W/n5uIHSs=
X-Gm-Gg: ATEYQzyi4J6+ItvL6s2ZJGhzWHgCo1VEB+2vVnz2sdOBYMLPtCKaPADaMJaRF1dnWyA
	2BH3wH48YodMZ2N55iGgLtg+ZbYqE0Q6yj7ywDDDa6xhgWCVRf0y/4OeLO2DKOngoCCQgBJtXoZ
	KD+dxenjYgB7NNVepGXrqM+y6hs/a7eadmfENlOMYhTZLN5lP7Xdt6ixOqFTjwKGEsf4GQyT4n8
	AwbkxQVdyncBduZzbHXlOuxh4J5HAYe3YvC9LHx3xa8uBeRMz68UEewjxUrV/xxYpV+AMLO1U3D
	BgcOS9xd1TnWdjURoh+m1ozEliWPv5q6Gbfu0Wqr40xrpX2lRDMAXEG2RZgMjkCG9ZbRqE6nS07
	wkNN81L2uZ69pmBFErAYHVI60nnSanwVY0nMqzeVmvKVd3vDoIHS0sWHOfNpgAh4oA7HKV84i5a
	4KldL2VvweJa8gljymOrbVMr6KBidO8PR5o4CC1+duRsFGMGDoztYpIujWgoC+PPV8f6m4JA==
X-Received: by 2002:a05:620a:2911:b0:8cf:d953:b501 with SMTP id af79cd13be357-8d01c5bcb6cmr248302485a.7.1774613282782;
        Fri, 27 Mar 2026 05:08:02 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e4ce917sm625565985a.31.2026.03.27.05.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 05:08:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w65yq-00000001Cbg-27vQ;
	Fri, 27 Mar 2026 09:08:00 -0300
Date: Fri, 27 Mar 2026 09:08:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Ankit Soni <Ankit.Soni@amd.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	syzbot+453eb7add07c3767adab@syzkaller.appspotmail.com
Subject: Re: [PATCH] iommufd/selftest: Add missing driver_ops for AMDV1 mock
 domain
Message-ID: <20260327120800.GA246076@ziepe.ca>
References: <20260325094615.2420522-1-praan@google.com>
 <20260326121325.GI8437@ziepe.ca>
 <acUlyRx-wdw5Av_w@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acUlyRx-wdw5Av_w@google.com>

On Thu, Mar 26, 2026 at 12:25:45PM +0000, Pranjal Shrivastava wrote:
> On Thu, Mar 26, 2026 at 09:13:25AM -0300, Jason Gunthorpe wrote:
> > On Wed, Mar 25, 2026 at 09:46:15AM +0000, Pranjal Shrivastava wrote:
> > > syzbot found that allocating a mock domain with AMDV1 format could
> > > cause a WARN_ON because the selftest enabled DYNAMIC_TOP without
> > > providing the required driver_ops.
> > > 
> > > Initialize a spinlock (top_lock) and dummy callbacks in the mock
> > > driver to satisfy the generic PT requirements.
> > 
> > I'm inclined to delete the AMDv1 option entirely, I was thinking about
> > extending the sefltest to use it but I don't have time..
> > 
> 
> Ack. so should we entirely remove MOCK_IOMMUPT_AMDV1? as in from the
> uAPI header as well?

Yes

Jason
