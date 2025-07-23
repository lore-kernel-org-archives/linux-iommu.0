Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77C82E5B0C;
	Wed, 23 Jul 2025 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272823; cv=none; b=Jkbt6gl51OYZTJpZESXPYKKMGJlARXwSyjBiDrOtwA1W5wVA1phBzvmH0BBMLvX1yAFZ6qV9hLvmgoecd4aZN6wXw0qDTtlIIbVryv2wUI/EB1QxjKni7rzt0whnR0csc8OzGv9e2BeF+GHfqQOfj0GNE13thSv1p9yMFjGtaKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272823; c=relaxed/simple;
	bh=aForeX81ulBt1NwI+Vee+Ra/gfDdqthVsLYHjg1huzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bsdb8ARYbKTTatEc+MgXCjtqUBHAWXuSsIhyMMASaG5h//2KgU0z77rPtLWGDsywpa+e7t3sA4S7qEoTGhzvUHd8X5nve2Z8B2ixnLdQdF2B96SRNL+HZ7A7HFi6TNHvaaRcQQvNB4rlNZ4UxJcCdNBoSNdtpq6lwLKe1WxdFJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLa8fVAt; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLa8fVAt"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e623a12701so263874485a.2;
        Wed, 23 Jul 2025 05:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753272821; x=1753877621; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1oDVKbfuzPoXEblaJbPogbvJRy/J8YBAAFt6Mi5hOyU=;
        b=QLa8fVAttrQsopC0K9TJi+RFEe5W9R0KEteTHV+X1NC8CTQcqzn1mnJNvIZnMtWKeY
         LxsGmaGeMIcYS2j2dl6xIM0g7oHa0u8cVyOnZyPrKM5pC5Thnw86+2wwrLer3xFG7jaT
         oDBY/fqBUT0sWir+61Uk0lNM4xrjd9M2X7Qb37K4FQ3OkJudoVdJFsAhwnggw3FkBm0q
         ld3RSwurdQEaA1ucEU179gBLEFeLIb4oGBoE6agUYXQRoJxjthHHS/xZ17YsoG2LOLaM
         rXFI7d4BeJnyvTsHb0h6uwsEdZy68Wx8A/7RD2GlOE0HiXzxAo41Nx66P1vqitc8KFk1
         k54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753272821; x=1753877621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1oDVKbfuzPoXEblaJbPogbvJRy/J8YBAAFt6Mi5hOyU=;
        b=Xo69oc51w88pnVFOeBTz565z69BpSYarAyklfGbedecAk81F0PYgTOvN6xExVlwRRj
         KkVjtBFQql12zmzQntC750Hg9gnrk8iz0ZIGH10RksNrYf0N3kZcFatpTVZTebm8Fn/l
         NlacoFNughMSEQN4hTwGrdCC3cpfBI6b2AMs8LIuYvXxNEjHQRLcnmgGwYQq5+T9R5IC
         u7M5PUQY3Hr4aAB01p+RxSk04fh7Rk5uwf3HHYtLTug1IS+GXnu4gku5gGMlBFG4MYS+
         FOctOM4eg7bz/r5MqbdPmYBumY5/n+qxpuPeLVE9uIFfgKAh0jFHxSutYcrnA++RZiKJ
         ZzAA==
X-Forwarded-Encrypted: i=1; AJvYcCWOSgUA+LeWXYSZEngSmwIjE2qIiNOXiodU4FhBohOo7ZVEEbz6mcn3LTPkW1HbJE4fwQkbelxba99v7MQk/BnIyLl0N5s=@lists.linux.dev, AJvYcCWVtfDVuMIJaRceM9YPnGcSjOqld3MFy5TfUIQeHUvS/+OYSk1ZrkYI4Xy6dbyDZ4EZrlUqXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywtso2K8Puj/ISBmwL3Pb8BaFMrWqSwOVX0GlYf/5ar8wYabXJG
	VDU9VxokqGOB+24MD9dbRu/PW0wIM1pFesOwatlltcrIKgyxAc+BocKd
X-Gm-Gg: ASbGncvoVZ2Zz+aZsy6QWG9pS2je+nT5mh+IPBuUuJ3oyBcHhvf5jJi7GWuwba5ZGlk
	MUpJgYADTKpm0LQnejzCiKmE1FatRHT4pQ0x1lM/r3bRbCF4KU66XsG1bUwCeLbm23eueNCxJvF
	C1SO1nOdCDSD+QkEePHOyhr8+HogWniCcEzpqZmV3LRjQjSg1ftf8CQK7mtg6Hsl/90YppkEEYS
	YU1PzHsgl2BGZa8p4RUGPGYj/Jjps3Z0aWbtUUMSyDzRiqt3ATxCRqhw3oPRu+REhS7D1BE2H72
	Z9XcClCCEuOXHMdlVYOW1yCl2BZgXNWLjOLhaxsQSLKpUC1J7VD+y17NSIFFmBiRFD7unVq9GEm
	PFaoNAxQA5raGjtvd0g==
