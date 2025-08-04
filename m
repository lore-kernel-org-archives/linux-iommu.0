Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68302634
	for <iommu@lists.linux.dev>; Mon,  4 Aug 2025 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754344691; cv=none; b=gkpSC9QJ6kclpNnlNGJQtnB3gOZ6mS546tFQT0aSso1r+tLNjAdsPhnRimchLw/NqyYNuw/JR+DtCwjxRzbXj/gHAs5xARjb4y4ncrJT/5ie82NpNPZbNJAphJq4y+o+006C6rh6FeRw/QiWaQ/Gv8pMmG2MARXYGAu1BGWsPHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754344691; c=relaxed/simple;
	bh=phZmo8auP3zVfADAYrT3k9fDcseX1eOIimkL6q/sHz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G36GFB8USiM4JN7yIbP8KXKlT1znd3hu6D6rfK1knmDTImXuOmZMeHyHCMDabFm/ncpMc8N21j+fBZeTjwTmLHfWJ99Z7hZ18C0Zpk6uqqaqS88rV5C+3ZKaH7H3ImIojhWJTAKakvbDHzTqnoyJy6pL67w3Hn+7h2uPMlhYMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFqaTC+j; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFqaTC+j"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5395f460fe6so2056842e0c.3
        for <iommu@lists.linux.dev>; Mon, 04 Aug 2025 14:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754344688; x=1754949488; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phZmo8auP3zVfADAYrT3k9fDcseX1eOIimkL6q/sHz4=;
        b=GFqaTC+j0dNl1L2b83+pv/4dDtpnnUJ22fOHKnnbLd3vP4mPf5bc46kFnvUsLM0HbU
         WQf//vNld6t4yJAyYyAeFllb+riJS51/NCpdMEwi9G1ZIwdUKcvB2Yi5gL1LrLbgcAFz
         xsGv9xCntUSVQu76bFm4uTsDMLoXo2Hk84+i2or7LFiyc1lBN8jNgF6eGASJDzCoFFwt
         aqTLuyvix3igHXWwK5rrA8PRPrQM5vm2UkXISmHC8wVnm8bQ/+JL5gAnamLjMqtih2Fz
         7oNMgzA556T0mZI2RrxmE+S1HWN1SmCpKnQRWIB4dsVLxGshoNpZQDorzVo7Q7T6uHuQ
         vLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754344688; x=1754949488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phZmo8auP3zVfADAYrT3k9fDcseX1eOIimkL6q/sHz4=;
        b=Rpv+cSnYEx+zbiunqHZZVWEYUW/G79R/WqiT5eHoiivBZ1hThtkOby9GGxa+fzt/oH
         riry+lyFhTnf8wsX6wpP9rK0AdEUa9ceQrUNzmbbKcB9/rp94KqJjZbWN6mzXEeVymM3
         64vsEoc+RGFcArFl9hsKkF4JKGOsFIe8CRfuRMDLLSB79kSU03Ca4vO55VWTIrUtywgB
         44I5EwNVPv2bWL0BYyt3akEOKYKqheweDcVAW0NKMJ+z+Q90f4WyTWVBW0NC1w6QA7ei
         loF898CNUBgAIIdV4kfjlmUXPxojpns8mP6FG6oExM3sS3Opko4/cpzpYexLNqqPA+Ao
         IYkw==
X-Forwarded-Encrypted: i=1; AJvYcCWyB2jhyHSPo3kVMkpjNK5CJMFkCehT9v0vhc5z0md/J4haHq6I3h4esTuURU3ajBKx563LhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx12khICK8zLFPQL2RfW0FC9VBpYo3DgTlKC1HvSzqNuElIMhFw
	5f+HXeL0S4blpNCCT+QwC/yG1ophky8k+a4YpxgiSIMiSDUY8A4zauMKiuVV95Z75BTPIlN5Xy2
	WrKtE5fqPPJelSMw/KHn+N++y+4/eGbcU0qv8
X-Gm-Gg: ASbGncsBDdrYnv+0w/Sqsi92bw860Zo/SwswWuT/Yh5YBIPJKAzFyomrlbfvnCP0BCU
	rBDoFqu8MrYK+rByrEKcWNvoVBMucomPMIGhn5gfHo7mXBYuZzbeLeObg3Yvuxj/1Lic27//Cki
	8QkRiK+QlOEm7znlUggPz8DEmNRbR3bl+Y8YGz+fZ0VceIxdd6w/J3vI4swrwzwN2QxE5oUsi+m
	KtnrNc=
