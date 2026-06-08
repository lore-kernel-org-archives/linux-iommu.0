Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E97EEA8;
	Mon,  8 Jun 2026 05:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780898306; cv=none; b=PdF9C0/UghMagz5nHjpt/B15uJ+j9WA3pl7pHGCxtbkBB/6Lr+kHMBo1uNG15mDHP7MQvz52bcc8Gi0YRa8plATN780eY7o1CLQwnaffJuRw/FmkUN+F4Kx5HAPV+sTwgoQrXVRIZQ+15ERWX/8ENhC6TiZlr5EUbjyE8rFmGMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780898306; c=relaxed/simple;
	bh=k4Hs1uVFViwv2FA9chw+IcyyWy+8AneZSb3CZ7VkoIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOPU24/+dL8i7efLdoFiuJIcijJJITb/5IFvajc8Q5NSfVQjGmlG0uExFp8gD2LGfRg9nHx38R1tPKRAjD/6zJI5ft0cq4hl8uw8FexDTK9umutFYj7jIXpcuU63hKWIaAd0/bbc90nkEmgAOelxo4X2PL2Thf2cm3sUei4X0xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdM6XUst; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdM6XUst"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5419D1F00893;
	Mon,  8 Jun 2026 05:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780898305;
	bh=VMtG3vI7QlXX+dnCQlAU6vBm5uepbxdKi6GBwd0rBgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cdM6XUsty0h9CPEawW32wLEux/C7tWSG7kRbyF2h6zYFhe2TRDs9c+ilcLmCPS2Fs
	 vHn+TWSJ5I1PlkYYpQpyU7oKWXRW5fE5A19v6hr+W0jH0sAX/LoB3y6rSYTJez8GCr
	 8OWhDXnT83eYoSFFu2Itk+NAtyawwuWag8BNkDMzvPsWg2le5rK2mkpPFo3HohVlHF
	 DPvS85MLr716MypTW+2lm45hOsH1Hn1kjjPLx/VAZVW379xCCZBSacjishqQmGJiqD
	 AAMzOx5JTYQ8GIgJn6aPJk87L59IqzodjzWXv0xB7NRsHSSRgM8PAQtwX1pb0lVP91
	 zy4YqSpG/r40g==
Date: Sun, 7 Jun 2026 22:58:24 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Mukesh R <mrathor@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, mhklinux@outlook.com, wei.liu@kernel.org,
	zhangyu1@linux.microsoft.com, schakrabarti@linux.microsoft.com
Subject: Re: [PATCH V2] iommu/hyperv: Create hyperv subdirectory under
 drivers/iommu
Message-ID: <20260608055824.GA1555293@liuwe-devbox-debian-v2.local>
References: <20260603225010.1347623-1-mrathor@linux.microsoft.com>
 <20260603165604.00006e9f@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603165604.00006e9f@linux.microsoft.com>

On Wed, Jun 03, 2026 at 04:56:04PM -0700, Jacob Pan wrote:
> Hi Mukesh,
> 
> On Wed,  3 Jun 2026 15:50:10 -0700
> Mukesh R <mrathor@linux.microsoft.com> wrote:
> 
> > Create hyperv subdirectory under drivers/iommu in anticipation of more
> > hyperv related files from upcoming PCI passthru and pv-IOMMU patches.
> > Also, the current file hyperv-iommu.c actually implements irq
> > remapping on x86, so rename to more appropriate hv-irq-remap-x86.c
> > and move it under the new hyperv subdirectory. Since this file
> > implements irq_remap_ops exposed by drivers/iommu/irq_remapping.h, it
> > cannot be relocated to the irq directory. This is in sync with other
> > backend directories like amd and intel there.
> > 
> > Lastly, this file should not be tied to CONFIG_HYPERV_IOMMU, but to
> > CONFIG_HYPERV and CONFIG_IRQ_REMAP.
> > 
> > Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> > ---
> > V2: rename hv-irq-remap.c to hv-irq-remap-x86.c
> > ---
[...]
> Other than the above nits, feel free to add:
> Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>

I massaged the commit message, dropped the spurious white space changes,
and committed this patch.

Wei
