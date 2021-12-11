Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A9EC433F5
	for <iommu@archiver.kernel.org>; Sat, 11 Dec 2021 16:27:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 694A940399;
	Sat, 11 Dec 2021 16:27:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sI5CGnyrwFuC; Sat, 11 Dec 2021 16:27:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 00CEF40017;
	Sat, 11 Dec 2021 16:27:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4610C002F;
	Sat, 11 Dec 2021 16:27:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAE70C0012
 for <iommu@lists.linux-foundation.org>; Sat, 11 Dec 2021 16:27:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8EC78580A
 for <iommu@lists.linux-foundation.org>; Sat, 11 Dec 2021 16:27:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0qt-qXudYB28 for <iommu@lists.linux-foundation.org>;
 Sat, 11 Dec 2021 16:27:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4FD4885806
 for <iommu@lists.linux-foundation.org>; Sat, 11 Dec 2021 16:27:12 +0000 (UTC)
Received: from mail-ed1-f48.google.com ([209.85.208.48]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M3D3N-1mxTBg2vHR-003Zl2 for <iommu@lists.linux-foundation.org>; Sat, 11 Dec
 2021 17:27:09 +0100
Received: by mail-ed1-f48.google.com with SMTP id w1so38829418edc.6
 for <iommu@lists.linux-foundation.org>; Sat, 11 Dec 2021 08:27:09 -0800 (PST)
X-Gm-Message-State: AOAM5309Jupp0Au+Ihz4wT0R1T7jKxmCOoX1j3l6y709AvmdHasS9m/B
 J81aHVbop8lsm+oSQ4JXi/Gq8yicn8yi8WplRuM=
X-Google-Smtp-Source: ABdhPJydOCBHCBVhL5GrxiQp2LNkO7SO9fSpEb1ktgLdLbaiYOV8bo99cpA+GLEsnha3mdPvOSWLSKg/3Dqg7U73gXw=
X-Received: by 2002:a5d:6902:: with SMTP id t2mr20632629wru.317.1639236258246; 
 Sat, 11 Dec 2021 07:24:18 -0800 (PST)
MIME-Version: 1.0
References: <20211210221642.869015045@linutronix.de>
 <20211210221815.269468319@linutronix.de>
In-Reply-To: <20211210221815.269468319@linutronix.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 11 Dec 2021 16:24:02 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2=LKoe1nw1sZZmxFwAh+54n-Q3cMO3goHEVMQKSVSh+g@mail.gmail.com>
Message-ID: <CAK8P3a2=LKoe1nw1sZZmxFwAh+54n-Q3cMO3goHEVMQKSVSh+g@mail.gmail.com>
Subject: Re: [patch V3 34/35] soc: ti: ti_sci_inta_msi: Get rid of
 ti_sci_inta_msi_get_virq()
To: Thomas Gleixner <tglx@linutronix.de>
X-Provags-ID: V03:K1:fYvffi4UG8Cnt2k7OgN83l5r/dxERPvXAFgHN1jSYH9SwuWJ5V4
 bp/bJiumofX7E+YMfOGM2E8zq0Qzy0pUyk2QiDIoNFcN7mmw1iI3z0x/75a5Ta6Oz714/7S
 k+NcclBGUDz2vs5BszDqIm+hGNgA4JY0bitXBzpMDTuv6UfwIFuxrVCBlB5wsakLu240suk
 swbTvo8bCdfmQpM/d9Otw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wdCV8I3HR1k=:+NECGqKrNujdthY2n1izY9
 PFFjUCzM3YBN63OJEvp1OBFca4JcktBUE1QXTzg2Ov0Lka8PrnXfI3KnlG6qSzLm2hFXvlddd
 JcGiqY2SX44PKF8xC8oIAsw/m65nQw5Kzd4HZefy9OuQtKGMZj35TzzqJBDrdEZAcy6IyeCWe
 WgylaIRJZjGt3pKPtWeOTeMckNYR8NMrnHHpNGoLk3Jqx1NomZJs8Yh5zQvWYD+t2o2rWUfOR
 11VvQAJlBRPZswCBgYGrmjtZs4uDfCfQNF9pZtwACkoBHc8lqT4ziaoaY7F1tiIMJiBlAl/DZ
 Ax2StkxiMkat858genUl2C+Gv2pFz72vuNCd+4bnYJd0ouhClFftp8enKl3bdtfd6X9aAqQ1U
 nYk4pILKFF+EwNXfg+kos/0EE1YJpWkLfjquACpMc11QHisIz78dUqTDbbLvWDciwBHvD3tvT
 Gc76auz/R6R7j2l/GURkuW/C7x3Sbfnyzv5EyjYYnCbNKrsx2xxYV10EHgJQl3A7nZ+QX6d+c
 qSHh92OYPrkjiZvlUJlWGUqmgs6ccodhPRpmFb23DJpiKvYSd3ijvwRoSzQf87gGrpFlARP0S
 iPT0cGpzHA5PFI52yMQTT5AfGF2hb+Md1DHhwQ9YXUzA83S6zPTrtkBMBpo0ZNLBM34gK4WDr
 TQDnsH2ydn24xlvk6mdZRt5wUKEvCjDmSoHJXZfi2ddSlZB7vU94qIQoYwNzUnQ8pknhRGYyN
 v5MopvFyybGd22Zn7M36hGsy0zSz21Tb4Z0P0F5mLhrsyVGinXyGYtnHsy3k+88Ew6lOxAI2n
 D6UtoxH00pwmQ303WueEVbn40c6DDGu9E3TiRA9o4bUlMlSPzg=
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Ashok Raj <ashok.raj@intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Jassi Brar <jassisinghbrar@gmail.com>, Sinan Kaya <okaya@kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Bjorn Helgaas <helgaas@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, linux-pci <linux-pci@vger.kernel.org>,
 xen-devel <xen-devel@lists.xenproject.org>, Kevin Tian <kevin.tian@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Megha Dey <megha.dey@intel.com>, Juergen Gross <jgross@suse.com>,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Marc Zygnier <maz@kernel.org>, dmaengine@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

On Fri, Dec 10, 2021 at 11:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Just use the core function msi_get_virq().
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org

Acked-by: Arnd Bergmann <arnd@arndb.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
