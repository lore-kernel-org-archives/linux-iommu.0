Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDDB31328F
	for <iommu@lists.linux.dev>; Tue,  9 Dec 2025 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765314333; cv=none; b=i49nFIfQ2grIeqIBhfHxkfKVI3S+heklHHF9+ZPxoVzQIsxA9IaZ4PcUR/zCYkngjUf7PyWdFtjelcBBfYJVqmwJS3ntg8+jwEdNtm0DlfCBDfzJFZ8JVVixbRXrOO1aTsikoTY5aA9GVy7QWGY3kJ2eaUtZetHOj8K1qGznk7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765314333; c=relaxed/simple;
	bh=ydHiuDxIrW5FazFjw0AZzylfnfdPPZlpeSRd2sqLG7o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lZTGht6QfzhySUPesmeI9mvpw6AhcFNvWsQVKIt6yrmbH81onAdIYxD+ltBra6ZEBojp53CE5y3uON9KIExgDQ7NFb0TqrfsO4tCjkCEDxsv5PJOQbvmXiffHAt6ju+3HIIs/yOequ8Rw6TihQ43tdhe/8qFK86OMP3Kv1TZhdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hPWoNszm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hPWoNszm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765314330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5JtO+/e6kTnIf7NZZ+Q5LHQ9Py7x/v7ASju/lUvZ3DY=;
	b=hPWoNszmH2Rp6jS81jfBq9chRheafqXWuW0SrUcYmnqR8LyCBo3GEjlJLbVubtA3f61r6Z
	GwBwNflrjLRrfHmNtWeRzjr8Zoh4tXtJhfBJD/uKhp6M2FphHc6psQ1NjzVqrbdCl032ca
	7l1HW0Zmdj8cKI9+FzMi/G2lKY3iI+Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-yRueWsQzM-iYmYYYYQPKIw-1; Tue, 09 Dec 2025 16:05:29 -0500
X-MC-Unique: yRueWsQzM-iYmYYYYQPKIw-1
X-Mimecast-MFC-AGG-ID: yRueWsQzM-iYmYYYYQPKIw_1765314328
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4776079ada3so57697275e9.1
        for <iommu@lists.linux.dev>; Tue, 09 Dec 2025 13:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765314328; x=1765919128;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JtO+/e6kTnIf7NZZ+Q5LHQ9Py7x/v7ASju/lUvZ3DY=;
        b=dao67Vs16rqYeqPNAUvKWo3WyQDgSazOhW8iatb3PWiQTDtlWauwbJEUgooDiv/wce
         bnNq3Z/di+gLVzlHJpGSR+6U8lof2Dm07v6Hpn3PIQKGgauWnwOyHU5eUytAFSHeq6kI
         oGIxfToIj3VXTYkqXZFD1T0w9xYfywriApqe+nSlHgGatFxYodkgFidokPK9DmAwGJ6O
         b6HfLqKKG6Gk+/Xn+oT4S5SNf84+Fr9EEOwHY+3Nl3bGeMZhmp8eKBWUacAy2GGFKnLl
         8/SeLzAUjZPadzqD9Rntk68CrpO9kpXfTYa6aYQthJ1BiDMwm7ZhUPvKrOTBs8KOyKbY
         NLEA==
X-Forwarded-Encrypted: i=1; AJvYcCUC6yqYOoUO/5vhhuK+9BKxLGYWjZOK03sQbgPS8JRaLEr7t0itmaSqabwyfWGr2oaT+W+BGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBQ98T1IhLqKPNBoDswrbKvn9pZcLXSnciLe4DFIezakxNjCOZ
	dYX10MFGACb3aA6AnBOkWSBTQrmJkW5bPrHST4MPqGrkbAjAhmS0GSyAaE6eDEEbBLcWR6Si8Bp
	NKaiq9BQSUDVkNDmShkr8YWPyeBdphbGFAdh8sYUMBMA/ruhdk6UCBOUq
X-Gm-Gg: ASbGncuRPy4yI658mYTcsSzul7ZQNii7jR59AAYRgPRfP1Ltanqp7aTOw/d23FBPxna
	A7pTYvoLXX0GhS7NlP8Pq1vgIMJm9Ex88Box4P3Y3g8mXnVfmTeWcm9W2M0AVaYsS0pqnMstQMC
	XQct2SK+CpduOoAtcq+UOwIXgNtHpe4x5NNQmrboy6kcQ+bcpe8ySLNwi+oWPCEBrUpg4hZHTXd
	Xg+oqdJmMj3XbkR2FqADToHUq69iMp0fFssOSlC9nzdUPtuzlEiefWWHGZWdv9dfbIDVtIprdmd
	+xZ6LKSnvJgVMMLLK4rNwvFkMptjSRAtbx2myJ65G+JkDLpntA/p9hXRLiCCLh3h2upkUwU//0j
	wt6L4lqPt9W1bmBw6vtbI0hfl3lFNc3jVKwKY8x6ISONPx/22xu3bKC3vm9E=
X-Received: by 2002:a05:600c:34d1:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-47a83744a33mr2306485e9.2.1765314327658;
        Tue, 09 Dec 2025 13:05:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtCAFhErGwzqpGWe7IpcJT0+41Hr+cUdeizf5PIDHvpAkbhAflBzeSLnGEysOKGluXPZLr/A==
X-Received: by 2002:a05:600c:34d1:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-47a83744a33mr2306225e9.2.1765314327245;
        Tue, 09 Dec 2025 13:05:27 -0800 (PST)
Received: from rh (p200300f6af498100e5be2e2bdb5254b6.dip0.t-ipconnect.de. [2003:f6:af49:8100:e5be:2e2b:db52:54b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a82cb12fbsm10202915e9.0.2025.12.09.13.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 13:05:26 -0800 (PST)
Date: Tue, 9 Dec 2025 22:05:25 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: linux-nvme@lists.infradead.org, iommu@lists.linux.dev, 
    linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-xfs@vger.kernel.org, Jens Axboe <axboe@fb.com>, 
    Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>, 
    Carlos Maiolino <cem@kernel.org>
Subject: Re: WARNING: drivers/iommu/io-pgtable-arm.c:639
In-Reply-To: <4386e0f7-9e45-41d2-8236-7133d6d00610@arm.com>
Message-ID: <99e12a04-d23f-f9e7-b02e-770e0012a794@redhat.com>
References: <170120f7-dd2c-4d2a-d6fc-ac4c82afefd7@redhat.com> <4386e0f7-9e45-41d2-8236-7133d6d00610@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: goSYvx29rqXyabQu_P4SpMglCu_lagsOEF9W4VqC4rA_1765314328
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 9 Dec 2025, Robin Murphy wrote:
> On 2025-12-09 11:43 am, Sebastian Ott wrote:
>>  Hi,
>>
>>  got the following warning after a kernel update on Thurstday, leading to a
>>  panic and fs corruption. I didn't capture the first warning but I'm pretty
>>  sure it was the same. It's reproducible but I didn't bisect since it
>>  borked my fs. The only hint I can give is that v6.18 worked. Is this a
>>  known issue? Anything I should try?
>
> nvme_unmap_data() is attempting to unmap an IOVA that was never mapped, or 
> has already been unmapped by someone else. That's a usage bug.

OK, that's what I suspected - thanks for the confirmation!

I did another repro and tried:

good: 44fc84337b6e Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
bad:  cc25df3e2e22 Merge tag 'for-6.19/block-20251201' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux

I'll start bisecting between these 2 - hoping it doesn't fork up my root
fs again...

Thanks,
Sebastian

