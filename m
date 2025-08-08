Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D402277815
	for <iommu@lists.linux.dev>; Fri,  8 Aug 2025 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754655320; cv=none; b=UWiMVq00xZwfw2IrktMCSGyUV0SsUnhqu/74RkSpgHYSFnzxeVqMVe3eCe3Z2eC7odz18MfKr7wtEPIRT0HJ2mL45g45OQb79j1CUeVEEJ8RvcHAyUeNnaDoS9WbIETnvVrZeff6Wo2o8+E/A7/EQO/yTOOJVh+c6Yx6u57kCbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754655320; c=relaxed/simple;
	bh=KjlLTJox+aEPkr7SyVNi+vSqzknO8UAJgxNui7KfZqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5t86+js/msagSmWd36ipMSPW0te+1BaFEYE+6jKtDQNhEZbZMvv5msiji1tfZCDmR5xeUUaXJ63ZGtpE0FWHc7OHoPjjDD0mBDuxE4JQLzSQvXeNrg6YQBxI+8+uMKRnsnk/GZ9W0iEPZUtApAy+10ZA1jAq3/URPYEB4wByA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nn0RlVvw; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nn0RlVvw"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e1d89fcc31so209832085a.1
        for <iommu@lists.linux.dev>; Fri, 08 Aug 2025 05:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754655317; x=1755260117; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KjlLTJox+aEPkr7SyVNi+vSqzknO8UAJgxNui7KfZqI=;
        b=nn0RlVvwevLQ3091xnDjvRZtr3uLG0kw+5+CovUOpM16fGeL4OGBZX4DBLhIs3Qme6
         0HwamN/3ogcpnFYkLOYrKM/Dvv7RGbvhdSBaEkibEqVOJo0r3fZwyNoS7sib9HvymrAP
         d3xrYao5GdLYpqT2jEvPZgMoYBXZX/O2qlOwynx6b/wipU8beOYKvT6POFzXLNBFWWN3
         sDaUC4Zrjrj/RgbRazmOHOyY3WozQajyxFaSw8sF0S8LrtyrdyueE6H8Ad9BER9uD8Fp
         Pqy6BgOJlAHVWTBb5GtiJ/B/M1aJ615GfDCHHR3zh+B4LcVKQUdarnjuIaDvFInS1qdm
         5cSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754655317; x=1755260117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjlLTJox+aEPkr7SyVNi+vSqzknO8UAJgxNui7KfZqI=;
        b=gQKGNeRvgvE0G2tlTBiVb8m4rNUJZ4NS6J3fV7GK9TGq2h30nhvg2FbWFX4rb1tvAX
         ZypnWCU5uQW5CX3+r9EAHjmQMA0L0XnTUi4wtAs2e+WNiYduZ1nnu7nY+we5loYrEz4K
         kVbw7w8IqbDEno6fw0b4cNt4frS7UXw1T6QcS08WWaKfLwMgelOIbE7I/fEm8c0UfjAL
         SU/hl0O+VItV0oUYmfjXojXmnNWu3IlUD0WkGpyN5ESLryHgY+tfFl1J/Q9+R0yMW30q
         BVnoDjAhYwhOZ9zVjBcNkAG8U5h6BKaAa+KLbiG5lG9yoOztmCkzxIO6QEtkCpS84qog
         y1Eg==
X-Gm-Message-State: AOJu0YxTdX8p5xE+Q3dsLz5WEFMM1MdQbX5sz0iOeFhBjEMJkDzUBL8P
	fFSMriTETRv2+R7CjMQx17jXW9LZN64o+3bpZoerJ3NpKYAOtMxfpErPaiiXNOHX++8=
X-Gm-Gg: ASbGncstEHntIjJF4kFhh2W26lTYEA5x/65/Wn64lOCoCx7WalUKiP3JQargnDlPRnH
	B2zYRNY952tp1D4e8tKzflsvIDqM3QIt85JQxRORQPRmp3DjQdlViCGR3OZEhoVOjrsAIb8G5U7
	UI5TkPAHxGr3SKLAufUsmK3/i1GcgO6hm107OwXCs5avHiOX5XgcGOAlmmG7c7uN9Wabxen/gL5
	oazEeLuGPKJaZ1X7sMBmyKNVgGQX8w+w9fF2tymINL/6iVGSlYiG5bAux1S9FUXCV+bgaXvode2
	zs0gJAHFrLcwDur1PBGG6JT1HRziegGuVjxoZgSjjal95YNLlCcQ9pTpU0qjerZg9Z5D8KQkFEe
	L28rg0ZxbXMRWwTqUhptnHhDO0KsZgMeywMxXI4gweZKdzC489p1x3BB8Hwu8dgsdlrvCspK8JP
	oz6Ew=
X-Google-Smtp-Source: AGHT+IFydq6l6b5JXXNn6gOqeE0yXEq9dZ/J9DKgW7tPI3RiBa0ZAO/jnR4IhHmIeHf5pIqVx18YPw==
X-Received: by 2002:a05:6214:29cb:b0:709:3d74:2ed5 with SMTP id 6a1803df08f44-7099a301143mr35261076d6.29.1754655317080;
        Fri, 08 Aug 2025 05:15:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cddc290sm112232056d6.63.2025.08.08.05.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 05:15:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ukM0B-0000000256j-2zO9;
	Fri, 08 Aug 2025 09:15:15 -0300
Date: Fri, 8 Aug 2025 09:15:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	will@kernel.org, jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com,
	bboscaccy@linux.microsoft.com
Subject: Re: [PATCH v3 2/3] iommu/of: fix device tree configuration for PCI
 devices
Message-ID: <20250808121515.GE377696@ziepe.ca>
References: <20250806215539.1240561-1-shyamsaini@linux.microsoft.com>
 <20250806215539.1240561-3-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806215539.1240561-3-shyamsaini@linux.microsoft.com>

On Wed, Aug 06, 2025 at 02:55:38PM -0700, Shyam Saini wrote:
> Individual PCI devices lack dedicated device tree nodes, but

This is not the case, you can put PCI devices in the DT as well, there
is a syntax for it. Why not do that and have the FW populate it on the
device node itself?

You should CC all the device tree maintainers on something like this
as well.

Jason
