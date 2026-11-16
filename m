Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858273;
	b=Hlcnnz2R/njAg7t+na3dLpeDYzhncl7gvZdH28OuO8BCNmQvsTypugo/UG1zGk6z5xHT
	 YJID7iBKYrbeUKeY9ObKvEC+Dgr7S1Bsq1X7i6i9hzeHak41feTC8lpaz7cG6yuO1M4ke
	 opyNRCJRnkpyUy01315dpNxOfBOJI6wFQPBqc5Z7K6qrG/QCgPnYujK3og4FoITmK3kUU
	 3qHel/wZ4RQs0LBEtAt3+O4kTt9R7fP2msFniVvSZM2Kn5f02eIYrews4o7vL4R6mRKUi
	 j01eGsuE6LyUCWWTQsFuDoP9K84+JHdqN8QbkRYv9vCDYYG4bdLcaHax02rOnLg5ZSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5a8RTlOneQoQgmIZF/2HgV2WGmUNnodxSu/n0rvD61I=;
	b=TA6ak0ZQTnhJRqbMohjDp1QMXu7/E/en1fMjg0PNyg3XTNYrjX0u5AlmEVtQ/KCxroTr
	 tYa4RHsHfPlxHxDje4Re0RyJbwEGg5myeuAOJXaxf7CWotJg2juTJBn/wlW/5hxVHqBJl
	 MR+M6lFJSL8ciiV2v2YSHySkUdXOtjVQSEPPDijtdI3br4/LPFS6sRLKtBpil7LWbloL4
	 CaKlvnJG6vp/UOyxPgArp7ebhPeizoS8cUaMdwFP+zw34b9W03LjlflR4BnVUEJUG3n6Q
	 xcyfstnbMjGdlgrzcjf+hbIwM/B/6AYYBzlUkopvmpA46E0972tcEScTrzOMFvEEQNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=UPqIykjY;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062C8606A32C
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 19:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 062C8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=UPqIykjY
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f2049ea7aso296471685a.2
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 11:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794858272; x=1795463072; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5a8RTlOneQoQgmIZF/2HgV2WGmUNnodxSu/n0rvD61I=;
        b=UPqIykjY3aho3GVF3YnAC6opLULMeEJgupOluDhBwL0djtANLMNf49k356SQNSofVG
         cMYcoWwitk/09uE30Auj3S554NKkq44vvFES9k3KELnBMi6zU/EHulFVpwWP4ye3iCDb
         L6cbYpw9xn4MQ2Z+Hf1N8hTe9+tMk+YF0ZjK7ozaVqhskTUqCTZdih5Z0G/FKgb9lQJI
         UfWyn8V0zD0vjCzgeNXGf0V7rdihk4Ul0xwqwQYg6kdGL7Y2DOy+GpjUMurlOP4RWQp0
         rX59oMv2eRa5NtSeRSVHvAe4GKi88mTQl7s+POpA2vtIHYky/Q6rzqDbJMpUosTWdLOz
         353A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858272; x=1795463072;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5a8RTlOneQoQgmIZF/2HgV2WGmUNnodxSu/n0rvD61I=;
        b=NaSRwkr7tqkWCmPFLqbEiqw4yoaTde3r15jwAT3ANMqvjOz0rCGuW7ryd1fh8uETxM
         QgkuxTjANrSddRI/rGep+njDipkxfPJFMpjctXKBLgtYFH9Rgvj3lla/TTKd1laJyF0W
         TkR/2QiDvE//KrMNVqaPKMZwa0aFu4V6L+Bet6KFWW3Oq9GEgIfXTY0sbWRqD1EOTgch
         1oZDpNCkFz5URCcoR9mNcpSG9YGmligyxHdhHzREie6+irB81UcuY6d4IDjESU8F1oyb
         xBHn6OnmZ7MRTU5BZNf0t6advDzewt0DOtjdHB99OmFiMPvqf/U7he1gS0vxiYl9Ov65
         oqdw==
