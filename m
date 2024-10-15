Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B1F1F9EDF
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011698; cv=none; b=W6LDOACcGq2ggvkQRf/saWHEZUWxCO3TIBeH3vLc5OGzDpC2VLkrgttIuDzuHZ81uD3pSU6Af4fwxEwL2l9CUAPYyTwuE2a2iIsRzsFoCTBxhZy25aVpatp1uehjoiMT8q0NPrvXNeeYX9sMXMp9zbokjKUdcKwvFPe9pSu219U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011698; c=relaxed/simple;
	bh=5j/boE+ggyRY8IsrcsLom9lsTKZxweCghTzAmiynmaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoWCm/g68rwRKbhhE6MqVDueAfZHw5+RciMBQSVxX47ofGMqVgNJV0hcMWXYhcxDwcGGoyRD/olbcFJVk37F+PG1HhFf3bjud/PTKi0BKEeToxt1RvAGZBIFPl7Gpxni6p28TA7YLPGOupGu1MjcfsVnGhtnn1YXfX4DX1z6wh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=C/ma/tih; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C/ma/tih"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-715716974baso3289229a34.1
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 10:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729011696; x=1729616496; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q/DvSNect61firhaFMldlLepElonkPc20b0lSMIuf2I=;
        b=C/ma/tihGTFkzHaaefnjRUzOLytEP6ISGsSGbI/Z9tQ3H73JNuVSrVvJVB2w+buGax
         kq2GQCGqO9HzPUVjqfqmOTaOk+UZXMe63zDWpbQ/K0WpJp7F0UePUirakguTKxc0vU98
         ug7bdMyRaV36Sbce2vr8FEOL+HFpW27QnlaXN9Xxq52JfDp3ZD0BVOUDzKA8zvVUEzng
         iIzHYSqA98/XD1RA5VpLvsKS5mMP4BVZCPlH7GJZjM27nWYGNvaRp2EJwmvk4gBPnWWR
         b/QRTYgXusgU7pdwxcTSxmA8wB66WGusgS61wmmddKL7UXQPsZiqSasCYICLRGCAXL66
         at2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729011696; x=1729616496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/DvSNect61firhaFMldlLepElonkPc20b0lSMIuf2I=;
        b=JUfRIxvxV/g8awInpoT9qF4iaI4NyAmLdn3tQ90rfdnRUin+JPYirSCw4BVxdpJfxq
         9j4FcS6m7pf9fNEW7ENh77I80J0ZuD4OKiOFlKL1LBR7UlHcYKD2/sTjK9+N2O7Mxwmn
         WSgzQ6DTa5RqzRS6VSsKwMYO9AIeBZfKT39d9+iDS5H86jGEcMLOzek0qvMz4ESeG0SK
         frgH+9Epo4fIQZ1zrxW3nF5lVxv0eltghxBGFWRNv75F8jBkYvlbHqDavXTHQNhNz0k/
         Ix8i2fCj8LECENuc7B8ySqYD/cghuHeXOO8tcUTXLXmZtwqWhJNsrIYxUJwTN09AYxHN
         F56g==
X-Forwarded-Encrypted: i=1; AJvYcCWT3Wj7zbMH0I0g908Di0BPzjv+AmAxdXJNR78aD8kBYpr4aHC/LSYHk6LxeNx70i+Qi5+qEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/6Oug5TS/BZCgC1Swder56zqx48BD4Y+zt4pKYIK6MZNgNeyK
	chy0K1G61McIQzkD9RNyeOz/OEEzkTqdl6oQMNTutchyg5zJ2m42DK0sMdRBGlU=
X-Google-Smtp-Source: AGHT+IE1uukxvE7RJpq0kHHk2hzd9jxilw/+AvBGwH1fKg1HsG9fpFCVa40eB840/BOkaVmFKId49g==
X-Received: by 2002:a05:6358:7e04:b0:1b5:c4f3:faec with SMTP id e5c5f4694b2df-1c340cb7b19mr357904555d.4.1729011695853;
        Tue, 15 Oct 2024 10:01:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0e4152sm8512091cf.36.2024.10.15.10.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 10:01:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t0kvO-00E6f8-Qa;
	Tue, 15 Oct 2024 14:01:34 -0300
Date: Tue, 15 Oct 2024 14:01:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v2 06/10] iommu/amd: Reduce domain lock scope in attach
 device path
Message-ID: <20241015170134.GQ1825128@ziepe.ca>
References: <20240910065812.6091-1-vasant.hegde@amd.com>
 <20240910065812.6091-7-vasant.hegde@amd.com>
 <Zw4p7Gc099DtQ_f1@8bytes.org>
 <24421a38-3d65-48bf-a40b-7a5b15f9b1fc@amd.com>
 <20241015161258.GN1825128@ziepe.ca>
 <62782c52-4bb7-4981-8158-9eccd589e50f@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62782c52-4bb7-4981-8158-9eccd589e50f@amd.com>

On Tue, Oct 15, 2024 at 10:15:30PM +0530, Vasant Hegde wrote:
> >> With all changes locking sequence will be :
> >>   group->mutex -> dev_data->mutex -> domain->lock
> >>
> >> In defer attach path (iommu_deferred_attach()), core call attach_device() w/o
> >> group->mutex lock. So I retained dev_data lock.
> > 
> > deferred attach is broken to not have the core code take the lock, all
> > most all drivers depend on group_mutex for correctness.
> > 
> > I think we should fix that, not retain unnecessary locks in drivers :\
> 
> If you recall, I had a patch to fix core code [1]. Robin had a concern and hence
> that patch was dropped.

I do, but I think the concern was addressed.

There might have been a small argument if AMD had a non-sleeping
attach path (at least in some case), but here you are switching to a
mutex so that is out the window.

It is one thing to say we don't want the group mutex in core because
it is just documentation, it is quite another to say you will keep a
fully redundant mutex in the driver!!

Drivers are relying on the group mutex, we have a lockdep assertion
helper now, we need to hold it consistently when invoking the
attach_dev and related ops.

But I agree we should deal with this in a seperate series

Jason
