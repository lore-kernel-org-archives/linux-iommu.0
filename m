Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103EF446857
	for <iommu@lists.linux.dev>; Fri,  4 Sep 2026 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515866; cv=pass; b=oB1QCOfsdbKgi8XyqvCF3FKWMMvoDm2loWL6u6MdHcHS0Sq1f7Zv0lSHZlNnzYoDc/+wr2R9aAiKJmUA+qA3rnHcdJbO8v5UYLpo5mXSEUSjckwTV/4/3Gjpi0EL3L1W1tfdgXrJyuBtICU92PaDNWR2L+W1XeAmqrm6CG+IwDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515866; c=relaxed/simple;
	bh=6WmWFr9BY8WHDH5HOaS9iTFTd4EmRtRdp6fMjyF+1mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awuEF1HdZW+FvtKZFl4HplC7ug6LTHvxHn5uyFHR43YYN0N0DYADGlXTEpE0XRrOGGjc536XW9PA1Hhot/TI3ZXLRAtEnSbpiWSK6hHdSo/HPYBawmrQzZts0utw6FPsda//27J6Yh9aNPDsanKHpYoGDqDsnAMQwRGbQ2/clhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aIPSlQVl; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aIPSlQVl"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7f4f53975e6so712631a34.3
        for <iommu@lists.linux.dev>; Fri, 04 Sep 2026 02:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788515863; cv=none;
        d=google.com; s=arc-20260327;
        b=qlrnjEI5pLfmtsEIHRCkvPdppSlHB45zgAA4vpsBfZrjBDXJyFXxXH6tihewHp+kF+
         ffGEs7nykqICq7S5Yz3kWfUTvWYhvw5fcbMsxpKvU8MZE2tDoTfJyS+34qZwCPoVKLjw
         gs7erWIbmX+mKyDj6a4PT5XG+3YbaZa0hwu0+S9h0blkk9ghGCWyN67l/QxWYZGMd7LL
         bjhxfHFKynTn8fv7qkwt3y4XMkQGXEfMqnyO+EgCxVLwMuoLs/HBEi52/rua2SyPYL2n
         2CGr39npw2RGXgjUZYb/hrcWVLfIuKTpw+dbruv3dRsNKVRqx2qEokgzPnEnSTbnqMjc
         XGnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3pmQAxfFHxZRfYhLuLaVrq3tjXnncmJuNgkRzDwbSwk=;
        fh=1RHqehBUwrUj2fHFGC9IzTjpa2m8c0CMehOErjlnAHA=;
        b=j7HjWPJmZFp8RSEvKcl6HEaQqsfVzvddukAiTfW1w7khQYY9vfOrbNWwnFJSnbUigi
         UWsvhMNREJBQTG1f4wqAIezOCaXcWDFwFtV4WoWvtcdUZmUUxYzR9xflICsVPBKyUEOf
         zYp+wmORlk5Mcp7VdYzFIdB35rzljn+YbwK345xRnG6BFoCeflXuLdx1b0m7UrprgVvZ
         Pqp0Q8qoGuiNzHS0mAZd/zNOerzk1vUm6al968NoSLmG58nNB/9yZLN0kzBEmemXdlwJ
         IfgdAxuSDTaGOH8DesukFHrdnpt+UW+tAi7Cm8eq6nioe8hq5UIBqL2L6/DqXqtUPJWk
         D0Ig==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788515863; x=1789120663; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3pmQAxfFHxZRfYhLuLaVrq3tjXnncmJuNgkRzDwbSwk=;
        b=aIPSlQVlaiqobv+VwiPhxiJfA/TjGzDhmcW6qg6cwkiKs4oblwZVadJFQsCXis5b46
         /6PgzcQ726EOC9/ixtQ3Y5nnuE0Gt78xRvobNJ9bvyFLv7YoUWieylXYF5JkbXsnzCKL
         rXdHR3FGPNAkIpRCmdMsFmCe6f57uulCQY1HqeOVg8GOxO4z2MGVMDH72KUDldGuvcFs
         o0v86P5TSMJs4HFSXJIZTvbJWbcwUeaQntnWG552YGxCl0aERrvS9OV6JKj9l4PoBDEj
         jaZZQFg2RUyYH/iLihZ32Rt/igAvJ++ZQYFqXs603nGdyZE0azQhC3MV/NGy08cMUi//
         q1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788515863; x=1789120663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3pmQAxfFHxZRfYhLuLaVrq3tjXnncmJuNgkRzDwbSwk=;
        b=Jr4arHPWlsX628ivyRFmcdvuzme74yHBg6LmjVMcZ+ZRgxeh2iLXTZtc0EMoHpMiEr
         5tylZtXzI02nd+p3wWCbb6p4VSOjf3eQNXk/GPCOS4Zr9F1DfEfoqasn75IWaBltgYKl
         DAPRsGJwwlHMaUtHMd5c7HvFXEj9pZVE9xvwndHizqHywUM9JQVpZI7ZYK5QsTqPirm0
         6ScDdXNDlKYVJejIvOWeDOxMCZrfDjgbyPAFi27wQ1eAd57kh5HqesaqlpIp4bKG53Ul
         ZtqJ3RZarzWLivv+Dvh4cAVrld7E4wtnRsDfWKa5DXq2eA1sDZrPEIFjtHPXps21Fj+i
         hycw==
