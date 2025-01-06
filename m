Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4191DD0D4
	for <iommu@lists.linux.dev>; Mon,  6 Jan 2025 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162951; cv=none; b=Bcy9ntgIzDvAGCsGGW5Y/EKE8mlZ5s4/RwxpaFYjyTzVxR7k1ukEXrir11APpSmB+qRaUKcx4/o7gpsNAWlyetsxYZeqIglqr63SV53SqtUWvXrtT8bsB/dYXiEdVTwupT5CBf++Q/NRI1/USvMD+sd+itjxvyaB1Vn/OpCv4bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162951; c=relaxed/simple;
	bh=tI5fc42ryrygOeH6dsKGzKwJMBW4jSmsF+51xguxsmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOE5wcvLbT6dguZPfP4bABVEHC1DWIkSL96oTB+nFrfbMAIZ5w4nKGvnVCLFdab0FiKKysHyMhw8MiJlfV8+sic+mPWclvjE2umDtD2i34kBVml1sRNIPCShGXNFeVCyAuARBRfRmVnPtLdKS9pBQwRL54p3rbAj+5LPu9NtzUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pkuo4ReQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pkuo4ReQ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2163affd184so186015ad.1
        for <iommu@lists.linux.dev>; Mon, 06 Jan 2025 03:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736162949; x=1736767749; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDZrKZ6oDkBIb+Wettj6ueOHhI4RIRyDtV98zYoes5A=;
        b=pkuo4ReQjeBlTqo3sDV3XeCA6SzvkO/2WqCxAjSBt3PsLoVze4CxVp9wwTa3yLeayW
         Tj+mkskD3/6zcakUsAlfew+d0sYMGeiNfJejGjY17XiYcE/9upPFwqqwGWQlMbM4FdX/
         Z8wzKf1HkA5W+SgutPYSZh30kDs/XMCYuR6SxIR0kDX3eGEP8lKLWXbzyOdv5Cd7nfsJ
         VcfGF62ZfN+8dWfR+813mgcpt6kWikuKs/24uwX+FE8ie3zSC+SWESw9+C4N416wQhNY
         scozF6ZD4lEUcL33crvpgHk1Tzj0+7/ZQEbbbORFhTEGG3hlYubVfk+5AE12u220cupu
         n6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736162949; x=1736767749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDZrKZ6oDkBIb+Wettj6ueOHhI4RIRyDtV98zYoes5A=;
        b=B/KEKaEoU4YAaMSSdbT5vJdnKoqk2LBXR90+0qS4aBBj4owiy6hSy249S/K6lqPInX
         RCQMcGZDMaiXdrIK+WcHIv2WsRLsHD9GNG7RuSwUEu+dwN2y5DzxoZdDFIt316iTSznJ
         ieDSPif37GIdPBhuFLrNTrXRk5YfMa2Po5JLtaIQJjEX/lvlVtGHRV6Wrws3MezxzoEA
         F9VZnK/BQ5bBes9rLeIUPsnv//BOnoJ6C4L4F5kXxElFOMpzfLuP+pIzoHZipBcApTe5
         sFxR2YDZvTorD6Cl1YA8Lg/lM1cByq/SeKFWPuHADJ79/AoFhXzl2RXILhgB2ngJtxkL
         bhkw==
X-Forwarded-Encrypted: i=1; AJvYcCU5eZWofMYaN6xW2ofHkw0gd9l8Tkrm7dZy2znwaAXpne5DPv38qRrze4myrs/JcYF3haiWwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFQYsWqMH9MebXom3b5BBI5yn/mvK6EB6/oUOEUA1LFyax1D2h
	4//NLVr/9OEY5CUAy5bfOycQ3xcbdLzM37xniAA1CQJTFDNeWOLviFF8pD85ug==
X-Gm-Gg: ASbGncvO/Lu4VkD5gIOi3OhLla6w7WRH3/VXbYn/BFcwDZFTk9XKpfFjvJHqBwKbY46
	GdEikp7IAcCwDkRXhkLWvbrm0VTiV9bpxewObgoB7FXsexCLCIRprKk+aDY0cgii8Tfn0zC6pNR
	FxmYuREiwxFcQVjvkT1oTOt2NQhwu7TAsD9sHftWhhGoXnzQixSPD6uXT+svziVSMoaRrv2tJDw
	GApKznW1whyVd+dLOs7CDB1HwGwzSjQeblKElRfe7h0hkHcdcviQm4hbdhzl05Zk/lS46h89Og6
	3Z9xCJ0CU7xe
