Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D2937A832
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656498; cv=none; b=ihtnrAHBfSftiRvnCVfJ/FgK5dP+bXyEd5+sKFkp+woN/myITcHuKSvpb01uxJ8EaScQE52zMDihgJwQVfD41VkvSXy9522cz62RMKBPxQurLiwpua40JlwpVkMnmTpJuV/2k+vHTUc6RLYotOyZszeUFhGIHLcO9pSyPY5SPhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656498; c=relaxed/simple;
	bh=5QCP3+8j+na07v88Li8T9o1YahfFEwfdrkmj0+NLdCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngIVCJ7xoMw8wm8yZzcIZl+94/DWK+rvFwPDZH8bZHVqi6dku7c2PYcl15cQmFli7jNuwXMBmV4w6vrw03wyleNwsLS18sX0HBs98OuP/hR8Ck8Yj/GHQS1eI6Wf3lvbRG3MHJ7WaqM6j3XL/jm4reHssOgqS/Q5UJ8cD81Ojyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DPkdlQlZ; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DPkdlQlZ"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910ca5aa8so76504685a.3
        for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789656486; x=1790261286; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3dWYS3ZZvJkfTmwwGBzOMGNsuxhzxqg/70St3SRcFJY=;
        b=DPkdlQlZBA5tp3VXj17pT+uhuxAkbSd9i6ULEOf2pN5SpMExewdJH5JeB6bgcaMH+a
         9KbxSFzjS/CNGlbZtntNtnCMAssKnXBmAh51DB5flHSrN0kq0JkCXpzr1crUrZ2B8ARO
         S30jw1XMDgisQ+kvEttdrCiRpAQ8yXmtckmAA7f280GVqfHPtZ3CnXTf3FhqEk3Gs7uw
         anzVDbWpQfOFb3hEahzBZuUpPCdPo7ClmRjeAos1VRSkmToYXyXHQ/6TlujguXi1Z6gE
         I2RaqDkq4hh9G/P3R9Ms2j4giBWjbn9lZUwFxElaCzbYj3xfuH4Zahty0V3rdxics/BD
         z6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789656486; x=1790261286;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3dWYS3ZZvJkfTmwwGBzOMGNsuxhzxqg/70St3SRcFJY=;
        b=ARt5V/UeMqFoNspm6MQ+Z36mGNZIHVL+ukktvrHmycMef0K5Q3Ca/2I/ReOZ8jWbba
         OE26xdhwPwhd/xp6907qL2wNu1Uvq+/Ec7DvRsYVfFttGT8NSl3YMXpp1S0QZGKB+wup
         /u6CE4efV9EMoDAvRYRoKkEqQ9knwpcIQP0CVBKs1Z/UK70r/0HfU9ziQRt8q2C1xsoQ
         VDxG8YcDCws0bw2tuJe19WD7EIyWq6kU/9RNBVig0GahDMcvZq52fu+9/N97rO+lLT/G
         MYgpJpKwPpyCxo/8X6rKJmuKffJWgCJ+zkF/zBoDVjoEL/KqCZqNPJiZ/J4d7+1bTI2Q
         O4Zw==
X-Forwarded-Encrypted: i=1; AKwUvBwB6WU7Fwb3BxiFaIT+jIRXSfqKxQPYbtXT09vtVrbFhjCTVz/n8VdeZL5qdS1bqWl4IRkqNQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mjJfppFdj+Q4OQxCexFtBS1ToGe0H5jRmO1kw8IyTE3oz2N3Yr
	vnBBODomoJWC8QbiSSJ1OSKM0PGNYnxV7gTqow9jTfcZYBx+TzGA26q/1F2rEl5Xaug=
X-Gm-Gg: AYBFou2HrjhzudEQXsHLgBHDDL7nlR8TluS4VPYX6dE0L5xOh3K/TwCfBnJ7OdYRvXC
	dtzdIkIhbtsjHxuevef1LsMUGIRH/OUOOOSwgURAEpub9W3vR+8wYLEu4W5UEBMGL/CWEimUdwB
	eZ87AWfAjrZi2uCuJbB68x325LPxxFpVxYm23v+Lrwbvwb09aHhPjhzc3dHD7f0Svrbi8sQA4C5
	BxOO05SP1Ee1HtXZNxYe6ALyc0AR4pyb7FGQppAGq8+m9px4xFB8ax4luzq/mBfgnk1Nkp63tix
	6mTS0hDdoQmQ3p58V4stT4+CoZ6gAzUH5ZFwMJd6DWR+nTfPEkQNwlEDFDafw0GCcgIAvJl8YUl
	4hjRkjxPxt8FGp4rLBqcqVgtMnRrgWRLy18+KcJh02s4nV+C1ncK0nTydg+Q7Wgqx0886F2EBzx
	P3R2Elk3ENazEwKbcSz+F2sssNFDXhRvYWVLvPSmFQDBdslqsceitqaug78bTvWld74cMf12tSX
	dYuNPblMmkiZeP5lXaIy4C0SoBF3qD+igo73d55fVFjOBBArCv7Lco9
