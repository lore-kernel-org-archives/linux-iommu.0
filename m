Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781A443E083
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390484; cv=pass; b=ct4ejdigJSw6LXRrxDr4qYWCv+TEYmrg3qlU+bkVOdhA2JSbnHD9/33++JebRPXKWEVt790Zu0m4pkphqFvTNwirv4N7BJ9qeLPe60gO7YOnNHC56jt5jLRaHGigVYCCMMIm0QhtueQ6+YGxqquY7CsRvUt8ULqRk2TT0pf30yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390484; c=relaxed/simple;
	bh=qTbmbR4TV31oKppyK1FzJBEXPWjFHR9x5HM244L3neo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2ZzyPQR44WhaRkOLmjBhuhY+7YEirqbQEa+QNpPMCHSDBi2K32nS5MBRzAfIOKoBZGhVVf88Pkkh4QB5IZv3s8dNni5rAbSw/OlUNypb9LoYHcw0Khmm1KwwF0VIj10z7lVE2C4/u9YFNDA6Odg0jcEBdz6uRlAVLKCkuECEmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=x6u.co; spf=pass smtp.mailfrom=x6u.co; dkim=pass (2048-bit key) header.d=x6u.co header.i=@x6u.co header.b=SP6+eISI; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=x6u.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x6u.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x6u.co header.i=@x6u.co header.b="SP6+eISI"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3964e76d0f4so2009583a91.3
        for <iommu@lists.linux.dev>; Wed, 02 Sep 2026 16:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788390481; cv=none;
        d=google.com; s=arc-20260327;
        b=KCKts8N5YPW0jOpZQsDulTkx3iRiK2LHNkaG8gy/fq9x+TadtzPHWgLyuYePi/snVf
         eX4UoxomKIfKSf3GKsum17mnB+eNEevbVZhy8D4GQtoIiTTHfciA3+yY5uxMnSv6rbO3
         CDRDzthLTRxQpJML13o8WfvM2RzGWqDU56icVYEfzPwUQyd4eUt9IPTEfxPlM0aU7/EH
         cFdVTqW5BfeVI3cPg5G/oicZLXYUtDg0gi9nHls88MF7zIpWoJfN4SrGWtIQt3+XUyP/
         Kd/kp9fXTcDdWXQKSgvWaLrp1aQvqEEx2RJfHD6aNKg5Fd8MPE5o0u/NZ4WH7WnP3BC9
         dWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qTbmbR4TV31oKppyK1FzJBEXPWjFHR9x5HM244L3neo=;
        fh=ExxGPVZZcCSwYwpFzhC1SdnFxiYk8sWn6cxzGrMyM1g=;
        b=Y5kJ8BalYqp/teFJgqvuyd+Ys2SgcOwaIho8gRHbIoL0t3iv04b9IUq0yGxbGxMdcd
         jjNb+roWWH073EnOABMAFvv685DzbfKd6VkfKqSpvYGbnvSv5hJ6kuIvd8kkyyYhcBtI
         o4538g0TS8g9lisPY3cs79j3Ajz6icQ8jKM73tnqd1avqGuPI1AMQ/tp88/Qq25CeX8Z
         XB4GaPG/vnYxnYNZuCAGSAg+yh7vm+tdRvmTM0p4232e3w+NDIBAMVaGwATFnAueWx+U
         pTjbq5DwqhqxamWAnMA1eY9BGY0kF1MRqmH38LyLvH+X9ylf3/VMC0KBe/KMhWmxg5k4
         vLmg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x6u.co; s=google; t=1788390481; x=1788995281; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qTbmbR4TV31oKppyK1FzJBEXPWjFHR9x5HM244L3neo=;
        b=SP6+eISINa8gFOuVVC0HKSDaDCskyMduTJ5U5w1ObByZOu064Tnd0mcPDsLo8HgKVZ
         RWRfHcQZXQOXRbFhk5/4lHxIe92XYgBM2OGTdj2u6q3i65I9kt3poDqzTzZD3BAYbdTX
         wpKzZ4pm9BqStwE6s2gyLkRnaR/0E4v25W8iU/o8hVi3nQ+hRxXWC+RhzlR3hbIULnHW
         XeCEuTbE0Ck206CgVN9Nrb5wtu8qabSGW47Po1UuFOg/tt0plEMvWU/8y7g8iHS3yOt4
         e/3esBmOOCes633xPOztNaDmkBBGZCuvLLKKTjwTw4u9NHpevfgqYEmXAIZorR3TGpAF
         zE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390481; x=1788995281;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qTbmbR4TV31oKppyK1FzJBEXPWjFHR9x5HM244L3neo=;
        b=VTBiNo9dtthrv+0MjEJj5ssWWJ0mjGoE+3sqS73LyCxVey1MNhnsKPyyfT0VeSAvwT
         VJvz4f2TvPeJ3GrXBSThw0mwUUzCCz06gX+NBiZVzi4NuAhM4LwvL6VM2gj6+Zt3SseJ
         k0/14NBMK3trQOAl58iTR7jJyNyutJ+/+BwQ8307duzE1Jw0fzvBD+vPsxKAnj7TSUi3
         6pam6fCF9yS+2pmI3cLzxbFw+HHC46UdkiY1xSMBp2Q5qEA9EtXqlLJ9Kx3gOgwNaWq4
         YYJg6/Gr55MY1iVZoSzK1UCqINDRFGzWf2jRgu18eT5vwbJHwiarpqSOmFjTwoWxDBcB
         Eo2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxOWdRdR7hf3O8y+eUQnPF23PWlLBYgb88/BrI+Y+FFUtoIF31cmo2v8chskH/LnwotoCk/9Q==@lists.linux.dev
