Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993221552FA
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627329; cv=none; b=ckFGAgwiqtJvRs6JUaJ5rV7VPwonns9h7DeDiUq/Q4+HFxq4PARJci8X0tyKhypmvtgHudNtjH7wwAvyPIVNfcDDD1MyFamd6kWeM3tHkXYNHqZehp5f0XNOuTP0KMVZOaI2rgh3DyChGoHjjssaPFwHH1+64VNrFS5mWd16Sdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627329; c=relaxed/simple;
	bh=UVmiROn4eJIlVWV4bbqb1IOXlCLFfoLnm5/daV8XhR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOlg0MNXCHD1H9ugv+b/zXzgE+AHOsIP+otO9JgkFdo9iBYPX+9v/PNe2WvAR+Ero+jPslXbr8wO7JfR3fTfQIUw1xXlyVUiorEbyQqeHKpZqgaUPlnEaCo3oTvKJJ5Vcc1mpTYoNd+mDBgJ5ZEpIM/hbo89Y38/VD0MsConQII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPDT4eT3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPDT4eT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10D1C4CEC4;
	Fri,  6 Sep 2024 12:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725627329;
	bh=UVmiROn4eJIlVWV4bbqb1IOXlCLFfoLnm5/daV8XhR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPDT4eT3fX6kvBmQPY4OP3135rkBsy+Hx0rFM9nepE0oLpICBprkn8rZRxmjwMxVF
	 E/OL+SlEiGhHSGuv1okVttqp8tha6h8yo4D1o3DuWUC5e6SW5KuIPcp5dAVPujaIsh
	 GT0b3q8ppOg6zEd2Brk2/ro5HXd7XZYo3JYzTAVeB/nCF65hKV2kiBgXUWFeY84vHY
	 mEN60NK8sGXPknfrFcAVwBu9Mt0iT0yzd4aqBsRi2wuXrc9U2Jl9gFUFjx8dgUO/Y0
	 ql3gbSjKUeFO3/0z6erK4DWvaqYuv6zkwS6oZOCXGJ5VwjsmGRvpQr8fzxM6/Up01+
	 MDDpN7msbKELw==
Date: Fri, 6 Sep 2024 13:55:24 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <20240906125524.GA16773@willie-the-truck>
References: <20240827193026.3993039-1-praan@google.com>
 <20240827193026.3993039-2-praan@google.com>
 <ZtAW0hVPFD6JbLTL@Asurada-Nvidia>
 <ZtEKMknbGaD9q170@google.com>
 <ZtEkUQ7tI3Nb0NOc@Asurada-Nvidia>
 <ZtV1-IL8AZu--jGp@google.com>
 <ZtZEFKnKasX6433r@Asurada-Nvidia>
 <ZtnXADX3b6qdqVs0@google.com>
 <ZtphFYr1jUhHOSnC@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtphFYr1jUhHOSnC@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Sep 05, 2024 at 06:55:33PM -0700, Nicolin Chen wrote:
> On Thu, Sep 05, 2024 at 04:06:24PM +0000, Pranjal Shrivastava wrote:
> 
> > > > > > Also, the printing would become
> > > > > > more complicated as we'd have to log different fields for different
> > > > > > events. Additionally, I don't see that many unions being defined
> > > > > > elsewhere in the kernel.
> > > > >
> > > > > OK. That's a fair point. I think we could have just one common
> > > > > union for the "good stuff" fields. Then, if something isn't in
> > > > > the common union, do a FIELD_GET(raw)?
> > > > >
> > > >
> > > > I'm not sure if I get this right, but are you suggesting something like:
> > > >
> > > > +struct arm_smmu_event {
> > > > +       union {
> > > > +       u64 raw_evt[4];
> > > > +       struct {
> > > > +               /* "Good stuff" fields */
> > > > +       };
> > > > +};
> > > >
> > > > and then based on the fault type we can use the "good stuff" or raw_evt?
> > > > So, basically just add a union between raw_evt and the other fields to
> > > > improve struct arm_smmu_event present in v2?
> > >
> > > Yea, I attached a test code at the EOM for your reference. Please
> > > feel free to drop fields if they aren't common enough, and confirm
> > > those bits are correctly written too.
> > >
> > 
> > Hmm, so you're suggesting to make the event a union instead of a struct
> > thus, making reading event fields easy.
> > 
> > The only thing I'm slightly worried about is if the bitfields don't
> > remain constant if more events are added in the future.
> > 
> > For example, the "IPA" field is in dword[3] for now, but if it changes
> > in the future, it may get difficult to scale the union for future events
> > If we can guarantee that it doesn't happen then I think union is better.
> 
> I believe HW has its own reason to put those fields constantly
> following the same pattern, and must have its tendency to keep
> in that way.
> 
> The "union { u64 raw; struct {} }" way isn't that uncommon in
> the kernel, here are a few existing examples:
> 	drivers/crypto/marvell/octeontx2/otx2_cpt_hw_types.h
> 	drivers/crypto/cavium/nitrox/nitrox_req.h
> 	include/asm-generic/hyperv-tlfs.h
> 
> Taking a step back, if one field in a new event in the future
> happens to be odd, we could still fetch field in its own way:
> event->evt[4] is still available to extract via FIELD_GET; or
> just define another union exclusively for that event, neither
> of which sounds like the end of world.
> 
> Having said that, I'd defer to Will. So, here is just my two
> cents.

My only real concern is the fragility of using bitfields. I don't _think_
the compiler is obliged to lay them out in the obvious way and I can't
think of anything worse than being given a bad pretty-print when debugging
a real driver issue!

Will
