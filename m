Received: from mail-dy2-f31.google.com (mail-dy2-f31.google.com [74.125.229.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD284F7967
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790375974; cv=none; b=I4EgCiFIGGVsle9wCECcXWHR7sfr9gXcxKG5vx6SSp5pvId3iT01hN3uJQtGHSk2dPQ6HBQmwK4tP1aS8IRRd4iHUs29kHcmoy3CokeMUpPbTc+P5gEzGXbC250DG67t8ObflUCQ1jz0c+AXZOtkqgBXOQkzS/+/RP2wngNY90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790375974; c=relaxed/simple;
	bh=me77pkKrvSGAEQT18HPyfC1epxTLACdOfEDCrD5V6F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIAS+fWHUH+QCreXjNUGpfDyEMWdwmCVIQO7wCyt2je8j+xIlwYKBVF7p4q8s/XS31yyvGDKH2WQCSI82uJe0iMjxinp3d0D2vtAPlAtgFzdymLEXznb3QxUzQyxaZ9VKbBCMjow8mfXYexfiI5yqt/cXn+7LHEhsIa+/IkYlmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IiruR3Tu; arc=none smtp.client-ip=74.125.229.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IiruR3Tu"
Received: by mail-dy2-f31.google.com with SMTP id 5a478bee46e88-33c11ef641aso1636300eec.1
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790375970; x=1790980770; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2DkhnlaU8X97aKYc97FzNgp9vm+bQnZHirc2X/jss6k=;
        b=IiruR3TuZ3C14G0OreUU4FHFQe2Qa/TgJkVrwYZGkbDZcrnv88MBSbm5LW1K//yOus
         QjEaeYDcyGj8/I/KBFI4g+l7B06bXtX6SQCnTAkUD8eZsudMeHPQwiQJO2MWxnUzpzdm
         v2uQdrnvhM5/+EMMLyWWl08n98n62baMx+oM2yoxCo08Fh9mxrZYrTFRbJrZUXmLx/ry
         B9iV6qeBVig/KzCw7+2o5UzgD8O/e+Gd7l1xTlAhQ3AYYcafcLuRLruqsmi94OrY0FMH
         iuncWilIiZI7mUrrxhL5g3+XEUhCA1MUldDdkWTZG2YBRfm/2hSys77YuhJo9DcGPzSn
         JOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790375970; x=1790980770;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2DkhnlaU8X97aKYc97FzNgp9vm+bQnZHirc2X/jss6k=;
        b=HcpUYTiwBWeCg35TEXWdaYWhrVjTXoR587POkVdQYHyZuqMfXYaHQd9zY5GRkwxMRn
         4yXPOupyOb1MpRW3zKL2Z2lk/UwGmpOM4/5UfLdfh76KdwvnyRUlufZfhkPID/g6bI7C
         n91l239aPdU3oDJx/j3FklkuSpswGHCN8i5nteY35jCzHrkuJ8cZ0Jw3FxtJcJkA3HL2
         3rhXkI6IJ1H42mu/BLrjhJNodZyrnoBE/SqF4oc1IvCsVhPnTO9jB57+Jb8T+HWA734g
         5Pe3Z3dSZzylekkaSyaM57boilspougueJm9X0zxedJWPyqpB/D29jV0xAoV8sWf9ZMh
         V9Fw==
X-Forwarded-Encrypted: i=1; AKwUvBxLxpsdJfos0hMGAucjVuw/5XmPcLsiKcVeVt3tmvimQxfJmMDsutY+j/Hfq0IQcYAHRCOxJw==@lists.linux.dev
X-Gm-Message-State: AFuF++m64kM6D4SxDhXTV6e61biqtLbQjt0CiECJcLqkpfJ4Ve6GRSt7
	DcqkYkF38lN1FIrmjQKZBvGytXkkz4qeaTn9PGA38vHEly6hzYttSBy7RO4aF+m00Lo=
X-Gm-Gg: AYBFou1Cygx2+OmdvkHINASzIlwn79gThpoeSReLFEEbZnAOoN56hJ6Y1+wJXVRa+fR
	hxaI6FYgW/lAvphjY1jb3qtMOO+qbYp22KHjJZhOZFcYDhfjrzLbOe58f43dx6m0abQMTbPg0RQ
	2t7YL7ESSiZUHQjx8NCE59w48zEkGNjQP1vu0WumF4JYY0q3aJS5OKAJLARYg4MNqGy1onVXUgp
	rc6I7B3LB3saaeOeWBOJDElNuN45x6fq9oH6WXwTZiJkg1VtkuUsMLQVXPH7Oy88w3bjFg0RRx5
	ql6XjWzram1T1VEbMrXVrw1AtiNN5rt+bV0GpSnkx3HRxPPFmEkGaV+9G097uCwAR02AwqVxHNU
	JKb5ttAngYBkIDXhYOcJy451b0Q4J/zJM7IhHOvuQJOmg5aD05ua5cLx29YtJ/Goq6zpkSv+bni
	8xJCp31fj/i80FUeiGwxQP8cdosq+bDkO1w1DRs23RMnmy
X-Received: by 2002:a05:7301:7196:b0:341:d152:9cfe with SMTP id 5a478bee46e88-34272c5c768mr1133260eec.38.1790375970281;
        Fri, 25 Sep 2026 15:39:30 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414407ea69sm8644124eec.7.2026.09.25.15.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 15:39:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xAEZk-00000001mwH-2Nok;
	Fri, 25 Sep 2026 19:39:28 -0300
Date: Fri, 25 Sep 2026 19:39:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>,
	Jatin Kataria <jkataria@netflix.com>,
	Boqun Feng <boqunf@netflix.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Message-ID: <20260925223928.GE163130@ziepe.ca>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
 <20260924225018.GB16465@ziepe.ca>
 <arYf3iJW7hfTua__@8bytes.org>
 <20260925122848.GD163130@ziepe.ca>
 <4560d7d3-4d67-457d-bcd7-2176bd850bd4@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4560d7d3-4d67-457d-bcd7-2176bd850bd4@amd.com>

On Fri, Sep 25, 2026 at 08:11:41AM -0500, Mario Limonciello wrote:
> 
> 
> On 9/25/26 07:28, Jason Gunthorpe wrote:
> > On Fri, Sep 25, 2026 at 09:20:02AM +0200, Joerg Roedel wrote:
> > > On Thu, Sep 24, 2026 at 07:50:18PM -0300, Jason Gunthorpe wrote:
> > > > Why does the GPU driver have to request this? Why can't the iommu
> > > > driver know that this is a special device that can use this magic fast
> > > > path and then auto set it when identity is asked for?
> > > 
> > > This is a layering violation either way. Either the IOMMU driver needs to poke
> > > into device details and their relations or the device driver needs to poke into
> > > IOMMU details.
> > 
> > There are no device details, this is just a module option in the gpu
> > driver.
> 
> Well the GPU driver has knowledge whether it's a GPU inside of an APU to
> decide if it's valid.  That information is part of the discovery table
> setup.

Where was that in patch 2?

The right way for this to work is to quirk it through the iommu driver
so it can choose the fast mode, and not involve the GPU driver at
all. Like we've done for every other GPU weirdness. And AMD should be
making this work better by providing ACPI support so the iommu driver
can understand how it should work without inspecting PCI IDs.

> > > This is not perfect but to some degree unavoidable with these highly integrated
> > > SOCs.
> > 
> > This is exactly the sort of hacky thing ACPI should describe so the
> > drivers can just turn things on automatically.
> > 
> > Who is ever going to track down and figure out it is OK to set these
> > kinds of module options in the first place? There is general negative
> > sentiment in the kernel to doing things like this with modue options.
> > 
> > How does Windows do it? There certainly isn't a "module option" there?
> 
> This specific one I don't know; but these kinds of things usually end up in
> knobs in a UI that plumb some IPC deep into the driver stack.

Given the huge delta I somehow doubt that AMD would ship a windows
driver that defaults to "slow" ? Nor should linux...

Jason
