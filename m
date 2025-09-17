Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D45661
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136615; cv=none; b=aDU3sHMdHSSL0I66dpfMowGTHPFYkUgOymb9ssk92zZgl8O44nLpHjilAltFpL0McHGCaS/nmJ8mk/M2IF7DTa3I04dj0E/8S41G9ltFe3xqlhaukuw5rPe6mOwfrQV4cdvmhzRPQAh75zRcjDM6BpY/lbTzobYBRZkMnHU+kQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136615; c=relaxed/simple;
	bh=iyfzVXc6Veh38mNzCbeQ1OZ7FI7NlY18Cw8pOgMf9iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQLBAkxHFj/nkDBp3uey0dXEjoG5uWt8ieY1LkTr8X5AxvaNNXzPvPWuOsrlcMpbo6w2LzHpacZYVvlYisQzH0Ak7JIIoYbH2RiSwX5H5PGNTge2dqrniiJ6yXP7tIdA8dGOwVvyZC7Wu1p9ZcMG2Gosp3VBoIChU+BPSdReuKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hUeDu6M6; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUeDu6M6"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62fa0653cd1so143066a12.0
        for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 12:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758136611; x=1758741411; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ks/nBSck7Stoiu3lp2n8wjNWID3INEqmA7FA9e4kAW0=;
        b=hUeDu6M6fTsLSZ3eVLdesloJtV+5/UU8JLdFDK1bhj4OQKO7ahhKjvytFYLSXqVOW8
         o7aVXsnA61b71YUyu8hSk4UFFkQI2ayNisDof0VpBJia145hY8gJdqZTVcsbTRmJbyQ5
         /RRLerlOvocuIuDSN2jqqofwOgBm5/RjSxeI6eHbE7xQU0+X/Jp668BkAIyIlG97crY2
         0lEVcPJc38n4SoONkBZ2bOhuOp+gD5401DPxFXACdkbua15kALz0jTUfoAy/AM1G6TfU
         KziAeVQWz7HY8WpL3BPXkphzan4oQolxuFT96jtqvmQSF2o7QTVPLIXWSowOc9lhjuTx
         2J2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758136611; x=1758741411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ks/nBSck7Stoiu3lp2n8wjNWID3INEqmA7FA9e4kAW0=;
        b=tVfxosIZdUXF9nCIl5e2iiuoax3MqC98UNmBJ3Y79o5FFIemYyLh6XOCIx0vRU+Ph6
         NO38NQW+sgkjPi6+nSkTQomFdV4zda0PcvFtMycgWwV9lz5avyeRmZHY0sab6rxA3zVg
         sv0uSz3ELWdwZzF/XfUENVI14YIq9sRMDr6aWGJhbHAKEVN2u+D2z+5leITnrY5m0TFG
         4NAzt6U6QddIe5c5+StX0cy/r/XWVGD6cH27a9ZhaIgV/9EjksqkZJIIkgYpm4hifigs
         vfdsfz/rHfCykGOemgPYyiFMulKcLBG+vvFUpd2KyZU1twnKad4gjMngu3kg1HZprcbh
         Ev/g==
X-Forwarded-Encrypted: i=1; AJvYcCWnpyVtdHcElZNXzMIyLkTr0rSx4HoeQa5QmWPH0/j96Lkjtm9jjBzOrPCDhh0SB2ZFEgRTxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhjX1x3FA29Za1lMjEgtMtONOU7SmZ0+dJ7yjwFi3UKlGZXmdp
	4Ag4Q8hOxs64XYw/paqiHDqZN7GfHkQE9tN4m4KQfn2HHa4rvsWe9H9tVFFyySUBYDA=
X-Gm-Gg: ASbGncuYATucEBC//WK+aLHB8n9O3ki0TeLE+GeYkmqlpBFpIo5mnMrmP9nRfJ71PxS
	+C0tfe/P4DXq/Psu/Femouaaa0pVhqLxz1pKoyuMt7U4k0geetQOC9faEZveT4afFuk2XHhfnUJ
	Ly5Kk7aG1t4tmrmd8P/Wy8YdoZJtLM6/tQZtEx20JWyOgkjLEEfv+9y2uznFtj0jYjIDuTHqRKE
	u6a7QjaJ7ZtrFdSuhik7fCnJobkXaLqIZKHwn8KNo29hY+IeqiEYn/fBPK4RDHXZ8j71Wrj1op9
	+nhmWl+riqEXVwWyEEC03ZGB8w+9Hwq8mJIXpcK9z+SoEgYOBZpFJ+5Q8m7cXTaI71+Ir5V85Mn
	ZZWMh8CEj2BodZ7Z5rF44hGTEEsHlTZ4=
