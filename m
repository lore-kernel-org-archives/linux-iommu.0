Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9006834572F
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306646; cv=none; b=ZwuygigEqFk24cJPdIJhMYGeKa6gEczCuMWR8nJ28KniSV3bvcYDmP+3V0OsWSz+mm6eif/P1JE7J+eJbT7YaMszqKxp01WBt0sGBYiDp0INAqFhiZj2KdQoMfdrH13AIBnF9Betsxie8XmnbZ4LiKUTMyxQHtdVM3upcHm2GWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306646; c=relaxed/simple;
	bh=38oreodTd3a6pgd9iHihqPkmarP5WZdM5RpNKRkZshU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWqvSMvjcM4035s2rxrVj9RaCEbjHWRJFXFDzhqX40qmzFrIzQmZC9rm3Y1cwfysXth8Az4N+o3iKvC6m1KzqVXtP5Emx4a9aFp2T3U3iv1kPtJRUbg4fsGbrNY+r/kcT0R5GY86A7Bfu3+kZ3hvvlMObf46J8mYAtna0LjJKPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tpJsGqir; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tpJsGqir"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b46da8c48eso1205ad.1
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 12:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779306645; x=1779911445; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zGlZIIGtCBSMFz+AR7h4nxPLAjxI6s+Py2Of2qTbbXE=;
        b=tpJsGqiryQ4m+lxhREcoEqDQy+DUieC/Zoh/E3GQzVDOyTNM3+1AX9xt609kf1hERd
         wOI/NvCX2LP3sBOst0wipkWPQYyf7f2Q5glyRmVDKdTsU1Daf//hdd+H4hpUmMwOk6tp
         KrdFhQQvwxpT64BzLloGyZSDo3pjXNndWWqVRngeE7R1+YmbzB1rDG01c/3UrEj/jWK1
         zYZoEmvhj9hopMgesuPlP1lEbwVWL3cdvPFV7VOlMH0ORZLbB0ovS6PSBknC02d80clJ
         WjIkaTY/3f2lieVuBKy4UE1wn+h3EcRV2TpBsDmG7Vo7i4odfXgxubeQqw6BypxaV54f
         6+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779306645; x=1779911445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGlZIIGtCBSMFz+AR7h4nxPLAjxI6s+Py2Of2qTbbXE=;
        b=DwC833wwn/8iQut8acjp9Q2uSePhNlCRgrGU8xoU9VRSA2/I8ujU81EpcQvpliUu26
         ib1UN8tXnMTfedbpaPepDGkizl2I3znwczcPYQOMkGf0okaNyx8/rHcsFw1sUq0MC/Yc
         Ti887fyt+YMEJgkexZAS/0fU4WS55D00y4ru4SzauUInELMsWnWYBuJoq9Wis3iYavle
         Ft187wpApVtPI3/kjlqx3Oi+8vynK9G6MnMrfNyvv1ZBMldbfXkpPalGUC+WhbPKzmuy
         El1u6xlxgaDSd+3J1gmVFh24Mk7is40OONsINHq1ifA/xkITLkTgyxlDMDaL59yp5pcH
         P2WQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bG+1Tv+eL6HFOktBQcXNoC8cYX/7s939DhmrYI86OM6l3/BDygrMAGtKeynnLI89dyfT6+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxGhvwrjRQNxl9o/mRCPY/6s1AWxcnP5JlYm42jmbKucc0jO58
	k52F/o2R6Ep+doO+YcZL7SifiRv2IcXPsMywI3InjWlBK0lZHRWrMOjeVZxsyd2GEA==
X-Gm-Gg: Acq92OFHwB3+tsDHM4nYK1Ol7XYix1J7wcSN068WPm9vYcoU+LXfw02Pfl6G+LBxqBS
	DY7aJ7Os7eqG/uIqToxoDirRb4GIkC9qIZJztPqdh6T5tmEjM/VC9sbym1auk7i9cFk0+8R87/5
	Cu5PyxdtlxbS3Es8G8EzPs63LKOQ1mzdKqk/SnNDLbYjPCgBjunb6L0iJeqZDrpgZqa0J+Gc4rv
	QdTugLPuOFIa6bHFvzNxcGi1byQCMcCbG+IXPk9vtjAOQfuBZOvwEKlsQrN9GFmJA4VS01vtiVU
	NlNhFyOISUV064n3VXCTchiLBcLm6VknlpPT1CamQ6B5RxDLop1pddwqyRULrWh7HJbpRxpDBIh
	aySBAmxjIz++6WECWpQKonrrRP3Y58sNcPuRWmC/uHolYiIpcTfT5pW2gSGJhFuo7AdUhShyZKR
	az/Ev3b2ak8sk4YlGyUkGxe6pguSd3EZHfPCjNSgGEQk7YKkB0c581K62HvvpWnNUmsZmZJA==
