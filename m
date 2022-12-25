Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A196D20E2
	for <iommu@lists.linux.dev>; Sun, 25 Dec 2022 18:56:30 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id gh17so22634077ejb.6
        for <iommu@lists.linux.dev>; Sun, 25 Dec 2022 10:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAm0yOM0+s/U7gxlg+FgYD014KLak/J4twkxYMxVba4=;
        b=h7vsNd/knvpJaC1PJP13zpHllAOP+j8A7r2AqpuuPn6pQkSyB6TJVqjI4/SbD+03zq
         P5jXGHLhY3X4B314aZwGI+W8Ahu9r9IWm1dA32A2mWWLfpp8UmA4smQv0915AukIRvMm
         VTVWHQ6RE/7pYej1wr1rlgjTaHZal4xT8nSBDIqjHy7yeLuoFRQfnY6WHuU1vHhkPO2P
         TxVj1SZDPDPN2K+hW/u0ogec98+mXnxD1RCrV6qhToionfmQ8fm0kyt1jOdDEOyPjXRV
         hO0BF3IQGB1G15rbvkRGrKn4e55e7WiQJlYSdoTplVYqk5Oe8YU6ao1qIGKK9/fheEYc
         OEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAm0yOM0+s/U7gxlg+FgYD014KLak/J4twkxYMxVba4=;
        b=iWmuH68EhynxxanyfMl+vCNvl4Wqy1czu67FkmMwOmAyZcZkKvbUj3BTuLQnXcl/RN
         OIEIopQVLGwLKqnRxDeg1ga1khsDnOXKBWdx1TOILNrvbLX0mtxSOQSuVw+yZDJxQG5i
         nek2rp2cLHDgZ5ZoNilU3fI117ug3thk496oIPH3ElVrFNcuAZnZnLBDtN0MxXVOCRCt
         Yz7OKyFY5qoOkq6qRwKQG3OcD/rGmo1IpDiTvLVdWTXhVhU7pFe5weVWaawwpBsqrBWN
         7dFbp3dlxQnDuaBiuEEdR8uEv6gWt+rsijiWFmuWrtl1Vc2M3xf+WDQYc9druajxoWaY
         9o0g==
X-Gm-Message-State: AFqh2kqy4f71tGyRxJAWg6jF7I/q8wm328KH1dUZ+zJRq3PW9kV0aIyu
	B4GJRjcAp+W7YWxkiPQdoch3BYg/Pqsf+KFXofo=
X-Google-Smtp-Source: AMrXdXtpOhLJd+wLVMNcoiP4Ek229yaY6gHmNyv8YvIy0UwxKE+GLU+jKaZ/8zzcvMq/FwbtsfrpuMyLiowQI4RXmNk=
X-Received: by 2002:a17:907:c24d:b0:7c0:dfb7:62dc with SMTP id
 tj13-20020a170907c24d00b007c0dfb762dcmr1178188ejc.139.1671994588734; Sun, 25
 Dec 2022 10:56:28 -0800 (PST)
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
Date: Sun, 25 Dec 2022 19:56:17 +0100
Message-ID: <CAOkhzLUTNpq_hA9v1jZn9+919Hk43=+ouHG2f_u_g1Xt-m5tDA@mail.gmail.com>
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

The problem happens somewhere between Kernel Version 6.0 and 6.1-rc1.

So my Boot is fine with Kernel 6.0 but stops working with Kernel
version 6.1-rc1.

Best
Zeno
