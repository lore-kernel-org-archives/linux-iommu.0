Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA41F2820A5
	for <iommu@lists.linux.dev>; Tue, 12 Aug 2025 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006492; cv=none; b=LYq74KIJH5arDZLaim4NX/r4uaDVrM8kUsq7bDbSX83t55mUqfbpbyBiVj36lSpCTcsOUWdHFyzxyZujNKfA6FOCQxV+jcWXrW1gjNIdzijYDVKIn9ftPb1F96GY7re9lJlsrfB19uljhVZCRgtz85CJcfOBMnb/BxppE4WzfNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006492; c=relaxed/simple;
	bh=8w8dsb/uFPEAy0xmEBycHMX3X/m+wobouE+WgPVe6Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6weyiLEjhDmUGCRC8NU34lKhqswTWC0HcSBvcqwKyrxvO6kZBihKtBxe/6Zk27Fx87hDlnZGVkx+8ogQtENwxjfXRWQ1q3ekEJi93THVX+gj5J53Iu9Y5Wwjw5bkpaNehXE74oer3DFMO8SYK5zKu2wYUTIYj9rfOn2pYZSzNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AAOpoPE+; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AAOpoPE+"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b0c5d57713so39005571cf.0
        for <iommu@lists.linux.dev>; Tue, 12 Aug 2025 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1755006489; x=1755611289; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FR8GU0OhyrXp1118wyyWRxkyUnIP7crv/d61bMyXgwE=;
        b=AAOpoPE+MldvIJC2M/hcezDOhOUg1Ee9igxLqWIOoME23JmsJY6PQ+T0Z7UDtkH6or
         uRq5xYxB95Vo3bPx6DC4WxlOSZUTw7CBmygGaHCrN2T7xZ3PzWl+mgUD0DcloHFvjK+7
         1jQJuOv6mPQgG0+Ew8WMQQWJzXr9Ocf2Kub+hzvrQTH2WhwWzwmCvWjI8TToV2RE26FS
         dqVAGN3elQjIvtTbhHf6Uy1ASo3zIpvwM0GlYxHG9h2NMsOHDR/QWV5PRwd96qAGYARL
         6G3BfUUX0oliPN/bhPC4lFqbvDQa/LalIzoQ3T8SY9GRUOayxCZdYyD3xC5WMtGrk4wH
         XIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755006489; x=1755611289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FR8GU0OhyrXp1118wyyWRxkyUnIP7crv/d61bMyXgwE=;
        b=XlPCmU9h0lGYl4chYdFJskVpnK/EAbLEvnGKcs8IDUavtqx+FtkvYeNX34dOHPCjJP
         CrOlwiG3fQiLL7O0hdfPAbMEYichuBdCFlKwyImKS+Yw6O1wP1gC8C4B47SBKEPDrNZR
         mZSRuOyU+3LyjysAI0QUBs83gfHA/AOwxBiXjWB3CqWeuCsx3cukZAFF8lgnmc//OY60
         QoSX/fTtrKsMvlO3RHvamp3GnvFgu/SkwYrj3wB9YM3L3qRB5FbY9yH4zNFtjtuCl8UP
         l19oP75fWrskUW+8iFZTBQSHlQyS74Kw7V/OO2dBXU1eajfbxELLbYOYGorYYriiComm
         t7gg==
X-Forwarded-Encrypted: i=1; AJvYcCURaAWbjpkQLRtjwQZSBxPAt4Oame+vAlYzQ3D1O9YU2VfLYjFdfJADJeG1iFa6VNP5o4G5ZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCgnbIGGzxwcdXP0TUJks34Td6Wi2Ri8IINZerX7vIEonVPM7g
	tnn2m5ONAiuua6MexyfojaFSttxvkQNqOFWBhWPtSwMVn0uvDVAHffvV4swyib0fcfY=