X-Forwarded-Encrypted: i=1; AKwUvBw7u5GgrXfedqiZVef2yEa/I6o6FfaK49v5qO2L3QcC+se3RxemZa4oSbYC8rtMGw4c1vRVxQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lRULHQryZ1c7x7tcsEe0XnxsQ2nPzd/hdSFx2d4RbeDa7ql4NV
	u2s5J2Ovl076yJ/+Vs/JaL4qBH3/2oO6k9Gzzseb3t7VOPtJ6qqq/MNwlqfdWRdRkzrchk+4h0O
	d96gapxxPaKMkQvJgf5hYGlp1KNG5LzW2qAbnQbbF
X-Gm-Gg: AYBFou31GN8bMYoIb7dl0OjWXKpvFhgfYfgIwHkEKpJB7+Y4S6OPZIYQusbd7+5yH69
	Fpd9PKBVf9+ZFxLcsG2bGbyM2UQlGjA+UjRHWN5kdKSqLyr986EmkBzZNAu7Y3M1lbzisCc88/e
	t2WI7kI4kn4jkv+CgSZjldD81/yTkQWkVRCU2qPqOivOiMYIy2J4L/yXvc+50Wjz35cJsdTtW1+
	3rwNoLiDcLsu6L968j0Plr0zv3Lyh9GoAea1CkbVtk1iZ3ymFiTjVrYOu0dSkgi3Pxhg4SUNH2J
	uvfS5REbfb+8uGWHtUgQjZIpDy6SQ9CqXFo1zZk7Rg9ZNajJwGSTdbRg6wpl8rxtPwgvICsrvth
	MISOckegHrn1pi/ZwWwvCUnC60zZ7p9AgNaVn2Hsq4koOn3KsRlPl2V/Q6g7h+Tae2n8izPsbY0
	U/blYkyLnnAb1HH5MegHnLosnr
X-Received: by 2002:a05:6820:6ac3:b0:6b0:4170:59ad with SMTP id
 006d021491bc7-6b6fc7d1f64mr3797277eaf.24.1788515862149; Fri, 04 Sep 2026
 02:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260904-clown-zersplittern-sequenz-987f972a607b@brauner> <6a9a8cd1.a011d2ce.399d32.0000.GAE@google.com>
