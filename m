Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C889C1DA631;
	Tue, 26 Nov 2024 20:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732654716; cv=none; b=DPfp/xuTfALHE74koKOVzpsd/VsRMSVcg8T02S+LWgH7RmiweYEfjORmQiVCfz72qc16RqQ+9h9Tn7vAHG+KIGs+JaHZM5Bc73QipeXRUc/yysqoBhRacwrWg7HPqemTCTTss0Ri2WRXRKXXO0fMTGDvr+la+8NeYeub1BM3xVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732654716; c=relaxed/simple;
	bh=8O2hKszepkS2sl+knMvKoTgyr2VnkgLcts+rvzU52Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OpLfJ9upRMS4qwhE1j5C0+IhorClRRU3ogt9ef9wKEN0olb3c6z7+mK7C7GVTbS07Ex+ep1K4TlCSMZKSh4JmaN92vNxkbnwHhWKW/dQu/mba2Bq0aFItvPwD3lNDSZ2Ue7BBPCDZNE5mn93ccPV9Ah/pHjfC3OQTMwD159hlZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjZseJfI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjZseJfI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C19FC4CECF;
	Tue, 26 Nov 2024 20:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732654716;
	bh=8O2hKszepkS2sl+knMvKoTgyr2VnkgLcts+rvzU52Rs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HjZseJfIzeBtDxWVVRK7ZHG8kwcvQOfWqGZwoZCoaPzzFOgs5/fN//L43IbDuxukG
	 6McSPPcI7fUCzq2Ha8Vt+RQU3tZ8BbHUa868hL+TlvBGaDsk5eTdK3LFPcXAZQ5fZo
	 YxEg+9f+BgMrD5Zypom+1/mXH2KRgH3R+bDNIFlHIZfGgNIGmdQ1upaF1BGy4yVxSu
	 dDT8yWxJ7Hu6eiidYndWJ9AeAPwYO+IZRPqkh8PhGF3vtKtYRDTsl+bx9Qd/+BCu8b
	 Q0krkL77s+aVj7SVlatas/PvEa9j7+ALjkb+JUF9MphM/u2z7p+KtMNMSJxdWudnG5
	 E3BeEaF+rwU/Q==
Date: Tue, 26 Nov 2024 14:58:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, vasant.hegde@amd.com
Subject: Re: [PATCH v2 2/8] iommu/amd: Add debugfs support to dump IOMMU MMIO
 registers
Message-ID: <20241126205834.GA2651046@bhelgaas>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106074639.2039-3-dheerajkumar.srivastava@amd.com>

On Wed, Nov 06, 2024 at 01:16:33PM +0530, Dheeraj Kumar Srivastava wrote:
> Analyzing IOMMU MMIO registers gives a view of what IOMMU is
> configured with on the system and is helpful to debug issues
> with IOMMU.
> 
> eg.
> 1. To get mmio registers value for iommu<x>

s/mmio/MMIO/ to match usage above.

>    # echo "0x18" > /sys/kernel/debug/iommu/amd/iommu00/mmio
>    # cat /sys/kernel/debug/iommu/amd/iommu00/mmio_dump
> 
> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> ---
>  drivers/iommu/amd/debugfs.c | 58 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
> index ff9520e002be..e56c050eb7c8 100644
> --- a/drivers/iommu/amd/debugfs.c
> +++ b/drivers/iommu/amd/debugfs.c
> @@ -15,6 +15,59 @@
>  static struct dentry *amd_iommu_debugfs;
>  
>  #define	MAX_NAME_LEN	20
> +#define	OFS_IN_SZ	8
> +
> +static int mmio_offset = -1;
> +
> +static ssize_t iommu_mmio_write(struct file *filp, const char __user *ubuf,
> +				size_t cnt, loff_t *ppos)
> +{
> +	struct seq_file *m = filp->private_data;
> +	struct amd_iommu *iommu = m->private;
> +	int ret;
> +
> +	if (cnt > OFS_IN_SZ)
> +		return -EINVAL;
> +
> +	ret = kstrtou32_from_user(ubuf, cnt, 0, &mmio_offset);
> +	if (ret)
> +		return ret;
> +
> +	if (mmio_offset > iommu->mmio_phys_end - 4) {
> +		mmio_offset = -1;
> +		return  -EINVAL;
> +	}
> +
> +	return cnt;
> +}
> +
> +static int iommu_mmio_show(struct seq_file *m, void *unused)
> +{
> +	if (mmio_offset >= 0)
> +		seq_printf(m, "0x%x\n", mmio_offset);
> +	else
> +		seq_puts(m, "No or invalid input provided\n");
> +
> +	return 0;
> +}
> +DEFINE_SHOW_STORE_ATTRIBUTE(iommu_mmio);
> +
> +static int iommu_mmio_dump_show(struct seq_file *m, void *unused)
> +{
> +	struct amd_iommu *iommu = m->private;
> +	u32 value;
> +
> +	if (mmio_offset < 0) {
> +		seq_puts(m, "Please provide mmio register's offset\n");
> +		return 0;
> +	}
> +
> +	value = readl(iommu->mmio_base + mmio_offset);
> +	seq_printf(m, "0x%08x\n", value);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(iommu_mmio_dump);

I think this would be much simpler and more user-friendly if you made
this a single read-only file to dump all the registers, as
/sys/kernel/debug/iommu/intel/iommu_regset does.  Having to write
"mmio" and then read "mmio_dump" makes it hard to use, and it means
that two users can race with each other and confuse things.

This is part of the AMD IOMMU driver, which should know what registers
are of interest and how to dump and possibly even decode them.

>  void amd_iommu_debugfs_setup(void)
>  {
> @@ -26,5 +79,10 @@ void amd_iommu_debugfs_setup(void)
>  	for_each_iommu(iommu) {
>  		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
>  		iommu->debugfs = debugfs_create_dir(name, amd_iommu_debugfs);
> +
> +		debugfs_create_file("mmio", 0644, iommu->debugfs, iommu,
> +				    &iommu_mmio_fops);
> +		debugfs_create_file("mmio_dump", 0444, iommu->debugfs, iommu,
> +				    &iommu_mmio_dump_fops);
>  	}
>  }
> -- 
> 2.25.1
> 
