Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300356;
	b=cAYuCcEEZo+R6KGAkeFg5YaHt9kpmM5JmV6wrTwS+VSQCZuqBsv/mn57kDYWC9SfY0Id
	 yznmH/DphIewX01tStVkgjDF1BwR+XCWof6VJyEZKMw7oT/nBiysYez2tN3kT01XwTOzA
	 rjFdu1O5VaVhzPdKZQPPFW/EdNT8YW6eVEeY1b0b9PW618QjEVBU67Q9h1LbnmI6H39na
	 Gdcrll+Gyq+VrYOXO/9xs8FEhrrGCi/nA9U1mt3LcRbixpKYE4SFpepWB2Qlkr773iCEy
	 zVnbeDyDlLpk2tEX5K5b9DW53APNgNsFHDa8l1E8ko6s1gK9NY2IMg0KwLdsjkQCfOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=K0Ytmrnk1GXIgM1fqIrHZ5HsCVM2IH42icX0Nl0p4uM=;
	b=xEKgJo+7hKRIKpEEFWst0HNWZopV7Hdnh8bXiPCed4LLpFDqXCJp5fszsADPtXhGzekM
	 XcASW5lmOyXg9rI+iWob/mT7azZ0yl94iFMwASo5lYTB/f7B3td3KIQbk2LAAZHAgf8tJ
	 r2JtTnPMrid/8wgnN65QgivoGaZoABpLwsGHYte4DTz4X4q34bEjB5OCumP2YJ5QynZgk
	 gthdqdNsuZOlTCI8fvuNgaUc+cMCswh6f102W75Q+/XfMOiM7sI8DMBEcpCeLbpHoKvy2
	 0n1i21bl5YYw/ySF8gM99rKGqM3eCL/PKS8yOSCbmtFRgsxbvgy0rWOP51/WLMtWgYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE575606A32D
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 18:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE575606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so25127375e9.1
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793300349; x=1793905149; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K0Ytmrnk1GXIgM1fqIrHZ5HsCVM2IH42icX0Nl0p4uM=;
        b=n9Vivb5TqpsSyppk6cFWW+1D31ir1UyzZpBK7DVSRRChQLLaDj31UlBbNKx4YmWXag
         zVhyfGXJPH+MzNLrU+mvz+ENl3bIjy/90SAvNWgNhkrBVwEvyG8vIAIx3UPabgO0ZtCF
         ZRyH3umxTrS+VkQXUxVvWPZIPfKSWRFwu1dTt13Rj0cby9fCf5XCNBBPLcWGetGiWhc3
         6F+xzB2w2OZ2k5ca07PTeNGvImsviLMMbUzVnHjVp0ryII+FiHdg9e7xBxuZe8lEriln
         sooL3S6eGLjAekJY4vYbjolm+Pvn7suKQndQusP8EWjwsAZ1xE74xGLP7+JZOW+nc2Xn
         WlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300349; x=1793905149;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K0Ytmrnk1GXIgM1fqIrHZ5HsCVM2IH42icX0Nl0p4uM=;
        b=S5SxCWzSQqlKOcCkUkzKFvw5LItxwxfEhabbYY5RGEPc4ItWkb9Jg+sKLIR38KHr/s
         TGsNIXA/VGGHW/EzofSCkfkIx8sHM+ITyXF975ZgaOhgK5cRDaYZfXzZnHhcx7037gF7
         H0rcR+26fHa0t8FFhpx91YuyVdqz8WBFhoXWxxOjaTQ0nBH+/t0Zoq9+WnEPRwGGreMT
         6FQAvZXpih0N2bkZETHkxRM1nNIpIm0qiR+mj9yy48Y3lb6fmHW4mwyRj3Qp3xAMA5O8
         kLQxRJEcG+nPx3dnJSxrC1nIGk+aGImbux/g+FmGkFLP3NwlEQgsJEqFZ7EZzzibqQHe
         CXxw==
X-Forwarded-Encrypted: i=1; AKwUvBzxGej+LjBefH/1O4eIJw7T3qydJoXdE1hXnpksv7ZyLa0IgCjM1CnQgLa7ZjhVms6PSB0/EA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLTMrg9aPWy/7x/D4jgoA/dgjQml+1tfsJpDyQ5QtwLuagutVR7
	N8Qk4afCuIKpR5lDVsGzULUeTeMmj24RCdtcP2v5Tb9o/AoHBUzLRIV0
