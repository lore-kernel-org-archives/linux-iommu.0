Return-Path: <SRS0=iLvA=GK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA84C433DB
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 18:09:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F5D23403
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 18:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F5D23403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C1E1A204E7;
	Thu,  7 Jan 2021 18:09:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rNHVY2Nt3tuB; Thu,  7 Jan 2021 18:09:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 47358203E4;
	Thu,  7 Jan 2021 18:09:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CA32C088B;
	Thu,  7 Jan 2021 18:09:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C7B7C013A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 18:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 322DE86554
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 18:09:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dsJZmebqMDIJ for <iommu@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 18:09:45 +0000 (UTC)
X-Greylist: delayed 00:24:05 by SQLgrey-1.7.6
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7A23A85F6D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 18:09:45 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id f26so6286936qka.0
 for <iommu@lists.linux-foundation.org>; Thu, 07 Jan 2021 10:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lmRpyU02tzYzNNegjIihcCxZyXW1d2vZ/GdMFK5mnJk=;
 b=SoKXOKPjPIj0bNZqjL8jd3g1x++IpRUGavBgQZB48yjMr3FErg0/LB8QoBzIcQt/ka
 3uw3LzC05V0NXsnGkX2E/jViOUmBeqfz+Dm7BPkaUOwck9GE68NEStaDUzo2Ps4jBT44
 o0xJvs9naSndqu5VCEiuqFkwP8CanbrdeGCSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lmRpyU02tzYzNNegjIihcCxZyXW1d2vZ/GdMFK5mnJk=;
 b=GW9N/zJq0zAjAA7AjHDEbceYS4QFxVukdiNjaWkBzKR+6HV0kd5BFq/f+eBSl3+2m7
 gJdw/OeP/TTiy06XFGZDiw8xdentVIT8pnBJ1TIaR0kHvJQnegb3O1im3faEJg2H/o/8
 Z0y4hN9d6UEydzfteiR0lhJH7/zP2pLFthFaspL5xD9LR7HdGuOnObLi2U5NRNbbzYkz
 SKtR7YNafPnDLueAPv4axzArpMdjQRyBXqRP9jWbhOPLmVa60gumYenWNxrKYc9S1cs3
 YPk5P1VqiAeB9rKdB+HQaIDrd7ArEcPRsRBhMvjsLvdTHi0f4f1IB/fBrJUu3TkgkRXC
 kIRw==
X-Gm-Message-State: AOAM530C8Yp2E/x43Rxcp0JHjb35gCMPH1+gioX5XDCCVsncxQLGlsLz
 +XhqiUElR0miRTaN/Vcdz0gVMYLMPvrXePEs
X-Google-Smtp-Source: ABdhPJxvMPdde78I73suU2+139MPFl8pLIfszqOj6lIFWTRY5U4mltmXyhWyI/GbObZnsARfhvNiWA==
X-Received: by 2002:ae9:e308:: with SMTP id v8mr10129883qkf.339.1610041539405; 
 Thu, 07 Jan 2021 09:45:39 -0800 (PST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com.
 [209.85.160.174])
 by smtp.gmail.com with ESMTPSA id o29sm3147697qtl.7.2021.01.07.09.45.38
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Jan 2021 09:45:38 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id y15so4789412qtv.5
 for <iommu@lists.linux-foundation.org>; Thu, 07 Jan 2021 09:45:38 -0800 (PST)
X-Received: by 2002:a02:b709:: with SMTP id g9mr9101800jam.90.1610041143173;
 Thu, 07 Jan 2021 09:39:03 -0800 (PST)
MIME-Version: 1.0
References: <20210106034124.30560-1-tientzu@chromium.org>
 <d7043239-12cf-3636-4726-2e3b90917dc6@gmail.com>
In-Reply-To: <d7043239-12cf-3636-4726-2e3b90917dc6@gmail.com>
From: Claire Chang <tientzu@chromium.org>
Date: Fri, 8 Jan 2021 01:38:51 +0800
X-Gmail-Original-Message-ID: <CALiNf2_stqoY_wKXNgXFOcoSMkjpFhs5ZsM+jr27Z9pgDSJH_A@mail.gmail.com>
Message-ID: <CALiNf2_stqoY_wKXNgXFOcoSMkjpFhs5ZsM+jr27Z9pgDSJH_A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/6] Restricted DMA
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 mpe@ellerman.id.au, rafael.j.wysocki@intel.com, Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>, will@kernel.org,
 konrad.wilk@oracle.com, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
 boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 rdunlap@infradead.org, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
 Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1701428361363979113=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============1701428361363979113==
