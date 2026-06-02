Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCA7380FDA;
	Tue,  2 Jun 2026 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392852; cv=none; b=c+crEMAxneZp+H3Ljraw9KWBqTL2d5pBWr2X2L0tnZXr7dD8R0u/i+l/egHemI46NAPyIOEFKXKYm4FXLTiuu+Gu/lg4qw9zce35VymFlSpgOFTEacWYDpZJ6bGfIYLo9kw/kt+Co9hrM7+5aR5gWthQ//Q+Jtqb6q21hUs14u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392852; c=relaxed/simple;
	bh=Th7aC8Ea06bRC4u5rMBdbBfiE7jS2gJ2dyJAvmcLwOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V34Ooq+DOWbGZ5X92fpcpR+BY+b8whMz7Fc/dpP8+LSGIPcoqxnEyw34cHZGbSHygi4YwY8hy7b0qH1M8dnut5t9QMLzTi/MT+K6T1C4hY0HNX7GXWkua9KKydKLmQtV+StDp4z8ddpW6WOxoir67uy++RgM43UgTueXt4I8Aik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KH5cT3/d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KH5cT3/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDA81F00893;
	Tue,  2 Jun 2026 09:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780392851;
	bh=0PgKu/MhXV92fdaOPawC1vOXdcv4sVC0hsvmah/4e8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KH5cT3/d1fW7mKTPUXP2hJf3hqjzw8svhzdezKnm8uDo4NbITku1tcc4lgSDjgCnQ
	 LzoUKYJhDN2BgKJZVqXrTz9wXYbOVdWAntoJqPrxf4WCHj/PeYLX9uMDR7+GZolZr5
	 68FAvxXuuSkAlZZ5ixjIEQEXa/aiyQmCfunPFE2j+qmVfSBZl0YJC8GFWOwYBNsFHg
	 FIsTovKWHP0jaHKp91YmXvpwbu27upGLBcRgjel2izDC/4xZY4FGhFLHlDig1d8Ibf
	 ipIx7HBOjEWNbarMhA7Z8LcEl9VRxhvrmOho3XVlzdpNJGdgt2fiEYoNBjjc9/8g4j
	 BjoxvWi8ygLNQ==
Date: Tue, 2 Jun 2026 12:34:01 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Baoquan He <baoquan.he@linux.dev>
Cc: Will Deacon <will@kernel.org>, Wandun Chen <chenwandun1@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	iommu@lists.linux.dev, zhaomeijing@lixiang.com,
	catalin.marinas@arm.com, chenhuacai@kernel.org, kernel@xen0n.name,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, robh@kernel.org, saravanak@kernel.org,
	akpm@linux-foundation.org, bhe@redhat.com,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, m.szyprowski@samsung.com,
	robin.murphy@arm.com, quic_obabatun@quicinc.com
Subject: Re: [PATCH v3 09/11] arm64: kdump: exclude non-dumpable reserved
 memory regions from vmcore
Message-ID: <ah6jiWwwC6DDSJXd@kernel.org>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
 <20260527032917.3385849-10-chenwandun1@gmail.com>
 <ahmr-UjoApj2j5JS@willie-the-truck>
 <ahsPcv8G1BR9rLah@kernel.org>
 <ah0R8pEIyuk4N2Is@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah0R8pEIyuk4N2Is@MiWiFi-R3L-srv>

Hi Baoquan,

On Mon, Jun 01, 2026 at 01:00:34PM +0800, Baoquan He wrote:
> On 05/30/26 at 07:25pm, Mike Rapoport wrote:
> > On Fri, May 29, 2026 at 04:08:41PM +0100, Will Deacon wrote:
> > > On Wed, May 27, 2026 at 11:29:15AM +0800, Wandun Chen wrote:
> ...snip...
> > There are patches that move common code to kernel/crash_core.c:
> > 
> > https://lore.kernel.org/all/20260525084932.934910-1-ruanjinjie@huawei.com
> >  
> > Review from arch maintainers would be helpful there ;-)
> 
> Before, Andrew would put patch candidates into his mm tree and trigger
> testing. If any adjustment, he would take them off. Can we do the
> similar thing for kexec/kdump patches, unless the patches are objected
> explicitly?

Yes, we can add patches that look reasonable and expose them in -next.
Now is too late in the release cycle, let's start with it after -rc1.
 
> Thanks
> Baoquan

-- 
Sincerely yours,
Mike.
