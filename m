Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5790740D598
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781035915; cv=none; b=FaaQ6z/H3p2+Zj0Wa9si2QLiMrHagxCH80LmLOhzWRgcCsJbv2FNUIKVxI6l3LFRNQEEkKZdGKuhxPufeO0z6UKI//6yChxbGPundAdevBySxDdcE0j8sL6m4FsB6gX7G4F0Gbgy96zfhpTbGrhVIg42ThEyRvmLj8Q96MsFKZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781035915; c=relaxed/simple;
	bh=wvrIltXBMg2/EmxZ7IhSgdix5pdMivDZLU1DH9W3b10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJMD0I6KYQ8Jgt5YyFv5BnP+FSpzcMknaYLF9mVQRPXXdT1kW+PsRjAVY4WVVMGLHZfhfQqGlu+YOY6ldHKjXOtyMBDh1Jlkb/T18hw6yDPqMi4fAZxr4BEUMZOVPXG//uslHVFOeV/BBk2tj+X9rzNsqJgVBxKD8J1bBxB5uN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q8eS23tB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q8eS23tB"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0b1a48855so1455ad.0
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 13:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781035913; x=1781640713; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nS7IcpZWz3b5YwmqEgZ6XKILf3MOjCp/zrLboq3oDIk=;
        b=q8eS23tBzc9ACMmJUjL4uUCf5MFLBb3X5R42OzxqFbusH68UWtH1SBIdQlHIVuSZFz
         5qaolwsPXvtjXFZmEEkkeRWRoJHUax2DwDxVK0clZO3BqaXKOKN5besL2eypQNWW2sHV
         sitl9XqnCwoyYaYQeUIuznEFWZczHVLirOFDDlzbLlMrUPJwATeXEwHPP9d80RNGsxAa
         pOK6i+EBBXm0CjxAShX0SauLE14eo6ZeR3HlPMXiZFaRAp9QaG4YWgr+5dMBga49lkSU
         o6BHgLW3fGB97W6/2UURKvlcik2qlAnVJ+swrxmbQVnIHIJCWcTErHI188U+DAPbOOPT
         YX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781035913; x=1781640713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nS7IcpZWz3b5YwmqEgZ6XKILf3MOjCp/zrLboq3oDIk=;
        b=jIBNHkH5Fy9L3sPm0eQUZ4GvUzxFt2/1Uuzlg05DkrmIKgppMdd1i0aFzd2vW7qCUY
         IJAElAzP6amWjkeBITDOFoiGqbyL206KEJR8x7afh7W0/OjWeAbIE3beyvj2lZpKiGYj
         S0elR2HaH4vMloIQPz9tNGbnNwUosZQwrXoj1ucLjOY3LMJQywQPtbpVn5CZ17em7eKW
         x9dIU1wrJeK50BJ+1Fuvkd2PLAghFMQlggW9jaJ/+ltuAMn3EfwA5hu+zfs2dX2YDDv/
         kNAc6X/h2HN0zjt8zs9Tafove3YoucyZcWIfLCEAUWaCvOJs+vvhQoxoGkZzJ68sJHTq
         ErMA==
X-Gm-Message-State: AOJu0Yz0UySGixWopaYygEHXnOLuF1qg8wsdwxZtkmGRxgBuhAYSG2Xv
	IsvBRN3DlyFb3ynXjem456AVPa0yLGPAKFuXhbC5YXrpysZ3a7qL6G+RbuXDDhAI1g==
X-Gm-Gg: Acq92OHRk51jvj6uuflk1LMIBh8ptJfy04KTc2pnXF8f4QyybEQGXrSQ8p321WaL3/0
	5imqLfrKS0xOpO/fyQzf0IlnI7rcgfvU38Fl0eCkzRIzxuXp+qLgnvOtA0TnajCuHAaiwePTcKH
	1idtF/SM6Gx4AWxuZT5Ouu9LE5ijpBfrk/rBWR3rJyfOW6UtXjo1YOaR1cmsWxEViONUW5GD4wa
	nue5x4aMFR9mBI9cpm1yl4NOCNjNc/LG6nH8A98tRH2fK8eLfVNs6ZHxe/E0bNdQQbjIhq0kPv4
	abErvd5nqvSevHWrdSCGl0Pp9/oj8/CzwaLuafoPxmd5RzmLBUPbuFkeLD3UhbCaOYHAljt2X0k
	5h/ja+7svhp5yg1aVLZ3P9L8EwY377cxY4ug3SIllGc4e/828jZYldskj5eMNw+Ffw2+8EuSL1P
	TPESrmzyrmpHm4qYs2vY/SWUkJ0RUHGbf8y1tLoZ0Zk6olZUAMEQ6cTQw+l+IG2QRxzRRSlLw=
X-Received: by 2002:a17:903:2349:b0:2bd:a61:8536 with SMTP id d9443c01a7336-2c1eb74103fmr6509495ad.6.1781035912985;
        Tue, 09 Jun 2026 13:11:52 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828fa877sm22581227b3a.51.2026.06.09.13.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 13:11:52 -0700 (PDT)
Date: Tue, 9 Jun 2026 20:11:46 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 11/12] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
Message-ID: <aihzgtczL99fM-1c@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-12-praan@google.com>
 <CAE2F3rCPgnFU=d5At1zrOLhsuVEbsweogOHGz9gDddRx73zRtw@mail.gmail.com>
 <aiEawEFsnG-LIahW@google.com>
 <CAE2F3rAWZ4Ac23D8eyAHfmaVVkHv8pz45+_dpMO1M4D7+RVCoA@mail.gmail.com>
 <aifsSxEXX64J1Etq@google.com>
 <CAE2F3rAGLH7si2S4aYhSUWyL-zZL7B_uo+WLE4zKY9SqKVi8zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rAGLH7si2S4aYhSUWyL-zZL7B_uo+WLE4zKY9SqKVi8zQ@mail.gmail.com>

On Tue, Jun 09, 2026 at 11:34:42AM -0700, Daniel Mentz wrote:
> On Tue, Jun 9, 2026 at 3:34 AM Pranjal Shrivastava <praan@google.com> wrote:
> > > I'm not sure if I have a good suggestion here. Have you considered the
> > > following: Do not call arm_smmu_handle_gerror() from
> > > arm_smmu_runtime_suspend(). Instead, call disable_irq() at the end of
> > > the suspend handler (and enable_irq() at the beginning of the resume
> > > handler)?
> >
> > I thought about using disable_irq(), but I think doing it at the
> > hardware level (IRQ_CTRL) is better.
> >
> > By disabling in IRQ_CTRL and keeping the manual arm_smmu_handle_gerror()
> > call at the end of suspend, we ensure that we don't lose any gerror info
> > We catch and handle any errors that occurred during the drain/quiesce
> > phase right before the power-down.
> 
> I think the beauty of disable_irq() is that it synchronizes any
> potentially running hard IRQ handler, which helps avoid races.

Alright, I guess we could:

1. SMMUEN=0
2. IRQ_CTRL.gerror=0
3. disable_irq();
4. handle_gerror(); at the end of suspend

Thanks,
Praan
