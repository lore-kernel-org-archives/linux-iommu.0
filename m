Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E436C1C8773
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744219; cv=none; b=QYF9P0v7P5S6ryBxt6eKZMPXEM8FIsdnRRrzqBpJCooWge+gWi3aTTyJWO+mIa1UbwaRV7/3yAndpmmkTb9zVrs92UqkueD3Whr4vsgc26rw9qu0Q7kXCVoFXs5/jZYWwTArWHqpfDpARR9J6LS6faMXvv/7RZZYLhXCEbo0PTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744219; c=relaxed/simple;
	bh=aEX9Iu2DdJjiZmq983HwIwVg7yEpc/Ypoy2TwUzFRDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDI0QqomNr3oRnVkmSVT+TGhT81M/OKq+g/bvRzjDoPVMngQu9ZEQA8MWTkqUsflRSQm3W6o8/y4/vvVxb1AEWNUpDUf8GF9SUeifi5S4chFBOrX5do2VSdCvTWdlDwz3MjmwfORXK9pVs5FUPd0pBPvUXWzpXzAhetJT1sUFcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cynxltyV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cynxltyV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c8ac50b79so38265ad.0
        for <iommu@lists.linux.dev>; Mon, 04 Nov 2024 10:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730744217; x=1731349017; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=znyLSus/k5Aefu/8ocVhsdcXS5KYGUjWWkyPgFuNIDs=;
        b=cynxltyVEXXmcQ8feR6H8x2XEV/C8rVOEZFf1AfBs8n3ByL9xK8wbZPgg/vI7owZjq
         r8WHssmEyU0/YV0QiT/UuktwhLrWOg510BN6WhKJvkvRdc+wQ4JjF7JF1KnFetInBI8h
         ckeB6f6Kizvln9iE89MBrFyXmjsTZD85q0uL3VGApheG7ll3WL3xkVGRE79q2RMOj1XA
         uhaf97dFdw4zNlMdN3LIaASfnKa7Bd7BTYudUmKo1qNnUwOloIXV/Te/hoaIi3pH9DRO
         /IGw9Udd3n5OQYo1OkQ2yeH4ciT3vRTt70/GtMSQBkDDiWKvvFijXzFXZvEXax5UUhtB
         hmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730744217; x=1731349017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=znyLSus/k5Aefu/8ocVhsdcXS5KYGUjWWkyPgFuNIDs=;
        b=WWl9m4OMCY7XsMbWRqps7q9N6fnoOmhhd57FozU7MuTF1HsjdZajjrTFMCDrsHJGJC
         /xnX5iJV1tDL8JtgIbLjxJeVtb1g5fbxZFelhljMKQT48I80J8fZzUivNiHmBzgPBzYj
         jJVyZEZvXQwUbxrylgP0azUtDT2yN4m7b5Hp8JIKC1YaejaAsrxwCB8J81N4ljumwjC6
         wjBDD1JMIFkfZhM+KEtH7dwdcD7srTbohMSTVCnLM0gWWBxnpeQyqlVsVGZp4eZ3uzQY
         SurTEzuNwmdnwFJZIJriIGaivYKbCUrm6bLeCNGvZ/k04neClJ8fxvh/NEUfKZ+L/+JU
         Wu2g==
X-Forwarded-Encrypted: i=1; AJvYcCXo5RH1LMz3rYESewtwSnTpya4tOW6yNbS5W5cbfDHzqsL+DsnwObTimaKJ7O316zF25f59+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8v+8+1L53cu94aFf7cGh/hgphrGr570IRt+NZJ3j/6tJTXTGz
	4r1Wr3ajudYZcpWp6oecXD4D9EoQsdLeDgAEs/UneZPyLgRiX/hbeHagpaQ2ag==
X-Gm-Gg: ASbGncu9ou0QSeq11wbI0cvAmSdhelFFaqeMS0sfQ/SV4EScvL6DnII+d09UQfg6VbY
	erchPHf93JXvx6um6TQdAABbz0MYedeXcBHUr52Mu8OCEz0WGxcDmqw6OQTEBkc2497tBcytQGY
	Q2yilkS3fvLt+pxHEvYOx8SxJl0Q6yCQuIkXNRorE0wvq3XuZ6FlvL7578JCyWwGP0hTpAOmefJ
	TeyO/tQ3cdqOYGIDuHy60Yqg19rDUg2uwaTbS7BkDMh9vcvbzp0UN5DwQbQkNWKvI/1VEqo4PYz
	Zl/CwzU3qpc=
X-Google-Smtp-Source: AGHT+IG3lvxhqeU5NQoIV693sptWY17DuxmthBKtpR0/yKhINIVjMqgDwkt9ti/ajyBkBH1laU/v8A==
X-Received: by 2002:a17:902:c40c:b0:206:b7b2:4876 with SMTP id d9443c01a7336-211327ab5d1mr5717115ad.20.1730744216850;
        Mon, 04 Nov 2024 10:16:56 -0800 (PST)
