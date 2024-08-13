Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D521AC424
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 23:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723592382; cv=none; b=nYM1vLH29dRXexPi8IMQ0OgvlnJwsv6IC5ZZgSiV3JllPwYLziR0jLQaRT26DvBNSbdwsu4zkdXgexx8+CsOQl4r/jeAkrw+2zZLTqQ2hqkj8vO0c3LHA4QbNfz2Abnt+P2vBpEOzAqLzPGM8FolbpoDDLQybhC/qtk5MYVrj28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723592382; c=relaxed/simple;
	bh=Pd3HOMguHxSzpPeuDioCvnrJlFHD/UK1bGXz5hdR1fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbMUcg153A+5ygyiFo8txWWJXuHkjcCOvAaOmWO5Ukdj8qcTk0pnwZ7lIht0YXRncL8lHnZlne7QOY0Wua8D2RtkPDm7UEvXXw4sJoic+KbCloCBXJ+ELnmUzCoTlRPUWgYQwYso2daRXGzOW3zAdNFwas+y27gEtGhrqL6I6dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DxypTesf; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DxypTesf"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4928989e272so2373229137.2
        for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 16:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723592380; x=1724197180; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=98OTBv0aioFqa8eP+pfN2QrHRSjQQBWkH6KFwlgEV7s=;
        b=DxypTesf5e0pgEQx1e9kHgDkQA04kvFZvZeDv68kJfnIN/ZrI2EKFbF18aLOfknc3e
         A1DmCxjDEETYIStH0cGzLSqaTIbEdfQq9i9ZBA0M8o134FJ5Il288xrJJYb6yEty5Q+K
         dTy2RbJExXEwNfdahKVFQd6l/8J7//VKCCp/nRF6O/61GssYT4Qz/rY5g+yMk6mty4IU
         Znf0gBjZz2EYAnIbQ1Pybh1SiAFZMXsdefzeM0t30f2qkFEypKAmo71EAcy9SYPJcfy2
         H5AsQJa/YpKWg0joh97OFa5BK7PojfQoQkzuGcnwpr6JEvvrHeuo0E3Q+0ydIFS4v+/1
         qykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723592380; x=1724197180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98OTBv0aioFqa8eP+pfN2QrHRSjQQBWkH6KFwlgEV7s=;
        b=AAncGwNnRbx7OIjmaBLPCetoW5HEaWuOHEwpWYMGVR6v+Pw7SZCIyiyj3mAzcA7jpB
         wbBdFFtww+tarsgP/NWiwbKWVKC6YJ0Tba9tuETbUULn/9ZasS7r+jDGTbxWznS7YycQ
         G/kZt5X7ibkR80MM6l59E2pR8+0L1LYWGuJ4a57J1UsPRxL4wUA0KUVm45UslYYylLfX
         J5tOBIaKOSK5ZFzSJN5jHqn48h/nVfB3E3l9JjBiozX95tv+TI10Ho6ARbHAQuoKtZWK
         BvGn9gWyz7TX9ARpJG/c62jHMWVc2uoNvT5ADRCuIekYaHDAg7j2uLqc8Xfoum65sCV+
         NLIg==
X-Forwarded-Encrypted: i=1; AJvYcCXy3pm2d9yv+DJThsz+F3NVOFB71l/YTKW8jxrNbtPjCc4pTviFCqsMLyTnQd8PUrdsEI8E0+OvFYwevd7LnAdduYA5u54=
X-Gm-Message-State: AOJu0Yyldyx/CLmtFgyCrg9p3by8UntieKAiahoVX9VFpfTot3rUlMdO
	hZh5p2wAlNPeXePCTmZLxCasB77e8t6ubDNZtgts3Ly5kPrb7MOwc2gONmPkD6Y=
X-Google-Smtp-Source: AGHT+IE48TPAx7DnvwgaTUAY+Kff+tTrcpLLhWszaW51zZJR6kZlFg0WGCb5G5Fvkt7muunVnyyQLw==
X-Received: by 2002:a05:6102:6ce:b0:48f:df47:a4a8 with SMTP id ada2fe7eead31-497599e66c9mr1595703137.29.1723592379937;
        Tue, 13 Aug 2024 16:39:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82ca1ab5sm37630276d6.62.2024.08.13.16.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 16:39:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1se175-00AOnT-0P;
	Tue, 13 Aug 2024 20:39:39 -0300
Date: Tue, 13 Aug 2024 20:39:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
	quic_bqiang@quicinc.com, kvalo@kernel.org, prestwoj@gmail.com,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	dwmw2@infradead.org, iommu@lists.linux.dev, kernel@quicinc.com,
	johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci: Create feature to disable MSI
 virtualization
Message-ID: <20240813233939.GT1985367@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170014.1583783-1-alex.williamson@redhat.com>
 <20240813163053.GK1985367@ziepe.ca>
 <87r0aspby6.ffs@tglx>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0aspby6.ffs@tglx>

On Tue, Aug 13, 2024 at 07:30:41PM +0200, Thomas Gleixner wrote:
> > Howver, it will still not work in a VM. Making IMS and non-MSI
> > interrupt controlers work within VMs is still something that needs to
> > be done.
> 
> Sure, but we really want to do that in a generic way and not based on ad
> hoc workarounds.
>
> Did the debate around this go anywhere?

No, it got stuck on the impossible situation that there is no existing
way for the VM to have any idea if IMS will work or is broken. Recall
Intel was planning to "solve" this by sticking a DVSEC in their
virtual config space that said to turn off IMS :\

So using IMS in the real world looked impractical and interest faded a
bit.

But the underlying reasons for IMS haven't gone away and more work is
coming that will bring it up again...

Jason
