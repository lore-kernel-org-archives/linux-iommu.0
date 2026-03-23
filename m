Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5E43C8710
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287104; cv=none; b=XtXfBGzXZy/bxY+aq2BZqUEXGxL2m0s6SlIHUFP1HiXZH0NS4s+IbinilGOOOQV9EIVU+znpNF8K1iZtD9swoihWMJ5vFO64ghKXqBJfiqedEDXe8sl8ADCTE4b/4EbKsfFpjtAn+DUrkBdjMtZszTCP5S5ZhPOTpinvHZetgRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287104; c=relaxed/simple;
	bh=mBhx/iGMR6MnTH62/x8K0OvjgYxObT0PTNXZZqCOHkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/pH2uY2nOVgpZm2ze/uRNGV72TOpktaz6QTOpopfvJGORvn9UoxbWHEusuCwNN6eX4ONspElSoLVtNV/0F1gzoc5qHv1CYzfvwIDlMY8Aco+ty0wBlF4bdQwubMxUa5clumKZf+N/Ty6fr6AYy/7/iYJ4q7Xbn7aEPvOFmuJH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VbNXjY1d; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VbNXjY1d"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64e9f9226a7so3919209d50.2
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774287102; x=1774891902; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7FawmBPSYeihgLrf84TswLXrZodyF3L+TdguCBeUDA=;
        b=VbNXjY1d8uKkb2SWV7dmbBKKpRjp41TODq6ndGf+X+ctce8o377CCUECBXZ5hPui9B
         gujA+Dpy6d8PotFCGXDnrdp1DFW1DL+KazApsqL1TJhJ4Pk9SqxEhlrcwL0z0uMgNLVI
         l2Hzsr5WrqrTFbIMOmvpV4mZaQIVquyrnhImQqVYwBayczrUD82AE8cim5jtQBF+J33P
         ujx3dygD5Wpv252Usu7zFYuH1hftSeNb9MYUEcxC3tz4XznE6yfq0P+1xBG0dc/K1nFh
         D/JpT25BkcNlc5HBXoE05EEgKkSUCMTHjzKOuxKhCjDl9wmD/BBWQmSuHGPdMAH4mEXD
         l8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774287102; x=1774891902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7FawmBPSYeihgLrf84TswLXrZodyF3L+TdguCBeUDA=;
        b=bKgXFwLMqh0FwAtpgk+cAgsRAK6N/mZIPImmZ2aG6wl8Ul15DZQAJPvcZlotnZoxQa
         rT2h6d42GSCYxNM++bWOIX2ftyWsgRBFTCjDmxOU7X+oz2T1UotWGWZ+8Pz5dvwAhttd
         JNKww4tnfct+HzhzUyUkteLYXhSYOuJuDmr8OJ1pJbyM0W53T7zjlDUnNf9zkppbaxIn
         Hhn4hZ/dKGFOcDkZtZOsTZuQ0lTWs5n4fs0eqCnOVGciwmfwvqcuZCbvS9t638vPT/R4
         iBoRCbjNcMs8AeeRxOw0mV0BBDA5EThNJhrDEx5652xca5d9y/C234PWKKIeoNOGzvii
         3IFw==
X-Forwarded-Encrypted: i=1; AJvYcCWbc6DdApDJ6rmZApEJ8Wj90H1iesEz41gYhli3ocrQtRnMj3aYvga3TJ9G98On6weXnpmgtg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYjyUN3vS8u8aMPBSyv1GoHNy8zz6ZObFgpJNVyPVEmAnUZfxC
	PnjcKhB1NNUqrEh9ojaJGcvyuXIL51Fp/g2M8IA3xR98RV2z/yNbWIgsqFX1hA98zqQ=
X-Gm-Gg: ATEYQzzdyazt1V4ckIXiGtoxixF2rU5OGdHTAD0NCP4/CGisvqdjBr8EBhoJ44DGU7s
	zbqSnPdECv67jjKLgZigXcG2wBE2NnnvbiSUSsCAFdXoe0wvKbdD8bjEzmdfGNm6ssWZiGB98Or
	ITa8yCWzz/SvABEv9SJLrM/p8UdR5YFxzf/1bklYzfcl8f4txC+Lyti1i/QAsm8KXOKlpvgIImb
	yRxJMMJRgO4MEJ1Q1Vemjvd0LVKCupT0dAn3zWG7X0jSVJyaKoAmxD6EaasXnrrFGIRAI6Vpi+8
	yddDxdRI5/H7UTa2A8iiAsNxaFuZzTn74olgduaZIHcOSjD6yd01gOuoCeuvbigGktigIVj5Hak
	ZbGTirGuFGO/FZAcL2Hzp8v1q3NH0f6chg3SzJ2ADzyA/m2cI2acCO/wru+ZCQPsDPeUo/6ibhF
	uXFoKrA/qn9VIuGM70zP7L5Z+LEe2ohCkVDDv2J0MuRXtIp32jriklmycXV1fDfUx+PmP/6w==
X-Received: by 2002:a53:eccf:0:b0:64c:9a6d:66bd with SMTP id 956f58d0204a3-64eaa6a2105mr10583694d50.8.1774287100249;
        Mon, 23 Mar 2026 10:31:40 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b36d071aasm88833571cf.11.2026.03.23.10.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 10:31:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w4j7q-000000006of-48OA;
	Mon, 23 Mar 2026 14:31:38 -0300
Date: Mon, 23 Mar 2026 14:31:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Joerg Roedel <jroedel@suse.de>, Bjorn Helgaas <bhelgaas@google.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	peter.griffin@linaro.org, andre.draszik@linaro.org,
	willmcvicker@google.com, jyescas@google.com,
	kernel-team@android.com, stable@vger.kernel.org
Subject: Re: [PATCH] iommu: Fix bypass of IOMMU readiness check for
 multi-IOMMU devices
Message-ID: <20260323173138.GB8437@ziepe.ca>
References: <20260323-iommu-ready-check-v1-1-5f6fef8f9f59@linaro.org>
 <20260323135414.GA8437@ziepe.ca>
 <1062b66d-e4d0-4eee-8fc2-dbb65491a01b@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062b66d-e4d0-4eee-8fc2-dbb65491a01b@linaro.org>

On Mon, Mar 23, 2026 at 06:46:39PM +0200, Tudor Ambarus wrote:

> Downstream we have a display controller that's using:
> 	iommus = <&sysmmu_19840000>, <&sysmmu_19c40000>;
> 
> These are 2 distinct platform devices, they probe independently, they
> each call iommu_device_register() independently.

Sure, I guessed that is what you ment..

Do you have an example of this in an upstream DTS file?
 
> If I understood you correctly, the downstream driver shall model its
> architecture and call iommu_device_register() only once after both
> devices are configured.

No.. I'm not being so perscriptive, I'm just saying that once
iommu->ops->probe_device() returns then the device is fully setup and
dev->iommu will operate all of the iommus described in iommus=<..>

probe_device() cannot return some half setup device with only some of
the iommu instances working.

We don't have any core idea of a half setup result from
probe_device() today.

> If the core's intent is to strictly enforce a single IOMMU instance,
> shouldn't iommu_fwspec_init() be checking
> 	fwspec->iommu_fwnode == iommu_fwnode
> instead of matching the ops? Because the core currently matches on
> ops, it permits aggregating multiple physical instances with the
> same ops into one fwspec.

The driver is responsible to handle this, not the core. It has to hide
this mess under its covers, not rely on multiple calls to of_xlate or
however it has been hacked up.

Probably it means something like of_xlate/probe_device has to
EPROBE_DEFER if all the instances listed in iommus don't exist.

Jason
