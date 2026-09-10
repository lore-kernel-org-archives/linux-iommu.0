Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E04915B7
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048043; cv=none; b=SDd35uKJM3+zmlaMXaenxnksURBLJl9kLvgxHzBVDS9cwyI5u8VWr6xmkzLtCWXH5pgmGs7ATaK1YD5Gibv7Xa7NfYcuTQLSoVq0y+z7vNCe79b/J3F69BjIdwC/U6YPFNrOE8G/d0jcQw4xoB5LvNEYBNDXODoZfcHPUG+1G9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048043; c=relaxed/simple;
	bh=EAupyPyuOf7QDpZYE61msvaSyoWYmzVXc55xqZ5Wf/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HelbvsdfLAT2UJZ5nySCU0L+eUdaG3S6wRDtdI8QKG5JVLy8iPb8NK1gfiS/F0R0YJGjYSCokNASRGHG8HqWXL9zGyjT1PKmP7ZCCjK7XqTcSBUDwEtXg/9+44FS/KGmuBqUfodsvI+176LOhO4lDGhe+RNtrVQGLTSkjGzSFTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I+G/ByBS; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+G/ByBS"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca07so74185ad.1
        for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 06:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789048041; x=1789652841; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Er/jDsnNRoh+QmJEZXA5qaI6MvfZ+ynzviSkzMrOHk=;
        b=I+G/ByBSC32wi8/eyv2MlllZfPQpLL/LRRceCcQBxoOem1hdIGJzo6BEHDFg4UD7lO
         Ufzcl1zcB3QzeU5cPwgsQVy1sFRLkoArjLF0UXliZ9M/7TOM8Bj0V6mH+xH7c5Q4/9Wk
         j8J01FxbtG6XHQFqUtmXqh14UcY3PKi5+QwA/TRpRgCRPF2oOmfSRdHkjc2hLHiAnUud
         tvzEE9hw5hQqa9/d5z5JDSqOo4AvSbh7JSLSkihKNULDJBLviS/ppH2NBagRMmPhsdjI
         r78LFpXIl3/Pj18uXZ7lyhxw8eANIcvymzO5KSJhcd3nHOMpc5s2xGIM2zuu7x87F0hD
         rAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048041; x=1789652841;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Er/jDsnNRoh+QmJEZXA5qaI6MvfZ+ynzviSkzMrOHk=;
        b=rwLr8uPkYfpJigqex4N8vm5ArGA9dEMBnqsYyGJkGL1RXw5vTAn0cWgMRGZFvCBBEa
         PJNU9TcgmGKFuth3ICnF4JoD4ju5rI+6wFk83gChWXMKA3RgQBBpWDxLmp84k27uParq
         Y4PA7o6pAp6a5AcSMjJ4wvgSeWvfxKY75bSSKjijIX7zbPcJVNOtnGcta+ms/WJfC0QU
         NQKgRExtN6CTexR7K9rhyXkkHEE8cFmtXo1+ACz9h7+QxBTgbtX/ccIbuyirE4ZgnSWb
         K/mxUtSSVI2WAY1kgPV01Wao/UpDbTpkihzSuwKLN+n4p1m3sBPkguwAUlR21CY70LCk
         9UQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxuKM1P+oCOe1NBLBgebZdh04ZK0IEh93vfaySa1Te5eICkk0q+XjMzMB48vea6G4F62F7j6w==@lists.linux.dev
X-Gm-Message-State: AFuF++kvNMTCAa+L5c5Ub/5gEkFBLDySHLMuxomDYcbi2pziq/IrB0t4
	TRhnkRB2rUitrSjygbMjlBuYvw4t754DdMDq0pfEOtUmvb5yeV+utzokL8W27YXyuQ==
X-Gm-Gg: AYBFou2S4v92E4XpPiDaYkUj6g+yvnSaM1uIEo5+Dhb87DNCvZhu4GZrwX76/HGxJ6U
	Jfp4J4XM9PmwFJbxp+ewoIIaQtkzImLJ2duC1/DGDVB8l9gOAv3xDdAUk0QWuh6o2DF4ajE2bBH
	sFDw3fYnBC+xTmfHknJZh+majC1nUCBOvwjlXNfSiPwjbI3JmE2PaXqc0FBsDkaltalXfudL2d5
	QRkRp/0vH3pJI0hel5EqSau56ujqyyHfx00O04uMTaLlYT2G/6BSdalmK4PCroBPdUrui1u8GVT
	clUn+73sa7mzmXQWlnx3WCF0VHjerOJ9NJkzOOWFXg2eKDTxqLhnglV8iI/O67QGnn2MsR4sM1E
	veQ9vJR/ujdBz72JLpeYwj2C/bvl3IVaJs0P2p4XdlMGYNWu/Hc1HJdmdkO8QrI9TYuLhjfUcLP
	nlJ6elUI/3uQafo8Uze01XxpTP8NCFnPf34uKaWRY2rxe8uzBMjmBeTopfsmRa9tAD8zqY8hoD2
	Zoq4QGMdAikZyv2WSlF+MJEuj4oJC5O/8UoBpBs1oclTpI=
