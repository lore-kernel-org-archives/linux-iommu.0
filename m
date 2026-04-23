Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C20D372698
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776985772; cv=pass; b=My8ID3fAfJAsWWUU1r9N3wHk4rtm1VBwRZiTqZlJevYnd4TyygByRL5Sxgifg3CHAUl5mXpL+HPG/o/FevFCvzA8tCSyXYaKSQcqcvPf2eYWpZUNZssJHOcFf03fI//nx3Oq9DXgf+w9crdsyoLy3m6i7zwDgD/SYaadZ5KtPt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776985772; c=relaxed/simple;
	bh=VSDvtpQyodvkH89hy45oW/Z42kZp4O88fgmSS7BMvzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HL/MrO3IPwF0Vtz0EqT98tJqaUxwlS299dSPlT17MLWd/XFZYtr7D6VLaAAj8u0A15n9XC/U4HEQ4/jRv0fjsPlt4pIFHjsDxU6sY4XRhIutxaGcGmhrKM7UwK8KJUxc06pqBpN+mHobhNlVn05OnhIXQdhNX62KyGqxJG2N6e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f+9oG/lx; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+9oG/lx"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38e68e4389cso76411921fa.3
        for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 16:09:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776985770; cv=none;
        d=google.com; s=arc-20240605;
        b=YU7gOKFiwbgIBnP6W3xUYWW30bTxLMysnJg9SatB839mLmSj9RYIB8J5Wqau1QO8QA
         /bDzVIVXUHTrQWikJ3puIeOvx0VMLgxa5ymS+o5p2RGXkqO5hifSGb0rTdNOu2ShnMcZ
         9iFtykNlzj++arN0M1p3pooQYTTcyStY4XytGLWlvTp06V4IxnpJWvIbjr/6ZrOrT4i6
         WHot8oTriSvx1xGZR52GQNqkKRBQJHgqVWqT6v+bCkQ8hY/LzGLsFhXT4iz7jRGwnxvC
         MQNwrTlaF0qpqYBGTSrNPpAUW8ukH4lPdcfeewCKln3SEqoZ0Xf8d14qT3AUWMwjEHct
         3BBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=du3muYvsQpTSBNV17AfC1+OtrIQr2PLFz51edOhTt/Q=;
        fh=Wt0u+EiYiA69GgXAmCUjG7NDq7uzxw8PdUfmYf1IPAM=;
        b=W7hc52p4bTLQtprw/u5xcy/I+vVGRiCoZb7LtgFLmzMSdyNYhzZq1fKW2n9UQUAHoy
         YfWG6QUsgx27CffzGDcMChaCny22P0v2Ny4d57puB3TdkyAkeJ27mncJbqT34fNvA8/3
         ECFkJKxbpwfK91r++f9NM9GEvxZBPYJ+flpcjbVOWh4PhJ6n9/m4XGsprnSX4em2uf9X
         Dsd7cdI+6+3RFt22fmfo0OexzGgLUb2KXCFKzhl0gm4zbF8poMZ06CiFwcE2NVfr9HYy
         9++pc+aj9mb4Gf2inTOHLgrz8F+cEyuJXD8Zqgs4XtHf/ArftehRY5UiWceuMERyxVjM
         InWQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776985770; x=1777590570; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=du3muYvsQpTSBNV17AfC1+OtrIQr2PLFz51edOhTt/Q=;
        b=f+9oG/lxMzuap7HphqMJ0EuJRIiM3O0Pr5PVBL+WvT47Td7+N+wO+YEdu58N3wA/LS
         rp8ZKBLfFI1Ka8TZExi22Y5jLfjQJANaF0JYSQuvjGO/l34YmWKccj8tQRz8sNIMvAWQ
         05KBc9VIOcc+poHcbsZyUZW7uVsIODL4Ttlhyvg1IQYuIthxPyD0WHYIDPmqfiATCbfw
         RW/85Ur1Fu+ZqdhpgiRu+HJM2v5Tkq4KTg9krsF1f8gULAbAYMRwYl3YADdWtuM839Zs
         fse6FmHbX3MmC5f2gPhyawo8w7nbORK2taIesf+d/V3mYPOZpYQN6pmW+cDp7UWOWAkj
         XxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776985770; x=1777590570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=du3muYvsQpTSBNV17AfC1+OtrIQr2PLFz51edOhTt/Q=;
        b=Qoy79ov/hzGaoqOKRo5ZSpA+VTkHb55nCF+W0Aimw3dzu8ilHd0szXZ9G0FeB2QihT
         VWIYzgHJoE+E08o4DaahAyYbiAfv7uXGTUH4Y87UtiG5QqEEb5gT0874FdCXlQZC41gD
         QH9gHU/DPZgfb7X3h7El98D4GUv09qAOXuvwfF2gTVw6Jrjr6983nSVwyFJBk25SyFVs
         6S/BfBqFGQkYPnxxgHKycJLa0uSk/2BXwY7Wf+OHHc+n/fXMQYeKdFZl4n4qmm2VREV/
         Hw3CAQD86Mw2QnWm/Rrft0ck9RkR6F0ynN2lwoZdZmJTdv4uVM0WjoKxzXrdiSiLMHbo
         x6tw==
