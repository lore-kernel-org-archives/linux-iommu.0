Return-Path: <SRS0=XM0R=PP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EDAC433F5
	for <iommu@archiver.kernel.org>; Wed, 27 Oct 2021 17:28:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D4D6109D
	for <iommu@archiver.kernel.org>; Wed, 27 Oct 2021 17:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 04D4D6109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C20C24040C;
	Wed, 27 Oct 2021 17:28:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GWdpUJpmBnqF; Wed, 27 Oct 2021 17:28:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 253A740139;
	Wed, 27 Oct 2021 17:28:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01FEDC0012;
	Wed, 27 Oct 2021 17:28:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 143EDC000E
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 17:28:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0412F80B8F
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 17:28:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U-r_wNp9acCz for <iommu@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 17:28:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4044C80B82
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 17:28:45 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 a17-20020a4a6851000000b002b59bfbf669so1167411oof.9
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 10:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wrZxhnpBVF+cF2MH+4hpGESknGnknZIvvFiYbEODzhk=;
 b=BPKmV1ZB5ebCw1S2IavTQsPuOPDm4WBZVvPMl8xkIMlg/OWb74QDL9Gl9wChwhEQ2r
 2wVgumPw/XQfIRncXfDOoiB+yINE59H6kZ5TaLp12p/OPl9kmtSY+dQIk7nygvKH8JeJ
 mla8QoY1HSDBbYn8sQwcErupLJi14EX3UUAgIljetwlliKtGtX06hd/YJA7DLK/azxmx
 nbYmsf85H72Tf5W7QEfa+X8/kFnTUys831ZX6RG3trxvc1AVSDI44kFGoFpZ0ROjxVeR
 oIc6oNGbuKNdTPdSv4oNqwlT9CEaLJ+q7hbETGhChOYkhhmfLQPx26MsaM31djQWr2pK
 RYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wrZxhnpBVF+cF2MH+4hpGESknGnknZIvvFiYbEODzhk=;
 b=jCoQCJcSDhuJY6JT4+d/r3MGsFeeF7I8ToI4X4DXuhMYTLtvhfSNEyIYbjY+eUHmsu
 U3MshClmlGODyZm3uNTyYwF26lJkM1uF3ml6h25H3dLMMYqhy2pBvB2VTRyXONDuIldq
 Q4YP8xtOmOkH1n5sXw2VtwiCB15fPPQQ2OZsQOO1ItttkykYYc9Bk6tOrZjp+goIzXXI
 CONovaJ4IBav1AcAM5wOF3beZjNcDNdfRdi+Llye18tH9G4bjMBhM67cmHiAe2XFsjyV
 r6A1q7Oe3E1RCQYP4bJ78SVgVIjG91xNk33blPUeMA3tEagnjQSs6R7+8Rhjz8KfQA7O
 s14g==
X-Gm-Message-State: AOAM532Gou4LA6vId68NjyJ+CTu0Rdi9gUYinYvaXlvZ9baBS26BDhPL
 FZXUVJAUbcZ2A4Wx7erdcDGIlcvD9m7rDfKKxhw=
X-Google-Smtp-Source: ABdhPJym6erSPEWJi1GKR1ra3PnGgufMkBKXgAkuizRFvk+0fbhMwySLArEFu+scGYoFci8xM0rNFjPMYcpXO2GU4k8=
X-Received: by 2002:a4a:8508:: with SMTP id k8mr5473333ooh.23.1635355724247;
 Wed, 27 Oct 2021 10:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <7a5123b0-6370-59dc-f0c2-8be5b370d9ba@molgen.mpg.de>
 <0cfccc44-6cc6-98f5-ecd6-2f376839ec18@gmail.com>
 <bc7142a1-82d3-43bf-dee2-25f9297e7182@arm.com>
 <3c2de089-8f80-3644-7735-7df1c6151d70@molgen.mpg.de>
 <82fccb9d-43e8-4485-0ddb-7ff260f3ed32@arm.com>
 <CADnq5_NiigOVnahNWrro+ur2aejcHLTLJMH5ndUyg3cO8E+NRw@mail.gmail.com>
In-Reply-To: <CADnq5_NiigOVnahNWrro+ur2aejcHLTLJMH5ndUyg3cO8E+NRw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Oct 2021 13:28:32 -0400
Message-ID: <CADnq5_O6KfZKJBDTPn6jJrFg12bRssHAvx1u9m39xiGvu=_dhw@mail.gmail.com>
Subject: Re: I got an IOMMU IO page fault. What to do now?
To: Robin Murphy <robin.murphy@arm.com>
Content-Type: multipart/mixed; boundary="000000000000074a4b05cf58ed5e"
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Xinhui Pan <Xinhui.Pan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Alex Deucher <alexander.deucher@amd.com>, it+linux-iommu@molgen.mpg.de,
 Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--000000000000074a4b05cf58ed5e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 27, 2021 at 1:24 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Oct 27, 2021 at 1:20 PM Robin Murphy <robin.murphy@arm.com> wrote=
