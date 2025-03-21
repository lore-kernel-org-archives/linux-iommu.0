Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86B09461
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742571039; cv=none; b=vFBaIiqCOHhMEGCek9yYqaIZCSwa1YqdX8fdiNUXafV3vhDzKiraxpGVVZ1EDRiz2JlFeKBTFFco/e1PS7YhyDcv8ISJOmP62mV862UZNV+zWXCrfRMWZcKtazxVxR/a4t0P98RUt32+XxDmVPbvZX3tO+3HtWLs7jwr+ufw00g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742571039; c=relaxed/simple;
	bh=8PHcbWJYouIzOj0v8sng4qswgXFi+gQaQHjq8R+pzlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vnt957FuuBnGMPFgiJgICLF5oBOVCQMP7B6rOOvswcWJ78sb3+tpdaCUUdAEJ8eNli6LoBT8Nmya+wCJPJV0CgWHb0d33k3ALTkgV6BHXcLlQ2x1PZNLDg5L6+5RL2MI6u6vv/ILZKbwqiqN0bI0QrFH4Gmd13A26Q3fpZEV+NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HHI4OtJj; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HHI4OtJj"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c3c4ff7d31so288169485a.1
        for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 08:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742571036; x=1743175836; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fWzJtKLPj/ANLzXXkhlY2o1HgIUBXjjvPZ3J9Gel80A=;
        b=HHI4OtJj6+rY++SWY/xZK6k/zY8Y/GpjeVZx4TGcohjVxcOvBXFAS2aFiLq+rzhLeA
         BgGZNYHVe8JsbieZK0yVX+tpAoRiSQmS85NkVP+Swbu554gdm8n4Bs7EYAErJJgH0dhx
         nNwTmp4kdD74hJrSJoKv4C06eo0attZYdg3p+sm0mfyH7Ykk5JiLokz9v/jwpMGgUiQV
         8pBxW7/n9HX+/muCl3QMrFMgWtKIbazXaRBgZezTDO6HPAsNQhewniacUwqKFR8kCYPJ
         9VfIoj8UlyNouhAPC8sxqV9rg11ElH+seRJvScOqhWLD6VvBSrBHg1tSmSeIYDNjwNth
         qR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742571036; x=1743175836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWzJtKLPj/ANLzXXkhlY2o1HgIUBXjjvPZ3J9Gel80A=;
        b=ey50bR6WuDQMlb8yznZmXozf4k2zdM5C0jwGhPm6JXmADg0NLRrAHwTKPIdxjHa9KS
         7Nk7rY/KC1K7V7rIghXXnBuawzyWHF9V+a2oCMZKnE42X05nFK/m+RRejEHP3ltW+CDu
         3MS7P5hVcarFlVXa8DkvFOSI+zqoXYVJtnaPdwzdXjQvE6LAJoMEIY3Zx3oaipQo3NZS
         KsmAilSAlN/C/l5YvTUORY9xkiyoFvG6cGnX6qJxqHm1LO1+qIJJAOTRMoIyDIb14Jlj
         gzbIAU+yAHglfUQisw2YewEyCFCjRq6WsWOjFMuSzZKAhqpKEwTEJCJCB6E3I2i8b+vM
         L/jw==
X-Forwarded-Encrypted: i=1; AJvYcCXLv8ysXMF7VQjiXsuTnmF0lsoO5k1mWBUMo+h4etceGAnFCjZQfSakrnErdjba59TpBK9H4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwToQn8YDmd61tRrSO2prQl3QLLhS+H7XIfYUPRtxhqLzvzv6YP
	Q1L4dWdzUWu1szyRXYkQHXv+L+6abNPD+DmWGmhaBD2hbrZGMZG8CIN280GL4iA=
X-Gm-Gg: ASbGncs7gIj1y4GzlZSR/jZLLAu/GAwcjweHn288Xi/wOBQZW/54Fg9VvX+Ew8e+IRp
	Ej/HlsSgerJEjr9ay5IiT9kV8tEo30bBmEJELtpyv3QAVTfJab4QzMC5D2uMIbvlpbTzhg581uV
	jWYRIxmHOWxZT1fhxxehOhhBiKtVAac7HcnKlnl/VHqbeV+DAWoLz7+yqQtMz+0K91frFnJPpe5
	gFcPEajYfzT4Sn2T10qdMRZewEJHhe2KGoEHtelB4Xfj3cA8yKjxeWzuXoFrCMzo5mjJ5dqXX9j
	6VAjmoZoIIYR9CIJw/4NyAFcoaVcty75zyGzjLm5slAOLGGC1iVIOkCCS7k3tN6wPvfIIkUuBcc
	tp+f2EMqNb1MQ8GSKbNntdWU=
X-Google-Smtp-Source: AGHT+IFpYeF6e8IWTYH4qBsYGtMJtMi6STFTZtoB3xqX7509YmeW0J7+o65gIWuC7PrSA+ibKh6pVg==
X-Received: by 2002:a05:620a:2415:b0:7c5:4711:dc51 with SMTP id af79cd13be357-7c5ba12db1dmr416835185a.2.1742571036356;
        Fri, 21 Mar 2025 08:30:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ec55esm142292885a.55.2025.03.21.08.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:30:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tveKR-000000014u5-005h;
	Fri, 21 Mar 2025 12:30:35 -0300
Date: Fri, 21 Mar 2025 12:30:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Mostafa Saleh <smostafa@google.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 0/5] iommu/arm-smmu-v3: Implement Runtime/System
 Sleep ops
Message-ID: <20250321153034.GN126678@ziepe.ca>
References: <20250319004254.2547950-1-praan@google.com>
 <5b29ea3b-ba8a-4f7a-b241-4ed5b1985a1f@arm.com>
 <20250319194609.GA126678@ziepe.ca>
 <Z9yWnBmOfeG-7rno@google.com>
 <20250320230551.GL126678@ziepe.ca>
 <Z917OSsvHBIZfar8@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z917OSsvHBIZfar8@google.com>

On Fri, Mar 21, 2025 at 02:44:09PM +0000, Pranjal Shrivastava wrote:

> However, still there's a worry about the reset value of GBPA.Abort as
> pointed out by Robin earlier. Since the reset value of GBPA.Abort is 
> implementation defined.. there's a chance that after a power cycle the
> SMMU wakes up with GBPA configured to bypass.. in such a case, I don't
> think the kernel should be responsible to ensure security..

The kernel should be responsible to operate that HW in a secure
way. If the spec doesn't guarentee security then you will need a
ACPI/DT flag to indicate if specific implementations are secure or
not (ie if the implementation preserves GBPA.Abort).

Otherwise we'd have to architect around the insecurity somehow and
prevent the SMMU from unpowering if there is any security sensitive
attachment..

Jason
