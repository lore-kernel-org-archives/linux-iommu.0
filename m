Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161E23A8
	for <iommu@lists.linux.dev>; Sat,  3 Feb 2024 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706927423; cv=none; b=jVDdf5c0fb3OxiM1iOLBnYEVjZQEE6fNFUklsFm3Y08DAB9hSbMelW0o+62VrXGpQ3ZXzPLstDoKspbZPcCHwEOb8iJ1WZ9QHgAIYFZ91edOZuBGx/DEtLk+eTkkBIE+hDi3krsfIlp2KSFta8NrmXNc4z3qtYFTajh4Bbjxx0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706927423; c=relaxed/simple;
	bh=31MALDMSUlwza8Dx/4jdfU0IQzumSFSUtKLVbEOi408=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gYp6ifBV+84N9Xm3uOCmoldBiclVGCkosYPgR6B1URqqa23odl3darSmCag8NCoUcOAi9j/b0PvEAHZ9BlDgdD9ws0LbY8DlZfb5uh/tATcYlIM/pM9SPU/Rmfwnd7GmBLQVh0ZJ2qsukNYOHu+yJP+9KcpnpSL6Mm28vvq0xiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bUWHeEWe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUWHeEWe"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d5ce88b51cso105035ad.0
        for <iommu@lists.linux.dev>; Fri, 02 Feb 2024 18:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706927421; x=1707532221; darn=lists.linux.dev;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XiG6CHWcYdWsI51hB+FTszglKDybzSu63LtpZjDM7i0=;
        b=bUWHeEWeLgknVRwJrlUBIZ40h+nOWSOTJVNZdvvn6cVuam08Ok34l/GpYhucuZ5jWD
         HtjIS8b0S76Z+dcSbTfHxcVbXVfw4TREvA3MP41hKlwHqhNWwwrZlBbCfxuWoZlGZN1e
         7b/3MA312N8Evw6Vbg0ruuLxFVBt0hcuTjzlZ5fsA2dILW63gxycRfp09lX0DVUwZDlk
         V9q69eNn4PcJWlbpApQnQ695eydO/xEkXl6B7GwcrunVBVUQaHPbdcV8kZiCP2ZVL7lD
         rhKudILINiXsO2tzoVut2cA0pmHjwwKVwUJ9VqeY/EwBJgcwOr5dNuVeHNec53s4aztb
         vLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706927421; x=1707532221;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XiG6CHWcYdWsI51hB+FTszglKDybzSu63LtpZjDM7i0=;
        b=dIGJgOnuwM9LKxaZh9uEwK4lhHU8Z0sYcoHQVPasWx450xGkWrpvFhBMmP88dCxcyI
         Uc9RXTCAUQTfqqKFn3X0/a49SlC5ZC6U7k0CL9/Sa06Crra1/R6EHflGUbEhAe446RVf
         SVmcl81Y7/Xv2cOmNAVaVNETwFI7QmdrUNwuCKE6wzgDtJdUaMJYksxqd92KLN0Cfy8/
         1LMgpG8lKtMN1tASTUVWRk3WNcAspCDgOn1St+OaE7VEmkSncnJr1Bl3uQDXtVaIeGQt
         H75nCFj3I5Xsz8QqpV0upmUDNyp6yXLyNhQ1KPW9Po9+tpnzPA4oOnkfR4OBuBs4UUTp
         iTWg==
X-Gm-Message-State: AOJu0YwZlyrIAREdbmD19kxmTOwI5GL39JvB8/NynGn3anIoHQmcqKUG
	xMSWXr2CkO9DiQssiU/JuCBabU7L3GT03iQq2SVvTT99f/Xj3dPCwzGd06dRQQ==
X-Google-Smtp-Source: AGHT+IHg996dygyt9LnIiSvyqK9FLVoUTcVkp9Miw1CYvlt+COnosUlv02z5yOlwrNv7Cbz2O6gz9w==
X-Received: by 2002:a17:902:fccc:b0:1d9:8e37:56cc with SMTP id mi12-20020a170902fccc00b001d98e3756ccmr24869plb.10.1706927420652;
        Fri, 02 Feb 2024 18:30:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVTJg+AEeBfOkpo/qJURUeu9o91x/nT1ZbAlXanN+fx4CgxYbFsH5DaRxefHDJLKAYgGLQ9IF9TOBbXgio9d1sxnArAMI62kfjIQwVRJFFH1C9Ih6WTB1vIMmmUJuIENK0KKVsZQ4f704yNfhvb8lj6P0i5wwsr5hTBgf/Qp63kzfRV9uhpKaPlEc3BSUA1ANE+aU210RCJmd+3VGAQMclintHIwqZRC6nPSf5y5OBzfg==
Received: from [2620:0:1008:15:5706:ac37:6d6d:7587] ([2620:0:1008:15:5706:ac37:6d6d:7587])
        by smtp.gmail.com with ESMTPSA id t11-20020a17090ad50b00b0029658c7bd53sm747960pju.5.2024.02.02.18.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 18:30:20 -0800 (PST)
Date: Fri, 2 Feb 2024 18:30:19 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, 
    iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    yosryahmed@google.com
Subject: Re: [PATCH v2] iommu/iova: use named kmem_cache for iova magazines
In-Reply-To: <20240202192820.536408-1-pasha.tatashin@soleen.com>
Message-ID: <d506a467-8af7-dc26-709a-ba49e6c5a3a6@google.com>
References: <20240202192820.536408-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 2 Feb 2024, Pasha Tatashin wrote:

> The magazine buffers can take gigabytes of kmem memory, dominating all
> other allocations. For observability purpose create named slab cache so
> the iova magazine memory overhead can be clearly observed.
> 
> With this change:
> 
> > slabtop -o | head
>  Active / Total Objects (% used)    : 869731 / 952904 (91.3%)
>  Active / Total Slabs (% used)      : 103411 / 103974 (99.5%)
>  Active / Total Caches (% used)     : 135 / 211 (64.0%)
>  Active / Total Size (% used)       : 395389.68K / 411430.20K (96.1%)
>  Minimum / Average / Maximum Object : 0.02K / 0.43K / 8.00K
> 
> OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> 244412 244239 99%    1.00K  61103       4    244412K iommu_iova_magazine
>  91636  88343 96%    0.03K    739     124      2956K kmalloc-32
>  75744  74844 98%    0.12K   2367      32      9468K kernfs_node_cache
> 
> On this machine it is now clear that magazine use 242M of kmem memory.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Very impressive!

Acked-by: David Rientjes <rientjes@google.com>
