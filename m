Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489E42DCF70
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770063274; cv=none; b=Yd4szjqL0DhwAw3X6ZLLM4aJzJtEt1JSc7j1rfg+bxir1CKtAYpTkJy2mo31j5S+Nej824beS1+SSlC/HqESdILew0ylyFUz0HP2c7lHyMPEjqIq2GZLEauRkHl8l9u+bIORZwX7Zz5B0ie7pGPiiLpJMPq2q+yMNpJFzTHrpjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770063274; c=relaxed/simple;
	bh=oWhUHT9ekXu4rrvkR3lQgyu0xLhDCifGPwHFBDAozdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyWdyGrEQbcSrRZEa7pvG49nGbKTveLO+UzJ1FpZgJlnDetuwwTxRG6hiBNfbP0Gx+ZKC/HzehAyShz6e6QWicwlmzP72wud8Tkqb7MWGRk45vHpjtnvT4i7ZiU1nqR18aW9mOylXldAMX6Axw7hRltU4lU1EbISTou0ae7d96s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xj1CG3EJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xj1CG3EJ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a885af8ee7so15345ad.1
        for <iommu@lists.linux.dev>; Mon, 02 Feb 2026 12:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770063272; x=1770668072; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sbVzDr6j8Cnfut/dHFXPjRRVJpGHldRxEVpuedl20WE=;
        b=Xj1CG3EJBMO2KpeeOx/WoaUQNj9xkmeSP8PTy95MfnvIXCDXnxW9UJ8aQBR7Ox06Cg
         xWG71WNn6OFmcDbcRTIvKC/rObrD5hvRueWU9SoiWe7pBJ3REnfJOEWAuZg87F4EUI1a
         JP2JuhpAMU5jh44OvPNV4gEAc6Spi6aAiVCGcUdvUvXPadsnroM413nyuP/6XbHpXfBM
         EZIe+VxhktbPlS+BYGulq8qNjG1v7VF/qm6Nbswv5AzLmQlgbzgRVOB1exXyFJw9yEla
         MeZefBrCN+6AeKK4V8OUk9uWNb+85jmsREO3ILX1vLRR762GQ8FrNWCkZrhihygvExnt
         tp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770063272; x=1770668072;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sbVzDr6j8Cnfut/dHFXPjRRVJpGHldRxEVpuedl20WE=;
        b=Y2Mr00Tl6cnSl80wTWl8Da94DP87fQ67Awxy26psuPeiJw/ARKAXjA3SgYeWDhSglU
         7YMM3dXNgAuQaaSkLLPN2b+NDM1Bss/niTDK8DczqB8LP1Gn3A9tVINodQGOyL6fn7Tj
         bFPG32aA4iWODLAg3L9CA/8st7EjvQr3kAUe8pWNbBGnVVo0jGeNHphRZW7sL7bn1WOZ
         jvk7RKiHSxl5Nd2gjsAVfIWKMxQgyTas372fvBjS80MwM7y8wMBQLicRATASyLw8CpD3
         NIwCohkRcAV3BZZzhWAsFlXAFAi2f4Q3WnUyGGtE6K8v7o7kp/5x7NrL3mJSjzatG9IX
         xeig==
X-Forwarded-Encrypted: i=1; AJvYcCWUx4RtVVPxS0LT02a9xulQF6tyhN0A3cL4MWiOqziFdyp/SM8L6ISf1XHWRruVszm8rKU0gA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyX5w2FXHHfDvl/sYuYZMBIFGylD6caSpwnxPlFe47B4moMWeNv
	crdBL6eLhcIfzRCszk2Umfvxh9O0vIvKtnBV0eSI0uqA9CZYgUKgvzDMxV2siMxuNw==
X-Gm-Gg: AZuq6aL8Wc2MOKx1xscxIVHwtiedN8GRRHGEGz17bO01L4VzjoAeTQkoE8o/Wwi9lN4
	urScQW8Y2am6C/sZz0qrx++kPqvvuc6UpBOAB1pqTeQJvV6Dj/FgB82/UcOrTDz9kGtMhQ/p6cp
	pfskHZIaBfpQCYGFJ/5gOeETIluNH9VUKqb9btN9agZC/YK69eyJkT1Fn6HLIrDShrCRJovf0a4
	SBJ2WVKkh36R160l6TLZdy2pj4BCbVsayKoFKOV+gqScNPZfkGC1t3xHrZiZaAn4jlrUi9WGKQa
	1vmqYmRTteaIEktAyySFgsT2L05pIoQxQ44PmApvVpz6wb3OPoUpWuMnHKBGfktQTv7NGPc6/6S
	A1qR7W5gXciRQQZwkUOjIfuuz7K05SN6+RoA8bRQTmUGz9xprSpTRFzSQ1yYWNbgS7ciDKzLjNr
	RmPnBy0rDdHL11mel2kb8OPDbQ5mu5kraIhTkbBEFG4/ST/eUb
X-Received: by 2002:a17:903:1a24:b0:29e:27f4:bac0 with SMTP id d9443c01a7336-2a92546efd1mr619255ad.16.1770063272159;
        Mon, 02 Feb 2026 12:14:32 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c3d2bsm161078895ad.53.2026.02.02.12.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 12:14:31 -0800 (PST)
Date: Mon, 2 Feb 2026 20:14:26 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
Subject: Re: [PATCH] iommu/arm-smmu: Use pm_runtime in fault handlers
Message-ID: <aYEFop8CJiLYzhLw@google.com>
References: <20260127-smmu-rpm-v1-1-2ef2f4c85305@oss.qualcomm.com>
 <9fb8f661-a235-4f86-bc10-f80a21a8fa9d@arm.com>
 <00fcbcf2-3f48-410d-88a3-88dc834c1ed7@oss.qualcomm.com>
 <d6bc7f38-b41d-4e89-b484-0e699981b8b4@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6bc7f38-b41d-4e89-b484-0e699981b8b4@arm.com>

On Wed, Jan 28, 2026 at 06:44:35PM +0000, Robin Murphy wrote:
> [ +Pranjal as this might matter for v3 too... ]
> 

Hi Robin,

To weigh in from the arm-smmu-v3 side, we’ve attempted to address the
"can of worms" regarding power races by leaning on these differences:

 - Threaded IRQs for PRI/Events: In the recent series[1], the PRI and
   event handlers are fully threaded. This allows us to call 
   arm_smmu_rpm_get() safely, as the handler can sleep while waiting for
   the hardware to resume.

 - GERROR Handling: Since GERROR remains a hard IRQ, we handle any
   pending gerrors in the suspend callback before the SMMU actually
   powers down. Any GERROR interrupts received while the device was
   suspended are treated as spurious and ignored.

Thanks,
Praan 

[1] https://lore.kernel.org/all/20260126151157.3418145-1-praan@google.com/

[...]

> 
> Hmm, but then how *do* we actually guarantee that autosuspend doesn't happen
> to kick in and power down the SMMU just as a hardirq handler runs, when
> there's some unexpected event? I fear there's a horrible can of worms
> here...
> 
> Thanks,
> Robin.
