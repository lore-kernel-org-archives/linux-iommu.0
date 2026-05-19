Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0773369D51
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 23:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779231914; cv=none; b=tP1W5mZhk9SuagA75LHzL+NgJKUGOM6WARd3TlV89zsDpRH2HnnQ/xfES6t2FlFDDjOzIyuiilrRY5LM+aZ10oCQ0G292zgod+yuAhad6+eD6LKLdY+hy52lrnN12o1zihuR7PeYKwx7MB4QJtCxw/BvIhaEvdwtHo44O+oEhvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779231914; c=relaxed/simple;
	bh=rKw+Gy2B3liLRrb1+batkgbRplDfelqd2XM3nHk15tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbKnnEa1a8FwhKrcn29+pS7OCnMk4YM3YBPhQyI05wPoS79ZL2BbaLKaqclfMQFQhi55dlFx2Lzke64iIrSVD/5MG+X6jm96FHkR5Us44nezcRj1rNdHq7OB1wcMDWFh4HZdyMA7VHQp0wcVbBHUJ3MBAxXNPYr08XRWY4IeIfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SPOO67oC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SPOO67oC"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so705ad.0
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 16:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779231912; x=1779836712; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/JGKe5XSqhMH1qT1WplE0RQlM2euEqwriUAGETdhTiU=;
        b=SPOO67oCDag3YmN9Iig3cn16TayXRoj5dIj/KW4klAapMiJ3yCBv5rgCTz/4/6aVPt
         L4yb1SmH8Rq2lLM5VoRqGMAT3+viWZmus2J74OOyY2x9THYiJC2/ajSSghsEqYYlJgdH
         g4M+E5yp5kN1uMRl+9U2KuhfQv9vZv4jl7FsgzMkngJD8xbH+ozBmpYj5ZzL6y7LpQ44
         DUq3ohSkNQBf4of6HAPAdTT20O2fsHnVS0fV4nDQRl6qe0bFQEUX9TEqfgeFALLjN5VF
         gaggD70SN3D+fzku1Cc5JHTq0ygylm2NCrLNatFpfnowqhmgSX+jdM+IB6s6nSW77kNu
         c2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779231912; x=1779836712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JGKe5XSqhMH1qT1WplE0RQlM2euEqwriUAGETdhTiU=;
        b=Q4JCv4Tt8CzOaodJVCCoBPsChwfi415+wyTe5ZJOZuGBP5rO69UAfAMnAmYQ0EA9E3
         buzhLQMTjW0b9GsNi6bu0L8KbVpG04JXIpMD/uU/7KxTrcISGyzYooQLel9xQzIsMsvI
         VEVct4//gc00NdyIWrj9+0M/aem8JqaVaaA7m5ScOumC0xDMb1dCMpZhVvIZ4BfY7BKn
         S/KqA6Z5NXtYYFHPOc5ZuXLEF2oWgprxNJBuKZmIezws2iu1n3dRg/9YRUfuMutklnpx
         TWf/3GoUipzAgd7eKrjzhBTjBaIwiwMwSQJkEO0BD+YNQc7inO0Y4keqeXk9/ypD0cs9
         C0kg==
X-Forwarded-Encrypted: i=1; AFNElJ9fuzHIgbDSJgMzZ1Aky9Nud/VlmkAYzgF1PsISIojtL+GBRPjERRwNs4WrSQcZYRlgymRC3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YySmxNkROyyZn9m5RZ3PIEmXaoQs0BA7WRwVt1tPRTdXtX3R378
	wsKyLIDHyt7RhEWuE3RkUdkUGYqQsvGimVmkws9skqR7YlhMLBLbhBMibsrHbGrYQw==
X-Gm-Gg: Acq92OEwztoXRnfJ8hHfEmid46XvkttcdhvSMgkiU7YlfNtnZo39jZlgS2GrykFS6Yt
	0lPMFyg/rXRZMMZ3BxRVTk6jD/QvvXLmJ2wLpowNQjedYrAQTWyDrEgBnts3m8W/b1cUinLnR58
	vcLYpMorWeqki4LS0388OxphUsseY9cNT2yTTvXQaBDx0zD8uABmwFbVtDArGv45ZVK/KG3/LZX
	HJfTAcLm7ntx/5xKw5SexDbk+pv4+ucbKm1jHodkqWLeezn7oVvJ4KX3TCuwQB11fRgaszxmnzx
	v21tuGigXL/i5J3Cp9IpM9P+fXAYcmynysLFf6iTpbITyAD5WuTfx/7XMZFVypBfCWknutuWTwh
	WgnhzOsvGiiS/ORkKOzKKEJ3fD93fj8GVwMWsLw+e6Pc6ZDHOSBXvpP+OLObGiYXsyQfmo7RgkH
	zgh46S6XAuTgvw9JW47hdKXIPmr/6OzEdjYYjZgEqwg87upYa8ZzAKt4dBEv6a8oh3ohtXxOpez
	b+GfdU=
