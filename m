Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2031CC893
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444907; cv=none; b=WuES+A7z0mnhCcFVwd+QGDnyPvSgUCzZtNVsztDswxr2C43bgoW+f+A+ccrwwuTGUV25wm2PByUU7kwdzug7O0FbdA0GXBXIJR+PY/4RXKvhzOcbzzO6RS/9YKoLGvR7BMeDUtTW6EFpy8OPQIy8GM/yGRAuusWtlAF4c5Pau+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444907; c=relaxed/simple;
	bh=447c9WT6teckQBQJvltrKhkPZMS/qgGYv9ZWRhnIWyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrC1nuhZj4L0uJmswI/90inVFAU5LMjdo0bn4V0eI8FCyLwoe+Ik9o+uJbMfOyn+lidEDm/oY8GOWi+lddwC5YHpakWqzfH0IyVjXY8uD83Oi9n2XkgcU3EVnzGXvD3qSKNLqnTJ7eHSdJHkxC0q+/Z+HpdisDCa38W1k/HASHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MhBU92WA; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MhBU92WA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=+B9uQV4kX5+BsKMZY2we/bUXq9xyN69t/NqTNdGYjJE=;
	b=MhBU92WAoqqebf8E9EOqTz+Rd3ELIOQkxH4lo3crHYeRGLMGBGwjDXaWDYS7v0
	G9m8gZmV5171KV+aW0G7sBKWxQFTP3W69Pe2x79+yFx6QeFYMfZ5jghPFZ5RdIaP
	+EsLHXTYOKvRbS74orpXARLEf70W9FttcBoa2h4Gaz9pE=
Received: from localhost (unknown [120.26.85.94])
	by gzga-smtp-mta-g3-4 (Coremail) with SMTP id _____wDX38oTM9hmGKTsCA--.24645S2;
	Wed, 04 Sep 2024 18:14:43 +0800 (CST)
Date: Wed, 4 Sep 2024 18:14:43 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: dwmw2@infradead.org, baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Fix 'Null pointer dereferences' issue
Message-ID: <ZtgzE73M49BnMHYh@iZbp1asjb3cy8ks0srf007Z>
References: <20240903144601.8149-1-qianqiang.liu@163.com>
 <3159e4ba-1c39-4a79-a844-c52c08fe41b9@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3159e4ba-1c39-4a79-a844-c52c08fe41b9@linux.intel.com>
X-CM-TRANSID:_____wDX38oTM9hmGKTsCA--.24645S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw15urWDuF1UZr47CFyrtFb_yoW8Gr48pr
	WxGFyIkFW5Jry8GFnrZwnFyFW5K34DCa4S9FyYq398u3sFvFyxtr929FWfuF1kXrs5JF1a
	v3W8JFWxCFZ8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ja388UUUUU=
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiLxlQamVOGGbbNwAAs1

Hi Ethan,

No, I don’t hit any issues so far.
It was scanned by Coverity, and I tried to fix it.
If you think it's not an issue, we can just ignore it.

On Wed, Sep 04, 2024 at 05:49:49PM +0800, Ethan Zhao wrote:
> 
> On 9/3/2024 10:46 PM, Qianqiang Liu wrote:
> > Passing null pointer "pdev" to "pci_enable_pasid", which dereferences it.
> > Check the "pdev" is null or not before passing to "pci_enable_pasid".
> > 
> > Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 9f6b0780f2ef..a1e54f334330 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -3935,7 +3935,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
> >   	 * So always enable PASID support on devices which have it, even if
> >   	 * we can't yet know if we're ever going to use it.
> >   	 */
> > -	if (info->pasid_supported &&
> > +	if (info->pasid_supported && pdev &&
> >   	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))
> 
> You hit any issue with specific ver kernel ? seems impossible to hit
> such NULL pointer issue with the latest kernel for which you sent
> this patch.
> 
> Thanks,
> Ethan
> 
> >   		info->pasid_enabled = 1;

