Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC55C433F5
	for <iommu@archiver.kernel.org>; Sat, 11 Dec 2021 16:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E49724035E;
	Sat, 11 Dec 2021 16:25:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X3awJ8X07AS3; Sat, 11 Dec 2021 16:25:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A5EBE40017;
	Sat, 11 Dec 2021 16:25:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75C22C002F;
	Sat, 11 Dec 2021 16:25:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9722C0012
 for <iommu@lists.linux-foundation.org>; Sat, 11 Dec 2021 16:25:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D540B42A3E
 for <iommu@lists.linux-foundation.org>; Sat, 11 Dec 2021 16:25:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eG0GNhNPr1od for <iommu@lists.linux-foundation.org>;
 Sat, 11 Dec 2021 16:25:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E9D942A3C
 for <iommu@lists.linux-foundation.org>; Sat, 11 Dec 2021 16:25:35 +0000 (UTC)
Received: from mail-wm1-f42.google.com ([209.85.128.42]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MtfRv-1mgDYp21WR-00v95p for <iommu@lists.linux-foundation.org>; Sat, 11 Dec
 2021 17:25:32 +0100
Received: by mail-wm1-f42.google.com with SMTP id i12so8983298wmq.4
 for <iommu@lists.linux-foundation.org>; Sat, 11 Dec 2021 08:25:32 -0800 (PST)
X-Gm-Message-State: AOAM531wzc/V1UTUjPY4ouVtK8UKI9ejLM6IgDJyGWhIPrq2N0NodQPz
 Rqg+O2PgtOhLGuianRpXZyhPV844En3FUq/fiis=
X-Google-Smtp-Source: ABdhPJyOlfLidEd9162beuC5UM1yFpg2300rafM4JRbY2mJjNOXxVFZo/cAEJoaFFS655TaSoVWjWn5yGpFZ9WnPivI=
X-Received: by 2002:a05:600c:6d2:: with SMTP id
 b18mr25037494wmn.98.1639236149109; 
 Sat, 11 Dec 2021 07:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20211210221642.869015045@linutronix.de>
 <20211210221813.617178827@linutronix.de>
In-Reply-To: <20211210221813.617178827@linutronix.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 11 Dec 2021 16:22:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0SPopq871z7hbeTZbgnpO=cnEz-4Pmi1Ko3SHFTpU-mg@mail.gmail.com>
Message-ID: <CAK8P3a0SPopq871z7hbeTZbgnpO=cnEz-4Pmi1Ko3SHFTpU-mg@mail.gmail.com>
Subject: Re: [patch V3 07/35] device: Move MSI related data into a struct
To: Thomas Gleixner <tglx@linutronix.de>
X-Provags-ID: V03:K1:CqoE0xVESfy+Q5aE+/70eQL3/UHETQUIOuJ5Soo48fuiaCo/nv4
 Ckw9INEXToug0dfcUlpOQ689X8Aiis7mGbgsa6kBqVdWguQP2PIx9BdUT/gGrTw/l41Q5U6
 rPlchBBoGxamlcAKV5LsYBeXplgc5kTy0s72DQ4qzAGxgmwA1tjLbHJTMPfIvayXWdXIut3
 RnvKkgPwa1gteP9KJ77sQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7TVjEP8bFro=:EA4aQgytHw//eV+zPEBaE7
 VDJMpSx94AsjkDu+rx/2RRdngADupSRh9dbcxceffusfaJIjh92FMRgArOeErmxwNNdiNhZkV
 iWgsT7ZSnOsX9M1TdKhOpz/AW+6mF+2fjXlJlW6b4ykoXOocaiMT3D5cYRoA9OxlrxmeiBVWk
 YrUGhSg+GuvrVmiZaCM8Bj6zXFThi4YPBppwhd5a7yMCZ5wp63n5pvv8N4GY5MhGIaxf2Eg6+
 DeyZH5Ls7qcYOtA7gFT6l60b5yMHlYye3rEIvw9g8P2qk1fjDSPxT2YG1CwGtDX5Ah2mv50/B
 o0UcwdRWfS7Z3uh081+NgntqWtrNuIoCIrId8STVjlVuzuEFG/d4v93dzS0e928yI4yITNMz9
 p5nNJ2HUKX8Fy6RmGyjOzcHIekwy4cPQseuoyGBuh7I6kPAUOizWQ1ZN4460KR/iAzj0JoT9a
 cqlu6gYnH3QeLOFuo0KinH/+HLtOyomy7wuIJaATetw6AyD9AlVCjegmlKGbAFTYyVqFGMKTW
 ILwLHvq1PKJZ18+u2eUVzCRGE11k1mumqLKF8gCUzDW6P2PQgiYZYNW0lIR8wC/p8CkLArSN4
 aXoNSTsvesnDsa3o66g9mIBomRCO9S+UZRrMOVj2rItupRaXovL6y9s4WAseEZvFbD99uY6M6
 VmhUlxTNxwwZQFXuOZVDdA/IxXC36lB8RHuk3uBlhlTlDfRtghq1KDt+PS2C+nmclTlplWol+
 AJAE5GQGL8EMb/VLVOXDhQYY+t+Wafq36uhHLkkC9tx4IHxgOYAJ8g1XhHA31x2pCOGNN96bd
 YCrFgX3GguSyfk0QGd8p2uiLUer/Wr4aRkblUeCc+wqeEQ/mHU=
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

On Fri, Dec 10, 2021 at 11:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> The only unconditional part of MSI data in struct device is the irqdomain
> pointer. Everything else can be allocated on demand. Create a data
> structure and move the irqdomain pointer into it. The other MSI specific
> parts are going to be removed from struct device in later steps.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
