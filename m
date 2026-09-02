Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA3E41167E
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344409; cv=none; b=Ws6F6zXMfYdakTUmbVXL+LqQQ/DCEESTRwpIAAiMmE0ooWgshXR4ISDXFrsCb0GiqsCJbLjKx94BvKiATuI8oRNexs1x2V2Zxbs4dRMwmKTfjE7Cb4g/uZ7iuTsXeN2YKGJUtQbVqesQxyhycZJdYqnHIQqgulZBCB3GlGmex3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344409; c=relaxed/simple;
	bh=T30qkz+9M1LAgOwevzA+t81YqEwTEd4VZwPPpeZk2CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQ2yzpGxTT9Rve8YbVuljPoHEq7J+f5LBlOF0CDGcGxKiHOFg+Wb2ny4weFeAIJJhRIssMfLXxQRaZW3734RY4oeTcvuyGkuS4awZYg37ybr6tqPp98WvRUwjy8bfJOMOGdDPReeJEBca82jQFFQimP/rS3qqWro3JETQKw747E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GjYBaVeI; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GjYBaVeI"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a5d8fd8d88so198a12.0
        for <iommu@lists.linux.dev>; Wed, 02 Sep 2026 03:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788344406; x=1788949206; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CaxTmsVsqU9sdyQdLqn3gY9Snjsgo09/gCkOT4Ryv5I=;
        b=GjYBaVeI+7hlEJd98DBfoJWaIPb3f954K3sbOQtyHGcY39dBldXVSkENp2HikP4zo3
         n6oLAqM9T8124dG4q4QQhk8ZVGZCl1ZqMJhypGu56PMCfx7Aktucsv5yu2tTvM5QotXq
         ozud8r+jFTLIxv9pec9tq4Q9zLJrcfeXz93IT2SRREaHM/OdP22PA1W9HMfBuPw2GA8a
         IklWm0WQCp7plKeoLfRC5IUJi3/uRqIANXzNl5Ll9j/EyVHFpb2/Ap0iaWc38gdrOZIu
         9wsVypuhMJP90h2PqqghCg+w5UCTXq/V32LM7HydkW6tr9CR6eBa0OJNofa4YvHcolxo
         nSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788344406; x=1788949206;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CaxTmsVsqU9sdyQdLqn3gY9Snjsgo09/gCkOT4Ryv5I=;
        b=AYGoeWS7qovVNfxej7ShcIEsXPHo1DiS19vWF7mzymp4u86VcsgJNaeVgjd96CzMDr
         RoY80on/3IADZQW6lByrExO4JEFQl3+a1ZOkyNOMw3Hpig8eU6Sxk21LyoaGURtED6dy
         +686xRyEEMILZVVLs5YXzRIA70ZTMvtJwmBQHwzRnazgcLIsRnu3XLP9JHXuicwIb00Z
         hITXD/A/pq7W7dnFEJ7GJ/JpMBTBteHJR3zCCWyzo8NFuqw754RqN1jwlHqamBTVCLPR
         TmBTGprpLozo0TpuJa9LWpWF372uF+R+Zud2U1MzZ1WTT7jQbuV9OgBl0UXaduSJaKFF
         Dmkw==
X-Gm-Message-State: AFuF++nb4dE10hsRO3nzbS+Ten4SBDq5KgWlsUNVSRZKkbuGamucavNc
	IhATmAhN5FefHp/H3VyeXPMN5Itq0HIx4At1c/cyA+3Vo8gz1T0YAy4IUE8iPU4YM79GPv6HH1R
	VVbbhuA==