X-Google-Smtp-Source: AGHT+IEvRmYJQjM9zsdRjRuGkl5/4rLc5vedFqdmF6G17vimj/rMcxhyJAcG28c6I/7w6VVDK2TG4g==
X-Received: by 2002:a05:620a:2708:b0:7db:93f9:b031 with SMTP id af79cd13be357-7e62a0b2e66mr370412285a.17.1753272820486;
        Wed, 23 Jul 2025 05:13:40 -0700 (PDT)
Received: from localhost ([142.186.9.88])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e356c3e36fsm639736285a.66.2025.07.23.05.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 05:13:40 -0700 (PDT)
Date: Wed, 23 Jul 2025 08:18:03 -0400
From: Seyediman Seyedarab <imandevel@gmail.com>
To: Will Deacon <will@kernel.org>
Cc: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org, 
	robin.murphy@arm.com, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: replace snprintf with scnprintf in
 dmar_latency_snapshot()
Message-ID: <xksn2q2mdvkb3fhgdbss4tm72agq7dlyvreuhh2x4v6fqxpvt3@jd3tqca2hyxv>
References: <20250722131117.2739-1-ImanDevel@gmail.com>
 <aH_RWQ_YqlydOkKH@willie-the-truck>
 <fvq3h4mbms64vzyqssy4xli2sudzpyimbacg74lkdgrzi77oqy@4yywt5fav7wi>
 <aIDN3pvUSG3rN4SW@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIDN3pvUSG3rN4SW@willie-the-truck>

On 25/07/23 12:56PM, Will Deacon wrote:
> On Wed, Jul 23, 2025 at 04:28:54AM -0400, Seyediman Seyedarab wrote:
> > On 25/07/22 06:58PM, Will Deacon wrote:
> > > On Tue, Jul 22, 2025 at 09:11:17AM -0400, Seyediman Seyedarab wrote:
> > > > snprintf returns the number of bytes that would have been written,
> > > > not the number actually written to the buffer. When accumulating
> > > > the byte count with the return value of snprintf, this can cause
> > > > the offset to exceed the actual buffer size if truncation occurs.
> > > > 
> > > > The byte count is passed to seq_puts() in latency_show_one() with-
> > > > out checking for truncation.
> > > > 
> > > > Replace snprintf with scnprintf, ensuring the buffer offset stays
> > > > within bound.
> > > > 
> > > > Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> > > > ---
> > > >  drivers/iommu/intel/perf.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> [...]
> 
> > > Should the check of the return value in latency_show_one() also be
> > > adjusted so that 'ret <= 0' is an error? I couldn't convince myself
> > > that the string in 'debug_buf' is always null-terminated if ret == 0.
> > > 
> > IMO, that's not necessary. 'bytes' can't be less than zero that's
> > for sure (AFAIK, scnprintf() doesn't have any case where it returns
> > a negative number).
> > As for being zero, in every scnprintf() call, 'size - bytes' would
> > have to be == 0. (or size > INT_MAX, but still you get zero, not a
> > negative number as an error)
> > 
> > In latency_show_one(), the 'size' is DEBUG_BUFFER_SIZE, and
> > 'bytes' in the first run is 0. So, 'size - bytes' == DEBUG_BUFFER_SIZE.
> > Since 'latency_counter_names' and 'latency_type_names' are arrays of
> > string literals, 'bytes' is guaranteed to be increased in the first
> > iteration, even if the rest become zero (which won't happen, since
> > they are smaller than DEBUG_BUFFER_SIZE).
> > 
> > So, the case of zero is impossible, unless you want a bulletproof
> > check for future implementations where the function might be rewritten.
> 
> Thanks, so that sounds like the error check in latency_show_one() is dead
> code in which case dmar_latency_snapshot() should just have a return type
> of 'void'?
> 
> Will

Well, there’s only one case where dmar_latency_snapshot() could go
wrong and return a negative number, and that's due to integer overflow.
It seems unlikely and probably out of reach, but increasing the number
of string literals might trigger it. So, I wouldn't say it's entirely
dead code. We can change it to 'if (unlikely(ret < 0))', or if it's
too out of reach I can send another patch to remove it and change
dmar_latency_snapshot()'s return type to void. (or a v2 including
both changes)

Seyediman
