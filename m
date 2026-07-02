Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D70E35DD1C
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783023931; cv=none; b=EIj42Z32r8z4t2AWPQQb+X4WJFLXXeXqwpIRxPzc9C1/U5R8kyv39UJIH/VJpIbxoK/y7nPiipVzY+zf18vg387eq4GR6HwivoDVQOcrcZGhgUJXTE3Sg+oBOM1eGGiUfG1F/s+042QQiyrSSCL7hu6xvQjB7650bILRzXsRhOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783023931; c=relaxed/simple;
	bh=k0pMqimW5JNY6E7Ta2qKbyunsX9A3EiSLwuDAUjF0Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpW3wdJUfmdGTfE+xRJml66qhY+8Cwa7rCznqOfRPE+q+ODGQ+FYARFhZm7Uo082FZlD18365NKyHLbDT6aSyx+awoU4uVzYB23HozOzL/nUnTFpz9Kj+y3DFwCcrrbLXhlvgT+w4I9lRZM8BX/fO/vvxg2e5YosE/ZzF8Lnj7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UIcf7eig; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UIcf7eig"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cacef7d299so27995ad.1
        for <iommu@lists.linux.dev>; Thu, 02 Jul 2026 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783023929; x=1783628729; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D1/4TQCQv4x02z/PLYtJPpvADBvf6W/GQerzpdxNkZY=;
        b=UIcf7eig7F9Ou926NTNJwH+PGFffup+lrEv0PvBFzdIfNBH01WGcjNyXAYoWZt8rZ6
         ajY872ejCWdF5a4meYfOFRbeiOnlAWLcWSozpSe14nkoWGir2FZ4jck+uGNYUO6D+b4C
         bbt7a23diUA9tGRgckZocREm0ehJH+jNeTLPqSYjef/30KY+hXDNnjv+jJK6faRRyv05
         Fua4GDBewApyceYkgTbPBSVtgutwN05dnW/Y4A28MX5Egmf4FUh/VwKcBv8fCa6kms+Q
         9wLHZH2abR1fzQKI7A0Nkxzb9Gg23pzYtU3q4qPM1ZRHNHS0SMoHJczcCeicYlKIyQpf
         mX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783023929; x=1783628729;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D1/4TQCQv4x02z/PLYtJPpvADBvf6W/GQerzpdxNkZY=;
        b=MwlPNV2WC08Ehb5QuHdOgNJK07nimv8ThnhzGBVqHNN65tEDsoAZH3DweC+wtgtaeL
         BzfuwFPT6m+INn3O2JbyoiKHf7Lafwz/8LKkP9OrHxx0NzihqE/sB43UfGlk3ry0qHYg
         tJh2zKXJTmv0iGCzlzn6bSIF3/4t20btI/+IOXGPy06S0VLzqXyT7DUX4NjXFE4LjBwJ
         H0HzjnsH8b+KtzO5SerIHnzbkvHS4nHT9KbWKsjaAJGLabr6OEx9p8lQR1rLS/f21J+C
         cKoTocj1/enHkUldKtJavvXQJoj3amqHO8IUNhWVAsLc/kxPOihzlY7SNNKTcAO7tflv
         ABxQ==
X-Forwarded-Encrypted: i=1; AHgh+RoKYJMBzLUro10nXpPASr/AwzL4vAlADwQ3IrWk0LKHnCQ5hnmltaEcj8BZhu8TOSeo2T+foA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyus/rC3MAHhRE0m2eIG4AFYy/FC2jEv+2kyyWa+cXaxBKLDz/b
	gIEuTRLStppUNbdAu7RH3uXzdRRGcTMGUREHhAo3JVLB4ekblyCJ23yT852sHgwEzQ==
