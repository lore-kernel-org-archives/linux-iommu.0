Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781686;
	b=oevkK55jMkjnecOdHTj6dCl67UDFF/6Wa7ZiyUaNdX4Re1ftjDzboSnDPDxGL1gUk656
	 L/ogpykISIw40FIR8cJvfS6/useVn6IJf98PkIctmP9Ub0xw1Ylky9NmBIqxPb4EcdgyU
	 psLIgWbmxGBqZfDtMsi9qxTeLhjrLZh4ggQPP837UNJCIOlUiT7JJ3s/uF3lWbJKgzeEL
	 NQer3E1QT34P1MYwkYsLGE/6jdjLqEuJ4g+b9TrUU6+8OZYM2YdPryE9OfQhKgjyN1i+n
	 rQ+ufj89yiLdRQKi0u2u3865bdN//NEUG4wSzzvPj9xE2tc3U7farHCO5i+66UfxPyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781686;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=3w20wn8ciMIi314K9ZKRgL922tIUAQ1fVj1q7jFt11I=;
	b=YVbqdJTquLn3SjFgyy9SKFu4FYtxD+XqF/htujHQvVqAq/NxMzFUk6ITPp4HqP/5TgmS
	 4/IDO1LWa8gz6HyKpcY3NgDtphsHzpNFTZ97VKHA+nm+YO38r56YWbOGejxfQ2d7WCSWn
	 SIZ3jdKd6DPYjlM/L1301KESuQX/TzSqkbyPPHdpsaI67/yzC5iFPqliBzor3/85Jx822
	 oVVpauVlisyHpD8bRejx4qrE8+pO2yMTe+3ryl0BghJegNDX7nUWmUz5VBn0iKzBeiwwi
	 lBExA7t9PioPw0EWsPNjbbidw9NU/zYIyrJPE0GfKiwnwqHhDUXshPGPNHbU9qpkBIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrGEsf9R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8B3606A323;
	Fri, 27 Nov 2026 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrGEsf9R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA841F000C1;
	Fri, 27 Nov 2026 12:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795781685;
	bh=3w20wn8ciMIi314K9ZKRgL922tIUAQ1fVj1q7jFt11I=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=JrGEsf9RGSAi95mThpsPZiqwBb8CPAROQvgPolW2qIJ2xXEk5VJKACzsGFeqPtsMk
	 12STunPm5NpI3riSYWarempFNzU3lBP52Nu9ASxRNvvlCt5tbzD/Hw69Mx3qSnEwze
	 Tixfxfhgo095X1TISXxrvq2kWiGqVrUKHT1E9npI8SB7mKrHS/umAuWt+Hx6/XLiPW
	 CxkomSEuUSy3wQR8uAzWuBAWKwnbwVNUjdHwpE1WFY5jnYft8hPuN8KnQgWOuemKqt
	 DFUFi5a6yGXRGOdEjpfbF1YQa23ZPwEuA+i7DRrh/a6UUpOg1fAbG/YbyqIeU2kgn0
	 fWfCj2t0bN5wQ==
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/8] arm64: Unmap FF-A lent memory from direct map
From: Sumit Garg <sumit.garg@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org, 
 akpm@linux-foundation.org, m.szyprowski@samsung.com, jenswi@kernel.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, 
 ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, 
 ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, 
 danielmentz@google.com, linux-arm-kernel@lists.infradead.org, 
 linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261111110738.872947-1-vdonnefort@google.com>
References: <20261111110738.872947-1-vdonnefort@google.com>
Date: Fri, 27 Nov 2026 17:44:23 +0530
Message-Id: <179578166371.172025.10770561998032628043.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=764; i=sumit.garg@kernel.org;
 h=from:subject:message-id; bh=H72B6Re7Lfo3dYJpngqffII6YfaUb4iqb0oxwd+0b1c=;
 b=owGbwMvMwCV2RWpxpe9rmzmMp9WSGLI5SzTqKoX2v6poOjM7Tepq5Ht5my8u93hEPXlY96rGb
 llxtjyvo5SFQYyLQVZMkSX167dp24T+1YZaneCBmcPKBDKEgYtTACZyuYeRYavT7sI3m/SebpyX
 onf6hgPXAYGpWw5ElojkKeqEbHUztmH4w+Vd9c3uxqQ7AhKnb8xtPv11xZuQkk5zO+20IpOs84t
 N+AA=
X-Developer-Key: i=sumit.garg@kernel.org; a=openpgp;
 fpr=65F5F696B612FE7D553AC80CD41AA3794DEB3C9C

> This series is a follow-up to the discussion that has started here [1].
> 
> When memory is lent to the Secure world via FF-A, CPU speculative
> accesses from NS to the lent pages can still occur as long as it retains
> a cacheable mapping to it.

One thing I forgot to ask during last review, in case of hypervisor
support like pKVM how are going to handle unmap from stage-2? As I can
see from code pKVM doesn't support FF-A lend calls to unmap pages from
stage-2.

I think overall it is important to unmap memory from both stage-1 and
stage-2 to avoid CPU speculative accesses from NS when memory is lent to
the secure world. Is there plan to support stage-2 unmapping like in
case of pKVM?

-Sumit

-- 
Sumit Garg <sumit.garg@kernel.org>