X-Gm-Gg: ASbGncvV/8w7agj45e55KXqTMXdDfkkpCPZdzBLaDyv+TQ8Zc7yx2iJjtbQ1g5ZYLju
	3WgZJmDcc4dfMPK5ZV9+t3tuf12h5mB42aUmMOl9NPPCXDZtPszgK5QBq3wjmD/Gpp27+znlxtZ
	k07dSMzGJMsLyhihprSkXLLYh8nuWzsmqOLRhrhQp+UMSeQdR00qB3xI8hUKSSAATSdA5Tb9PUW
	myzodINjIIS+taJgDkV4wMZ/ck5U3yK5Gc0U7VenoWt7kj0fm/i+TF069HCP6cl2zSA/64ElTSW
	BT4PTYyIuF0x7/8jBCPSZqyup79RGxtv7f8s3Usn1MXfflgM/IwSeVC139op+y8761cKfgP+OIi
	UFxK+upfHkKsdhvCyMZ6h/8jD/PVVDts+hPQptr0otqYiDKAuAnsiNQewih4+17dQ4eNf
X-Google-Smtp-Source: AGHT+IHI6EhFhIRzAESYthEtnG0baUD5Q9gVXq2RPFWP9iicVSAJltUOiMffIa1QwE25DHjgtqhMEw==
X-Received: by 2002:a05:622a:6:b0:4b0:86b4:2520 with SMTP id d75a77b69052e-4b0ecbe5777mr52212061cf.22.1755006489353;
        Tue, 12 Aug 2025 06:48:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b09c11bf8bsm83500631cf.20.2025.08.12.06.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:48:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ulpMG-00000002cyr-0e38;
	Tue, 12 Aug 2025 10:48:08 -0300
Date: Tue, 12 Aug 2025 10:48:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v3 29/29] iommu/arm-smmu-v3-kvm: Add IOMMU ops
Message-ID: <20250812134808.GC599331@ziepe.ca>
References: <20250731165757.GZ26511@ziepe.ca>
 <aIurlx5QzEtjpFLd@google.com>
 <20250801185930.GH26511@ziepe.ca>
 <aJDGm02ihZyrBalY@google.com>
 <20250805175753.GY26511@ziepe.ca>
 <aJNiW48DdXIAFz8r@google.com>
 <20250811185523.GG377696@ziepe.ca>
 <aJsXkidmcSl3jUJP@google.com>
 <20250812121056.GB599331@ziepe.ca>
 <aJs1dMiomjtxVwl4@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJs1dMiomjtxVwl4@google.com>

On Tue, Aug 12, 2025 at 12:37:08PM +0000, Mostafa Saleh wrote:
> I see, but most of the code in KVM mode is exactly the same as in the
> current driver, as the driver is not HW agnostic (unlike virtio-iommu).
> In fact it does almost everything, and just delegates
> attach_identity/blocked to the hypervisor.

How is that possible? the kvm driver for smmuv3 should be very
different than the iommu subsystem driver. That seemed to be what this
series was showing.. Even the memory allocations and page table code
were all modified?

This delta seems to only get bigger as you move on toward having full
emulation in the hypervisor.

So, I'm confused what is being shared here and why are we trying so
hard to force two different things to share some unclear amount of
code?

> In addition, with no standard iommu-binding, this driver has to be
> enlightened somehow about how to deal with device operations.
> 
> As mentioned before, when nesting is added, many of the hooks will be
> removed anyway as KVM would rely on trap and emulate instead of HVCs.
> 
> Otherwise, we can skip this series and I can post nesting directly
> (which would be a relatively bigger one), that probably would rely
> on the same concept of the driver bootstrapping the hypervisor driver.

I think you end up with the same design I am suggesting here, it is
nonsense to have one smmu driver when it is actually split into two
instances where one is running inside the protected world and one is
the normal iommu subsystem driver. That's not just bootstrapping, that
is two full instances running in parallel that are really very
different things.

> I am generally open to any path to move this forward, as Robin and
> Will originally suggested the KVM mode in the upstream driver approach,
> what do you think?

Well, I'd like to see you succeed here too, but it these series are
very big and seem a pretty invasive. I'm very keen we are still able
to support the smmuv3 driver in all the non-pkvm configurations
without hassle, and I don't want to become blocked on inscrutible pkvm
problems because we have decided to share a few lines of code..

Are you sure there isn't some inbetween you can do that allows getting
to the full emulation of smmuv3 without so much churn to existing
code?

This is why I prefer adding new stuff that you then just erase vs
mangling the existing drivers potentially forever..

Jason