X-Received: by 2002:a17:902:ce0a:b0:2bd:6dad:3dfd with SMTP id d9443c01a7336-2be9f6d571amr560625ad.27.1779306644147;
        Wed, 20 May 2026 12:50:44 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84149619c9dsm224416b3a.36.2026.05.20.12.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 12:50:43 -0700 (PDT)
Date: Wed, 20 May 2026 19:50:40 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v2 12/16] iommufd: Implement ioctl to mark HWPT for
 preservation
Message-ID: <ag4QQRB6g7BkANj7@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-13-skhawaja@google.com>
 <agzsngLHDmoD3JxT@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agzsngLHDmoD3JxT@google.com>

On Tue, May 19, 2026 at 11:05:02PM +0000, Pranjal Shrivastava wrote:
>On Mon, Apr 27, 2026 at 05:56:29PM +0000, Samiullah Khawaja wrote:
>> From: YiFei Zhu <zhuyifei@google.com>
>>
>> Userspace provides a token to mark the HWPT for preservation. Note that
>> this token is not the LUO token that is used to preserve the iommufd.
>> Once all the required HWPT are marked for preservation, the user can
>> preserve the iommufd into LUO. The iommufd will preserve the HWPTs that
>> are marked for preservation.
>>
>> The marked HWPTs are tracked using a new XArray mark protected by a new
>> liveupdate mutex. This mutex will also be used during iommufd
>> preservation to protect against any race with the mark preserve ioctl.
>>
>> The HWPT token will be used during restore to identify this HWPT. The
>> restoration logic is not implemented and will be added later.
>>
>> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>

[snip]
>
>> +int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
>> +{
>> +	struct iommu_hwpt_liveupdate_mark_preserve *cmd = ucmd->cmd;
>> +	struct iommufd_hwpt_paging *hwpt_target;
>> +	struct iommufd_hwpt_paging *hwpt_paging;
>> +	struct iommufd_ctx *ictx = ucmd->ictx;
>> +	struct iommufd_object *obj;
>> +	unsigned long index;
>> +	int rc = 0;
>> +
>> +	hwpt_target = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
>> +	if (IS_ERR(hwpt_target))
>> +		return PTR_ERR(hwpt_target);
>> +
>> +	mutex_lock(&ictx->liveupdate_mutex);
>> +
>> +	xa_lock(&ictx->objects);
>> +	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
>> +		if (WARN_ON_ONCE(obj->type != IOMMUFD_OBJ_HWPT_PAGING))
>> +			continue;
>> +
>> +		hwpt_paging = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
>> +		if (hwpt_paging->liveupdate_token == cmd->hwpt_token) {
>> +			rc = -EADDRINUSE;
>> +			goto out_unlock;
>> +		}
>> +	}
>> +
>
>Nit: What happens if the user calls this IOCTL on an HWPT that is already
>marked but passes a different token?
>
>The xa_for_each_marked loop will not match the new token (so it bypasses
>-EADDRINUSE case) and the code will silently overwrite the HWPT's
>existing token?
>
>Since there is no unmark / update UAPI, It can be a fair policy as well,
>but maybe we should call it out explicitly, maybe a log like:
>dev_warn("Overwriting token to %d ...") ?

Agreed. I will do this.
>
>If NOT, then we should avoid overwriting the token and scream with
>retval like -EINVAL & dev_err in dmesg.
>
>> +	__xa_set_mark(&ictx->objects, hwpt_target->common.obj.id, IOMMUFD_OBJ_LIVEUPDATE_MARK);
>> +	hwpt_target->liveupdate_token = cmd->hwpt_token;
>> +
>> +out_unlock:
>> +	xa_unlock(&ictx->objects);
>> +	mutex_unlock(&ictx->liveupdate_mutex);
>> +	iommufd_put_object(ictx, &hwpt_target->common.obj);
>> +	return rc;
>> +}
>
>With those two nits addressed,
>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>
>Thanks,
>Praan

Thanks,
Sami
