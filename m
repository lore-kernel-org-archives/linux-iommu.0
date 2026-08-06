Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724E3387375;
	Thu,  6 Aug 2026 05:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785993836; cv=none; b=BoGFM/z3ZCwMZY0950ukHcz0fISGivp4oZEF8QMnN9WmFPI1RXRP49S9jDIa2Kuq8sUQ3yukjLaVl6wSVyOFDgDqS/E3o3Xg/io34fNBS/mgs6JRNPPWaWmokC9Q+Gn8ZsqwD8ZV3Ugf2cNk6GRkQgQprjUQ3xLuE26Z6ejMGHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785993836; c=relaxed/simple;
	bh=LLzoqJ6iWkdaYWF6YDdx39wtk9QuB4fEWZpJHr04Xio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MG/dxTMYQm7fHHVnQK2gVuTDlNDQeCKbchxsgkopuVXf6OdAjwvPy4op3MYSVNlRB7pO306EkJke8XHgmSzkzhKBbfoUugsTVA12r6NXZvzeU0TNFEsIxPieZu3A0lmM1wgQGcJSNsPJySRcbaUJfsUWdKZ3P7cj31LL5DJKx9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxx1fg/O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxx1fg/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17B71F000E9;
	Thu,  6 Aug 2026 05:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785993835;
	bh=nGUsqZ9RJANQTX4cFkBlQkPsf7GNKP6d1ba13+NtzNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kxx1fg/O5f0UuVL1DBWUTFwB6czE67TjponNaQJ6hDBbO7K3J20+B+gtnpGtE2EHp
	 rAYyji6NuNaTUGeqF46kTwC2M7YbgXsjwKLvmeWuFfrx6RJwW8ThPiF9e3AlBewIdu
	 Yt58roYQMaKAnSMS6u4ntZnpmNXP5ntAEepXmcWQvZGKEvePNd8juzw+UHlNuwjUhc
	 +eg931sMy/6/d1swtuJORhOO74AZxy6WXG5pgjO/NGSCggG2H4xNnuYHqv/Ajilgby
	 dadyrRTqc3LSA0sWym7qXm1iqql6EANUinvBX3hPHY2ZA7RyixT1QTefSp8DKu0eCh
	 EkFhBAW/82RLQ==
Date: Wed, 5 Aug 2026 22:23:53 -0700
From: Drew Fustini <fustini@kernel.org>
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: ben.horgan@arm.com, xiaqinxin@huawei.com, zengheng4@huawei.com,
	palmer@dabbelt.com, tony.luck@intel.com, reinette.chatre@intel.com,
	tomasz.jeznach@linux.dev, will@kernel.org, robin.murphy@arm.com,
	pjw@kernel.org, aou@eecs.berkeley.edu, alex@ghiti.fr,
	Dave.Martin@arm.com, james.morse@arm.com, babu.moger@amd.com,
	corbet@lwn.net, shuah@kernel.org, jgg@ziepe.ca,
	kevin.tian@intel.com, cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: Re: [RFC PATCH 0/7] riscv: iommu: Add QoS ID support for resctrl
 device assignment
Message-ID: <anQaaQvpEXFTRYvS@x1>
References: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>

On Tue, Jul 14, 2026 at 09:06:50PM +0800, Zhanpeng Zhang wrote:
> This RFC extends RISC-V CBQRI/resctrl support to external requesters
> behind a RISC-V IOMMU.
[..]
> Open questions for this RFC:
> 
>   * whether a common resctrl "devices" file is the right ABI for
>     associating external requesters with a resource group;

I think a separate file is the right approach to avoid confusing iommu
groups with pids. 

I should note that James Morse had an ARM MPAM "extras" tree [1] which
carried an iommu_group assignment interface, using the same
iommu_group:<id> format, but writing it to the tasks file. However, Ben
Horgan clarified back in March [2] in a reply to Qinxin Xia that it is
no longer maintained. Ben also wrote that the interface would likely
change upstream. I've added Ben Horgan and Qinxin Xia to the CC list so
hopefully they can chime in.

I plan to review the patches in this series further but I didn't want to
delay any further in pointing out the above.

Thanks,
Drew

[1] https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot%2Bextras/v6.18-rc1
[2] https://lore.kernel.org/lkml/d13fdc75-b647-44f3-9657-d592353e8a1a@huawei.com/
