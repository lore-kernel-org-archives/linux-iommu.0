Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A0719DF62;
	Wed, 10 Dec 2025 21:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765400658; cv=none; b=fMRsz87uCBEmCDIyf7P7Rci5FKqxrmHaonABf7Lx0rFx3siqyVL6gxMGrekniLwA0eiY6NnhloHp65dpQnhbYN6XApCLbNNi4C3SoVzH+qzXJbx3oyi6WQimXXSR4w2WzPNO+NZM7RgyfsxrNM4GRvGqS2Gy8j4rkJCqCmIzaQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765400658; c=relaxed/simple;
	bh=Qs4b3z1pm0ndIdr4UcDS2LE1LcsKzBmrdvQ17Sx/6EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SH4HX0hX+LSZs1aFZP0yw/+YDlIZWW5U6Fhj66SMCQ6xRTpwSkVWBD7Y08iqdcd/QCQnt03p6RKTr19zixh3Xzn8giuRL+RifbQM40YKmsoXlhImGyUlbMK4N8RDm9iFuTUE8o6ToE8GhIPdQkQk+D2hezvBDqB7UjbH+xMbSgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jP5Zfoic; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jP5Zfoic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8625C4CEF1;
	Wed, 10 Dec 2025 21:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765400658;
	bh=Qs4b3z1pm0ndIdr4UcDS2LE1LcsKzBmrdvQ17Sx/6EE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jP5ZfoicM9N+3tiTUpWMH9mGWtrC5oyPW81SRPOwyz/9Lj4KBEAu6yXKuQSxAuqym
	 zFyG0F38lsblWg1Gx5DD3VzMvmeruRwBLtkhkUPkOFWwgrM7leb5yFSu7W1Cfr8JQk
	 9UE5Z2Y3fjabVKbo9DKvnnXyYYjQ0cExmWFXqTgWItgpjr2va2cwAvz3xcOFt6ZhoI
	 rLTyRdhCcJDa2XdFXVDaFJ2BeBN5Yz79NWuRXbgp61AFlJdXCAprEpAv2L0qE9niCU
	 C4endY8NgKQAXP1GQ4NxutwpkNy7WweVSimARqP/gu5qUwqlwfJyVzs+W8uk7vJn/E
	 q8O7hRqp1v9nQ==
Date: Wed, 10 Dec 2025 15:04:14 -0600
From: Rob Herring <robh@kernel.org>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
	bjorn.andersson@oss.qualcomm.com, bod@kernel.org,
	conor+dt@kernel.org, krzk+dt@kernel.org,
	charan.kalla@oss.qualcomm.com, prakash.gupta@oss.qualcomm.com,
	vikash.garodia@oss.qualcomm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] of: Respect #{iommu,msi}-cells in maps
Message-ID: <20251210210414.GA3329469-robh@kernel.org>
References: <20251204095530.8627-1-vijayanand.jitta@oss.qualcomm.com>
 <20251204095530.8627-4-vijayanand.jitta@oss.qualcomm.com>
 <20251209201725.GB1015230-robh@kernel.org>
 <a0a5cf96-70fe-4005-a100-58ae0b72b4cd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0a5cf96-70fe-4005-a100-58ae0b72b4cd@oss.qualcomm.com>

