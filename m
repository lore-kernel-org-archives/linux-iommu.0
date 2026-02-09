Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDDE298CC9
	for <iommu@lists.linux.dev>; Mon,  9 Feb 2026 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770653162; cv=none; b=jAMfG1bclef39xhZ9k+i96XCGpHtUohZg7kep0dVyvL4EesFOsScGSiRwJDFlr056cM8WyArg82nS+kqZS1psWIxInKNlNmxjiMbgE+842D7bp1006RUuub7vY3jJgMxKEgeaficwk/QAI3KoQHBzDP8a8CjOJ4PoB7YwEy37f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770653162; c=relaxed/simple;
	bh=j5YRDCf581DxSZELSDqFmiETNcYM18q4XtmJvweo84o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aysnRDC1sruBSD1NUSCRNQ+llMl9cnVyiF/zh8FcubMxiLytynleEPlFlROv48XJGWzHCmdsJGtDg7Qp0IrXH/9BLgh4HeFpNYQ4gY1roBsWrsnICRGI4jGyM159bbZKQ7yKADemNuQXWn+mmhJMfeyIF6r1aifCKS/ggvkhriY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 180581063
	for <iommu@lists.linux.dev>; Mon,  9 Feb 2026 08:05:55 -0800 (PST)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 350073F63F
	for <iommu@lists.linux.dev>; Mon,  9 Feb 2026 08:06:01 -0800 (PST)
Date: Mon, 9 Feb 2026 16:04:02 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Karunika Choo <karunika.choo@arm.com>,
	Liviu Dudau <liviu@dudau.co.uk>, Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux <rust-for-linux@vger.kernel.org>
Subject: Re: [RFC PATCH] iommu/io-pgtable: Add support for Arm Mali v10+ GPUs
 page table format
Message-ID: <aYoFcjNkPkPQh4zG@e142607>
References: <20260209112542.194140-1-liviu.dudau@arm.com>
 <58767D4C-505C-424B-AD08-C042BAA3FC34@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58767D4C-505C-424B-AD08-C042BAA3FC34@collabora.com>

On Mon, Feb 09, 2026 at 11:16:38AM -0300, Daniel Almeida wrote:
>

[....]

> +cc Alice Ryhl and the rust-for-linux mailing list in light of the Rust abstractions for this component

Appologies for the omission, I will bear in mind the next time to include Alice and you as well.

Best regards,
Liviu
