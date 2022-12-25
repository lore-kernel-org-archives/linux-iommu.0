Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47E0881F
	for <iommu@lists.linux.dev>; Sun, 25 Dec 2022 14:27:08 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id fc4so21749622ejc.12
        for <iommu@lists.linux.dev>; Sun, 25 Dec 2022 06:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l0HQo0Uft0T8VxsKwPRkMhcgNln9pBoHhuFSGzN1zn8=;
        b=b1FiBf0gQjcjcgGEIuv6yVR8jv6iYP8N/dboBANVF5S92hEvFO1iOAF/SK4iQ44Rjc
         jDH/1hppfhsxc4y6XD5dG0Bq6R9UY7gcp67n5/gaMYCWmgz88ri2SSLrubyYZWROedt2
         4ZU8xhP8qR4yWIAeufpKYnKk6LYG/9hl42UL/BVwFXS5IYOZVuoo6jzh7vrkyXP6Y6Ak
         t9OpLA4ZPIeaWo9ihDlzVvyQtYbiz9+H/SLYEim3aVt2IXVP+sVJ+wWmh+NHfP0PmPF9
         G3M89cJSRXsiYqrnt5vc8B5CCCGc7bBEv1OvetqY3LPL58vr5d5lZtxwiSaKEw1RRXEd
         /QBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0HQo0Uft0T8VxsKwPRkMhcgNln9pBoHhuFSGzN1zn8=;
        b=qZwZH1F6mEj2MG3Rc29TKonaq2PWPOCD4rQewpZOudQxHsvYlJlhzA5cwAKQUhy7Sl
         WVynFv6Z0A0R1k8cIMl+L7mYX+jckujBuPvgOxaygP1pyiHAktlUHVknxhOCiYQ9b6FK
         0nWRF2D1CO82CfLcpkaFt5SOKZBx7T3PE1Ie5oshhU8H3FwBvWeTyJwicF29DPaaII2z
         1kRs15WJ4GGudNGNlwmjMzfNjwzTJiV0zwtBwwotBA9BZi5oal1AHBEm/BlJXfP6weVm
         8GA/wN2SLDX8xf/7C8Rr3s27+iN47FhvtSHrGjGM95s0A7lvOFpBWxNbRyDCqxDrCrue
         fwWw==
X-Gm-Message-State: AFqh2kq1jwCFyUJheshJ/osuVwM+cigr6Im2Txh2Al1FA6aOMNDY5DWa
	vC11Ac19bbYP7cNKLIbob7Xt0/TSvZYCjBH28gI=
X-Google-Smtp-Source: AMrXdXumUZ0egLCgdNl+lat9zn+x+X7k504TH6k/KmHZcmWIEf8pX/Lu9CfWyS/UmPDBJiOZ9JiJ6KM41R4UN67hDr0=
X-Received: by 2002:a17:906:4f12:b0:77f:9082:73c7 with SMTP id
 t18-20020a1709064f1200b0077f908273c7mr839677eju.517.1671978427064; Sun, 25
 Dec 2022 06:27:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <D41A3A42-2412-4722-9090-01565058E525@gmail.com>
 <6531c0eb-5ca7-9026-a8b7-eb4442629d0d@linux.intel.com> <CAOkhzLWJzYoE-1b02ZLra=1FF7WjLYznf_PwMEAQWB0NGJsJhw@mail.gmail.com>
 <1c3be2ab-43af-cac7-fa0b-f3118b4e714e@linux.intel.com>
In-Reply-To: <1c3be2ab-43af-cac7-fa0b-f3118b4e714e@linux.intel.com>
From: Zeno Davatz <zdavatz@gmail.com>
Date: Sun, 25 Dec 2022 15:26:55 +0100
Message-ID: <CAOkhzLW-GttO2fA-qaQ5eAu02VoOhxR7sG2u9itVCvcbrCxrzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix PCI device reference count leak in
 has_external pci()
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: wangxiongfeng2@huawei.com, dwmw2@infradead.org, iommu@lists.linux.dev, 
	joro@8bytes.org, jroedel@suse.de, robin.murphy@arm.com, will@kernel.org, 
	yangyingliang@huawei.com
Content-Type: text/plain; charset="UTF-8"

Dear Baolu

On Sun, Dec 25, 2022 at 2:52 PM Baolu Lu <baolu.lu@linux.intel.com> wrote:
>
> On 2022/12/25 21:37, Zeno Davatz wrote:
> > On Sun, Dec 25, 2022 at 2:16 PM Baolu Lu<baolu.lu@linux.intel.com>  wrote:
> >> On 2022/12/25 20:11, Zeno Davatz wrote:
> >>> Hi
> >>>
> >>> I am getting this hang with kernel 6.1. See attachment.
> >>>
> >>> Is this related to your patch?
> >>>
> >>> Kernel 6.1 does not boot for me. Kernel 6.0 was fine.
> >> It seems unlikely.
> >>
> >> Have you located the patch through the bisect tool? Or does it boot well
> >> if you revert this patch?
> > I did not bisect the patch. All I currently know is that version 5.5
> > and version 6.0 of the Kernel booted fine for me.
> >
> > I test every Kernel release and normally the boot process goes flawless.
> >
> > The patch I am referring to is also mentioned by Linus in the Kernel
> > log, AFAICT tell the only PCI patch.
> >
> > https://lkml.org/lkml/2022/12/11/206
>
> I didn't find any reference to this patch in above thread. Can you
> please elaborate a bit more?
>
> By the way, from the video you shared, the hang happens in the PCI
> enumeration process. This patch touched the code that only executes
> after that.
>
> Can you please simply revert this patch and check the boot again?

I am also seeing some "refcount" mentions here:
https://lore.kernel.org/lkml/CAHk-=wgyXu4D44b8wQU9dpTYUft6WhZ0wr3nV1fziy6k0GwCCw@mail.gmail.com/

Best
Zeno
