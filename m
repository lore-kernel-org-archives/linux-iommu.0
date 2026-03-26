Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B133B8D40
	for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527958; cv=none; b=MpR7E4Axl+t8V6BcrM7X/YQwECeGdGKOpdQwN2yNIn2Xx5BypFTAKy+RQfGzvXpbGLsxfiiUx3mTFhNZtz9yefU38NgTyDLOgAvo6X5ZgIm2v+TL565dMwqvrvnyiSLoT1gj6AqP/kLETadYeyJ5L0QHKs8uRJl42faUwpO/ch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527958; c=relaxed/simple;
	bh=pczy2Exb9e5C2uVFExmwa+NTIo63602ON2TJcB4w6ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUnGTeqBGC7/+MfKeXACLZJBeolL+zSuPTTs6B72k/u6en3KCEBUQKtiJyRKyeJ56pbgFOQbEP2uZlCT2bjAbeTRLp9rjw//rpO1K/NuQILNYJl+HIUI6NepX1XK1iatTM9PDISR2afKWrT9hkVg7A0NOzcFRUd+KYZ70Jw+JGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AcTwLelC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AcTwLelC"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b0c12be0ecso62965ad.0
        for <iommu@lists.linux.dev>; Thu, 26 Mar 2026 05:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774527957; x=1775132757; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HDkr+R1frJvTnBvB6MpDrWNgQvdK2CQ9rt0ADgFaunE=;
        b=AcTwLelC3ww34q9HEr+ELFbmJb54Y0yu0nemczfVbYiNcIklJE9jMwcO4v3lnHHSDq
         AZGrCvQ+VAqaCoATxjo62iGWF37Cg9Nm+k+1AXhJ022nB4ngaSS9ZB2Rpyfmpo2mgSJL
         vPwSNmBpedvdzNYTXROfd1cs1hEzKgXQzIl2rrjA9AVub5RiASqKiqtSZqJIjiPgbFRl
         ndhPms2VAMkBeM/DoH0VLU68ZGpl9vTeSxEZdIjF+El5IXM7MOHdD2ghmjSXNaErsKrE
         P7iGAFv8nutSFDEADGhvkVxkIioWROTBv4FyvetjAwJENaJms09HBMaEiaNvRxDPTVt1
         Jszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774527957; x=1775132757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDkr+R1frJvTnBvB6MpDrWNgQvdK2CQ9rt0ADgFaunE=;
        b=iI/RZWfRdXNFE1EkjgyAOf8EGIX5EWRbcJ5BMOYFLWJcn8zv0Maop7udcSilj1/C7R
         XkCEy9k07vezk0hN30kuWoc8fH8VXgUCffuTzNM7XZ1wCeRwU2vIbmg1RiWAQF0Z0rZ1
         McKk4/ZKpEIb4FVDmsF4sFE+VQRK9sVsto2YGqiOrNeVZk4OcYrLZ9BlqIU3ZfIaMrg5
         kAItQvS6TuejXEcoE5Z8z18RiSUmEzf84/1hfBSvr2yX6Tud3gB3+dT3GdT67cKkVPNA
         BsHhkB2mycLiTJkeOu6xjcOqtg6jZ/NrWIMq0C88M/xKSlBnwJZmlslHHkcsV885N8qr
         Y0uw==
X-Gm-Message-State: AOJu0Yyytmsr5M0VJLnEOpdY6CG41Hm1qLif6RNz296XRFyee9dvAnJ/
	iCd7HYI2JBJAiZx9mOTHy9OY8NjGu8n4VeoLvut1XbFHkcab5GNplcLATebAhXSJAQ==
X-Gm-Gg: ATEYQzyG5VRySUYk6tnk8euPQiRhggMMjN7Td7WbCDEfp15tZjWgRIxg/jwv9470qLQ
	MYYE2ucdyqqzcn4sw/ZvcVsMTUtjYK2yWBLl1pb/TUj5bpa6vwsvoaXZZtxmPUoeLKqtq+mfiZt
	2Mseb4JXJjWg3J4dI8FZo2vC80WyrTh54KNM7fdrnwuh9EWtHVatdoUSCqSmIelqE75BwsZxwvV
	iBw2ub4MjBvCQnQ4Ks9qspmwNbkfkq639HCofBpVPDBOa+gV7N0+Rxy2o9JaNU36AaL42j/kqoy
	q/iYVFBk1eJuTy22kQjoY405ZuC4198NO//HDYQxOSsmLsj0M78Yjj7EQE9bM8WFl76CdcKbiI6
	8ftgwxSKkr45qZpKlx1N7/TrD8ZrF1buxwabDS3KI0u3C17k5xW1qQf4XG7UxdalGncrj0gJ8Tn
	9qnRdQekFTBpLooxuJJoYTV8c/W2pcJ7Sc0Soj3WiKvf/8xsNk3YmeUdByOg==
X-Received: by 2002:a17:902:f542:b0:2a7:6c4e:5914 with SMTP id d9443c01a7336-2b0bf526053mr1001195ad.6.1774527956185;
        Thu, 26 Mar 2026 05:25:56 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22d09573sm1622623a91.16.2026.03.26.05.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 05:25:55 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:25:45 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Ankit Soni <Ankit.Soni@amd.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	syzbot+453eb7add07c3767adab@syzkaller.appspotmail.com
Subject: Re: [PATCH] iommufd/selftest: Add missing driver_ops for AMDV1 mock
 domain
Message-ID: <acUlyRx-wdw5Av_w@google.com>
References: <20260325094615.2420522-1-praan@google.com>
 <20260326121325.GI8437@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326121325.GI8437@ziepe.ca>

On Thu, Mar 26, 2026 at 09:13:25AM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 25, 2026 at 09:46:15AM +0000, Pranjal Shrivastava wrote:
> > syzbot found that allocating a mock domain with AMDV1 format could
> > cause a WARN_ON because the selftest enabled DYNAMIC_TOP without
> > providing the required driver_ops.
> > 
> > Initialize a spinlock (top_lock) and dummy callbacks in the mock
> > driver to satisfy the generic PT requirements.
> 
> I'm inclined to delete the AMDv1 option entirely, I was thinking about
> extending the sefltest to use it but I don't have time..
> 

Ack. so should we entirely remove MOCK_IOMMUPT_AMDV1? as in from the
uAPI header as well?

> Syzkaller is hitting this because it found it can use a parameter that
> the selftest never uses.
> 
> Jason

Thanks,
Praan
