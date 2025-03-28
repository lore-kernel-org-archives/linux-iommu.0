Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A32279E1
	for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743174527; cv=none; b=WR6h1BZ2pu8GqupH0FtlAfN4SOPO7q+ZJRoc/gxHsvDGicQ4138IVL4suhq4Ko2Ln2HyJrlJIMSu1cZl1p36KhoMOPkiCeaNIihJUTAoDPpOECDqs2tf7vu3gQUKm2KupjllqFRzCpZx0+9CraTa+IeTXtBHOLBt/iH4+AYi0xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743174527; c=relaxed/simple;
	bh=QqntEO1X5ZymFp390lM18w7g83XRLFOyNBw0Er5e3HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRX9Uk2kaDmgMJvEJ7IW4Y+VjgVCZkwlF1ugfCEtH2HAd3XURgXD8vZiY02zVMNSAAg/fXiOZQa/mTS3EpVM15/DQU6fjBhnkmoT2HKlrl5W6PGErIhxtYeu7G69/HyDx/Yh8QQ/5SHjvFe7eLdFXrqHj9r6o7J9EG6jGe2IiIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0QTrSS1L; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0QTrSS1L"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2240aad70f2so255595ad.0
        for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 08:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743174525; x=1743779325; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AKHLKTK2hD4Sdccydg3HYf+F5u3EBDzc0KOEexdmjAE=;
        b=0QTrSS1LZhbRj0rvY/NY6Zb88eisJiBvvH62JzfSs/sH+Xmd2kJ5FL/iTiKVAho55J
         ZxWG6tINJqs8Lx7gCGRI7mx8QAnnV03JZ0UhYPWD9hUvF8oD0MJzXhcxIDx5wvmyLOoT
         Dnd2Ce9tAZUJAmtjzNwBUVqOoA20iTrTkQjSMjQzhFc6k+rwp4jueoqX0w9v24vHOqku
         2oTbSX67ffYIygrnwb3/7PQnNk0/TSmf9nYnmZpcDSeCzKZoCWKg5INxK4W0p5gqAas5
         4YjtLMjIJq/PRO6eerC3W4haUVrk7gcw/txxVXgGGGGKVcIeGNrtluPvoN2c0G/T8xwS
         hTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743174525; x=1743779325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKHLKTK2hD4Sdccydg3HYf+F5u3EBDzc0KOEexdmjAE=;
        b=f46M9MQUWAa7vQ/b7RTpGkAaCfHI+DoQYDrRuL41IbueYUdYInMz3N5qj+NwnPKdKL
         xrWKhayB0zBHumqBXRHQQyDr6RJxnhV5MWPpsENg5QDPKnLIwEu7CKh3n0U7vVmZWA4i
         nHI66cAEfSNsu9VfLOVo0QGaCPAHHYaYGoOX+LF1HHcvXLpO3oUJMrd+M0D5aGyUw+7M
         hoFitSX+G9B1F/NwVYe94140CczP6vDo0gYXi2StFT1dPsuBUIbY9KcrwM1R4ZsmJTeX
         AKLMuHw/wxC00DXzyTKR3U4KBKt3gAgd+YNEkoD77zCxJpwvyGO7Vfq4WFe5F7PAbYZT
         66Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXRj3Dg8uMly5/UMS9Cyfo7h/tC+HQ9NNmsETFABA5aloa/HAUQOOT0Tg5epXXCOCCG7Xf4aA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6kpXm3C8fUm5KKD5Ctbt+RLt56MMg8/eaLSDZbsGT/6fouSNB
	8jyKP6lCalDWXCIwXB0E5NPmyGzTBffdKhet7f1wRdc3bawWkw0NjHhiavCfOyWzRTWuHI2rlrV
	FMA==
X-Gm-Gg: ASbGnctG59BMNpTF2Bucy9Z6d/NnARl5XWsEGVAwkNlsUDXLNGxUPNepMxaCpVuh714
	AerBUiUYX9pYwysQiVCyz+dY0Fnmd/izND8AhNlWxbZpRnAxfn67sQZWpO0kgdq223mbVJHdnjo
	tt3qYBWrKUC0ijOhzYmEbhTNFjjkrzFtCkKinI1NLwCMUb7cW7p6P35GgFi5EEVSfJ0TIFhtyze
	RO+c9C4JkqSzk4NUKBdONSUdnVCranXyTsrGmjVWzADK/83m9NJmyRq+WZlGDnvXdjqfp4WVO1x
	Vt3I4qqzL6OfWNCYIxLxVMX84QVXZVTaM2U4+DYaIu4wR44o/X3ytryx1S/0U6XK0BiHY6bGdVp
	rfXQ=
X-Google-Smtp-Source: AGHT+IHKFxUldid48FWSkTvmPnWzw//vPZO19hJrsyr8wQJ82573wK5C9Du4mOP4yKWlGpk6ijCvxw==
X-Received: by 2002:a17:902:d585:b0:217:8612:b690 with SMTP id d9443c01a7336-22920ad2436mr3013665ad.8.1743174524834;
        Fri, 28 Mar 2025 08:08:44 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1ececdsm18937055ad.218.2025.03.28.08.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 08:08:44 -0700 (PDT)
Date: Fri, 28 Mar 2025 15:08:36 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mostafa Saleh <smostafa@google.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <Z-a7dF9HPGteVVCp@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319115730.GC10600@ziepe.ca>
 <003f23d7-b829-4611-8dd3-35b56a7ca90e@arm.com>
 <Z9yV8KsdXnZg1Ppo@google.com>
 <Z911UT59UnDzRymF@google.com>
 <63806834-a0a1-41e0-9cca-60087b460f78@arm.com>
 <Z-GYKyBi78tHw8Lx@google.com>
 <Z-WKlZMBDTJDSfd4@google.com>
 <Z-ZoHdfgyaZoqJkm@google.com>
 <20250328131844.GC20836@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328131844.GC20836@ziepe.ca>

On Fri, Mar 28, 2025 at 10:18:44AM -0300, Jason Gunthorpe wrote:
> On Fri, Mar 28, 2025 at 09:13:01AM +0000, Pranjal Shrivastava wrote:
> 
> > Other than that, the MMU-700 implementation spec[1] mentions that 
> > certain revisions might access config and translation structures while
> > SMMUEN=0 (through an impl defined prefetch), and one of the provided SW
> > workarounds is to issue invalidate all with SMMUEN=0 after the SW has
> > finished all modifications to config/translation structures, which seems
> > to be happening anyway with arm_smmu_device_reset.
> 
> That starts to become another security problem though, if the SMMU is
> not in forced abort and it somehow loads invalid data into the cache
> because it hasn't been fully setup yet.. That can't be allowed with
> insecure attachments :\
> 

Ack. This is just to address the caching of invalid entries. GBPA.Abort
is a different issue.. All I meant was that when SMMUEN=0, the TLB isn't
supposed to be used for transactions (as per the spec) even if
GBPA.Abort = 0. 

We'd invalidate all entries in the resume callback before setting
SMMUEN=1 (as part of arm_smmu_device_reset).

GBPA.Abort resetting with 0 (i.e. bypass) is a different issue that we'll
need to address. I kinda agree with Robin there... we can't control what
we get when the resume callback is invoked... FWIW, there could be some
firmware that touches the SMMU before kernel does..


I like the idea of a flag telling us if the implementation boots with
GBPA.Abort = 0 but I'm unsure of how the iommu driver would understand
what attachments are insecure (or even if we'd wanna add that kind of
intelligence in the drivers)

> Jason

Thanks,
Praan
