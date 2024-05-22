Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DDEA3F
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381924; cv=none; b=Ji/2JRRWR0d6LxosBdDmOecZfphT3uWo3lSB1DsnPypb9xiT3vGvLoNM0JozZkAFZlZvt2M/AKE0GP0w+wdVkrkPHl42Qrw9sm/DI+LqlQo9WcKJ8TBYYnsU9eyX+Oiz2KBVokGe1FSZyPylFAn681jeo39Qsmw8MTiiqX7whJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381924; c=relaxed/simple;
	bh=6h+DlmyiNaZDu8EDvDasz+c9qX1zA+VxQ63Rp9dwApI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2Y59LnaUvbVlEMQ0YU3rjVzBqsi5jzx7K1ZwvFXoPLRWMbtapW0ij2Hcx/HHwmfY6K6qAolc6vFVHiBhVrjCX24+0z0P00yoU2B8ehRJlDEDz2EDU4epJEgV9J7QAqCUS+XAPJ58vf+ruwZ6AVOpM2XRjl9Yj2QKAfstJHBfcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HVMO9/uN; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HVMO9/uN"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-792bc48f6beso351101985a.2
        for <iommu@lists.linux.dev>; Wed, 22 May 2024 05:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1716381920; x=1716986720; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4PMQO4MVXhDYxg8A5GdJyXIRUDNYHsFb/4hfxxANEPE=;
        b=HVMO9/uNmpirbFvBUS1w5Bb7vBvcWJnnoILygjZmtrsu3GmRtsiSCjgwzgojUAAIDx
         u0vlbShhSGX+unfXuFxWIK1YIHrGjhgtyspb1SIUTJyJyEasnRegBuUEjeFU6P9E1PC2
         LEMWM1oMDBG79URzt8xDlBfQpLnQ6hetAY4Uqf5LcWUxJ77HGArKiWiBkxHFI5OhG1VW
         W6ByNkd1sZy168tOMYvAS/X36qnN5YC9ODmA8689p3J3fma+XK2GeywPDE2OCs8gzHoc
         sEHRmz7NnmsZcLYBd1lEQhEYURK36x2MQBAcatKR+O3M6A2v/BLHLxZNb0fqorrg/0HN
         79Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716381920; x=1716986720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PMQO4MVXhDYxg8A5GdJyXIRUDNYHsFb/4hfxxANEPE=;
        b=go1c69DE2oFzPSEFxi5JU4GimucH4Db5tRfMydW/NTBS5Q/T0lNblDQaPCzackN2DG
         MZrPSpTGLH6ywLSxWy/i7R9VE7ckX7dC5DR5fuL1aKJmn8g2GXhi/IzVzNsKHEy1lkat
         +AcQObKzM+29+QTGkuiaJ4qiDhJCBFHPHuJg5HHsHktHMGr1AemJYgZFWL6VqXQKRyge
         rk/CLDdDUU6v76+6OOzXZgEMJdJzcYHTCmVPUaA2pX+6QVJ065msSkl6RActZoqEKtvQ
         d0eWiLdxOjAqtTfAfjqIe25OL3U/1LgIftDo8mffuTHKEgsNCkMVekaMWV4nZ9sHrpMA
         RLXg==
X-Gm-Message-State: AOJu0YzuxS/xdiNOez8rcLv8mMQt+7s5qhCvaACH2aQq2tniLrqWzbHZ
	oBf+12Nsnn82vHCP8rEjTO97umZpmk23VTDcjPauoPO54Eh0JaoEc8bMX9cdNsE=
X-Google-Smtp-Source: AGHT+IGIOccHjWonqMh6MgWpEykK9Anbf2pkSPXkUY1K9SY7GpTRp/S1Mt8fo5h3PG7O1Tk4y5aQ1A==
X-Received: by 2002:a05:6214:459d:b0:6a0:a7a9:4988 with SMTP id 6a1803df08f44-6ab7f33865fmr20129356d6.13.1716381919783;
        Wed, 22 May 2024 05:45:19 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f17b4cfsm131592176d6.26.2024.05.22.05.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 05:45:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s9lLJ-00C8xv-OI;
	Wed, 22 May 2024 09:45:17 -0300
Date: Wed, 22 May 2024 09:45:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/3] iommufd: Use atomic_long_try_cmpxchg() in
 incr_user_locked_vm()
Message-ID: <20240522124517.GB69273@ziepe.ca>
References: <20240522082729.971123-1-ubizjak@gmail.com>
 <20240522082729.971123-3-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522082729.971123-3-ubizjak@gmail.com>

On Wed, May 22, 2024 at 10:26:49AM +0200, Uros Bizjak wrote:
> Use atomic_long_try_cmpxchg() instead of
> atomic_long_cmpxchg (*ptr, old, new) != old in incr_user_locked_vm().
> cmpxchg returns success in ZF flag, so this change saves a compare
> after cmpxchg (and related move instruction in front of cmpxchg).
> 
> Also, atomic_long_try_cmpxchg() implicitly assigns old *ptr
> value to "old" when cmpxchg fails. There is no need to re-read
> the value in the loop.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommufd/pages.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This patch may as well go through Joerg's tree with the whole series

Thanks,
Jason
