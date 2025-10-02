Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1422BAF7
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759449432; cv=none; b=cPNZcMHmvL8wmb4X8b5EBeTwZILf2aJQ3HYGbSQebjDym/3vOvPnt4FZmmo0wxWaraKaaRfcREQbBy/Xmn3nbjHMtWnFyRvYUHytgEUXurFBq86Cl93AAhJf9iCoiv7dL24wZLRQmxf5DZwVX8UsjeQoFTkXboWmgY9Qftt0gOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759449432; c=relaxed/simple;
	bh=6DYQ3CsM0QwlUcHSns62zmWuEfYU/yp087Nd6+EjwJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y55Nq3W2ipmfxdw4UGdcFr8QRsGT+p5qVQfxwE06ZN4EKSJ+JfoRCC6Ycr3ghSQ1AvPKMPgVfasgiEGA0dy+qysP/Ja7QTguOFORThwEFNSqQt83u0WibcyUaBi19/rx31vuQa0EBqgoxeb9tdbB2GmBFTqpwKp5Ekd3kcgR/ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dAD46OdO; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dAD46OdO"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4dcc9cebfdfso69501cf.1
        for <iommu@lists.linux.dev>; Thu, 02 Oct 2025 16:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759449429; x=1760054229; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DYQ3CsM0QwlUcHSns62zmWuEfYU/yp087Nd6+EjwJE=;
        b=dAD46OdOIuVrjP4wEeFJKBN6PFhwB7yzmdzJAdy2dmbbn8zb0AIVvsOqC3o+NvoVmM
         o0lgWDc5XOrFLE//XF99kThdWrHgtue9grWF41hHiWuVg1uxX0CYvjCs847F4xE5mvmk
         qUfYkEJ3Lr2IX1jvVAf2rPBPOKqxqHhyXYCYScLejqxMGNx54kRl60WJr/8NDo/r8mB0
         41Qg8kAew4/8eUPgftgPtjVQZeDAHZStjaQp8GP+6ITqmx6vNT2zM5NkQPdjBF1R7Y4p
         Q0J7bIjcvh+/6WsfOQCuu5oB/yrujRs3QshdDxXgY8lqOlZzP2uPjxMOENVIeyyym7Xc
         OIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759449429; x=1760054229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DYQ3CsM0QwlUcHSns62zmWuEfYU/yp087Nd6+EjwJE=;
        b=hrpaF+zFasygib7Jnknvnx+OILQz0YRLD087smnlwRb3WW5dX5TxoIsikgueB/6cTK
         kMZJc6ohmB4HQ2s04xA4InhrGshzV1YJn46f1rb97OZOKFcretPNVEW9c2Tjq1U042tN
         MxutoZPP1A7YtKjiibzxGP64+1CojHskBTeg93gkCEFVzwDb3CE/45fgETMdmyS4vMQT
         8t2ZxWM2gBpKzJ/fI+1whCrqryLi9jeF2e2trWSkTx+aAMP9+dXLWd9HltKEzsDPA7gB
         VtVWyT5NG/efWKN83OztmHgShKS8owrcrx8rnJmxliwMOT7UmN8tgoh4OUBdw7e965ez
         e0Nw==
X-Forwarded-Encrypted: i=1; AJvYcCWK3MUYj8mzGT9dwFH0Ykn7SyTCIaqI2MwDXrz/N9o+0NEICBebJXgTSGr0oUTuFpBI9Re+UA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywq8dtFX7iAWo+mWEEGgjWbyNnmxKvhE1BH2v2iFxMeJPxWMOMo
	0NFcOQdnweDurzaiJSihxZs2rggHgH2loyUcUbAtjU9BzdcYlTShCZMNkaxULDNQp8Glr7zHisB
	NGoKk74h5alXH83aWfX9T0AiOVHFyRmPosqq51yY+
X-Gm-Gg: ASbGncsO724cWaEPR2UafYRxDNanv75XmUAJ8aY3Oid3FCbZn1vV9jzsqopvbZqHfif
	Hj8XVaJ1NcL7i6/FrbkrFQ5m3wyy5xrb3idMDlFW18CWwHIyj9n6+9mWHGReusutPY5FWurOr6V
	lTll1NJhTdPPJHjRHZ0xTR4a/j5u9qxvunLhVCj2y9XSkBJvxn2YgHGF2LVLxzbzaDGYF43qBKX
	PSwAsgPY6eNWFFjc/+B3hB9kpF8OLBIDDZV/XOsj1mg2w0KEIqU+6S4d/Olw3E51cDLpxqb2fqq
	N0E=