X-Google-Smtp-Source: AGHT+IHykcOXTk1a6tur651VWEsRLYVKfCQ0dvzLRtdYQ8gOpn4ZAYevIOYz/DJNbLAO5Jx7dvWoJg==
X-Received: by 2002:a05:6402:2755:b0:61c:1b27:56d4 with SMTP id 4fb4d7f45d1cf-62f8466118dmr3057422a12.35.1758136610657;
        Wed, 17 Sep 2025 12:16:50 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:4eea:42a:b97c:21a5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5d4357esm119697a12.23.2025.09.17.12.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 12:16:50 -0700 (PDT)
Date: Wed, 17 Sep 2025 21:16:46 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Enable use of all SMR groups when
 running bare-metal
Message-ID: <aMsJHheI6Y1V5q74@linaro.org>
References: <20250821-arm-smmu-qcom-all-smr-v1-1-7f5cbbceac3e@linaro.org>
 <aMAkJ7CfPQuhvhfm@willie-the-truck>
 <aMBJNzXpQTMg4Ncs@linaro.org>
 <d73e5026-ccb0-4a19-9742-099a0443f878@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d73e5026-ccb0-4a19-9742-099a0443f878@arm.com>

On Wed, Sep 17, 2025 at 07:02:52PM +0100, Robin Murphy wrote:
> On 2025-09-09 4:35 pm, Stephan Gerhold wrote:
> > On Tue, Sep 09, 2025 at 01:57:11PM +0100, Will Deacon wrote:
> > > On Thu, Aug 21, 2025 at 10:33:53AM +0200, Stephan Gerhold wrote:
> > > > Some platforms (e.g. SC8280XP and X1E) support more than 128 stream
> > > > matching groups. This is more than what is defined as maximum by the ARM
> > > > SMMU architecture specification. Commit 122611347326 ("iommu/arm-smmu-qcom:
> > > > Limit the SMR groups to 128") disabled use of the additional groups because
> > > > they don't exhibit the same behavior as the architecture supported ones.
> > > > 
> > > > It seems like this is just another quirk of the hypervisor: When running
> > > > bare-metal without the hypervisor, the additional groups appear to behave
> > > > just like all others. The boot firmware uses some of the additional groups,
> > > > so ignoring them in this situation leads to stream match conflicts whenever
> > > > we allocate a new SMR group for the same SID.
> > > > 
> > > > The workaround exists primarily because the bypass quirk detection fails
> > > > when using a S2CR register from the additional matching groups, so let's
> > > > perform the test with the last reliable S2CR (127) and then limit the
> > > > number of SMR groups only if we detect that we are running below the
> > > > hypervisor (because of the bypass quirk).
> > > > 
> > > > Fixes: 122611347326 ("iommu/arm-smmu-qcom: Limit the SMR groups to 128")
> > > > Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > > > ---
> > > > I modified arm_smmu_find_sme() to prefer allocating from the SMR groups
> > > > above 128 (until they are all used). I did not see any issues, so I don't
> > > > see any indication that they behave any different from the others.
> > > > ---
> > > >   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 27 +++++++++++++++++----------
> > > >   1 file changed, 17 insertions(+), 10 deletions(-)
> > > 
> > > Is the existing workaround causing you problems somehow? Limiting the SMR
> > > groups to what the architecture allows still seems like the best bet to
> > > me unless there's a compelling reason to do something else.
> > > 
> > 
> > Yes, the problem is the following (copied from commit message above):
> > 
> > > The boot firmware uses some of the additional groups, so ignoring them
> > > in this situation leads to stream match conflicts whenever we allocate
> > > a new SMR group for the same SID.
> > 
> > This happens e.g. in the following situation on SC8280XP when enabling
> > video decoding acceleration bare-metal without the hypervisor:
> > 
> >   1. The SMMU is already set up by the boot firmware before Linux is
> >      started, so some SMRs are already in use during boot. I added some
> >      code to dump them:
> > 
> >       arm-smmu 15000000.iommu: Found SMR0 <0xe0 0x0>
> >        ...
> >       arm-smmu 15000000.iommu: Found SMR8 <0x800 0x0>
> >       <unused>
> >       arm-smmu 15000000.iommu: Found SMR170 <0x2a22 0x400>
> >       arm-smmu 15000000.iommu: Found SMR171 <0x2a02 0x400>
> >        ...
> >       arm-smmu 15000000.iommu: Found SMR211 <0x400 0x3>
> > 
> >   2. We limit the SMRs to 128, so all the ones >= 170 just stay as-is.
> >      Only the ones < 128 are considered when allocating SMRs.
> > 
> >   3. We need to configure the following IOMMU for video acceleration:
> > 
> > 	video-firmware {
> > 		iommus = <&apps_smmu 0x2a02 0x400>;
> > 	};
> > 
> >   4. arm-smmu 15000000.iommu: Picked SMR 14 for SID 0x2a02 mask 0x400
> >      ... but SMR170 already uses that SID+mask!
> > 
> >   5. arm-smmu 15000000.iommu: Unexpected global fault, this could be serious
> >      arm-smmu 15000000.iommu: GFSR 0x80000004, GFSYNR0 0x0000000c, GFSYNR1 0x00002a02, GFSYNR2 0x00000000
> > 
> >      SMCF, bit[2] is set -> Stream match conflict fault
> >      caused by SID GFSYNR1 0x00002a02
> > 
> > With my patch this does not happen anymore. As I wrote, so far I have
> > seen no indication that the extra groups behave any different from the
> > standard ones defined by the architecture. I don't know why it was done
> > this way (rather than e.g. implementing the Extended Stream Matching
> > Extension), but we definitely need to do something with the extra SMRs
> > to avoid stream match conflicts.
> 
> I'm also a little wary of exposing more non-architectural stuff to the main
> driver - could we not keep the existing logic and simply add an extra loop
> at the end here to ensure any "extra" SMRs are disabled?
> 

It's not that simple at least, because some of these SMRs are used by
co-processors (remoteprocs) that are already active during boot and we
need to keep them in bypass until they are taken over by the drivers in
Linux. Any interruption inbetween could cause the remoteprocs to crash.

With my changes, the boot SMRs stay active (at the same index), because
there is an existing loop inside qcom_smmu_cfg_probe() that preserves
them as bypass:

	for (i = 0; i < smmu->num_mapping_groups; i++) {
		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));

		if (FIELD_GET(ARM_SMMU_SMR_VALID, smr)) {
			/* Ignore valid bit for SMR mask extraction. */
			smr &= ~ARM_SMMU_SMR_VALID;
			smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
			smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
			smmu->smrs[i].valid = true;

			smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
			smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
			smmu->s2crs[i].cbndx = 0xff;
		}
	}

