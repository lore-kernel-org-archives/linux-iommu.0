Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCABCCA481
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 17:08:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C7864262C;
	Fri, 24 Jun 2022 17:08:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C7864262C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C-2vyoCw-7DG; Fri, 24 Jun 2022 17:08:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 952734262A;
	Fri, 24 Jun 2022 17:08:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 952734262A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41EC2C0032;
	Fri, 24 Jun 2022 17:08:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67325C002D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 17:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4140284926
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 17:08:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4140284926
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pvot2_dTgw7c for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 17:08:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED93E84925
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED93E84925
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 17:08:40 +0000 (UTC)
Received: from mail-yw1-f171.google.com ([209.85.128.171]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MtObA-1nocDw0LIU-00usXi for <iommu@lists.linux-foundation.org>; Fri, 24
 Jun 2022 19:08:38 +0200
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-31772f8495fso30944127b3.4
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 10:08:37 -0700 (PDT)
X-Gm-Message-State: AJIora8EhxQWgoseT3PFtBah1YTFLtPaTwr+JLaaL6rtFBZNRAfqMpnw
 2BDIH6Df+cS6VM0L/Gd4pM0UCW+VHlIEAsI2JeI=
X-Google-Smtp-Source: AGRyM1tBSdPwbFq9GZSjizWzVuAB7giujhHzzt55cTqkntbPy6yauQrkbaXTZ2eocC/Zbg06KphUioMdhsic93kqOWE=
X-Received: by 2002:a81:b93:0:b0:317:791f:3c0 with SMTP id
 141-20020a810b93000000b00317791f03c0mr17394782ywl.42.1656090516599; 
 Fri, 24 Jun 2022 10:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220624155226.2889613-1-arnd@kernel.org>
In-Reply-To: <20220624155226.2889613-1-arnd@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 24 Jun 2022 19:08:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a04C+ZavWb2nnYs-02CKZq10OA8rDE7QHMFF5qZzb6t9g@mail.gmail.com>
Message-ID: <CAK8P3a04C+ZavWb2nnYs-02CKZq10OA8rDE7QHMFF5qZzb6t9g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] phase out CONFIG_VIRT_TO_BUS
To: linux-scsi <linux-scsi@vger.kernel.org>
X-Provags-ID: V03:K1:s0tGddKJwbC5IvwcQxTd/mJe6sC8OPHuUQAMGKt17t5CLqmWqD0
 JLN+b+Zfmdzmi26XBF9Ka0KtmSZODyxoKFYpiqKcIEVbhrpDmhprOXgwiVCfSyGPF6z5nD8
 rMrsnZYIiSyHnS1npeWY/0eVtKn1A4e/2SXRTzikjZSIwQFgpRjVS/bvtk7uXUQqJ1TzEib
 PRGWGlE3cN8gD0U/UNh7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IUD+y7SxG5Q=:E/X2uuUoi7Ky6lRljxJYZ7
 YJmMxtV3aRl88nPruHErt/XGxoS+d586M5B8BqGz8mmqI1KezxtyF4FflwHIxIEocQwVMGyrm
 /yEL3oBQe0Mc1DYWwEhr+xmy+E0v5ZDRV5WKREaB/Th1fnDCM1wu7ZhnR5RcmZ5aN1cOsHNrk
 TPjvqEeXZyGCLKBbHey7sFk8H97EZqHjZMm8a5h/C2haQNdb9SfK651YaG/Wu/89H/yCZbEp7
 gR25qG5KG0Yhaxef2fx5S9F/8a0MkC3YCiMpOuWlOqafdH8QztJBWgKRRgOQxLFZO/MKyhBaJ
 RK2mXPwZrQWmC2fBwq+Qib0elc5gnMYIbEVIN3atoBOSyTTsb+T9HMaqDnYY9rGSCHXWex6kz
 BrhkwMMdGDrzgdHkslAvHmSb5fcRh3r137lWdyyOfK/vvYQtWMUiSGt6+uPUJylPnP7Hz+PC4
 WCsCHLCwe4Ao12MPgMgTnrXQGUELkHMXDKcePWNYpFGIG0NJTk8iXIuZ7Jz5De1RnPfI/aqD9
 9I3yxvdBoJnGj+pggqBSeEcgeEtdTmFxr0Sj6wCv4Hos+LtkmBnFEqdRMcgHmGoVTNSfsrPuG
 bFbC0ClaIatvvw6plPq6Z9Kddq6LkdXBwPE0d/6MYw1JsbFWn963QWJnje5022Axn+uht+vtR
 vFFCNvd/gURuv0hpMJH0cA1lq8nEaoDnkoNzaOYGAmL4k+O76CE7TTJdzGGacN2uNt755HQA9
 t58zPa9qx426Dpx8VsjpjE5+Wmwfsvd8m+ILYBfiqaR9OuiCdCJd4BJG0aoGMwO3Xy496p9pf
 OWVm8lEfDpN2xK4n/nH33v5UY+o63IBmTOkBm/KCwVvwZFZN7jzPZ0ml5nyXmoUachSALspaB
 cIm29OEpjbrLNSNJHSGA==
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Miquel van Smoorenburg <mikevs@xs4all.net>,
 Parisc List <linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Denis Efremov <efremov@linux.com>, Mark Salyzyn <salyzyn@android.com>,
 Christoph Hellwig <hch@infradead.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Matt Wang <wwentao@vmware.com>, alpha <linux-alpha@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Khalid Aziz <khalid@gonehiking.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, Jun 24, 2022 at 5:52 PM Arnd Bergmann <arnd@kernel.org> wrote:

> Arnd Bergmann (3):
>   scsi: BusLogic remove bus_to_virt
>   scsi: dpt_i2o: remove obsolete driver

The dpt_i2o removal is overly large and got dropped by some of the
mailing lists,
if anyone wants to see the full patch, it did make it through to the linux-scsi
list at least:

https://lore.kernel.org/all/20220624155226.2889613-3-arnd@kernel.org/

         Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
