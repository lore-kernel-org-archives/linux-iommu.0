Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156C47F2DE
	for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640949; cv=none; b=Hw/B5V8adj/QT7aMGmh7VWlR/N2+AT1yEdTeqAhg1c2vVxnIRhSrzAsL+wPSfdFvVYV+GxZxImpkpjKXq8IDxojo7dPBxm0inCEB/pdqORtA9gqMgjfwAcVfxCFw22wicJfHxJ0J8V3M6cIOXAwJKZXj9ktwvPvAlPtP6iuoZ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640949; c=relaxed/simple;
	bh=pjp/OfeQHhVWdT3jgV5w5E5OgdF/qaSYH+WqNsGsneI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaS3gAyft1sW8mC0tr8ku+az8Qk3lXoeHaoF7y45XGenvNS59aCDweb86BoOuhkkdDJxUcsl8T8g4ZtRA9LglzLp/7sbxqKn559P92hYMoDbJ7O3j0MZyLgjPO5p4Z3gydCtt6y0DlJ7ExkiMzjirKuGGo+uIK0xUxrBix/4+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Cqwxuh8s; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Cqwxuh8s"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f186025973so759286d6.0
        for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 10:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786640946; x=1787245746; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nYcDUJGUC25Nk5HBlqapVMecG82Gc8I0/R2s4LHak/k=;
        b=Cqwxuh8sK2dUMX3P+RQLRB2lJcMW0YBFKd+T/9gf1/7PfM2fP6EHk/ObtSfZfChiu/
         BFvT8K5IF1YdB3QvpUSdZyF96ZFhbnt3FsEu7RiEEbSiOxD+2+ozvGhGugusPYRFgb+q
         o7/1VMqMz2Jbkz3S1oaqlHM30aTbRJtY8M1Pbq6/llNrSKwHeD00dJJxl/DhX7eYHHct
         2hza/tg/+ddVKPk3k3SyzWueCQLeaXQVpcKvBSLFE0g38jafPPFblklgfo/sWS4zw5og
         VLWI13r195Oe7742YrMX9122pF7/JAHYrPlgU4NoXJ5XlwPzwzt/a887psuJy0kud8Q8
         IkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786640946; x=1787245746;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nYcDUJGUC25Nk5HBlqapVMecG82Gc8I0/R2s4LHak/k=;
        b=rIdN67nEOARwwAEJPHamp29U+Zaxb24EsC5v2Af91tIMhTz/Oxfo8NXeEYghRAlYuj
         +hJidnnrJ+oqEbf7eQA9nqT5OrixFDrx+PqI1Pvc6iFJxSu0KEk0+/LIzTNf+uDtNvTc
         43VYcMQsnmNjqPpUvBI6sxz9GHuI/MkNRSzwDizQZeOU73p/8mwDIYCOFeqK7cGrpaP6
         S6lKoGToZdImP+jFL5CAUcEz8ymgq/eQZiiHx+F+XsSY4gKFwbltpRZK9jgduy0TSuui
         g5LS95ISSXgsnuwvTf7o/Y1I5we/jkjH3utjajhI56K/+wZ5L3Zen4zF26UneF++uDvY
         hLcg==
X-Forwarded-Encrypted: i=1; AHgh+RqYtGa/ZYyWESuRHfkoX5P5z17WHcydyw1jiPiwIUGTAjMNZdVq/o+RcONYt0sOEjmji6CGiA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw433h3tseUkF1sLxXUY9CGpGY2+rotaBr8uMrlLchOXQZy5ZZn
	APK9dbIZAajRaibRjLJkGFzR+Wh/jfuuz4Vv8y2aa8Jy8uBwTiHjjQZAlj5/ncuP6So=
