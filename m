Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B742DC433F5
	for <iommu@archiver.kernel.org>; Sat, 11 Dec 2021 18:05:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3C0B44046B;
	Sat, 11 Dec 2021 18:05:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RI8FshUBZPPW; Sat, 11 Dec 2021 18:05:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C0B4040017;
	Sat, 11 Dec 2021 18:05:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91BEFC0038;
	Sat, 11 Dec 2021 18:05:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2ED65C001E
 for <iommu@lists.linux-foundation.org>; Sat, 11 Dec 2021 18:05:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFD1B60D56
 for <iommu@lists.linux-foundation.org>; Sat, 11 Dec 2021 18:05:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vDsfRIPOoi46 for <iommu@lists.linux-foundation.org>;
 Sat, 11 Dec 2021 18:05:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6075A606ED
 for <iommu@lists.linux-foundation.org>; Sat, 11 Dec 2021 18:05:40 +0000 (UTC)
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MZSJa-1mzsTn3CDu-00WZAz for <iommu@lists.linux-foundation.org>; Sat, 11 Dec
 2021 19:05:37 +0100
Received: by mail-wm1-f41.google.com with SMTP id
 p27-20020a05600c1d9b00b0033bf8532855so8894975wms.3
 for <iommu@lists.linux-foundation.org>; Sat, 11 Dec 2021 10:05:37 -0800 (PST)
X-Gm-Message-State: AOAM530vl7aGNJ6jTEionskf4gMGRszHjOzZ6amqFmcSGkl9cxNGOo0D
 Ul+jTDZ4zwE8BYXy19/rgTAmAUVkyFMQ90FOtd0=
X-Google-Smtp-Source: ABdhPJz9JqWJLeTUfS5IahRcetLl+JbMiIvXpgsv1eGAXoUb1XDPjjtJEfoNcEXB+cjjosPGuUvpUWQic5X/F+X6I8s=
X-Received: by 2002:a1c:1c1:: with SMTP id 184mr24672882wmb.1.1639236184421;
 Sat, 11 Dec 2021 07:23:04 -0800 (PST)
MIME-Version: 1.0
References: <20211210221642.869015045@linutronix.de>
 <20211210221813.928842960@linutronix.de>
In-Reply-To: <20211210221813.928842960@linutronix.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 11 Dec 2021 16:22:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a00M1MGPEwMQpgGJ9-g9-P6e9wo8G1frfVMqJ4bRp1Okg@mail.gmail.com>
Message-ID: <CAK8P3a00M1MGPEwMQpgGJ9-g9-P6e9wo8G1frfVMqJ4bRp1Okg@mail.gmail.com>
Subject: Re: [patch V3 12/35] soc: ti: ti_sci_inta_msi: Allocate MSI device
 data on first use
To: Thomas Gleixner <tglx@linutronix.de>
X-Provags-ID: V03:K1:djv5qHJRLjTS4pWf5aoJ+hII6bEdq1IHt4yHUcKWogkGJPhFbGp
 UQIt2MFdMUIamMb+Y4yTVlSlckB3VQGi0pQdKpdQZ4i0J9QeoIsdk7ixkPzHI8R+CLxIezn
 lJZA8g6PzTpTyWDObpPjUf/5WhaCNAtPQHVRKAI/QR2aio+2tkLkXq2gRvlSsxEMPjwj0Nd
 sxT5Zvu5hk0vuUeAlRMfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jv/Z9PuOqoo=:2soz1n9DSJBZ90jDpW3Hkt
 u1BHWCQpDWXQ0J64OO08T+9tAfGVoy70+DeSZ3XTdiPvNXq67Xegiza+IVaUmR4s3v3N+tLqJ
 DwkuPpAitIDjN750bOMQRBKPvWn0qG27hwMLqgkRSCGTapyDtyJGzpuC6zHmUaSwaMebJFubA
 GxuMxMlwzNR1jhuAQ0k0aqXmOTZbeb3YhgfgVs13Rod4A9xDJXwSYSlL6Eis7Srr8rceRJrzP
 9FVsqSCUn2Z2iqlaVeAg/PRJO5yxmR3CxgWywuKxYKYeQmkLzrmrp0GiR6qxHYXwhHopeGQSx
 Opa77tp9UdkEV/xyW1ygnpq+AnXn+MGK+s1YvuYgoYHIVeDYQYjAgXjgpcKtFIkTWCe5glZNI
 BzuXosRhGbW4iRisioeM6SdcRQ8D7W0taJWQO2W/B7JyWAIKIE/C6v/JJdD9n94Ojg4+yVz6a
 m7kZNHfa1HQ3zBrF9/TZaZ2bG2j+Fy6Xddih3hvxlGy9C3ANyIdEYottHlDQXkuVIDuJqCirE
 bUODugEEgSW4UgbZzSC3Z3DcFE4nvNCykC3vJSVbGWiyRuTQ1ANBlSYeRnAeC4G2BEn2MDlc2
 d4QKYq4Xw+SKuyG29hUbsHt0p9gf2f7MSR081UV4xgNvY8LBDV7Az+zsjuIb+ArtDgxC7s6aJ
 0W7cpo7ao8G/4eiDVQ3E0M7/KVWZw6N4XFVC6BBwM2WhHXc9ZLvZx1KYhh6S/Be2JWQAjGZuF
 vOlUAOePk7A1hyUn+Ir4xXmQ/z5HGfy0gUaLiL2iLbolfEI0boKhrQinBVgbZyVVoPfGmRcb4
 j/Y4Y7ZwgzSPcO0TVP7XgiXdPAtTjQ/WmJ/RUSJxUzT6McUukQ=
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jassi Brar <jassisinghbrar@gmail.com>,
 Sinan Kaya <okaya@kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
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
> Allocate the MSI device data on first invocation of the allocation function.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Tero Kristo <kristo@kernel.org>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org

Acked-by: Arnd Bergmann <arnd@arndb.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
