Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F52146B2
	for <iommu@lists.linux.dev>; Thu, 23 Nov 2023 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="I3YFWvFk"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-58a01a9fad0so483228eaf.1
        for <iommu@lists.linux.dev>; Thu, 23 Nov 2023 08:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700758764; x=1701363564; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb3uM4eHj7Jl63k8foMst+crg9YImtyVYd5Ckxd0hQ0=;
        b=I3YFWvFkTW//trvBBYsd2rWwP95B0Ud51Z+T3xOsaWxPtBXwfur6ofpjz7EyAbs+zD
         EQBN7AgMgV0OqiazuMXzn7AW7jtUCMDSXFyzeOWhKEhF5f9HEGMiwdck7BOVcw60Ladq
         +UtgMqs2sfd9xg/CtBO1Uvs/+X2B7Zkn/w1fXdWosBYbybwcyv2q1p9Mol7h34AZfwm5
         +mhS2miEKj6IQ5hKX8wDAukR0Sp07pFp9zS2Vvq1lTG6sw3euM7sIMGMosB5pVII/bDJ
         pnV7BOKCYXqmN+9YsDVIpRpyUQN/Engpcx4nVHYCKh/r1qF/qmCl8SAK5gP/ChgURRpz
         ipgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700758764; x=1701363564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb3uM4eHj7Jl63k8foMst+crg9YImtyVYd5Ckxd0hQ0=;
        b=gCqwhwtBp6/kjIS2d+nL5d2NH89o0QroV2J4ovPpMoDXqM33HZ5N6G+Gi9sfEr2zc9
         Wn14RJSTGuzbJMyz9I4dvjPzGfF64EOPNjjmcY8d2tb7Nr9v8SaLCLKSmBmi+GE3Aee8
         +u3qUYTzKZedl/GXua4BnERAvjdjmoSQmogILR0L5cW1Iv7Deg9qPVE4vpy67llGNOWS
         T3SKhh7c5ttsyH/nfKIML0L5FmvKS/XNYXc71nzvyVi6bWvSJbr0Ox3Zmh/1BYv9Ba7G
         B7ZXWOKqb4s74ZUhYEwJu3r/ffmxKBG1wsmdVughNLt7jlI7mHqJ9jk1kuACB6wFLZ/c
         JFPQ==
X-Gm-Message-State: AOJu0YzztNQM25Z4+V4yFC72EHXSnMakGSjEIRKsWv528rrAVzZuF2Yn
	BS88MeRY47tLeRxw6F7vWAOKxQ==
X-Google-Smtp-Source: AGHT+IE762WpKmdtVhoxKqpc4Yh09j8J85cJxRzUD4a6ug5tSmlnzeuITpsKERhFmhRUc42hDIlY6Q==
X-Received: by 2002:a05:6820:2206:b0:58a:32a6:bc41 with SMTP id cj6-20020a056820220600b0058a32a6bc41mr1819511oob.3.1700758763984;
        Thu, 23 Nov 2023 08:59:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id h7-20020a4abb87000000b0057e7c1118b9sm238914oop.31.2023.11.23.08.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:59:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r6D2w-001rih-KY;
	Thu, 23 Nov 2023 12:59:22 -0400
Date: Thu, 23 Nov 2023 12:59:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Rob Clark <robdclark@gmail.com>,
	Gaurav Kohli <quic_gkohli@quicinc.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 0/2] iommu: Allow passing custom allocators to pgtable
 drivers
Message-ID: <20231123165922.GB432016@ziepe.ca>
References: <20231120140425.GA10140@ziepe.ca>
 <20231120153838.2166e7b8@collabora.com>
 <20231120144604.GD10140@ziepe.ca>
 <20231120161418.5eca178e@collabora.com>
 <20231120154536.GE10140@ziepe.ca>
 <6e74bd37-9e10-416e-9fbd-0cebb7948e2b@arm.com>
 <20231122175055.GI10140@ziepe.ca>
 <20231123095141.19dc26d6@collabora.com>
 <20231123134800.GA432016@ziepe.ca>
 <ff23d70e-8af6-47b5-a85c-de68ebaab4e8@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff23d70e-8af6-47b5-a85c-de68ebaab4e8@arm.com>

On Thu, Nov 23, 2023 at 04:49:21PM +0000, Robin Murphy wrote:

> Oh, so essentially your plan is to replace io-pgtable-arm with something
> else entirely. That's fair enough; happy to review that when I see it, but
> as I pointed out, realistically this change hardly makes that any worse than
> what's *already* present in io-pgtable-arm that you're going to have to deal
> with anyway.
> 
> I would instinctively assume that an "enterprise" optimised version would
> want to be a clean-slate fork itself since I can't imagine it wants to be
> burdened with having to handle non-coherent pagetables, Armv7 LPAE format,
> or any of the quirks for embedded and mobile IOMMUs. I have no issue with
> moving SMMUv3 to a shiny new pagetable implementation in future, but that is
> quite clearly not at all incompatible with leaving the existing
> implementation in place for all the *other* decidedly non-enterprise
> io-pgtable-arm users, both IOMMU and GPU, not to mention GPU-via-IOMMU in
> the case of Adreno.

Oh, okay! Great, then we are all in agreement!

I was not thinking about a fork, per-say, but yes I can see how that
is would be a fine approach to take for everyone concerned.

Thanks,
Jason
