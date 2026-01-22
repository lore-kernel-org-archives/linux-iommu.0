Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F287A36AB54
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769070150; cv=none; b=JwUZhnK3UVNb0qjrPllMwrNsFH0ip41Xu/7oNb/EM3FjrT8lrz6p6RHfuLq8wazmZW+N74G8upgHWt9vTVTCJbW4lU77SNLq8IgGHZY6FOVE986B50qyXYPpB8tUdvjrYbsF+n7MxK+yGEBJDqMInYxroFaIIda/qTHTlrJyAcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769070150; c=relaxed/simple;
	bh=XybfUO7yVGOvC4FG53feah88rsR0zGhrBBfOPUrRHAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BAwLnLm3d29lyUueERZ3PkXXyXXsQQN/EnEcz76dH3JhAxvlEq7KgmEomVHAuhh3Kl/uTd9/jYiS5sPPfsEPsDa/PqQmofdBMJZK9LCO7JNCm+nRUp02n4y9/W9m9oPtEyKEA06rcfnwrM1t2XYO1HrpLybMkmLROmEhnVcw+OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2WAV1wbp; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2WAV1wbp"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4803a72daaeso5498705e9.0
        for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 00:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769070147; x=1769674947; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TXFQssapFyW7Sp+ikLaCf1ZvrfgQKhOMJ9hRqHbbDRg=;
        b=2WAV1wbpFeIGIaSkQYzBHf1DiPz5X/U2r/RyC+y9YPUS/D051Kb+UrWMG3Ws2b7lfY
         m2O3/zG/zePTfzEytVDzwOvTXhC9uIaJVOTmTU07gGVsUo3SQT6+5Fs5jEO80fSY3SyN
         FVDzq38IxzqAA0E1fIkvdkyeNllH5KCE55HmYDiGUdd3D1HdBb5NLh3v+6H7PSIZZMaw
         ezT0v6gIcrr3qEk+WKO6Ado4BWA8R950pRUbfjWE7JadMpj11nqlXpnpinlIYttx9IpU
         Lcqr1y9AzNqQ5pu5l/GE8k5K5yc9CWSKTMf2kBxvnhQOrqjr7U4EU5wCiD+zQoJ8F1Bo
         z3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769070147; x=1769674947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TXFQssapFyW7Sp+ikLaCf1ZvrfgQKhOMJ9hRqHbbDRg=;
        b=gFITXDsB8Rt9wZMFJEKiu+EFw+JwRDKPSqomEQF7+6G/r/mhfS1olcj6eZXDajPyt3
         BvIn4oOevAOZD++oDZ7IS236Ruf9EVt+UvpzknQJkK2EgK9mfYLWfC3wPvVxmZ6MGA64
         7nNo/XaQjAXiVO1SxatHgMBhcV9Lnk75GcKzbUwg6bdqeA2aIkGfyf7xjJq2brImCxtw
         6JUEea+zpYrzggLpePGlGL7m9BWU07gCcw8HmeVMUwZv1cN92x4YLgkvsBm2I+osMQ/f
         JHbFjePXwLkoGFAI50o5hCy0CHUg1H1FbodmW+kkBkZqts4JfOTotp/Q9rp2vfAs5gXp
         VgwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdSFWQ+WGtTBwrITkLh/5OU0cwGOpr6YQ7Wh251OsEgrNUfj7AxTOYnH+tkIl5VcLstSjEVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwScsw/4W1duD/bXKQWk53gnYu04b0J6TDuMUGOWVnFK8d5wVTS
	Gu4XYXp3wh3Me/SbUkUyg8rvKUDmmtAMxMOqmfp5RgyABG/g/OYUREkFAF3RtSv5h93ae/P/0dp
	ecb4Dy8ryjf/pLu61kA==
X-Received: from wmcq14.prod.google.com ([2002:a05:600c:c10e:b0:480:4a03:7b73])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a6aa:b0:47e:e7de:7c41 with SMTP id 5b1f17b1804b1-480470c74demr22446035e9.16.1769070147395;
 Thu, 22 Jan 2026 00:22:27 -0800 (PST)
Date: Thu, 22 Jan 2026 08:22:26 +0000
In-Reply-To: <20260121184339.74256-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260121184339.74256-1-ojeda@kernel.org>
Message-ID: <aXHeQi4xKRJGSHv6@google.com>
Subject: Re: [PATCH 1/2] rust: iommu: fix Rust formatting
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Wed, Jan 21, 2026 at 07:43:38PM +0100, Miguel Ojeda wrote:
> The Rust kernel code should be kept `rustfmt`-clean [1].
> 
> Thus run the `rustfmt` target to fix the formatting issue.
> 
> Link: https://rust-for-linux.com/contributing#submit-checklist-addendum [1]
> Fixes: 2e2f6b0ef855 ("rust: iommu: add io_pgtable abstraction")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Thanks Miguel. For both patches:
Acked-by: Alice Ryhl <aliceryhl@google.com>

Alice
