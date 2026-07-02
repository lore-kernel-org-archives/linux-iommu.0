Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A073655D4
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 04:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782968217; cv=pass; b=EPPV036mP+a4dZ7Cu3zhfw8bAOXK+4r23utz42Wc3hpuMBEtm+6q/VofoqU2NzwiZfmyy3w6/Ixw9y7sbOpclotYmU7NuOP6L9xfwEqpwl13vDVMcleriO4/tUDci2iy+R0lC+s5cu+vFBx2H0GhB+qkDxqdbJUoAmglnkXjSnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782968217; c=relaxed/simple;
	bh=s65isEOLkWD56800G/UwzuLsNE2vVm3cYxQLdhlGrm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ud6Maos6AUxPEvZ1QlCVnzI6nVuQf4I7mjJ/sMr94+Hp7cDeGyboVMehi09vxauQc0Tem/AoiX6fCsefAo/XEIg75ZyhUjpIqz7u4XKCSVS00r3bWukgQ5B6FkvdsFsGbY+DXpkDQDctD96BcYE+pOHc17f26bEjFoBxnVpecgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qL4BkIkR; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qL4BkIkR"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aeb688ae83so19477e87.1
        for <iommu@lists.linux.dev>; Wed, 01 Jul 2026 21:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782968213; cv=none;
        d=google.com; s=arc-20260327;
        b=YxfIEfr6v9oyhXilABKJN9z/0jeCfzJIRXMxFvsWl+ABa/D3YAYOqpg2i3gA1ZBQBI
         kmcndQaESAtRA6u5rywHY0udYJ80EYnDpH9STw1fpibJ7TceNO1iCiPcJjxEHC34L0Pe
         ybEzXK0unftxWF7WsCQuZDJP6mNhE6EUm49sCHxcXahpaqK2qtEQ3vvo2jx/3GeqbuS4
         PNDHOHZQBIUSjxgAUudpZHEPSPG5U90MGTqkbDk9D+6D6kCavqEiiAfMNkayJdwYsUVY
         G6kcwbRfGmsXzHNE+4lkQrvDkNCtEFclWF4/ZgPyXXnSZEDDQH5M54d3YBom2I4gmdQg
         EaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R/pb0b0doa3XFteGoKySEQfP8Mo6hx3U4+0voSqDAH0=;
        fh=wss6+ABSJH4jVaMeagJeAMH7jnQi8Ua6wVEhPuxLtgE=;
        b=mrEGyKqbcI4lsMwxy6C6umm5LFqWhvasrPYxIuiubxubGfLuZnNJeHpdR5FAR/teJl
         aILznXR8Ica8DdglSs8m7s+246SgkYtygXjKz9y4Vspb492D+PKJRSw20qCdwDXfiwcw
         Il3lmO5+lfHysacEWxko/SN9RjmS5g+EwDOAROmXUWTDh8a+9xrLh6RjEVZhbVwSFntD
         QdEKMluY7TWyU87CkdkKAss0ICYsZMBehjEtx2U8OzQdsqnc4nGJUFHEJEFONBzEGcNU
         fs0F3ghxgJd+H0Nq3Wqoh+C+tV5aoOniYmbqojZSsCvKz/ESYNZrjyXqLRYzuicE+YRc
         t7JA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782968213; x=1783573013; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R/pb0b0doa3XFteGoKySEQfP8Mo6hx3U4+0voSqDAH0=;
        b=qL4BkIkRa7XP4f7p55lh6mmc5TRMDaTRAUUg9omS2WsCFrDBytEOaHMEYwmDnAu8a8
         KWIJttuiBG6AosC1ykJnw2EZmdjVc5ABcN0BfL/hOL25AIA8uQTOvkfL1SgbaiMONKYv
         XF99OW6CXo0sDc+Q/yp/d8p1c33DoY4QEbxNzGEnNb+n7sdINLfxDSWDktcfnNhY0+I7
         +NbY2V+pCEBO99VaFA9M8H4nXxfVqaL8RgCwSq/BqypMQ7g0ZAdV377MfaAtAxiyePpa
         fKQIPMGv3ffooenwuAoXg72eJHg9tz7qV/SzxG8cUuT4pcoouybRBlS3tAuasrJHuGpl
         XenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782968213; x=1783573013;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R/pb0b0doa3XFteGoKySEQfP8Mo6hx3U4+0voSqDAH0=;
        b=gAfL+2fzs9qhMuF9626ysjMicuQZX+tNQkjFxNkQf1ghE/eCtc2Iphywy3UXYBBhNp
         njjVgLVJu5s3AzKdKFHFgoWpC3iCxlGTIn9qdSqQHiY3i/izklm3SbSMqBtrQqc+PD+l
         SFKJkMc9F2H78L9mWvuDSFTD71KVbaNst0+SSaMS6Y6/smn22ZlPTbM6f4ZbzZShJcQF
         aq/lQZhl1dMR48ZkCaf6JNecNIQrkThwFwHlCT16a8MfHFRsicYMU9waiaJV89xH5ASp
         IE0q6qxRWGTRXyVckEwI3LoTErlmqMfmcvaIZtZKx6w8rvGtiun1TstCvVMXFvKtpMV9
         vWAw==
