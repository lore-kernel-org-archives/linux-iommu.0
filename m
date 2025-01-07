Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE051E25EB;
	Tue,  7 Jan 2025 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736281129; cv=none; b=BATyIm1hSPnOi1EQ6MwGy/CChdbyJRFkKXT8xemwPDs7Y2xdRGAt+pS/pRKrCQo0NVKwm9jVBiK1y0QS8B7HFwWVWPdaWAltKvQ13jEXilus4ghl9c9nsdGP6/vv1YnjFIY0bVQfracNJ85UIeqibfAZd6+VkfbUSo9ZCed4X20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736281129; c=relaxed/simple;
	bh=Xa5p5o5+qGct3Zl8MMzmVOZ88udDmLYBPY/u/BDhsy0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kpZK8oN8GdnMWYWFXRrFQAcXvy/daSouTetQDDiycX6OCJdfY5qQp233UMR1nkmrZgOp3He0HF9Tb2V3mccZIoVbuEr8SXWXwivre8lBwnjs6RZpATIS8weILYTQIOUu2fegJDQ+jld+EnDid19V40hfF2166Nzpltqwj7h/V7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuT7vtPt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuT7vtPt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4943C4CED6;
	Tue,  7 Jan 2025 20:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736281128;
	bh=Xa5p5o5+qGct3Zl8MMzmVOZ88udDmLYBPY/u/BDhsy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VuT7vtPtWzi9iiertRfwwTUJ8tk+GyPLLFY2Kv89i4CfIKO2RP/k8dpROTB/HrAA0
	 XOsRYnJhxOcMK4z18/s1rOU5w7rPuDGPvZpmNbpubMRgzQFEG5fgCmpQNU+JlzwnHr
	 16Qgs4G4AenkGg22mOeZbhVwW77f1LvkSk0UjKvHqcjNUBA95laK9IL5cUErRACarx
	 7LFpd5R/1yt0gVxWu1O4E18HU6Gq5cpdp2wN3RL2YA3/KOaYuQo5zD2JbvfS276OYJ
	 8q7Q7J318IUzQm9MZ0lQT85XAtxVHaYhBQ7eJl5OgS9OATq/5ysL5IUmi2bO78kbUU
	 z4HwOL+MYVoSg==
Date: Tue, 7 Jan 2025 14:18:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Srivastava, Dheeraj Kumar" <dheerajkumar.srivastava@amd.com>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, vasant.hegde@amd.com
Subject: Re: [PATCH v2 3/8] iommu/amd: Add debugfs support to dump IOMMU
 Capability registers
Message-ID: <20250107201847.GA179670@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ff7361-f5e6-467e-b027-bb2171d49d4f@amd.com>

On Tue, Jan 07, 2025 at 11:33:16AM +0530, Srivastava, Dheeraj Kumar wrote:
> On 11/27/2024 2:29 AM, Bjorn Helgaas wrote:
> > On Wed, Nov 06, 2024 at 01:16:34PM +0530, Dheeraj Kumar Srivastava wrote:
> > > IOMMU Capability registers defines capabilities of IOMMU and information
> > > needed for initialising MMIO registers and device table. This is useful
> > > to dump these registers for debugging IOMMU related issues.
> > > 
> > > e.g.To get capability registers value for iommu<x>
> > >    # echo "0x10" > /sys/kernel/debug/iommu/amd/iommu00/capability
> > >    # cat /sys/kernel/debug/iommu/amd/iommu00/capability_dump
> > 
> > Same comment here.  Why does this need to be so complicated to use?
> > Can't you make a single read-only file that contains all the registers
> > of interest?
> 
> Please do let me know your concerns and views on my comments in the
> previous patch.
> 
> With the implemented approach we do need separate files for mmio
> registers and capability registers input/output files as to
> understand if user input is mmio's offset or capability register's
> offset.

My comment is not about the difference between MMIO and config space
registers.  My concern is using two separate files to read the same
register.  That's inherently racy:

  UserA# echo "0x10" > /sys/kernel/debug/iommu/amd/iommu00/capability
  UserB# echo "0x20" > /sys/kernel/debug/iommu/amd/iommu00/capability
  UserA# cat /sys/kernel/debug/iommu/amd/iommu00/capability_dump

UserA expected to see the register at 0x10, but sees the one at 0x20
instead.

I think there's value in using a strategy similar to other IOMMU
drivers, e.g., intel.  But I'm not an IOMMU maintainer, so I'm just
kibbitzing here, and maybe your strategy is better.

Bjorn
