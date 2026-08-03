Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B281379974
	for <iommu@lists.linux.dev>; Mon,  3 Aug 2026 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785755484; cv=none; b=aRxrUFBV1R7tAUgiy2d/hmjaFCIe5Z9zGPFzt8W5+NT2aqkNyJTdGE2juKGjhg2orzwGOnE4gggLqGeeeEY9wKiyVLnMR87Mk6SPY6xJiT3yLC5HK+bMxkzDdkky/H63UGtZAWD+VnB1mYUN8ZuSKFCUwEMjC5+QFgHeRL1fxVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785755484; c=relaxed/simple;
	bh=zUEehrAAlTJ8R5aPfUUZP8MnSQLpWmy3bvL8DQf8vmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pa1ID3YHGC2WVkIgpTrVg/XTvnFgAFBQnVhX0lHU2Xc2WpQO+UGV8XruLLK9iHoSQN7eBNenWHh7fmKyz1ETxQnq+c8tfGWj6sshvKxOpGLh6a28AvjfNMBtzesAVAM28D6J6ei42QbJ9zmAc31YrRERQMUYr1m8kJBbq+59rzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MP4dFWI4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MP4dFWI4"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccdf36f63dso128845ad.0
        for <iommu@lists.linux.dev>; Mon, 03 Aug 2026 04:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785755482; x=1786360282; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n762/MxYtv1d3KOPSEF5oTaF+noAfHsJGw6J2wXrY+s=;
        b=MP4dFWI4/DPFl79A0B8oBAVxtImL7Wus/DwffRQB1RnKva2NZ98sRmsRVPLDfdx+T4
         YWX3+F/i7HT+z5R4RBSNsO/rh/YW/Zt5A3Mx/lLGUYAFGnkB0XZl2h5JNCNjONJybS7C
         oX9J8+u3PbWH4ecHH9j770lT6RZRHiwNfv4H1/j+4i5KWC599NWoSCVEOC2OplumRIlF
         iXVyxWl0v0t33sIysXfU4o2LDTWFG5CGN7a1vXVzgnCkBJdlUjLVPEWFUZ2Huk39UQpK
         1nCtlWN928QQ0gRHdk0lM2l1Bioo7FMI8lQuSjNgXNh7jH3JnAwKjS0QfVUe1fQRrR1Y
         fFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785755482; x=1786360282;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n762/MxYtv1d3KOPSEF5oTaF+noAfHsJGw6J2wXrY+s=;
        b=qS6ikxENg8zUh4RIWrnnqpa2DiwUBr9HmbDwEhzmivfMcgj2kgU4E1J13IU+/hxnSx
         OHHRNvAcsN5xQSJFz4GBff732WSC9Xu8qymaeOb/DPw7aA8iVOo0r8MjrA7tAMIOk0/3
         TmCGMwQtHP7fq5eNekZ9Y/LlRZM1zXJ8KdynErNX0uwq56iKJTtOG6zNYDnOrQA5eAnX
         N2EJU63yZfVIKVkWHuqrP4W7eL49XBQfB2seV9rbhE5yweo5mCSwmFLX37RL3XfIjTUd
         c9SJljeY4Gcr5p4Hg/qf2Fa8t2Fm7zA9x3vGqKbNpan5eSr12Umx9nzJVQH5UgpMdoK9
         HNNg==
X-Forwarded-Encrypted: i=1; AHgh+RpU5/gXXROGuWaPuUfCOtzxu64fkVNsN+O5celU6NxMuAf2N2mYxlciypB1bqJRfxvwAjHqGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzc1UtbMvKuTwH6+tqo7FMXeGf90CLkq2FXU35oEXFUxQKx1aAE
	fjihVi/2/bTo6j5ZUbnNp45PRqAy325fPboQzOdutAtg/kgt3+9+qZAM1DZRuJOw3g==
X-Gm-Gg: AR+sD13grHPR3FSOTS/zuxy3L8cp2GTmtvSHv3PEf4w564U0cDG665fLCdE8n/rJHep
	LtA9bPHDjZjsyql/dpaoY3oMLzWliVvws+oMSzjAWy6k4vfGI1hTEi/yXjp4K8AtlATBsZpK/bX
	LcUwTHal+uiZX+sv019HvLN+rdHy4X28kpy+zdq3UdY2Ftmd81qw9EQqlS/11PtKbJJcMFE0Sez
	SgHRv4LkLC7vVC6WP1zaQQB9o/0db5GgUztMZa3pHHt+rKyo8w5hb6q5XUtc6Sghf2zHpcKx53k
	fUYidd9QhSuHnZ3G5jCtRTAXhjNzE4z3aJAUEoo13ilESpiHyBjrOXUlqpy6s8rzd9BZYW2dZLN
	8sy/EoihKBd7+X6ie1jtEMzdy29Fy+gAqk7vFzUrQ8KjOCn6MUON0FJh/q97RCCsQcKwFPK+Gqv
	lW2deLaCXJ4+y7qxMzxmO/S+nrttubYmUzIqXKJfukReZV8tflYOCH82+Mj/vKFT0GmR3IBxnLe
	izvG5lRc4LZAGyHdBjER1c=
