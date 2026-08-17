Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105B642643C
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974725; cv=none; b=AZ9xpg7z8oVrxWpMGh53LbSZsRjGMMO2nwDCNEFZXA7g2m4VxAminIkrl/hdojl/YGICWBUvWrJAK2Jhdxcm4luRW9HtkuNDGDAu0wzMTrXNmbzMxn7Bg/tAseLdkBB+NFzg97nj/V58be4t9lwltdj0QuPSqyiczJpPxPwTFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974725; c=relaxed/simple;
	bh=ovicJPVHHm0KKOq5P+Gn+Ka0LA06O3tLa290kqEJT4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRl3aJfPmgLVD9qQoCA+49cXwPF0uBatUAvqT62LTwAovxdNf8ey/iLZPMu8YP6uBQLomBaysModZFv9pCrc3XzoTw54tdgF7Wr0tgKU26jitkJjVQi0LjZW5jGDYmFhaWGvp6JjqM4szolRogF6cTOzn158cDdfT2iHt6bzLbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OO1xR1YX; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OO1xR1YX"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c2a818fc4so22696091cf.2
        for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 06:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786974717; x=1787579517; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+jsIHo1W5qHLLVsb5aeGfb7z9NhHPeAPjBJZbhgtOzQ=;
        b=OO1xR1YX/93jm8LKsoO0xWPBMsSwo/9/steOY6IJjU/9RrJERq0QEMzhxIDW1V0/I0
         876shk/qQuBivr0wXr6FkBMWgjn+EogDRjVsq11p5U+JBBLy1hOgUH93A2i7caRB9cOe
         DCW+MZ7eXpELhbXzkEkh4DL0EMmD+8cCx9n8BgMC88Kj/9DJQWYf/UYTsZbkbAbXfjpC
         P0rO2vsGNl7rlc/3mqjUP/yqOOMJhYyc0yzY9N/wO6kFvRU4ngyFCkTSjJROCZq1gnv/
         agofKipLXhQyfRDpRgRceeNMaCq5Fv6DCWmx9cY+LWcsXrfCyuKd/GHNbReNjapCo8ut
         JHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974717; x=1787579517;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+jsIHo1W5qHLLVsb5aeGfb7z9NhHPeAPjBJZbhgtOzQ=;
        b=GAswvWoQHzKQfAB8a6y2UdkXK6fiqIgKe2O+3+cOL9+hR6skRkplFQlSUEhpKGZ2LM
         JFc6AUVa5aAOWXS3GFgK2cvZiefI/W5GRJjcb8y01EgM9Q/qu8iNH4Wye+0W59iCKX+k
         tI6xlhEXer7dXiR0LeGguTIpQGWZaCkmiNBqVaOJbbQmwbyg5mneQ6MhUnBDFq3lNXpm
         p5hTfl0sti6DEkVQnRAbluXUnGqG2jt+kbWFv0ecBkI0HfgnrzBuLFVAG8Ic3JSyzIDh
         oYpw4LbeXMV6wsmPFY2f4GQ89YGrQoCB7d25Gbo8a7RuKJuJdXXkx1UPyKD4QuCw9xV1
         SeIA==
X-Gm-Message-State: AOJu0Yx7f+OZ6o4KOZbt214VpY+wQG4sAG2qPrAhL0sOUOol+d+nOcFn
	AKT6O2pSGic8UTwxaX9SDNCp5YcNRtYJRzg6T2HM/yALEz/s6ALMS4DqgzZmznRf8ItjX8incHD
	5e9Vm
X-Gm-Gg: AR+sD139Kwyex8SluRTtin0Tq8oKzuLF/qNHOxSezagEmEOm0/jctGZarghEoZVXm+Z
	WMKWDU693bGCkButGc20gxgrLFyDl06ezKfeiSc9KxztNvqfvqceFFq+IDH9BSPLzVzHfR4uKsk
	9efmmL+oVSoldoT0SL7ZvCePUbgu4LTsm8xJ0Cn97bC4HRyZAxcrCeTpI3R5vEGHLQHnKhSjpC2
	gdgQb3Tndo7HT3vYDyiJLZ5neBpkslwleZ04h44YXG2rj/30zee/MV1AYNmznD6tClDyCz5rtwA
	5hxZRayAfWwBihH+z5Vr/sf1iz2SXXJONDNKvYnPO+iJcSRl0l3HOv7JDFjY7zpGM7aGizfxzCp
	lxMzIPPTETLfqpf+t5No8wZ8tyRsEDiXtOoRaiQrJN9aWpqOO2KZr3AU2Ysqtfr3DIcvmsGzdLD
	pDL8wYnpQRYWieP8ytxUxwDfxAZbu8Kfe3rQpxLA==
X-Received: by 2002:a05:622a:30f:b0:52d:70b2:b9b1 with SMTP id d75a77b69052e-52d8552ed24mr250363471cf.44.1786974716982;
        Mon, 17 Aug 2026 06:51:56 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52db60e9e49sm14905441cf.6.2026.08.17.06.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 06:51:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wvxkp-00000005x70-24dO;
	Mon, 17 Aug 2026 10:51:55 -0300
Date: Mon, 17 Aug 2026 10:51:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	Max Zhen <max.zhen@amd.com>, Liang Wendy <Wendy.Liang@amd.com>
Subject: Re: [PATCH] iommu/amd: Remove iommu_group_mutex_assert() from
 amd_iommu_clear_gcr3()
Message-ID: <20260817135155.GB1415075@ziepe.ca>
References: <20260814104029.71021-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814104029.71021-1-vasant.hegde@amd.com>

On Fri, Aug 14, 2026 at 10:40:29AM +0000, Vasant Hegde wrote:

> Remove the iommu_group_mutex_assert() call from
> amd_iommu_clear_gcr3(), since PASID teardown via the mmu_notifier
> release path is a legitimate caller that does not and need not hold
> the group mutex.

Why doesn't it?

Right below this line is:

	gcr3_info->pasid_cnt--;

Which certainly needs the lock.

In the ARM driver this async release notifier was pretty tricky to
lock properly. It just updates the equivilent to the GCR3 entry to
make it disabled and doesn't touch anything else. This is locked in a
way so that concurrent domain detach doesn't face any races.

AMD should have the same basic design here too.

Jason