X-Google-Smtp-Source: AGHT+IGfAD+S6/axI2iYnVbYKCPQDEYT/sroxutjW5MwuDrsaywilPtrk/418Wgx5uDA2xg4jzQfTK07V6LqF3Dx+5A=
X-Received: by 2002:a05:6122:4585:b0:532:fc17:7839 with SMTP id
 71dfb90a1353d-5395f0d5705mr5179241e0c.2.1754344688081; Mon, 04 Aug 2025
 14:58:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250724085600.4101321-1-xiaqinxin@huawei.com>
 <20250724085600.4101321-3-xiaqinxin@huawei.com> <CAGsJ_4zVR3R7erGP57vxM8vKBARG8BttA=FsCVFjy4QtswcsQw@mail.gmail.com>
 <c7f7d9b3-2ab3-4ebd-99fb-071733573291@huawei.com> <CGME20250724094224eucas1p13a911259338ac1890d4baed8b9998fb0@eucas1p1.samsung.com>
 <CAGsJ_4zSw57DMyRZM24BUdDpbi4+BRfgWUqxSKurCsAVC7Kptw@mail.gmail.com>
 <f8c0cbdc-9c68-46bb-8dad-1d7c80f3f741@samsung.com> <CAGsJ_4zs8=n+J4Xtd=Un8+p3c=FCOTji9qMfBsOKcc8sFG0v9A@mail.gmail.com>
 <c5170042-ac38-b0db-ba51-c5fce5363d40@huawei.com>
In-Reply-To: <c5170042-ac38-b0db-ba51-c5fce5363d40@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 5 Aug 2025 09:57:57 +1200
X-Gm-Features: Ac12FXwU_Fw8azMCD-b6SxxAp3g9GwaEPrqSRpBFjjlK5ZyS0hml8lQvXIGgnos
Message-ID: <CAGsJ_4yXrFVt5UM-6RqFcia8Qhgg6np7+=7ie7xOk1kSYhLH6A@mail.gmail.com>
Subject: Re: [PATCH 2/2] dma-mapping: benchmark: Add padding to ensure uABI
 remained consistent
To: Yicong Yang <yangyicong@huawei.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Qinxin Xia <xiaqinxin@huawei.com>, robin.murphy@arm.com, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, yangyicong@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 8:12=E2=80=AFPM Yicong Yang <yangyicong@huawei.com> =
wrote:
>
> Hi Barry,
>
> On 2025/8/4 12:47, Barry Song wrote:
> > On Tue, Jul 29, 2025 at 8:32=E2=80=AFPM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> >>
> >> On 24.07.2025 11:42, Barry Song wrote:
> >>> On Thu, Jul 24, 2025 at 5:35=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.=
com> wrote:
> >>>> On 2025/7/24 17:07:08, Barry Song <21cnbao@gmail.com> wrote:
> >>>>> On Thu, Jul 24, 2025 at 4:56=E2=80=AFPM Qinxin Xia <xiaqinxin@huawe=
i.com> wrote:
> >>>>>> The padding field in the structure was previously reserved to
> >>>>>> maintain a stable interface for potential new fields, ensuring
> >>>>>> compatibility with user-space shared data structures.
> >>>>>> However,it was accidentally removed by tiantao in a prior commit,
> >>>>>> which may lead to incompatibility between user space and the kerne=
l.
> >>>>>>
> >>>>>> This patch reinstates the padding to restore the original structur=
e
> >>>>>> layout and preserve compatibility.
> >>>>>>
> >>>>>> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common hea=
der file for map_benchmark definition")
> >>>>>> Cc: stable@vger.kernel.org
> >>>>>> Acked-by: Barry Song <baohua@kernel.org>
> >>>>>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> >>>>> I don=E2=80=99t think these two patches should be part of the same =
series. This
> >>>>> one is a bug fix and should be handled separately=E2=80=94ideally p=
icked up on
> >>>>> its own and backported to stable.
> >>>>>
> >>>>> Also, the subject should not say "Add"=E2=80=94it should be "Restor=
e". I assume
> >>>>> Marek can handle it?
> >>> ...
> >>>> Ok, I will send a new version to fix it.
> >>> If Marek can help fix it while picking it up into the dma-mapping tre=
e, you
> >>> might not need to send a new version.
> >>>
> >>> Honestly, I hope this gets merged soon=E2=80=94it feels like it's bee=
n
> >>> overdue for quite a while.
> >>
> >> I'm sorry, I wasn't aware that this need to go via dma-mapping tree. I
> >> will take it after this merge window.
> >
> > Thank you, Marek! I also noticed that Xiang Chen=E2=80=99s email has be=
en invalid
> > for quite a while, likely he moved to another company some time ago. It=
 looks
> > like Yicong has volunteered to take this on:
> >
> > https://lkml.indiana.edu/2408.1/08865.html
> >
> > I'm not sure if that's still the case. If it is, would Yicong be able t=
o
> > resend the email with my ack?
> >
>
> thanks for reminding. I think currently Qinxin is more suitable to help w=
ith this.
> she's working on the smmu stuffs and help look after this benchmark tool =
internally
> for some time :)
>
> Maybe she can help along with you (ack the fact that you're always helpin=
g to review
> the codes) if it's ok with you.

Certainly, Qinxin is welcome to take over. I will be glad to review
the code when time
permits, although my schedule is typically quite occupied with mm.

Thanks
Barry