X-Gm-Message-State: AFuF++nlhs3puMBMiykZ73I8v0NpA6CQdWs3MQgJl67R+WZ9NUfat8Xv
	auCLnc++EEQVIsP7vde9vOZIx9AOqjyggX++0T9zuv8+WS34cuQs+03Ts227flv37VufFMgo/CT
	NpcvyEvYDPMo+mCMvAhtgWwP15QW16f+B9M54nDtJC2s=
X-Gm-Gg: AYBFou3lzXG/JbxebF9MGORaVbdoGOO4LKDhQg66JAFjJvG7DblPAe8y/Vqsdou8yIr
	CrGhVkn9Xwl2hM91Y1+2HG0kop0wTSR9n6NZjLj6EvnUetKBzUkaExbBUUnY2ZKXxj6DLtkIrKT
	iNIxkX/WKDZgq7JfywT0Pavh5ibbao4ugXkeja/CtdFfVYBNKAMiud8mbxlygXvI6w9hECjK+Ij
	/9s9jLAXM1sPldz4N6a7O/EtxdJKO8JQSFPeQ6PWyZyr6cYtO9rRqS7vA+mpNHjcasIn+Zy5PYz
	GAJKPBiJsdBoMWejX+b9/tgJY3rLb7Mn61IEfIymPXubwqsYNn/ppoWmwmGawfpAZ1faSBU+yA=
	=
X-Received: by 2002:a17:90b:3e8d:b0:396:4cbf:45bc with SMTP id
 98e67ed59e1d1-39aee153e79mr9644253a91.16.1788390481503; Wed, 02 Sep 2026
 16:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260901170849.4052816-1-dhu@x6u.co> <20260901170849.4052816-3-dhu@x6u.co>
 <20260902120832.GB2890729@ziepe.ca>
In-Reply-To: <20260902120832.GB2890729@ziepe.ca>
From: David Hu <dhu@x6u.co>
Date: Wed, 2 Sep 2026 19:07:50 -0400
X-Gm-Features: AcwNN1UWr9DtGOkBk_AsJGV3X93dnPOEvrR1ndZaMb2yMaRxX36LCdah5a513PI
Message-ID: <CABdL-LTO5OKkDmtXpiLury=2n6q6Rcm42_qqz8U+JkEu=v886Q@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] dma-buf: Split sgl by largest page-aligned chunk
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, alex@shazbot.org, 
	ankita@nvidia.com, chriscli@google.com, david.laight.linux@gmail.com, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, jmoroni@google.com, 
	kevin.tian@intel.com, kpberry@google.com, leon@kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, nicolinc@nvidia.com, praan@google.com, 
	sashiko-bot@kernel.org, stable@vger.kernel.org, viursachi@google.com, 
	xuehaohu@google.com, Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 8:08=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Tue, Sep 01, 2026 at 05:08:49PM +0000, David Hu wrote:
> > From: David Hu <xuehaohu@google.com>
> >
> > Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> > This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> > first entry, resulting in non-page-aligned DMA addresses for all
> > subsequent entries.
>
> This patch is fine, but pedenatically a scatterlist's entry limit
> should be bounded to dma_get_max_seg_size(), though I don't think it
> helps this. Operating scatterlists at the size limits has proven
> problematic in a number of places already...
>
> > In addition, a non-page-aligned sgl length will trigger an edge case
> > in `ib_umem_find_best_pgsz()`. In case of a discontinuity in later
> > buffers, we will have a `va` with lowest bit set to 1. That will lead
> > to `ib_umem_find_best_pgsz()` always return 0, and break the promise
> > to find best page size for the mapping on the NIC side.
>
> That's an IB side bug, the newer logic that joins adjacent SGLs should
> have avoided it?

Hi Jason,

Thank you for the review. I think you are right on both counts.
Regarding the IB side, the new SGL joining logic in
`ib_umem_find_best_pgsz()` indeed avoids the issue. `mask |=3D va` is
skipped for artifically split, contiguous SGLs. Since Christian has
already pulled v8 into drm-misc-next, I won't spin a v9 to avoid
creating unnecessary noise on the list. If you prefer a followup,
please let me know.

Thanks again for catching the IB logic detail!

Regards,
David
