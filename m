Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6A736B903
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856867; cv=pass; b=SCUrLN5cckq1W1CBgnEjkRvpEKbB2W+2JJguWJvSULOzbsVQqHnSzvrVyDlVNTk+2dqVUW87DuEJ3Sh5aahh8hwm8rNJg0/eZGotDmliN97g+YGIsrLefY84kKSLC3fPQXXcHwpvi3NXutRMXC8Tq45vH2HhJn33T0frgyuaWas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856867; c=relaxed/simple;
	bh=T1pG2WEfWVgIVf8ho0lrSnlLE3kBpBwPvvr4u9b6ALU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBFly634xJd8oxACWH8qR95gA3gGMMJN04k4Ak8F553d7IxrEhdhgEvnEcRMUFdRrxfqij09WJ/6c1gPK90/JTWcVFsFCEKz28cjlDBvzRDGJ6YsfdeWJAZY0Cb4/qZ5iyZMCNXrPum/9twLuLYGNO7ywWvI/OZqJPzfBIEhFlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qa3JfF4U; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qa3JfF4U"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e347638adso52152a91.0
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 11:54:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787856856; cv=none;
        d=google.com; s=arc-20260327;
        b=g0pxHvwa/Ao9+ubwiZaCz50AQ2eFpNNeOzVvq+1pX1j7RrGwOgwjn+7I4ANBXGXmTV
         TaummYo2eqfUqGKaQsBtS9fpL5+P222hgK/F3fUSBDq6y/W6k6+ERn77tKD/fh5G5uZO
         0myuwSbxzi+fUZJc5qqEoU1KFxqiU5c2Yes/TxAgczJWJaI5QoYCj5uVPGvoX7YFeXH6
         CNy6iyfr6e5JiM/l2Qv53I+Xf8HyzrUYwyXFoB5VRwb7H5j7IDDjGcbBpyhiiUJ1j1TV
         cvuWSjyxEHBUWkpWNCPptWHopM4aOThBeVc7YL1z88xRiEb4/dcYzlUWM1xixAu1SYjL
         Q5Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hIMFUTwheoLBZ4d5onLuSDPADLZX1lH9pIq/GlMnSC4=;
        fh=kkAZM0GceR2iZNWHdrO0hi8ERCDAdHewGj3/43amfQo=;
        b=XWyRQwJbaZ2lV4NkEtlmzr7c7cl9EwML0e1vlHg8SasD4P4bTUXhsYuKjG/O7Wy8TT
         yuGpPNbPzSa/CijYA6kwtEvR50S2HjkPtwwt/5KgkD8FqPuL9eXvUDZD8n4pu2lmfupx
         lz9ZMkLf3oO7N/0XIzkolaga6ic6FvVuPRmYvj+5Re85QJmUXTjCZJfIwe95OO6JCppZ
         2Fjz6s2IE0Z6X+RIknzNVTmeTDtTmzls8WIvBqlhdOUvn8uTmq+ZHijAv9MI2HddDsDd
         srgvFf+MymtDwwaAPi0q3umuEaqCcKmQUOjlLj4FRMKSeVb/0ZN2JV4YjHuMlsa5APmo
         ty/A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787856856; x=1788461656; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hIMFUTwheoLBZ4d5onLuSDPADLZX1lH9pIq/GlMnSC4=;
        b=Qa3JfF4UbOWXcO0bsyHDVh9VYEvb6gY6QAd3iGYVFfLu2F6ELLoi112pY68ZY0A9/5
         z2Hb4miEWVQsA+BE/WGRVmX9u9QfPGtlxkmmmi45f0y1+g1wAdBnslIxI73eLf+FrIVJ
         5An7w3klCOWjgUIUpFAokLbxanv7eWvkFk9jHw8grU4uwHi2lojP1EfhAgDj+KJLQ27o
         IcsNLG44BHeVOJxLEIblP5Q/UpW1jCGQJe95xs/i3t5JOgJU2+Gl9jb9A4UdE6xydY/+
         Pr0NOqOiEGNMLKlE/58VTk6LFAVaG2Qof8sa31IuHH7T4SA92kemjCWTTMgMZDn22SxJ
         bExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787856856; x=1788461656;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hIMFUTwheoLBZ4d5onLuSDPADLZX1lH9pIq/GlMnSC4=;
        b=kILiCRV7bVF27S9QBvxWx7sg7Y6rP2oKyrVCt/Zp6wDA9HUQFDmXBG7kBEcdp/MakX
         p6H/DdfxeZ79oRj4yGXPDHhm3N3i2UF93ilPeg9wNhQZgjWrIdMOIJv+uHVY25PRS2uc
         k1UsftyXmyn5p3g2fwfz3lj90PEnBgAPJf1yLQhGc5oRh6IScW6hLJ/c9HMmmgOFK1wS
         Iyn00CiuZaMR0M7Pr6AyYZm+eqyoOm+C2wvOiIMMeJ+D0IX1NsP1HRXaGG0cQn7yFps0
         O4+pIiDcK2LOG722/8sYvEWRCe5UV3JuFcyD2E7Ud3fN8OHiKAUR1ECQJ0Il1Lg7Env5
         cA1A==