X-Gm-Gg: AfdE7clh2F5Lc+VYuJdRCPHABa3ZY3dp80kQj9B5tlTWHX9gFud98c73wzfw0wPwgPV
	Qf+msmla1zHqQx6+zRUPyQ3bIucf2RUHUEot7VIej8g2Chu3wZpkl0Z4i2odqtuxFe0XyLvx4Iz
	tIRv2hik1e6RFqcc5+NjO8ljKTeROZpVVUlNXDekizmeCQ/L5q9NSR9c4p80Fqc38KoDYj9SVsP
	dH9D1GqclUEROY8wbunKdzpuDTICJ6TgogCUBCQXkuXiPobsRCPDFNsGvWeNih3OiuO1HLnrRP3
	0KgIdOttsEVjADJYZXB6ZE3CyJQMg2To8uQ8LOP4reUHwcW5WCJ9JreHYe1gUYndxbspPhlUFf9
	dDW/A5/zORG0H7z2WD4lt1RWizlFZAJReTvajbZH+L2bUSvMwABGjeh0CyEGQdK6QdW7tW8QSt7
	rCbSz/yFKVz5jQ6E4jvil9P3i8Kbgj9NvNJGAJdpgUulMYUsg=
X-Received: by 2002:a17:902:da8e:b0:2bf:1000:d3ac with SMTP id d9443c01a7336-2caa6ff1431mr2958025ad.11.1783023928961;
        Thu, 02 Jul 2026 13:25:28 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9aa0b7e9sm18461795ad.81.2026.07.02.13.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 13:25:27 -0700 (PDT)
Date: Thu, 2 Jul 2026 20:25:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>, Kyle McMartin <jkkm@meta.com>,
	Breno Leitao <leitao@debian.org>, Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
Message-ID: <akbJMT2mH7QfLwuQ@google.com>
References: <20260702112825.781750-1-kas@kernel.org>
 <akZ-KIVJlmP4LEcQ@google.com>
 <akaFcwcSHVGeT8PZ@thinkstation>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akaFcwcSHVGeT8PZ@thinkstation>

On Thu, Jul 02, 2026 at 04:38:55PM +0100, Kiryl Shutsemau wrote:
> On Thu, Jul 02, 2026 at 03:05:12PM +0000, Pranjal Shrivastava wrote:
> > On Thu, Jul 02, 2026 at 12:28:25PM +0100, Kiryl Shutsemau (Meta) wrote:
> > > The command, event and PRI queues are sized from the maxima the hardware
> > 
> > A minor note here is PRI & EVT queues are disabled for the kdump kernel
> > (see arm_smmu_device_reset). We could just mention all SMMU queues are
> > sized [...] in the commit message. 
> 
> Fair enough.
> 
> Here's updated commit message (I will send v3 in few days, if no new
> feedback):
> 
> Subject: [PATCH v3] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
>  kdump kernel
> 
> All SMMU queues are sized from the maxima the hardware advertises in IDR1,
> which can be several megabytes each, and are allocated at probe. The kdump
> kernel already disables the event and PRI queues (arm_smmu_device_reset()
> drops CR0_EVTQEN/CR0_PRIQEN) but still allocates them at full size. On
> systems with many SMMUv3 instances that cost is paid per instance and adds
> up to tens of megabytes of coherent DMA in the capture kernel.
> 
> A kdump capture kernel runs from a small crashkernel reservation and only
> has to drive the few devices used to save the dump, so deep queues serve
> no purpose. The queues are not on the DMA data path, so dump throughput is
> unaffected; a shallower command queue only bounds how many commands may be
> in flight before a sync, which does not matter for the capture kernel's
> small device count and modest I/O.
> 
> Clamp every queue to a single page when is_kdump_kernel() is true. Doing
> it in arm_smmu_init_one_queue() covers the command, event and PRI queues
> in one place. The command queue still holds at least one batch plus a sync
> (256 entries on a 4K-page kernel, well above CMDQ_BATCH_ENTRIES), so
> command batching keeps working.
>

Looks good. Thanks!

Praan
