Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC52633CEA9
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497989; cv=none; b=qyQx1k2IL14RGrcqFEDksa6XsTlKiDbHScw0JPGFqbGN+5VY7TJyEg5RGvI4ZA4MFcIaMkxK+tyV5srNBkXq7AS9te3Xw3xITLRcLZR94fj/jAd+taeyXfjnrwR0E4ETkFQzzQlecXbdCRwGMGDu6zJRc/eCk5V5+YW8nEixV78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497989; c=relaxed/simple;
	bh=tGBk5L1oFJO/P+xtNYGuto+/t9YS1RPiu3G+FYN7QOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/0xK5zXvPzMsHH1U0tyfXn6kMR1cc4alGZ4ZvLmJaX3z3+wdZ9Wfqr7VB1gmtrcijvNPTz5Wzdcp71vGCMJ90ZRMhsJ6ymuMB93/gv/3LQ1AocseQvZgnz8sHHvThGwzsivLYChRSHUeed5xt/kKp9eZISbUEBpuejUfspF8w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ps2oyRC6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ps2oyRC6"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0b1a48855so93705ad.0
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 07:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780497987; x=1781102787; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NqOHLB4Z8uMw84hLhaHogABPafTAVpzk9ZFgr9w7mCY=;
        b=Ps2oyRC6TxgH/AYQdMsYZwZRBSfqCEyRUDySVwEFGMN8LNuPMg912pjLpyGHEE/JcG
         nOIMCwOrRxZG1PpCVxz+UdRsa1Hwq0wHAytYh42nQ8E3mIecCn7wuqzNvEqAY/TF5V1H
         2jBv5Fion5Dl2bDb4sZY+1HsR1IlpHYsDG0yO/IP+R/GF1esl1y/6a40IY4i42hfTqJ/
         /7cvgRgI4XJLJZzDptqEnHCayVVC38seKasEXaOMSLheVT3p3o7chV4yewwZcN5GOvCH
         t0eGK9wPMdmYvm+Ojlrgf+EnlwuhL/lJ4NKImdoPooKbHuPnIhLokOzD06XbqMhHCqrQ
         akpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780497987; x=1781102787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqOHLB4Z8uMw84hLhaHogABPafTAVpzk9ZFgr9w7mCY=;
        b=YlWYofgtdO5V5HwXcAHtWUz1FWJ3K3C55VtqYl1OgCOfAPeGCrEQ0pyrZECNWLGw/d
         8EJwyuv/526wZFKCgpdB+rsdYUQCCEmxKoFMeA2qWGkwTofMXZX0oxYxdFnJS3P525aZ
         Z4D3KIRLcXBfsR8udbBm/yTHxLBqQbZ7zeR6y24GVebN+VpRAilbybNcWsy+IzdY4UEJ
         T37Vr7UUKUejz309iYKE8vH+PxuunAg8Tb6l6Ppye94qU2a1sWlbas/b+zQ9fLYeP4pw
         3OWBoWRzXWTsLy0kUWOBArL6g5/FEJc9GFerd22ZoFsgmueohA1WDMz9SOAY2QEUNEqs
         afBg==
X-Forwarded-Encrypted: i=1; AFNElJ/ohJtZeCJTIzRa+HoLgKk8GT/viuUJSwewz/wL/I7toovxjLZmnBnUU5Fr1gRe3vE2jDkQMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwRRFZrOIPTRslngXYi72DGbwZmyvTyVYhMnTlomK65Cfw/t1eo
	EW7qznFYe+2lPCec6ewoVDtuBFihe+tv8I1r43C1b+fRsBYjQ2996Ds/liEUP5x3DQ==
X-Gm-Gg: Acq92OEUSuTjrz2CWHljhmfzMt30iqMUnlC4lPRAjao0NITPYNkdT2ZLMAf9pYA4BPN
	EYAmNP/yoaP4EtGLRvIKWTR4teL0I9mWj5w9kH85AKNE9EX4ZHlkon3V0aAziw8QhrCpeXG6Txb
	PptaGo8HErDQpWBh9aa3Qmgf5s5UM1iCaAz5I2dPuqgugZfx1iH8YYTg/m4OnomuddXxf1mp2Ry
	LXaOFFOP3Ce1U5JyLZBtm5U8oHYNgt7+WPZOVru1n6Ga5wpHDQLw6SWGjiceY0N1IeyyyckIUPn
	ajolDA6+P1kJlA8QGs3PyQQeueVjXWVOlgx/e/r9zv/r0ZT7vaoavzMueJvousP/IsRqEGNIdAe
	erYQA+YopzJ1THyvUjtdhAXHd8H2shoXt4sNxSs7PdK9Bw2CEC3cHsyKg+RdGjGGotqxl9qz42W
	bZqeJztAhWPXAC8Rx/4vGpaaxCsU6Xfz8Yd/7a+hQOthWezQqumwJm7Uhty/sFFqcg9PDJ2F8=
X-Received: by 2002:a17:902:c408:b0:2c1:5756:1230 with SMTP id d9443c01a7336-2c16bf60842mr2091185ad.0.1780497986471;
        Wed, 03 Jun 2026 07:46:26 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282880050sm3185925b3a.29.2026.06.03.07.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:46:25 -0700 (PDT)
Date: Wed, 3 Jun 2026 14:46:20 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, joro@8bytes.org,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 7/7] iommufd/selftest: Cover invalid read counts on
 vEVENTQ FD
Message-ID: <aiA-POwZ8KT2ijUV@google.com>
References: <cover.1780343944.git.nicolinc@nvidia.com>
 <7bcd153d306f2cf04c094c728c0ebe146855072a.1780343944.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bcd153d306f2cf04c094c728c0ebe146855072a.1780343944.git.nicolinc@nvidia.com>

On Mon, Jun 01, 2026 at 01:42:38PM -0700, Nicolin Chen wrote:
> The vEVENTQ file descriptor must reject reads whose buffer cannot hold
> even one event record. Add selftest coverage that exercises both the
> empty-queue path (the upfront size check) and the non-empty path (the
> in-loop check that fires only after an event is fetched).
> 
> For iommufd_veventq_fops_read():
>  - count == 0 and count < sizeof(header) on an empty vEVENTQ both
>    return -EINVAL.
>  - count == 0 and count == sizeof(header) on a non-empty vEVENTQ
>    (event has trailing payload) both return -EINVAL.
> 
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
