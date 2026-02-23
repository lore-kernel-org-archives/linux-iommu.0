Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38CE37AA9F;
	Mon, 23 Feb 2026 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883558; cv=none; b=cGtK/XiDfojvsWWW/BiFDHc6alsjkOX2V8uiUaMPDPIs2iYhp5hXZzjTB0atEepxqoFSOk/kJWbFbe5V3TvU4VGbX7vsHppH3zOiemcm6Zw50AKyr1p49stDWLRTyQYq/fAjGnnczPqcXUuI8KHnc9Xpg4ukqzd359INzgnladc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883558; c=relaxed/simple;
	bh=/stCI5ijiZ7yMnH4o/+LgfD8ysmkT8zvJMlAlRyApjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G07/d6frynxmcJT+W9LGBMwggn6GBo7ml4O8ldNovT7g1nS9miHuGASVuu6UHqIHQ64qfm+yplqHCi2ZO0miXxjFYwsJ9oYcPQKwX6yPT1WMqfPRFwIsXSMfNOpn7nlkDXIEy1gEF9rOxVnaRNswsZOIqdrx7sS/426AGFkxH6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itktZGAm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itktZGAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D72CC2BC86;
	Mon, 23 Feb 2026 21:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771883558;
	bh=/stCI5ijiZ7yMnH4o/+LgfD8ysmkT8zvJMlAlRyApjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=itktZGAmcWMTx8XokiFfZPKu+31BcdMxHrphcVS9GjKORywe+FScSVJb08hfpx9lz
	 kAGmTJUPF+Rq6Ai3+nsFJn3VW26qLH1GLnotroUIwCo1D+j22+4g3loa99t+M5h3Aw
	 f2GkWVbHzLyZu9ziKMTRmoeLQlQlSrNLSZShGvgbShS/ZA7Q+5xVqohl3vhSsArRRn
	 ielYecXOETCBys8aYMFnZSg2hp/mvDybO7Ww4e8sKiCyNOgVDxFvQeXnclgWWBhuL7
	 9F3rPkqRrV3vgsqQBaDTWDcIQe8G3S0I2ICNjDJsf40h5ODMwYAKAHX48BbEOHvgcC
	 IRCxve5BqB9HA==
Date: Mon, 23 Feb 2026 15:52:34 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Bharath Kumar <quic_bkumar@quicinc.com>, 
	Chenna Kesava Raju <quic_chennak@quicinc.com>
Subject: Re: [PATCH RFC 02/18] accel/qda: Add Qualcomm DSP accelerator driver
 skeleton
Message-ID: <elu44euja7d7nnnhdmdqgof76646b3m3isjmws5pr274gqhy2a@dbeq4hk74ebo>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-2-fe46a9c1a046@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224-qda-firstpost-v1-2-fe46a9c1a046@oss.qualcomm.com>

On Tue, Feb 24, 2026 at 12:38:56AM +0530, Ekansh Gupta wrote:
[..]
> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
> new file mode 100644
> index 000000000000..18b0d3fb1598
> --- /dev/null
> +++ b/drivers/accel/qda/qda_drv.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +
> +static int __init qda_core_init(void)
> +{
> +	pr_info("QDA: driver initialization complete\n");

This print is useless as soon as you make the driver do anything, please
don't include developmental debug logs.


In fact, this patch doesn't actually do anything, please squash things a
bit to give it some meat.

Regards,
Bjorn

> +	return 0;
> +}
> +
> +static void __exit qda_core_exit(void)
> +{
> +	pr_info("QDA: driver exit complete\n");
> +}
> +
> +module_init(qda_core_init);
> +module_exit(qda_core_exit);
> +
> +MODULE_AUTHOR("Qualcomm AI Infra Team");
> +MODULE_DESCRIPTION("Qualcomm DSP Accelerator Driver");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.34.1
> 
> 
