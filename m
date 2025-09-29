Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D792494FE
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759178564; cv=none; b=bE5betHQCiMOk0kGIpWB4mx3slveN76wUqzxyrbzdv5zy3ztDBVSQBVKHwzwfsA+DqNzj9mJNcU3MvJvfqvymvKACHAJ3iKSTwmjPEYPdtA/clSS+Lz0ybslc7uKivMbidY/HSApzt41RZ2W1xN1ZUtpcemlXbuNf6dwX6pRJiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759178564; c=relaxed/simple;
	bh=oXJgIjEe3L2FI9kbI9ch0+g3fkejnXAUjmTtn7Kifx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gs/zuobY+dXRw5K1mA5EOAk9LMOl5f8S92QW3Jf5jy/Aqx98cqbxFaAqY0AG121txhIT6nu/zqIZllL0arTPV90WUWI5Yjmpis7fUECW/iNDY0+9dmdpk+/pyVATT5GUUVXWqk5fsopsowfz8LZ45kqugCY1B6kg+5qurjF5hrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ZFAxasm; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ZFAxasm"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4df3fabe9c2so25231cf.1
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 13:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759178561; x=1759783361; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEC74i6THPBvyxToCwC/1HpM1gtTzCHhQKVMM5vaV7E=;
        b=2ZFAxasmAaLXWW9gwTl47NoLMuVsXdQmaqJFK8/ndHQdGI5WuUiodFklEkeVPJMcND
         5t3Dq3HhjL8oFnY5dXd90jR93lkNfZ/G/PqMAwFQDnp5BF7pYbMXzT+1uqS4SudWNc3c
         QuHeHoGevoADjRG97x1p5BvC7A2Iot605aoVD2BwusMUbnZ3oxtUWvebUCVje+ALWA5+
         DKG0WWLJ4r9WAGA148zr/AuClGk8fLRqKrbvy7PH9De9bwKpgceHMZ5neU36jNuR5VgR
         I50RyDEIVoPZ+K3rJS7MpcI0/Y16NvjxJs8SnYpOcPwXewCmfaDQxQzpeefFlkCpE55l
         zFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759178561; x=1759783361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEC74i6THPBvyxToCwC/1HpM1gtTzCHhQKVMM5vaV7E=;
        b=V71uhdFh2/0t++tF+lFf7fWmm3s5ktrFG4YSjn7UhfZxG2/HvJ0WWtkG+JqFxcDGTw
         9nhaY2N2xPa4GvBOrpY2qea/IcM0qoOkMFguDcQsFHDBAmj0ZbSGKVHLEktNLt1POA8R
         NlKbJH1hsyTXHkWVPak8r1qWoDVrod/TFY+PBWVIb8AzvPjiZ6h/jzTLYvSx9t/kXB1l
         Z/h5oogQdS1JEthtjowBwEf5QoMtJ0mqYyQIwM1BkDGVrxzDge18Ygp/6nGPMlro77b1
         ThykJ8157GJRtzzO5EV6Zc7ko1UZbYCZ6s7KHVqtk8N8Q4GJAdd4kpfSTOTACAtxeZM6
         oJiQ==
X-Gm-Message-State: AOJu0YxjbsKxXB3PKthboeFXi/9KOcAnq+gCgEbGERIvROiPujaf0sUM
	O5jOFzOkadjSMhpPvwkA+wwV6vt4p6ZYlqTrXHoXhbfv7COGa7m9htdBWI9XYOBKwVuAmdNtK4/
	7/70EDbE+qXc3aYYpkM+lVKAXXGJ5zj9D2dqfm4n6
X-Gm-Gg: ASbGncsjR2HVfX6lYwV5sBO22T/yQ7E1X9e+yzHmATeg5g/8NCuMYVnJHfcr+Yz8DDM
	vPY2Sd4tqStXpoSWiU2KGVTq8fUlHhgJfqNHUu+ioDhBR3vUOmQAvagSEsZFc9KaRUlP/dhYJ/P
	9XUNlifxT7QxNHaH6h3piKfCe/2bF9qELSkOu/aQZwHbp/Tocv6cnKLQ9dsMLeQz8c1psjtHxdo
	Wk+VXbK1ow=