In-Reply-To: <6a9a8cd1.a011d2ce.399d32.0000.GAE@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 4 Sep 2026 11:57:30 +0200
X-Gm-Features: AcwNN1U7j0-le73bygNJxDaUo8VXPRh4lkxTXAwyp7z5061WENtccz_ye1P0Dso
Message-ID: <CANp29Y4e=0yahrA4K8xKO186JiruTorRaq7u+Y=Q4Mo-3SReCQ@mail.gmail.com>
Subject: Re: [syzbot] [fs?] memory leak in path_openat (4)
To: syzbot <syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, iommu@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 11:18=E2=80=AFAM syzbot
<syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com> wrote:
>
> > On Wed, Aug 26, 2026 at 07:54:38AM -0700, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    26260251022f Merge tag 'livepatching-for-7.3' of git:/=
/git..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1196a17958=
0000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6c1b5958b2=
d1207f
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3D7666ed2c3d42=
196bf7e3
> >> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils fo=
r Debian) 2.44
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D139f7179=
580000
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/0f75e7622b1f/=
disk-26260251.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/2bbff9fd7b60/vml=
inux-26260251.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/95d73300490=
7/bzImage-26260251.xz
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the c=
ommit:
> >> Reported-by: syzbot+7666ed2c3d42196bf7e3@syzkaller.appspotmail.com
> >
> > #syz set subsystems: iommufd
>

#syz set subsystems: iommu

> The specified label value is incorrect.
> "iommufd" is not among the allowed values.
> Please use one of the supported label values.
>
> The following labels are suported:
> actionable, missing-backport, no-reminders, prio: {low, normal, high}, su=
bsystems: {..
> see below ..}
> The list of subsystems: https://syzkaller.appspot.com/upstream/subsystems=
?all=3Dtrue
>
> >
> > This seems to be a reference cycle in iommufd. path_openat() and
> > alloc_empty_file() is just the place where the file is allocated.
> >
> > The reproducer does:
> >
> >   r0 =3D openat$iommufd(AT_FDCWD, "/dev/iommu", 0, 0)      /* =E2=86=92=
 fd 4 */
> >   ioctl$IOMMU_IOAS_ALLOC(r0, 0x3b81, {size=3D0xc})         /* =E2=86=92=
 ioas_id 1 */
> >   ioctl(r0, 0x3b8f, "2800...0400000000...0010")          /* IOMMU_IOAS_=
MAP_FILE */
> >
> > So that last payload can be decoded as:
> >
> >   iommu_ioas_map_file: size=3D40, flags=3DR|W, ioas_id=3D1, fd=3D4, sta=
rt=3D0, length=3D0x1000
> >
> > So fd is r0 itself which is the iommufd fd which is handed back to IOMM=
U_IOAS_MAP_FILE.
> >
> > That causes a cycle:
> >
> > iopt_map_file_pages() does fget(fd) without worrying what it calls it
> > on. So that does iopt_alloc_file_pages() which takes a long-term refere=
nce in pages->file =3D get_file(file)
> >
> > The reference is dropped in iopt_release_pages() in fput(pages->file)
> > from the IOAS teardown. That in turn runs from iommufd_fops_release().
> >
> > TL;DR:
> >
> >   struct file(/dev/iommu)->private_data-> ictx->objects->ioas->iopt->ar=
ea->iopt_pages
> >           ^                                                            =
        ^
> >           |____________________________ get_file() ____________________=
________|
> >
> > Closing the fd does nothing. The hex dump shows the same pattern btw:
> >
> >   - obj1 struct file @ ffff88812811f9c0, obj2 its LSM blob
> >   - obj3 iommufd_ctx @ ffff88811161cd80, first word =3D ffff88812811f9c=
0 =E2=86=92 ictx->file is obj1
> >   - obj5 xa_node, its ->array =3D ffff88811161cd88 =3D &ictx->objects
> >   - obj4 iommufd_object: shortterm_users=3D1, users=3D1, type=3D4, id=
=3D1 =E2=86=92 the IOAS with ioas_id =3D=3D 1 from the repro
> >   - obj6 iopt_pages, kref =3D=3D 1
> >
> > Likely caused by f4986a72d6e4 ("iommufd: Add IOMMU_IOAS_MAP_FILE")
> >
> > Afaic,t, this should either reject based on file->f_op =3D=3D &iommufd_=
fops.
> > But iiuc there's other cycles that can be formed.
> > For example, via a vfio device fd that's bound to the iommufd. It holds=
 an iommufd_ctx reference via iommufd_ctx_from_fd().
> > So mapping a bound but unattached vfio fd builds the same cycle.
> >
> > So probably this should do validation what type of file can actually be
> > used like shmem and hugepage file.
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller=
-bugs/6a9a8cd1.a011d2ce.399d32.0000.GAE%40google.com.
