Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB5230B518
	for <iommu@lists.linux.dev>; Mon,  8 Sep 2025 14:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343530; cv=none; b=udFzHqH0We3lLimnLx6M0xwTpzWUCS3tJ8hM4Yxf6XJih35M73k5ISmlWwhZwGaivcQ0+E02gfTcLTHP3DIDngdRDFsuOkT3CGUFF0/eoykNnKGxvQnHWexJ4+Z+qvJAOiS9ed34OjDjSdCzLsJWKHXxUb3t2lSBd8iLjxEFBbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343530; c=relaxed/simple;
	bh=qD6rSVIGRWAFJh5ZP8autyVxm6mFsWrg8RVJ2pRgD2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgoVALb2QdeEbtu4ncxRHlMW+yLb+ZeGGwJwQs6QFZxGXi6QqkrIps8Yf+h/s6puoThjSEo5JjXzKwfmpCTOH0liq0f/SCcVjPNLdtbN6laovwXezYEQDCvAMU4ErOogIEmW2QarCWDiup4T6sRTpgxPNrTAjc/jk6g7DjK8hfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ev0anl+F; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ev0anl+F"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b38d4de61aso61721921cf.0
        for <iommu@lists.linux.dev>; Mon, 08 Sep 2025 07:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757343527; x=1757948327; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=At5jIJoawR6VKU81ZFaZespdUJb3hi00zL5H+qR/XdY=;
        b=Ev0anl+F4lCrOygDleZpk+4k1Bg7nPsgsIEmtHEYmstTtBYGW7bjZEhR+yE9TJ5Eyi
         TuUqUTn5PC/ITRY/FutO9TpiOvTi14ERPD74p1ePZnL9iELjPiHqlrBr0Mi/rHoFGiYF
         eR5OBrr9V0hjQSWWum6UMZWBnGbclrvWj+tKJFzPk9Od/OaQR75/DbQUTi0ZgV5wRKlo
         8ludH+agxsCEoK/5lrGc50GXktTqglcUTfPinfMOcvI5tEtHLim5IvNjGNdheibr45sJ
         llIQl6BX6q4geGaDRHQ5jze6IOe3+7HHu3T7A8Cu4Drzc8aldp/imobCL1Pno9hsa4R6
         RwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757343527; x=1757948327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At5jIJoawR6VKU81ZFaZespdUJb3hi00zL5H+qR/XdY=;
        b=r56wnqX3t8KoimPbZ4SEeFgAIv/HImqoimjkm9g51ypLKqtqiffxSlqQ0xh7hp06vi
         zcgW5Cl47VMBgJyPMcyJh4pnl3tVILYuMm66imUthIgf+3UCtt7KiEOG3Seqyq10H8Qi
         V3dYbVieKr3CO3XVqB/KAfup2MNnFnV4nAYhMYgkEFBtGrjQPdhv1ya/+Rdc5U1NFQAE
         F7pWQqkbNcOUm3CMcsegSk0EQaO37ePHwS88VKS+hZ0csCUJRLLKiDDlTL2G/GILzODP
         zHYWyOe7j/Z+IubsWSAIbYao//+vmvn7VZzsq4y3ShrjA5upmkwqp2sMcqY1qQQSgJl6
         ZmMg==
X-Forwarded-Encrypted: i=1; AJvYcCWBjplMkLZs/CaGM7VQLJhzV5OC32TXKXIC76aijc6WJGS6bCi/oAQcM/peMXIgmdaUp0Puwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPXX7A4SNo0hLImG3GAleGIeNgkKpvS7iiI7IROOesoLzEHvsE
	suDjt8qj/RJEw2J2dOWOU+BTu7tifZIRGhy4RSqHkuJKWhhQdXf2y/rzUsQpPOSAbqk=
X-Gm-Gg: ASbGncvjDcIA9JZ1TAwEdoL5dRQZra2TETUdCo6EKsyijL13naGYZdQK05Ye5h5gMTw
	bYyPasHaTQeJYwN7jxSZZVsDOR8bTmLJNOXJX1E5tsSdpTUogK3Zd6KOhT4Gp0m3WUREH84M3vv
	h2J4YMn4+hTIYPYV5BbJthUzxXR9Xr91nowupZI+HtIYVvQOd/utjmuD46IbRNNUx2t/dN6+1oJ
	a5uLAGn3kfw+VFU5YS7FMDx+SCBUVAuw2Pe/uoa14BhAaapdgMmJBtcKq5wIgdYcxMeR+IacWCq
	o1uyj7u+hUV0dWY8aB5n2aNIhqBpB+QUqNHAMabQzjsiUVM3TGP4ey/2cIkUBYorBXSf7N93+Jd
	Xysfldd5gEZ42E86loztYW/uIFWT8RUDbA6SFjGRwDy/KNltAmp0kKzAxjBbAHGTxLaaMAZSjsh
	w+6m0=
