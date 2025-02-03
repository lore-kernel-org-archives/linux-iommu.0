Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F274B1E9905
	for <iommu@lists.linux.dev>; Mon,  3 Feb 2025 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738571826; cv=none; b=OS7U1vJb+0GeI5aGYxwT33PSAxVFQCIKEge8G2iuwRmVPw9KuQ42WY1SQ4I4IR17FWQ8fg20DqeMqK3HMUWYgFhapKfsh8cGjA0lO5FQkFg9eXA02M1WXSK7xbsATlb/LuxSOUU5zY69TmEdiTm+mgAAOdhiusLcVRQr0142jms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738571826; c=relaxed/simple;
	bh=gWOFAt2rybSaMtiQKrZAONssTjaaeIu2CUJS662ZrX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBFG20qMydPolNkN7Lnhu5VmsEapcjhQp7jxjHZdwob7O9G4NKZ/o4cZsicNx7fqAeeKObFsImfCTtlgvr8BSAuRODeKw2WSNiqEK837MC/MUoCUPtFeq7zov/nR1e6QGJJvnKzTJNYmFMXgTj+1eRtc5WNhBJRsorSBIyQMe9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmoIp3kL; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmoIp3kL"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-540218726d5so3879580e87.2
        for <iommu@lists.linux.dev>; Mon, 03 Feb 2025 00:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738571823; x=1739176623; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j30JImXL8j/mQY7XDaNDiKvNWf91T15iq6ow2JICGdU=;
        b=CmoIp3kLfCUbmbGXvq/dBMv2QRWns8IKnJv44MuuliDE4vMb9S2N+NONWti+FNg7Cq
         vwWRazniXZM78vplfgxvsn5AWGbGNS7Zy/QKTxol4z9RwljTS9KTT9SC7clDImLbgOEe
         WGHmFnJ3dfgVgaByJNZd+SlxYBikx+JWO1LItjTmC9Shpda6xMvsUmTb5ksFaiDA+VNJ
         7iiN1IwqJX503+wXPB1MB605XR9hKxLlSAoDDxpao+C5+NoF3kPZ61yOKhYtr8zPVhUz
         f3gtM8pj7X/ABvOnQ1QNZ5wViuAd8DVfXCV3FlIc4eVQh+GilBTFiH2wBMokHb+Leut5
         UU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738571823; x=1739176623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j30JImXL8j/mQY7XDaNDiKvNWf91T15iq6ow2JICGdU=;
        b=uhdwqGPR6zwCqaWyEF+6qMfAp6zGxNJyF6+bnt96KTyboe8ZFWtMMW1ikECmjSwq0c
         xHUw3AjQbkKu6WNqdfZkPQ9CoXXYhqBMgrl69DR+9TWe4OoaaMJFCTmBySLy28jDVIQP
         uoV3kjzYErGZ0ZoGp/yQLDBkP2th+21Zh5VZjYimKZV6pS+wcWC2BbzGqiB7TCdnSsld
         RQTsmZPSMv7/HA+HmsGFn1av+0iOesolPAt07fG701E8bua3oxPhRzUFbOD2Hq3GKOS9
         WoW7EEal2PNxPHONk2BQey7mX4FEDjpVX0mMRmkWGPp6DpY62+LtbQBPJwZ5ol/CAgey
         hT+g==
X-Forwarded-Encrypted: i=1; AJvYcCUGg5rP2I2E1cXFG5FWB8l3PBbgAO4X5A+48qH6+Svt6wlptjK2LE4G4CJwhK+bXm/gJFvj+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YygUw0cR0ZPQI0Oj0r5jArsXSsKHAByBQsJjTjUcxYF1xv6+qQ5
	tLUQsfemMboeKPfems5x0hN4KJHqpQH8LFa063myQURZgwldkwEb
X-Gm-Gg: ASbGncsrxs3si1pLmEv1kRxxBIZf6PcG7C76Fcc0rXEwJKvvy8PSOaQNiBQRfgjM48l
	qypZioUcaNUieEgMIebfoaSvSsIEAdHemxBIDoGy7R+UsNGlCALOa0Q1OnBOm8pmz/jHs9u5T0v
	NGOlgKc0e3IsXfOC4Gaq0hQ0HgZeewRfMr3Bt7/9ICfwQQrrRxfKp7qJ9wRFqFN5ZA45ElhSBoG
	l7nXieSgeKPI9RsewKIiO2uTCzPqYUBFOGkW6huVXPceu4DmEuSSH4nswujNqEQsEhESBhqB1Cy
	62yR5tEua9n5mXx6ZsYJXjmGQJQncxSP88/bpPq3PZ6F94rIHA06dj6CbyA9FQ==
X-Google-Smtp-Source: AGHT+IF2J0IfkNwwMwXACa9nZcYDX3ga+w/KRzEdi7zlalBoWSm0GuqBJLQ+dPRSCXr9qDRpU/nP3A==
X-Received: by 2002:ac2:430a:0:b0:540:1b2d:8ef3 with SMTP id 2adb3069b0e04-543e4c3ca2cmr5198254e87.52.1738571822740;
        Mon, 03 Feb 2025 00:37:02 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543ebebe6a3sm1197056e87.219.2025.02.03.00.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 00:37:02 -0800 (PST)
Message-ID: <b8ea4215-f4f9-44ba-8976-7d60afd7c8d7@gmail.com>
Date: Mon, 3 Feb 2025 10:37:00 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/3] MAINTAINERS: add entry for Rust dma mapping
 helpers device driver API
To: Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
 daniel.almeida@collabora.com, dakr@kernel.org, aliceryhl@google.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-4-abdiel.janulgue@gmail.com>
 <4956d01e-2d06-4edd-813b-9da94b482069@arm.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <4956d01e-2d06-4edd-813b-9da94b482069@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/01/2025 13:49, Robin Murphy wrote:
> On 2025-01-23 10:42 am, Abdiel Janulgue wrote:
>> Add an entry for the Rust dma mapping helpers abstractions.
> 
> Can't really speak for the Rust side of things, but I could be an 
> additional reviewer to keep an eye on the DMA API angle if that would help.
> 

Yes, would really appreciate your help! Thanks!
Abdiel