X-Gm-Gg: AYBFou2NXkGIwiURyJLPJ7MNE0LjmnumBuh0LxzEIkvgGn1bQ0JsS3dpCVSEiYnAO63
	tjIAIag5LJXZIvycsrsR5Ja/gM44R5sk7e+oVA59RblFxYK3ZkUbK0XGLNPX119Cz7D0IuQ6kNG
	VnAcXcKvvk6BWMv0mlUFcgZO6lvJBjDRUo6xMx6JeZekd7pmloYJumHkrIu/lDfaMhwaDXtdESE
	FM4uEc0g1NNE/bGzP601No5mLOBw/GrnwcL+kvWfYsuko84V5VYkSiD9zBYRMJphDIMPqFUy/kD
	F9GDiPpjTX8M7t9j2Srx12GBMZiJDCgxYjV24I7Z1C4bBtPb1JMCVZsEJTD3sVGK3PXkaB+dkZb
	FlK1/pv0F787bErn9c8hLnCzBWiEesGVbagJF/UdrXCkKORRrUjilOtfWE1caFUn5wY0331jh2n
	hYoiYxUIYFGrCpfoU/BmtlX+AaBcigz+oRHKWl/0E16zsYbqbE6UitIyim93La9wvoW3zgLhdtm
	tg09mprhfvTkKaVAvyhkETFKNCBuckyrAZOYpE1ilFaxI8JtVqHmCE5fSvFwrzQrPuc1UZxD2TT
	y2De6mgjDffOcktom3FSVCnUAWReqsG/fuXcBkQ8mlYuy/J2nIJrMs9uEgPoouH0gCeDKV6qA5N
	8SjU3wgAYS0MxJcl2tSeJ2vPZ2jJAvBs7SqWclKHv68v9J1TlDnh5AUzqG9EMlldToihuasah2i
	/o7AnReP8MrwLu
X-Received: by 2002:a05:600d:4121:b0:4a3:59c9:a758 with SMTP id 5b1f17b1804b1-4a96836988amr152798385e9.32.1793300349381;
        Thu, 29 Oct 2026 11:59:09 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c76507sm4933955e9.10.2026.10.29.11.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:59:08 -0700 (PDT)
Date: Thu, 29 Oct 2026 21:59:04 +0300
From: Dan Carpenter <error27@gmail.com>
To: Frank.Li@oss.nxp.com
Cc: Frank Li <Frank.Li@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alex Elder <elder@kernel.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Guan-Yu Lin <guanyulin@google.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev, netdev@vger.kernel.org,
	imx@lists.linux.dev, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/1] PM: runtime: change stub pm_runtime_get_if_active()
 return 1 when !CONFIG_PM
Message-ID: <auOXeGVQG0UHeoQb@stanley.mountain>
References: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>

On Thu, Oct 29, 2026 at 12:30:37PM -0400, Frank.Li@oss.nxp.com wrote:

> Pattern C: ret > 0 / ret <= 0 / ret != 1 checks -- FIXED
>   drivers/usb/core/offload.c: checks (!= 1), old -EINVAL caused
>     -EBUSY even with !CONFIG_PM. Fixed: now returns 1, proceeds.
>   drivers/accel/ivpu/ivpu_job.c: drm_WARN_ON(<= 0), old -EINVAL
>     spuriously triggered WARN. Fixed: 1 > 0, no warn.
>   drivers/gpu/drm/i915/intel_runtime_pm.c: checks (<= 0), old
>     -EINVAL triggered error path. Fixed: 1 > 0, correct path.
>   drivers/accel/ivpu/ivpu_sysfs.c: (> 0), old skipped freq read.
>     Fixed: proceeds correctly without CONFIG_PM.
>   drivers/gpu/drm/xe/xe_pm.c: wraps (> 0), all xe callers
>     (xe_bo.c, xe_shrinker.c, xe_vsec.c, xe_ggtt.c, xe_guc_ct.c,
>     xe_pxp.c) now correctly treat !CONFIG_PM as active.
>   drivers/net/ipa/ipa_smp2p.c: power_on = (> 0), now correctly true.
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c: (> 0), now correctly
>     executes stall register update.
>   drivers/staging/media/ipu7/ipu7-buttress.c: active (<= 0) early
>     return now skipped, correctly proceeds.

Pattern C is mostly bugs so this patch should have a Fixes tag since
it fixes bugs.

regards,
dan carpenter


