Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E363EA90
	for <iommu@lists.linux.dev>; Fri,  5 Apr 2024 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712325891; cv=none; b=eEChgmDq1fPliw2GW9+fAAttFRu8HAz/nDsZ1npbUTYPb9Qc9rD9naDoW/jX0a6pHfE0Gt4RGTBp1gubPBsmRmhke2RIwGuaYWC2zs4LpCta3bLdHGVguc5syaN90WUOHBtjZcNbLyGzjEkL7jz727EwvmzndanNpKcGN0/CE5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712325891; c=relaxed/simple;
	bh=YLppziVi18FS86lsRUFYbik4pdpKw9o5av3kYjqyrXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TaI6352ri4uVUYOjG9ESjvmVbdINh7s8XR3/Xse92hoOmW6fHLpHlIOaiss5EIk0elYHNPPJcUafbkC3JAWQMVB2aBPcGxKC84re1YTTTuLoWEIh32Lyi+0RHTNnEFnkAMRv3wU67yrgciFsEOhfQZdRiy9kedlloBMPAWFkXQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B70BVjZB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B70BVjZB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712325889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJZjF5huZ/IS92CnJZN2AYaHFZSXzZinDMU0oFLcit0=;
	b=B70BVjZB2JEXjgcyYGaXixHEqyGt7P8yZ3wmDrE7Mf1MMq3QJG/z9hyeorlqyfuUv7nI7t
	dnQRM2Z3uj1gPHgFNNplQsdz5OjaECnI6bVuzJPnj/2mk+Qn34l6X89V0puVjwzj0SQmmz
	vONMyMLci3vJQyRhJRsCTpZmLz4MzoU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-cI9W15iGMWWvgISnRWBROg-1; Fri, 05 Apr 2024 10:04:48 -0400
X-MC-Unique: cI9W15iGMWWvgISnRWBROg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78a5bd4594cso208176585a.3
        for <iommu@lists.linux.dev>; Fri, 05 Apr 2024 07:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712325887; x=1712930687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJZjF5huZ/IS92CnJZN2AYaHFZSXzZinDMU0oFLcit0=;
        b=CGgax46F+V1uLMIJGLS1V3qKfKc6kgsMJrsxeveU3Vnnvt5Juvd0CdktNfchTcKzzy
         REa0fRXGsFwLrO5ZdrMwNFe+nsPn4/2XP5nyT5YOgUxyKEZwe8jx+aojil8OzYF1cMl1
         GBkfdOUW0MddqjgPDcyJQ/JKauZ/Xx+VPggitlUr/lsKA1rgv/ZsRhm7hEHlSFdP4ue1
         D/J2ZsxjY31BCe+qQPOUpPRfQfe/eVHR8t239o+McNeGpoQAS/vQiWeGXo5AfDV3Y+Tz
         /0jLtz4pfyzgYpWtIFEqR8JC7gcT/BwiARqVvs1eY6tGdcIv/QsOLSH+0MBaYK0nbmns
         n/Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVqDFY7XJ6oFRyBjGuw7GCeG/AMpKpaUCCC1q2fS217Vi0Y992gyua746Y6tye8qA+vdmNoKcQm+w7sLRTOCrrhW354swg=
X-Gm-Message-State: AOJu0Yw24BgkY0NswxJeXUo3JENgzodkULfLU3qH1aD782C2vnyhK7Dm
	vey+P59d1CGOwmU4BYmWMBcVw7gIsxCcY36gjyYFhuKKs37TRIX0kHQovl2Mp/R4eLt3Iuu55Ae
	N8tS+g3nQZ7aX/oAcWUgEBhD+7huq3u3ZHSs23Cmw7zzHgcVzkBfd
X-Received: by 2002:a05:620a:2b84:b0:78a:72b3:b629 with SMTP id dz4-20020a05620a2b8400b0078a72b3b629mr1708180qkb.44.1712325887098;
        Fri, 05 Apr 2024 07:04:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeHEjy/9A/4fTjZi0cCVsMnWNGemn3Slh0adyB59fLgBdpF4HyFXzqH7mBOCLvsV91+RB47w==
X-Received: by 2002:a05:620a:2b84:b0:78a:72b3:b629 with SMTP id dz4-20020a05620a2b8400b0078a72b3b629mr1708136qkb.44.1712325886596;
        Fri, 05 Apr 2024 07:04:46 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id s9-20020a05620a030900b00789fb5397d4sm654993qkm.100.2024.04.05.07.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 07:04:46 -0700 (PDT)
