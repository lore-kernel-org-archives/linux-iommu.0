Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14C51ACEDE
	for <iommu@lists.linux.dev>; Wed,  4 Mar 2026 00:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583426; cv=none; b=LWaXSALdiIWp+rdlt/u+BWsRvNimLrNPg1BRDkPbleVkRNvU0a7Am/OayfSkXmhAogUPN1AMnEb/5rqMWXYLzMwzISGZt8I8sCEULKUGZeziaLihp+fh7umfgJzmQml1W7xu2f7b8w0t5uU/XA0+u2vuPNBo5vFXQMRBYBPss5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583426; c=relaxed/simple;
	bh=X6C/76WEw4vUdc/hkKIY4lH8TczRDzHUm4gqTQ/U1lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxHP+z2LjZ6K1gNyUrX+2/+nhaZjsmbOZypvgtHrJzUrHqxbims17SqIo4VrJKfxRGlgCQ4eLPiDa+DDJBJVLryAvswV+dMCO6WjqQXKL4s41cel3oCPyHELTObAaDlW6fsWyEVnlf9loSyldNLmEkJ4Y9aaljoQ4PUGPLru1yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nst4mYx1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nst4mYx1"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae49120e97so120335ad.0
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 16:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772583425; x=1773188225; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ye6hh9uo+WbVhBDIVb1s+VZOu40x4wcR8cEKrSMNyN0=;
        b=nst4mYx1nMTYA9X5KC6AA0VtWEaUezIox8t7vvpxI1iVTQHAB5cT/7m902+0oiRgnx
         xCNBhE+QUa/vFVklgVbqlcgKpwzSTEyF7B21J5mVF3mvdvby5SX/tzgF+fo2/53E/09G
         mWi4dI4y9y8LjJPgudwm8b/fu9YqekWNB1MgqG2VzGV+H3yZj7TxAFtEJqRC0k8+wyoE
         Ri3yK27eqtQPE7pFrKUFyhYm+ACf89sKTU7/aQw2cPbKJdl7P8CjwxOQKihxiqQlvGsq
         ePzLQkDsNZsqJLyX5HWLrCylzmsOysftVfgMUcSuHGoYAhwXsuB6opvZjX4tbM6Hg1Zi
         566w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772583425; x=1773188225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ye6hh9uo+WbVhBDIVb1s+VZOu40x4wcR8cEKrSMNyN0=;
        b=fcG2CGJ9t836rgy8MnVguMraze8UNrz5zZlx6zkfsmrv0Q0yojpJbO8hznjigk2jk+
         OTWqpPP291Yvtjw3sIxiPi/gBtmZRBZozJzBZcyzqOcqlt7uk7s3Kt3kQuG3dfVJHuvT
         JCiTbfBzkAcUHdHFE0kN6g+5+Up7169ZgNr+XAyyTjr3AIvti1v5+mmQRK/UPry8smB7
         K7bWxz6v8Zyj/okO76btSEYhfZll2cc1yWGUPp3h+XBy4VL+tLHc7PM8AGYTFJ7V3WyP
         Jd+zAukbRaLVJPmZLzetr2gmQ81JOLfQf3qss2AIAtsOEXfIOQcwNd5jX0G06+dlJm24
         p53A==
X-Gm-Message-State: AOJu0Yx3phhygEdQ7lKk6BndMX9Qjg+EDFWc6AaifDfrPEWYzCKk6Tqr
	IUzNPtwqfdBxqXAOE8Qd01Tavee5t+FcMXm45mTV+vLD8nEOL5RmQLkmzYZ6JGxq7g==
