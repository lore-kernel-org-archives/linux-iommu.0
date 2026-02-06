Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F043EBF05;
	Fri,  6 Feb 2026 06:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770358301; cv=none; b=K+BKFD8VJtIkJ8ShFaam+rN4ElOVwGKEinoGe3XpVJ1Bc3C7OG0tznAfo68kqIpCbHPciDmUcvzyYUuDOGg62iT06+OM42wKKWqOIrseC1tRhrKF1n6O/VdTbu/bwNVa0CMrQkwJYkLv9HObF+xbNe65tVYp7RyfwsYmG5OCB4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770358301; c=relaxed/simple;
	bh=xQSKwhkANWN8IwjK9ckDxM334/zoJ+AcdEkWuOlyze4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WW69H6v0nO23IDKySgA9+GMzW99BeTSyJwaT74fBVercXH0FqNCn+d0hcwE84qPDPtHpSgaILntLyZXfj/yU7jrUGopWQ1ZNhSu/o1MOEGbIwmDAnNmwIQqthmjseuAYIXgz2n/NUAn4agPd4gSq/7eKJiDqvJk2qfNktX+95hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPsGU1LJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPsGU1LJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2709C116C6;
	Fri,  6 Feb 2026 06:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770358301;
	bh=xQSKwhkANWN8IwjK9ckDxM334/zoJ+AcdEkWuOlyze4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bPsGU1LJrFqeLArNybkaNfr/lVd5ZdvZFwss0zlO1bkv6QAcNoTkRln2gPQdfBc8P
	 v9jsoEj15xJNX22uEts8ki7IRrdXusX7r3tya+jqqU5sBHRU/rFJ97C1COKah5dA0Z
	 fDRMu3kM9h9nxKtwmQr8rqeDbVoT0o615FzVew/jA5gomL8EE5vGvNyd8GmK1eGGyq
	 7DLLTyTW049d2U3uUgaRG8URQmt6gC9nU2BmAkQmQe7HZGu8EFcoJVmtZ882vh04s4
	 RnT5WJ7LPnuttQxFOC/yxAXEzpt9fBkgb46ibM3Ec1A6esdPs8VI0DL6KPpjZwptGu
	 sqGvrg8kvJc9A==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, suzuki.poulose@arm.com,
	steven.price@arm.com
Subject: Re: [PATCH] arm64: swiotlb: =?utf-8?Q?Don=E2=80=99t?= shrink
 default buffer when bounce
 is forced
In-Reply-To: <aYOVf066Fdr9L-nw@arm.com>
References: <20260120070102.182977-1-aneesh.kumar@kernel.org>
 <aYOVf066Fdr9L-nw@arm.com>
Date: Fri, 06 Feb 2026 11:41:33 +0530
Message-ID: <yq5a8qd6iep6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Tue, Jan 20, 2026 at 12:31:02PM +0530, Aneesh Kumar K.V (Arm) wrote:
>> arm64 reduces the default swiotlb size (for unaligned kmalloc()
>> bouncing) when it detects that no swiotlb bouncing is needed.
>> 
>> If swiotlb bouncing is explicitly forced via the command line
>> (swiotlb=force), this heuristic must not apply. Add a swiotlb helper to
>> query the forced-bounce state and use it to skip the resize when
>> bouncing is forced.
>
> I think the logic you proposed in reply to Robin might work better but
> have you actually hit a problem that triggered this patch? Do people
> passing swiotlb=force expect a specific size for the buffer?
>

This issue was observed while implementing swiotlb for a trusted device.
I was testing the protected swiotlb space using the swiotlb=force
option, which causes the device to use swiotlb even in protected mode.
As per Robin, an end user using the swiotlb=force option will also
specify a custom swiotlb size

-aneesh
