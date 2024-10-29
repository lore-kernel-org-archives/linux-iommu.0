Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B61203719
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228031; cv=none; b=SeV0ySMgywsBR1uC53I55BCKkOkSmcTCAjgVEU0jFl8DD5iJoNHxy/w6GoBAfR1Tz8GbQjvNImbckjiocZ5a/MRDEzb6dVx9PJyKYF3tQzWv9Fl6hQMB+sm5DqXzHbuegN5bqAgzIDFieLw1vVTNwWi6FN1PrSB9NT90siU5M+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228031; c=relaxed/simple;
	bh=d4dntIrY8BzGXuOurIVemUjbRJ3uFpAYEFTj15wPzkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLctrdloKPpoe/A0NblZ06/fCO8K89UZqiHlrxmbWO/VPjKbd1NcBuOd3QD61fJvIWPsOa/nkgpSRqpxVpjs+0TDDDKto5NokvP0n7rKgLRm/rY2E0drEBbRLLSZEaMWTypdA63CJAgJ43JPRi4NfvCg/PVp4bgksbs+M8pT0AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iwr5wlrW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iwr5wlrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945A0C4CEE4;
	Tue, 29 Oct 2024 18:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730228031;
	bh=d4dntIrY8BzGXuOurIVemUjbRJ3uFpAYEFTj15wPzkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iwr5wlrWsYo8W5zs9ay8qhLF+91JC85AaqAfks91tMw009eA2L+TribMYk+0nqBLq
	 L62pLLToW2px+VeAHjsGD16/njdn6J3gnbbX/h9YkTSphpBzsmr9LM0yq1tRT9aopX
	 rH/8+O2k4CAcXFpcgw1B4Y3YBkQPRAM7ISyOOuPB4/OqgsJrgNlYonec6qbsWY/ONw
	 nN+LOchrTIMXa3ILWZeWOD4UhmUGfInka3aIVOyKBoEiH9/z/boTVspcEwV5LDCTH1
	 /NmQYn/G8QlJmdAbaE+pvn8rYXEFzOTxy0aOtQxB/4Mhd85p0S5a0wXQ8wuIB7c1Nz
	 t97puHX8kt4eg==
Date: Tue, 29 Oct 2024 18:53:46 +0000
From: Will Deacon <will@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 2/3] iommu/arm-smmu-v3: Log better event records
Message-ID: <20241029185345.GB5454@willie-the-truck>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-3-praan@google.com>
 <20241024131511.GH30704@willie-the-truck>
 <ZxpWUp8O6QXEe9xv@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxpWUp8O6QXEe9xv@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Oct 24, 2024 at 02:14:42PM +0000, Pranjal Shrivastava wrote:
> On Thu, Oct 24, 2024 at 02:15:12PM +0100, Will Deacon wrote:
> > On Fri, Oct 18, 2024 at 06:00:21PM +0000, Pranjal Shrivastava wrote:
> > > Currently, the driver dumps the raw hex for a received event record.
> > > Improve this by leveraging `struct arm_smmu_event` for event fields
> > > and log human-readable event records with meaningful information.
> > > 
> > > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > > ---
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 109 ++++++++++++++++++--
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  13 +++
> > >  2 files changed, 113 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index 2f1108e5de51..4477cf86cb8e 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -83,6 +83,34 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
> > >  	{ 0, NULL},
> > >  };
> > >  
> > > +static const char * const event_str[] = {
> > > +	/* Bad config events */
> > > +	[EVT_ID_BAD_SID_CONFIG] = "C_BAD_STREAMID",
> > > +	[EVT_ID_BAD_STE_CONFIG] = "C_BAD_STE",
> > > +	[EVT_ID_BAD_CD_CONFIG] = "C_BAD_CD",
> > > +	[EVT_ID_BAD_SSID_CONFIG] = "C_BAD_SUBSTREAMID",
> > > +	[EVT_ID_STREAM_DISABLED] = "F_STREAM_DISABLED",
> > > +
> > > +	/* Bad translation events */
> > > +	[EVT_ID_TRANSLATION_FAULT] = "F_TRANSLATION",
> > > +	[EVT_ID_ADDR_SIZE_FAULT] = "F_ADDR_SIZE",
> > > +	[EVT_ID_ACCESS_FAULT] = "F_ACCESS",
> > > +	[EVT_ID_PERMISSION_FAULT] = "F_PERMISSION",
> > > +
> > > +	/* Bad fetch events */
> > > +	[EVT_ID_STE_FETCH_FAULT] = "F_STE_FETCH",
> > > +	[EVT_ID_CD_FETCH_FAULT] = "F_CD_FETCH",
> > > +	[EVT_ID_VMS_FETCH_FAULT] = "F_VMS_FAULT",
> > > +	[EVT_ID_MAX] = NULL,
> > > +};
> > > +
> > > +static const char * const event_class_str[] = {
> > > +	[0] = "CD fetch",
> > > +	[1] = "Stage 1 translation table fetch",
> > > +	[2] = "Input address caused fault ",
> > > +	[3] = "Reserved",
> > > +};
> > > +
> > >  static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
> > >  				    struct arm_smmu_device *smmu, u32 flags);
> > >  static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
> > > @@ -1756,6 +1784,60 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
> > >  	return rb_entry(node, struct arm_smmu_stream, node)->master;
> > >  }
> > >  
> > > +static void arm_smmu_dump_raw_event(struct arm_smmu_event *event)
> > > +{
> > > +	int i;
> > > +	struct arm_smmu_device *smmu = event->smmu;
> > > +
> > > +	dev_err(smmu->dev, "event 0x%02x received: master %s:\n",
> > > +		event->id, event->master_name);
> > > +
> > > +	for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> > > +		dev_err(smmu->dev, "\t0x%016llx\n", event->raw[i]);
> > > +}
> > > +
> > > +static void arm_smmu_dump_event(struct arm_smmu_event *evt, struct ratelimit_state *rs)
> > > +{
> > > +	struct arm_smmu_device *smmu = evt->smmu;
> > > +	char title[100] = {0};
> > > +	char mastr[100] = {0};
> > > +	char addrs[100] = {0};
> > > +	char flags[100] = {0};
> > > +	char other[50] = {0};
> > 
> > I haven't followed previous versions of this series in detail, but
> > allocating 450 bytes on the stack for this seems excessive to me.
> 
> Hmm, I think we can reduce the title, mastr, addrs string to 50 chars
> and the `other` can be reduced to 30? Or maybe we can avoid printing the
> `stag` and `stall` fields altogether which should reduce it by 200 bytes
> We can save another 20 bytes by reducing the `flags` len to 80 bytes,
> overall saving us 220 bytes of stack space.
> 
> I introduced this in v3 [1] based on suggestions in v2 reviews [2].
> I can revert to the approach followed in v2 [3] as well.
> 
> LMK what's your vote?

Keeping the strings concise is one thing and we should do that regardless.
However, I'm questioning (a) why we need so many arrays rather than just
e.g. char linebuf[...] and (b) why it needs to be on the stack at all.

Will