:
> >
> > On 27/10/2021 5:45 pm, Paul Menzel wrote:
> > > Dear Robin,
> > >
> > >
> > > On 25.10.21 18:01, Robin Murphy wrote:
> > >> On 2021-10-25 12:23, Christian K=C3=B6nig wrote:
> > >
> > >>> not sure how the IOMMU gives out addresses, but the printed ones lo=
ok
> > >>> suspicious to me. Something like we are using an invalid address li=
ke
> > >>> -1 or similar.
> > >>
> > >> FWIW those look like believable DMA addresses to me, assuming that t=
he
> > >> DMA mapping APIs are being backed iommu_dma_ops and the device has a
> > >> 40-bit DMA mask, since the IOVA allocator works top-down.
> > >>
> > >> Likely causes are either a race where the dma_unmap_*() call happens
> > >> before the hardware has really stopped accessing the relevant
> > >> addresses, or the device's DMA mask has been set larger than it shou=
ld
> > >> be, and thus the upper bits have been truncated in the round-trip
> > >> through the hardware.
> > >>
> > >> Given the addresses involved, my suspicions would initially lean
> > >> towards the latter case - the faults are in the very topmost pages
> > >> which imply they're the first things mapped in that range. The other
> > >> contributing factor being the trick that the IOVA allocator plays fo=
r
> > >> PCI devices, where it tries to prefer 32-bit addresses. Thus you're
> > >> only likely to see this happen once you already have ~3.5-4GB of liv=
e
> > >> DMA-mapped memory to exhaust the 32-bit IOVA space (minus some
> > >> reserved areas) and start allocating from the full DMA mask. You
> > >> should be able to check that with a 5.13 or newer kernel by booting
> > >> with "iommu.forcedac=3D1" and seeing if it breaks immediately
> > >> (unfortunately with an older kernel you'd have to manually hack
> > >> iommu_dma_alloc_iova() to the same effect).
> > >
> > > I booted Linux 5.15-rc7 with `iommu.forcedac=3D1` and the system boot=
ed,
> > > and I could log in remotely over SSH. Please find the Linux kernel
> > > messages attached. (The system logs say lightdm failed to start, but =
it
> > > might be some other issue due to a change in the operating system.)
> >
> > OK, that looks like it's made the GPU blow up straight away, which is
> > what I was hoping for (and also appears to reveal another bug where it'=
s
> > not handling probe failure very well - possibly trying to remove a
> > non-existent audio device?). Lightdm presumably fails to start because
> > it doesn't find any display devices, since amdgpu failed to probe.
> >
> > If you can boot the same kernel without "iommu.forcedac" and get a
> > successful probe and working display, that will imply that it is
> > managing to work OK with 32-bit DMA addresses, at which point I'd have
> > to leave it to Christian and Alex to figure out exactly where DMA
> > addresses are getting mangled. The only thing that stands out to me is
> > the reference to "gfx_v6_0", which makes me wonder whether it's related
> > to gmc_v6_0_sw_init() where a 44-bit DMA mask gets set. If so, that
> > would suggest that either this particular model of GPU is more limited
> > than expected, or that SoC only has 40 bits of address wired up between
> > the PCI host bridge and the IOMMU.
>
> That device only has a 40 bit DMA mask.  It looks like the code is wrong =
there.

The attached patch should fix it.

Alex

--000000000000074a4b05cf58ed5e
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-gmc6-fix-DMA-mask.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-gmc6-fix-DMA-mask.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kv9ske4n0>
X-Attachment-Id: f_kv9ske4n0

RnJvbSAzOTczNWY3NjEyMzRmYTQ4MGQzOTNiMTQ3N2RkOWQ0MDA2NzgzZjM0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFdlZCwgMjcgT2N0IDIwMjEgMTM6MjY6MTkgLTA0MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1L2dtYzY6IGZpeCBETUEgbWFzawoKVGhlIERNQSBtYXNrIG9uIFNJIHBhcnRz
IGlzIDQwIGJpdHMgbm90IDQ0LiAgTG9va3MgbGlrZSBhIGNvcHkKcGFzdGUgdHlwby4KClNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjZfMC5jIHwgMiArLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y2XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192Nl8wLmMKaW5kZXggMGU4MWUwM2U5YjQ5Li5hOTM1NGNiMmQ2MzkgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192Nl8wLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ21jX3Y2XzAuYwpAQCAtODQxLDcgKzg0MSw3IEBAIHN0YXRpYyBpbnQg
Z21jX3Y2XzBfc3dfaW5pdCh2b2lkICpoYW5kbGUpCiAKIAlhZGV2LT5nbWMubWNfbWFzayA9IDB4
ZmZmZmZmZmZmZlVMTDsKIAotCXIgPSBkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KGFkZXYtPmRl
diwgRE1BX0JJVF9NQVNLKDQ0KSk7CisJciA9IGRtYV9zZXRfbWFza19hbmRfY29oZXJlbnQoYWRl
di0+ZGV2LCBETUFfQklUX01BU0soNDApKTsKIAlpZiAocikgewogCQlkZXZfd2FybihhZGV2LT5k
ZXYsICJObyBzdWl0YWJsZSBETUEgYXZhaWxhYmxlLlxuIik7CiAJCXJldHVybiByOwotLSAKMi4z
MS4xCgo=
--000000000000074a4b05cf58ed5e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--000000000000074a4b05cf58ed5e--