X-Google-Smtp-Source: AGHT+IFZkjJtNV1pksDuYNlegzLlidrTi8fIyrs4KUDqdkljqyGb3FrGl4Mr9etFGBRw8s/K0G1pow==
X-Received: by 2002:a17:902:e5c2:b0:215:69a3:1c94 with SMTP id d9443c01a7336-21a62c072d3mr2910295ad.28.1736162949020;
        Mon, 06 Jan 2025 03:29:09 -0800 (PST)
Received: from google.com (1.243.198.35.bc.googleusercontent.com. [35.198.243.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8164d3sm31182863b3a.15.2025.01.06.03.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 03:29:08 -0800 (PST)
Date: Mon, 6 Jan 2025 11:29:00 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Will Deacon <will@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	catalin.marinas@arm.com, kernel-team@android.com,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v6 0/2] iommu/arm-smmu-v3: Parse out event records
Message-ID: <Z3u-fJSL7JurZXDc@google.com>
References: <20241203184906.2264528-1-praan@google.com>
 <173378062404.4091733.5462540525505481045.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173378062404.4091733.5462540525505481045.b4-ty@kernel.org>

On Tue, Dec 10, 2024 at 12:17:29AM +0000, Will Deacon wrote:
> On Tue, 03 Dec 2024 18:49:04 +0000, Pranjal Shrivastava wrote:
> > Enhance the arm-smmu-v3 driver to parse out useful information from
> > event records into a structure for better event handling & logging.
> > 
> > Some sample events, powered by QEMU:
> > 
> > 1. Bad StreamID:
> > 
> > [...]
> 
> Applied to will (for-joerg/arm-smmu/updates), thanks!
> 
> [1/2] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
>       https://git.kernel.org/will/c/43ca55f5555b
> [2/2] iommu/arm-smmu-v3: Log better event records
>       https://git.kernel.org/will/c/d814b70b9b90
> 
> One thing I noticed when playing around with this on Qemu, however, is
> that we print the raw hex dump in reverse compared to the way in which
> the record tables are described in the spec. What do you think about
> doing something like the following on top of your series?
> 
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 143ff6336a95..d33a150b29ef 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1880,8 +1880,8 @@ static void arm_smmu_dump_raw_event(struct arm_smmu_device *smmu, u64 *raw,
>  
>  	dev_err(smmu->dev, "event 0x%02x received:\n", event->id);
>  
> -	for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> -		dev_err(smmu->dev, "\t0x%016llx\n", raw[i]);
> +	for (i = EVTQ_ENT_DWORDS - 1; i >= 0; --i)
> +		dev_err(smmu->dev, "[%u]\t0x%016llx\n", i, raw[i]);
>  }
>  
>  #define ARM_SMMU_EVT_KNOWN(e)	((e)->id < ARRAY_SIZE(event_str) && event_str[(e)->id])
> 
> 
> Then, for example, a permission fault looks like:
> 
> [   32.543815] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x13 received:
> [   32.545115] arm-smmu-v3 arm-smmu-v3.0.auto: [3]	0x0000000000000000
> [   32.546361] arm-smmu-v3 arm-smmu-v3.0.auto: [2]	0x00000000fffff040
> [   32.548672] arm-smmu-v3 arm-smmu-v3.0.auto: [1]	0x0000020000000000
> [   32.550209] arm-smmu-v3 arm-smmu-v3.0.auto: [0]	0x0000002000000013
> [   32.551990] arm-smmu-v3 arm-smmu-v3.0.auto: event: F_PERMISSION client: 0000:00:04.0 sid: 0x20 ssid: 0x0 iova: 0xfffff040 ipa: 0x0
> [   32.553952] arm-smmu-v3 arm-smmu-v3.0.auto: unpriv data write s1 "Input address caused fault" stag: 0x0
> 
> I started going a step further and printing the records 32 bits at a
> time (again, to match the spec), but then I realised that the current
> code doesn't look like it handles big-endian properly...

Ack. I think I can post another series to refactor this to match the
spec by logging 32-bits at a time in Little-endian. I'll give it a go..

> 
> Finally, coccinelle suggests you could use str_read_write() instead of:
> 
> 	evt->read ? "read" : "write",
> 
> which I suppose we could.

Ack. I'll use `str_read_write` do you want me to club it with the above
refactor in a series?

> 
> Cheers,
> -- 
> Will

Thanks,
Praan
