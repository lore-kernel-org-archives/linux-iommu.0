Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99093376483
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505752; cv=none; b=Q7hcRPqHvABRUTT0N5naQbbcUEoHZ4OUMZm3C3voICiJU6myuydSZ/rdeg65uJIs/Yoaa08HwlNnaMoGNo/8mY5JVTSe2tgyqAdWL73kX2+cY+k5V+7o5E+f+6QHBq60vy0K9ZdkI19Z41CskY1Y+5PK+Dh5RG6zSMTslp+8/9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505752; c=relaxed/simple;
	bh=QCLyIduHWDaal5TO9sBwO677I7k+rnGufj+09Tz+zfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nK8ab+XxgeehBkxUr9YemEzWtll7RCudUYDbhqHhHeyfGdIf+VIrVTSbc1XkP8bY3vlyNFSWlOBxpTofmjWKFbkwWGs0j75qjkj0bqBdVDE+OcNwHxBgTqS4VVK6rJHzb6Df4ivAV17XzSkG51ZChL+OJEfonEtYccbeV1BKvg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I17wd++C; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I17wd++C"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so1355ad.0
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 06:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778505751; x=1779110551; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j1/7qz951QFpfVmLjYKwAHUwEETJuwr+EbTrOwLd4n8=;
        b=I17wd++Cys3eWLubvE40qdLL6KWVjg94IV7Qlp5K6ku17iicMg/nRk2qgB8fPkbngY
         U9yhRwJuAzt4Q9SpeVScHwp/rTrJJJ5HsfzY9IGAMIZGGaQnXgylxrV3W/LD9l0RXfSF
         V1FKpaPEy5qGwOw6YejRBrmXeKleuik6t9bTyzM/wOT4v13bXZEJsGWgBGDqFxIzLlSF
         mX83lKKWrBxFYN9Jdoig1eVxlF+h29KGWae4lAgodhmbhaqNvGNFcQflgSOxECWtDzgW
         Kyw6TrCgM93Dz7jH4DdAfh1YrEA/7J3doTsmsE1mp3ASlAqngqZ2V+INUHMJ2/CSRqEq
         zoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505751; x=1779110551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1/7qz951QFpfVmLjYKwAHUwEETJuwr+EbTrOwLd4n8=;
        b=kPLKcwTdeZ7pVMjYM6sgvZ7o7quLYPZKN6IOiKm14U1ti6/kLPkrdp1rY46MiWRI1Y
         nPSk2sOXGjVGBpge08rUNUVcdD8++U+w6tCg+d12TidUpUDTnYXlNDBGBMyBW18m5kk6
         uDkkn+/LA4fXHOj3PSlYEmdZleuUuMHSat5loUFIjhKMAHCA588rc3Hqf0ZHa0J899oJ
         PlV7nveZEOaOXw33qlIAVv/ax8qDv+8WxV06Kt7hJVQEoNUMa5fHxk8LRrhP6+jOvO+u
         PqswvA07GAAoE55Aimd37qt+W3WE0Ft2TzlV6JB7CVTMBhdza84hG6nUIkrXPDFIOSKE
         QV8g==
X-Forwarded-Encrypted: i=1; AFNElJ/XNQTItrJBNvb3y4QQC6CroOuf3lpnE4fBR2WxOhDWoaHcSsQfmSD4D0dSl/nuFblkwZ/JIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1COk6JxJSLJenQnc59w00f7Z+bRfV5awLePZodwKOUFs48mGY
	sj5WFoJlrOKw2C58YZ1pEcdM+ZylZUm8r1+zWsOcD9wLORG4LDrmGHxxo0NfX36RnA==
