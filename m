Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57D623C73
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 13:04:58 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3f41d087b24so14089985e9.1
        for <iommu@lists.linux.dev>; Thu, 18 May 2023 06:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684415097; x=1687007097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SH8xwc/xXorVb/89z74xGoIXBJoV+Yr58jU5Hs1UYB0=;
        b=dh+BcZwl8yDIzumwUjXDrKKP6mozTnLS69yI16G3xABvq7pMKbIx+hTsvkDyMCItoZ
         gGvIw+XCR2ts6oG9WA+ObWTg3PIuGQ0efysguYzZjfo51s9NsirrgGDO6pJnSIbl+II/
         Ut6RCgEMj8JiAR9tbl6+XXRep2GqxpXFKMQZf9GjNzhlI8aXcyrfsxytKHFz2UTOo9hi
         xoH3IjVKX5ACHUMXyRpONRgXuZWZKwbC9I321EopsudrEA+Gi0fOfiO3KQwt3BWv6IuG
         YXm4mK9RdUMMpwPRdd71Y2A/5JSKlbqjeSnnqIQcAEo0xlh4OJiT7SIx634IwsSYRiou
         JgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684415097; x=1687007097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SH8xwc/xXorVb/89z74xGoIXBJoV+Yr58jU5Hs1UYB0=;
        b=IwYRCOTg/7kG1rf27uTht3GP9DSrw+XT0TBfmZZ12GYeISlULQcnka04Evs82UVd4z
         qhYcTFAkcW/Eg7C0x5cMniS73qRKiFfgCFnTaYcX6RnR/CpXUQA0m/LyfJXsGF5yDkeQ
         XYL4OiuxcSRd7Ntuc7P2u/lcw7K/oHbyJxenoGmdEPUk1/zasrM8y6AjXh2N7r9dQp8+
         3fi3Eumti4SqKUC8+tlvFRL1Vr4Yy9cTJ6r4o+1+hYC9lJAasdnaxjooBeLNPDucEUzi
         taGiiJOl8E46C4EFL55/5jUeQWgI/BlkNVpGvSVRa+7vNEURBaAtJX/fNedRtWszsV7N
         0+AQ==
X-Gm-Message-State: AC+VfDzfQspH19aFVNFkr+W8ltkS2lh682FK16P/1Womjv8UBqsq7Lc9
	CQG3MCX1gQsxeTCKt+jqzFqFMQ==
X-Google-Smtp-Source: ACHHUZ5Kyufdq69uAysYPdJAwzbEYibt131CYFSzvhjPjsPflXyyYrJptBlJke3yX48lpp0oXIyKCg==
X-Received: by 2002:a7b:c7c5:0:b0:3f4:286f:1d99 with SMTP id z5-20020a7bc7c5000000b003f4286f1d99mr1379558wmk.32.1684415096946;
        Thu, 18 May 2023 06:04:56 -0700 (PDT)
Received: from myrica (5750a5b3.skybroadband.com. [87.80.165.179])
        by smtp.gmail.com with ESMTPSA id a8-20020a05600c224800b003f42cc7aac4sm1993293wmm.37.2023.05.18.06.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 06:04:56 -0700 (PDT)
Date: Thu, 18 May 2023 14:04:59 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: arm-smmu-v3 sharing SID
Message-ID: <20230518130459.GA2587493@myrica>
References: <DU0PR04MB94172CB3F138AD39E9B6DEEF887F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <359b01bc-e87a-9a50-c971-681e89985491@arm.com>
 <DU0PR04MB9417B971D20D1572FB598769887F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417B971D20D1572FB598769887F9@DU0PR04MB9417.eurprd04.prod.outlook.com>

On Thu, May 18, 2023 at 11:44:56AM +0000, Peng Fan wrote:
> > Subject: Re: arm-smmu-v3 sharing SID
> > 
> > On 2023-05-18 11:46, Peng Fan wrote:
> > > Hi all,
> > >
> > > Current arm-smmu-v3 driver does not support sharing SID, If there are
> > > two devices sharing one SID, the smmu-v3 driver will report "stream x
> > > already in tree".
> > >
> > > We have an SOC that using smmu-v3, only supports limited SIDs. From my
> > > understanding, the smmu-v3 hardware supports SID sharing, but linux
> > > driver not support that.
> > 
> > Ugh, we've always hoped that nobody would build such a thing, since
> > SMMUv3 allows for plenty of stream IDs for any reasonable system (Arm's
> > implementations support at least 24 bits), and aliasing at the StreamID level
> > does rather compromise the usefulness.
> 
> We only support max 64 SIDs. So I am thinking to share SID, since we
> have lots of dma channels.
> 
> > 
> > > I would like know is it ok to add support for sharing SID?
> > > Something like to use common rb_add/find, not
> > > smmu-v3 driver local rb tree add/find.
> > 
> > Not sure what you're thinking there - the StreamID tree is still private to the
> > SMMU instance either way, and the existing arm_smmu_find_master()
> > function is ideal for arm_smmu_device_group() to detect aliasing devices
> > and group them appropriately. Then you also need some way to skip
> > updating STEs that have already been touched for a previous device in the
> > group (basically generalising what arm_smmu_install_ste_for_dev()
> > currently does for duplicate StreamIDs owned by one device).
> 
> Thanks for sharing insights. BTW, would you plan to add the support?
> 
> > 
> > I'm fairly confident in reasoning about this for basic .attach_dev purposes,
> > since I did implement the equivalent for SMMUv2, but I'm not sure I even
> > want to think about what it would mean for SVA, PASIDs and nesting...

We should disable all these things for multi-device groups, it's not worth
the headache. I think we used to but I can't find it anywhere. That said,
I guess only PCIe PRI (not upstream) absolutely won't work with multiple
devices sharing a SID, since page responses are routed back by RID to the
endpoint.

Stall and by extension SVA can't really be supported with multiple devices
per SID either, but that's mainly a software complexity issue (we'd need
to guess which device it comes from, or report the fault for all devices).
PASID and nesting might work transparently due to iommu_group, though I'd
rather not think about that either.

It may boil down to updating the smmu->streams structure to support
multiple masters per stream (maybe simplify the driver first by moving to
a xarray [1]). That would provide a refcount for each SID and allow to
only write the STE once on setup and teardown. Since arm_smmu_find_master()
is only used to handle I/O page faults (stall/PRI which we won't support
in this case), it could return NULL for multi-master streams.

Thanks,
Jean

[1] https://lore.kernel.org/linux-iommu/ecb3725c-27c4-944b-b42c-f4e293521f94@arm.com/
