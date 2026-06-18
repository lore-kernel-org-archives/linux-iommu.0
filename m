Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A9B26FD93
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 00:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781744238; cv=none; b=EQTkSKCqRe0E4ULy7XILNzX7B+fEUNr1tx/aLTyxpBX8eT83mjtaUx5U5dPPsLSdhjzkrw5mmfIgy6saRkV/s52wihhffq8xPZx3mXyLxODM+hJxbxhb0D3hIovn68phH8BcFo4ufEQlDGPm4YvlItUN5/5Q5KFmHS/Ng7kwPvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781744238; c=relaxed/simple;
	bh=r4IaJvvyIT6el7i2weVkvEk5QehixTD6dFSGgLsOExE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Co4w/byL5tBd7fm8jxR302tJwdq6HYtw0NWOmxInS/VHMv82ncuExYgxfOrXExQMQdyi6GDYS3veCpvdRWxYo9MXJdP/vqn956oR591B8VdVJC4RoJDwhttj9fiXUbMFDnTGcz2L9feBN8a/oXbsPxSs144w+6CleQZz8+dmHMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XiZ5FrA9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiZ5FrA9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781744236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIF8cjycHSBcMVtLMb8AxYPq8NTa82BvKAmKc4vxWAU=;
	b=XiZ5FrA9DJ3vzWcxR9eY5D1tQ5TBU9UXTganM78Da/jawra+j1oqAtVqadp5SDK++e08MG
	A7IYq9M/ZrpxXHuF4+l5e9RN9RE6hpJONoIHS/8jSe3cW5kN8OYm9HOJtFL6hnTk/E/ZF0
	WOwDSsfijoyzIuQ7AFFWV942UylVUp4=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-wTuH08oOPNW_KxoYVxcmfw-1; Wed, 17 Jun 2026 20:57:15 -0400
X-MC-Unique: wTuH08oOPNW_KxoYVxcmfw-1
X-Mimecast-MFC-AGG-ID: wTuH08oOPNW_KxoYVxcmfw_1781744234
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-485fdae1db3so778704b6e.1
        for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 17:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781744234; x=1782349034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LIF8cjycHSBcMVtLMb8AxYPq8NTa82BvKAmKc4vxWAU=;
        b=OPlthXnnFqq68HvjSRpV5Q91BAw5rjAyBhVoBghEN/MpZy97SKqzS0rrtp3Yd9zW3D
         Sn1axJo+vAF1FR4tVBpoyYI3IccAYFMYNnkscTWxKMRtHkV9yVlifyp80H/szae2q15e
         +B6rKNU6lGMy5Wd1cr7EwGljXQYy3FH3LcXtG2wvRxQGMPYqqyRnrisPfuTIkNJSWYaP
         59MRFq6X1NyLDLxqOvGZuDtjNzuXXHq8D5Kg40Saok0lSUFD7EeuXkzR23C3t389VCOp
         hpyzcD0JydqP3nhjZxA5D8HWVQNfDVfiopoSBbyvQkSAbGktNB3yfx0yQCB3mClZx93C
         gH/g==
X-Forwarded-Encrypted: i=1; AFNElJ+ifAaL38EN4AfmnCYo7Bj+5JHJpm15bscTbwwAQ/855CVWhYB48sEE6GEuFatLw8UZff+okg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yws3JgBwOUNtOxc0og5gyzrnISxreaRYmVREwMInNBrSXY+A3Sk
	b/OIcm78nDM81F2Xl1G5Q7FNPPw9re3VjudA1WpqXywPodW7Fd+Jb37PQO0fPl2SEMyPjh4uDyr
	nZfg0NlWzZopOqxKrqjETyeVhNUFbsJN/Ljuy0FsB8wVwRyT804A3+dFiJLf0zUgv2HQIah2ecX
	UCTprIvoFfuVO0TUsG4MUC2hHa5n7KDj4=
X-Gm-Gg: Acq92OEN8sHBP44LDPhYyC0/swkjhAfLazGVqgCe34fx0nD/ULwQ6RwUumTJLl+drNJ
	9DD9hz2cIUMhx3zVCG7nqZ9h35u3Pd2ygSwnazH0uY+v5ifDHp7/6LJ4veQf4Dn4eDGPT+BIwE4
	gHXGnp5vruUmKD3TaT9Nfs1WwLmBYNI0Noh/uv58HUHKunUgS5q9KRvTtr64l8Fsrn6Y/BAzC8S
	g0AOr6zaWCblcC7LeMXplnGn14k
X-Received: by 2002:a05:6808:3442:b0:467:13b5:8ae6 with SMTP id 5614622812f47-4895d0e6f4emr242156b6e.4.1781744234305;
        Wed, 17 Jun 2026 17:57:14 -0700 (PDT)
