Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275C5237194
	for <iommu@lists.linux.dev>; Thu, 24 Jul 2025 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350143; cv=none; b=T/7K4ExvF7wJjMS/vjDAd8WwUMy1jUqq9w4s8YJ3OzBK5OrN77m1UYBRHvrWCwv79vzuReepxsaGa56jmd+17fl9G44TRClx0gjmqtiUbREv4tRU0OwuaO/ALmruPmKVo8mdkDIUjf3dvFode7jFBbh11XT6yT2+glMVTorGBBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350143; c=relaxed/simple;
	bh=0yEzlUXDcKH+2lW23G2uxcBdUEZQQPC4WcJyV+RFPjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/kuAknmGHsOkeP7igsca6oS+aII4mrbMpi3gttpCrHmd2vw3KEVfhHTjdd1nIgr/P08FT93AUPRZPe5s0rj0e1WQcSnPdXYm3ok7tgzWvU4pmRWtF6li5R+8+DHmU3D/BEVmYBi7AN+71s3nxUoysXm89/3ZlUaaW78S+hFRPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBFFij5/; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBFFij5/"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4e8110ac0f5so234720137.0
        for <iommu@lists.linux.dev>; Thu, 24 Jul 2025 02:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753350141; x=1753954941; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yEzlUXDcKH+2lW23G2uxcBdUEZQQPC4WcJyV+RFPjQ=;
        b=eBFFij5/75Fp9HUOZXG5F3MdTu0sKzhRpjDGlAZ+OvOeDFC7XgvMxImkSNXbJnPA5/
         PVnzDAzWix0+1useNrPoxV3qQfwm0bLjlnOnUht+1eciowAbyMCgN3irsQ1t90aoSUM2
         msLO0W3jLePRnt4IctACH76k/zUTXqxbERhVstE5515LcpZBvvCawxbS7kTamQUC+olN
         GVIJ5aQDFhuC8i13hMXrsgV6qUiQUhV8CLQO+mEoJaq2RM6ujn5P3463gx7noWTVaAKG
         ttk6k7iTpnG4Rihvj3sz7xOXpqjnP8AH97yh5Sou5cOntyB0zKZoc5SXPSRiqMFYCUgm
         80Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753350141; x=1753954941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yEzlUXDcKH+2lW23G2uxcBdUEZQQPC4WcJyV+RFPjQ=;
        b=QSkmur0iTObMCKFUsnhZMc1FC4LcfAEbDn0noGkMRhxhXAKva7ycyrTJIIP3m8r9b2
         6BrHb0h06tDJzfKIjitz3XFTlw0zPDXm/3QD8n6iOdGiB9qsl4mtLJ2FyLmfkg2T+AXv
         9Bd8hrwAAl3Vvq73vRXWuNhKlKf1+i3Js5U42ahLdcgYidLlilFPhuaIzWhsUjB6uFFG
         hlFW7xCvDV7KhpY9io5rp2RANTkzggORc7LU+tEYpcVDHIy5x/QUt/xJMHngq7/skdl+
         y0nX3lsXLO+khwGVLLUbhcwY+FjnWWeGs+0OTp3Zzx5WYevV/m9bMIkIoHWFNS3wV7mK
         U9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUEajXtRfmiVdIkGjLnIXMblgLfPfDWWiXkHDuRW2P5kCxgT2KMjO1gK2T5sUbdRs95Fm1KWA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yye0XPb9O6yqu8zdBhGgztj2nInSY97VzCvatw6cxEWgzywHRB2
	8swQj5JvM3gLOGVdCsSwikxtS6JBDsU895/q5LpJas6VmnAXpFK0HrNi+TaCi97RmQAXamLlUmT
	+SSk28QOX2uB4AfY46FvdhESO+69rZDY=
X-Gm-Gg: ASbGncsXxpkXN9TGDeLDkTywV3P5XbKiaIzRDP5kbYzBMpmIKZ586unFGzELwCpMnOn
	7y0BA3c6DPRri6+DsEPDh/LWCnLgU0fa4qZ3RtHYQAOQTpD3w5UfWtAVltvKl5dSqmGAL/MMvAl
	OD3BxyTzbV8qCTJqydIz7TY+qwF7GwQYxR2cfJ3M+9lE8l0DSWdyudxX2VgPFFOMCB3l5kCjzxS
	gKnf3k=
X-Google-Smtp-Source: AGHT+IFVdAR+nALw2dfOwe/SBdedrjFoxCZWdT3hu72WG7PbkJMjT24657fyC8JNSjqGNYeNAeujPq9L90HfMwrRt4U=
X-Received: by 2002:a05:6102:3712:b0:4f9:6a91:133a with SMTP id
 ada2fe7eead31-4fa1523a607mr2737239137.27.1753350140982; Thu, 24 Jul 2025
 02:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250724085600.4101321-1-xiaqinxin@huawei.com>
 <20250724085600.4101321-3-xiaqinxin@huawei.com> <CAGsJ_4zVR3R7erGP57vxM8vKBARG8BttA=FsCVFjy4QtswcsQw@mail.gmail.com>
 <c7f7d9b3-2ab3-4ebd-99fb-071733573291@huawei.com>
In-Reply-To: <c7f7d9b3-2ab3-4ebd-99fb-071733573291@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 24 Jul 2025 17:42:03 +0800
X-Gm-Features: Ac12FXyOhPCNOJmuHWV1Cslha1U4fTMs742fhuCReMB40zYcc2mUNhkN5PvOnwU
Message-ID: <CAGsJ_4zSw57DMyRZM24BUdDpbi4+BRfgWUqxSKurCsAVC7Kptw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dma-mapping: benchmark: Add padding to ensure uABI
 remained consistent
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 5:35=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
>
>
> On 2025/7/24 17:07:08, Barry Song <21cnbao@gmail.com> wrote:
> > On Thu, Jul 24, 2025 at 4:56=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.co=
m> wrote:
> >>
> >> The padding field in the structure was previously reserved to
> >> maintain a stable interface for potential new fields, ensuring
> >> compatibility with user-space shared data structures.
> >> However,it was accidentally removed by tiantao in a prior commit,
> >> which may lead to incompatibility between user space and the kernel.
> >>
> >> This patch reinstates the padding to restore the original structure
> >> layout and preserve compatibility.
> >>
> >> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header =
file for map_benchmark definition")
> >> Cc: stable@vger.kernel.org
> >> Acked-by: Barry Song <baohua@kernel.org>
> >> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> >
> > I don=E2=80=99t think these two patches should be part of the same seri=
es. This
> > one is a bug fix and should be handled separately=E2=80=94ideally picke=
d up on
> > its own and backported to stable.
> >
> > Also, the subject should not say "Add"=E2=80=94it should be "Restore". =
I assume
> > Marek can handle it?
...
> Ok, I will send a new version to fix it.

If Marek can help fix it while picking it up into the dma-mapping tree, you
might not need to send a new version.

Honestly, I hope this gets merged soon=E2=80=94it feels like it's been
overdue for quite a while.

Thanks
Barry