X-Received: by 2002:a05:620a:800e:b0:939:5c62:fddd with SMTP id af79cd13be357-93bb772cd8cmr1243423385a.19.1789656485922;
        Thu, 17 Sep 2026 07:48:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b7821d231sm483562385a.21.2026.09.17.07.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 07:48:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x7DPA-0000000Ctlh-2V45;
	Thu, 17 Sep 2026 11:48:04 -0300
Date: Thu, 17 Sep 2026 11:48:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peng Fan <peng.fan@oss.nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC 0/4] iommu/arm-smmu-v3: Support shared Stream IDs
Message-ID: <20260917144804.GI3196566@ziepe.ca>
References: <20260916-smmu-shared-sid-v1-0-517384504aee@nxp.com>
 <20260916161018.GE3196566@ziepe.ca>
 <aqtDg1EH95RYOdCJ@shlinux89>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqtDg1EH95RYOdCJ@shlinux89>

On Thu, Sep 17, 2026 at 09:33:55AM +0800, Peng Fan wrote:
> Hi Jason,
> 
> On Wed, Sep 16, 2026 at 01:10:18PM -0300, Jason Gunthorpe wrote:
> >On Wed, Sep 16, 2026 at 11:12:33PM +0800, Peng Fan (OSS) wrote:
> >> Some SoCs have a limited number of IOMMU Stream IDs (SIDs) and
> >> hardware that inherently shares them. For example, the NXP i.MX95
> >> eDMA controller has 64 channels where each TX/RX pair is assigned
> >> a single SID by the hardware - the two channel devices are distinct
> >> from Linux's perspective but present the same SID to the SMMU.
> >
> >Is that a reflection of poor DT modelling though?
> >
> >Why must a TX/RX *PAIR* have two platform_devices nodes?
> >
> >Fix it there and you don't need any of this? Or is there more?
> 
> I think there may be a misunderstanding about the device topology here.
> 
> There is only one platform device node for the eDMA controller
> (dma-controller@42000000). There are no separate platform device nodes per
> channel pair.
> 
> What happens instead:
> The fsl-edma driver probes the single platform device. During
> dmaenginem_async_device_register(), the dmaengine core calls

Yes, and if your DT is correct then that platform device should have a
single iommus = [] listing all the SIDs for that logical device.

Using iommu-map to describe synthetic dma_chan_dev devices that the
kernel creates is the same kind of DT abuse from over here:

https://lore.kernel.org/linux-iommu/20260618151745.GD231643@ziepe.ca/

So the problem is self created, by using iommu-map instead of iommus
and using DT to describe linux SW expectations you end up in this
strange place of asking for aliases.

> The iommu-map property sits on the eDMA controller's DT node. At channel
> allocation time (xlate), the driver calls of_dma_configure_id(chan_dev,
> edma_np, true, &chan_id) to look up the channel index in the eDMA node's
> iommu-map and attach an IOMMU domain to that specific channel device. The
> dmaengine framework's dmaengine_get_dma_device() API
> (which checks chan->dev->chan_dma_dev) then returns the per-channel device
> instead of the parent platform device, so DMA clients map buffers through
> the correct IOMMU context.

So go back to the basics, why did this platform use iommu-map instead
of iommus? The only real difference is you get a DMA translation per
queue. Is that required? Are you short IOVA? Some other reason?

You can read what I wrote about this general problem before:

https://lore.kernel.org/linux-iommu/20260818130724.GA5482@ziepe.ca/

It would be really nice if you all could work together to figure out a
better way to handle this than through DT abuses.

If you really need unique translations per sub-compoment of a logical
device from some pool of SIDs that feels like a weird version of PASID
to me, it may be an interesting to explore.

Jason
