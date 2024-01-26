Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA0D1CF98
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282225; cv=none; b=RQSVXtBpbmq8AB4XFi3T7YrGNOIvAW1aGjZn4f8I8YEqPvp8rB2zzKQZeBSU31GS2YGr/dV51PQ20gbnBv2MhymPxCkFi1sPnCOO8mScPCJv7ChL0f72F3g8jGApJRnL0itpNxHeeC1itjaZfRj4sLoWpuZ/QkHPiMKxpD03GXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282225; c=relaxed/simple;
	bh=ycK1Stg6RqUITxTiNF6zYf2SsEC1R2ya33fUNr0wo3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfU+FT8VJbV5Gsoj2aTqWeXDIo528J0f4UyscW8Yjrr0JxTE3KrRdsbLYj0lMYMo4hwqiN38fiFuMTmVSAboWc9bBPl9bt0pQfxE/4YXk2Bfjw/B3q7dWjyxQoHTxDLBkAfurWrNJVoYJmpOy7DlXD+fvU4Go8NY7qrtpitG1Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K55Q8KlR; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K55Q8KlR"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so293187b6e.3
        for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 07:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706282223; x=1706887023; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ycK1Stg6RqUITxTiNF6zYf2SsEC1R2ya33fUNr0wo3M=;
        b=K55Q8KlREHjsL/C3PNvf/8e+kpIKtZkj4WRQ+xZTUSKSlLh0MkOwuLQFe08mku1Ys6
         8nGUc5KgOTzRsGdWVq+W+iZ9bD9XxQoKYZUZeqSqa+aGWAl0jM/E6qz4i/pWK+nKE6nE
         v8dOFPKIQCsE/vxW0uGZv9758QD2NkffWf/d1dB3FcO/wppsPQ8NitXya0kpUs2hSUc3
         o4X77zD4st/OSCgnIifuIC0EHkvjYL8KGBGmDXEdYQoRcQ/HdfQwZ9l8LXOcnVcHweIP
         +zwe5MHbN//yrMjN7hOyb4fsCMabaZLxHTdZ/DE36lfSuWlLsIfqAdnBpswo7ogZCT8y
         1eCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706282223; x=1706887023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycK1Stg6RqUITxTiNF6zYf2SsEC1R2ya33fUNr0wo3M=;
        b=mTxSVLolk5czz7gdOhIV/ds+h/UNx80aIrCk3GXeD8jn/Wq4NSxq613YEUoGRJOq4T
         hCpGKT9bYIG+zTliKmuk1zwj9IVq4sjC4qMSIjZueiIo5wU+Zf79nPrAsqvEG43HrrmC
         yT3eIo1QfYnIEXw+PMpEY0TdlpweV0sK8ObhDCm9HGMD3cQWrVzSuQukAhrKxwJ75J/G
         ad8vUZ+T6E+AlGwjUTR8R5vujTLjoKM7X79BH6nb9JcTxi0Ob6WDk/O70tA1P3oUufAR
         wm5DSC9kq6dvSH/0hYfrcdzRlBMJ4trcS/AMk9UMviRZCS1rVr/QPdPY5k+Y+Mlga9qp
         WzGg==
X-Gm-Message-State: AOJu0YyPO7qppjZY3/8nvNwmnmT5Sm/gqVMCuQ/2dj8Zf6l6yFjRpkiz
	rqNkGcxGSgzmOOY5tiFO5xujoweoDvkaYhNbrDwuVzV2oH+pDJeM8klQw5pjXiI=
X-Google-Smtp-Source: AGHT+IFrt9nryZjWKK5XB8rdZZQ0ZLiVll/0WhFtuhH2eLFjwwzfbOmZXs5b/TpVTrjEAEXhJyZ8jA==
X-Received: by 2002:a05:6870:b1c4:b0:210:e14a:7a9c with SMTP id x4-20020a056870b1c400b00210e14a7a9cmr1359195oak.58.1706282222837;
        Fri, 26 Jan 2024 07:17:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id ns26-20020a056870ac9a00b00210cc6cc9eesm385454oab.33.2024.01.26.07.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:17:02 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rTNwz-009S0o-4e;
	Fri, 26 Jan 2024 11:17:01 -0400
Date: Fri, 26 Jan 2024 11:17:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: iommu@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com, jroedel@suse.de,
	tpearson@raptorengineering.com, aik@amd.com, bgray@linux.ibm.com,
	gregkh@linuxfoundation.org, gbatra@linux.vnet.ibm.com,
	vaibhav@linux.ibm.com
Subject: Re: [PATCH 1/2] powerpc: iommu: Bring back table group
 release_ownership() call
Message-ID: <20240126151701.GZ50608@ziepe.ca>
References: <170618450592.3805.8216395093813382208.stgit@ltcd48-lp2.aus.stglab.ibm.com>
 <170618451433.3805.9015493852395837391.stgit@ltcd48-lp2.aus.stglab.ibm.com>
 <20240125155017.GW50608@ziepe.ca>
 <b825dd04-3d32-4fbd-91e3-523ddf96fc7a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b825dd04-3d32-4fbd-91e3-523ddf96fc7a@linux.ibm.com>

On Fri, Jan 26, 2024 at 08:43:12PM +0530, Shivaprasad G Bhat wrote:
> > Also, is there any chance someone can work on actually fixing this to
> > be a proper iommu driver? I think that will become important for power
> > to use the common dma_iommu code in the next year...
> We are looking into it.

Okay, let me know, I can possibly help make parts of this happen

power is the last still-current architecture to be outside the modern
IOMMU and DMA API design and I'm going to start proposing things that
will not be efficient on power because of this.

I think a basic iommu driver using the dma API would not be so hard.

I don't know what to do about the SPAPR VFIO mess though. :(

Jason
