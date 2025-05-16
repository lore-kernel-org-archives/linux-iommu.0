Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005741361
	for <iommu@lists.linux.dev>; Fri, 16 May 2025 06:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747378064; cv=none; b=W/woLGs/365/4GPTqKV4WTSnEKCai3XL4iyIddmhMiuc8h/j4gz9J0tJQ4FJW4sYVvEPvHp82arPZHbxbjvcKKQPGZUColwDLxhTncRpBH03tESgwMOiT3Y/nLtitUq+7O9zq5+QzPu1n1pFOTUsZZuB8jLIdN3mBwO5uug8yjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747378064; c=relaxed/simple;
	bh=+8BDgBey691VNSBZjd0HdnlUxaTWfqka20xfk0knP2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mg95nVUl4VL97QxMARUXZGV/lDubZWQ2Aax8yUfudgNK2mvtQuFGYs2zGr4IPM9gSpIX8v490GTU8Dx5ungboFShxKQz3HUfHY3o8ACTqQpfoy4cXso+xNrUqBAT/o86KVVwndJlYyVvTdUf2cQ8oHadijepGVAZt3zDtdSbkp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Zxt4LPLt; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Zxt4LPLt"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B313E4B65F;
	Fri, 16 May 2025 08:47:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1747378061;
	bh=+8BDgBey691VNSBZjd0HdnlUxaTWfqka20xfk0knP2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zxt4LPLtGk6no+szvy+NXvA+Ht3Jtx7Aar2bjG3i1RiJH9XNy/PYQyYaOxNJQyEpD
	 InxkiYozGyqipO4XuCZtmEJ9kce2ntz8qAf1N9pPbNjydsVkchuqxuGyHP8/jCoKY3
	 l2uD0APUgVPbF3hlnv+NkZGoBrEiwfHAatECWlPvxGsTfuOASNomR4iXalz/Xka/7m
	 kNq55SJGGK3wjQyLZ9NBzxMTYc8etZhQkfszRdDIzN51wzszWH3zTpQ1HxvFfxhuYZ
	 ZyosvMdYr6lVmYvQ6wHpUmwP/9DlilvcFOTyge/fPGoyPgAyHXHouzMTnl/KFlGH3I
	 AGpV++QVB6OKA==
Date: Fri, 16 May 2025 08:47:40 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Rolf Eike Beer <eb@emlix.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Bert Karwatzki <spasswolf@web.de>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCHv3 0/6] make vendor specific subdirectory inclusion
 conditional
Message-ID: <aCbfjD5kybvl_hqG@8bytes.org>
References: <1926170.CQOukoFCf9@devpool92.emlix.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1926170.CQOukoFCf9@devpool92.emlix.com>

On Mon, May 12, 2025 at 03:07:27PM +0200, Rolf Eike Beer wrote:
> I found it strange that the vendor specific subdirectories were unconditionally 
> added. Everything in these directories obviously depends on the specific Kconfig 
> option. This series cleans this up by making the directory itself depend on 
> the respective option which looks more natural to me.
> 
> I must confess that I am too lazy to find a good solution for the "arm/" 
> directory, so I left it as is.

Applied, thanks.
