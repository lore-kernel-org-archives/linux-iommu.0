Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8FC1FF1A1
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121263; cv=none; b=G35kU8uaoxjVaqn2aaJfAP90vEmKWE9cb/SI0Vgbu05jN/kceJRcV6iBMdcVQAilZTm/5LrfTh/MBAY5WZNE/+SheVA/3arN8fDzLgeG5J371siXZSQjl6BgH/+wLzzW7MpjOLG3wcCgUsN0f17gkYMvpALXYT06zBdpQVW1c3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121263; c=relaxed/simple;
	bh=Hk7PlUV7DRaB6Y8+MXwxOd574HrHX06n8TKlKCQ5qK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVtdOMuZr+5lRjZuhZjHZshTwc5fJA0lvqn8eZQldoZI3Vzp7Ek4TO0HK7dp8rxDahgRHwEhAMu7VqCFkuwf6mOVDZSG0c2NKuB+TflNt9Wx9wDLYIKWFoh6vDxjBG/gj2egjhS42qNtamqQDrt+uP/4iJ9FrKVk5Z2yK5tQ724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8y5eQea; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8y5eQea"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45f28aba94cso90155e9.0
        for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758121260; x=1758726060; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PQv8x46eYXApZo970LUOsV6mmTMwe7go+DO7Uot/fuU=;
        b=o8y5eQeal/6ILmm9iqZ7UpYaKkSMJkauo30YekA4/sXnvUx02kzLYc4dugnKm5N0AS
         voS4Is1rhv+QML5busc3C4zGBJVF0gstgSOMm6S2zr36fp+lhSLlQkNPxEwfgFe181Pg
         kzehc2+8/tLuUD36hBXshS1ogL1FQFdGIapVTD97Vy12c+4pKQNeiRVFx6zlzkspusLD
         47Gqf5wBIwq0Cqs190zdz+M7hmUAs3v465T3dfpOOaEn5Frm/3k1hXSWa5d/TVo3y25n
         g9T8AZ2YlOtIRrq/4d/rTp+cqKk3ub5EXZY5aN9YqUP37++DVRZxIWbzM9bSkOKMVkoe
         Bl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121260; x=1758726060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQv8x46eYXApZo970LUOsV6mmTMwe7go+DO7Uot/fuU=;
        b=RxXT5xXU+2Vk6x+CvvzTgVhrnk4yf24uS9zZGvxY+Jw5qNb93q5Iky+ZbmYsF3MsLn
         5zgo7KMxhg0/g9x9WOuj7UpUJvvZDCEzfg8SBaMEUXTUWWVNhlsDY5Yl+tgxfgHxjYsA
         PuFY3BHQS3kNPDdX6KupkynpmqEQTLDM9G5JxRm8A3jgGf4v+mruWocsWoSC/ny3LIDy
         UJN1BDsb0ifkmdkn6wDq9vLt4+v8t1C7Bhp1Bh6cDQ8Ghpl68sq+Mx5q8GKTcG0/FRTk
         gL+D0oRjpeBSb5qTv1kResu9kjLHKuNnO8c239gkpqoVEyyNxcs6xHnkuD/HOuRixqnq
         3E+Q==
X-Gm-Message-State: AOJu0YxxCa/xXlHZIzALZtCGYgewBfQSJM3lHP2370AkCK6kK6NPb+Wi
	Ev3qBUzVwf0gee3kJc4bLZaqCmQW39TsOogAXhkEIKXgIRlEt0c/XnIiB7EIThB3cQ==
X-Gm-Gg: ASbGncvcbWLIHcPHk0zbZdI2XquUXd9BnznxuzpE+4SRzUXBRcLfzoui65/c1cFFLVA
	9ibsfA+2sgF2zuQAUkWlYo+EJGtOWiz9BmA4ydjKT8/ujzCywXAi3o+Tmid4U4onED396d6C/q2
	mpMA5sDlxxd47kLjt4UPtGYODFfEV3JKfzI/47hrAy9SaG9dbF9b6voXVZU6+JavnqwzQvHvc3h
	ubQcWD+Gv5BhB/xAE7VHbZKQcAfRvc97vjLwXP6evM7OlgS2bDffweVtZJbGf311KfvGR/5V2XJ
	bSYVsDA8StapmhV9iBgkbGPYIdlFj3aiMiNQbznM4KQcwqHsJy1B1Er2uPJ8UdLfx/Y+KBAyx2b
	MYipCTVmaq4wmW3U2evMbIXr/2IwsD7NKb6XSHPs8ukG9amxaiMz+fX0Bv1pJeZTNc7E2cw==
X-Google-Smtp-Source: AGHT+IENFLjDgY/V9nMPy/hERD3SF2EFRD4h9LqOWJ4wBVjA8e0W/iIDo4QRwD9b9SDaGu4uXHig9g==
X-Received: by 2002:a05:600c:4850:b0:45c:b621:9199 with SMTP id 5b1f17b1804b1-461a1cdbcf5mr875645e9.7.1758121260129;
        Wed, 17 Sep 2025 08:01:00 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-462d525fdb2sm18471915e9.13.2025.09.17.08.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:00:59 -0700 (PDT)
Date: Wed, 17 Sep 2025 15:00:55 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH 0/2] Move io-pgtable-arm selftest to KUnit
Message-ID: <aMrNJw3obyu8IvBL@google.com>
References: <20250917140216.2199055-1-smostafa@google.com>
 <20250917144435.GE1326709@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917144435.GE1326709@ziepe.ca>

On Wed, Sep 17, 2025 at 11:44:35AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 17, 2025 at 02:02:01PM +0000, Mostafa Saleh wrote:
> > Instead, we can remove the __init constraint, and be able to run the tests
> > on-demand, and possibly compile it as a module.
> 
> I think you can just put the kunit in a module to avoid all this?

Yes, I don’t see the point of trying to run everything from __init,
relaxing that allows us to use more of the kunit infrastructure.
But, it’s more code to do so (it’s just longer to explain :)),
I can add a patch in between, modularizing the selftest before kunit.

> 
> alloc_io_pgtable_ops() is always exported, and I didn't notice any
> symbols crossing from io-pgtable-arm-selftests.c to io-pgtable-arm??

No there is not.

Thanks,
Mostafa

> 
> Jason