X-Forwarded-Encrypted: i=1; AHgh+RokejaBW8WsaB8UepY5DjOpNjWi4EVkx2aWjZ2OMyuDEIdV5qnw+NVkLv37ZXk+Gyf9QzIYag==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQ7RjP5+qe+mZT7L2xDN4N10zhuOngunvQr9tpqPTj8tFn5Dgx
	vDgFHJ5okysAPmJQ9swagHvLEsSJYWHJwH4RknIO15n8pkRXe1ebm7QVtKu0kDzVSGXd1Y+xcdv
	QRnOpdLlbJ4J7IOCKvMra+YdEBKRptQh4889czA4=
X-Gm-Gg: AfdE7cmv5d1RDU3FBqEOtrid2lr8Ryhdnm7GfAR75SAdY88NfMYA/DVZ2nYxwJqib4P
	SlttKD/ofBckuiRu9sLhZEGqjqzc4Sh3dGiz3MCk3+jC+dYI2r+WCK49T2y51o4NvCGS20FDYlv
	c5wYI0nO1NXCRxFP6xxCk5jPLnhXEesT7WxNNnWOY1ktGt6BDbNoCiN5jOzW6Y7NND2tJByZNKV
	mS9lkrSMavoPA3QUhVYGCtrq97RzYWJQFMyV6Dpq2rPcZST/THm/x4upxchXNALdnA4FuLyla5m
	EgWO4JcvbfT+s/D/zLbwJOIjTzjKiw==
X-Received: by 2002:a05:6512:2243:b0:5ae:b843:9470 with SMTP id
 2adb3069b0e04-5aecc237a55mr33635e87.5.1782968212825; Wed, 01 Jul 2026
 21:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260621222130.1667453-1-xuehaohu@google.com> <20260623015459.1153884-1-xuehaohu@google.com>
 <20260623094446.4a8fc2ed@pumpkin> <ajryxMaT5evDUxaq@google.com>
 <20260623235350.6540eaa2@pumpkin> <20260630124252.GD7525@ziepe.ca>
In-Reply-To: <20260630124252.GD7525@ziepe.ca>
From: David Hu <xuehaohu@google.com>
Date: Thu, 2 Jul 2026 00:56:40 -0400
X-Gm-Features: AVVi8CdtQ5k1Gu0I7l3KP5nC_hRlM4qrUkGZrb3FkW53eA2H-q-z2clu4KZkrHc
Message-ID: <CAPd9Lg9uY1RZvYUtcbKUg=VdWM61M2f3aqmS5veUg_8M_Ce80g@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Laight <david.laight.linux@gmail.com>, Pranjal Shrivastava <praan@google.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
	kpberry@google.com, chriscli@google.com, sashiko-bot@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 8:42=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Jun 23, 2026 at 11:53:50PM +0100, David Laight wrote:
>
> > > If we restrict incoming dmabuf transfers to fit within VFS-centric
> > > limits (2GB), we impose unnecessary overhead on the RDMA stack, forci=
ng
> > > it to manage a significantly higher number of memory registrations. B=
y
> > > cleanly splitting these massive contiguous device buffers into
> > > page-aligned SGL entries, we directly improve the efficiency of P2P
> > > transfers and memory registration.
> >
> > But a divide by '4G - PAGE_SIZE' is also non-trivial and (I think affec=
ts
> > a lot of io) when the quotient is always 1.
> > Splitting into 2G chunks is a lot cheaper.
>
> Doesn't matter this isn't fast path stuff. It is better to use fewer
> SGL entries, IHMO.
>
> > > Since this change doesn't seem to have a negative impact on standard =
file
> > > I/O or break existing VFS constraints, I'm curious why we shouldn't
> > > support splitting these >4GB P2P transfers? Am I missing something?
> >
> > I was only wondering whether it was needed...
> > It does bring up the question of why the >4GB transfers even need split=
ting.
> > But that is another question.
>
> SGL can only store an unsigned int size, so any large physical range
> has to be split down.
>
> rdma now a days has code to process the sgl and restore back the > 4G
> sizes since mode RDMA HW can accept that.
>
> commit 486055f5e09df959ad4e3aa4ee75b5c91ddeec2e
> Author: Michael Margolin <mrgolin@amazon.com>
> Date:   Mon Feb 17 14:16:23 2025 +0000
>
>     RDMA/core: Fix best page size finding when it can cross SG entries
>
> So whatever this produces needs to be compatible with that to undo it.

Thank you everyone. It looks like most open issues are sorted out.
I'll wait for maintainers to weigh in before sending out v3 (which
will remove the type cast for min() per David L.'s feedback, and
revert to ALIGN_DOWN(UINT_MAX, PAGE_SIZE) per Jason's feedback).

Hi Jason,

Thank you for your feedback. I took a closer look at the commit to
ensure compatibility. This patch is perfectly complementary, and
actually prevents a failure in an edge case for the latest
`ib_umem_find_best_pgsz` [1].

Regards,
David

[1] For dma-buf split with `0xFFFFFFFF`, in case of a discontinguity
in later buffers, we will hit this code path in
`ib_umem_find_best_pgsz`

```
if (i !=3D 0)
    mask |=3D va;
```
(*After `va` had been incremented by `0xFFFFFFFF`, due to `va +=3D
sg_dma_len(sg) - pgoff`)
(*Which will set the lowest bit of `mask` to 1)

Because `count_trailing_zeros(mask) returns 0`,
`ib_umem_find_best_pgsz()` will always return 0 in such cases.