X-Gm-Gg: AYBFou3bNv5cKhBveE7v01ywRY+rXmFd8oQ0h75/jC2nLGALhJqXQSgoeRYYT8UUlgn
	W2fC036gaR6UIZuMe8oU5lXU6L08gd7jd0DnHBHssZllVZ5RA41YjWydm23dUI3HjMSZdCEdjyu
	2psDsvs0s36whwEjDEMLuesZLOLPSzyKBeth99Z3OX5zKJ9322KPEn8PiquhahVp+4N5QKVmaOY
	o48uTdyOn0y8KVSBKLtZkqzt93CQxS+mFPmTGuOrUFauZVj2McxbG3xl0qa+SF+W5ZhP2XieRf3
	3VNy/0lJcTmSytfdgVJ6nVCoF9UJrtz82tuvlalfUEWcG9Ud1pPpau0JXsd0ZCH1dzHe8HHq9WE
	Rf21aqjvjd46VE/KTl3mhpH0unt4F3pYZk11cONOZCv8A6f4UqIvmSzV2oxZNL6nX4QaoW/a4nM
	bKG9ekZbHpJo5J9EvqzWB4hPfpIR92mk/hsKOM7oXl+lft12sQxiylChM0jwsfr4TVq5sa5dLAT
	4acQ59G4z1OtufPXzWnn0oQ59IZ5jgB2EjPZqM5
X-Received: by 2002:a05:6402:514e:b0:6a6:86b5:f5c6 with SMTP id 4fb4d7f45d1cf-6a68da6c737mr1486a12.0.1788344405146;
        Wed, 02 Sep 2026 03:20:05 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d041d4a8sm107261866b.54.2026.09.02.03.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 03:20:03 -0700 (PDT)
Date: Wed, 2 Sep 2026 10:20:00 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Timo Witte <timo.witte@gmail.com>
Cc: iommu@lists.linux.dev
Subject: Re: [BUG] iommu/dma: "Not yet supported" CC_SHARED rejection
 regresses dma_alloc_attrs() on SME hosts with IOMMU-attached GPUs (commit
 8277a12d0d60)
Message-ID: <apf4UNuGx-jWd8jH@google.com>
References: <CANB4YXS=Nf-co3t8eMHtqrW4sn=1BDcP6o=EoTrgZm0WYMYTyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANB4YXS=Nf-co3t8eMHtqrW4sn=1BDcP6o=EoTrgZm0WYMYTyw@mail.gmail.com>

On Tue, Sep 01, 2026 at 11:09:03PM +0200, Timo Witte wrote:
> Commit 8277a12d0d60 ("dma-pool: track decrypted atomic pools and select
> them via attrs") added to iommu_dma_alloc():
> 
>     /* Not yet supported */
>     if (is_alloc_cc_shared)
>         return NULL;
> 
> dma_alloc_attrs() auto-sets __DMA_ATTR_ALLOC_CC_SHARED whenever
> force_dma_unencrypted() is true. On an SME host (mem_encrypt=on) an AMD
> GPU with a 44-bit DMA mask hits that condition, so every GTT (system-RAM)
> allocation fails with NULL/-ENOMEM, amdgpu init aborts and the system
> boots without a display.
> IOMMU in Translated/DMA-FQ mode (iommu group 29).
> 
> Before the mentioned patch it worked: the IOMMU PTE carries the SME C-bit,
> so the memory controller transparently decrypts for the device while pages stay
> encrypted at rest. For IOMMU-backed devices force_dma_unencrypted() is a
> false positive - the device DMA mask does not limit addressing once the
> IOMMU translates, so CC_SHARED should not be auto-set for them.
> 
> When i remove the rejection and clear __DMA_ATTR_ALLOC_CC_SHARED
> in iommu_dma_alloc(), so encrypted pages are mapped with the C-bit and
> everything works again.
> 
> Maybe we can implement real CC_SHARED support in the IOMMU path,
> so SEV + IOMMU works on x86?

I believe that is the way forward, but as the merge window is closed
it won't be possible to land something that big in 7.3, we would
need a fix for the regression for now.

I think your suggestion works be clearing the __DMA_ATTR_ALLOC_CC_SHARED
from iommu_dma_alloc() but no need to remove the rejection then.

Otherwise, force_dma_unencrypted() can check something as
use_dma_iommu() but that feels like the wrong place, as the HW does
need to decrypt the memory and dma-iommu would be the one knowing
how to do that.

So, I'd suggest you send a patch with your fix.

Thanks,
Mostafa

> 
> I already reported this in the amdgpu driver:
> https://gitlab.freedesktop.org/drm/amd/-/work_items/5735
> But i think it should be fixed in the iommu code as it's a regression.
> 
