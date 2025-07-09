Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7B02E8E01
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076323; cv=none; b=hadE1i/eYSBjlov38QkovKwTukOZ09x3x5S/zl0ro7bBGk5U3CYL22uv91+mrU0e/9/pwRveAkDQCt6fcGJkLMK2468RMY6sFDBxRvB+yhhvMFEdLkuBekQj186+izYvifJz5OnbpTtFHcvn+patXSh7gBSE5oErVeQAQl+FaBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076323; c=relaxed/simple;
	bh=neRG5nAF9GeJJNLGC2/+CQkRxoRqo3/yEX8tkqU+KMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijlVBJoBP+ZVbvrc+3sUMecZriUF4eN3w0ydzbH11U6drx3Yyd5ONfJ15916GFYuStt8ck99N8hVCT5IhvSwF+YKm6TnVTcYcpx56LhkuLHFsaikfRe4tOF4KTJoBEQ8r0Wc0AhJVgj3OPzu4jrOW7dEc1YHqTttqL/10Bktxm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zes7Bwm6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zes7Bwm6"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23dd9ae5aacso175705ad.1
        for <iommu@lists.linux.dev>; Wed, 09 Jul 2025 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752076321; x=1752681121; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MaN6y96fso9eH16uqaS+k/SvhhSMtB2yBaj4L57hCLo=;
        b=zes7Bwm65Cz2zWFAgp60LgES/BCzMQ59IIXTmKmb5+58rKICGTe2JkDqFzqR6K8ltN
         ih1M2MJ638dKUqI//LP9qhtR/E/pYc7Jg4Uys4DgSe1bhVA2pY/MIfkKRrzotX0xuTIh
         ZI62ok4Vv1iPZ7JE4c9/New/jSMDVxuZZYMSOKwOkhO3w1IiKCcAyhQHHb0I+j0CQAw9
         OCfxkzHQC3Ab6DmqQa4PgqDpH+U1ehkmCUQoOmToCTIueUrGw5K03byAApKUQgLY5HiJ
         d2qNpEW5yJ3G1eILRZZkx53ZssqWFL1ZjW/nk2KSIxL8/qn8PMmjQ2K2j3HwjwmDsJoX
         f50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752076321; x=1752681121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaN6y96fso9eH16uqaS+k/SvhhSMtB2yBaj4L57hCLo=;
        b=JzD04ZvsBJwNGQfKdRXesZifPPRCdOEiotg7anWgnPIMkZ20V9qd0Z4kqEgWiOk6Oi
         1nYfUo02PuQSn29dZ1J+6Jf9wCZT84LXh2jeIwkG1LKkvrRMFdLNviHoBV4YFKrSjnlc
         7iy4kskpBzx6hbhrZoNKEk82U/V6sBGwX5oU8Q2AzH5FAZudiERMU+D3tzZT1GOtE6QT
         ctzuF5UEZyKaE2NvG7ZGd51lpVkkORS0qdmavijfnlrUA2PvdSCQdkAu4Eq5RGpI2GXu
         12T0h8JbJo4IYFy3Ven2Sv15yx7C0VwEeiv3xF7Y/0R7uGt6qjQm+vCnt/jE/HoOQC4k
         TyDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXii4cF3KIuBQj9CguSYVxKdKY0kPFMsDWH94H0qqb72pFZSvBdNLMaNEkt1oBdW1zkPd/kEw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxc7AM2V8Zskt0Kv5ryn55LgXaBT7DSoqjQ+dW4agkNE6x0TGrg
	40IDoKpx2Hnr8MVUsDi/hx9kG1Jxt/YV1ov+TQcmLxRmXAvPWOmqGwQB7R/qnUdXgg==
X-Gm-Gg: ASbGncv3mCyOia34mTRjrRitVaguowsRpelOpR61rMHnwNtvdRb2B2cI/eSRHyjjo/V
	SV9QFtrgoQyEsoqbSRfq2Ik0AorNpwjn0WCAoPAUhPWZfWCwT8qztfq97NNuIfIHvDNVec+jLPI
	x3lJ8jkIeYslBza966bQdeXPiWl0XAlkk/S28WsNsS8w227QqDwZfpiimDclNN+/PM0aJzndeBS
	HK25xng8sNnUyPJTGzjlBqu+oisy8/GDAU3g57IRvmL09njs8Ar6EbC3wXUPREJ1Vz3lnOXDIor
	8tVltdiIIvmi/VNnsMf1mLluwbKA8YsX+1ZMwC992r5pW+GR8AehD0acf/5WfuEq18BZ+z7BXdG
	8YRiNdofgrVWw6qfsY60H
X-Google-Smtp-Source: AGHT+IHuzmNy+B/oCO/2QqQlep5MB1emRbkOhmYvWpGIYJ6wPtcVhd41J2cjEkccVc0pChtBnmioUg==
X-Received: by 2002:a17:902:f544:b0:231:f6bc:5c84 with SMTP id d9443c01a7336-23dda3a6a7dmr3334135ad.8.1752076316654;
        Wed, 09 Jul 2025 08:51:56 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a2638sm15075036b3a.137.2025.07.09.08.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:51:56 -0700 (PDT)
Date: Wed, 9 Jul 2025 15:51:50 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH v3 5/8] pm: runtime: Introduce
 pm_runtime_get_if_not_suspended()
Message-ID: <aG6QFk-2hG4DiOd5@google.com>
References: <20250616203149.2649118-1-praan@google.com>
 <20250616203149.2649118-6-praan@google.com>
 <aG2U51i3lY4R88ot@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG2U51i3lY4R88ot@Asurada-Nvidia>

On Tue, Jul 08, 2025 at 03:00:07PM -0700, Nicolin Chen wrote:
> On Mon, Jun 16, 2025 at 08:31:46PM +0000, Pranjal Shrivastava wrote:
> > +int pm_runtime_get_if_not_suspended(struct device *dev)
> > +{
> > +	unsigned long flags;
> > +	int retval;
> > +
> > +	spin_lock_irqsave(&dev->power.lock, flags);
> > +	if (dev->power.disable_depth > 0) {
> > +		retval = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	if (dev->power.runtime_status == RPM_SUSPENDED) {
> > +		retval = 0;
> > +		goto out;
> > +	}
> > +
> > +	/* Cancel the auto-suspend timer */
> > +	pm_runtime_cancel_pending(dev);
> > +	atomic_inc(&dev->power.usage_count);
> > +	__update_runtime_status(dev, RPM_ACTIVE);
> > +	retval = 1;
> [...]
> > +	spin_unlock_irqrestore(&dev->power.lock, flags);
> > +
> > +	return retval;
> > +out:
> > +	spin_unlock_irqrestore(&dev->power.lock, flags);
> > +	return retval;
> > +}
>  
> One pair is enough.

Ack. Will fix this.