X-Google-Smtp-Source: AGHT+IGr2ovY2PKoHH1pUShHgVnHK4SNmDcVHy2Pvi/heXQZDU5vNspYDt8i9ng4dAFLZKDUgXguuJTgTwstmdMpOrI=
X-Received: by 2002:a05:622a:9005:b0:4e5:7827:f4b9 with SMTP id
 d75a77b69052e-4e57827f4e7mr757181cf.3.1759449428869; Thu, 02 Oct 2025
 16:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250930210504.GU2695987@ziepe.ca> <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca> <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>
 <20251002115712.GA3195829@ziepe.ca> <CA+CK2bAudSHq2t5NZPBKDC2wfzsF6SSxTF7aZ2kxueOTzWYcfg@mail.gmail.com>
 <20251002151012.GF3195829@ziepe.ca> <CAAywjhQGQx2_2X8r0rf3AgMDbJj-9C=9_1a3xgiLwuzKLAvXCQ@mail.gmail.com>
 <20251002211217.GI3195829@ziepe.ca> <CA+CK2bBJ_RoRuCxiHuraDH4Gya-ZON3S6PE9PgPfsxObvBRY4w@mail.gmail.com>
 <20251002225834.GJ3195829@ziepe.ca>
In-Reply-To: <20251002225834.GJ3195829@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 2 Oct 2025 16:56:57 -0700
X-Gm-Features: AS18NWCWM0pP6cWdsNU3tiI37HhQqHXT3KVR39h8qAlDJKKejqt4C9jChSJRnCk
Message-ID: <CAAywjhS77-Kw7GVgksimZ8-Oy+kSvCPpL8xQfJt0eQHwf=WH_g@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 3:58=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Thu, Oct 02, 2025 at 05:30:53PM -0400, Pasha Tatashin wrote:
> > > Maybe finish is too broad grained? What if each session had a finish?
> > > All the objects in the session are cleaned up, invoke the session
> > > finish and the memfd's in the session unfreeze?
> >
> > All sessions have their own finish:
> > https://lore.kernel.org/all/20250929010321.3462457-15-pasha.tatashin@so=
leen.com
> > LIVEUPDATE_SESSION_SET_EVENT
> >
> > Each session can go into a "finished" state independently. However, I
> > am still thinking about whether a dependency graph is needed. I feel
> > that if we require FDs to be added to a session in a specific order
> > (i.e., dependencies must be added first), and every subsequent FD
> > checks that all prerequisites are already in the session via the
> > existing can_preserve() callback, we should be okay, as long as we
> > finish() them in reverse order.
>
> I don't think it is quite that simple, like "finishing" an
> iommu_domain cannot reconnect it back to the memfd. The only way to
> finish it in the current sketch is to delete it.

Agreed. But I think we don't need to reconnect the iommu_domain back
to the memfd it depended on. All we need to ensure is that the memfd
remains immutable until the new HWPT replaces the old one that is
pointing to the restored iommu_domain. Until that replacement is done,
iommufd's FINISH callback would keep failing, which would prevent its
dependencies (like memfd) from receiving their FINISH calls and so it
keeps them immutable.
>
> So if you have a notion that finish is disallowed and when it is
> actually finished maybe the order doesn't matter?

I think FINISH for FDs in a SESSION is not atomic. If a dependency
memfd gets its FINISH call first, it might make itself mutable before
the iommufd FINISH callback fails because old HWPT is not replaced
yet. By then, it would be too late; the memfd has already become
mutable. That is why order would be needed.
>
> eg it doesn't matter what order we unfreeze memfds in.
>
> This sort of assumes that something outside luo is still ensuring that
> no disallowed operations are happening to the objects. eg nobody is
> trying to ftruncate a memfd.
>
> But I don't quite know what other objects besides memfd are going to
> have this special frozen state??
>
> > There are two issues:
> > 1. What do we do with LIVEUPDATE_SESSION_UNPRESERVE_FD ?
> > We can simply remove this IOCTL all together. Stuff can be unpreserved
> > by simply closing session FD.
>
> This is for serialize error handling? It does make sense if some sub
> component of a session fails to serialize you'd just give up and close
> the whole session.
>
> > 2. Remembering this order on the way back, and since we are using the
> > token as an iterator, that is not going to work, unless the graph is
> > also preserved. However, now that we have sessions and the token
> > values are independent for each session, I am thinking we can go back
> > to the model where the kernel issues tokens when FDs are preserved, as
> > each session will always start from token=3D0. This way FD preservation
> > order and token order will always match.
>
> You could just encode a preservation order numer in a seperate field?
>
> Jason