X-Google-Smtp-Source: AGHT+IEwLQc5fvRUVGPyGy8NV0Qi19qFJZstfSg+2T66md9AyC2s/4sHLcp2+Hx+syyTPDNwiHIA8qqIMcHvs2IsWFw=
X-Received: by 2002:a05:622a:1486:b0:4d1:b2d0:2e2b with SMTP id
 d75a77b69052e-4e2d0df3039mr1922061cf.6.1759178561226; Mon, 29 Sep 2025
 13:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250927223953.936562-1-danielmentz@google.com> <aNrks8eXTfHyVhKl@google.com>
In-Reply-To: <aNrks8eXTfHyVhKl@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 29 Sep 2025 13:42:29 -0700
X-Gm-Features: AS18NWClVxUbv-JzilVwbpc6ZKlxzRQDsp7pvXXSKlzjb8hhrBGe7HxydTOUiSs
Message-ID: <CAE2F3rCZhgLOPKMmAqvNaQt3mUdj0kez9_MDxM3nGVOpgr5wuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/io-pgtable-arm: Implement .iotlb_sync_map callback
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Rob Clark <robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 12:57=E2=80=AFPM Pranjal Shrivastava <praan@google.=
com> wrote:
>
> On Sat, Sep 27, 2025 at 10:39:52PM +0000, Daniel Mentz wrote:
> > +static int __arm_lpae_iotlb_sync_map(struct arm_lpae_io_pgtable *data,=
 unsigned long iova,
> > +                           size_t size, int lvl, arm_lpae_iopte *ptep)
> > +{
> > +     struct io_pgtable *iop =3D &data->iop;
> > +     size_t block_size =3D ARM_LPAE_BLOCK_SIZE(lvl, data);
> > +     int ret =3D 0, num_entries, max_entries;
> > +     unsigned long iova_offset, sync_idx_start, sync_idx_end;
> > +     int i, shift, synced_entries =3D 0;
> > +
> > +     shift =3D (ARM_LPAE_LVL_SHIFT(lvl - 1, data) + ARM_LPAE_PGD_IDX(l=
vl - 1, data));
> > +     iova_offset =3D iova & ((1ULL << shift) - 1);
> > +     sync_idx_start =3D ARM_LPAE_LVL_IDX(iova, lvl, data);
> > +     sync_idx_end =3D (iova_offset + size + block_size - ARM_LPAE_GRAN=
ULE(data)) >>
> > +             ARM_LPAE_LVL_SHIFT(lvl, data);
> > +     max_entries =3D arm_lpae_max_entries(sync_idx_start, data);
> > +     num_entries =3D min_t(unsigned long, sync_idx_end - sync_idx_star=
t, max_entries);
> > +     ptep +=3D sync_idx_start;
> > +
> > +     if (lvl < (ARM_LPAE_MAX_LEVELS - 1)) {
> > +             for (i =3D 0; i < num_entries; i++) {
> > +                     arm_lpae_iopte pte =3D READ_ONCE(ptep[i]);
> > +                     unsigned long synced;
> > +
> > +                     WARN_ON(!pte);
> > +
> > +                     if (iopte_type(pte) =3D=3D ARM_LPAE_PTE_TYPE_TABL=
E) {
> > +                             int n =3D i - synced_entries;
> > +
> > +                             if (n) {
> > +                                     __arm_lpae_sync_pte(&ptep[synced_=
entries], n, &iop->cfg);
> > +                                     synced_entries +=3D n;
> > +                             }
> > +                             ret =3D __arm_lpae_iotlb_sync_map(data, i=
ova, size, lvl + 1,
> > +                                                             iopte_der=
ef(pte, data));
>
> I think we must check the returned value here and break the loop on
> error. Otherwise, we might burry a failure by continuing the loop.
> We should add something like:
>
> if (ret)
>         break;
>

Now, I'm realising that __arm_lpae_iotlb_sync_map always returns 0, in
which case I could change the return type to void. Would that work for
you?
