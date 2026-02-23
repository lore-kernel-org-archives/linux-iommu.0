Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5133B3793C2;
	Mon, 23 Feb 2026 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883436; cv=none; b=PelogawUNJeSph6yqOC+KG3nnhwVaeHu/YQdMboBbx2KtjIjCYs/r8tam9oiiLRX7xIzN521Z6v155hrMo9EFDebzEaZ1aWC7RS1chWnvMLe5Yh0X+dQvV7suRxjLFK8d9elQPjzyFVr4cb9KDUu21ER0ad8G0tnswGfo1WyBpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883436; c=relaxed/simple;
	bh=yIA0DgDkXMAJODpAWpRW7m141h+JUK6FbQ2KGDgNbrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBOYIjkLV6ncxcx56vJrbVyZEqEV+QYcoMWv7goQoHUNpkb5zD9EJI2spUAbHgkYkhj3BVcv2x0z/gIioksJgdG91EBUqmppHUBNXQ0aRXuPQ6dXtALNQshG2CMS6daXNFdk8wFhB9wLlHZaKLuEmOTDEp+XXPBl8y51zmg4QRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Te00VyXD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Te00VyXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2779C19421;
	Mon, 23 Feb 2026 21:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771883435;
	bh=yIA0DgDkXMAJODpAWpRW7m141h+JUK6FbQ2KGDgNbrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Te00VyXDEw7O9qzDqt5v7jEtrHMEbx6c9Vtk7RxnF7k0Dp91xZ3EJ2vQnDUw2vaNa
	 clevf3aPPW1sbv5R0tIqbMhsNPKPyn4xEHCv14i8e7MxRqWk94xM6plH1RXvnFutUS
	 aXEOQa9O/LGlngkuP1mofF6qRciBXhGFMS0kK6pKV6iW30/rWHwghCDPkLonpkOYUW
	 2+IcVnIiRAV+4VZZLlJt1gu1HxTAUabDLN5mQCCX7M6Vun37b1bpgqSaV1D2aGrTrt
	 hzXVx3RohDbC3w3rS8/RVqGjSbXXIgsoGRKzDVPefPMvtIkIi/qkxxbupU/h36bRv0
	 Jy6sBufMjrGRA==
Date: Mon, 23 Feb 2026 15:50:32 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
	Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
	Bharath Kumar <quic_bkumar@quicinc.com>, Chenna Kesava Raju <quic_chennak@quicinc.com>
Subject: Re: [PATCH RFC 03/18] accel/qda: Add RPMsg transport for Qualcomm
 DSP accelerator
Message-ID: <lyco6vkfjlerri55ldyn6fbhihbkhnuolifddcnscevybsztq7@ljhjln2ynmid>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-3-fe46a9c1a046@oss.qualcomm.com>
 <tqsdbijgjomrn7fq3sdz7v2axwxqvbccpjh4fmvod4kbrq7pod@af3igw5dx66p>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tqsdbijgjomrn7fq3sdz7v2axwxqvbccpjh4fmvod4kbrq7pod@af3igw5dx66p>

On Mon, Feb 23, 2026 at 11:23:13PM +0200, Dmitry Baryshkov wrote:
> On Tue, Feb 24, 2026 at 12:38:57AM +0530, Ekansh Gupta wrote:
[..]
> > diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
[..]
> > +/* Error logging - always logs and tracks errors */
> > +#define qda_err(qdev, fmt, ...) do { \
> > +	struct device *__dev = qda_get_log_device(qdev); \
> > +	if (__dev) \
> > +		dev_err(__dev, "[%s] " fmt, __func__, ##__VA_ARGS__); \
> > +	else \
> > +		pr_err(DRIVER_NAME ": [%s] " fmt, __func__, ##__VA_ARGS__); \
> 
> What /why? You are under drm, so you can use drm_* helpers instead.
> 

In particular, rather than rolling our own wrappers around standard
functions, just use dev_err() whenever you have a struct device. And for
something like fastrpc - life starts at some probe() and ends at some
remove() so that should be always.

Regards,
Bjorn
