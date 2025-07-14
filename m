Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D199180B
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752487252; cv=none; b=UhDZ0lutMceMBb8nFXMKuizkXydulRQ/QG4h38jUJDMXCXPqg/b9mQ6mD3h1CnG7kvCtyQ8CZGS74g2+axCA8f6SvE/vvtV2Xr6JWTKNMPo5HO0wfgFgXc0fLjCkA+aWUligSV57FC7LYx+JHlTTuBhL+P+MZBSk+6VFZZIRBZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752487252; c=relaxed/simple;
	bh=VhGEkrY1EpSik14TyuXcM0wj3XqkY7zjFge7GwvvoEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ux7gJB5SD6bSrTTNYzovd4y1WWO8kvkwIDukwJkSNfYyOkn4L+S9EvvX6N0sC1G/7rgRw40xTRqT2zQpVudLy97B9L++/qPPKG/y3XRmNYA9wbFCgECDdtRgwbij4It2ruBtz9veFb9lq276qCxoEBIqJCy4qdY3MoeKySZR2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idvdZgKl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idvdZgKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FCFC4CEED;
	Mon, 14 Jul 2025 10:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752487252;
	bh=VhGEkrY1EpSik14TyuXcM0wj3XqkY7zjFge7GwvvoEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=idvdZgKlytrYrQScXs2nTJW/HFAmFMaacs70AM/1ijBEhhRKFQH1Oh3jqBfCej/dO
	 Nteae0mSyMSC4v7rVIk5CI/Tzp90crFFKBc5AlSdNCO0RRNK9MVklS3LUTTXKmrbpJ
	 am8AV+pBo9AMhp4otfrHnx46OPhLl2U38auYrVLT9yIS76DH1wq90OHJQCTNk3jyd1
	 vRM55RhuVEix0juieooYaO/SRJ63XfmbcsvOv/L7seHXmlOzQA0VxAhTA0bjpoD3i3
	 4/Fg1kHfJRks6mkGmHkLlXQvyHYBKA/KGWXkN+gIU4b3XXlE+4++aECnGDx8npRKzH
	 mgahlypnpSn0Q==
Date: Mon, 14 Jul 2025 11:00:47 +0100
From: Will Deacon <will@kernel.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
	iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: Off for two weeks
Message-ID: <aHTVT4SEEyZmDdIO@willie-the-truck>
References: <ojjm5wbqi44t5v2qo752u7q36uvbrda7au5coskjbnxgaom6t5@ebbfcm7zmwfa>
 <aHE4Vo7rJAQVkZsA@willie-the-truck>
 <551c46fd-d034-4b06-94a6-6080dc9b9600@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <551c46fd-d034-4b06-94a6-6080dc9b9600@linux.intel.com>

On Mon, Jul 14, 2025 at 01:12:38PM +0800, Baolu Lu wrote:
> On 7/12/25 00:14, Will Deacon wrote:
> > On Fri, Jul 11, 2025 at 04:39:46PM +0200, Jörg Rödel wrote:
> > > Just a note that I will be out for the next two weeks and not do any updates to
> > > the IOMMU tree.
> > 
> > Have a good break, Joerg!
> > 
> > > Will Deacon thankfully takes over during this time, so please
> > > send everything his way :) I will be back on July 28th.
> > 
> > I'll do a sweep of the list and pick up what I spot but if folks think
> > that I may have missed something, please just shout. I'll switch to
> > "fixes only" mode middle of next week, given where we are in the cycle.
> 
> Hi Will,
> 
> I didn't see this notice before sending the pull request of vt-d
> patches.

No problem! I was going to drop you a mail asking about that.

> https://lore.kernel.org/linux-iommu/20250714045028.958850-1-baolu.lu@linux.intel.com/
> 
> I cc'ed it to the iommu mailing list. If it happens not appear in your
> mailbox, please let me know, I will send a v2.

I'll grab it today, cheers.

Will
