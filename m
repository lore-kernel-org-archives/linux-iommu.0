Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54C8C433EF
	for <iommu@archiver.kernel.org>; Fri, 20 May 2022 08:09:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57CCC60EE5;
	Fri, 20 May 2022 08:09:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i7DY0j102wUq; Fri, 20 May 2022 08:09:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3FD2E605EA;
	Fri, 20 May 2022 08:09:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01554C0039;
	Fri, 20 May 2022 08:09:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 671B3C002D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 08:09:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 56673424D4
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 08:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nwXCg71GDHE1 for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 08:09:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 212C241D68
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 08:09:37 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id B62ED820; Fri, 20 May 2022 10:09:34 +0200 (CEST)
Date: Fri, 20 May 2022 10:09:33 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2] iommu/amd: Set translation valid bit only when IO
 page tables are in used
Message-ID: <YodMvV/8eii4KCLg@8bytes.org>
References: <20220509074815.11881-1-suravee.suthikulpanit@amd.com>
 <Yn5YIfzmerwAM30M@8bytes.org>
 <1dfaf07e-040e-848b-db7c-86a107fd5cb3@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1dfaf07e-040e-848b-db7c-86a107fd5cb3@amd.com>
Cc: iommu@lists.linux-foundation.org, jon.grimm@amd.com,
 linux-kernel@vger.kernel.org, vasant.hegde@amd.com
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

Hi Suravee,

On Mon, May 16, 2022 at 07:27:51PM +0700, Suravee Suthikulpanit wrote:
> Due to the new restriction (please see the IOMMU spec Rev 3.06-PUB - Apr 2021
> https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf) where the use of
> DTE[Mode]=0 is not supported on systems that are SNP-enabled (i.e. EFR[SNPSup]=1),
> the IOMMU HW looks at the DTE[TV] bit to determine if it needs to handle the v1 page table.
> When the HW encounters DTE entry with TV=1, V=1, Mode=0, it would generate
> ILLEGAL_DEV_TABLE_ENTRY event.

Ah, that is the part I was missing, thanks.

> - I am still trying to see what is the best way to force Linux to not allow
> Mode=0 (i.e. iommu=pt mode). Any thoughts?

I think this needs a general approach. First start in the AMD IOMMU
driver:

	1) Do not set DTE.TV=1 bit iff SNP-Support is enabled
	2) Fail to allocate passthrough domains when SNP support is
	   enabled.

Then test how the IOMMU core layer handles that. In fact the IOMMU layer
needs to adjust its decisions so that:

	1) It uses translated-mode by default
	2) passthrough domains are disallowed and can not be chosen, not
	   on the kernel command line and not at runtime.

Ideally this needs some kind of arch-callback to set the appropriate
defaults.

> - Also, it seems that the current iommu v2 page table use case, where GVA->GPA=SPA
> will no longer be supported on system w/ SNPSup=1. Any thoughts?

Support for that is not upstream yet, it should be easy to disallow this
configuration and just use the v1 page-tables when SNP is active. This
can be handled entirely inside the AMD IOMMU driver.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
