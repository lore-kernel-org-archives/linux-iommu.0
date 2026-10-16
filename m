Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F227F348463
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160740; cv=none; b=XIEdtzITBDAc9nWwMugiobw9Z2EeSu2bOSlOUu9KF3bybt54RfWE9SJb3i6YYl+OTBH12LYLAzaEIFqdxTqXfKtw3ffEktFtdl30sobK/BLvO9QzUnHNvMgsZXZsCAKPFPuWkXzUfmSmfNlXxUJc5F0fPe+2xgeXC8O2X0n84Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160740; c=relaxed/simple;
	bh=2vGcDzsdpNp3kRCn75jM79nFrKB+2GlocvrWcAHxSGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY5ch69tpbl5OC607LcaizM8h/VSWatmbzm6I8DbSxWPumN7vXH3K7xybZ/aCMvefP10G5ZrEBpZ9h55Ofyf2THnwKLGDJEGnUxSV9jr9tNfw6Jeo6YFMXcsSRMy3V78KmHZGmuAxN67Z8Exa+kZWGFoXFoFDUcroZXPze+CrgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=amD/uSCX; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="amD/uSCX"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93efc0452b5so1135185a.0
        for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 07:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792160738; x=1792765538; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J9B4QGdToSnYzAqwiubGkyqZ40Y9TYft35PK0Z/WSHI=;
        b=amD/uSCXSJKpjufZI5rC49c+xKu8MYzLgH5DW5ZgBOdF2HwCl2kjPL6fLLw5IwX4pQ
         4idx0PsO6Je0mPS3P0pmBhe2/j5jvTZnkVZzc+Ji3iAgG20XdrxwnM1Rec1gDHW07VDw
         8/7FHhzEBoyVCzuBbedxHbfWPtSqBSEbr3/5QKM3g55nMNTVmR/wLdZEAuIlu+05bpgl
         AP0fFXj+S3JBRD8YrTxvx4LfU4uPC3yaZJefC/bF555ywjQCC0h6alG9nBDZGgGViMYt
         akrgO69eg4qkpiK7VQ+V/HjQgNOavUJWhGmsIcybhlwqQEXbL6pTdq9doDk56+qCmMmX
         xaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792160738; x=1792765538;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J9B4QGdToSnYzAqwiubGkyqZ40Y9TYft35PK0Z/WSHI=;
        b=bcGSboVLYDavBoDNkYNu2ZZKFc+EWPkdh8cKCL102y4Yen58ZtSHLxIDMmoh+Lb5km
         5eSQSxqzjgsW8FH5VJIsdYRQ6jBpgQ8h/7kwJc7+5IZ7cpdZL6J6HJCvvmtPyqs39CQp
         ju9SDvDO6TSvHg3akjIbdEDh998mrHEyp/VzxgiQgLbPMjyfmTxytnPKZjvFpnFiyCBS
         dOTQadZ3o01C4WsWR0fRHAH+P9LGzt0eVcf00bKE+7Rnit0oKXC/FksqoZrijj+yEnNb
         cfd5KntxkeIfKJbLIzNkIdYxgBSpnNBVyaGKJ1u8jxFuVqoiHykUKunk1X87dGXsmK1R
         b70Q==
X-Forwarded-Encrypted: i=1; AKwUvBzCgewEBTQKXuzM5HR56RsGA36Oh+f5E0vTKtXe/Gf/uUNvoYHbddnGL+IdsGPf6MN7BEdG/A==@lists.linux.dev
X-Gm-Message-State: AFq9FYKwpJ+OeqhOCG6M4tdFNQqRFAsSfNq+WIuEFwm9ubV1wO8i+Tgy
	XKzdq+NPylRiuyMhaeemX1FSK1AekdZBJGhs1efCwQH0Fv11R6WBh1i9V1z/JflWG1o=
