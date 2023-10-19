Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FED8F49
	for <iommu@lists.linux.dev>; Thu, 19 Oct 2023 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GHWmJcvx"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1c5c91bec75so57508705ad.3
        for <iommu@lists.linux.dev>; Thu, 19 Oct 2023 08:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697728512; x=1698333312; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m/tcTfs0PflHwKMpetwk3afhilPxA8Q9Lp8a1lR/wmE=;
        b=GHWmJcvxQHIrOOzx/kbdOmPLx6qGvjcVqfB/RcxNlr8s6ovlMcejPMVbfig8iHghKv
         GHGFh/0YaYzXXaETfPALdS1P0/tAH9On1SyPe1tTV66TpuSNGy5mepCGEfmflWvMQLFD
         W0rQtpHgsixMGVpd4D4fEi481A2zoxFv8MP+clFuA1JcXdhAW/N+Tn53OtzOJL0h6hyY
         S2XLLgO8filuux/w79VuE+7vAI/SfVK0O5BaWIcuxojK9x4+us17JUDYVnXw9dNNPpIa
         hhzkjEDfIdpu9Uoly11pFK/tKkGjwlPPJp7Acoab45LFX4OgOoSa7ISb6xvuQ3Yq0Gwk
         vo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697728512; x=1698333312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/tcTfs0PflHwKMpetwk3afhilPxA8Q9Lp8a1lR/wmE=;
        b=R6STclbZRdpFC0i4W71gmQIFz1H8d2uczOu0XcDVXumV0Tc14p4H/7OXLiZf3h0VrM
         GcTdI8M1eDdavSqoGhKBoCTDKHf8lM2J4aXtavfM8b8WWeMM7osq3aYyxAWNny0kAIGH
         pZvNFPdqAH+9lUByZLzOpW6wSRQAUjsRFVhN6xGFVbFvsRXdBJ1vXrNuaUe3M8x+awdd
         kM0LCu/xdViWItxOR3aTRlZwfNFJyVe476G76VsSOYgNur5XoS50DPw+QS++CcigPiwc
         3xtrjTIChdMPRC4G+Rhsdj4fzjU9BR6922Zpl7k9jXvNpmjH2cCvKJqzwkUYgH7QawOT
         vkog==
X-Gm-Message-State: AOJu0YwVUNveYRvC3j86nXVESy5IzK2ws0wQi8HqRt6KThxfADEP+y7X
	t3mG8RUIr+3x2fE+oFz7Yz6xWEkc7OGj3eS6K+UA4g==
X-Google-Smtp-Source: AGHT+IHC2GCYSgQBivySy6NMX0VhiBlgVlMe6JGwUC4TRk9A/00nLrDl6p8Mw5q8/7/dfkM9E4VZIw==
X-Received: by 2002:a17:902:c7c2:b0:1c9:ca02:645c with SMTP id r2-20020a170902c7c200b001c9ca02645cmr1815570pla.36.1697728511974;
        Thu, 19 Oct 2023 08:15:11 -0700 (PDT)
Received: from ziepe.ca ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id ik14-20020a170902ab0e00b001bb3beb2bc6sm2113976plb.65.2023.10.19.08.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 08:15:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qtUjt-003D8G-LY;
	Thu, 19 Oct 2023 12:15:09 -0300
Date: Thu, 19 Oct 2023 12:15:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, quic_tingweiz@quicinc.com,
	Pavan Kondeti <quic_pkondeti@quicinc.com>,
	"Patrick Daly (QUIC)" <quic_pdaly@quicinc.com>
Subject: Re: [ARM IOMMU] IOMMU framework concurrency issue
Message-ID: <20231019151509.GD691768@ziepe.ca>
References: <e2e20e1c-6450-4ac5-9804-b0000acdf7de@quicinc.com>
 <20231017163337.GE282036@ziepe.ca>
 <70cc8d3d-1ddf-4700-ac15-bcd74fae2b2a@arm.com>
 <20231018161918.GB691768@ziepe.ca>
 <0d6b490d-83df-76fb-f5ad-e9730fc57660@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d6b490d-83df-76fb-f5ad-e9730fc57660@quicinc.com>

On Thu, Oct 19, 2023 at 04:21:47PM +0800, Zhenhua Huang wrote:
> In above time window (1), dev->iommu allocated but not freed, if it's just
> accessed by client device's probing(Thread 1)..     crash happens.
> 
> I also want to mention from our side, it's *not only seen for non-iommu*
> device.

I see. So there are only two locks we currently have that could
resolve that - the device_lock or the iommu_probe_device_lock

The device_lock path is what my prior series did, in your case you
already have the device_lock on of_dma_configure_id() so you just need
it on the bus path.

The iommu_probe_device_lock is what I guess Robin was thinking of with
the of_xlate rework.. I looked a little and it seems like quite a
thorny problem.. The ARM SMMU drivers seem to model the correct design
using the iommu_fwspec to pass data from of_xlate to probe, while a
whole bunch of other drivers decided to put the first half of their
probe functions into of_xlate!

To untangle this to use the iommu_probe_device_lock the of_xlate would
have to stop using the struct dev (ie so it cannot touch the
dev->iommu any more) and all the dev->iommu touches in the of/acpi
code reorganized into function arguments to iommu_probe which would
then store them into the dev->iommu under the lock. Ie stop using
dev->iommu as some temporary scratch pad to shuffle data around prior
to probing. Pass iommu_fwspec as an arg to iommu_probe and a new
ops->probe_fwspec. Stop calling dev_iommu_priv_set from of_xlate ops.

> Patch seems good to me and in theory can cover the case I have met. I tested
> below based on 6.6-rc1 for sanity with minor changes(clean up tags etc). If
> you're OK I want to propagate into our tree and to see if it fixes issue?

I don't think this patch can solve the races with of_xlate vs probe,
that is just wrongly locked.

I assume my series you linked to comprehensively fixes this?

FWIW I don't have the energy to try and fix all the wonky drivers
properly so I don't plan to revisit it.

Jason
