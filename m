Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98C3165F1A
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 04:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051920; cv=pass; b=Dm9r6bW6AyaoHK8j2EojDMsjZCfYt9h2aQFJ7n6rOIHycE762THGAiozxwyVLLxvHWwvSr4TQQH1VKXrgI6LGk2zU1hGeoEKVt05AIvl8KXhDC4MmmSdygjng7yb3zq8TlwgUphHNCFlAvy6qbJQD/Kydm1C3l2qq+G+v9Vd0DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051920; c=relaxed/simple;
	bh=lBh87CRQVK/bQItX2JEUtPyQ2PHFCrCkEVZmQXZdgXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tC8m5koZnZrMcoaUocX3mA13BQIuOf0K+mzvtf2CDvlW8N9n2uLTJI+c+kLfB7cDuHfvxVtSGLPV4ezm1vKpzDdeZyp6t4i7tJcnn3qhwi8yr0K4jw/vRgzQqFzJoP25F8+pzaZY2eB3NC85neqUis6pD3H9AkaJ2OQ2Li1TKSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mk4jozBb; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mk4jozBb"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aeb688ae83so32966e87.1
        for <iommu@lists.linux.dev>; Thu, 02 Jul 2026 21:11:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783051904; cv=none;
        d=google.com; s=arc-20260327;
        b=YCbv5BwGonMntw1bNqlWduYjZ24QJ7RVuhIzn4yZwv6Wcm+4bIiAMALiAzcbrcRoGF
         Gfpuml7lYUnaCn0OEEyiCNOqf+hD6F1YW6ZgmxhDt2JgWhLLuNp0OWgqC23VV+WAyYEi
         nTdh5NoWuBmi2qzjXXyxjk8AaFvg6pceE/N/fMlk1thHS9DWROexMsEOKQe0nL3c9zcF
         GAy45Rxzt1zVao7D17IsKt7hPMySZsgnYgh1ia9T3XPTsSx1OaADLioA0mlqlMthzUsk
         ChOrP5gZXySY7rcEhfEPqZpSDan93eKc0NBLll0fTJzfhHo8ugTd6VIZqXJw5y6HEike
         v2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mYG5gbdqiZUgRx9K2qyqNMU3tiBr/+AhYbboeAOaEGY=;
        fh=tHZuUmE2R5XBqIqMVhxzHY3D5V+JHM+oClRTPAnbdns=;
        b=VLayWSvYLf6tCZgf/2u7IzsdG4b+lCFapzPdUkUrhgFhq0kRjUfkZ++iiwBtWWvZIb
         fir5dRD19dfIzFhNxB7qu+QkpmcvHTHrkxBWnjSFzCCsE73KbCEPm5YBe6LMFt1rp+1O
         BJCeGlceB7ApAIvYO6l0HMX/Li9IpKCr7cAYEqccQn1Ecp0YKQ8XelnZM5pKN2tyASk3
         pDEy7MVJqtfkPMmkmoyig84O4VGqmVfenNbWFC/JZnntr1vGEqaO6QmiuME4nDpV7ojh
         AWozm8wxNaST4v5iDFn/LAF4DUDdJu5vKB/osOgw6RrPys32bSPSadxUZVrR92XDURRl
         Xl5Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783051904; x=1783656704; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mYG5gbdqiZUgRx9K2qyqNMU3tiBr/+AhYbboeAOaEGY=;
        b=mk4jozBbxiOJ5aAFWbt1FFgsWlRxCYTKmBrnVcatl8X9dhvCosIMjB0TjxU77cmrYd
         801ZZHYYkcZxwgZmfGoVHixTURdrR6fiMIN7gy3PsOPwBJ5HaqdHU1Zg5SsUYm9jEV7C
         Gx9fXjWLhcajeIcjj+McJzGM4Yowj8xMkxD+3TToFy1wXP5v4QctAUWOkyqyj/zS1pyy
         IQBDzP7LWbSTYvQlPPUUZJ5yPekso5YNogoK977UiZoGkX+oipY/kAnCIy9dibvhIbQQ
         fIzjF3tFAurpkvnXEds9tAQyBeuBIgAWT8n0uNOxsj4gjJwYw7UzGuR+3Fj5QfnLwoP5
         jZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783051904; x=1783656704;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mYG5gbdqiZUgRx9K2qyqNMU3tiBr/+AhYbboeAOaEGY=;
        b=Iz0i9XnMVvJMP18+n/ngUs7ET68+SsUsOHQONwjd/tI+BfgKEeC1B5blSUw5OM0AzF
         yOe58h9LAZdvx01ztmrZidCwn6O5Laa01PSk6896LuRLzplTvCwwWy6wZDGDjGzoCQ0w
         BO5vRTd0Z4acSG/5i5An65n9j3MRxPcFcvubYEejEB6ImbXOw7jqnIKApgaK7yjKm6ey
         h11MH8x+LqmriySg+SL/rdMeZWyNJGbVWTlRf+NJHakfow0bYNnbxo0slKHnRpXMZjZ6
         tEQ8YRhAfzmY2VZlxi7yZye2IJKcHZo0uJ5Ss33Vuy4eKsQdl25kpK47hewuYmFjQ4q/
         4q+A==
X-Forwarded-Encrypted: i=1; AHgh+RrZPedVGphXHs0qsdXd/TxmAuQoHvr3VOWAiDw8pxa4kaR+d5MiyOrP6ny2VxV+fXBNAELstA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3E0qKWds275e7DQyK0QLearbUEL/i3OAyM+yL+VVAOXsWZ4vq
	4vsuRcLNsn9Rkt7+1HaIfHO18Yir9SSSkl3UPN572IiSi02WhKvckjnLbcLgEdgW6aJrgC09mAt
	FTI+FeZg1uYv/C4SzfvVwq8K9UO17S0FzttTXxAo=
