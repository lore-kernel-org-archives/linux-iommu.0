Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680059;
	b=ZvgXV5GctFgTVMkoVhftjy5F0hQpFIJXmzFnTE+LfTjR+6m0Yy1bCAaOkoJB4WwDa2Jh
	 Glv7akmfI7FWB6ezSru/BZAATe8so2tWt3/PydM3UiTxduO0ryi7740Lfdslsgi0lwM4p
	 zbkVNCMmVdTdPtOZLyej+yeSpuNDTA9HMWSIPo2iKjeVxjAi7RaFmD2xkXLcOenFQ/OR2
	 Ol8qEptLqUx5jcMfLmyBfQbEt5Rnhvb8vggsgfX6Pym2MgXe0kHAtiiZzbfAMzygTCtNa
	 oSBYB3jFgqzKQANIhYBNqCktMb49TsWHWZWDjdlQiCpWxMUUEuljVGYzmz34PGS+J3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680059;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=f3brnrr9GTVM/u1/q9tBPE+4oO6hwpwhbCfP57HoEM4=;
	b=Vcm7PvpO9exKZ8IySgAd/hLz3esncEcvuyXmUA1/RyChuVZPM0Z0+4Mo/+7Wy9kSFiKO
	 qpjr1w0+eReUb2b6Fd3RO1dcjHEG65ppKUmVCu7wJ31JFUanPZO0xUGhZqSEufFAOs0Yb
	 DNDgNjXbWzFsS+TmPDSZcr77Pa0rD0iw543f6VQqSjP+sV6xmXoethv+MI8p0CMLEFJmA
	 C5ClEL1zpRTZwxri5REsHoHKG9xLDPm9CS9SZoj8BHyiDnloZtHk+7M6KEzZP5UbdjQYO
	 26bUPYIiefmFsL9l0TdVxs+2PmAtiMOtIHa0kOX8LzoTrNNhjoe9qPKH0fUJPebwGrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RSQJfjke;
	arc=none smtp.remote-ip=91.218.175.176
Received: from mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43103606A319
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 14:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43103606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RSQJfjke
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Q8GxvwGChN6/R7iREbia4Y5Fe+czvz/W6UuO4Z5BeAg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792680051; v=1; x=1793284851;
 b=RSQJfjkeTeMv7d3HI9fYpewS/LEJnmAp+2VJu8Z/R+YVjzDjK3Rdiunj6L57DokGUwa26lhm
 z88Elv9JuEMAnpnsatW6mJNBmQ+/ElBOllDLlVh41xTV0Wk0mqDf4bRJo601405k2RRBLrGrM7w
 iItyavz0u0AnoTJFw1T6eZNg=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id eec811b34d849da2;
	Thu, 22 Oct 2026 14:40:51 +0000
X-Mizu-Trace-ID: eec811b34d849da2
X-Migadu-Flow: FLOW_OUT
Date: Thu, 22 Oct 2026 16:40:41 +0200
From: Andrew Jones <andrew.jones@linux.dev>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, 
	Andrew Jones <andrew.jones@oss.qualcomm.com>, linux-riscv@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev, tjeznach@rivosinc.com, jgg@ziepe.ca, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, 
	palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com, 
	fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v6 09/16] iommu/riscv: Reserve an MSI IOVA window for
 iommufd
Message-ID: <atoeGhJkcgy2G1tO@orel>
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
 <20260925151659.419512-10-andrew.jones@oss.qualcomm.com>
 <179209292716.4133959.2758345963634439485.b4-review@b4>
 <atEuxafCLCdZrdR7@nvidia.com>
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
In-Reply-To: <atEuxafCLCdZrdR7@nvidia.com>

On Thu, Oct 15, 2026 at 12:51:33PM -0700, Nicolin Chen wrote:
> On Thu, Oct 15, 2026 at 04:35:27PM -0300, Jason Gunthorpe wrote:
> > > Reserve one page per possible CPU, sufficient for each supervisor IMSIC
> > > page. Use a 16 MiB base instead of the 128 MiB convention used by ARM
> > > SMMU. kvmtool places its guest IMSIC at 128 MiB, so with IRQ bypass the
> > > domain-wide guest MSI address match can also capture host-delivered
> > > MSI writes to the SW MSI window and misdeliver them to the guest.
> > > 
> > > 16 MiB falls in a hole in the current kvmtool and QEMU virt memory maps,
> > > away from their guest IMSIC windows and RAM. Keep the window below
> > > 4 GiB so devices with 32-bit MSI address registers can use it.
> > 
> > And this is a good reason you should not follow ARM down this mad
> > road. Nicolin had some patches to allow userspace to select the SW_MSI
> > range instead of using a kernel hard coded value, which becomes a
> > sneaky ABI. It would be much better if riscv starts off on the right
> > foot instead of continuing this mistake.
> 
> It was paused due to lack of an immediate interest:
> https://lore.kernel.org/linux-iommu/cover.1760487869.git.nicolinc@nvidia.com/
> 
> If riscv wants it, maybe we can give a push.
>

I'll look into Nicolin's patches in a follow-on series and defer enabling
VFIO_IOMMU_TYPE1 for now. I'll see if I can avoid introducing
IOMMU_RESV_SW_MSI at all, which would rule out using the legacy Type1
backend as it stands. Instead, I'll try to support existing Type1
userspace through iommufd's compatibility interface, which will need to
manage MSI IOVA allocation without SW_MSI, since existing Type1 userspace
won't issue Nicolin's ioctls.

I'm posting a much simplified DMA-IOMMU-only v7 now.

Thanks,
drew
