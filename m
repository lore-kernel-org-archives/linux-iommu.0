Return-Path: <SRS0=8Bah=3X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7668CC3524D
	for <iommu@archiver.kernel.org>; Mon,  3 Feb 2020 09:28:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EFDD20658
	for <iommu@archiver.kernel.org>; Mon,  3 Feb 2020 09:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3YnFVfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFDD20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0E89986064;
	Mon,  3 Feb 2020 09:28:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JWX+OAVL+SHe; Mon,  3 Feb 2020 09:28:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 97E0B85F6D;
	Mon,  3 Feb 2020 09:28:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 671FEC1D80;
	Mon,  3 Feb 2020 09:28:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80402C0174
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 09:28:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 650E4203D5
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 09:28:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HvpwIHjaMa+U for <iommu@lists.linux-foundation.org>;
 Mon,  3 Feb 2020 09:28:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 by silver.osuosl.org (Postfix) with ESMTPS id C8F63203A8
 for <iommu@lists.linux-foundation.org>; Mon,  3 Feb 2020 09:28:09 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id x14so13776034ljd.13
 for <iommu@lists.linux-foundation.org>; Mon, 03 Feb 2020 01:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B47qx31XKDa7NMcDDuZL/S2vVsRTqXVAhY1J3a5iDQo=;
 b=b3YnFVfsnb1vVy/MNAmzdHXX8B5yeWs9LagJmXcwNGVfxJaEIfIvNyZGFW7a5hydcW
 j2QaM9ZCGxry+imiUIK3akQzhpIClZZ9IYft1V4bKBWh7qH3XuGxpLkIDiK/GrATUrPW
 x/ENi2GxZgee6Iz+IO5mVcOauKjwuBOC3yu4lrVlHTFmKYtAF3RV1n+9jAb+ahUiF7uM
 yFgIhC57gs2RZ6PlhCtSYTyfCX3O4cgL7g8M4P6Amhs7c4a7CWE2E/wsfHLeYffOJy2V
 jCMoY3O4JWroW+/L5Muw6NNyI5fI7wbNzv9549deaWKmB70WQz7AobYI2h3cFOdWnMoi
 tnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B47qx31XKDa7NMcDDuZL/S2vVsRTqXVAhY1J3a5iDQo=;
 b=slDjNyNgGCdDv5iP9pA3LCDWE6IBycpDT8cDOwY/O31q60Aq07gBMRkQXZ+ut+TVsA
 f0L6Wo6IfMkvgk0bxdJt/XJC6s0xWXUrqQOwBa8lpOh5GHBKXlBaFBDkX+hBZMSGM++4
 n11dui8KV+uT7atf1WDkybtomWcAU4LAoh63r+fpQH9Mm0xue/HFGbd2CwQTAOohgSKY
 tAGjR9YwejRaY5DBRLRY3XWg6yaxPyUwoGXBGcFDoC2K/FhSNp0zCvqSPwbtlNWdEGzU
 rwzuyZbqV0OTE4TdcXOA7CchMz7T8mtALybXia7Vcp+eMLiV8jsuoDXV/aVKJz2woY0A
 00pw==
X-Gm-Message-State: APjAAAXVXrzqHcF/xdDCdjqI6QU459e/eQXmift7nLi57BGvMrCi24Dc
 y11ppV6cah5PVm+BHt1fvXy8/OhxB89w/bvOcsI=
X-Google-Smtp-Source: APXvYqzpZ19W40GIYWfmLaVAIflBfokkuMO9pbThxEM0V5pcSm0CKOTo6ygSF18J5GcoIL1i8R4XmnzNbg075hDDK6k=
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr13515247ljk.201.1580722087738; 
 Mon, 03 Feb 2020 01:28:07 -0800 (PST)
MIME-Version: 1.0
References: <CAJ9qOnVSKAeBst8KmOE3U+mnhwaTWYHi6+=z6054koX6QKA9EA@mail.gmail.com>
 <7a147a10-c472-2fcd-b45f-215dd6c96b7c@linux.intel.com>
In-Reply-To: <7a147a10-c472-2fcd-b45f-215dd6c96b7c@linux.intel.com>
From: Thomas G <thomas.grudzien@gmail.com>
Date: Mon, 3 Feb 2020 10:27:56 +0100
Message-ID: <CAJ9qOnVFBzSHPJ=fmhk-nv-0h=SYgx=kj+vKnHS06F96opHXoQ@mail.gmail.com>
Subject: Re: (new error in kernel 5.5) DMAR: [Firmware Bug]: No firmware
 reserved region can cover this RMRR
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org
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
Content-Type: multipart/mixed; boundary="===============7262775507638822266=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============7262775507638822266==
Content-Type: multipart/alternative; boundary="0000000000008743ad059da88a32"

