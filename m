Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB21741C75
	for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835332; cv=none; b=dG6uPZl2DxJQwFMYSB+CJSnqCxdEduySo5ZXwDbGbOrhoxQTjta78rWhRCe3ABauPgtrDTwJmfzkutH3rPKtWShQ/Mq6peZfAKwX6F6DxkEdttunzTYEXZnIPBEMd7uQ9duhJGA6TFYX2Y9NeV1GXuRIXFLwgGc461NcEr43blo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835332; c=relaxed/simple;
	bh=dGCo5O1zuXivuV35bP/mp9Fz8NV3YZDD4lKLvTu/AoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNnd9kwx43qlZjDDtPgroUC6fp+qllTKgDWU6a7ogzh4ueDtVVvk/h3vR2CZNnxWVJQxpEh34IQ7NsqUcVnp8eU7DYb5NpY4GOM78R7nKGH9QEDJz9RKD5wGxRPQOfe+ld0+iyWMoamjvFhHWfoFttMD1AMyiP9+NKfLb5xGtQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ou4u1Y/2; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ou4u1Y/2"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ddf26eba3cso651530a34.0
        for <iommu@lists.linux.dev>; Tue, 13 Feb 2024 06:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707835329; x=1708440129; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3VCFBkygL/6eJOKkXAgrZmI3b3/D/n5FCeZU3c3PKSI=;
        b=ou4u1Y/2vGdWvpObnGtCOPQ0Hq4FSzJH3jrbt9EE+ZttIvzbPzb6vAeFfPYPja8T4b
         5UqGbG9GatAuwpbY3/aPPE7LExZ2WmA4VaU5zFzfXZX5s6qgXq2AlCxCugwDFZhjL/0L
         GOQomooj0IxuU8kWFb2SfysrTp/rySRYoYgQeXAXs5m/p7gpBoDbKa3zIe7hLisAjTLf
         MshUB1Ug8cnlzwMQNxBIei6q1W/LSENvWeUKLAnXc2wDw5F3FNlFStMDPNJjwAgU0qOw
         1cuH3JOIqsroTfx7bgLHyu6koFPbZPjenwfZsyHA8O1RZWEefgZcYb8KV6xsADg9mpy4
         tG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835329; x=1708440129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VCFBkygL/6eJOKkXAgrZmI3b3/D/n5FCeZU3c3PKSI=;
        b=GKpL29vkqB5Z+7nicVVjg2m1Ip2ZDCht5dVM8jjCPbWLvx67wA14RqeBD8Kqh+L5LA
         jaAfHBT2/58GkUgsT0Xs6BiiRCE1JgoaqOhcuDTvI5EDMQoquTZ6wYK8tqf4Hy1quVhd
         +wPY8kaAcwxx+Pduzrl22cU6zQeM+9SQv6n2M9juwyeBNc7H/PyjJMiZVmHkQQB/gy/Z
         9HQZRyTeXbbLvEoL07yLezut9EU+l92R3iyXjem3XM8lRfa/hBg4LxQFUxDNCcEYQPgs
         P2X7Jp6XLXRdGvOy6OoEo4IEuMa6faOt74XadtfAQE566koB3diIsyNKAtCOYmrlswzP
         QD0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcJN/VS/d67hLPNWKF4nB8PLWlVhjMNTOAHM0A2vEjct3v5hh1iEp3jzbXL0g/t2airgQ/8VM5SCuRHes2sNCW3F7f2O8=
X-Gm-Message-State: AOJu0Yy3bKnH+h0VfJTykQk0ruUgYdkNKxIfLFiO5P2wvt4dkeerrPf8
	O5MqTZ4hFn6YGu8N2qQ4y4yS9L4f6kfNwoBUYPK8A5O/L4qudyznxhvwsVmU/lbKclKDb1DjqFM
	+
X-Google-Smtp-Source: AGHT+IEev1ENW2z4nIyP0krgZKDnpV0XiwBvzjiKIgCGC5osYXFrnDkIC+NoX8PX+UjSiiAxpJuTtA==
X-Received: by 2002:a9d:62c6:0:b0:6e2:e506:748d with SMTP id z6-20020a9d62c6000000b006e2e506748dmr6090754otk.12.1707835329736;
        Tue, 13 Feb 2024 06:42:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUew+4emMEaTUg5O6y6uIZUs/k5DUoPaOpH4gZzdbJULcYM2c2T2sHO0jE0TF3yiZUGZvbI+wYzKMipBvgt3vtPABVLp4ntzKQ6oGmaUkDEg8uq4hud5115K6VSY+lzwlTz09lhpbDiozcoKgj4VtcSuapRxf6cAGUS047fbzgnClqB0KCbKnIyUOz2HAkjZ+hDAaMdKX2hzJqg37lviWNRPlv/vYhB8eNQXDTOKLn5Cjp0RDJwDKDa9EvvW+7SNBrkmXT5TTU=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bf10-20020a056830354a00b006e2f7ddf4eesm136171otb.28.2024.02.13.06.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:42:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rZtz6-004WEV-5n;
	Tue, 13 Feb 2024 10:42:08 -0400
Date: Tue, 13 Feb 2024 10:42:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robdclark@gmail.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] Revert "iommu/arm-smmu: Convert to domain_alloc_paging()"
Message-ID: <20240213144208.GL765010@ziepe.ca>
References: <20240213-iommu-revert-domain-alloc-v1-1-325ff55dece4@linaro.org>
 <20240213121257.GI765010@ziepe.ca>
 <20240213121934.GA28726@willie-the-truck>
 <20240213125303.GJ765010@ziepe.ca>
 <20240213125951.GB28844@willie-the-truck>
 <20240213134726.GK765010@ziepe.ca>
 <20240213140900.GE28926@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213140900.GE28926@willie-the-truck>

On Tue, Feb 13, 2024 at 02:09:00PM +0000, Will Deacon wrote:
> Hey Jason,
> 
> On Tue, Feb 13, 2024 at 09:47:26AM -0400, Jason Gunthorpe wrote:
> > On Tue, Feb 13, 2024 at 12:59:52PM +0000, Will Deacon wrote:
> > > > The typical kernel standard is to fix bugs in patches and only reach
> > > > for a wholesale revert if the community is struggling with bug
> > > > fixing. Dmitry already tested removing that hunk, Robin explained the
> > > > issue, we understand the bug fix is to remove the
> > > > arm_smmu_init_domain_context() call. Nothing justifies a full scale
> > > > revert.
> > > 
> > > I can't say I'm aware of any consensus for how to handle this, to be
> > > completely honest with you. 
> > 
> > Well, I work in a lot of subsystems and this is a surprise to me and
> > not something I've seen before. Fix the bug, move forward. Reverts are
> > a cultural admission of failure. I use threats of a revert as a hammer
> > to encourage people to pay attention to the bugs. I hardly ever
> > actually revert things. What does reverting their code say to my
> > submitters???
> 
> Huh. I guess I'm lucky never to have worked in a environment where that
> is the case. In fact, my experience is quite the opposite: revert first
> so that things get back to a working state and the developer/submitter
> has some breathing room to rework the broken code. It's actually fairly
> blameless if you get it right and when you have a half-functional CI it's
> pretty much a necessity. Anyway, I digress...

Fascinating, I am glad we had this discussion because I was pretty put
off by this talk of revert in this and the other thread. Cultural
differences!

Thanks,
Jason
