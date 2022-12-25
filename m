Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C37E881B
	for <iommu@lists.linux.dev>; Sun, 25 Dec 2022 14:03:18 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id c17so12931652edj.13
        for <iommu@lists.linux.dev>; Sun, 25 Dec 2022 06:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DuTcTdyWe6Y84QMdROYViIK2QWcXLGLnMiYSgiOFsYk=;
        b=psLrQssVYx7uLAH/cW1OTvZDmxKVpJp4AgYPjNPeU6BzTetw6iTrL5mlapIVVmXLs4
         WOcm+KgrFTLSz2hshO8EnhZnP8Q1UNAQG7SadkbW6ByLvXqvfPHCc/oRJWAddvPEYGb8
         MdymNlaBt4mWERGggN9/ncvW830xYCuWMXtKJtY/RishVz6BEtOBski+RCiD5xfMoJBw
         q7ys6bEVFcHHzAYxtvKjl0oGc9O90QkmSl79YOWMLLDAern4BrE58KfbVpmoyX2UHmP8
         IZ/MT5XIMT8FrEt1FIxMjNRldDT6bzp9IN7SwQJs2sQVZWpMHv8gkV6m+d1hlZUaR/lN
         zCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DuTcTdyWe6Y84QMdROYViIK2QWcXLGLnMiYSgiOFsYk=;
        b=7FWGINQwABnH8luth70pqB2cPSw+G8/1IgpxyGvOEWEnmgym8tRGWdVJ75s3c0nqmD
         ogfjmF87TJjrbLvy0s3H92YGeW/YggE0voZvw7Ge2CWbDlp3ztD0U4AT5POjid7lbenp
         76lwhdHv+MR62ZvnpwjhdwpMz5zXFJxA8+XzcLaibX1u75QBm5+87HlpODtalM8LydKJ
         fUW/iHpPSwZ0Ppp3nWPe4C5BWN8XKQJ7wdgHkhyA9fJ9hIdC+7R2n88U/EsKmgOHES2l
         yxWRj7XofuPJTlfl0IDvicuwV4hAJ/IAFO8mHLLN48vpHAOn+d/R7ST5TIhbCIeuH8A1
         C/5A==
X-Gm-Message-State: AFqh2krcAtcYVaShHbT9dX9s5vQ4WbA/xNTSXprAW8E0Xfz85dSJnbuI
	jkb5+Wxh8VESHhGm0YN5DGP39b6gB+AFOeNfac/rnn1h+IM=
X-Google-Smtp-Source: AMrXdXuKTlfSaO4r4oKRfORhRE/L68DhBD50WBXrHhKQR5itFG+6xTsKlaMIzjfFAwVj0DNCcVZhoeDfpPTe3SMeKv8=
X-Received: by 2002:a05:6402:501f:b0:46f:77af:10ff with SMTP id
 p31-20020a056402501f00b0046f77af10ffmr1905874eda.178.1671976996465; Sun, 25
 Dec 2022 06:03:16 -0800 (PST)
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
Date: Sun, 25 Dec 2022 15:03:05 +0100
Message-ID: <CAOkhzLVBY9aVVT98bYtOAJc+EwYfnjru8fJcthNmwM8Z0V+y+A@mail.gmail.com>
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

Yes, I can try that. What is the git checkout hash, where I have to checkout at?

This hang is very strange. Did something change in the Kernel
enumeration process?

Best
Zeno