X-Received: by 2002:a17:903:2a87:b0:2bd:6dad:3dfd with SMTP id d9443c01a7336-2bdb37cf83amr8934085ad.27.1779231911476;
        Tue, 19 May 2026 16:05:11 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f196638d0sm22941288b3a.7.2026.05.19.16.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:05:10 -0700 (PDT)
Date: Tue, 19 May 2026 23:05:02 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v2 12/16] iommufd: Implement ioctl to mark HWPT for
 preservation
Message-ID: <agzsngLHDmoD3JxT@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-13-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-13-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:29PM +0000, Samiullah Khawaja wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> Userspace provides a token to mark the HWPT for preservation. Note that
> this token is not the LUO token that is used to preserve the iommufd.
> Once all the required HWPT are marked for preservation, the user can
> preserve the iommufd into LUO. The iommufd will preserve the HWPTs that
> are marked for preservation.
> 
> The marked HWPTs are tracked using a new XArray mark protected by a new
> liveupdate mutex. This mutex will also be used during iommufd
> preservation to protect against any race with the mark preserve ioctl.
> 
> The HWPT token will be used during restore to identify this HWPT. The
> restoration logic is not implemented and will be added later.
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

[snip]

> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 6ac1965199e9..111f4d42e210 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -44,6 +44,11 @@ struct iommufd_ctx {
>  	struct file *file;
>  	struct xarray objects;
>  	struct xarray groups;
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +#define IOMMUFD_OBJ_LIVEUPDATE_MARK XA_MARK_1
> +	/* @liveupdate_mutex: Protects the preservation of HWPTs. */
> +	struct mutex liveupdate_mutex;
> +#endif
>  	wait_queue_head_t destroy_wait;
>  	struct rw_semaphore ioas_creation_lock;
>  	struct maple_tree mt_mmap;
> @@ -373,6 +378,10 @@ struct iommufd_hwpt_paging {
>  	bool auto_domain : 1;
>  	bool enforce_cache_coherency : 1;
>  	bool nest_parent : 1;
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	bool liveupdate_preserve : 1;

Nit: Is this bool a remnant from v1 that made into this refactor? I don't
see us using it anywhere?

> +	u64 liveupdate_token;
> +#endif
>  	/* Head at iommufd_ioas::hwpt_list */
>  	struct list_head hwpt_item;
>  	struct iommufd_sw_msi_maps present_sw_msi;
> @@ -706,6 +715,15 @@ iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
>  			    struct iommufd_vdevice, obj);
>  }
>

[...]

> +int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hwpt_liveupdate_mark_preserve *cmd = ucmd->cmd;
> +	struct iommufd_hwpt_paging *hwpt_target;
> +	struct iommufd_hwpt_paging *hwpt_paging;
> +	struct iommufd_ctx *ictx = ucmd->ictx;
> +	struct iommufd_object *obj;
> +	unsigned long index;
> +	int rc = 0;
> +
> +	hwpt_target = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
> +	if (IS_ERR(hwpt_target))
> +		return PTR_ERR(hwpt_target);
> +
> +	mutex_lock(&ictx->liveupdate_mutex);
> +
> +	xa_lock(&ictx->objects);
> +	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
> +		if (WARN_ON_ONCE(obj->type != IOMMUFD_OBJ_HWPT_PAGING))
> +			continue;
> +
> +		hwpt_paging = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
> +		if (hwpt_paging->liveupdate_token == cmd->hwpt_token) {
> +			rc = -EADDRINUSE;
> +			goto out_unlock;
> +		}
> +	}
> +

Nit: What happens if the user calls this IOCTL on an HWPT that is already
marked but passes a different token? 

The xa_for_each_marked loop will not match the new token (so it bypasses
-EADDRINUSE case) and the code will silently overwrite the HWPT's 
existing token?

Since there is no unmark / update UAPI, It can be a fair policy as well,
but maybe we should call it out explicitly, maybe a log like:
dev_warn("Overwriting token to %d ...") ?

If NOT, then we should avoid overwriting the token and scream with
retval like -EINVAL & dev_err in dmesg.

> +	__xa_set_mark(&ictx->objects, hwpt_target->common.obj.id, IOMMUFD_OBJ_LIVEUPDATE_MARK);
> +	hwpt_target->liveupdate_token = cmd->hwpt_token;
> +
> +out_unlock:
> +	xa_unlock(&ictx->objects);
> +	mutex_unlock(&ictx->liveupdate_mutex);
> +	iommufd_put_object(ictx, &hwpt_target->common.obj);
> +	return rc;
> +}

With those two nits addressed,

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
