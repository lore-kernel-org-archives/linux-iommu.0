Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.214
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795276171;
	b=HGnmX1mVIMSQZmE1571RAxczB9IMe0tKpI0pqQhqc3MyOLy+9gTJ3LGavW0LSZnfX4hI
	 Xf0+Z1Xncf99RkYqFarfPuj5kyPJrFb5YZTydMKMUL+3sfP4fXWQLjhOug36Ffr2UP1vi
	 7eUP4EAN3hSc2MaOhDlENWpfsrHnuJRj33/TTj9FWZHHsyGodzTHnllrZ3dhqaVj5aqWy
	 /9KhXZn9tyqB5Xm/ClIrrlDyohjCtumNXJWcQKBM6C3zPd3x4S7WFeuFde7GgTgyhoj/h
	 VM5Hr+m+EF/Am19ZLo8pzXrXWMbkv1FkSpUR4GYe/+96YDopbMm/HB5rdCeD++MIuLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795276171;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0YZb9vl8h3h2s9tCOBwKg7YDMBx7IJ0VENcqcFynRLs=;
	b=BPQbC/CMmM6jqsMoI5xF+/QRkTF2ixhHlkrh12vZ0Gj7+cotXAB52A7Q1Xcj89eBw3uf
	 usP8N/eTYPvUiMzw05z9jbdQGuUEBpqY5kvkLiLbPKAD/dZYouRY8GfY4/ci2gr6DvDhu
	 sZ5eCBP1fS8djuysz9wndj2eQpPj1TKzXLAnvXZbTyc5kvoG+UHaFj1/7iYhZnLprZgDX
	 kK7Y935Xo8EUypojcUxT0IxLZbOS4FiDgk1m7xOZ7NMBa2eICspXXOlnvvQRVqpcJC751
	 kX3/79NPpV9eZxZCRuN4ahoQFWOb5qVp1w7oBp3zXwALosJyRLQJ0/Ui0satm3tIT+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w2pR9wVL;
	arc=none smtp.remote-ip=91.218.175.214
Received: from mta0.migadu.com (out-214.mta0.migadu.com [91.218.175.214])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA08606A32C
	for <iommu@lists.linux.dev>; Sat, 21 Nov 2026 15:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AA08606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w2pR9wVL
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=87tG5wTJqa8KKU5Vw1XcYaRFIKmNyRkg1DQIqfjExPM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795276168; v=1; x=1795880968;
 b=w2pR9wVLVUEmNc/0xvbGAfErcyc7Q064cNe2Qb0JIQ8E3trfNPtCcUuXokXWWavloaXnxfRU
 Y3drjX4obip27K21vOfT/kadJGIDVNpdHfim3KoKCHqoBpoWUFI7VggUrR3pFshFi6VvgDpAEym
 dXAczSt5dyLO0XQ6IT/CY/Lk=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 1cf4a9c89376da71;
	Sat, 21 Nov 2026 15:49:28 +0000
X-Mizu-Trace-ID: 1cf4a9c89376da71
X-Migadu-Flow: FLOW_OUT
Date: Sat, 21 Nov 2026 16:48:51 +0100
From: Andrew Jones <andrew.jones@linux.dev>
To: Gong Shuai <gong.shuai@sanechips.com.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Tomasz Jeznach <tomasz.jeznach@linux.dev>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, Fangyu Yu <fangyu.yu@linux.alibaba.com>, 
	Tan Chi <tanchi25@mails.ucas.ac.cn>, Wu Fei <wu.fei9@sanechips.com.cn>, 
	Zhao Qingye <zhao.qingye@sanechips.com.cn>
Subject: Re: [RFC PATCH v3 09/10] iommu/riscv: Add
 riscv_iommu_attach_dev_nested
Message-ID: <awG5Q7pmntSme1A2@orel>
References: <20261119132744.396426-1-gong.shuai@sanechips.com.cn>
 <20261119132744.396426-10-gong.shuai@sanechips.com.cn>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119132744.396426-10-gong.shuai@sanechips.com.cn>

On Thu, Nov 19, 2026 at 09:27:43PM +0800, Gong Shuai wrote:
...
> +	if (riscv_iommu_bond_link(s2_parent, dev, nested_domain->viommu->gscid))
> +		return -ENOMEM;
> +
> +	riscv_iommu_iodir_update(iommu, dev, &dc);
> +	riscv_iommu_bond_unlink(info->domain, dev);
> +	info->domain = s2_parent;
> +

When moving between the S2 parent and a nested domain on it, the parent
briefly has two bonds for dev. bond_link() puts the new bond after the
first bond with the same GSCID, which may come before dev's old bond,
and since it's then dev's first bond, bond_unlink() removes it. dev is
left bonded with its old GSCID, so its new GSCID misses invalidations
once no other device's bond has it.

Passing the old domain to bond_unlink(), like I do in [1] for a
different reason, would let it remove the bond matching both dev and
old's GSCID.

[1] https://lore.kernel.org/all/20260928143113.49838-12-andrew.jones@oss.qualcomm.com/

Thanks,
drew
