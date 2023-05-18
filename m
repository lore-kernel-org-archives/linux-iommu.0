Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ED523C9D
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 16:49:36 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-30644c18072so1518583f8f.2
        for <iommu@lists.linux.dev>; Thu, 18 May 2023 09:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684428574; x=1687020574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AM8DwTmosLNfh4+dWykqnnp3+AvL+dO94NEcMeQYDFQ=;
        b=jkffKmivCJNFzoQ6z0jsuQ5OnNUV5s7hDGPvgf502x3D56V4OZ9auOZcWvEUFF+cu5
         8Bqzvq5wySx+SiLdeLdGNJYKOBq6L0BhG3Vb3hSZFZP79+k9eN4YkE5U92VREm7o8lWw
         yWmJrf52yWPr5YCVg18BLi0hjqS/8Im/oTiO5W7fBVOEvoYqljLM76wz9skAAJIwBM9V
         /2W2q/uS8iNZ+qjIDhvjh9AhHmm9zozY4c5x3z7RX0p4vZahyMTXon2PTgKkZQG7lGW1
         LQpd7pxqDlGbUgLIviL4Z+/DvvS2tburMNKQ/CYy70SEk8A9NdQWEZYhujMuahMAQiyz
         9StQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684428574; x=1687020574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM8DwTmosLNfh4+dWykqnnp3+AvL+dO94NEcMeQYDFQ=;
        b=D68UNwvJrPLYH9kUaItYjD7r9nWsGPyQ2WmiZJy5Lbmcz0KXK59MPlDTNGBS59mbQv
         LI422qJRQHdbt2oxbSSQV3VpX005SXSJA4nY0sCXSOXyyteR+/lcpcVgzpObGCOnKjiI
         4tQe/BaLWygGNRDMdHkflqzUlaw0efc5J3Toqda/h8BZrwRP1Rhg2IAI5LiDHyT4uaXX
         OBFt5jIPz3CC/taV21/NfbKqHnKqqDANnwMFgpGo9yHZrrlvD+d1/E6mDrDGh7HMOAlM
         zT7FkS759gIgKDedt6HlRYXVF0swSXGCgFnsYfYf0syYpb5cST6oiyxOEStxgYSa0DdM
         uyuw==
X-Gm-Message-State: AC+VfDzR01HRhMHBcE8LL6r0/MnKjR4s0cKwPjQg1Dpcd4DLgLU/Dc76
	feq7qBTEX0Qj4CGUUsK6+Jr38A==
X-Google-Smtp-Source: ACHHUZ7/wGIKmYno/qEiN1QV7YGyBQN5K4Nr3OQzJ53R0OvyhypPiOw2/5mRgNMSCEwVBuOW1B6WKA==
X-Received: by 2002:a5d:4041:0:b0:309:732:86df with SMTP id w1-20020a5d4041000000b00309073286dfmr1915516wrp.58.1684428574676;
        Thu, 18 May 2023 09:49:34 -0700 (PDT)
Received: from myrica (5750a5b3.skybroadband.com. [87.80.165.179])
        by smtp.gmail.com with ESMTPSA id e2-20020adfe382000000b00304832cd960sm2726216wrm.10.2023.05.18.09.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 09:49:34 -0700 (PDT)
Date: Thu, 18 May 2023 17:49:37 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	eric.auger@redhat.com, virtualization@lists.linux-foundation.org,
	iommu@lists.linux.dev, akihiko.odaki@daynix.com
Subject: Re: [PATCH] iommu/virtio: Detach domain on endpoint release
Message-ID: <20230518164937.GA2934820@myrica>
References: <20230414150744.562456-1-jean-philippe@linaro.org>
 <20230510081157.GA3326511@myrica>
 <ZGT+44a6RYZ999kz@nvidia.com>
 <20230518135638.GB2587493@myrica>
 <ZGYvMDbkBN+2UgzG@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGYvMDbkBN+2UgzG@nvidia.com>

On Thu, May 18, 2023 at 10:59:12AM -0300, Jason Gunthorpe wrote:
> On Thu, May 18, 2023 at 02:56:38PM +0100, Jean-Philippe Brucker wrote:
> > > Can you wrapper this into a BLOCKED domain like we are moving drivers
> > > toward, and then attach the blocked domain instead of introducing this
> > > special case?
> > 
> > Yes, I think the way the virtio-iommu driver should implement BLOCKED
> > domains is initially clearing the global-bypass bit, and then issuing
> > DETACH requests when the core asks to attach a BLOCKED domain. This has
> > the same effect as issuing an ATTACH request with an empty domain, but
> > requires fewer resources in the VMM.
> 
> Does that exclude identity though?

No, identity attaches a domain with the ATTACH_F_BYPASS flag (or an
identity-mapped domain if the feature is missing), it doesn't rely on
global-bypass.

> 
> It seems like the protocol should not have an implicit operation like
> this, the desired translation mode should always be made
> explicit.

I probably misunderstood your plan for BLOCKED. This particular patch is
about removing devices from the machine, for example PCIe hot-unplug. So I
thought you were suggesting the core will at some point attach a BLOCKED
domain to a device being removed, in order to block translation while the
device is being removed and while a new one is being plugged in with the
same RID. For that case I think DETACH, rather than ATTACH an empty
domain, makes more sense. Otherwise with the same reasoning we'd need to
attach all 4 billion endpoint IDs to an empty domain at boot which isn't
feasible. In addition I don't think we'll want to force the VMMs to keep
endpoint ID state internally after destroying devices, though that does
need to be specified one way or another.

If BLOCKED is only for transient states, for example while a struct device
is not bound to a driver, then attaching an empty domain works and is
simpler to implement. Probably the best is to implement BLOCKED this way
and still call DETACH in the release_device() op.

In any case, it shouldn't make a difference to the core. I'll see which
one is better for the VMMs.

Thanks,
Jean

> Having a boot time default makes sense, but there is little
> reason for an OS to go back to the boot time default...
> 
> Jason
