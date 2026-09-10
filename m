Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44E493D59
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050547; cv=none; b=PXvw6n3YlmT7Uu6et9YXOa9id06KCm/gllmwnqLEl8S1mIwEwLamVt86hfIkUXz3iV3diXcPj5u9DFiKj5Tj/xEUaDe8EIDdTtJpVpXMV+2ivTRlMn8G2ziLL1kzEt9Ik2Y1lFrmspclsNcqazn0tJrp03P1MpCDtwqgI4/kkdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050547; c=relaxed/simple;
	bh=lyspu3aOKLbIRf5XENbtCVfMBm8FA06IHpc+MnfQ5hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdoXaxPWWwlpdQreHCelMSKk74zisP//xbW6ahS9DPKKrL4eRKT8OBLqXRSY80BEnfzuQxjSFSWd/TzZP3JSixoHMqsw82jqdhbnTYJcsyebx+TTFrpVZjsedozyzc2TRyDVLpOOeO64+m4wvgm93Q7KgCN+BoeUCpORCZLAHuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tx4bUsTC; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tx4bUsTC"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so230291cf.0
        for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 07:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789050544; x=1789655344; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U4B0H2819dU8lEDJ1XLSE6/+8p+h2NlR6cCuK8RNsxY=;
        b=tx4bUsTCJFlgvsJwmGqKghRlSQNAoetw6XeKeA7YGoBKgc0GPff1jYSin2l2fLDYaB
         gcGe6/fmz3h6ih56ro20u5VUb2JmbCCaQS1e+T5PlOxDX1c3fdMvQSAYlETLW0+2nfAJ
         2/hQ/3d29q7jSnsVQMgQVh0C8mH3u1pJ+ulWyEMwAMQ34eOQ1CrKjRmwMRkG83HfZSmz
         vXi5+2+3VNPSR5jlam6x/38ZonD9x4nDWod2IrwD9Vc0FYM1+IRYl7FKBdZexHOTCrma
         trcnjMqqFMgnc9z8/C4HUDfPbI6LW8QmYBfetLIchaeWZydw53m5gJnXYbLrTdT+3G8a
         LBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050544; x=1789655344;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U4B0H2819dU8lEDJ1XLSE6/+8p+h2NlR6cCuK8RNsxY=;
        b=j0XJw92XBLBlnnzLqpHIeICvIyLStpitHPBP5FzTnJcrdVx7c8RtLoTS4GFMX4ZF4n
         RNRY2BpIhrK72KtHQow8khevEpij/4aUx1g4iRAEIdJolUWfSETfs4feypep3oDKZWjP
         GCr26pB5geS5ojuK5kn9/jLodMm/yeFJ8VhEbVRh4PCat5tYjHhoeUxHySx5B/Qrj6uA
         YBvFCL5eBKluM/jjwOY4ljXI4nIFZvzitd7YbeoYH7L3ewMq2NC6NTCXojGqb70ftBpd
         Dp5L/7/ncC557fWziMsTfa6RMPGeyZd+5of44Ge6JeIZug5uH4LlWJwjlzpqEnJwiObL
         nCPQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuM2r8xvJZePUS+ccxDB8IWsMYucVSRlUv1kAVSIkUS3k1MeTJbytvGvcwwqeA4q+I9jNrCg==@lists.linux.dev
X-Gm-Message-State: AFuF++mjVRMlMGQrDScpomL41Lq3aLEYdkaO3kWBkjo2cLxu50FebyOY
	PjZNqWQiQlFZVz71YLzZLPpzOpLISoD07DV3ugU29+0VSZH6QUUEGIef2berv1Gong==
X-Gm-Gg: AYBFou0WkOhyP1C4Tex9oS/8990LFvozslTZPUQp96enlM8WsP0YeRV022lmgR7KEkb
	wuU+Y/7PDrnoRJAVrnRLYViPI4u0EU4dXt1nJk3x5eN7c2Xpd+wrx0pG1zFV0ur5CDcO/uheNgl
	UmuDLvxVIglr/pn9yGdNFwtDhl49UeeyZOM5erNjrgZ0Ww0A/l77xUcPZQgeAS6t01cHp3Cg0ru
	DMw5xkzaBv2L2cjOTI77H2wbItiW4SwbDauvGjdcIXl7hndATcrKOpPc8cViksYmqwF21gmGEi5
	5Fkg8xj6QfQA1Wxttm547KNMbYco5PPizZ6TAZOOQP0D40B+lthOQWePho8Wvj1r06bmSJLkX8E
	8ttGt1yH4h8KZHKh/12WXqh1wxN8dLO4rREMj/aFb2Ufogna4WVYqzUo6m1MofHQUadgyJz2Lf8
	SpELyjOvYhj0+Yym87LQkQ1uJBWBHO7lspqZp19Ujx8AJiYIsaqyKfRVms2a4SB3kYv36ZwPnXq
	OVPvdlOVIMHi6t0tcyQBs7L5Mq7jM8mFwU76iQZ/A5GKHY=
