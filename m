Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45006182CE
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 12:08:15 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-56433b1b0e0so1259735a12.0
        for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 05:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690805294; x=1691410094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pJnixsCQHiyrF6hVIPsQkPv41cYGjNRTEPiId7td3UY=;
        b=WUnWnGphZ4QJA5WgfKzdJITA14jp18vwMSRqQ8Px9Z3Wy67WICz8rCp6COj9BEWPtd
         cQLQ7p+K3v7A0Bv4ZDLJjqJ7q08iAEu+QPCUiUX7PbeR1ETjkwv1lkOQvxwHH6FLO/c/
         HPhSljOrFKeV/JKAQdnKYqZKeUhqcgefL+9oc7fUDLkxmsnShw/DU89W+g4Y/NkB6607
         xth/HK3+KyylF9EALPACojHcrSdrXAo79poLWR3WQ1DPyV40u9wuCc3t0YrCCccbkgMm
         dk7QFiCWgBUc7w1IlVZ8KXaL5IjoWdzPQ0RTTWA7uYQXmVRViflFTH+tHHQvdoM6FyZl
         A2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690805294; x=1691410094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJnixsCQHiyrF6hVIPsQkPv41cYGjNRTEPiId7td3UY=;
        b=Vg3Z45wZIeJ5oMSRdWI5laS5h5RkaN4bP760fOdL2WiWZ52SYvqCqitxJodMX80kPB
         ngfHlCoYRpQowGWTMN7AHPwlaR731BGNwa9Nl541rUHOdwsTwj5ngIdYotBKKAv+2kGu
         mldMp4LzqRLKd8bBM8icW3UqAbXjj1nblfjz4j/3zSkGK1FWGIwfAXOZ1FoEwkF21hiM
         p5H8meBXS9SvmqjlqMmmFiylmF71GXzEOseLeriugMHFu52iamOi05yfm9u+xYuFxS1E
         59eZc9jReAyuZM8TvmYUswN+vfJWsgaZ4BaNyP5eXswRPQ95E9Hwqx0LS2Td2t+iQFZm
         9Ozg==
X-Gm-Message-State: ABy/qLa+XH80YTI2BNfbz95HJuuVHTT0KHRbchl2CsMI39dwnh/p/CFN
	WuKS/9a/lxwcw/9vhAx9le1X/A==
X-Google-Smtp-Source: APBJJlGH3xZvd+jTpXZSLVLmgnOrkbdINJz3zoQaM9c62Mr9zRgJ6G2nkJZTbMkfQCbaLYQ2KJPlhQ==
X-Received: by 2002:a17:90a:4144:b0:268:314f:8f40 with SMTP id m4-20020a17090a414400b00268314f8f40mr9183951pjg.16.1690805294523;
        Mon, 31 Jul 2023 05:08:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090a1a0b00b00268238583acsm8392241pjk.32.2023.07.31.05.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:08:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qQRh6-002EkK-Cg;
	Mon, 31 Jul 2023 09:08:12 -0300
Date: Mon, 31 Jul 2023 09:08:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 13/16] iommu/amd: Introduce iommu_dev_data.flags to
 track device capabilities
Message-ID: <ZMekLADODWhaQqbT@ziepe.ca>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-14-vasant.hegde@amd.com>
 <ZMPS8IGzwSWdnNWv@ziepe.ca>
 <89614189-9dc5-f643-9594-6fbcdda5ace5@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89614189-9dc5-f643-9594-6fbcdda5ace5@amd.com>

On Mon, Jul 31, 2023 at 01:27:49PM +0530, Vasant Hegde wrote:

> I had to dig git history to understand why its implemented like the way it is
> now. IIUC it was not for broken GPU. We cannot switch from V1 page table to SVA
> (iommu_v2 module). Hence they forced device to be in passthrough mode.

That has nothing to do with identity. It means you need to select v2
page table when working with the GPU.

We really need to get this cleaned up properly

Jason
