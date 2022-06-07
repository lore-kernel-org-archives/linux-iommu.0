Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CA1C43334
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 08:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A748D410B9;
	Tue,  7 Jun 2022 08:00:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KCz2iTyPLqMl; Tue,  7 Jun 2022 08:00:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6FF7F4051E;
	Tue,  7 Jun 2022 08:00:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 401CCC0032;
	Tue,  7 Jun 2022 08:00:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90671C002D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 08:00:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 69AC0613E1
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 08:00:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wY4uYlYV6OeL for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 08:00:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B95B1613E0
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 08:00:46 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 487BF423; Tue,  7 Jun 2022 10:00:43 +0200 (CEST)
Date: Tue, 7 Jun 2022 10:00:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2] iommu/amd: Set translation valid bit only when IO
 page tables are in used
Message-ID: <Yp8FpnMrlJcXIHqq@8bytes.org>
References: <20220509074815.11881-1-suravee.suthikulpanit@amd.com>
 <Yn5YIfzmerwAM30M@8bytes.org>
 <1dfaf07e-040e-848b-db7c-86a107fd5cb3@amd.com>
 <YodMvV/8eii4KCLg@8bytes.org>
 <dac2c654-cb9c-6554-0afd-9e8db012374a@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dac2c654-cb9c-6554-0afd-9e8db012374a@amd.com>
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

On Thu, May 26, 2022 at 10:29:09AM +0700, Suravee Suthikulpanit wrote:
> Actually, I am referring to when user uses the IOMMU v2 table for shared virtual address
> in current iommu_v2 driver (e.g. amd_iommu_init_device(), amd_iommu_bind_pasid).

From what I can see this is not handled yet and needs an additional
check. I think the best solution is to set iommu->iommu_v2 to false when
the SNP feature bit is set.
But that is probably not enough, all functions that are called from the
IOMMUv2 driver need to fail.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