X-Gm-Message-State: AOJu0Yzu6KF0o8x03qPXYNbLzZKQnttDPhOMoz3fxQ7S7KkGQUzYuAsZ
	dvJRbvUHjgsJrc+n10abeOLORyzhazsc0gvf582hX1js3GlvZX91FiMY1YHNbaCr5KyBsNEsfWW
	kMtLP+KpWxdde9fsXXNSijwbjp8BqfLJrbq5czpb2
X-Gm-Gg: AeBDiesEJCS6CR+38qhg2FxqveRqm1YDw8ZHZgFr0pEaVeOtNAvRCCZ/JAABsn13Vrc
	8Bf0A5b0qsAz/GI0neKngTNJlnCye+V8Xj1GAo3Nnuefb7pcq+Ey3XW2ug/PbNarOWed7rxlsjp
	acUbbJiX8S80zoSm56opU4nrmKzmuYwPrGgqBUqlOMVcMOr23ra5KRB6h2LHFzZojKMDx0Cn+nP
	pB+1AI5mDsJ5vmf4mapivBDIs8n9aELxL83NzLJPSrMAQEtT+wGoyATa/gg0jRrBFLMYksHI9C1
	5lOsdKTRHSlBVfAUEyFthvexRV27Bg==
X-Received: by 2002:a05:651c:418e:b0:38a:965d:79ac with SMTP id
 38308e7fff4ca-38ec7845ffdmr82161421fa.12.1776985769266; Thu, 23 Apr 2026
 16:09:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260423212316.3431746-1-dmatlack@google.com> <20260423212316.3431746-9-dmatlack@google.com>
 <CALzav=dGpHEnEjyp8qc50iZrGeKJ47vjLvwtvkLCyNzOMJhozw@mail.gmail.com> <20260423225253.GA3444440@nvidia.com>
In-Reply-To: <20260423225253.GA3444440@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 23 Apr 2026 16:09:01 -0700
X-Gm-Features: AQROBzCagtk2g3nQiz1XNHTS_Y7Vpcsrr0LE0644u_NVwvd3XuR0UjLC-oW_vCY
Message-ID: <CALzav=fraXLgGs-XMc-=whMPhMbS99twFskGtV5Eo=UQ9mU5Fg@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] PCI: liveupdate: Require preserved devices are
 in immutable singleton IOMMU groups
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Joerg Roedel <joro@8bytes.org>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 3:53=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Apr 23, 2026 at 03:10:55PM -0700, David Matlack wrote:
> > On Thu, Apr 23, 2026 at 2:23=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > >
> > > Restrict support for preserving PCI devices across Live Update to
> > > devices in immutable singleton IOMMU groups. A device's group is
> > > considered immutable if all bridges upstream from the device up to th=
e
> > > root port have the required ACS features enabled.
> > >
> > > Since ACS flags are inherited across a Live Update for preserved devi=
ces
> > > and all the way up to the root port, the preserved device should be i=
n a
> > > singleton IOMMU group after kexec in the new kernel.
> > >
> > > This change should still permit all the current use-cases for PCI dev=
ice
> > > preservation across Live Update, since it is intended to be used in
> > > Cloud enviroments which should have the required ACS features enabled
> > > for virtualization purposes.
> > >
> > > If a device is part of a multi-device IOMMU group, preserving it will
> > > now fail with an error. This restriction may be lifted in the future =
if
> > > support for preserving multi-device groups is desired.
> > >
> > > Signed-off-by: David Matlack <dmatlack@google.com>
> >
> > Jason, do you think requiring singleton iommu groups is still
> > necessary/useful now that this series preserves ACS flags on preserved
> > devices and upstream bridges?
>
> I have forgotten why we introduced that? There are alot of funky
> things about iommu groups that might be important upon restoration..

You had originally suggested it in this thread:

  https://lore.kernel.org/kvm/20260301192236.GQ5933@nvidia.com/

> Like if you preserve one group member but not the other what do you ?

Yeah I imagine there could be some tricky cases there...

I wonder if PCI core is the right layer to enforce this. Maybe this
fits better into Sami's IOMMU core series since that is where all
those tricky cases will be (I imagine?).

> Even if you have ACS flags there are cases where groups are still
> aliasing DMA..

Hm, if a DMA alias can be created after boot time enumeration even
with the REQ_ACS_FLAGS check, then
pci_device_group_immutable_singleton() is not really immutable.



> Frankly, multi-device iommu groups don't even work fully last time we
> tried to use them in a VMM. So I think I would not expect them to ever
> intersect with live update. Blocking something tricky you can't test
> does seem like a reasonable thing.
