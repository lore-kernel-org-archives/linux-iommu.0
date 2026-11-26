Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795682922;
	b=FKnosCBs+jY0M8zm/rhkeEfoydZw7Jp0JRkcOXzi0G87Wx8dGtyvQC2/v4S7LQ8snY1y
	 Zg2g+orCzIMwT3li7Qef9vPr0+bSzGyofjAWcvFdi0dM/dLbnyPA9lwYlRbQT8+fZpFnt
	 lzvXsdTPY+jO0D80n6l+TEW0fPKDJUCPCO2BsG7DAdnfnIlqLJKC7WazM9WQcotE7pecL
	 myK++s1gogv3AUf1QBNtWvNwyM4MahxYTz3nqaiE6GhINd/jeipJ7T/LJN8JJRkjdfPsB
	 MLbvERb4z71oAhMTwmHsq5VvHhQnFtCiONveMnyxE6UHTmwlU0lXLT1l2xVX33gzhnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795682922;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=io1kMFUEr/ccPJRfYw0m/6E8bCk045K1I/y5et1ULyY=;
	b=g7s24/qdg1cP368UdPDP1M0bbJTMNYeLoKjS1iZDdJSuQJZv2QmGjn0KJxzncbHCh5od
	 EcP72sqFe8w9xlgVTst31Cmf6gbggDWYRaX/0yyAHVaED7/5gZYo5sv/KNqrUz2qiVg86
	 P/I2HgEq0v7kif9K8Xh36mR3r+GjiyNxIURM5AIGjo1Ch4oXgJZjLvJIhoIYXgL2l+/uv
	 u4yCo/A/h5N/+EtI5G+sTIiEUCYE+UE1AOL2TrnFALXui12oISbqZ31O+EoLO8QtkU59V
	 eMm7nZ3+mRwAUPq/u/Uo/gb/KWyOfCQ9m6ompgWAcsp5RZpLWkRTWnFxB5MqtZ6bh5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AM2oPE1h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9166606A327;
	Thu, 26 Nov 2026 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AM2oPE1h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86D31F000D3;
	Thu, 26 Nov 2026 08:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795682922;
	bh=io1kMFUEr/ccPJRfYw0m/6E8bCk045K1I/y5et1ULyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AM2oPE1h1eijCq+wOs82I+3Ir+mXWdXechOjxktI2SaX4enYJ7F/SJItwYNeNPc/o
	 A9AFjWZ/sToiQUR35COyMiVkjdiaqCHPvq4vS5sJaIkkrV8L/n1CFwwjtjOLlBIUxI
	 BVFmSqUhySSFvg7iib0ZWfglytiNAXQDm8NYm4X4/Td7WwdeP6nlYQW2N9PeDAU0bm
	 x/4mZWcb1p+//twK4V+mxgxAiojBThqOYyG0TH9pEMzpXCDCdcZML/adj8jvVRy9vX
	 a9gkqlPnD2NHrPpGtfbaz1jSh0cJsdYXwhrA0aDGuyVbT9vtqn+luNToGIHrhG2U68
	 89MIvV5y+rNEA==
Date: Thu, 26 Nov 2026 09:48:37 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Pe3k <pe3cek@gmail.com>
Cc: iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Damien Le Moal <dlemoal@kernel.org>, regressions@lists.linux.dev
Subject: Re: iommu/vt-d: data corruption, AHCI gets IOVAs inside its RMRR (HP
 Gen8)
Message-ID: <awfyZTNe9WFue33m@ryzen>
References: <CAGvcwsDdKSZe0reeuT0eQabaSbM6+KAfwFimxiqhvKrjD2nQeg@mail.gmail.com>
 <awX_cNOqtTjAP33a@ryzen>
 <CAGvcwsDwi9vNcCLxdBz-Arx=5i-fFvqxP+QbRKrx7hK4yqmvRg@mail.gmail.com>
 <awa_ys0XSt9UwAZE@ryzen>
 <CAGvcwsCvuedSN4Fs1TaFRTVc2QbcQK94P6+xqH3qmEvNqq3d9g@mail.gmail.com>
 <CAGvcwsDzu1HEUPWNRvybqH1=Lte0rYk9JohctDgR252eByBtvg@mail.gmail.com>
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
In-Reply-To: <CAGvcwsDzu1HEUPWNRvybqH1=Lte0rYk9JohctDgR252eByBtvg@mail.gmail.com>

On Wed, Nov 25, 2026 at 04:49:10PM +0100, Pe3k wrote:
> Hi,
> 
> I tested the suspected commit and its parent on the spare Gen8. Same
> setup as before: intel_iommu=on, translated default domain, the same
> copy load, and the 5.11 mainline config trimmed with localmodconfig.
> 
>   c062db039f40 (parent), two boots: clean. 0 of 6 copies bad, no DMAR
>       errors, and no map in the RMRR range in the iommu:map and
>       intel_iommu:map_sg traces.
>   c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the iommu
>       ops"), one boot: broken. 21 x "DMA PTE for vPFN 0xf1f80..
>       already set" with the WARN in __domain_mapping, 1 of 6 copies bad
>       (20 zero pages and 1 page of RMRR firmware data), and iommu:map
>       shows AHCI mappings inside 0xf1f7e000-0xf1f94fff.
> 
> So c588072bba6b introduced it. Its changelog says "Remove the iova
> handling and reserve region code from the intel iommu driver". Before
> it, VT-d reserved the RMRRs in each domain's IOVA space itself. Since
> then that seems to rely on the generic reserved-region code, and on this
> machine AHCI's RMRR does not end up reserved in the IOVA space of the
> group it shares with 00:1f.0.

Adding regressions list and dropping linux-ide list, since this is not an
ATA problem.


Kind regards,
Niklas
