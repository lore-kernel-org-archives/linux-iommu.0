Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6B31474C5
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897086; cv=none; b=H/nE8Uu9wytEZQa7AJtDGiICJ7OuzEGOozkcgJ0DjcMkhmGha8mnb374wm7pFRCjF2QBeyGWbYe25LITJxoiVBj963DcR8WpuiVCw+VQN/6/QKiKUyBkdd5+pO2+Za/XEt4oiv2qKrxsQZx+4plEM+e1Lxj8xsPO2s5YgXNxSJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897086; c=relaxed/simple;
	bh=Zx4DDxuZPCP/PEq8O78n9UklQLgFp6VRMfg1bUcF2K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpKmZVeFKZ4hmh0Ibm22DPx014eaMsYeKlkkpIWhQxqg3UMEaV/A29ShRpHyue/NGSU74eHzlflceu0pjNmDNyJ6wJRa0hYEXkfBId6AcoC502XpJg9Z5AsU1PKz9bew43ywPU5dSaQ4QSxcVdaWL+PQahIjhx0pnxB/U0qRw9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=cqHAPfgd reason="key not found in DNS"; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="cqHAPfgd"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42ab03a5aeeso12638401cf.0
        for <iommu@lists.linux.dev>; Fri, 02 Feb 2024 10:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1706897084; x=1707501884; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9bijSb9yEaTmlnOsnr5FnwiHhV7CJXfrStAeun3CCBg=;
        b=cqHAPfgdrfeYLuC3PML6sEmnMyzEdAYbXhvM6nfZCy6PhflnA5bynfgeVMOxC3EWDD
         sDwqg3DT6AxMolwOmMJztOXF4sxzPs21QAcXwCCaDtTDKOEH57mGxh9YCoiSj0DrlIpg
         e2fz84KW+y4OqfDzwM4lBf+J7xo8DlaiDXlDydgYVVvHvyQwFy5R3b/i+cL+6K+UsHEE
         FM2oM0+rrJnMuzuOhuhjGmypeRSccywEPWtxt+A2oBKcMJ9n+/iKy3re6+dtop5t3lnZ
         y2y9tJtdwb7Y9mqE1Q9oS3BYRJOOFLoy5U1aK6K7B//lwoOa5y6MfxH2mkoTFNaKxOks
         /XXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706897084; x=1707501884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bijSb9yEaTmlnOsnr5FnwiHhV7CJXfrStAeun3CCBg=;
        b=lJpxOOhBUJEQuJYMpm7QWUrt3qEJIUd6ptM5pCnJV8X4iY1iA1KmoZUt+lqEVFqjfu
         L4pfZHuh5+z4uwxKXs/g0OnJNKM2Nq9Ch77XYUmwD/rzqtummJcpXfmskows8E0BkYXx
         ccrNlXm/16UteqZ3+rOMstJLvogQwXx7hbaWY1+8vBuYrkbp7KWqdrCO8FseD5cmHRZl
         G9IaAQX5Qd6+3E1kjDkMw9hqg/bgexs/ZbsmHFBAoNNDarWWa958filBNFLj+2XTVA67
         09pGp6RfAjZyyH05ckMnAIwYD5n1S95UZPN92Qf9+bJsAb/dGHNTiyVZL2f1zLng7s8I
         weMQ==
X-Gm-Message-State: AOJu0YwWCepMydLyvZtoHBydmIuQXjPnLxq4nKvVZTgOzyTnGlBfW7tC
	3DYFtVXQMzHTP4Uh4/lqIoL+AU4b+u9oSEFI9jLBQ1NOp3ZcvhCIAaDTyhD4fxabkqNgihWtOGL
	K1byBMt46y8fVybLDB0I1wq5itUKvRlBGm05eUg==
X-Google-Smtp-Source: AGHT+IHZP6Un/HfjT028jnx0QVAGxq1NUEXIMQe8jhyWY9SpyTJFVDbuNtWHifT6v8EukAWp/hKqGTYNjWvGHCDW5lY=
X-Received: by 2002:a05:622a:343:b0:42b:eee7:5f5c with SMTP id
 r3-20020a05622a034300b0042beee75f5cmr9136031qtw.63.1706897084294; Fri, 02 Feb
 2024 10:04:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240201193014.2785570-1-tatashin@google.com> <02610629-05ef-4956-a122-36b6ac98fbc2@arm.com>
 <CA+CK2bD_q3pnThtLVSzFCjyevBEaG6Ad+1o2=1tVZsYg35UMmg@mail.gmail.com> <84c7e816-f749-48d8-a429-8b0ef799cdbb@arm.com>
In-Reply-To: <84c7e816-f749-48d8-a429-8b0ef799cdbb@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 2 Feb 2024 13:04:08 -0500
Message-ID: <CA+CK2bCFbeRHT172KUci5+8WJNUeo-2A1M=UXsSqqOy64w1LJw@mail.gmail.com>
Subject: Re: [PATCH] iommu/iova: use named kmem_cache for iova magazines
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com
Content-Type: text/plain; charset="UTF-8"

> Hmm, I did misspeak slightly (it's late and I really should have left
> this for tomorrow...) - that's 12KB per CPU *per domain*, but still that
> would seem to imply well over 100 domains if you have 242MB of magazine
> allocations while the iommu_iova cache isn't even on the charts... what
> the heck is that driver doing?
>
> (I don't necessarily disagree with the spirit of the patch BTW, I just
> really want to understand the situation that prompted it, and make sure
> we don't actually have a subtle leak somewhere.)

Hi Robin,

The following tracing is without Google TPU, simply upstream kernel:

The iova_domain_init_rcaches is called 159 with the following stack:

 iova_domain_init_rcaches
 iommu_setup_dma_ops
 amd_iommu_probe_finalize
 bus_iommu_probe
 iommu_device_register
 iommu_init_pci
 amd_iommu_init_pci
 state_next
 iommu_go_to_state
 amd_iommu_init
 pci_iommu_init
 do_one_initcall

Each time 1536K is allocated: in total 159 * 1536K = 238.5M

The allocation happens like this:
for (IOVA_RANGE_CACHE_MAX_SIZE)
    for_each_possible_cpu()
        iova_magazine_alloc
        iova_magazine_alloc

IOVA_RANGE_CACHE_MAX_SIZE = 6
ncpu = 128
sizeof (struct iova_magazine) = 1K

6 * 128 * (1K + 1K) = 1536K

Pasha
