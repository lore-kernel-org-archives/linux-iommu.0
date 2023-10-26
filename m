Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007F12D7A9
	for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K+N15Kdi"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ce37d0f1a9so489752a34.0
        for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 05:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698322819; x=1698927619; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qU0vFWhyRKz3l1/cwtPJ3LxAPBuI6AFrBw6ekYuxL/0=;
        b=K+N15KdiPuWRQuvGhZCvMlMWH6x1wmffYvBotWif22JRIVHTvc10FAxxeAzV7up63p
         eUNB5CTQ66axKbtFXNwU93vdO44Mn5/6Y8Dlncu4LTLg3BjkCzM14NiJpgzcLMb5HBCT
         zjiY/rKxzHzArirzNaH9rWHrl0KppGwsebNQNuydaW1nZ3587G79uJITr/Tc7NXrcoe7
         d6asqR/MIlb9btGhOT/KpeLl/gDhAYTs8iExT2C2i3hp1xtZV2likYLhYIbGKsygC1+4
         uED05oi3gFTIfRw1CrzM7H+vUv12hc4J4tusZ6Cb98wp6NMN/VZErdwy20f3tZth+Ns0
         zUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698322819; x=1698927619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qU0vFWhyRKz3l1/cwtPJ3LxAPBuI6AFrBw6ekYuxL/0=;
        b=HgUTQgfNCJEe7SFAoQrxj5ngGMiGzAiY1HwthSjds5n3WwQXo1+oiPC2OvSfcwKZgy
         40ROCvo2AHc/0Mci8Krmm+Un+TMCAXsJpBhWNAa/v9vaDJl5spH4vsX/f+9cTJQBera+
         CV+7BJxSKULddcRS0MDz72/j8sD1dZ0wvomZOar25rZieqHXuQu5F97PPumiyfMx5ay6
         fkgM3rs9rh+ajMKQYqqYsbRqC/kE3Yk9losV4EoHoAyzwRWg9GdhpFGxg2nfMF1XeJ8c
         NGYUQ9/l5CLGtuv86PR3sICmxEnBFcn1U2G+4S3y0QoIUlKpzEYgc+QMTfZG9VSyZlod
         QCQA==
X-Gm-Message-State: AOJu0YyC2QaKrkXF7gFG9g7oZJk5vWqTWC4wXxEAIDeYxvQxDvmfPhPB
	slbVo7rze6MW6Ua/C7Zsu5JspQ==
X-Google-Smtp-Source: AGHT+IH3V0Wyvq3WAkx6gNZbtYj7bpXecF10nQELMvJIJVFlv9xPTITWAHw3myCxCfAO9zsI2u+Iww==
X-Received: by 2002:a9d:73c3:0:b0:6b9:b226:d08e with SMTP id m3-20020a9d73c3000000b006b9b226d08emr20022310otk.34.1698322818799;
        Thu, 26 Oct 2023 05:20:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id t16-20020a9d7750000000b006b8c87551e8sm2616543otl.35.2023.10.26.05.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 05:20:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qvzLU-005091-VY;
	Thu, 26 Oct 2023 09:20:16 -0300
Date: Thu, 26 Oct 2023 09:20:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v9 0/5] Share sva domains with all devices bound to a mm
Message-ID: <20231026122016.GU691768@ziepe.ca>
References: <20231018050640.24936-1-tina.zhang@intel.com>
 <ZToUOKSqqI6Bh_03@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZToUOKSqqI6Bh_03@8bytes.org>

On Thu, Oct 26, 2023 at 09:24:40AM +0200, Joerg Roedel wrote:
> Hi Tina,
> 
> On Wed, Oct 18, 2023 at 01:06:35PM +0800, Tina Zhang wrote:
> > Tina Zhang (5):
> >   iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()
> >   iommu: Add mm_get_enqcmd_pasid() helper function
> >   mm: Add structure to keep sva information
> >   iommu: Support mm PASID 1:n with sva domains
> >   mm: Deprecate pasid field
> 
> Thanks for doing this, it all looks reasonable to me. But there is one
> thing missing which needs to be done before we can move forward with
> this.
> 
> There was a discussion about the Kconfig symbol naming used in
> mm_struct. Please see the discussion here:
> 
> 	https://lore.kernel.org/all/CAHk-=wgUiAtiszwseM1p2fCJ+sC4XWQ+YN4TanFhUgvUqjr9Xw@mail.gmail.com/
>
> Please update this patch-set to solve this and I will take the series.

Lets call it CONFIG_IOMMU_MM_DATA then. It is still pretty nonsensical
but it speaks to what it does after this series

Thanks,
Jason