X-Received: by 2002:a17:903:4b46:b0:2d3:153d:acae with SMTP id d9443c01a7336-2dd109d9e59mr7015225ad.0.1789048040913;
        Thu, 10 Sep 2026 06:47:20 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1483ea94sm89902865ad.9.2026.09.10.06.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 06:47:20 -0700 (PDT)
Date: Thu, 10 Sep 2026 13:47:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ankit Soni <ankit.soni@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
Message-ID: <aqK04hq575iwY5BR@google.com>
References: <ao3RF0w_AXo5EXxv@google.com>
 <20260825175315.GD3325090@nvidia.com>
 <ao3oHn8HiXIx5Wrl@google.com>
 <50ffc453-f918-47f8-9556-9813308690a9@amd.com>
 <20260826122147.GA3666382@nvidia.com>
 <bfb7be5b-2da3-4bd3-8146-9bd079011a75@amd.com>
 <20260828115331.GC3922654@nvidia.com>
 <399db967-050d-48dc-afb5-5c77ee9cce65@amd.com>
 <20260904142547.GU4157646@nvidia.com>
 <9be08ef1-7ae0-483a-938e-17e606b5d214@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9be08ef1-7ae0-483a-938e-17e606b5d214@amd.com>

On Thu, Sep 10, 2026 at 05:25:25PM +0530, Vasant Hegde wrote:
> 
> 
> On 9/4/2026 7:55 PM, Jason Gunthorpe wrote:
> > On Fri, Sep 04, 2026 at 03:43:01PM +0530, Vasant Hegde wrote:
> >> Jason,
> >>
> >>
> >> On 8/28/2026 5:23 PM, Jason Gunthorpe wrote:
> >>> On Fri, Aug 28, 2026 at 10:46:48AM +0530, Vasant Hegde wrote:
> >>>>> Having the driver boot up with all DTEs programmed to identity (eg
> >>>>> 0'd) and then try to fix them to blocking after the iommu probes
> >>>>> devices is security backwards.
> >>>>
> >>>> During boot, it only sets dte.v bit.
> >>>
> >>> First it clears it to fully 0, what does 0 do in HW?
> >>
> >> IF DTE is fully zero, then all requests are blocked for that devid.
> >>
> >>>
> >>> It doesn't make sense that you'd pass over the DTEs after
> >>> probing if the original 0'd DTE was actually blocking?
> >>
> >> During boot, it sets certain default values includ dte.v. It doesn't
> >> clear everything.
> > 
> > ?? It starts out with a 0 DTE table? There is no inherited DTE table
> > except for kdump.
> > 
> >> May be we should just remove ignore_device() completely? as
> >>   - normal boot, its not yet configured, so no DMA is allowed
> >>   - kdump boot, old DTE is still valid and let it continue?
> > 
> > Yes, that makes alot more sense to me.
> 
> Ack. @Pranjal, Can you fixup and send v4?
> 

Ack. I'll remove ignore_device entirely and drop patch 3 for v4.

> > 
> > But this comment is also wrong:
> 
> Yeah. One of the cleanup patch missed to update below comment.
> 
> > 
> >         /*
> >          * Order is important here to make sure any unity map requirements are
> >          * fulfilled. The unity mappings are created and written to the device
> >          * table during the iommu_init_pci() call.
> >          *
> >          * After that we call init_device_table_dma() to make sure any
> >          * uninitialized DTE will block DMA, and in the end we flush the caches
> >          * of all IOMMUs to make sure the changes to the device table are
> >          * active.
> >          */
> >         for_each_pci_segment(pci_seg)
> >                 init_device_table_dma(pci_seg);
> > 
> > The DTE starts out with blocking because it starts out as 0. This
> > isn't making the DTE blocking, it is doing something else. And it is
> > very suspicious and racey looking to me.
> 
> IIRC there were some requirement to keep V bit ON. Otherwise I don't see why we
> should set and flush the dte here. Let me dig the details.
> 

Should I also update the comment in this series? (It seems less relevant
to the ATS stuff)

Thanks,
Praan
