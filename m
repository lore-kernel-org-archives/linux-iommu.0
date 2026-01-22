Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA45364E80
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769069999; cv=none; b=s24U9e5aZeL2tLS/Ebe5SQZyti3O9+h3M7/EeGI4qNhbXFgRuceACAh/OKlZc+Kz8V3qGkJTxptq7Dpf2zat4aGwASud/EwBGAchYz/rZNknGgfBKFbx9H9uJ/FW02oNXMvJ6hrtFjmoBJm2Wb9rfOIY/WSysMyIvNWCYh2ABqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769069999; c=relaxed/simple;
	bh=7wjIICdI/a8cjpTI1k51V2vQP0Fu5a8mhNvbjcSYJGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExmcBy//EaWHY8iTO3TdE26hrNxZIIhx11RV8d5Crbre0YMAjk7jE8mjny1+fXdd3XQg5XyPcwZjuo3VkB1V1jOxjei3eDP4V6Bj4MiLsqxtoG3Do8wo5hjwWr7tDwDXE37Aza2nP1BAyiq2nVnGtc5XGey+bCKq+omwIbXXVy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=eLrH76rz; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="eLrH76rz"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 106581C03FC;
	Thu, 22 Jan 2026 09:19:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1769069996;
	bh=7wjIICdI/a8cjpTI1k51V2vQP0Fu5a8mhNvbjcSYJGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLrH76rzlrqeTfAzLo4AeiIV+MU1GJpSXjyNUR/HJYCpvkHHmPudOQvJwSDXc1LCk
	 +yGZlsg4wxk8YsZRlkFSuHWLcAguJAwq2XFz/hrWTEf46/SXIMlgIWykw/kFGVSYlw
	 Ykk4/puuKu8CQ/1TDYSIiFjW8OdJxjQ7UYLPMkDb0pIjI+/gaaXRaLhkb3FodIES6H
	 oaQM6k1GGzRFFV+x5u3RXaLbyNWtNDommcv9Apm+ygH0NSDvIbIoWC7D2AftzURsvl
	 pwYbN8tl08U3i7AXexaNpHzOu4FNzqmmNPNPbcgj7TeQENU4jXC/YdSbFRfKZMtVPv
	 F3JmbdIRm+E9Q==
Date: Thu, 22 Jan 2026 09:19:54 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	iommu@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	rust-for-linux@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] rust: iommu: fix Rust formatting
Message-ID: <gww3jn5noc7z6z5rvkqrevkrxhm6ymwdgzqnhdpp5esc3cranc@vou4etrrxzmp>
References: <20260121184339.74256-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121184339.74256-1-ojeda@kernel.org>

Applied both, thanks Miguel.