X-Received: by 2002:ac8:5cd6:0:b0:530:2f98:cebb with SMTP id d75a77b69052e-530b62fb6a3mr16703951cf.11.1789050543398;
        Thu, 10 Sep 2026 07:29:03 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6bebe8d3f3fsm3196267eaf.10.2026.09.10.07.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:29:03 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:28:57 +0000
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
Message-ID: <aqK-qfJ0x8-RLMgT@google.com>
References: <ao3oHn8HiXIx5Wrl@google.com>
 <50ffc453-f918-47f8-9556-9813308690a9@amd.com>
 <20260826122147.GA3666382@nvidia.com>
 <bfb7be5b-2da3-4bd3-8146-9bd079011a75@amd.com>
 <20260828115331.GC3922654@nvidia.com>
 <399db967-050d-48dc-afb5-5c77ee9cce65@amd.com>
 <20260904142547.GU4157646@nvidia.com>
 <9be08ef1-7ae0-483a-938e-17e606b5d214@amd.com>
 <aqK04hq575iwY5BR@google.com>
 <cb98a268-c709-4489-981a-07d662a1f4da@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb98a268-c709-4489-981a-07d662a1f4da@amd.com>

On Thu, Sep 10, 2026 at 07:45:01PM +0530, Vasant Hegde wrote:
> 
> 
> On 9/10/2026 7:17 PM, Pranjal Shrivastava wrote:
> > On Thu, Sep 10, 2026 at 05:25:25PM +0530, Vasant Hegde wrote:
> >>
> >>
> >> On 9/4/2026 7:55 PM, Jason Gunthorpe wrote:
> >>> On Fri, Sep 04, 2026 at 03:43:01PM +0530, Vasant Hegde wrote:
> >>>> Jason,
> >>>>
> >>>>

[...]

> >>>>
> >>>> During boot, it sets certain default values includ dte.v. It doesn't
> >>>> clear everything.
> >>>
> >>> ?? It starts out with a 0 DTE table? There is no inherited DTE table
> >>> except for kdump.
> >>>
> >>>> May be we should just remove ignore_device() completely? as
> >>>>   - normal boot, its not yet configured, so no DMA is allowed
> >>>>   - kdump boot, old DTE is still valid and let it continue?
> >>>
> >>> Yes, that makes alot more sense to me.
> >>
> >> Ack. @Pranjal, Can you fixup and send v4?

[...]

> >>
> >> Yeah. One of the cleanup patch missed to update below comment.
> >>
> >>>
> >>>         /*
> >>>          * Order is important here to make sure any unity map requirements are
> >>>          * fulfilled. The unity mappings are created and written to the device
> >>>          * table during the iommu_init_pci() call.
> >>>          *
> >>>          * After that we call init_device_table_dma() to make sure any
> >>>          * uninitialized DTE will block DMA, and in the end we flush the caches
> >>>          * of all IOMMUs to make sure the changes to the device table are
> >>>          * active.
> >>>          */
> >>>         for_each_pci_segment(pci_seg)
> >>>                 init_device_table_dma(pci_seg);
> >>>
> >>> The DTE starts out with blocking because it starts out as 0. This
> >>> isn't making the DTE blocking, it is doing something else. And it is
> >>> very suspicious and racey looking to me.
> >>
> >> IIRC there were some requirement to keep V bit ON. Otherwise I don't see why we
> >> should set and flush the dte here. Let me dig the details.
> >>
> > 
> > Should I also update the comment in this series? (It seems less relevant
> > to the ATS stuff)
> 
> I'd say lets do that as separate patch. For now lets get this series finalized.

Ack. Sent out: https://lore.kernel.org/all/20260910142655.3281464-1-praan@google.com/

Thanks,
Praan