X-Forwarded-Encrypted: i=1; AL+hErED3QrhgDE4zhC5pxU38WyYS8TFbMdfdB6YfEzySUazPA5sO4pzsEcmMXdVZ+SSGewuPtPU1Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z8fmvrbWXbgiLgSA4NuBUPOKQtf6peo5NxeIyg2c9t078mX547U
	khtv0ZQh/Q2Teu13a5aeI/JfNv+4XhfQD2nwV86h/KMYIIE14u/aUkca5LgDr//rCVY=
X-Gm-Gg: AYBFou0ktluA6xurnOSHmAdPyIkEeSn4bVUlBzz6b98vo3A8BkOlAX/5I/n6yYU7y0t
	8c6AqWF004WiN8B56Nk0txMAEdOm7MNC7j273n0T9FgjfeJ1XS3Cc+AK6hLCAH6VAgG9ySyMd9c
	eXr0jVfJmT4BBcD2rhBDqteQgcJdlDgHmmK9l0B3NYR+1/WeJ2Bifc6BR35uhvQNk5TuIK9NtOB
	iyEij3vgggzXY8fu6uKN+8qLbiKgAQWvOkl7tM2SQjejkNFlQh0ExQQF8UMW4H1QsxaGhH0MAlC
	Xc9g6P/2yaN1B/urd9Vz6ZYL7He+Tr4m7PeTo6RFzAGsa96BvgNp6XW6fk44oQXqAyhik7LLW/S
	UImuZ6nZGxT7FyPFYxPpZ6U6c/mqTTDwGC5UXCc39tYI+wvZkRmJcF06P5raU3YdbZOwOBQ3vtK
	LlXbZT5HPBYyX8+Wg1p1V4P78fd0lTbEgDf9uyJcxG3+E4Ui0y6O0OUXbUgTA1dyTUygF6EhOaS
	UALIdog7bb6R8b5EwmXjvHB1TBe3dZpqzb4TVNFibzEcz+4wY14wd8LQpb/5bYQxWoe5PkcD+cY
	8KF51w==
X-Received: by 2002:a05:620a:d8d:b0:93f:1d5:9973 with SMTP id af79cd13be357-9494bcea5c5mr1799354985a.73.1794858271993;
        Mon, 16 Nov 2026 11:44:31 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c8e1c94sm917649385a.39.2026.11.16.11.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:44:31 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT2cw-0000000AKjk-3CZC;
	Mon, 16 Nov 2026 15:44:30 -0400
Date: Mon, 16 Nov 2026 15:44:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/2] lockdown: Prevent booting with lockdown enabled but
 IOMMU disabled
Message-ID: <20261116194430.GD2452510@ziepe.ca>
References: <20261102-lockdown-iommu-v1-0-00f3c2be4c9f@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-lockdown-iommu-v1-0-00f3c2be4c9f@kernel.org>

On Mon, Nov 02, 2026 at 08:00:24AM -0600, Mario Limonciello (AMD) wrote:
> Lockdown is a kernel LSM that restricts access to sensitive kernel
> resources (e.g. /dev/mem, kernel modules, perf, tracing, kprobes,
> BPF access to kernel memory). However, without IOMMU, any PCI/PCIe
> device can perform DMA to arbitrary physical memory, effectively
> bypassing all lockdown protections.

I don't see how this is enough?

You can have an iommu but the commandline can put the whole thing in
DMA passthrough, which is the same functionality as not having an
iommu.

It is not like "any" PCI device can do this DMA. Lockdown
systematically prevents any userspace from triggering such an
uncontrolled DMA.

This is more about preventing someone with physical control of the HW
from access all of memory, which IMHO, is not part of the threat model
lockdown should have.

If external attacks through PCIe are part of your threat model then
lockdown is the wrong direction. Leon's driver trust series is how we
are trying to solve this issue comprehensively in a useful way.

Jason