X-Gm-Gg: AR+sD10SCK4kO1grTAFAzGM3WMfYSJYWtiEiNAKgArxAU6GY/am9q8u9+mjuuxR4USR
	44EpoGgoLgEtCyN5W70oNvpGpDB15ymNCW/xHVXWiJ6yGJ9nfezIt+/H+Tf5wJxxSpHJfyXICTH
	Hvr3QMf5mQ6RAXMagPk8SxqLBQZqDGEtYele27SISonvMpjL2N7xcgkAymClMWrbSyK6fiCMUdj
	DdTCDgLPuiLWingH/lnnY2fdYKq3ZcR8QZiNwbIpkg6zcbRRXkR+m0FBcigdyf2TIzNx+UGDtTY
	E0T45mHjnSTpfeuHTv4ZRTh2lW5Olw+jv0QL+cO4li1ccZ+sxcfHxSvgYVSWDP1msEnzKgW8uGM
	s7ghyUzWiXpPMsZRgK/P0atHRIR9YLvWTWCXP4Nxf0qRd14wUJ7ULejjKzkiBok8T1u53sPjv2J
	iq75JT5SpUl7eG5uqDP89olrwyLJicTnKLPZ5udw==
X-Received: by 2002:a05:6214:c44:b0:908:a729:73bf with SMTP id 6a1803df08f44-90a80c2d2e8mr89485816d6.22.1786640946476;
        Thu, 13 Aug 2026 10:09:06 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a81aba12dsm19266596d6.45.2026.08.13.10.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 10:09:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wuYvR-00000003rjv-11eh;
	Thu, 13 Aug 2026 14:09:05 -0300
Date: Thu, 13 Aug 2026 14:09:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: syzbot <syzbot+90c2d711b5218d10ce61@syzkaller.appspotmail.com>,
	baolu.lu@linux.intel.com, dwmw2@infradead.org,
	iommu@lists.linux.dev, joro@8bytes.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	will@kernel.org
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in free_iova
Message-ID: <20260813170905.GB905583@ziepe.ca>
References: <6a7910da.9c11d2ce.289b96.00da.GAE@google.com>
 <68eebaf3-2427-48c0-93d3-87455ff266fb@arm.com>
 <20260810173230.GQ200537@ziepe.ca>
 <6f650cc2-b4fd-4305-b4d7-847ef935449a@arm.com>
 <20260811131154.GA544626@ziepe.ca>
 <317c8a9c-3b40-407d-bcf2-02b9be1b14b3@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <317c8a9c-3b40-407d-bcf2-02b9be1b14b3@arm.com>

On Thu, Aug 13, 2026 at 05:59:05PM +0100, Robin Murphy wrote:
> On 11/08/2026 2:11 pm, Jason Gunthorpe wrote:
> > On Tue, Aug 11, 2026 at 01:57:38PM +0100, Robin Murphy wrote:
> > 
> > > But where would that unmap be?
> > 
> > If the theory is right then the bug would be some concurrent driver
> > thread like a work queue/timer or a user thread going into a fops that
> > outlives the driver remove function. That thread would do the unmap.
> > 
> > This is an extremely common bug class in drivers at least..
> > 
> > eg DRM has lots of challenges in this area if the guess about VGA is
> > correct.
> 
> Oh, indeed - I futzed with it a little bit and sure enough:
> 
> [  225.056075][    T1] [drm] Found bochs VGA, ID 0xb0c5.
> [  225.071671][    T1] [drm] Framebuffer size 16384 kB @ 0xfd000000, mmio @ 0xfebd4000.
> [  226.061260][    T1] [drm] Initialized bochs-drm 1.0.0 for 0000:00:01.0 on minor 2
> [  229.801060][    T1] bochs-drm 0000:00:01.0: [drm] fb1: bochs-drmdrmfb frame buffer device

wow nice job to find that!

> It's a well known thing that DRM drivers can't really support device
> removal or any kind of forced driver unbinding at all, as the drm_device
> can be held open by users and outlive its underlying driver, then it's
> UAF city in more ways than anyone cares to enumerate. Furthermore, a
> completely bogus dma_unmap() of the VGA framebuffer's physical address
> in a misguided attempt to clean up a doomed unbind might well explain a
> reserved IOVA getting freed as well...
> 
> So yeah, move along folks, nothing to see here :)

I was told DRM has mitigations now, but they have to be deployed in
drivers.

So this would be a bochs driver bug I suppose?

Jason
