Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1572D29C2
	for <iommu@lists.linux.dev>; Fri,  5 Dec 2025 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764943812; cv=none; b=RM88Okwf6KNiQShQNi/jYXQ8FfEchKG3kc/bhOmpgSOZsBe85SwTQoeowtrcHLf6f0RWQUu/N9atEP+peTEIPviJKV7uwamkYYt+tMZT3C55AmsKxVn1SW7nO3FfngbaBDkGuCOcoc8UJx9l0kCWBAsWAN1sCZjqBdlSDxsklKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764943812; c=relaxed/simple;
	bh=gnCEBRkidZwyaPEKnpkIAePBaw/pe1/iXZz2aSes1Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=im0n7Aili9lL8maz3wmrbgaxUSGklwNEN/pbvkSEC52zaHT9npEp/TjQnABAwhbA/y2htEi6PgK9Xc2QJI/AF0bG074zXxOCDuKjaRPFaCujaUKt0qw8rlLMbd4NjOjMNtBf191NzZ7SV5tfb012UwfqdFvq/1i9UQa/eoBpWAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Uv59qZr6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uv59qZr6"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso3445220b3a.2
        for <iommu@lists.linux.dev>; Fri, 05 Dec 2025 06:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764943808; x=1765548608; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JPf0COEbNpriVuumzXQyO3bI30l5by5dgElwjM0SDRQ=;
        b=Uv59qZr60ojRjJ80MX9IZujuB29mMxxtwAntfEVKsy3AUX7FmwklTQkN+f/BFHUuJW
         FFCKs84W5ITi7VtUTkMxkIckTiwaX2CKADmgMRuHgpBXQITrJ290uzH4PwydoZtl6e48
         QdLN3ogSgPwflA9MEggSX0SuHyMuBWGsIcFps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764943808; x=1765548608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPf0COEbNpriVuumzXQyO3bI30l5by5dgElwjM0SDRQ=;
        b=ogjMbG26Y9kVhLNODiAmDn0+N297WbTqwlTDp8fBWKuK1V/eIahDBhuidT4usuN2k0
         gzGBaoCLaFDu0dpcGIA9b9W46IZQQh5OJVeggWrH0gvz8Ug1JEgFAJf7XgFiftNoyveU
         CFYP58IBdJZJ5MvAEhe5AZzKQCD+rawer09gEcIVYZ0gYHAQo7J8uA60FVn32FYt+xWE
         WH7S6dAx/UvSeqjVQG0zgoqAcDMtE+DKTR4M/viz4oEK8bJ2sIrd4aa9hoYNYzKzq/E0
         1CA16WKUC8TBqOLQFIByNCVIHQv0Wlc8++Dz2/C8+RU1DvtKuu41ONxaqy9zS5u71yFs
         mgJQ==
X-Gm-Message-State: AOJu0YzGdPG2LpCX9dMl5LOHVOKJdB+DRI1Oqux/F3f2jw9olOKrGfyq
	Sc7ZfrQHsImrahDGqtN7PYtVa91QCHmDs9P4Q8OyLQcj+Erf1JaCES8ApM0YjVje8g==
X-Gm-Gg: ASbGncvdeFcNtMZPnTMIp+3Orcvg9zscjs8+cpjJWeu+dNUInR2g/NYkSTbj/8JCJVb
	jIA374IH414KDuiiATfvYTHe1Ha7jyAVljYmM2x2ECLrzqCyDsNBuePTuWUSI4ArEnfvmEheElC
	UnKGTKiOuYHn+8R4j7xAsrKSojkpzGto/56HdF5iabo6e9RcT/fcGSgSNyYLA2cy9UTaGbgl3wQ
	DcjypmhY6bD+VcCvHsGG9LrK0i4O2tdsVHoKx2m3dmrfBFkabmEuWqQwR3LL0zFeb4Dl/w0K0S8
	N3YVPq1GXgZnhIoFyWvtwdQ9HEEFzdUbtojFicybbV0l68MTHVB62UMZqP1jVOzJEFSZ2JZ7JKO
	76M13wCSuQr+pv6wRF8PSA5RatisV30E8skPG0AsXz4nkzBc7M9+8aEDy2FUcsrBiFz/9KBjvgv
	QvPbhsywnY
X-Google-Smtp-Source: AGHT+IF2A72F0zyuYb1qeE56wYDSKLzZlV+L5RsoW4zbZH3zjztf+SD2FbICsfjkg0jjwhd8gJJ/Ag==
X-Received: by 2002:a05:6a20:939d:b0:35f:30ff:89f1 with SMTP id adf61e73a8af0-364038a809emr9057699637.56.1764943808237;
        Fri, 05 Dec 2025 06:10:08 -0800 (PST)
Received: from google.com ([2a00:79e0:a:200:8c1a:ba94:2497:cd7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6a1306a8bsm4840066a12.18.2025.12.05.06.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 06:10:07 -0800 (PST)
Date: Fri, 5 Dec 2025 15:09:57 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, David Woodhouse <dwmw2@infradead.org>,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: [Intel IOMMU] Question about memory ordering in context/PASID
 entry updates
Message-ID: <aTLntWFSADz81_NF@google.com>
References: <aTG7gc7I5wExai3S@google.com>
 <b9c23895-ae8f-4c71-a0b4-5956e2719901@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9c23895-ae8f-4c71-a0b4-5956e2719901@linux.intel.com>

On Fri, Dec 05, 2025 at 01:32:51PM +0800, Baolu Lu wrote:
> We didn't implement that primarily because we hadn't encountered any
> real issues, operating under the assumption that the root/context
> entries population is completed before DMA translation is really
> enabled.
> 
> However, that assumption is incorrect, as users can change a device's
> default domain in VT-d legacy mode. This action triggers a context entry
> change while DMA translation is already running. So, yes, this is a bug.

I see, thanks. I might try to prepare a patch, though it seems not
exactly trivial to fix this all over the code. Roughly seems we could
just modify the context_set_*() helpers to use READ_ONCE/WRITE_ONCE
similarly to pasid_set_*(), plus add barrier() before
context_set_present() and pasid_set_present() calls, plus maybe we
should also correspondingly fix updating root table entries in
iommu_context_addr() etc.

BTW why exactly I'm concerned about this: even if no one has encountered
any functional issues caused by this, DMA isolation is also a security
thing, and an attacker might be able to exploit this (albeit only in
case those operations actually happen to be reordered by the compiler in
a dangerous way in the given kernel build).

> as users can change a device's
> default domain in VT-d legacy mode.

Not in scalable mode? I'd assume users can change it in both, and I
don't immediately see anything in the code that would limit it to legacy
mode only.

> Thanks,
> baolu