On Wed, Dec 10, 2025 at 03:57:56PM +0530, Vijayanand Jitta wrote:
> On 12/10/2025 1:47 AM, Rob Herring wrote:
> > On Thu, Dec 04, 2025 at 03:25:30PM +0530, Vijayanand Jitta wrote:
> >> From: Robin Murphy <robin.murphy@arm.com>
> >>
> >> So far our parsing of {iommu,msi}-map properites has always blindly
> >> asusmed that the output specifiers will always have exactly 1 cell.
> >> This typically does happen to be the case, but is not actually enforced
> >> (and the PCI msi-map binding even explicitly states support for 0 or 1
> >> cells) - as a result we've now ended up with dodgy DTs out in the field
> >> which depend on this behaviour to map a 1-cell specifier for a 2-cell
> >> provider, despite that being bogus per the bindings themselves.
> >>
> >> Since there is some potential use in being able to map at least single
> >> input IDs to multi-cell output specifiers (and properly support 0-cell
> >> outputs as well), add support for properly parsing and using the target
> >> nodes' #cells values, albeit with the unfortunate complication of still
> >> having to work around expectations of the old behaviour too.
> >>
> >> Since there are multi-cell output specifiers, the callers of of_map_id()
> >> may need to get the exact cell output value for further processing.
> >> Added support for that part --charan
> >>
> >> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> >> ---
> >>  drivers/iommu/of_iommu.c |   3 +-
> >>  drivers/of/base.c        | 107 ++++++++++++++++++++++++++++++---------
> >>  include/linux/of.h       |  17 ++++---
> >>  3 files changed, 94 insertions(+), 33 deletions(-)
> >>
> >> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> >> index eac62bc441c5..48759cf1d900 100644
> >> --- a/drivers/iommu/of_iommu.c
> >> +++ b/drivers/iommu/of_iommu.c
> >> @@ -45,10 +45,11 @@ static int of_iommu_configure_dev_id(struct device_node *master_np,
> >>  				     struct device *dev,
> >>  				     const u32 *id)
> >>  {
> >> -	struct of_phandle_args iommu_spec = { .args_count = 1 };
> >> +	struct of_phandle_args iommu_spec = {};
> >>  	struct of_map_id_arg arg = {
> >>  		.target = &iommu_spec.np,
> >>  		.id_out = iommu_spec.args,
> >> +		.map_cells = &iommu_spec.args_count,
> >>  	};
> >>  	int err;
> >>  
> >> diff --git a/drivers/of/base.c b/drivers/of/base.c
> >> index b8f78a9e6a09..68a7d6ddba66 100644
> >> --- a/drivers/of/base.c
> >> +++ b/drivers/of/base.c
> >> @@ -2045,11 +2045,30 @@ int of_find_last_cache_level(unsigned int cpu)
> >>  	return cache_level;
> >>  }
> >>  
> >> +/*
> >> + * Some DTs have an iommu-map targeting a 2-cell IOMMU node while
> >> + * specifying only 1 cell. Fortunately they all consist of length == 1
> >> + * entries with the same target, so check for that pattern.
> > 
> > Can you show what a bad entry looks like here.
> > 
> 
> Sure, will add an example in the comments. Basically it would look like below.
> 
> for iommu with iommu-cells  = <2>;
> 
> Device having below iommu-map property.
> 
> iommu-map = <0x0000  &smmu  0x0000  0x1>,
>             <0x0100  &smmu  0x0100  0x1>;
> 
> >> + */
> >> +static bool of_check_bad_map(const __be32 *map, int len)
> >> +{
> >> +	__be32 phandle = map[1];
> >> +
> >> +	if (len % 4)
> >> +		return false;
> >> +	for (int i = 0; i < len; i += 4) {
> >> +		if (map[i + 1] != phandle || map[i + 3] != cpu_to_be32(1))
> > 
> > Why does the IOMMU arg cell have to be 1? The description said 'same 
> > target', but it is just all have an IOMMU cell value of 1?
> > 
> 
> Here, the check is for length argument to be 1. This is to maintain backward
> compatibility as mentioned above, as all such bad entries right now have
> length as 1.

You say length and I think arg/cell length, not that the cell value 
contains a length. That's because generally cell args are provider 
defined and specific. So just say the 2nd cell has a value of 1 and 
leave out that's a length.

[...]

> >> @@ -1455,7 +1456,7 @@ static inline int of_map_msi_id(const struct device_node *np, u32 id,
> >>  		.id_out = id_out,
> >>  	};
> >>  
> >> -	return of_map_id(np, id, "msi-map", "msi-map-mask", &arg);
> >> +	return of_map_id(np, id, "msi-map", "#msi-cells", "msi-map-mask", &arg);
> > 
> > There are cases of no #msi-cells and we default to 0 cells in that case. 
> > Do you maintain that?
> > 
> > Rob
> 
> Thanks for pointing this, I see this case of no #msi-cells is not covered. Will
> add it in next revision.  Also, IIUC shouldn't we set default cells to '1' to
> maintain backward compatibility of of_map_id in this case ? No ?

The only default is 0. Perhaps msi-map is never used if there are 0 
cells? IDK, you tell me.

Rob