X-Google-Smtp-Source: AGHT+IFTREWXmNkCHrDWnxjbQBowejD+m7z5dZM3VJ/Oa0MlcqknU/2nQMhyme6Bl98HvCKinECwig==
X-Received: by 2002:a05:622a:2486:b0:4b3:940:e41d with SMTP id d75a77b69052e-4b5f847f8acmr78181031cf.69.1757343527463;
        Mon, 08 Sep 2025 07:58:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2cbc78sm125532986d6.23.2025.09.08.07.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 07:58:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uvdKP-00000003IyI-35cn;
	Mon, 08 Sep 2025 11:58:45 -0300
Date: Mon, 8 Sep 2025 11:58:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, will@kernel.org, maz@kernel.org,
	tglx@linutronix.de, robin.murphy@arm.com, akpm@linux-foundation.org,
	steven.price@arm.com
Subject: Re: [RFC PATCH] arm64: swiotlb: dma: its: Ensure shared buffers are
 properly aligned
Message-ID: <20250908145845.GA699673@ziepe.ca>
References: <20250905055441.950943-1-aneesh.kumar@kernel.org>
 <aLrh_rbzWLPw9LnH@arm.com>
 <yq5aikht1e0z.fsf@kernel.org>
 <aL7AoPKKKAR8285O@arm.com>
 <b5ee1ab3-f91f-4982-95c7-516f4968a6c9@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5ee1ab3-f91f-4982-95c7-516f4968a6c9@arm.com>

On Mon, Sep 08, 2025 at 02:47:21PM +0100, Suzuki K Poulose wrote:
> On 08/09/2025 12:40, Catalin Marinas wrote:
> > On Mon, Sep 08, 2025 at 03:07:00PM +0530, Aneesh Kumar K.V wrote:
> > > Catalin Marinas <catalin.marinas@arm.com> writes:
> > > > On Fri, Sep 05, 2025 at 11:24:41AM +0530, Aneesh Kumar K.V (Arm) wrote:
> > > > > When running with private memory guests, the guest kernel must allocate
> > > > > memory with specific constraints when sharing it with the hypervisor.
> > > > > 
> > > > > These shared memory buffers are also accessed by the host kernel, which
> > > > > means they must be aligned to the host kernel's page size.
> > > > 
> > > > So this is the case where the guest page size is smaller than the host
> > > > one. Just trying to understand what would go wrong if we don't do
> > > > anything here. Let's say the guest uses 4K pages and the host a 64K
> > > > pages. Within a 64K range, only a 4K is shared/decrypted. If the host
> > > > does not explicitly access the other 60K around the shared 4K, can
> > > > anything still go wrong? Is the hardware ok with speculative loads from
> > > > non-shared ranges?
> > > 
> > > With features like guest_memfd, the goal is to explicitly prevent the
> > > host from mapping private memory, rather than relying on the host to
> > > avoid accessing those regions.
> > 
> > Yes, if all the memory is private. At some point the guest will start
> > sharing memory with the host. In theory, the host could map more than it
> > was given access to as long as it doesn't touch the area around the
> > shared range. Not ideal and it may not match the current guest_memfd API
> 
> The kernel may be taught not to touch the area, but it is tricky when
> the shared page gets mapped into the usespace and what it does with it.

But what happes?

The entire reason we have this nasty hyper-restrictive memfd private
memory is beacuse Intel takes a machine check if anything does it
wrong, and that is fatal and can't be handled.

Is ARM like that? I thought ARM had good faults on GPT violation that
could be handled in the same way as a normal page fault?

If ARM has proper faulting then you don't have an issue mapping 64K
into a userspace and just segfaulting the VMM if it does something
wrong.

If not, then sure you need all this unmapping stuff like Intel does :\

> True. The GPC Page Size is going to be 4K. At present the RMM S2 page
> size is fixed to 4K.

A 4k S2 is a pointless thing to do if the VMM is only going to approve
64k shared/private transitions :(

Jason