X-Gm-Message-State: AFuF++mDpURmkGwt3OUthl1DAvOjS+ln0qYE/OzqeEMK4SWxD/3I7UlC
	7eMZVRNa8ppRmVx0ndHLblP475oI/ddWMLo5VtCuZiO+zl2c1OBkjyFqdJkDzn+PNEoXNAE1Zdp
	vt4bi7LDojdWPCIrhueIpaiTyK75O8YA4sCL/sNl3XeS8kYxQDAX27cTKMaI=
X-Gm-Gg: AR+sD110T0DK8xJ6JVjAg15JPkPgcVteQtCrkggPMlfBmwNshTgxHdxKMQwu49cHP/f
	nHI4O8B62JoHY+QtG2s1q3M+6WY3BvUAqWzTueI2LHyg/5YXeLAPt/85jd/cfcVVF7A5F/ciCRp
	yZ5Yd/dJQU+tRZvwzkQ1BPhOPc1LOJGAwmM5xpb2TSuP14rmIY6ObYxx5BST/Zy5mKJH0A0MnSA
	O3Ulo4wCXXl0RjX3jSYxxEDTcoWZCHrO9WsK8Hovj+X5vBR78e76yXzxWwXClKBSkRhiZmRSIHb
	pF2h8zVVFvgn9d4XnYImJsJYSGU/UcdIeaudbl9VgibMEzio2M+WitOIoA==
X-Received: by 2002:a17:90b:1a90:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-396d0f8e80cmr1888877a91.10.1787856855570; Thu, 27 Aug 2026
 11:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260827173511.2322549-1-dmatlack@google.com>
In-Reply-To: <20260827173511.2322549-1-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 27 Aug 2026 11:53:43 -0700
X-Gm-Features: AcwNN1WvasuJQlPgX8gu4_bgTqaxnyoZQNZsTMyZ4LFvBrDZl2W53G30ppdPRJU
Message-ID: <CALzav=fCyLcbcNJWERyH+uO6+60w76iyHUd2HXgOnDauysR6UA@mail.gmail.com>
Subject: Re: [PATCH] iommu: Introduce reset_mutex to avoid circular locking dependency
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Joerg Roedel <joerg.roedel@amd.com>, 
	Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 10:35=E2=80=AFAM David Matlack <dmatlack@google.com=
