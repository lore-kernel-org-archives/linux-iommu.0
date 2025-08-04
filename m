Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6979475
	for <iommu@lists.linux.dev>; Mon,  4 Aug 2025 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754306751; cv=none; b=lUuFxlEjVXqF31X0Wje4VHiJNEavfuUbJYIcFc3sG2kaub0cqTrJ6zmdHzONRyrHMIo708u32iIMeWna59AHv9mL9AiE8GUisKADL2p2lFB20byk8h7rboCS3de1yOFO1hyo388m+Cc0FwbrCkCI7nE+Ns3s+N4KcjL5UA9zTRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754306751; c=relaxed/simple;
	bh=gkDSsxAB1CmVNE9hEyyfIildmdzJCDg55uhtOa6+TMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUO0gUMzj7DqKB01f+mPRRVmugxo78GmzNMw6AO8y2m8wsu3lk2gvxYiTLQRq2AJt7lX7Q0N2zIcjnDd/0rkHphpMkKEopAPGSYGp9TA9st7H527iDhdFeGhhwzjb2BzpmLaifUoVCPjxh2quiTgHiISwDIQRZwMQTQ/3EJJ7Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q51LC0L0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q51LC0L0"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-240708ba498so286205ad.1
        for <iommu@lists.linux.dev>; Mon, 04 Aug 2025 04:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754306749; x=1754911549; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nOgk0O3jELXDtoN6mDS+bFUGLsf/vE9G43+i47E0bHY=;
        b=Q51LC0L0qFwiAi+MENLxL+GFu8qwt85mxtCuF0b5j4DuWGiDFOtR1Xos1V4L6l3/Yx
         KynHHCtJR0xK2761Mpa86iMq4CftDOLhV4I9f/2qHisGmVt58n0J1P8axeJoUcob4bC5
         s7zuPmmDU8u5L0wVrmj65OTpxb7WHFw4gGK4aly+0jOXk3CLr/dK7DT2hGjPVcVzzKd0
         1dOztgGCA1rhkaJpF3GOD5TmZFlijwdD/5zqvDfyjIOps/oC16TE9+/ySNKEbgwGUjJp
         VXVtXnFnUVqDmmjSXYlZix5MIhmi/ehPj+0ZrrTl11NM4TMxLwjWfGXn2QGuHuFOKcCx
         fy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754306749; x=1754911549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOgk0O3jELXDtoN6mDS+bFUGLsf/vE9G43+i47E0bHY=;
        b=Fltc2Eb1XOv5fzrvPBwLJL+1pwvwWhEy3lhqaS2P7lRwcE9HDqnNu3+0i+cMctCNSf
         zcQSKvO6S0F1gK6co7mNBba109/wjTDTCbojP7EIMiFphrKITMjXpOIJXNtNxte0FmNK
         +auXRvN3lDrqRPl48rCuYAqUZX+7IiNI5ksj4K5lDMf+h5rm1qK5uHbXh3R4qffUnUJZ
         Izu1ntFBTS1piR6udpr59yxonlCTPI5e/rBtj0skYTCWElIRTN64nL/6mWIj+Ma5Fxbx
         yRfUPiNy2hObsn2tzNbTqKPS2Y3vLpFNRJZagPNKwF/VBB5ti9H9DtNLUuaCvtRA/mDu
         00Mg==
X-Forwarded-Encrypted: i=1; AJvYcCULmpm8SQzQ5+9GcrQS3tjmmYN0m5XkErt5sR4phn6ilL4blj8/UJeP7o/FaG0RxwbMDUYObw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxT4SOqltYdT6t/MuNnmTdsDku1twfJF0WGyqOngYa97awQ9lbe
	ppKtrPFMIcXPhrFMyeZHCEJ3cAWTHOeYMcVUppLebk9fv6hPz4NbgQPvXcgdFzLNGQ==
X-Gm-Gg: ASbGncs0gzXSXFM+ycmXyL6OP61Q3mdNyxLLG7QPpjPIFWmlM/q31AQ6K2ndKFOiHA6
	sAh8Pgd/xsFS+pONPTcC13vmgbnDkfgYp4zMqwDAH2u0R1Qhe5nwAOagcZe4q6f4rojt07H4yXn
	eRStK+cPJsFyotu/gJtVVoFHaQ7772PTHEVD9yacdsIS4lAQ0bUsL7z73+UtJ3avuJwqhMeswkw
	CMzwR6F+zPhm4Ejr1jvs8YxxeBuCby171VpEDfTrvFKOU3K34HLr+ZKIQLQtHWuz+sEA6I1gR6w
	iyt99D7IOIx0T/5I2jCLWQeC1Vt4uixd1QC9sj2xIfh4qXEtnslhtPvuJb4bRkBasnGX1soUZRs
	zrW7JxvPf9iSuc7xt5j/Dhnh3xpc9Qt3AZgfBKMYXYKUiwD9qZfMl+Q2b
X-Google-Smtp-Source: AGHT+IFPki1gSIr5EdJS2B8cjAGJSJGlNaB6DIHKZAxSzQhV0ctnAdxmT77WAI7t67u+WNTGjOhEog==
X-Received: by 2002:a17:903:41c7:b0:240:2963:f794 with SMTP id d9443c01a7336-24248569b13mr4997985ad.6.1754306748923;
        Mon, 04 Aug 2025 04:25:48 -0700 (PDT)
Received: from google.com (208.131.87.34.bc.googleusercontent.com. [34.87.131.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfea38csm10272472b3a.128.2025.08.04.04.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 04:25:48 -0700 (PDT)
Date: Mon, 4 Aug 2025 11:25:42 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Richard Gemego <richardgemego@gmail.com>
Cc: nicolinc@nvidia.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jgg@ziepe.ca, iommu@lists.linux.dev,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: Re: [PATCH] iommufd: fix returns ENOENT in
 iommufd_viommu_get_vdev_id()
Message-ID: <aJCYtnyBjvTxULbE@google.com>
References: <20250804100859.3462571-1-richardgemego@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804100859.3462571-1-richardgemego@gmail.com>

On Mon, Aug 04, 2025 at 06:08:59PM +0800, Richard Gemego wrote:

Hi Richard, 
> In iommufd_viommu_get_vdev_id(), if viommu does not have any vdevs, fix
> this func to return 0 instead of ENOENT.
> 
> Fixes: ea94b211c548 ("iommufd/viommu: Add iommufd_viommu_get_vdev_id helper")
> Signed-off-by: Richard Gemego <richardgemego@gmail.com>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> ---
>  drivers/iommu/iommufd/driver.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
> index 922cd1fe7ec2..ad635af8555b 100644
> --- a/drivers/iommu/iommufd/driver.c
> +++ b/drivers/iommu/iommufd/driver.c
> @@ -68,6 +68,7 @@ int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
>  			break;
>  		}
>  	}
> +	if (!index) 
> +		rc = 0;
>  	xa_unlock(&viommu->vdevs);
>  	return rc;
>  }

I'm afraid, I don't understand the motivation behind this? IIUC, if a 
dev is not associated to the vIOMMU -ENOENT is returned. This patch
seems to be returning 0 when the xarray is empty. The issue is that
returning 0, would indicate the caller that `*vdev_id` holds a valid 
value which doesn't seem to be the case here?

It seems the original behavior is correct. Nicolin/Jason am I missing
something here?

Thanks,
Praan.