X-Received: by 2002:a17:902:ce0a:b0:2ca:4bb4:4bd with SMTP id d9443c01a7336-2d056f86736mr14315255ad.5.1785755481934;
        Mon, 03 Aug 2026 04:11:21 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30a43a6sm3840095a91.12.2026.08.03.04.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:11:20 -0700 (PDT)
Date: Mon, 3 Aug 2026 11:11:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Subject: Re: [PATCH v3] iommu/arm-smmu: Use pm_runtime in fault handlers
Message-ID: <anB3Ukk7JM42Wgpp@google.com>
References: <20260630-smmu-rpm-v3-1-f69874a580fa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630-smmu-rpm-v3-1-f69874a580fa@oss.qualcomm.com>

On Tue, Jun 30, 2026 at 02:32:46PM +0530, Prakash Gupta wrote:

Hi Prakash,

> Commit d4a44f0750bb ("iommu/arm-smmu: Invoke pm_runtime across the driver")
> enabled pm_runtime for the arm-smmu device. On systems where the SMMU
> sits in a power domain, all register accesses must be done while the
> device is runtime active to avoid unclocked register reads and
> potential NoC errors.
> 
> So far, this has not been an issue for most SMMU clients because
> stall-on-fault is enabled by default. While a translation fault is
> being handled, the SMMU stalls further translations for that context
> bank, so the fault handler would not race with a powered-down SMMU.
> 
> Adreno SMMU now disables stall-on-fault in the presence of fault
> storms to avoid saturating SMMU resources and hanging the GMU. With
> stall-on-fault disabled, the SMMU can generate faults while its power
> domain may no longer be enabled, which makes unclocked accesses to
> fault-status registers in the SMMU fault handlers possible.
> 
> Guard the context and global fault handlers with
> arm_smmu_rpm_get_if_active() and arm_smmu_rpm_put() so that all SMMU
> fault register accesses are done with the SMMU powered. If the SMMU is
> not runtime active, the fault can be safely ignored as
> arm_smmu_device_reset() clears fault registers on resume.
> 
> Additionally, disable fault reporting in arm_smmu_runtime_suspend()
> before powering down. pm_runtime_get_if_active() returns 0 during
> RPM_SUSPENDING, so without this, level-triggered fault interrupts would
> cause an interrupt storm while the device is being suspended.
> arm_smmu_device_reset() re-enables fault reporting on resume.
> 
> Fixes: b13044092c1e ("drm/msm: Temporarily disable stall-on-fault after a page fault")
> Co-developed-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
> Signed-off-by: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
> ---
> Changes in v3:
> - Add arm_smmu_rpm_get_if_active() wrapper that returns 1 when pm_runtime
>   is disabled, ensuring fault handlers work on non-pm_runtime systems
> - Disable fault reporting in arm_smmu_runtime_suspend() before powering
>   down to prevent interrupt storms during RPM_SUSPENDING state
> - Use pm_runtime_put_autosuspend() in arm_smmu_rpm_put() instead of
>   private __pm_runtime_put_autosuspend()
> - Link to v2: https://patch.msgid.link/20260313-smmu-rpm-v2-1-8c2236b402b0@oss.qualcomm.com
> 
> Changes in v2:
> - Switched from arm_smmu_rpm_get()/arm_smmu_rpm_put() wrappers to
>   pm_runtime_get_if_active()/pm_runtime_put_autosuspend() APIs
> - Added support for smmu->impl->global_fault callback in global fault handler
> - Remove threaded irq context fault restriction to allow modifying stall
>   mode for adreno smmu
> - Link to v1: https://patch.msgid.link/20260127-smmu-rpm-v1-1-2ef2f4c85305@oss.qualcomm.com
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 92 +++++++++++++++++++++++++----------
>  1 file changed, 67 insertions(+), 25 deletions(-)
> 

[...]

This version looks fine to me, 
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
