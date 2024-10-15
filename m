Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066E41D9669;
	Tue, 15 Oct 2024 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982792; cv=none; b=D2R4mqSF0jk+3r23UtmMs2da0gLPyrLYTqGxJkPXmO9f2+Ct9ZnlwfBVVK2qXHfxhp3VIH4Ym0qMhcN8ZDDF4Yu8k8qOpNpyR+nsMHmPdByo1H24zdkqZjt5vqj5jWUhWLDtDiXLKlObTRN0VlBzAnIN0axPqQ2ImLny2XsZ9kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982792; c=relaxed/simple;
	bh=y3aK+OC3+bmAwtiyXzBhoRjPUn7oC1omzxWkKEaweQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGXkCP7t8er3LiCLUaSaZI45MXxYkilcMjJs3s1eLZuR0UpPJdlNpC0CLe1CEzDaWFqTw+19wWL8T18dtoeQTsZl53glcc/bjV+ZK9JZ4h+4/ljc8GnV1kE6ueSRnX1STpx9TJKSbqc07ZNxLz+dIHLQFaHkOHNPiJcX7+YNsNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNvBY8Rb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNvBY8Rb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C35DC4CEC6;
	Tue, 15 Oct 2024 08:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728982791;
	bh=y3aK+OC3+bmAwtiyXzBhoRjPUn7oC1omzxWkKEaweQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNvBY8RbYZyW4uIXyvjZb7rC0g0Dkmw0bowhZixXU3TgcAe8Tdou+A1/BSJX5p8m6
	 kHMuuCu+6Umd1KgKySjGYD6HLzjA3IXG7w/P1L+DC5pK1M/Q2iv3ubfT1aGKMqSKCk
	 iNkuVHtfe5Lu07Fr+ZrC5zdY/q6HaZGFESY0Osb/mmUinKZ4Kp8iDHt6Y4q3GKsIzO
	 OyDT0UaJo/4dRnRINUGRAH4mvmEmK9gzdW/NpZWBR14lCWLOHnlq4kJYY/a6iBqZKQ
	 aDIEpw29fBzj2njrU+bsBPK9wRkXDy1RkcyakFs3hSirX7pHWTD/qGm90vc/+SsRhR
	 7Na8oo9GHo4Mw==
Date: Tue, 15 Oct 2024 09:59:45 +0100
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v9 0/7] Linux RISC-V IOMMU Support
Message-ID: <20241015085945.GC19110@willie-the-truck>
References: <cover.1728579958.git.tjeznach@rivosinc.com>
 <Zw4s3BHQZ6x4d79-@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw4s3BHQZ6x4d79-@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Oct 15, 2024 at 10:50:36AM +0200, Joerg Roedel wrote:
> On Thu, Oct 10, 2024 at 12:48:03PM -0700, Tomasz Jeznach wrote:
> > This patch series introduces support for RISC-V IOMMU architected
> > hardware into the Linux kernel.
> 
> Thanks Tomasz. I plan to merge this driver into the IOMMU tree if no
> further objections are raised in this thread by Friday.

Sorry, bad timing on my part -- I just left a couple of questions/comments
after Drew poked me at LPC to look at this.

Hopefully we'll get those resolved asap.

Will