We could "move" the SMRs > 128 to earlier indexes, but this also needs
to be done carefully in order to avoid:

 - Stream match conflicts, if we write the new entry before deleting the
   old one.
 - Unhandled transactions, if we delete the old entry before writing the
   new one.

Currently this can't happen, because we don't move any entries around.

We could do it similar to arm_smmu_rmr_install_bypass_smr() and add:

	/*
	 * Rather than trying to look at existing mappings that
	 * are setup by the firmware and then invalidate the ones
	 * that do no have matching RMR entries, just disable the
	 * SMMU until it gets enabled again in the reset routine.
	 */
	reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
	reg |= ARM_SMMU_sCR0_CLIENTPD;
	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sCR0, reg);

However, this would need to be done carefully only for the bare-metal
case, since I doubt Qualcomm's hypervisor will allow disabling all
access protections by setting CLIENTPD.

I can try implementing this, but the resulting code will likely be more
complex than this patch.

I realize it is weird to allow non-architectural features like this, but
I haven't found any indication that the additional SMRs work any
different from the standard ones. The SMMU spec seems to reserve space
for up to 256 SMRs in the address space and the register bits, as if it
was intended to be extended like this later. That's also why it works
correctly without any changes in arm-smmu.c: the bit masks used there
already allow up to 256 SMRs.

What do you think?

Thanks,
Stephan