Content-Type: multipart/alternative; boundary="0000000000006a175905b852ea63"

--0000000000006a175905b852ea63
Content-Type: text/plain; charset="UTF-8"

On Thu, Jan 7, 2021 at 2:48 AM Florian Fainelli <f.fainelli@gmail.com>
wrote:
>
> Hi,
>
> First of all let me say that I am glad that someone is working on a
> upstream solution for this issue, would appreciate if you could CC and
> Jim Quinlan on subsequent submissions.

Sure!

>
>
> On 1/5/21 7:41 PM, Claire Chang wrote:
> > This series implements mitigations for lack of DMA access control on
> > systems without an IOMMU, which could result in the DMA accessing the
> > system memory at unexpected times and/or unexpected addresses, possibly
> > leading to data leakage or corruption.
> >
> > For example, we plan to use the PCI-e bus for Wi-Fi and that PCI-e bus
is
> > not behind an IOMMU. As PCI-e, by design, gives the device full access
to
> > system memory, a vulnerability in the Wi-Fi firmware could easily
escalate
> > to a full system exploit (remote wifi exploits: [1a], [1b] that shows a
> > full chain of exploits; [2], [3]).
> >
> > To mitigate the security concerns, we introduce restricted DMA.
Restricted
> > DMA utilizes the existing swiotlb to bounce streaming DMA in and out of
a
> > specially allocated region and does memory allocation from the same
region.
> > The feature on its own provides a basic level of protection against the
DMA
> > overwriting buffer contents at unexpected times. However, to protect
> > against general data leakage and system memory corruption, the system
needs
> > to provide a way to restrict the DMA to a predefined memory region
(this is
> > usually done at firmware level, e.g. in ATF on some ARM platforms).
>
> Can you explain how ATF gets involved and to what extent it does help,
> besides enforcing a secure region from the ARM CPU's perpsective? Does
> the PCIe root complex not have an IOMMU but can somehow be denied access
> to a region that is marked NS=0 in the ARM CPU's MMU? If so, that is
> still some sort of basic protection that the HW enforces, right?

We need the ATF support for memory MPU (memory protection unit).
Restricted DMA (with reserved-memory in dts) makes sure the predefined
memory
region is for PCIe DMA only, but we still need MPU to locks down PCIe
access to
that specific regions.

>
> On Broadcom STB SoCs we have had something similar for a while however
> and while we don't have an IOMMU for the PCIe bridge, we do have a a
> basic protection mechanism whereby we can configure a region in DRAM to
> be PCIe read/write and CPU read/write which then gets used as the PCIe
> inbound region for the PCIe EP. By default the PCIe bridge is not
> allowed access to DRAM so we must call into a security agent to allow
> the PCIe bridge to access the designated DRAM region.
>
> We have done this using a private CMA area region assigned via Device
> Tree, assigned with a and requiring the PCIe EP driver to use
> dma_alloc_from_contiguous() in order to allocate from this device
> private CMA area. The only drawback with that approach is that it
> requires knowing how much memory you need up front for buffers and DMA
> descriptors that the PCIe EP will need to process. The problem is that
> it requires driver modifications and that does not scale over the number
> of PCIe EP drivers, some we absolutely do not control, but there is no
> need to bounce buffer. Your approach scales better across PCIe EP
> drivers however it does require bounce buffering which could be a
> performance hit.

