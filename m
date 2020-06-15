Return-Path: <SRS0=8EFN=74=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCFDC433DF
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 11:06:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C15320656
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 11:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C15320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6C770850E9;
	Mon, 15 Jun 2020 11:06:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EN8OezaeJVZP; Mon, 15 Jun 2020 11:06:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0E7FC83445;
	Mon, 15 Jun 2020 11:06:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4DFFC0888;
	Mon, 15 Jun 2020 11:06:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6864AC016E
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 03:19:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 64CFF87784
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 03:19:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3KhT20LZKjHa for <iommu@lists.linux-foundation.org>;
 Mon, 15 Jun 2020 03:19:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5B89B8777F
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 03:19:24 +0000 (UTC)
Received: from mail-oi1-f198.google.com ([209.85.167.198])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <koba.ko@canonical.com>) id 1jkfec-0001vh-BD
 for iommu@lists.linux-foundation.org; Mon, 15 Jun 2020 03:19:22 +0000
Received: by mail-oi1-f198.google.com with SMTP id j131so8342441oib.3
 for <iommu@lists.linux-foundation.org>; Sun, 14 Jun 2020 20:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=J00uqwyYby1d3ZVEwMDTsX2oFDYv8bGGzVc3WDHD1JQ=;
 b=SnM0hvdXaM2KLzKb8zTWLyoiur2yizjqhpgHjiGTPU6AsuKZwqbLVBrnW90E3i0Tvk
 L0YCwacnvgWhXmOYPziDOHaSzA4YfY7Pix065Bv9PKfbcpMph4+5GY7rOAzN+Q/VmEOK
 +rhpr7NOPdDSQn/Yn+72sL7coMJ962OyO0cjFxfUzG9OGZ0ndqEs/WxCKpH6SNeujhu0
 Mn5M5bzWeVVXVA0/taiAkyw+PpI4T4UBdRZNP+MDhw5gu+J+/31PznXFAuzQr48DblFp
 86kh05O7YXu0IGbj0cxpgRyxakhLI7y45Bb/PkN559MwPYRfimVfb+5wn/MAU8YjtpUF
 ogmQ==
X-Gm-Message-State: AOAM533PWjAlPndDN4d9UHM2XNa+2oyPkPHe/+reMsdxITZath6fnDRK
 Mtll/nF2+YMEj8JM29DBmrv9ysJgPU2P5p8mPVGc7vB2xCR/UAusXhrlBiUrhK6rd2rXBxiCEL6
 RBuavYwA4ZG/wA7pajhGej8heCJpTzLBTVegPRt/Yts4+OenZh6gvYrNnkC0DdgA=
X-Received: by 2002:a9d:20e9:: with SMTP id x96mr18730179ota.326.1592191161361; 
 Sun, 14 Jun 2020 20:19:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHzZsJmkKI3e2WjLvMRDyK+Gdawuk8OT9TolyFnv648r5/K7e4BjThYumxl57En1J6mmIQ7mmHfHo+kak7+Es=
X-Received: by 2002:a9d:20e9:: with SMTP id x96mr18730170ota.326.1592191161092; 
 Sun, 14 Jun 2020 20:19:21 -0700 (PDT)
MIME-Version: 1.0
From: Koba Ko <koba.ko@canonical.com>
Date: Mon, 15 Jun 2020 11:19:10 +0800
Message-ID: <CAJB-X+Ww=bZN2qZ=e=4EkN_RUTiZxHxkdnHh50y9iVqZmT_XQg@mail.gmail.com>
Subject: [Issue]platform/x86: iommu: System can't shutdown because iommu
 driver keeps checking the status of DMA_GSTS_TES
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>
X-Mailman-Approved-At: Mon, 15 Jun 2020 11:06:21 +0000
Cc: iommu@lists.linux-foundation.org,
 Kai Heng Feng <kai.heng.feng@canonical.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
Content-Type: multipart/mixed; boundary="===============1453415708377565533=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============1453415708377565533==
Content-Type: multipart/alternative; boundary="0000000000009261e805a816e4ab"

--0000000000009261e805a816e4ab
Content-Type: text/plain; charset="UTF-8"

hi All,
I have a machine and there's only intel gpu.
the secureboot and vt-d is enabled in BIOS.
On the Ubuntu desktop, I do s2idle first and restart the machine.
The machine can't restart successfully, so I need to press the power button
to shutdown.
I tried  each of the following and the issue can't be triggered.
1. disable secure boot in BIOS.
2. intel_iommu=off.
3. intel_iomm=igfx_off.
4. nomodeset
5. i915.modeset=0.

After I investigate further, find inte_iommu keeps checking the status of
DMA_GSTS_TES.
During the procedure of restart, the driver would disable iommu translation
and
check status of DMA_GSTS_TES until status of DMA_GSTS_TES is 0.

If you need more information, I can provide it.

Thanks
*Koba Ko*

--0000000000009261e805a816e4ab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">hi All,<div>I have a machine and there&#39;s only intel gp=
u.<br><div>the secureboot=C2=A0and vt-d is enabled=C2=A0in BIOS.</div></div=
><div>On the Ubuntu desktop, I do s2idle first and restart the machine.</di=
v><div>The machine can&#39;t restart successfully, so I need to press the p=
ower=C2=A0button to shutdown.</div><div>I tried=C2=A0 each of the following=
 and the issue can&#39;t be triggered.</div><div>1. disable secure boot=C2=
=A0in BIOS.=C2=A0</div><div>2. intel_iommu=3Doff.</div><div>3. intel_iomm=
=3Digfx_off.</div><div>4. nomodeset</div><div>5. i915.modeset=3D0.</div><di=
v><br></div><div>After I investigate further, find inte_iommu keeps checkin=
g the status of=C2=A0<span style=3D"background-color:rgb(0,0,0);color:rgb(2=
55,255,255)">DMA_GSTS_TES.</span></div><div><span style=3D"background-color=
:rgb(0,0,0);color:rgb(255,255,255)">During the procedure of restart, the dr=
iver would disable=C2=A0iommu translation and=C2=A0</span></div><div><span =
style=3D"background-color:rgb(0,0,0);color:rgb(255,255,255)">check=C2=A0</s=
pan>status of=C2=A0<span style=3D"background-color:rgb(0,0,0);color:rgb(255=
,255,255)">DMA_GSTS_TES until=C2=A0</span>status of=C2=A0<span style=3D"bac=
kground-color:rgb(0,0,0);color:rgb(255,255,255)">DMA_GSTS_TES is 0.</span><=
/div><div><span style=3D"background-color:rgb(0,0,0);color:rgb(255,255,255)=
"><br></span></div><div><span style=3D"background-color:rgb(0,0,0);color:rg=
b(255,255,255)">If you need more information, I can provide it.</span></div=
><div><span style=3D"background-color:rgb(0,0,0);color:rgb(255,255,255)"><b=
r></span></div><div><font color=3D"#ffffff" style=3D"--darkreader-inline-co=
lor:#ffffff;"><span style=3D"background-color:rgb(0,0,0)">Thanks</span></fo=
nt></div><div><font color=3D"#ffffff" style=3D"--darkreader-inline-color:#f=
fffff;"><span style=3D"background-color:rgb(0,0,0)"><i><b>Koba Ko</b></i></=
span></font></div></div>

--0000000000009261e805a816e4ab--

--===============1453415708377565533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1453415708377565533==--
