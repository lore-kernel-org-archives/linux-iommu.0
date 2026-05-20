Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5211369999
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298171; cv=none; b=PrRr/KgjKxmeD1oYG9klKtK8JHy2McnqknT7ZsXm46GJ43tkQst9vXTFwNPtJO6CitOwOaxXzVxFYGpKc1sNyA9BuzL8MjjVMchhiHVKxIl+rgQI7C6TeVTLxrHKd+I2BNanoa/+9/V3VvhMTypEevHbxJkm19lQevAcrYRDnNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298171; c=relaxed/simple;
	bh=swndveOwFBrQHenLNsbHaeYRdxFM/mHCS9gLfA23gKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmYprQaERplGrqXU+o51RNlPYQTtmLD5BkqPygrpPBz2BAiMV5siX1pQbwvYMfFxVSa5SALZPPyrJ2ay52UEoOYeHD3PL5NzQmX98KFI7ruxw6iEG+Onigdi+75ptcwsmD8pd5j9F7X4HQPMiw4Ac6shcSj+dRWIDjV4SkXlfWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NJup+TFh; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NJup+TFh"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-91080895355so609384185a.3
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779298169; x=1779902969; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=exjD62wJL9xWPCxLYQZyKnslKmMxfygqA8U7tuRD18o=;
        b=NJup+TFhg/6mpgHEp4FhzsK8yuyhMe/r/2cx5vFmpC7n7mOigx+qcokGoQLzJUgu7o
         GArkMGt2SYlHw4fkvNR9kDNTHDpNLmAvl62KBxU7m3HJm82ATtB8Q38Kc0L4lsZeKaqN
         1OzmkG77v4dxhyfcI3Qf5cjetT7BTbhPkWkt5wevMiucUjQc67HIngK8mENY9sIaJkSO
         9gXTIQF6IwKgS79zf2NLFIekE00bnox2cmTiqH4e9rIBq0MOm2lKIcJAE0PxWGAiQ5OX
         QNLiioyDD6SIsgCJ9Nt93DezORR+VRkz3nWm6fUIJ87DmfartMakGJc7ZbOXJaSVTz5C
         ffRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779298169; x=1779902969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exjD62wJL9xWPCxLYQZyKnslKmMxfygqA8U7tuRD18o=;
        b=BscAfMT8NM4MyRy678F+6QK17JDeonyTu7n4sSJX7GXDmsM5VFrn61ZGx+1uGp0Fh/
         ZivqzS3vIkSYwQFm9of8EQ4+kt8zwggofdueRXp18jdbUsSi4vK/1P7D/xiHTXFg95NO
         0U6XuoomcOJVYaq93tytME2VBzZWRttxPYQuEPPzMzvGaULm5b7LOrqjwdBb4Az8YCmQ
         Je0Gag0XMcUWzPr+JArLyFLqUDFxG9/unzTFhIKrjFmDnNRKYjvkcoforPStCtuicgc2
         fEUgVKdy4jdDnzo3WmP5ymeMUdthYwFia33P1K6ByXXnwwKt82G1ln5dvf0+qsV+lTvH
         hnyA==
X-Forwarded-Encrypted: i=1; AFNElJ/dvR3V7qBJW8zMhhr+xlZ7tvuD7ZIybh1LVmoLJ0/FhTtz6VhXvh2hIAGD8K1ueJEc9ASggw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXGh6g4d/vN3mNNq66SMDhRTIvFpzjEEecBaYGWGuhQPscmMaU
	hfT55AS/kgpOUjHiTOwitFYyzi/Tqr8XaKx+80FO0ukoiHOCULqhCI4L7UL0EuKniBY=
X-Gm-Gg: Acq92OGGeAuz/Pht8BsjYCfi8C3fXfbODNK46wBvh0zYMTEEG9EzwGNtznleH7uZvnY
	S7NLsX6gEJvfedoyJdUv6Eyc5I7ZY6fstet0HSeCsjqPxJTIe8E+nFL5qfnVXA8NCZ2bHWV0t3G
	U9zcVEsEJUHbx17sUYEc1ttRzvYtoGxntJudEuesyEc856d4Cjc/j85+SaOQ+p0YpudatK6ki6K
	Kp9hJtsu5SaYVxuIB2ZqjEvxRgC8inOUgUTKugtYDwsR6ai9ybLpSctoqZmV7XFAp0eT9Og4h82
	Lh5GuVKLmOKdq0RoWVk9iQs1TcK4eQqDxKiHM02SzVjmA4qow8/ynFSbogNkSw4dK8VaRoXYM7L
	Z6KvQpzjQfpkjisieixSDtuYK65bK7QYbge9Wh9KSNeiRbCo1Si/u1ZYA/8ng4E6lNIaoGLLtNB
	rOyZQa6G49GQxotmh+6i6piQD+n7HZMsDFS3fvV2Gnkhk5SmXG/vIJClJ7bOsKbEzNuN7++5nok
	RYPYw==
X-Received: by 2002:a05:620a:4112:b0:8cd:91f5:7a29 with SMTP id af79cd13be357-911d087bedfmr3730351885a.53.1779298168893;
        Wed, 20 May 2026 10:29:28 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf37762sm2298183085a.36.2026.05.20.10.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:29:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPkjX-0000000HXSw-2zB0;
	Wed, 20 May 2026 14:29:27 -0300
Date: Wed, 20 May 2026 14:29:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	decui@microsoft.com, longli@microsoft.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
	kwilczynski@kernel.org, lpieralisi@kernel.org, mani@kernel.org,
	robh@kernel.org, arnd@arndb.de, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Message-ID: <20260520172927.GY7702@ziepe.ca>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
 <20260515223545.GL7702@ziepe.ca>
 <lxmfd2ml5dafkxquuf5i45uqgh6wxl44hlqphu77kvximqrnmi@b3htoyjc6d5z>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lxmfd2ml5dafkxquuf5i45uqgh6wxl44hlqphu77kvximqrnmi@b3htoyjc6d5z>

On Thu, May 21, 2026 at 01:15:24AM +0800, Yu Zhang wrote:

> 2) Follow what Intel/AMD drivers do: find a single minimal
>    2^N-aligned block that covers the entire range, but may
>    over-flush.

If it is plugged straight into a HW invalidation I would do this..

Jason