Only the streaming DMA (map/unmap) needs bounce buffering.
I also added alloc/free support in this series
(https://lore.kernel.org/patchwork/patch/1360995/), so dma_direct_alloc()
will
try to allocate memory from the predefined memory region.

As for the performance hit, it should be similar to the default swiotlb.
Here are my experiment results. Both SoCs lack IOMMU for PCIe.

PCIe wifi vht80 throughput -

  MTK SoC                  tcp_tx     tcp_rx    udp_tx   udp_rx
  w/o Restricted DMA  244.1     134.66   312.56   350.79
  w/ Restricted DMA    246.95   136.59   363.21   351.99

  Rockchip SoC           tcp_tx     tcp_rx    udp_tx   udp_rx
  w/o Restricted DMA  237.87   133.86   288.28   361.88
  w/ Restricted DMA    256.01   130.95   292.28   353.19

The CPU usage doesn't increase too much either.
Although I didn't measure the CPU usage very precisely, it's ~3% with a
single
big core (Cortex-A72) and ~5% with a single small core (Cortex-A53).

Thanks!
>
> Thanks!


On Thu, Jan 7, 2021 at 2:48 AM Florian Fainelli <f.fainelli@gmail.com>
wrote:

> Hi,
>
> First of all let me say that I am glad that someone is working on a
> upstream solution for this issue, would appreciate if you could CC and
> Jim Quinlan on subsequent submissions.
>
> On 1/5/21 7:41 PM, Claire Chang wrote:
> > This series implements mitigations for lack of DMA access control on
> > systems without an IOMMU, which could result in the DMA accessing the
> > system memory at unexpected times and/or unexpected addresses, possibly
> > leading to data leakage or corruption.
> >
> > For example, we plan to use the PCI-e bus for Wi-Fi and that PCI-e bus is
> > not behind an IOMMU. As PCI-e, by design, gives the device full access to
> > system memory, a vulnerability in the Wi-Fi firmware could easily
> escalate
> > to a full system exploit (remote wifi exploits: [1a], [1b] that shows a
> > full chain of exploits; [2], [3]).
> >
> > To mitigate the security concerns, we introduce restricted DMA.
> Restricted
> > DMA utilizes the existing swiotlb to bounce streaming DMA in and out of a
> > specially allocated region and does memory allocation from the same
> region.
> > The feature on its own provides a basic level of protection against the
> DMA
> > overwriting buffer contents at unexpected times. However, to protect
> > against general data leakage and system memory corruption, the system
> needs
> > to provide a way to restrict the DMA to a predefined memory region (this
> is
> > usually done at firmware level, e.g. in ATF on some ARM platforms).
>
> Can you explain how ATF gets involved and to what extent it does help,
> besides enforcing a secure region from the ARM CPU's perpsective? Does
> the PCIe root complex not have an IOMMU but can somehow be denied access
> to a region that is marked NS=0 in the ARM CPU's MMU? If so, that is
> still some sort of basic protection that the HW enforces, right?
>
> On Broadcom STB SoCs we have had something similar for a while however
> and while we don't have an IOMMU for the PCIe bridge, we do have a a
> basic protection mechanism whereby we can configure a region in DRAM to
> be PCIe read/write and CPU read/write which then gets used as the PCIe
> inbound region for the PCIe EP. By default the PCIe bridge is not
> allowed access to DRAM so we must call into a security agent to allow
> the PCIe bridge to access the designated DRAM region.
>
> We have done this using a private CMA area region assigned via Device
> Tree, assigned with a and requiring the PCIe EP driver to use
> dma_alloc_from_contiguous() in order to allocate from this device
> private CMA area. The only drawback with that approach is that it
> requires knowing how much memory you need up front for buffers and DMA
> descriptors that the PCIe EP will need to process. The problem is that
> it requires driver modifications and that does not scale over the number
> of PCIe EP drivers, some we absolutely do not control, but there is no
> need to bounce buffer. Your approach scales better across PCIe EP
> drivers however it does require bounce buffering which could be a
> performance hit.
>
> Thanks!
> --
> Florian
>

--0000000000006a175905b852ea63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Thu, Jan 7, 2021 at 2:48 AM Florian Fainelli &lt;<a hre=
f=3D"mailto:f.fainelli@gmail.com">f.fainelli@gmail.com</a>&gt; wrote:<br>&g=
t;<br>&gt; Hi,<br>&gt;<br>&gt; First of all let me say that I am glad that =
someone is working on a<br>&gt; upstream solution for this issue, would app=
reciate if you could CC and<br>&gt; Jim Quinlan on subsequent submissions.<=
br><br>Sure!<br><br>&gt;<br>&gt;<br>&gt; On 1/5/21 7:41 PM, Claire Chang wr=
ote:<br>&gt; &gt; This series implements mitigations for lack of DMA access=
 control on<br>&gt; &gt; systems without an IOMMU, which could result in th=
e DMA accessing the<br>&gt; &gt; system memory at unexpected times and/or u=
nexpected addresses, possibly<br>&gt; &gt; leading to data leakage or corru=
ption.<br>&gt; &gt;<br>&gt; &gt; For example, we plan to use the PCI-e bus =
for Wi-Fi and that PCI-e bus is<br>&gt; &gt; not behind an IOMMU. As PCI-e,=
 by design, gives the device full access to<br>&gt; &gt; system memory, a v=
ulnerability in the Wi-Fi firmware could easily escalate<br>&gt; &gt; to a =
full system exploit (remote wifi exploits: [1a], [1b] that shows a<br>&gt; =
&gt; full chain of exploits; [2], [3]).<br>&gt; &gt;<br>&gt; &gt; To mitiga=
te the security concerns, we introduce restricted DMA. Restricted<br>&gt; &=
gt; DMA utilizes the existing swiotlb to bounce streaming DMA in and out of=
 a<br>&gt; &gt; specially allocated region and does memory allocation from =
the same region.<br>&gt; &gt; The feature on its own provides a basic level=
 of protection against the DMA<br>&gt; &gt; overwriting buffer contents at =
unexpected times. However, to protect<br>&gt; &gt; against general data lea=
kage and system memory corruption, the system needs<br>&gt; &gt; to provide=
 a way to restrict the DMA to a predefined memory region (this is<br>&gt; &=
gt; usually done at firmware level, e.g. in ATF on some ARM platforms).<br>=
&gt;<br>&gt; Can you explain how ATF gets involved and to what extent it do=
es help,<br>&gt; besides enforcing a secure region from the ARM CPU&#39;s p=
erpsective? Does<br>&gt; the PCIe root complex not have an IOMMU but can so=
mehow be denied access<br>&gt; to a region that is marked NS=3D0 in the ARM=
 CPU&#39;s MMU? If so, that is<br>&gt; still some sort of basic protection =
that the HW enforces, right?<br><font face=3D"arial, sans-serif"><br>We nee=
d the ATF support for memory MPU (memory protection unit).<br>Restricted DM=
A (with reserved-memory in dts) makes sure the predefined memory</font><div=
><font face=3D"arial, sans-serif">region is for PCIe DMA only, but we still=
 need MPU to locks down PCIe access to</font></div><div><font face=3D"arial=
, sans-serif">that specific regions.<br><br>&gt;<br>&gt; On Broadcom STB So=
Cs we have had something similar for a while however<br>&gt; and while we d=
on&#39;t have an IOMMU for the PCIe bridge, we do have a a<br>&gt; basic pr=
otection mechanism whereby we can configure a region in DRAM to<br>&gt; be =
PCIe read/write and CPU read/write which then gets used as the PCIe<br>&gt;=
 inbound region for the PCIe EP. By default the PCIe bridge is not<br>&gt; =
allowed access to DRAM so we must call into a security agent to allow<br>&g=
t; the PCIe bridge to access the designated DRAM region.<br>&gt;<br>&gt; We=
 have done this using a private CMA area region assigned via Device<br>&gt;=
 Tree, assigned with a and requiring the PCIe EP driver to use<br>&gt; dma_=
alloc_from_contiguous() in order to allocate from this device<br>&gt; priva=
te CMA area. The only drawback with that approach is that it<br>&gt; requir=
es knowing how much memory you need up front for buffers and DMA<br>&gt; de=
scriptors that the PCIe EP will need to process. The problem is that<br>&gt=
; it requires driver modifications and that does not scale over the number<=
br>&gt; of PCIe EP drivers, some we absolutely do not control, but there is=
 no<br>&gt; need to bounce buffer. Your approach scales better across PCIe =
EP<br>&gt; drivers however it does require bounce buffering which could be =
a<br>&gt; performance hit.<br><br>Only the streaming DMA (map/unmap) needs =
bounce buffering.<br>I also added alloc/free support in this series<br>(<a =
href=3D"https://lore.kernel.org/patchwork/patch/1360995/">https://lore.kern=
el.org/patchwork/patch/1360995/</a>), so dma_direct_alloc() will</font></di=
v><div><font face=3D"arial, sans-serif">try to allocate memory from the pre=
defined memory region.<br><br>As for the performance hit, it should be simi=
lar to the default swiotlb.<br>Here are my experiment results. Both SoCs la=
ck IOMMU for PCIe.<br><br>PCIe wifi vht80 throughput -<br><br>=C2=A0 MTK So=
C =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcp_tx =C2=
=A0 =C2=A0 tcp_rx =C2=A0 =C2=A0udp_tx =C2=A0 udp_rx<br>=C2=A0 w/o Restricte=
d DMA =C2=A0244.1 =C2=A0 =C2=A0 134.66 =C2=A0 312.56 =C2=A0 350.79<br>=C2=
=A0 w/ Restricted DMA =C2=A0 =C2=A0246.95 =C2=A0 136.59 =C2=A0 363.21 =C2=
=A0 351.99<br><br>=C2=A0 Rockchip SoC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tc=
p_tx =C2=A0 =C2=A0 tcp_rx =C2=A0 =C2=A0udp_tx =C2=A0 udp_rx<br>=C2=A0 w/o R=
estricted DMA =C2=A0237.87 =C2=A0 133.86 =C2=A0 288.28 =C2=A0 361.88<br>=C2=
=A0 w/ Restricted DMA =C2=A0 =C2=A0256.01 =C2=A0 130.95 =C2=A0 292.28 =C2=
=A0 353.19<br><br>The CPU usage doesn&#39;t increase too much either.<br>Al=
though I didn&#39;t measure the CPU usage very precisely, it&#39;s ~3% with=
 a single</font></div><div><font face=3D"arial, sans-serif">big core (Corte=
x-A72) and ~5% with a single small core (Cortex-A53).<br><br>Thanks!<br>&gt=
;<br>&gt; Thanks!</font></div></div><br><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 7, 2021 at 2:48 AM Florian Fa=
inelli &lt;<a href=3D"mailto:f.fainelli@gmail.com">f.fainelli@gmail.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<=
br>
<br>
First of all let me say that I am glad that someone is working on a<br>
upstream solution for this issue, would appreciate if you could CC and<br>
Jim Quinlan on subsequent submissions.<br>
<br>
On 1/5/21 7:41 PM, Claire Chang wrote:<br>
&gt; This series implements mitigations for lack of DMA access control on<b=
r>
&gt; systems without an IOMMU, which could result in the DMA accessing the<=
br>
&gt; system memory at unexpected times and/or unexpected addresses, possibl=
y<br>
&gt; leading to data leakage or corruption.<br>
&gt; <br>
&gt; For example, we plan to use the PCI-e bus for Wi-Fi and that PCI-e bus=
 is<br>
&gt; not behind an IOMMU. As PCI-e, by design, gives the device full access=
 to<br>
&gt; system memory, a vulnerability in the Wi-Fi firmware could easily esca=
late<br>
&gt; to a full system exploit (remote wifi exploits: [1a], [1b] that shows =
a<br>
&gt; full chain of exploits; [2], [3]).<br>
&gt; <br>
&gt; To mitigate the security concerns, we introduce restricted DMA. Restri=
cted<br>
&gt; DMA utilizes the existing swiotlb to bounce streaming DMA in and out o=
f a<br>
&gt; specially allocated region and does memory allocation from the same re=
gion.<br>
&gt; The feature on its own provides a basic level of protection against th=
e DMA<br>
&gt; overwriting buffer contents at unexpected times. However, to protect<b=
r>
&gt; against general data leakage and system memory corruption, the system =
needs<br>
&gt; to provide a way to restrict the DMA to a predefined memory region (th=
is is<br>
&gt; usually done at firmware level, e.g. in ATF on some ARM platforms).<br=
>
<br>
Can you explain how ATF gets involved and to what extent it does help,<br>
besides enforcing a secure region from the ARM CPU&#39;s perpsective? Does<=
br>
the PCIe root complex not have an IOMMU but can somehow be denied access<br=
>
to a region that is marked NS=3D0 in the ARM CPU&#39;s MMU? If so, that is<=
br>
still some sort of basic protection that the HW enforces, right?<br>
<br>
On Broadcom STB SoCs we have had something similar for a while however<br>
and while we don&#39;t have an IOMMU for the PCIe bridge, we do have a a<br=
>
basic protection mechanism whereby we can configure a region in DRAM to<br>
be PCIe read/write and CPU read/write which then gets used as the PCIe<br>
inbound region for the PCIe EP. By default the PCIe bridge is not<br>
allowed access to DRAM so we must call into a security agent to allow<br>
the PCIe bridge to access the designated DRAM region.<br>
<br>
We have done this using a private CMA area region assigned via Device<br>
Tree, assigned with a and requiring the PCIe EP driver to use<br>
dma_alloc_from_contiguous() in order to allocate from this device<br>
private CMA area. The only drawback with that approach is that it<br>
requires knowing how much memory you need up front for buffers and DMA<br>
descriptors that the PCIe EP will need to process. The problem is that<br>
it requires driver modifications and that does not scale over the number<br=
>
of PCIe EP drivers, some we absolutely do not control, but there is no<br>
need to bounce buffer. Your approach scales better across PCIe EP<br>
drivers however it does require bounce buffering which could be a<br>
performance hit.<br>
<br>
Thanks!<br>
-- <br>
Florian<br>
</blockquote></div>

--0000000000006a175905b852ea63--

--===============1701428361363979113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1701428361363979113==--
