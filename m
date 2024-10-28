Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80FC1DDC11
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 14:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126817; cv=none; b=QxtxvUFipZ5xRm1EzsUnP5a+zpifQJv61/4dIsky4dH147wESrj39q13LBwiOjFoEh+tY0zM0XcbF28L+itKXcZtLUEJIMMEjHxV29HT/nbVaPtpTlDRwcejqESIfoQ/zf28ogn7XriIIPwME7ysxzd7xMgwxl7CS3NbGPXisqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126817; c=relaxed/simple;
	bh=6uT/SLQKpoiwc86vYS/8kLcD/tcGkRA0w/pJz2bdO5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUFcG9GZ25nDhhY6gBU7jccIl3xP/+HEXb5y8+aI3k1+a2zGwuSBgz3ARKtp+cdtTlPqDU04/fol05MTNdHHAbXz0VkYdsWiLxEXkZeH1pzFAl/J7iwEjScfQiP9lr2evkUnyjkV9WOe6Y6LFOT68I+viqHFgxkcVXwxY5S7Cu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jn42nYqZ; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jn42nYqZ"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a3bd5a273bso940135ab.1
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 07:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730126815; x=1730731615; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ecyjOldK8k/04gC4CR9l7GkkynqdWcYUKZOMSY4OObI=;
        b=Jn42nYqZXmQ+RY4b/SUsD2XymRsxrdzrhW6HXQNk3NGFQ+sM8okj8AGGyPKmQlYEYC
         y15BYXzk9BxPKSpWsi49zQhFYWKIo3JkkzpWGq5yd1OWEJ3gemcFt4oyQGFlPzCF2as+
         h/02UKUOy1WnvDW7tSKEP8OT8GnkjFeSpix5SAG9WUR4OAGB8GLG1HEq9XXyoMImwIn0
         41OB2ZdgQOzD5d+C+9XiCUwn8by7GVQop43xWtMbokETtDMIFx9MKi/Rc8aI/2aU5as0
         BSL5EHoE2fTfbpmjYCR7ECK5BDCDWwV2tSoeJAbwB11J0hNW/d6ZT2duSKp2IaI+NNow
         OD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730126815; x=1730731615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecyjOldK8k/04gC4CR9l7GkkynqdWcYUKZOMSY4OObI=;
        b=xRTBje+lJhk2I3SxO7v5Erh6FnZ+lnTOUMpZj72OOXF445CChx/PYUoiWNkwoHAm45
         85YoawFeKLX9WKBU/WC9Ly15EkdpcOFevk/O+miAVuA3Ls+0JPMiOvWQv++6FWcO5uIi
         rJeYGYV7GfQiQv7F5vl2QRKua4dZ8LBUxdBfs7iNIi6z93aqcw3weuTdjI9ycEWxsm7Q
         IczSFXmNHN7DO8T/qDzQH6eeqIVWY0WKdrmx0/f7femBN6d+nWWcDNkpzfzk8brbxvnH
         2TgC/kB+8+Ud20DTcjokNxdTaWVN3O7rzorOYEQsQZ25ZTSXM0DJDi7cr1tHGLW3OQ3L
         bKpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwyoI4wpp4rmexR/zz3H2/ERwy7UyehLwLoR/vEZMxbDRHfFG9MMJaW46ljGwAyHoD6eu38A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrC05TBJ4J1iA8HzwhiP19WRA097NFKhArVg1zf4xtPtpZlBRi
	sRfKp8Yo7iwKqKvpBjiaH3l9wOYZNYQxbbA1ODrBaNhEBBMFMjkkZbWSUnPffg==
X-Google-Smtp-Source: AGHT+IHyVkaO8QpdE31cQ/1Cm0giBbv4aIdbrTocVPP9IeGPawLv+H/FBPwvS+yZ6jLRsW5L6WLqnw==
X-Received: by 2002:a05:6e02:1d89:b0:3a4:d2ba:2011 with SMTP id e9e14a558f8ab-3a4ed1e531bmr10754655ab.0.1730126814462;
        Mon, 28 Oct 2024 07:46:54 -0700 (PDT)
Received: from google.com (146.254.240.35.bc.googleusercontent.com. [35.240.254.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205793273csm5756295b3a.74.2024.10.28.07.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 07:46:53 -0700 (PDT)
Date: Mon, 28 Oct 2024 14:46:45 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <Zx-j1fEU5MV3UzwK@google.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-2-praan@google.com>
 <20241024131147.GG30704@willie-the-truck>
 <Zxp9kHerb-ln4ioO@google.com>
 <20241024170329.GC6956@nvidia.com>
 <ZxqFx2qFHlUmMtpA@google.com>
 <20241028122353.GN6956@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028122353.GN6956@nvidia.com>

On Mon, Oct 28, 2024 at 09:23:53AM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 24, 2024 at 05:37:11PM +0000, Pranjal Shrivastava wrote:
> > On Thu, Oct 24, 2024 at 02:03:29PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Oct 24, 2024 at 05:02:08PM +0000, Pranjal Shrivastava wrote:
> > > > 	/* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
> > > > 	bool                       stall;                /*    88     1 */
> > > > 	bool                       ssid_valid;           /*    89     1 */
> > > > 	bool                       privileged;           /*    90     1 */
> > > > 	bool                       instruction;          /*    91     1 */
> > > > 	bool                       s2;                   /*    92     1 */
> > > > 	bool                       read;                 /*    93     1 */
> > > > 	bool                       ttrnw;                /*    94     1 */
> > > > 	bool                       ttrnw_valid;          /*    95     1 */
> > > 
> > > Linus has had negative things to say about lists of bools in
> > > structs. Use a bitfield?
> > 
> > Hmm, I agree, each bool is a waste of 7-bits. I tried the following:
> > 
> > struct arm_smmu_event {
> > 	u8				id;
> > 	u8				class;
> > 	u16				stag;
> > 
> > 	/* Group the boolean values together */
> > 	unsigned int stall:1;
> > 	unsigned int ssid_valid:1;
> > 	unsigned int privileged:1;
> > 	unsigned int instruction:1;
> > 	unsigned int s2:1;
> > 	unsigned int read:1;
> > 	unsigned int ttrnw:1;
> > 	unsigned int ttrnw_valid:1;
> 
> You can make this a u8

Ack, I'll update this with the v5 of this series.

> 
> > struct arm_smmu_event {
> > 	u8				id;
> > 	u8				class;
> > 	u16				stag;
> > 	
> > 	/* Group the boolean values together */
> > 	union {
> > 		struct {
> > 			unsigned int stall:1;
> > 			unsigned int ssid_valid:1;
> > 			unsigned int privileged:1;
> > 			unsigned int instruction:1;
> > 			unsigned int s2:1;
> > 			unsigned int read:1;
> > 			unsigned int ttrnw:1;
> > 			unsigned int ttrnw_valid:1;
> > 		};
> > 		u8 flags;
> 
> I wouldn't do this..

Ack.

> 
> Jason

Thanks,
Praan
