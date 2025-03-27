Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41591DE4D4
	for <iommu@lists.linux.dev>; Thu, 27 Mar 2025 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114029; cv=none; b=BExK0Zh/xinHd2JlQjO+Icz9mApLQBEsz4BN6kW455sxpJt1bbgx+oi6u005YUVGdFpjKJK+Ir5PQRmVX+HFCdvjMVD66eRN2W73d0qfRdSo5nVbziUe4C4fKgIflDUUqF9p1PMCbT28xg1ALuOJ/ox2yoWC0qNdA+9r6aXLK8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114029; c=relaxed/simple;
	bh=Qljo7I+h9mG4MlHEOO+aiPISer31QeO35gqjFiAepxM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjpKCjn8PgapNMtfdY01Jv//El+nmtFijPR4eHio42CKsNofCQ4WtE5vzRNV/qdrvgvm29kb8/d1n4TpI7J2/EJcAoZAh0jMtlV5t31MeVUKMe6vP4AwVtrm6ZeytJB4neRZkPxs2CkpEuAnXbEtpZP1QBSQIYR5FPPB5QJ82sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bgOvkHzO; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bgOvkHzO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1743114025; x=1743373225;
	bh=/KpF8fnzMUOMSpfBWmOCjM1gtE658ydJ+q9j6uReSoM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=bgOvkHzOTobtMKvnsusEfRFL3kMDcXd8nj9L4IYcosBjFRogjLbZmEd83oC/vstDA
	 stp6xW4FvEyyk8PciZdjO40vw4daITYpq420TIStPGNc/geKS6nRcPH7JlHcy27M0C
	 KHSNUbkurvwVKNuX+wVUCdcRRHlf1X2Gv3Fi3K21+yS8PoW6paxie/R6SqFe1IUjU+
	 F4oSW5eys91v7XosivRomzeVG9TiwG6R5yvBL9vaZf9PzhtlJD3179vUMm8P3CNp2F
	 P1Ur5nK8uRoM7Ac/PAIjEipcg2J1SgSnkShCZUgVaBqBV/fKsCvm/7qt5yM2tj3sJB
	 GHJw3yfSaaekw==
Date: Thu, 27 Mar 2025 22:20:21 +0000
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>, a.hindborg@kernel.org, ojeda@kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, "open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]" <rust-for-linux@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] rust: dma: be consistent in using the `coherent` nomenclature
Message-ID: <D8RECLYHIWP3.11SI3UWJVZ76L@proton.me>
In-Reply-To: <20250326201230.3193329-2-abdiel.janulgue@gmail.com>
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com> <20250326201230.3193329-2-abdiel.janulgue@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 119eb6d0acb9c7ccaedb6faf72deb47a1ff902d7
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 26, 2025 at 9:11 PM CET, Abdiel Janulgue wrote:
> In the kernel, `consistent` and `coherent` are used interchangeably for
> the region described in this api. Stick with `coherent` nomenclature
> to show that dma_alloc_coherent() is being used.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/dma.rs | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