X-Gm-Gg: Acq92OHNGjwl2FJPSx1cXSv4VZ9aeMWZdx0i2kZqA+G2werDeoFuoKYLGsuJ+b2mTXt
	hakgwAnzZezfXZXuColhViSATtNLkM6TOA7uhmuLJRxcmuVNZnOhvqIIWfdm2WVzJghc7JBnZOv
	i96rMXeUVRk7taN6YsouRzEMnxrVdJwyYuungHkiduUEV9kll/tDAxVDbsvtKvOwxMFfDV8HEyr
	N9N3Cl11rG8ar4SDzSWodpt1MWDZLTGK4z+73ixaPOGz92CWq3wvl3zPwIhDOCaq0nz5h8gH8Ok
	dszrKQ9Ngb1mR6DSjdwqEnTku5h4GEWfRHnAl3Nv1fJBwa0GxUD/7JrABIGGxwk5tfejK2+FtML
	V+u8oQKCkLEtZcjn1nT6L0ctSXUn7RYMtw5lal8aVYhAGD3hPdddyc00B7oygXw+HvJJcWh+ja/
	NgBciFMUh2Bs8K6D6M3iNB1gjyjOPp7+nR/OU3LjDbi/WMW/wh0OATdeVtItNVMFs/zOXC
X-Received: by 2002:a17:903:986:b0:2b4:58ad:e987 with SMTP id d9443c01a7336-2bc786865femr3773475ad.17.1778505750279;
        Mon, 11 May 2026 06:22:30 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d26968sm102835425ad.16.2026.05.11.06.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:22:29 -0700 (PDT)
Date: Mon, 11 May 2026 13:22:23 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3-sva: Enable Hardware Access and
 Hardware Dirty bits
Message-ID: <agHYDxuYyqzmAfy5@google.com>
References: <20260503135413.1108138-1-nicolinc@nvidia.com>
 <af0SdkjQOZxnnaQb@google.com>
 <20260508123550.GB9254@nvidia.com>
 <af3hWGp3etGOIdEn@google.com>
 <f31043cc-45dd-457f-8031-0cef51c9470e@arm.com>
 <af3ryl7G58D2GeWr@google.com>
 <4e129891-2f52-4bac-8e33-1fdde42fd29a@arm.com>
 <af7oyeleKFXpcIKu@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af7oyeleKFXpcIKu@nvidia.com>

On Sat, May 09, 2026 at 12:56:57AM -0700, Nicolin Chen wrote:
> On Fri, May 08, 2026 at 03:24:32PM +0100, Robin Murphy wrote:
> > On 2026-05-08 2:57 pm, Pranjal Shrivastava wrote:
> > > I see, so IIUC, you mean if IS_ENABLED(CONFIG_ARM64_HW_AFDBM) but CPU
> > > doesn't enable HTTU, it is perfectly safe to let the SMMU do HTT updates,
> > > Since the fault handlers are already expecting HW-triggered updates?
> > > 
> > > Which means our check would be something like:
> > > 
> > >     if (IS_ENABLED(CONFIG_ARM64_HW_AFDBM) {
> > >     	if (smmu->features & FEAT_HA)
> > > 	 ...
> > >     }
> > > 
> > > instead of cpu_has_hw_af()?
> > 
> > Hmm, looking closer, cpu_has_hw_af() is the thing which actually influences
> > mm behaviour (via arch_has_hw_pte_young and arch_wants_old_prefaulted_pte),
> > and that can still be false at runtime if ARM64_HW_AFDBM is enabled but any
> > CPU doesn't support HAFDBS, so perhaps you were right the first time :)
> 
> IIUIC, v2 should be:
> 
> +		/*
> +		 * Enable Hardware Access and Dirty updates (DBM) if supported by
> +		 * both the SMMU and the CPU. It is unsafe to enable SMMU's HTTU,
> +		 * if the CPU does not support it as it bypasses mm page aging.
> +		 */
> +		if (cpu_has_hw_af()) {

Ack, yes. IMO, this is the correct system-wide gate.

> +			if (master->smmu->features & ARM_SMMU_FEAT_HA)
> +				target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA);
> +			if (master->smmu->features & ARM_SMMU_FEAT_HD)
> +				target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HD);
> +		}
> 

Thanks,
Praan
