Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F276216B3BD
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070533; cv=none; b=KfX90wfTajx5LFN/lFF7rOL/dUh1hu00c+djGINMPbwNpNwUwhrcG71WV1EqGi3NxaJ8/UXi+ATdLFeJRVRaJo2dJEr8RYqZN3u676Qq6xihXHFYNai63aX7clG3+Pf8BlrarQCLfqQTgN7QSgqSyHYnckX2xE1Hi46PaZHPckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070533; c=relaxed/simple;
	bh=RyUkRNXmhJ5lIQbz47jZgf3RzPgsgH/d3BFP+Wl/Pxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0zC609elQWL9GXqmaCooxhK3KplaEa4qkOwunhvgYmCDvYyGJaJ5a2TnUga3nhnWeT7KFApO8SWUK6HKEZz45ioT0mQVtKGH7mmglGjfnQHJLPJAb523p0UDk9+Cq2BTgPG9nzM9F3ZP7DLFfHmwGXXrk7r2dmaG1OcyqQULt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lmVweeaL; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lmVweeaL"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6bf953cb5d3so6939676d6.0
        for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 05:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724070530; x=1724675330; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lriq5+tRSRLkM8EzeVI/tjuBsyDcUwfembmPFZugMx4=;
        b=lmVweeaLagpxZImNSzSjxMnaH4XCMdRglbXxLastgRGT7/j6V7KmOOkclWS0ZCz/ac
         yvf3bVdv301npRFU3HD5bxuHG6hRYC9WWb2aFhLmi47ewU09MMhnqZf1a661xmIlIWcw
         RmEzHqfxBQp202aWbitqkonqWlZPHj9CApuhdOZlrDueb46EEyw5NC7upZhJG7fFgXh2
         Btyn0SShOh187k2v0a6ta2XEST7tw256FeskwsvbNrh0wzFdgC+5rZ6SoWCEeIY8lXUj
         sGFXZ5XflQvnRSDFOwM9wUTrMq6fMuP+UeurGxwB87xj6ZSTsH/sQW0hW9xVa97632a/
         Wzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724070530; x=1724675330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lriq5+tRSRLkM8EzeVI/tjuBsyDcUwfembmPFZugMx4=;
        b=bDLAxSpSGL7kW2wTVC3lgBHOl0u9oNpp+3ep4QurlWIHa14P74RAqAx876lvk9RoZP
         OUoU8nVZUH9Vq/Pw+GxtOzuY2U98DqH9yTIV6CLk4j5jcXeRS+dTqvH8U/L+KbtwjIe+
         dys+P/CeUenGAlWf7VYvVAMceFMZt+i/8aGfAX4xBwvNMAfIFB1P208Szcmf3/UGcjLs
         aE6pm9RaPNN33HtWcZhbsqyGXjSqiKsKykYKTEhFNwY9kxWbXQMyCfPMebSYtM4tts7d
         G4pKspxmIcgDwnZJPGjXzynwOPagQAi+CXSPlMqrCWWlQGDou/PTYJRKXH1/UtgVX4+L
         8YdA==
X-Forwarded-Encrypted: i=1; AJvYcCVoWcK1zaF4Qk0piBeppHtfsQtCf1DJkOQ/eFd4nTx/Go7bX9xHHYyIKeXPzz1eWNPne5xKgsuvkeSwPnYC8UCPczmT1ZY=
X-Gm-Message-State: AOJu0YwvjLhN/fon9p42iwBlmmqXNawpZamBIpIsKHI10Mfq+DOKXNCL
	CQYU3SmB8K7oW01dyVlvOvc134gzkTYUK6qweiCAFilBscNrFWwjxxC7oJVnbCk=
X-Google-Smtp-Source: AGHT+IHNw+vGr/7csQmWCkE0wiwg/E+XpDzDEzhlnrIiVMvjWiTJ+dakALBuGKPHH1MPfHM79/ZEFQ==
X-Received: by 2002:a05:6214:4520:b0:6b7:ae86:e33e with SMTP id 6a1803df08f44-6bf7ce59f5cmr92736316d6.37.1724070529543;
        Mon, 19 Aug 2024 05:28:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fec5e9csm42159046d6.80.2024.08.19.05.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:28:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sg1VA-00CHYK-Az;
	Mon, 19 Aug 2024 09:28:48 -0300
Date: Mon, 19 Aug 2024 09:28:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 3/8] iommufd/selftest: Make dirty_ops static
Message-ID: <20240819122848.GS3468552@ziepe.ca>
References: <20240819120007.3884868-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819120007.3884868-1-ruanjinjie@huawei.com>

On Mon, Aug 19, 2024 at 08:00:07PM +0800, Jinjie Ruan wrote:
> The sparse tool complains as follows:
> 
> drivers/iommu/iommufd/selftest.c:277:30: warning:
> 	symbol 'dirty_ops' was not declared. Should it be static?
> 
> This symbol is not used outside of selftest.c, so marks it static.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/iommu/iommufd/selftest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I picked this up for iommufd

Thanks,
Jason
