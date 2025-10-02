Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510C526F287
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428509; cv=none; b=VTGVuKzgqMQWZ5/tkomdtvzI/neqcEAGos3obX/6vi0HF3QMciG12sUw5E7imVVpFNBHVurkwgDb4UZ0cXCbFIbN4cGWFLb8wRq6bYwNvI3QysjhVbNW+lBB48/+bB+c2FNSOW8CuALwN8/Gc2pRv1clB6W4WvcEFckVGI3ugzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428509; c=relaxed/simple;
	bh=g38T6g1L7joJTmSvGU76LmE7YNEsX6Xc26blEFLSnfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwzdnKrShdfNHXgvbBzXWS2KA6MPxWnQvQ4+TA0hf1B6KQAbC0Sd4o6QW1jQF30fk4Hi0h3FGnOR8t1vRwRWSRu/vAuK1aVV0L8myc/65kNTd51XcCM6WHx6AoelVjImvJBAlltvVDYoQnghpB2yj7Z0VS7ys6GdRSJZewvQac8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QzAxlrbz; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QzAxlrbz"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4dcc9cebfdfso31771cf.1
        for <iommu@lists.linux.dev>; Thu, 02 Oct 2025 11:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759428507; x=1760033307; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g38T6g1L7joJTmSvGU76LmE7YNEsX6Xc26blEFLSnfA=;
        b=QzAxlrbz2+x3NaS6FY/ICYd4v5AuaMAbQO2R/JtmzcJQrGC3Zb7GEfPiIrm5eR1WzJ
         A03ZjsUicml/v5erE735DorBR5IUbXX31dXSVNpW5Yb2X93uEpiDRdJ1XWj9T8G72ZYl
         UhRvYCCZ30Bd/uYrcDU0yLqf62/EXOEFIkIkavsKJFDoDfDS6kWQ3cJ2ipX0mLWiWI76
         x7sxOEJfeiXIOEjw4Nufz9Fe/yYD7pzPUhFJkjNxL9hM4YeGF6RsSGyNv47QaG1US8Lx
         Lzc9QBz3ZXGqROAZyDohp72FmHr/O8maVW+5u8njtmQmTNUNtKmUby2qqrM1audYvWed
         7F/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759428507; x=1760033307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g38T6g1L7joJTmSvGU76LmE7YNEsX6Xc26blEFLSnfA=;
        b=h9WnX7PTFkT6Rclx5wCR02icq/ggWL46gh35FnGOnCAUTPcFbQOIXk3Q71OhEUUjzk
         tBqPQorf0thuJ5mRm7ydeRykTQjcRqERwpqqNkb92eng8+4AWGStutbJeNAp8+QHkVhr
         EvVcGhZJ8Nj6BHCruM/JgjbtaacJBzn6iBZwelxwUMnuuXoOBF2s/plxviE9RcR7zDKp
         aMi1lFK23KVUfyTe6xzBaNbeIrA+HT4ItUmwI+skJ5LflQeTvTJQLoqtGAt6lOnqSOFe
         Ony/mDlHG0r9bewN8tfVurYt3I1fLhMezTG/4TqsXgCDA/vY18MxWUciz2prKWqyEIdD
         Ib9g==
X-Forwarded-Encrypted: i=1; AJvYcCWdvbnkOq0w3jQ9wgtiPAHSQQvn8ehom7Uj8Qb+IFbT5ZB0f+JuQzhGaqMliwVEbrZsHsy5xQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4E8uBjaFjc2ITitrX+GNTisVQPlWOcPIRrwG+Y81S+vtqOmfk
	cLM6wRV0OzMTfO5TPG75+j7XKtYiOlIIIKyOewLA8vF5u6v4K+VxD7+4x6d/Wb2nuv8CKS+Hfpo
	KV0aiueshz4xAhqk/+TAa5hUQr5/zzvXQqRnDCEr3
X-Gm-Gg: ASbGnctjvAjY7uS8i0iZmsFpTOqGQC4akytEwfi+Ka5sX9+x43N7ojyT9/bJcDRR0Vx
	nicLRiVl4iR5vPpeH2cBiJLTKHbC+4oh9TMwEf6pVleHYTBvAoLdiVWRLTD1etYBL1jVr4bm9Xb
	JpqPyK7eY9oFQ3O8rrl4EetQMyHjwGgQyXxcJh0D8xrXDZcv65LbxNhCvJT/9l4b1TLZho7Qcbv
	zJLgVdpvFLhGEk7elvWsxpCYEs0vlRCz8QSlzZFIIYaA1rqJ+0qrByMfaPeU20NSlZgbOg=