X-Gm-Gg: AfdE7cm10TN5hd1K9b3PEle1lUg9Qegn45fHVBYrPsTxik9bknnBbKFGaMeDRQO0xhw
	NS/I/1H2tCRJ79MtSGYoLk9m5oiwTRf2siDbKhltJfjjwHvaBbbeRQE8dubeRlNe3KvoAJbuPsA
	hNiu2BGoqSQkg2+gc0dvyv8L6BPZTYlxoGIymyZ49DHdEKHLnIkFrZEhpkkj+htYZSxAVANGEnN
	HQR0H1Bs2Amncro6Qs2HwpmLX87RZGEzIMP3oeY0d+j/XsIAZM/jMZiIabpPT1WZHuRnh1JRLWP
	HftfbxZtGyKogG98csuDYcQGpBBhaA==
X-Received: by 2002:a05:6512:3b0d:b0:5ad:4a8f:58ed with SMTP id
 2adb3069b0e04-5aecc237342mr247261e87.7.1783051903965; Thu, 02 Jul 2026
 21:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260621222130.1667453-1-xuehaohu@google.com> <20260623015459.1153884-1-xuehaohu@google.com>
 <20260623094446.4a8fc2ed@pumpkin> <ajryxMaT5evDUxaq@google.com>
 <20260623235350.6540eaa2@pumpkin> <20260630124252.GD7525@ziepe.ca>
 <CAPd9Lg9uY1RZvYUtcbKUg=VdWM61M2f3aqmS5veUg_8M_Ce80g@mail.gmail.com> <20260702091040.35eff00c@pumpkin>
In-Reply-To: <20260702091040.35eff00c@pumpkin>
From: David Hu <xuehaohu@google.com>
Date: Fri, 3 Jul 2026 00:11:31 -0400
X-Gm-Features: AVVi8CeOojzP-I_HmExSVQqRC_n17UpgYFkRlrxVBr237r7JGuzRVJ9YNtE2VWM
Message-ID: <CAPd9Lg-ti9hOr4-62xExbNuBJ1fmnhg_Vi1uxFZ8h-9FoeGAnA@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
To: David Laight <david.laight.linux@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Pranjal Shrivastava <praan@google.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
	kpberry@google.com, chriscli@google.com, sashiko-bot@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 4:10=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Thu, 2 Jul 2026 00:56:40 -0400
> David Hu <xuehaohu@google.com> wrote:
>
> > On Tue, Jun 30, 2026 at 8:42=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > >
> > > On Tue, Jun 23, 2026 at 11:53:50PM +0100, David Laight wrote:
> > >
> > > > > If we restrict incoming dmabuf transfers to fit within VFS-centri=
c
> > > > > limits (2GB), we impose unnecessary overhead on the RDMA stack, f=
orcing
> > > > > it to manage a significantly higher number of memory registration=
s. By
> > > > > cleanly splitting these massive contiguous device buffers into
> > > > > page-aligned SGL entries, we directly improve the efficiency of P=
2P
> > > > > transfers and memory registration.
> > > >
> > > > But a divide by '4G - PAGE_SIZE' is also non-trivial and (I think a=
ffects
> > > > a lot of io) when the quotient is always 1.
> > > > Splitting into 2G chunks is a lot cheaper.
> > >
> > > Doesn't matter this isn't fast path stuff. It is better to use fewer
> > > SGL entries, IHMO.
> > >
> > > > > Since this change doesn't seem to have a negative impact on stand=
ard file
> > > > > I/O or break existing VFS constraints, I'm curious why we shouldn=
't
> > > > > support splitting these >4GB P2P transfers? Am I missing somethin=
g?
> > > >
> > > > I was only wondering whether it was needed...
> > > > It does bring up the question of why the >4GB transfers even need s=
plitting.
> > > > But that is another question.
> > >
> > > SGL can only store an unsigned int size, so any large physical range
> > > has to be split down.
> > >
> > > rdma now a days has code to process the sgl and restore back the > 4G
> > > sizes since mode RDMA HW can accept that.
> > >
> > > commit 486055f5e09df959ad4e3aa4ee75b5c91ddeec2e
> > > Author: Michael Margolin <mrgolin@amazon.com>
> > > Date:   Mon Feb 17 14:16:23 2025 +0000
> > >
> > >     RDMA/core: Fix best page size finding when it can cross SG entrie=
s
> > >
> > > So whatever this produces needs to be compatible with that to undo it=
.
> >
> > Thank you everyone. It looks like most open issues are sorted out.
> > I'll wait for maintainers to weigh in before sending out v3 (which
> > will remove the type cast for min() per David L.'s feedback, and
> > revert to ALIGN_DOWN(UINT_MAX, PAGE_SIZE) per Jason's feedback).
>
> Does this code get used a lot for 'normal' transfers?
> I'm away from my normal systems and can't check.
> But if pretty much all of the fragments are small (< 4G) then
> it is probably worth adding a check for 'size < limit' before
> anything else and optimising that case.
>

Hi David,

Thank you for raising this. This file (`dma-buf-mapping.c`) was
recently added [1] to exclusively export MMIO device memory.
Therefore, it is bypassed completely for `normal` transfers (IIUC,
e.g., video buffers for V4L2 or DRM).

Regards,
David

[1] https://lore.kernel.org/all/20251120-dmabuf-vfio-v9-6-d7f71607f371@nvid=
ia.com/