> wrote:
>
> Introduce a dedicated reset_mutex inside struct iommu_group to serialize
> device reset operations and domain resetting state without acquiring
> group->mutex.
>
> Commit f5b16b802174 ("PCI: Suspend iommu function prior to resetting a
> device") introduced pci_dev_reset_iommu_prepare() and
> pci_dev_reset_iommu_done(), which acquire group->mutex during PCI device
> resets. In drivers such as VFIO, device reset handlers (e.g.
> pci_try_reset_function()) are executed while holding driver locks such
> as vdev->memory_lock.
>
> This introduces a circular locking dependency that can lead to tasks
> being permanently stuck in a deadlock:
>
> [vdev->memory_lock]  =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80(1. VFIO Reset)=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80>  =
[iommu_group->mutex]
>          =E2=96=B2
>          =E2=94=82                                                    =E2=
=94=82
>  (3. VFIO BAR Page Fault)                                    ... [*]
>          =E2=94=82                                                    =E2=
=94=82
>          =E2=94=82                                                    =E2=
=94=82
>          =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80  [mm->mmap_lock]  <=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>
> Fix this by using group->reset_mutex instead of group->mutex in
> pci_dev_reset_iommu_prepare() and pci_dev_reset_iommu_done(). To ensure
> other iommu_group operations stay properly synchronized with resets,
> also take group->reset_mutex when checking group->recovery_cnt.
>
> [*] The iommu_group->mutex --> mm->mmap_lock dependency was reported as
> a transitive chain: iommu_group->mutex --> cpu_hotplug_lock -->
> i_mutex_dir_key --> mm->mmap_lock.
>
> Reported-by: Vipin Sharma <vipinsh@google.com>
> Closes: https://lore.kernel.org/kvm/20260821193502.92431-1-vipinsh@google=
.com/
> Fixes: f5b16b802174 ("PCI: Suspend iommu function prior to resetting a de=
vice")
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
> Cc: Alex Williamson <alex@shazbot.org>
>
>  drivers/iommu/iommu.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index e8f13dcebbde..29e63697211f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -56,6 +56,7 @@ struct iommu_group {
>         struct list_head devices;
>         struct xarray pasid_array;
>         struct mutex mutex;
> +       struct mutex reset_mutex;
>         void *iommu_data;
>         void (*iommu_data_release)(void *iommu_data);
>         char *name;
> @@ -1080,6 +1081,7 @@ struct iommu_group *iommu_group_alloc(void)
>
>         group->kobj.kset =3D iommu_group_kset;
>         mutex_init(&group->mutex);
> +       mutex_init(&group->reset_mutex);
>         INIT_LIST_HEAD(&group->devices);
>         INIT_LIST_HEAD(&group->entry);
>         xa_init(&group->pasid_array);
> @@ -2476,6 +2478,7 @@ static int __iommu_group_set_domain_internal(struct=
 iommu_group *group,
>          * pci_dev_reset_iommu_done() attaches the device to group->domai=
n, if
>          * IOMMU_SET_DOMAIN_MUST_SUCCEED is not set.
>          */
> +       guard(mutex)(&group->reset_mutex);
>         if (group->recovery_cnt && !(flags & IOMMU_SET_DOMAIN_MUST_SUCCEE=
D))
>                 return -EBUSY;
>
> @@ -3652,6 +3655,7 @@ int iommu_attach_device_pasid(struct iommu_domain *=
domain,
>          * This is a concurrent attach during device recovery. Reject it =
until
>          * pci_dev_reset_iommu_done() attaches the device to group->domai=
n.
>          */
> +       guard(mutex)(&group->reset_mutex);
>         if (group->recovery_cnt) {
>                 ret =3D -EBUSY;
>                 goto out_unlock;
> @@ -3745,6 +3749,7 @@ int iommu_replace_device_pasid(struct iommu_domain =
*domain,
>          * This is a concurrent attach during device recovery. Reject it =
until
>          * pci_dev_reset_iommu_done() attaches the device to group->domai=
n.
>          */
> +       guard(mutex)(&group->reset_mutex);
>         if (group->recovery_cnt) {
>                 ret =3D -EBUSY;
>                 goto out_unlock;
> @@ -4042,7 +4047,7 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pde=
v)
>         if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
>                 return 0;
>
> -       guard(mutex)(&group->mutex);
> +       guard(mutex)(&group->reset_mutex);
>
>         gdev =3D __dev_to_gdev(&pdev->dev);
>         if (WARN_ON(!gdev))
> @@ -4153,7 +4158,7 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
>         if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
>                 return;
>
> -       guard(mutex)(&group->mutex);
> +       guard(mutex)(&group->reset_mutex);
>
>         gdev =3D __dev_to_gdev(&pdev->dev);

Ah, this does not work. __dev_to_gdev() has a lockdep assert that
group->mutex must be held. I'm not sure why my test did not catch
that...

>         if (WARN_ON(!gdev))
>
> base-commit: 37ffa24c9d07edcd414d34283e02af3f3866cf12
> --
> 2.55.0.897.gb25b4bd76c-goog
>
