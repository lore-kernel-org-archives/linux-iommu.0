Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA692F549C
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759395; cv=none; b=K1Kqfu24S6Yz4gvz0S9vTAlk1lDc2pIRPaJk51N5xxC+XkehmG2XF0MUu8NYGW827nDflrklx1lsZ12griKAv/a2KyCp/kwe0fkj716x6qEe8QnnUU62L1p2ahAjZ6Q+UB7JsR223s1SbHldplFE5RIadbKTbd4p++ib+76fzzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759395; c=relaxed/simple;
	bh=ODMC7InBF06GWssENCFF35L7QXBK/pKM+fNN466Ya8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbg3fSBKgdvbMU4LiIJwAwfKMmgYZS1nfl2RYwgWDaW3XyJvQI+CZdCsH9eiMyAckmhIffinMgEH+yg+MCUywojyWEsD/OMlXAjaFNp2uHzqeWuigNCw8Sj5qMQlSEgAuoptpxNDPgcjVlHjQPmvUu7xYprdZM+wW2dDmBsIZt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VLOQj4F9; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VLOQj4F9"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50babbce85fso12982351cf.2
        for <iommu@lists.linux.dev>; Thu, 09 Apr 2026 11:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775759392; x=1776364192; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VPyWPfO2ahQ7vvuDxRFUZN9wGMKQdVim3FCtdZSzgeM=;
        b=VLOQj4F92xqPUmXmBVYgLxs75twdkjpNBZ4FzwJ4DuBFboqyVWXoxij70b2aJ9oKVB
         hsDIpvTZh/zaMEX0vmGkQrcfwrSSirexqytfEQEDwzpoL7ookuG9z2/hHvGjpPD7pGKn
         tgM+Ytm76KwZ3dMGxm1r7c81Rv3F0+cAiO3rMwkWcUBA4dwQw+jvApAy+si8zU5kUBl/
         tXdcx1eNqubLZsov6hDGHH5ZidP77Ch3aZtj+wdg/SqYgxEFbNR4IIzrb8Ep+dcXyu76
         2vthmEZpIJtxeDCTI08uQKqEZvGjTNgi0AMZOvZX1mqH+sgKrJrUnxAJLgizhswvg1f3
         ih0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775759392; x=1776364192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPyWPfO2ahQ7vvuDxRFUZN9wGMKQdVim3FCtdZSzgeM=;
        b=LHLnDu68Q852WALpIml1EPEJhQjFxKMcv65WwqenPvupMV24k8Jmd9c1goUf9mxqIg
         5RStQ0uvjLSIrIARiWPP6OIxBu02nMCbqkQVmvvPsc5mIA3M8W1DPiOM5HGIZFWD2K4Z
         GYLz3fWyqlokX5rUqf58TT27nJSmzGVF7nCipfvra2Q2WC/hKjUXr9A4+hIQzypA3fut
         Smjt+AeD0j5C0rBNPNnwrMQMZMscQCcA9VoOMCSXrkbB9Moro/XYH2iszMZFznwjGEjT
         qwU7XQYBkENOF+W7DEyNJRrPK5Od+TnzNNmd+cxMRWfDJxjAaARB8bb5449QcSNmYXdY
         QT1g==
X-Forwarded-Encrypted: i=1; AJvYcCVfHsz5owQmNrMfjecqFNjLR5qLIrKoqqMFxqiF6KW3IsNmpQ/aCElkqHxh8VY368uOndAJUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0U/cSCl4nKhwJMRMXHxxSW/7WA5Juxx8s5HKEc15kWPWpwy2i
	ljuFeR5HnpUNW7MQKyC98WF7l1ok/3LF2TiK7dHSROlFWTrt27umQhMxBU8v2m4hvOY=
X-Gm-Gg: AeBDietmYJ3F3WjtlaFQFZannoW5c+2vIEMZID/YKL5HSgAnIyqj5+v6EayEHQQJoMK
	WK/8cNwaurfqFGij1QxgBWvU5XCC/7aq6YQGgIsMoFLVIQj1EIDm6HbDqvdxEE0dMCpdFd8mKFY
	wOw9q1cGCIC3T5vbWuwk0cFwzNT/RQGtnMZjI111eRt+FkXWv4CGb831YIMZNQ4nXmagjjHvwxx
	5ZJP5Pg0WcmOY5U+o4SEIe/1PfBBnICfEHQayPAsrFPdi98TSph2iMCuCh9NAFc4TnUTT7Ld1mC
	9oPig2Nmm3qve7gKdTTlVdUaiEz4hSeUw2fsNo7b0wiGUOZxeTVvBTGVGKVgnAZbdhzGxkA0J+q
	YWwMQyf6K5uyY4CrXPQuQviOkEbdshVZrSzLBxYbCScgDNKzHk38SGhnhuYCWOzOsGVz30w3CZ2
	1Y6bOGjRYrMovJ02YknGH+8B8VF4OxdaBVXgM/qO87VT4H9fOX4KXN6OP6RrU0NiqFwWyrDA==
X-Received: by 2002:ac8:5855:0:b0:50b:a9d3:2e20 with SMTP id d75a77b69052e-50dd5c5de8fmr4147251cf.49.1775759392454;
        Thu, 09 Apr 2026 11:29:52 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd53e1f45sm2885961cf.8.2026.04.09.11.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 11:29:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wAu8V-00000009EkY-1bgt;
	Thu, 09 Apr 2026 15:29:51 -0300
Date: Thu, 9 Apr 2026 15:29:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Subject: Re: [PATCH v2] iommu/generic_pt: use __always_inline for
 amdv1pt_install_leaf_entry()
Message-ID: <20260409182951.GS2551565@ziepe.ca>
References: <20260402141012.1437095-1-khorenko@virtuozzo.com>
 <20260409170117.2014479-1-khorenko@virtuozzo.com>
 <20260409170117.2014479-2-khorenko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409170117.2014479-2-khorenko@virtuozzo.com>

On Thu, Apr 09, 2026 at 08:01:17PM +0300, Konstantin Khorenko wrote:
> With -fprofile-update=atomic in CFLAGS_GCOV, GCC fails to eliminate
> an impossible branch in FIELD_PREP() inside amdv1pt_install_leaf_entry()
> when the function is merely "static inline".  GCC may choose not to
> inline it, and without seeing the constant arguments at the call site
> it cannot prove the FIELD_PREP value fits the field.
> 
> Change from "static inline" to "static __always_inline" so GCC is
> forced to inline the function and can see the constant values,
> allowing dead code elimination of the impossible branch.
> 
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
>  drivers/iommu/generic_pt/fmt/amdv1.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It was already merged:

commit 8b72aa5704c77380742346d4ac755b074b7f9eaa
Author: Sherry Yang <sherry.yang@oracle.com>
Date:   Thu Mar 26 09:17:19 2026 -0700

    iommupt/amdv1: mark amdv1pt_install_leaf_entry as __always_inline
    
    After enabling CONFIG_GCOV_KERNEL and CONFIG_GCOV_PROFILE_ALL, following
    build failure is observed under GCC 14.2.1:
