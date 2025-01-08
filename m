Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66861F7580;
	Wed,  8 Jan 2025 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348852; cv=none; b=GytKgP6Fccg4jc1U13aDkQMK47ogsaevzbXUzl2YbpXg8AQtEmqfroqvhm3xgkEBUjeaQ+rbAveZYFjj9O0q9FeGjSsUKgnrTplKOb1mIssi/N4PYeP4snbASX0uoSvkwW0ZkdiqBYafJST06wjO7/VBxjJgpF2CRxOlnIipDFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348852; c=relaxed/simple;
	bh=6kKI+ZZjIPBF7ralqB98Yh3wcIovpUpRBoUWQ1FiHdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELoFXumRCfU7GMWlX5W+sgAcfF2N7gn0h+1HiPcIIqEjUOOaDepDf97My+kIFcile+UFfBfwZEiy/+wv8EDn2bI2D+MQx//gYguqngrqP222nQU/h+Hnoe0iF+dpuO7JlgHz8M+CD/KZSeUZbPR+9R0vlG7dE5AJjTCfPXyNn6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ls0/cX0h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ls0/cX0h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFB2C4CED3;
	Wed,  8 Jan 2025 15:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736348851;
	bh=6kKI+ZZjIPBF7ralqB98Yh3wcIovpUpRBoUWQ1FiHdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ls0/cX0hzOYLDYZQcy8hvplpbsIg0M3XtD3I+tfAi9zo6dbFHOxo+tthnkOFW+KnE
	 U+igBR4F2WbmhYQkxWti4FyS6TWSoXzr35STmLHBxwJvlYqcZNEtrlv/dPUoE3VmjG
	 hKB6PQCj5SYOxMPVFdgAta5ch/eXa+61UfNTKMx66fpXTYCiA8Pm4g8Rbsu/+D81FW
	 h7FtjEkz00iICDeaPROmlZTCjEx+pIu4/xwa4OghMeJs/WrA5yPeTAFQS0VxXHKy42
	 nDnOJSOvlMxKi2lvAgIGf1wbeTz8u5x7/cb3rDobCxT8YD4nZeKpcDUracWbufct3r
	 kkUhjbtolvHug==
Date: Wed, 8 Jan 2025 08:07:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Adrian Huang <ahuang12@lenovo.com>, Christoph Hellwig <hch@lst.de>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX
Message-ID: <Z36UsE5dj6j5HhkX@kbusch-mbp>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>

On Wed, Jan 08, 2025 at 03:38:53PM +0100, Thorsten Leemhuis wrote:
> [side note TWIMC: regression tracking is sadly kinda dormant temporarily
> (hopefully this will change again soon), but this was brought to my
> attention and looked kinda important]
> 
> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> Adrian, Christoph I noticed a report about a regression in
> bugzilla.kernel.org that appears to be caused by a change you too
> handled a while ago -- or it exposed an earlier problem:
> 
> 3710e2b056cb92 ("nvme-pci: clamp max_hw_sectors based on DMA optimized
> limitation") [v6.4-rc3]

...
 
> > The bug is triggered by the patch "nvme-pci: clamp max_hw_sectors
> > based on DMA optimized limitation" (see https://lore.kernel.org/linux-
> > iommu/20230503161759.GA1614@lst.de/ ) introduced in 6.3.7
> > 
> > To examine the situation, I added this debug info (all files are
> > located in `drivers/nvme/host`):
> > 
> >> --- core.c.orig       2025-01-03 14:27:38.220428482 +0100
> >> +++ core.c    2025-01-03 12:56:34.503259774 +0100
> >> @@ -3306,6 +3306,7 @@
> >>               max_hw_sectors = nvme_mps_to_sectors(ctrl, id->mdts);
> >>       else
> >>               max_hw_sectors = UINT_MAX;
> >> +     dev_warn(ctrl->device, "id->mdts=%d,  max_hw_sectors=%d, 
> >> ctrl->max_hw_sectors=%d\n", id->mdts, max_hw_sectors, ctrl->max_hw_sectors);
> >>       ctrl->max_hw_sectors =
> >>               min_not_zero(ctrl->max_hw_sectors, max_hw_sectors);
> > 
> > 6.3.6 (last version w/o mentioned patch and w/o data corruption) says:
> > 
> >> [  127.196212] nvme nvme0: id->mdts=7,  max_hw_sectors=1024, 
> >> ctrl->max_hw_sectors=16384
> >> [  127.203530] nvme nvme0: allocated 40 MiB host memory buffer.
> > 
> > 6.3.7 (first version w/ mentioned patch and w/ data corruption) says:
> > 
> >> [   46.436384] nvme nvme0: id->mdts=7,  max_hw_sectors=1024, 
> >> ctrl->max_hw_sectors=256
> >> [   46.443562] nvme nvme0: allocated 40 MiB host memory buffer.

It should always be okay to do smaller transfers as long as everything
stays aligned the logical block size. I'm guessing the dma opt change
has exposed some other flaw in the nvme controller. For example, two
consecutive smaller writes are hitting some controller side caching bug
that a single larger trasnfer would have handled correctly. The host
could have sent such a sequence even without the patch reverted, but
happens to not be doing that in this particular test.
