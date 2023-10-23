Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2144219F1
	for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YjipIn87"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ce2d4567caso2549670a34.2
        for <iommu@lists.linux.dev>; Mon, 23 Oct 2023 11:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698086128; x=1698690928; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IIoRI2ARPSz8WtQUlc5itQT0gMoQCkpLJtTDznyytSc=;
        b=YjipIn87Y9m7QsLYiKNFKhRXhZZIin4XEF2JvLnqRe2V/CbITcUytPWs5emFkE30MH
         MnKmjNaBtG1QX5AQ+cxHI660FvAdDiMHGc/6ImkakDVi7BCuzl4y6UbbHsAB2CsKnmGX
         6qwyGmaYoE6RVWpRdpyI9xE9HfYkeKp327M0+LCHD3xlDPcZ6TG64yIcKzOjAz/IBa3w
         WOWItpdr34fyVSyo3oKQVCoHC3qpoQZ2/Zmv0sEkntPJ0bWopFiX8WHJGj+nauC6MbMH
         5Mm43fcu9zv4pnmw92FVUD4iQaQCHUn+M+c/27j6QyxyU0gMl76J7eEqxzJO8pIcd07K
         /6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698086128; x=1698690928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIoRI2ARPSz8WtQUlc5itQT0gMoQCkpLJtTDznyytSc=;
        b=fvPShi6R2C/ziUYB6N8Qu169Myr2MyQlqgpMxRHBvE7kUs5jtGeN1hU4/FADZj0Gy8
         t78o3Fkherk68uJvmxBRLGuxUW8Sy5Z1kC+6Z7OKVeGV/+Nf7H1wk0EE4eJr7oE2HZIR
         sIcin7/dOqU0O1APIKB08n3LbXknyx6fr65SPJ411CS9hXAudSIs+2Ja4883CWmIUs6S
         WvXp/SZVQ1E7cTl+DGqj6YdgtyWmh3nNDg0MTagAzjQqMC9TQMINF0xQuUtG3AARk5r2
         3BOp/0lwQdeEmpGAk/sQLVArDYF8brqhgUKwrSUY8Hwbv0vPmGfd6dj1tX48qOFSR02q
         41WQ==
X-Gm-Message-State: AOJu0YwF+ut1mXty0CBKsSE19/eBI6dHeiSi483WKRMT0qcjgyCPP0iS
	HALskkHVprSGSEvU7DDQDuVRUQ==
X-Google-Smtp-Source: AGHT+IF87A5sAEPwDGGscH4VZHk76YpcDJFB/PbHnNeeeYrEYuSNJeTyvaSasLb7bG0Tzfme5ZXN0A==
X-Received: by 2002:a05:6808:158c:b0:3af:9848:1590 with SMTP id t12-20020a056808158c00b003af98481590mr12228373oiw.6.1698086128598;
        Mon, 23 Oct 2023 11:35:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id bj6-20020a056808198600b003adcaf28f61sm1593859oib.41.2023.10.23.11.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:35:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1quzlv-003jZ6-6w;
	Mon, 23 Oct 2023 15:35:27 -0300
Date: Mon, 23 Oct 2023 15:35:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tina Zhang <tina.zhang@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: [RFC PATCH 06/12] iommu: Add mmu_notifier to sva domain
Message-ID: <20231023183527.GM691768@ziepe.ca>
References: <20231017032045.114868-1-tina.zhang@intel.com>
 <20231017032045.114868-8-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017032045.114868-8-tina.zhang@intel.com>


On Tue, Oct 17, 2023 at 11:20:39AM +0800, Tina Zhang wrote:
> Devices attached to shared virtual addressing (SVA) domain are allowed to
> use the same virtual addresses with processor, and this functionality is
> called shared virtual memory. When shared virtual memory is being used,
> it's the sva domain's responsibility to keep device TLB cache and the CPU
> cache in sync. Hence add mmu_notifier to sva domain.
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  include/linux/iommu.h | 2 ++
>  1 file changed, 2 insertions(+)

You should look at how arm smmuv3 ended up after I went over it to
make similar changes, I think you should take this patch

https://lore.kernel.org/linux-iommu/20-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com/

into this series (maybe drop the arm part)

And copy the same basic structure for how the mmu notifier works.

It would also be nice if alot of the 'if_sva' tests could be avoided,
smmu didn't end up with those..

In the guts of the pasid handling sva shouldn't be special beyond a
different source for the pgd.

Jason