Received: from google.com (146.254.240.35.bc.googleusercontent.com. [35.240.254.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057cf273sm63173085ad.239.2024.11.04.10.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:16:56 -0800 (PST)
Date: Mon, 4 Nov 2024 18:16:48 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <ZykPkEuv70SXKiT-@google.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-2-praan@google.com>
 <20241024131147.GG30704@willie-the-truck>
 <Zxp9kHerb-ln4ioO@google.com>
 <CAE2F3rAtg_dE2NpFM-xB8fs3W+_7tANnBdA00SVfKgk-y6X5Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rAtg_dE2NpFM-xB8fs3W+_7tANnBdA00SVfKgk-y6X5Gg@mail.gmail.com>

On Mon, Nov 04, 2024 at 09:23:31AM -0800, Daniel Mentz wrote:
> On Thu, Oct 24, 2024 at 10:02 AM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Thu, Oct 24, 2024 at 02:11:48PM +0100, Will Deacon wrote:
> > > On Fri, Oct 18, 2024 at 06:00:20PM +0000, Pranjal Shrivastava wrote:
> > > > +struct arm_smmu_event {
> > > > +   struct arm_smmu_device          *smmu;
> > > > +   u8                              id;
> > > > +   u8                              class;
> > > > +   u16                             stag;
> > > > +   u32                             sid;
> > > > +   u32                             ssid;
> > > > +   u64                             iova;
> > > > +   u64                             ipa;
> > > > +   u64                             raw[EVTQ_ENT_DWORDS];
> > > > +   bool                            stall;
> > > > +   bool                            ssid_valid;
> > > > +   bool                            privileged;
> > > > +   bool                            instruction;
> > > > +   bool                            s2;
> > > > +   bool                            read;
> > > > +};
> > >
> > > minor nit, but it might be worth seeing what pahole says about the
> > > layout of this structure in case you've got a bunch of wasted padding
> > > thanks to the mixed-size fields.
> >
> > I ran pahole with this, looks like there's only one 4-byte hole but the
> > cacheline aligment is bad (for a 64-byte cacheline):
> >
> > struct arm_smmu_event {
> >         const char  *              master_name;          /*     0     8 */
> >         struct arm_smmu_device *   smmu;                 /*     8     8 */
> >         struct device *            dev;                  /*    16     8 */
> >         u8                         id;                   /*    24     1 */
> >         u8                         class;                /*    25     1 */
> >         u16                        stag;                 /*    26     2 */
> >         u32                        sid;                  /*    28     4 */
> >         u32                        ssid;                 /*    32     4 */
> >
> >         /* XXX 4 bytes hole, try to pack */
> >
> >         u64                        iova;                 /*    40     8 */
> >         u64                        ipa;                  /*    48     8 */
> >         u64                        raw[4];               /*    56    32 */
> >         /* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
> >         bool                       stall;                /*    88     1 */
> >         bool                       ssid_valid;           /*    89     1 */
> >         bool                       privileged;           /*    90     1 */
> >         bool                       instruction;          /*    91     1 */
> >         bool                       s2;                   /*    92     1 */
> >         bool                       read;                 /*    93     1 */
> >         bool                       ttrnw;                /*    94     1 */
> >         bool                       ttrnw_valid;          /*    95     1 */
> >
> >         /* size: 96, cachelines: 2, members: 19 */
> >         /* sum members: 92, holes: 1, sum holes: 4 */
> >         /* last cacheline: 32 bytes */
> > };
> >
> > I don't think we can do much about the 4-byte hole as the members occupy
> > 92 bytes only. I assume a single 4-byte hole shall be fine?
> >
> > However, for cacheline aligment we can move the 3 top pointer-members,
> > `master_name`,`smmu` & `dev` which improves the cacheline aligment:
> 
> Can you be more explicit about what is a good cacheline alignment? I'm
> wondering if you're trying to ensure that raw[4] is contained within a
> single cacheline as opposed to spanning two adjacent cachelines. I

I'm using a tool `pahole` [1] as suggested by Will earlier.
The tool prints information about the layout of structures, checking for
memory wastage due to padding and if the struct layout causes
mis-alignment with the caches.

The tool printed, "cacheline 1 boundary (64 bytes) was 24 bytes ago"
hinting that with the current layout, we are wasting 24-bytes of a
cacheline.

> doubt that this is worth optimizing for. Also, I'm wondering if this
> analysis assumes that the base address of a struct arm_smmu_event
> instance is cacheline aligned, which I am not sure is the case. I
> would solely optimize for size.

You're right, the tool does assume that the struct begins at a cacheline
I'm just sharing the analysis done by the tool to be able to finalize
the layout of `struct arm_smmu_event`.

IMO, if we don't have a strong opinion about this, there's no harm in
trying to layout the struct better even if it is a micro-optimization.

Although, I agree that size was the main concern here but if we have a
92-byte structure with 64-bit fields, we'll always have a 4-byte hole.

If we remove the `smmu` & `master_name` fields and pack all bools in
bitfields as discussed earlier, we'll have a size of 69 bytes,
(92 - 16 - 8 + 1), thus, we'd need a padding of 3 more bytes. Hence, the
size would be reduced to 72-bytes from 92-bytes. I guess, that's fine?

Thanks,
Praan
