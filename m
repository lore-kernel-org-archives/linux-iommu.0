Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33732882D6;
	Wed, 23 Sep 2026 01:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790126874; cv=none; b=lMd9dn73HnshOhlnHvtaodd/LyuaqY0egBxWUNgTbjw0DldMpogYaxYeygQDHY72Md0J+B91AVaLeXiRU7yNU/WfiwlpPEu9AtHt/XUmSl3itN9XB97WifhwSOP5Z+Plj5hQKa8v+aqlz48ITQYWJ+BhszWC0fFIW7Eg5lM81Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790126874; c=relaxed/simple;
	bh=6lXYIkXsCGhMWgdtU2+XGolZIjsRdbNYIm2VlwRF74Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KB1KLIEKkjuRNYgxQ9iVVYKBFlTMtC17jKkf7xWCK/l7v2ODe6XVxnutzXi0gtmFaFuDDw0RNVJP/7e7vwqy6csvxHbqwABZwaGVYW/jH9dr23rzF61PXv1dG9WJcLvEb26EIJZkc41lGrMsza7V15E7VXK6Dbap5z4H8cjKmhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7/yIza1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7/yIza1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C361F000FF;
	Wed, 23 Sep 2026 01:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790126873;
	bh=/08pGxKrLgqH3ERhly0BGeg2r9Qnfihq7jzAwh7thOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b7/yIza17KoIcJbVW0SsFsnrIaYGmaENCr/JDYQjp8vTfW1wZkKyvNUuDwSPHTsVN
	 J03clZlPkW+FFdJZL3rngToL60D8ryQsTIBkQRHLzLj4D7XGdzLLazs5MaGAP6pOw8
	 3Xa2LiY4xTekH9Hj/3CucNkLh0Lc4zl1fTaJnIKCFzcm17a4v56sfQ2+oH2+5/IfI+
	 zhyu1zRMbKsX6K/EAZP7SY8hrXzrcphiH08wUIffWzdhq4G3gtPMxgWhFNItxFhtj7
	 5MFZXax+40tDUFcoQMvzoiCdm4R0XcLUYGjUkIsHdgXZ2TmWqgtZb8hg6ds9WkV4/D
	 N2Ipq9+eLp1mQ==
Date: Tue, 22 Sep 2026 18:27:51 -0700
From: Drew Fustini <fustini@kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, babu.moger@amd.com,
	baolin.wang@linux.alibaba.com, ben.horgan@arm.com, corbet@lwn.net,
	cuiyunhui@bytedance.com, Dave.Martin@arm.com, james.morse@arm.com,
	jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com,
	palmer@dabbelt.com, pjw@kernel.org, reinette.chatre@intel.com,
	robin.murphy@arm.com, shuah@kernel.org, tomasz.jeznach@linux.dev,
	wangzhou1@hisilicon.com, will@kernel.org, xiaqinxin@huawei.com,
	yuanzhu@bytedance.com, zengheng4@huawei.com,
	zhangzhanpeng.jasper@bytedance.com, x86@kernel.org,
	iommu@lists.linux.dev, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: Resctrl and I/O
Message-ID: <arMrF51oJAXJrikO@thelio>
References: <arKx__kOPe4B5gDW@agluck-desk3>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arKx__kOPe4B5gDW@agluck-desk3>

On Tue, Sep 22, 2026 at 09:51:11AM -0700, Luck, Tony wrote:
> Patches for ARM[1] and RISC-V[2] are both at RFC status.
> 
> They appear to be based on similar h/w capabilities where architecture
> specific tags can be added to transactions from I/O devices by the IOMMU
> servicing the device. Device enumeration is handled outside of the resctrl
> file system.

Thanks for starting a discussion on this topic.

> RISC-V description of "architecture specific device tokens" sounds great.
> I'll have to find some ares of /sys to provide the mapping of tokens to
> "device groups". There's no association with IOMMUs, so this will be some
> other path in /sys. Perhaps under /sys/firmware/acpi since the data comes
> from ACPI IRDT table.

resctrl could parse iommu_group:<id> itself which should cover the IOMMU
case on ARM and RISC-V. Maybe other prefixes could be passed on to arch
code?

> Need an info file to tell users the format and source for device tokens.

I agree and it could list which token namespaces the platform uses.

> I'd like to avoid limiting resctrl monitoring of CPU activity due to the small
> number of I/O RMIDs. Perhaps don't include a "devices" file or mon_data/{i/o
> events} files in resctrl group directories when rdtgroup::mon::rmid >=
> num_io_rmids? But that feels clumsy.

There's no separate I/O ID space on RISC-V that could be smaller. The
IDs a device carries are the same IDs the hart (e.g. cpu) carries. The
number of RCIDs (e.g. CLOSID) and MCIDs (e.g. RMID) is a property of
each capacity or bandwidth (CBQRI) controller. The RISC-V IOMMU spec
also requires the IOMMU to support RCID and MCID at least as wide as any
hart.

Thanks,
Drew