Date: Fri, 5 Apr 2024 09:04:43 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, robdclark@gmail.com, will@kernel.org, 
	iommu@lists.linux.dev, joro@8bytes.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, quic_c_gdjako@quicinc.com, quic_cgoldswo@quicinc.com, 
	quic_sukadev@quicinc.com, quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com
Subject: Re: sa8775p-ride: What's a normal SMMU TLB sync time?
Message-ID: <lqdosfpb7gdjooqswgjnabzxapocndzam3ws7dq7god5bn55an@igvaowz6h7ye>
References: <kord5qq6mywc7rbkzeoliz2cklrlljxm74qmrfwwjf6irx4fp7@6f5wsonafstt>
 <Zg9vEJV5JyGoM8KY@hu-bjorande-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Zg9vEJV5JyGoM8KY@hu-bjorande-lv.qualcomm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2024 at 08:25:04PM -0700, Bjorn Andersson wrote:
> On Tue, Apr 02, 2024 at 04:22:31PM -0500, Andrew Halaney wrote:
> > Hey,
> > 
> > Sorry for the wide email, but I figured someone recently contributing
> > to / maintaining the Qualcomm SMMU driver may have some proper insights
> > into this.
> > 
> > Recently I remembered that performance on some Qualcomm platforms
> > takes a major hit when you use iommu.strict=1/CONFIG_IOMMU_DEFAULT_DMA_STRICT.
> > 
> > On the sa8775p-ride, I see most TLB sync calls to be about 150 us long,
> > with some spiking to 500 us, etc:
> > 
> >     [root@qti-snapdragon-ride4-sa8775p-09 ~]# trace-cmd start -p function_graph -g qcom_smmu_tlb_sync --max-graph-depth 1
> >       plugin 'function_graph'
> >     [root@qti-snapdragon-ride4-sa8775p-09 ~]# trace-cmd show
> >     # tracer: function_graph
> >     #
> >     # CPU  DURATION                  FUNCTION CALLS
> >     # |     |   |                     |   |   |   |
> >      0) ! 144.062 us  |  qcom_smmu_tlb_sync();
> > 
> > On my sc8280xp-lenovo-thinkpad-x13s (only other Qualcomm platform I can compare
> > with) I see around 2-15 us with spikes up to 20-30 us. That's thanks to this
> > patch[0], which I guess improved the platform from 1-2 ms to the ~10 us number.
> > 
> > It's not entirely clear to me how a DPU specific programming affects system
> > wide SMMU performance, but I'm curious if this is the only way to achieve this?
> > sa8775p doesn't have the DPU described even right now, so that's a bummer
> > as there's no way to make a similar immediate optimization, but I'm still struggling
> > to understand what that patch really did to improve things so maybe I'm missing
> > something.
> > 
> 
> The cause was that the TLB sync is synchronized with the display updates,
> but without appropriate safe_lut_tlb values the display side wouldn't
> play nice.

In my case we don't have display being driven at all. I'm not sure if
that changes the situation, or just complicates it. i.e. I'm unsure if
that means we're not hitting the display situation at all but something
else entirely (assuming this time is longer than ideal), or if the
safe_lut_tlb values still effect things despite Linux knowing nothing
about the display, which as far as I know is not configured by anyone
at the moment.

Any thoughts on that?

> 
> Regards,
> Bjorn
> 
> > I'm honestly not even sure what a "typical" range for TLB sync time would be,
> > but on sa8775p-ride its bad enough that some IRQs like UFS can cause RCU stalls
> > (pretty easy to reproduce with fio basic-verify.fio for example on the platform).
> > It also makes running with iommu.strict=1 impractical as performance for UFS,
> > ethernet, etc drops 75-80%.
> > 
> > Does anyone have any bright ideas on how to improve this, or if I'm even in
> > the right for assuming that time is suspiciously long?
> > 
> > Thanks,
> > Andrew
> > 
> > [0] https://lore.kernel.org/linux-arm-msm/CAF6AEGs9PLiCZdJ-g42-bE6f9yMR6cMyKRdWOY5m799vF9o4SQ@mail.gmail.com/
> > 
> 

