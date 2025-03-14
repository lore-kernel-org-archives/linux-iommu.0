Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3D2202994
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965865; cv=pass; b=ITjwEgMBDI13moQkK4WjjBM59miZgzVw9vKs2JZHegnTQ2rCT7sDE+ffH1lD47TqDrsKmvwmU3wzC/NHXNJijHHsCbXoPcsNI/Zu7DR0iObSiciVvrtNgO7fbq+EcD+5EY0r1V/twiToDV3wxy1Dl7KrwjeKYP5nsRfIKsqE1bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965865; c=relaxed/simple;
	bh=5NNLn8o225TdZXA7u0GvGNYzPZdZPdqKBfXq6DaAKS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLAm5wIb8qbkNKtdNid3CCs3u+wn7Tnyx31ch9cdRMDR1Z6/D0fLfngRSgXC/cGnv3T/L60dYRzwAVaHB9PLbpXpwRYtgYQL6nINRMe4yGCyrzwRmmkL+tHSQDwdmwLMNznUo1P/nEsULwqdB3AABnOpi8dLfg5BqimuJXSdztY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=ZLkJGJCl; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="ZLkJGJCl"
ARC-Seal: i=1; a=rsa-sha256; t=1741965855; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PBE2WetXVXfy4uVLZSjdr0eFNtrxtlpdjHnGeSg3aogrmtfdXWpFAujCTGARAjPJUw5xRIP8VlFar80FxGLH7TRRimD+FCTkuRiFfOwR3r88KO+MjuLbY5CJKNzUEN/H9CvCyUt6Pp4ULo3CosWJ6D8vPjT/oLvPHDJac0MjJtQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741965855; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OUJ5ojOh2DQGZl4efmMHMaBqmtEVmQ/TmLAsz3AkV2Y=; 
	b=Mnn0MvNjXKZWo4n07bY4Fin+L6y0I+rPeF9EkCL3TbG+GpVb7xPgQs78dam1dTfChg49QINYwrMFmgYQ7CDEu6fhFdLGeliaeSaa0kJFP3LQafvgJp6D/06jmePAq+d8BcThHlWPIcGvfLM1n82q181eQh8k4er8RwGOxiRGh8w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741965854;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=OUJ5ojOh2DQGZl4efmMHMaBqmtEVmQ/TmLAsz3AkV2Y=;
	b=ZLkJGJCl43jXzQl9mtozrGOXCEtuICvdrhvG6NDLUMPz/yoa74a5k/6AXfxUDQYB
	yZueeCPWYtY+1u1WboxlhTXBn+PrPvYnzbFNULLQfzkWDkDNQckeN7EEr9XyEGgpOES
	Y9NsgBE0dyFjlsgz56BgV0/1vIcZyTbZdqb57gJE=
Received: by mx.zohomail.com with SMTPS id 1741965853063954.058894236911;
	Fri, 14 Mar 2025 08:24:13 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: joro@8bytes.org, will@kernel.org, linux-rockchip@lists.infradead.org
Cc: iommu@lists.linux.dev, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, heiko@sntech.de,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/3] Rockchip IOMMU fixes
Date: Fri, 14 Mar 2025 16:24:08 +0100
Message-ID: <13295142.O9o76ZdvQC@workhorse>
In-Reply-To: <cover.1741886382.git.robin.murphy@arm.com>
References: <cover.1741886382.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 13 March 2025 18:31:03 Central European Standard Time Robin 
Murphy wrote:
> Hi all,
> 
> I was expecting my DT probing change to flush out issues, and it seems
> some weaknesses in rockchip-iommu were the first to show. The first two
> patches here get things working again for me on my RK3399 NanoPC-T4
> (with a console on HDMI exercising the VOP MMU), the 3rd patch just
> finishes the cleanup since I was there and could test it.
> 
> Thanks,
> Robin.
> 
> Robin Murphy (3):
>   iommu/rockchip: Allocate per-device data sensibly
>   iommu/rockchip: Register in a sensible order
>   iommu/rockchip: Retire global dma_dev workaround
> 
>  drivers/iommu/rockchip-iommu.c | 61 +++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 35 deletions(-)

Tested this series on an RK3576, which indeed fixes the boot panic I get with 
next-20250314. After looking at the patches with the full function context, I 
can't see any obvious issues.

For the whole series:

Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Kind regards,
Nicolas Frattaroli