X-Gm-Gg: ATEYQzxc8cYUwSN65px8I9jFLxWzt9pECkr54Bk6rS8vHB5mpuypOcrcmOyM8APL7Tb
	VHNCyQeNcArLh7ki3NYFNfcm2eiXNBhvUT4Dy3d4CRWHBzFGbV5WMQ3RyMC1JkCmb51gioCwcs5
	lJtJyobSNlbX1ShiGPaUCkGGjFVzcDOHpces2gVXU6MwuzgtRj6tpeG+gW9C1HuoiXYk1H0X4Lp
	ZUAyhAbU3XcxF7K0yasFsvkAySFpw1N/8/NFOzE3OcJyB1d0l1IB6omZ2H+hSggEa6XYMttOWIY
	fdTMPPosnF78HoJNVps9BJFPwBm21okwUT4z3LCY1pjKUHpGN7MDtPGg5t2jK6ymO6yd4Y1cB9I
	CJPwzROg1dirAx9N/vZ1Ut1DcyOcChwYDZVlIYzm/8ME5bX3ugQT/m3DIlh0F5rK071LD/pmCQi
	EaSfgStcw7atofA73XHUOTjM/cTDbhBAJzu4WwFyAQWYtFwhBlHWKPjIxOZQiJog==
X-Received: by 2002:a17:902:f712:b0:2ae:4f95:df55 with SMTP id d9443c01a7336-2ae4f95e48dmr5854175ad.25.1772583424491;
        Tue, 03 Mar 2026 16:17:04 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c49eb5bsm3255616a91.11.2026.03.03.16.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 16:17:03 -0800 (PST)
Date: Wed, 4 Mar 2026 00:17:00 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, baolu.lu@linux.intel.com, jgg@ziepe.ca, 
	kevin.tian@intel.com, nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, 
	kjaju@nvidia.com
Subject: Re: [PATCH 2/2] iommufd: Report ATS not supported status via
 IOMMU_GET_HW_INFO
Message-ID: <lfsrujftxeqtidal4q6x5pxmoxdhlid7lgiwm4b3g2vorju6cj@ajwaqo3wv57n>
References: <20260303150348.233997-1-skolothumtho@nvidia.com>
 <20260303150348.233997-3-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260303150348.233997-3-skolothumtho@nvidia.com>

On Tue, Mar 03, 2026 at 03:03:48PM +0000, Shameer Kolothum wrote:
>If the IOMMU driver reports that ATS is not supported for a device, set
>the IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED flag in the returned hardware
>capabilities.
>
>When this flag is set, ATS is not supported and not used for the device.
>
>Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>---
> include/uapi/linux/iommufd.h   | 3 +++
> drivers/iommu/iommufd/device.c | 3 +++
> 2 files changed, 6 insertions(+)
>
>diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
>index 1dafbc552d37..d85a2d3e1b40 100644
>--- a/include/uapi/linux/iommufd.h
>+++ b/include/uapi/linux/iommufd.h
>@@ -695,11 +695,14 @@ enum iommu_hw_info_type {
>  * @IOMMU_HW_CAP_PCI_PASID_PRIV: Privileged Mode Supported, user ignores it
>  *                               when the struct
>  *                               iommu_hw_info::out_max_pasid_log2 is zero.
>+ * @IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED: ATS is not supported and not used on
>+ *                                      this device.
>  */
> enum iommufd_hw_capabilities {
> 	IOMMU_HW_CAP_DIRTY_TRACKING = 1 << 0,
> 	IOMMU_HW_CAP_PCI_PASID_EXEC = 1 << 1,
> 	IOMMU_HW_CAP_PCI_PASID_PRIV = 1 << 2,
>+	IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED = 1 << 3,
> };
>
> /**
>diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>index 344d620cdecc..2e98818806c0 100644
>--- a/drivers/iommu/iommufd/device.c
>+++ b/drivers/iommu/iommufd/device.c
>@@ -1624,6 +1624,9 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
> 	if (device_iommu_capable(idev->dev, IOMMU_CAP_DIRTY_TRACKING))
> 		cmd->out_capabilities |= IOMMU_HW_CAP_DIRTY_TRACKING;
>
>+	if (device_iommu_capable(idev->dev, IOMMU_CAP_PCI_ATS_NOT_SUPPORTED))
>+		cmd->out_capabilities |= IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED;
>+
> 	cmd->out_max_pasid_log2 = 0;
> 	/*
> 	 * Currently, all iommu drivers enable PASID in the probe_device()
>-- 
>2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