X-Received: by 2002:a05:6808:3442:b0:467:13b5:8ae6 with SMTP id
 5614622812f47-4895d0e6f4emr242131b6e.4.1781744233829; Wed, 17 Jun 2026
 17:57:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260430014817.2006885-1-desnesn@redhat.com> <CACaw+eyKh7buHDoDyTOe8O65FP5cSXYdzCcQvwqKw=1DwX26oA@mail.gmail.com>
 <20260502235517.089ba5bf.michal.pecio@gmail.com> <CACaw+ewOTVh49tnkz+cRr0SD_Z-LmYrMWhFUrsik6YF83mPBtA@mail.gmail.com>
 <20260503071749.6abda137.michal.pecio@gmail.com> <CACaw+ew8uV5g1G-6qZGtVBEYZ3k+fvFrOq3XMyq-Nuhbq5mdnA@mail.gmail.com>
 <20260503213111.117db3a1.michal.pecio@gmail.com> <20260504093118.615ff480.michal.pecio@gmail.com>
 <20260518083339.507e24bd.michal.pecio@gmail.com> <CACaw+ewSWTo72fSk2Q7ZzCM8pNuyrX5ua+qA=SZOQuNNMKSA5Q@mail.gmail.com>
 <20260522110328.0d3eecd8.michal.pecio@gmail.com> <CACaw+ezqEO_PgjGeYCLq5hA2eKczFXgmZLa8qjPtVJZCGwsdsg@mail.gmail.com>
 <20260523022944.59799d83.michal.pecio@gmail.com> <CACaw+exPdwXVsJc5Xr=vN1WJt8XR46=X0-8PP=+5dWY5zUrKeQ@mail.gmail.com>
 <20260523102815.5c05c70a.michal.pecio@gmail.com> <CACaw+ezMnQh2_oqbZ0jF99+wOADMU2vSMqxh9BoJoefjAC_ixw@mail.gmail.com>
 <20260527103221.7f8b15b0.michal.pecio@gmail.com> <CACaw+exN3fdzGQE7oK-hRE3KpMrA3ckPDRAcXaFbd=ySXf8E5A@mail.gmail.com>
In-Reply-To: <CACaw+exN3fdzGQE7oK-hRE3KpMrA3ckPDRAcXaFbd=ySXf8E5A@mail.gmail.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Wed, 17 Jun 2026 21:57:02 -0300
X-Gm-Features: AVVi8Cf7Uiv1UFfqctPnTUuo9KLx6CyYhY3_twtj7WI22l-VLlYMs9UQJvgzio4
Message-ID: <CACaw+ewuPm-eOACKX3Ux0UwJBRSftoBm7H+rxE2Z9E7KzWb5ew@mail.gmail.com>
Subject: Re: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on command timeout
To: Michal Pecio <michal.pecio@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org, 
	iommu@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3yTpDJfwO4Ei1lx3__qSwxFKoqo6CyEsdfaIv7fwY9k_1781744234
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello IOMMU mailing list,

On Wed, Jun 10, 2026 at 12:32=E2=80=AFPM Desnes Nunes <desnesn@redhat.com> =
wrote:
>
> I have just found out the solution for the bug.
>
...
> In scalable mode, a PCI bus may populate only the upper root half
> (UCTP) when all devices on that bus have devfn >=3D 0x80. On bus 0x80, I
> have e1000e at 80:1f.6 (devfn 0xfe) and xHCI at 80:14.0 (devfn 0xa0),
> so the hardware root entry correctly has lo=3D0 and hi=3DUCTP present.
>
> However, after copy_translation_tables(), I noticed that root[128].hi
> was zeroed-out (Present bit cleared) and another (expected) different
> value on root[128].lo.
>
> In short, the culprit here is having a zeroed LCTP, since at
> copy_context_table() the allocation of new_ce for LCTP context entries
> currently governs the pos variable; which is later used to save new_ce
> entries for UCTP at tbl[tbl + pos].
> On the first iteration idx will be zero, old_ce_phys will be empty,
> thus this moves the loop straight to devfn=3D0x80. At devfn 0x80, idx
> wraps to 0 again ( (devfn * 2) mod 256), but since no new_ce was
> previouly allocated for LCTP context entries, pos will remain zero
> while copying UCTP context entries.  After all upper context entries
> are saved, tbl will receive new_ce from UCTP at tbl[tbl_idx + 0], and
> not tbl[tbl_idx + 1]. These will be later written in
> copy_translation_tables() to iommu->root_entry[bus].lo and
> iommu->root_entry[bus].hi, which causes the bug.
>
> In summary, the hardware tables were correct, but the copy path
> misplaced the UCTP table for bus 0x80 when dealing with a LCTP
> zeroed-out during kdump.
>
> To fix this, I created a v3 patch that uses devfn to better track
> which half we are copying, so UCTP-only buses (lo=3D0, hi=3DP) are
> installed into the upper root half.

0001-iommu-vt-d-Fix-UCTP-context-table-slot-when-copying-.rfc.patch

> I am doing some final tests now, but since this was a lot to digest,
> comments at this stage will be most appreciated.

FYI, all of my last tests looked OK.

> To IOMMU maintainers: should I send this patch to the iommu mailing
> list and move the discussion there?

I meant as a new submission to IOMMU maling list, since this started
in xHCI at the usb mailing list.
Of course, that is if nobody has any comments or objections to the patch.

Best Regards,

Desnes