X-Gm-Gg: AYBFou2CDxXmfBfxoL3glAqxxfS8wVk+tyt6S9A1b5bsK2zg+jPUC+OTdmYWEcbYooI
	DR9HzgL9KAknBQfBzCDLYlYMTxcLaXaSmT+KDL50SJY/bD2zE1LIdsCQmKeJgTt3GPZjb1tcs90
	b1Xzqp5jpFp9ZulqVxDbSLMiG6lae+LVPHezkuTS5TeLFwA2NlDgUF8u//3j3wnSxV7U7Ex2by7
	MgWgHaXrxD1Bs9va0frc8/4Ch/PSWab06CvrkE1K9PYHQHq9FhQZZMBySePTvwRuG8ZgcbYViHg
	BXUQ5qvpr9OO2JYyb2INTMakMCmdpV9ZHlOCwF7pgBkEDKTBxhqPn/q0FZ2Zohpdvty7IGygntV
	rLeGw9hz0b/tUmtTu7mwysBgzIDEEvy5uK/NS3iDhfKuIv9Ebd8JSi2jOTB+DA+Bzqf1UALsgJB
	uE7Gvsu0qcDCtyAyKkeZTtqe5ff2q9AzMCRPdahYbhpu45lxow1tNj38IGb82L5wKy3z0lVR9ha
	XW8rqLIk4cCierBK28JPx8jqVqXvtE/ztR0YAfbGts1W5hOOLaIwiFN
X-Received: by 2002:a05:620a:3947:b0:93e:78b7:fa4e with SMTP id af79cd13be357-93ebd24b2fcmr3934753985a.37.1792160737536;
        Fri, 16 Oct 2026 07:25:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcba3e3a0sm23953506d6.9.2026.10.16.07.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:25:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xHisJ-00000001pql-49O3;
	Fri, 16 Oct 2026 11:25:35 -0300
Date: Fri, 16 Oct 2026 11:25:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Gong Shuai <gong.shuai@sanechips.com.cn>
Cc: alex@ghiti.fr, andrew.jones@oss.qualcomm.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atish.patra@linux.dev,
	fangyu.yu@linux.alibaba.com, gsh517025@gmail.com,
	iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	palmer@dabbelt.com, pbonzini@redhat.com, pjw@kernel.org,
	robin.murphy@arm.com, seanjc@google.com, tomasz.jeznach@linux.dev,
	will@kernel.org, wu.fei9@sanechips.com.cn,
	zhao.qingye@sanechips.com.cn
Subject: Re: [RFC PATCH 0/12] iommu/riscv: Add nested translation (vIOMMU)
 support
Message-ID: <20261016142535.GD14213@ziepe.ca>
References: <20261016000004.GB14213@ziepe.ca>
 <20261016091610.13912-1-gong.shuai@sanechips.com.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016091610.13912-1-gong.shuai@sanechips.com.cn>

On Fri, Oct 16, 2026 at 05:16:10PM +0800, Gong Shuai wrote:
> Hi Jason,
> 
> Thanks for the review again.
> 
> > > Add nested translation support to the RISC-V IOMMU driver, so a KVM guest
> > > with its own vIOMMU can own the first stage of a device context while the
> > > host keeps the second stage, and add the interrupt support. This is an RFC
> > > and comments on the design are welcome.
> >
> > The iommufd parts looked reasonable to me
> >
> > I feel some mild skepticism about all the MSI parts, it would be good
> > to get more of the interrupt stuff actually landed before posting this
> > again.
> 
> Agreed on the MSI parts. They are a working proof to exercise the
> nested flow end to end, not a finished design. The reason they are
> in this series at all is that the NVMe device we use for testing
> depends on MSI interrupts. Without this support, DMA succeeds but
> the MSIs fault, so the driver ends up polling for completions after
> timeouts.
> 
> We will keep following the irqbypass groundwork as it evolves, and
> continue this work once it has landed.

It seems to me the riscv interrupt architecture is a terrible fit for
Linux, so I would prefer you keep that out of a viommu series and try
to address interrupt support in VFIO through the other series.

viommu shouldn't change anything about how interrupts work..

Without the msi stuff I think you could get this merged without a big
trouble.

Jason