--0000000000008743ad059da88a32
Content-Type: text/plain; charset="UTF-8"

Thanks Baolu, I'll wait for 5.6 then.
In the meanwhile I'll also try to contact Asrock, without much hope they
actually patch their bios.

Best regards

On Mon, Feb 3, 2020 at 2:34 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi Thomas,
>
> Below commit is supposed to fix this issue. It's currently in
> x86/vt-d branch of the iommu tree, and will be part of v5.6-rc1.
>
> commit f5a68bb0752e0cf77c06f53f72258e7beb41381b
> Author: Barret Rhoden <brho@google.com>
> Date:   Wed Jan 15 11:03:56 2020 +0800
>
>      iommu/vt-d: Mark firmware tainted if RMRR fails sanity check
>
>      RMRR entries describe memory regions that are DMA targets for devices
>      outside the kernel's control.
>
>      RMRR entries that fail the sanity check are pointing to regions of
>      memory that the firmware did not tell the kernel are reserved or
>      otherwise should not be used.
>
>      Instead of aborting DMAR processing, this commit marks the firmware
>      as tainted. These RMRRs will still be identity mapped, otherwise,
>      some devices, e.x. graphic devices, will not work during boot.
>
>      Signed-off-by: Barret Rhoden <brho@google.com>
>      Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>      Fixes: f036c7fa0ab60 ("iommu/vt-d: Check VT-d RMRR region in BIOS
> is reported as reserved")
>      Signed-off-by: Joerg Roedel <jroedel@suse.de>
>
> Best regards,
> baolu
>
> On 2020/2/3 5:06, Thomas G wrote:
> > Dear all,
> >
> > Vt-d seems to be broken since I upgraded to kernel 5.5, there is a new
> > dmesg that was not there in 5.4:
> > "DMAR: [Firmware Bug]: No firmware reserved region can cover this RMRR
> > [0x0000000041d92000-0x0000000041d94fff], contact BIOS vendor for fixes"
> >
> > System motherboard is Asrock X299 Taichi XE, bios 1.70, CPU is Core i9
> 7920
> > Vt-d and gpu passthrough was working ok since kernel 4.20 when I
> > purchased it
> >
> > I attached the dmesg I get with kernel 5.5.1, and the dmesg from 5.4.17.
> >
> > Also, I use the following script that displays the IOMMU groups, I found
> > the script there
> > https://wiki.archlinux.org/index.php/PCI_passthrough_via_OVMF
> >
> > #!/bin/bash
> > shopt -s nullglob
> > for d in /sys/kernel/iommu_groups/*/devices/*; do
> >      n=${d#*/iommu_groups/*}; n=${n%%/*}
> >      printf 'IOMMU Group %s ' "$n"
> >      lspci -nns "${d##*/}"
> > done;
> >
> > The output of this script with kernel 5.4.17 is attached to this email.
> > The same script with kernel 5.5.1 produces an empty output
> >
> > Hope it helps narrowing down the problem, please ask additional info if
> > needed. Sorry if this is not submitted as it should be (then please
> > advise), first time I report -what apprears to be- a bug.
> >
> > Best,
> > Thomas
>

--0000000000008743ad059da88a32
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks Baolu, I&#39;ll wait for 5.6 then.</div><div>I=
n the meanwhile I&#39;ll also try to contact Asrock, without much hope they=
 actually patch their bios.</div><div><br></div><div>Best regards<br></div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Mon, Feb 3, 2020 at 2:34 AM Lu Baolu &lt;<a href=3D"mailto:baolu.lu@linu=
