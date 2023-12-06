Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B65639FF1
	for <iommu@lists.linux.dev>; Wed,  6 Dec 2023 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMjAXLpZ"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50bef9b7a67so4935609e87.1
        for <iommu@lists.linux.dev>; Wed, 06 Dec 2023 05:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701870480; x=1702475280; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9miOKK/UUvaSvAzOVHQH1JTB5Oh8DCGH0eTcRA1Hgqc=;
        b=wMjAXLpZbi3j1RetC7hZnRZ+z+c4zmdaBpG0AFUg+mxf/0orwvR5hErrWTU184FhvS
         t635cHvXkX756Q6Aehs3mcX2+DbG2VX/sMywPxXWS44dXORAJKfO88l5hP5aTmSPEu2J
         hdvnbEDGiuakbByTu8X7bKJV7lg2NoRYeXZlcuOw4lilwjO0lYE8BJnQH3eGNH6rCemA
         MyEuJvbkN4/hKZ25GULKlZMaKAj9aLoyQGBiiFBLC9NoSpWf673jf+ekUFcG6YlEcKlR
         l3MHcP4uG85g3Iuw+06Ewetj4DGwCwXqgU1jA5psowRORHZnYkcLrfIswGCB3u8X4lHT
         efSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701870480; x=1702475280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9miOKK/UUvaSvAzOVHQH1JTB5Oh8DCGH0eTcRA1Hgqc=;
        b=DAqrAkpFljLoFrZIsNvbDPR2/1OOt9efrp2j7I2kMmcT/6Sua9/TngjYT0dGT8Y/US
         eRn5PVjxhcUwmS5jpOzwf+EXI7qR0q4BN9ZiI1DxgYRIiZfK2vsOU7MSLkvm+lSr65G5
         aJffwApvvLE7+8DoCeF65+frc3/xRx/bJxLsMfyDsLZern/yRL41LKlqIGcxcA3CKaNN
         JqiTE8KteJuN1fu1Krr5ogailDEy8l5qNKduOiHiVhuS4Wh7ibZnFcoKpRGAC6FpjpKK
         VUg/5KFsM6xTTHPZPFPI6LSqycYil4V18lXoZgQ01rHp88Ts5a/QEe2w++GxLeGSnWJZ
         5tiA==
X-Gm-Message-State: AOJu0YxpCV6ofqWnHk+y0i0nqP5D8jksuZRG2OrXJvjTY0RUTUkG/7qq
	s817Wj0/L1LyNlBGgcEUSGUbwftpBfXhaeRxx1CevA==
X-Google-Smtp-Source: AGHT+IHw3P3cXoW7pJNEQWcIDG3J+FZRlOarsKh/yt7qJA5ssgURhZvvxsqlatP7qeWxo5iGA+5Hy5O+DWF/K4Beido=
X-Received: by 2002:a19:f711:0:b0:50b:e750:dd94 with SMTP id
 z17-20020a19f711000000b0050be750dd94mr588145lfe.1.1701870479946; Wed, 06 Dec
 2023 05:47:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231206005727.46150-1-zhangfei.gao@linaro.org> <20231206013039.GN2692119@nvidia.com>
In-Reply-To: <20231206013039.GN2692119@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Wed, 6 Dec 2023 21:47:48 +0800
Message-ID: <CABQgh9GVUh-6vXG=pgGgY5YotNb8VMQPUv6ESd11T8rb98Rd1Q@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: disable stall for quiet_cd
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	jean-philippe <jean-philippe@linaro.org>, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	Wenkai Lin <linwenkai6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Dec 2023 at 09:30, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Dec 06, 2023 at 08:57:27AM +0800, Zhangfei Gao wrote:
> > From: Wenkai Lin <linwenkai6@hisilicon.com>
> >
> > In the stall model, invalid transactions were expected to be
> > stalled and aborted by the IOPF handler.
> >
> > However, when killing a test case with a huge amount of data, the
> > accelerator streamline can not stop until all data is consumed
> > even if the page fault handler reports errors. As a result, the
> > kill may take a long time, about 10 seconds with numerous iopf
> > interrupts.
> >
> > So disable stall for quiet_cd in the non-force stall model, since
> > force stall model (STALL_MODEL==0b10) requires CD.S must be 1.
>
> I think this force-stall thing should get a closer look, it doesn't
> look completely implemented and what does it mean for, eg, non-SVA
> domains attached to the device (as we now support with S2 and soon
> with PASID)
>
> The manual says:
>
> 0b10 Stall is forced (all faults eligible to stall cause stall),
>      STE.S2S and CD.S must be 1.
>
> And there is a note:
>
>  Note: For faulting transactions that are associated with client
>  devices that have been configured to stall, but where
>  the system has not explicitly advertised the client devices to be
>  usable with the stall model, Arm recommends for
>  software to expect that events might be recorded with Stall == 0.
>
> Which makes it seem like it isn't actually "force" per-say, but
> something else.
>
> I notice the driver never sets STE.S2S, and it isn't entirely clear
> what software should even do for a standard non-faulting domain where
> non-present means failure? Take the fault event and always respond
> with failure? What is the purpose?

Sorry, I have no idea :)

>
> Aside from that the change looks OK to me:
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks Jason.
