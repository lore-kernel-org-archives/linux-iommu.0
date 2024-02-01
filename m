Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D9C7E0F0
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 16:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804601; cv=none; b=gZhXA48lBHEnVVEF8YXErHlk9IG1nA2bwZNkP1VCGqd2izbPrwg6G3z7EdRZAI+jbEkrXNUR3ewavd2RaB6dymFF3e9oDWvKgJhZbt9+qA/34A67Jd7jYmN6ulLRI18VbTy11jjxQY0usDWTP4/mVy5y41f0jaci/SvcShxKsiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804601; c=relaxed/simple;
	bh=CcTsJRuBV7FsnKfKzyIU75uXHMZOKiQnJvCybgMg5QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hne1awESp49tmaZJtTH9fqa+0zIzMwyaJbDFeL48Lj0j3F5yj+oOvMfSLySyUXE2GMIrkWjNj8/8XDmTGZPdEmYmgVOCCgRj2L4zkoeP0BnppGg+XN2ZYyrg6p8j3JbXMfM9/VYVUq+FhXvVbm+sdRkmhyCuZBjjD1Goyr+9MPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oG23djQE; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oG23djQE"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7838af983c1so83716385a.3
        for <iommu@lists.linux.dev>; Thu, 01 Feb 2024 08:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1706804599; x=1707409399; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CcTsJRuBV7FsnKfKzyIU75uXHMZOKiQnJvCybgMg5QM=;
        b=oG23djQEy3xEUqp6r8fmhouAyi0LwKSaFjdesQM8KXcPAkLpnkv29mTMp1r/G67P8D
         V7S6lNkxOfZEIWsEj53d4xjlq5YKm/VZ8O3AMrXt7JMXV1JLEt3U0JSKrdP65N3BeKeU
         OvwGf8vD5Y+dgZnGUxGi5pmZGf9cHLfXDeqbjW94MUpjOu4wiuHWvbLVpMhDoG+alRSf
         l9DYxADo+v9MVTHrxRxBUdP2DTlexpED7eAvZBdl1j/HvziXQLPT5FXr3y4JL9a/7890
         tSEvc3DIvo7nkO3hAVCizPjszWS1yfii7vphwu35zdVB2YfUce09io2D6STqW8oHJEWQ
         zfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706804599; x=1707409399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcTsJRuBV7FsnKfKzyIU75uXHMZOKiQnJvCybgMg5QM=;
        b=rJwXqg8d4wy3qZvW6ryJmMlWkvn5ZVh8vzvlRhLexEn6KKjJrW+0XO6uX6lzWtOl1c
         GdfvAbKRGjc9euNTJvI1eMzhxoeBeR9WPzyAXrix4/KUlOSdzyHzHCUECQOmKRiqpMyO
         MnWWXXBBEHG6vWD3udCL5SvXB29vmjMAZpIz36gMnZvLQrPGyoobf9RwFEJPODOGS8np
         NjxxxecguThZWBFa5+HAVCjpId4exF+1C2SCpIwu7kjTS5HDAs/wwpuiM5EB+QON429j
         k/MYRged1IV4YgQf46Pp3smLSjRkut/DPQkBHzMBnw8mSEouuN+wypV2VvJCfQzGe+Aa
         fSyw==
X-Gm-Message-State: AOJu0YyDHwjIB7oNdJG6rOBiBmCQnXw2yPvPUEga4aY4QecOzyDKFIE7
	urFpufHZfMHrD38U6agTuGantHftWT8vYle0X8I/QQCTfQQBheH2CdcdcX2NItk=
X-Google-Smtp-Source: AGHT+IFi4KZwaIGRm3q47w7BjMsKmiX4fpOGOKit+SVa9n3QbWQY3Wl0wBNYNELUTfzSXr2sJraYZg==
X-Received: by 2002:a05:620a:2491:b0:785:501c:2bd2 with SMTP id i17-20020a05620a249100b00785501c2bd2mr1035299qkn.38.1706804598763;
        Thu, 01 Feb 2024 08:23:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU87vsPNAg+pZEP5zUOh6/YC+YRKj4IweuYEznAwhlkaHTekFELvGEStc9E8xPfg6fdFoHbklzzDDEyWsQEF68iOX77q3SltmJfpPNZaLSf4Q5bmL9RMxTq1lt8kN+kEiP8o3PZzz3GzB0VtEY1vjmTkktIMB3EgdsUDAXX+roW0AYz77LG0s654wnd8RyTj2TsWgPGQBHsbf2kpVNp2bBCVaa6tg8=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d23-20020a05620a205700b00783f77b968fsm4034200qka.109.2024.02.01.08.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:23:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rVZqP-00Ammc-N5;
	Thu, 01 Feb 2024 12:23:17 -0400
Date: Thu, 1 Feb 2024 12:23:17 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nikhil V <quic_nprakash@quicinc.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Avoid races around default domain allocations
Message-ID: <20240201162317.GI50608@ziepe.ca>
References: <e605b38a2d40b1e7589e10110c6d3ece35f6af4e.1705571894.git.quic_nprakash@quicinc.com>
 <139a9abe-75d8-3bda-3ec9-a14a493eb2a9@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <139a9abe-75d8-3bda-3ec9-a14a493eb2a9@quicinc.com>

On Mon, Jan 29, 2024 at 01:29:12PM +0530, Nikhil V wrote:

> Gentle ping to have your valuable feedback. This fix is helping us
> downstream without which we see a bunch of kernel crashes.

What are you expecting here? This was fixed in Linus's tree some time
ago now

Are you asking for the stable team to put something weird in 6.1? I
don't think they generally do that?

Jason
