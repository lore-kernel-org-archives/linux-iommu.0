Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7E21C7B6E
	for <iommu@lists.linux.dev>; Thu, 10 Oct 2024 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574402; cv=none; b=heB83uh3cvXwI1+5ebdpO1tHsEyXihJ7OaZ/Cy7nf2IH2WMup3iPQpnKM//e5zDhMrudeQHjO2W6itvrWMvBP41knRkboAiXbAqqet1lo/qX5rAtfICH2j25IDpXk25ZtZpJq7+U9yPb9hMzKum7rZUoIebb3tJCF3jmxm0Mq98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574402; c=relaxed/simple;
	bh=huzcYhaj1QkMs2A+WerOIGgErQX8Kuj8Hm//GXsV3xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahVWAL3xtquYsPZyJNfX84zLSz5Zo12fb5CGK1bZ4w0MmrPT827DRL5ce3pyhf2PYLdSXDFmvKXJI8gUfKKuEkdMbSUxzwyWvBZaR/ArqidM1hYE++6X0HZXFYxJ2smHgZVdzyt7v9ERmQr+ryawpUZyg+4dnu8jO+rPZmlevSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NBxhee6/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NBxhee6/"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b061b7299so172825ad.1
        for <iommu@lists.linux.dev>; Thu, 10 Oct 2024 08:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728574400; x=1729179200; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w/ZmpxU5Ar2FNW/jteZs/sVfkGodgjpZwiHNQvHm7l0=;
        b=NBxhee6/l8bZckgkid0Tjdz52BzM54BZ2gNzjodqxxhdG6XK6tsI+/kRtzy1BnVL5U
         QJAX8hAEOwF2d66NE8g5gWNzBArGv2MHYF04bVIgqhnAp6ZfgCngOHKNgUJYFU98DVhT
         n2j85gmJq/Ioxny6K/+3ijIXrDrYh8HWnybwu2rMJTyJVcnn4lUtL9YRlJNwXtR/BxLx
         WzoeJkv2/uEdRL+Q18jzvRg1YE+Z+9LAZahR8q/p05XLJ9hGRi7WLq4wRy6vK40QGKTM
         3xd2+ACdSiMsMKJgNt2Jnlr2IkhpvDCN7NXx442/YHmCyQM800QdLPoOWF5I6PdBP5ax
         UlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728574400; x=1729179200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/ZmpxU5Ar2FNW/jteZs/sVfkGodgjpZwiHNQvHm7l0=;
        b=EVW8qBmbiWGFJR7MBPPxe9kCKFgnsKiqvA3MBRVXzWpSDjNoI7m3qNFUJ77AsLCWSK
         GFcw/oFSj0b1bqOFnX5OiY0MQqFs7qMBDVviEP3RS9qh4um9mpbUaOYoD2B8UhhQzU+f
         QrE77Dh5/Qq1t7qIsEZBzhlYIi4dqI/QhVGeCK4Mg+72xSw7s4bn0qjfoZ+FjEY6ykq5
         wMfXh5KUHBPK2B4l6i+5+wrYzBrw0K3onE9HFYGUUoJN2zuyhcMXUgj9Zax96nHXX/my
         pH3R4NvVj124eY3dOvWjWb9FYTltEPq7Q7qthcWmrK9lO7rbpG72z+5I6ykY8x7EMJ+y
         YAtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXe/25qw05khW5zeW3vHoe5xtc7PB+WbxtSbCBl4Q+jnFj3DIlSqoBKKXMuZVO4fDGYd1MgOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf3XPwirwWTMk5QtcpsjFn4Y4QF/zXvQ7RkX6TJ85NCm/vziC8
	2DdTUhaTza8NPeqRBivrd+jbdAxaUDfqvZyBcJB4iJraaae6m5DZasApXtgC4w==
X-Google-Smtp-Source: AGHT+IGckJvBw34/8XK0AfFY3nhmk4JYCNb2V2wP3vhB3S6j5MJz7Bqeauq+12aWJVrNrkRGxHknOQ==
X-Received: by 2002:a17:902:eccd:b0:20b:7784:278a with SMTP id d9443c01a7336-20c82eb95f0mr3152015ad.22.1728574399488;
        Thu, 10 Oct 2024 08:33:19 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5fc5c53sm1452540a91.51.2024.10.10.08.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:33:19 -0700 (PDT)
Date: Thu, 10 Oct 2024 15:33:11 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Rob Clark <robdclark@chromium.org>,
	Georgi Djakov <quic_c_gdjako@quicinc.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH 22/51] iommu/arm-smmu: Switch to
 __pm_runtime_put_autosuspend()
Message-ID: <ZwfztwoGAcvyvlWL@google.com>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
 <20241004094123.113725-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004094123.113725-1-sakari.ailus@linux.intel.com>

On Fri, Oct 04, 2024 at 12:41:23PM +0300, Sakari Ailus wrote:
> pm_runtime_put_autosuspend() will soon be changed to include a call to
> pm_runtime_mark_last_busy(). This patch switches the current users to
> __pm_runtime_put_autosuspend() which will continue to have the
> functionality of old pm_runtime_put_autosuspend().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 8321962b3714..cad02d5dc6d2 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -79,7 +79,7 @@ static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
>  static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
>  {
>  	if (pm_runtime_enabled(smmu->dev))
> -		pm_runtime_put_autosuspend(smmu->dev);
> +		__pm_runtime_put_autosuspend(smmu->dev);
>  }

Seems like a straightforward change as a result of [1].
Although, I had a few things to discuss:

1. The `rpm_resume` in drivers/base/power/runtime.c seems to call
`pm_runtime_mark_last_busy` in case the ->runtime_resume callback
returned successfully. In such a case, why would we want to move
`pm_runtime_mark_last_busy` within `pm_runtime_put_autosuspend` ?

2. In the arm-smmu driver, we seem to rely on the rpm_resume to call
`pm_runtime_mark_last_busy` as a part of the ->runtime_resume callback.
The only other case, where we might wanna `*mark_last_busy` is if we
want the autosuspend timer to be re-started in case of a failed suspend.
However, the `arm_smmu_runtime_suspend` doesn't return errno in any case
hence, I don't see any other case where we'd benefit from using
`mark_last_busy` in the arm-smmu driver. 

On the other hand, I don't see a problem with using it either :)
Any thoughts Will/Rob/Robin?

>  
>  static void arm_smmu_rpm_use_autosuspend(struct arm_smmu_device *smmu)
> -- 
> 2.39.5
> 

Apart from the above discussion, for this patch alone:
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Pranjal

[1]
 https://lore.kernel.org/all/20240109133639.111210-1-sakari.ailus@linux.intel.com/
