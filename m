Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE55C433EF
	for <iommu@archiver.kernel.org>; Sat, 11 Dec 2021 15:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31BC18595B;
	Sat, 11 Dec 2021 15:27:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sn0C8VAgPDQ1; Sat, 11 Dec 2021 15:27:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 280BE85959;
	Sat, 11 Dec 2021 15:27:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3192C001E;
	Sat, 11 Dec 2021 15:27:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE2E7C0012
 for <iommu@lists.linux-foundation.org>; Sat, 11 Dec 2021 15:27:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AB90261BF4
 for <iommu@lists.linux-foundation.org>; Sat, 11 Dec 2021 15:27:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x7d9eY_maFtD for <iommu@lists.linux-foundation.org>;
 Sat, 11 Dec 2021 15:27:18 +0000 (UTC)
X-Greylist: delayed 00:05:04 by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8ED1861BDA
 for <iommu@lists.linux-foundation.org>; Sat, 11 Dec 2021 15:27:16 +0000 (UTC)
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MrPRB-1m9JRc05J9-00oZDz for <iommu@lists.linux-foundation.org>; Sat, 11
 Dec 2021 16:22:11 +0100
Received: by mail-wr1-f43.google.com with SMTP id j3so19785256wrp.1
 for <iommu@lists.linux-foundation.org>; Sat, 11 Dec 2021 07:22:10 -0800 (PST)
X-Gm-Message-State: AOAM5309ukJomAeEe3GUO/eeQr40KfemFj1rQLFTP9HFNAcEXnTTjRsT
 kyKV6M2H46NJk6Nk/QtjfJPZf/YYUiYx4FixE44=
X-Google-Smtp-Source: ABdhPJw71fHmkJDBQfwdVvTsQemVVjs0TdIXte5O3MuH5722pvreNXPnvtVfyYQ4NEpRi0VtDUcmnQ9Z/Qh6+K4QE8c=
X-Received: by 2002:a5d:530e:: with SMTP id e14mr21123035wrv.12.1639236119426; 
 Sat, 11 Dec 2021 07:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20211210221642.869015045@linutronix.de>
 <20211210221813.493922179@linutronix.de>
In-Reply-To: <20211210221813.493922179@linutronix.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 11 Dec 2021 16:21:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3U2DSm_DWS+iDkzH14hNMwyOQ77iS=W4HoAyHPh6pqUw@mail.gmail.com>
Message-ID: <CAK8P3a3U2DSm_DWS+iDkzH14hNMwyOQ77iS=W4HoAyHPh6pqUw@mail.gmail.com>
Subject: Re: [patch V3 05/35] powerpc/cell/axon_msi: Use PCI device property
To: Thomas Gleixner <tglx@linutronix.de>
X-Provags-ID: V03:K1:r4z/4igR5PJTzwD1REDDrNfpz+jFus9r/dYXb43g4sRb+eNLrRK
 8nbRt7QoUEWVSah1mQKYAUalUb6cEF97lUTsDVZJEQUC3D2SJzJMU9blm/foMLOp3RoPaH4
 JAFXWSo8CfOXXoi34bvHCz2u/Rdi/4dzL2P2ZJWhUJMpwzL+hXDdkkwiVFa+1Z9v3AzrKRt
 4P/OD/OFWBf0EB8AJaymQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M3WjowCcRNw=:RzSbNiG63zkpBaSFMYy8wp
 HL0i0NjBYnGx11kH/qKtQ9IheG8d/3EnbtLe3xm02v88T7c49sZUyCFQSmsiOVoVfdWFTBshT
 EQgeIAqaJxKr+vBHgwigB5QVa78oyli6QZ1+/pP2YQdasRYi8dhXyke/5MqhKqfHXOXch4U4M
 2sTxRtiELeu6hjGCefJnNhNhP4FR09EUNaxscSKjEWWeotTkiN7V29qNtudk1LIfvwQLWeyND
 MLULpS10YzIYTqHcHaSmP2qjHSeS9wU8Vf4JImOHdlEFljVFcY8w6CzIi1PmiYrctz79gq8UU
 Z94L9P1ba3/9+zWamkz18aaO4aJWdJ3jZRlLEWJP0n/K13Zh5MamdAcdjFlID3Liup71llN8f
 i8Kq3lzLErtgXNVCT0AiB3W2/7B556Q4oX5j56eJAYq7H0GHNQSBO1s5HogpLJcG8sl+Vhkjr
 3oYWLrgOPP+VUBX/hVHBqEsQ+iEfsn8JqEjB3fF50wa4A+YZRvWwWfMVoY9MlcAEKZo8Nc8wh
 JMy5g5HOum9VclUz0LV+OpYo/cpOsYU7MsQpPaNJyGsYM6s4zav6BjIqGiMP93M3XlwCuw8Xh
 vcjSgjC77bI6jfttMI6dHyqfF/wXxUmtJc/dtG7Ex28rLTAoO3p7eIUjqyaqtcodmH8HD44xw
 KVzn5ingWo799a/GD5j4L4MwpHssFvd8gzNTQpCdCbmPmxcz4LNyMvE3Czvp8mqNOeZinK85T
 hgM7DzqSbvxUgDKp8flT+imh/aC7OOOQ3pVguTBj3A5vG3WbJB4o4FRlQMDaEpdHA05WMZJ5G
 zmxNf+nAxLuOaEfoi88F9njoXVZ5cdoN2f7BzNbIppqQgQOOFYiaSB9XQrR8qCYWux5bCtoVH
 S2h/6R5rLUFKZFm++hA+U5LVCKD0yJoWKUasnIFEAcNsv9L621dd5iNlJCVonG38Uevr4CoFY
 z2Am63Oa0Ig==
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
> instead of fiddling with MSI descriptors.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