X-Google-Smtp-Source: AGHT+IFgcqgS6ij+CGSYq6UnkUeAzdjMDFKaA1fGxKd4PkuuqKYQ/kuguF6nULX/Gyc2qNd4HMMNrn1RGTamPFxAjfM=
X-Received: by 2002:a05:622a:44b:b0:4b7:94d7:8b4c with SMTP id
 d75a77b69052e-4e5769456e8mr540491cf.0.1759428506788; Thu, 02 Oct 2025
 11:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250929160034.GG2695987@ziepe.ca> <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca> <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca> <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca> <CAAywjhRKvZBShj7KAXew2v_uGjn3HhvO=sFrZ=bVfMJ8ye-Vyw@mail.gmail.com>
 <20251002134112.GD3195829@ziepe.ca> <CAAywjhQrAWPjb8YtO=+G+pfJpW7p-rwrj03zB8ZqdhB0wtsO0w@mail.gmail.com>
 <20251002173715.GH3195829@ziepe.ca>
In-Reply-To: <20251002173715.GH3195829@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 2 Oct 2025 11:08:14 -0700
X-Gm-Features: AS18NWB8vFBhNg3zLO-LSZdH2zdVlC9_FLZZQKmUF4ohKaV1RcU7Tg5O2RPHFCY
Message-ID: <CAAywjhQsyU4j4wfOqVuLxaVu0FsxuqCCjhJHuk4vcYAo3Cqh_g@mail.gmail.com>
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

On Thu, Oct 2, 2025 at 10:37=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Thu, Oct 02, 2025 at 10:03:05AM -0700, Samiullah Khawaja wrote:
> > > I think the simplest thing is the domain exists forever until
> > > userspace attaches an iommufd, takes ownership of it and frees it.
> > > Nothing to do with finish.
> >
> > Hmm.. I think this is tricky. There needs to be a way to clean up and
> > discard the old state if the userspace doesn't need it.
>
> Why?
>
> Isn't "userspace doesn't need it" some extermely weird unused corner
> case?
>
> This should not be automatic or divorced from userspace, if the
> operator would like to switch something out of LUO then they should
> have userspace that co-ordinates this. Receive the iommufd, close it,
> install a normal kernel driver.
>
> Why make special code in the kernel to sequence this automatically?
>
> > session manager (VMM or LUOD) decides that the finish needs to happen
> > and the iommufd (or the underlying HWPTs) are not restored, it means
> > that LUOD has decided that the VM is not going to come up and the
> > preserved state and resources (domain, device, memory) need to be
> > freed/released.
>
> I've been assuming if luo fails so catastrophically the whole node
> would reboot to recover.
>
> Is there really a case where you might say a kexec happens and a
> single VM out of many doesn't survive? Seems weird..
>
> So to repeat above, if this is something people want then the
> userspace should complete luo restoring the failed vm and then turn
> around and free up all the resources. Why should the kernel
> automatically do the same operations?
>
> Maybe userspace needs some contingency flow where there is a dedicated
> reaper program for a luo session. The VMM crashes during restore, OK,
> we pass the luo FD to a reaper and it cleans up the objects in the
> session and closes it.

These are all great points. I agree, it makes sense. It keeps the
FINISH lightweight and makes the domain ownership model very clean. I
will further discuss the memfd dependency scenario in the other
thread.
>
> > > Maybe the HWPT has to be auto-created inside the iommufd as soon as i=
t
> > > is attached. The "restore" ioctl would just return back the ID of thi=
s
> > > already created HWPT.
> >
> > Once we return the ID, do we make this HWPT mutable? Or is this
> > re-created HWPT just a handle to keep the domain ownership?
>
> That's a bigger question..
>
> For starting I was imagining that the restored iommu_domain was
> immutable, eg it does not have map and unmap operations. It never
> becomes mutable.
>
> As I outlined this special luo immutable domain is then attached
> during early boot, which sould be a NOP, and gets turned into a HWPT
> during iommufd restoration. The only thing userspace should be able to
> do with that HWPT handle is destroy it after replacing it.

Okay, this is great. An immutable HWPT associated with the restored
iommu_domain confirms my intuition that this is just a handle to the
underlying domain. The user can destroy it when it is replaced, or
when iommufd is closed without HWPT replacement.
>
> Jason