x.intel.com">baolu.lu@linux.intel.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Hi Thomas,<br>
<br>
Below commit is supposed to fix this issue. It&#39;s currently in<br>
x86/vt-d branch of the iommu tree, and will be part of v5.6-rc1.<br>
<br>
commit f5a68bb0752e0cf77c06f53f72258e7beb41381b<br>
Author: Barret Rhoden &lt;<a href=3D"mailto:brho@google.com" target=3D"_bla=
nk">brho@google.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Wed Jan 15 11:03:56 2020 +0800<br>
<br>
=C2=A0 =C2=A0 =C2=A0iommu/vt-d: Mark firmware tainted if RMRR fails sanity =
check<br>
<br>
=C2=A0 =C2=A0 =C2=A0RMRR entries describe memory regions that are DMA targe=
ts for devices<br>
=C2=A0 =C2=A0 =C2=A0outside the kernel&#39;s control.<br>
<br>
=C2=A0 =C2=A0 =C2=A0RMRR entries that fail the sanity check are pointing to=
 regions of<br>
=C2=A0 =C2=A0 =C2=A0memory that the firmware did not tell the kernel are re=
served or<br>
=C2=A0 =C2=A0 =C2=A0otherwise should not be used.<br>
<br>
=C2=A0 =C2=A0 =C2=A0Instead of aborting DMAR processing, this commit marks =
the firmware<br>
=C2=A0 =C2=A0 =C2=A0as tainted. These RMRRs will still be identity mapped, =
otherwise,<br>
=C2=A0 =C2=A0 =C2=A0some devices, e.x. graphic devices, will not work durin=
g boot.<br>
<br>
=C2=A0 =C2=A0 =C2=A0Signed-off-by: Barret Rhoden &lt;<a href=3D"mailto:brho=
@google.com" target=3D"_blank">brho@google.com</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0Signed-off-by: Lu Baolu &lt;<a href=3D"mailto:baolu.lu@=
linux.intel.com" target=3D"_blank">baolu.lu@linux.intel.com</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0Fixes: f036c7fa0ab60 (&quot;iommu/vt-d: Check VT-d RMRR=
 region in BIOS <br>
is reported as reserved&quot;)<br>
=C2=A0 =C2=A0 =C2=A0Signed-off-by: Joerg Roedel &lt;<a href=3D"mailto:jroed=
el@suse.de" target=3D"_blank">jroedel@suse.de</a>&gt;<br>
<br>
Best regards,<br>
baolu<br>
<br>
On 2020/2/3 5:06, Thomas G wrote:<br>
&gt; Dear all,<br>
&gt; <br>
&gt; Vt-d seems to be broken since I upgraded to kernel 5.5, there is a new=
 <br>
&gt; dmesg that was not there in 5.4:<br>
&gt; &quot;DMAR: [Firmware Bug]: No firmware reserved region can cover this=
 RMRR <br>
&gt; [0x0000000041d92000-0x0000000041d94fff], contact BIOS vendor for fixes=
&quot;<br>
&gt; <br>
&gt; System motherboard is Asrock X299 Taichi XE, bios 1.70, CPU is Core i9=
 7920<br>
&gt; Vt-d and gpu passthrough was working ok since kernel 4.20 when I <br>
&gt; purchased it<br>
&gt; <br>
&gt; I attached the dmesg I get with kernel 5.5.1, and the dmesg from 5.4.1=
7.<br>
&gt; <br>
&gt; Also, I use the following script that displays the IOMMU groups, I fou=
nd <br>
&gt; the script there <br>
&gt; <a href=3D"https://wiki.archlinux.org/index.php/PCI_passthrough_via_OV=
MF" rel=3D"noreferrer" target=3D"_blank">https://wiki.archlinux.org/index.p=
hp/PCI_passthrough_via_OVMF</a><br>
&gt; <br>
&gt; #!/bin/bash<br>
&gt; shopt -s nullglob<br>
&gt; for d in /sys/kernel/iommu_groups/*/devices/*; do<br>
&gt;=C2=A0 =C2=A0 =C2=A0 n=3D${d#*/iommu_groups/*}; n=3D${n%%/*}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 printf &#39;IOMMU Group %s &#39; &quot;$n&quot;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 lspci -nns &quot;${d##*/}&quot;<br>
&gt; done;<br>
&gt; <br>
&gt; The output of this script with kernel 5.4.17 is attached to this email=
.<br>
&gt; The same script with kernel 5.5.1 produces an empty output<br>
&gt; <br>
&gt; Hope it helps narrowing down the problem, please ask additional info i=
f <br>
&gt; needed. Sorry if this is not submitted as it should be (then please <b=
r>
&gt; advise), first time I report -what apprears to be- a bug.<br>
&gt; <br>
&gt; Best,<br>
&gt; Thomas<br>
</blockquote></div>

--0000000000008743ad059da88a32--

--===============7262775507638822266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7262775507638822266==--
