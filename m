Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D169AC433EF
	for <iommu@archiver.kernel.org>; Fri, 20 May 2022 08:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D2C441D53;
	Fri, 20 May 2022 08:55:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KJz1ScrT3fMW; Fri, 20 May 2022 08:55:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 22611424BA;
	Fri, 20 May 2022 08:55:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C379EC007C;
	Fri, 20 May 2022 08:55:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7132C002D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 08:55:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C6C240A8E
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 08:55:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lMa-1KfhRwaQ for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 08:54:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7F7324012F
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 08:54:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D1291477;
 Fri, 20 May 2022 01:54:58 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 495CD3F66F;
 Fri, 20 May 2022 01:54:57 -0700 (PDT)
Message-ID: <794e13dd-8eae-481d-711d-b5462fdbfb18@arm.com>
Date: Fri, 20 May 2022 09:54:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] iommu/amd: Set translation valid bit only when IO page
 tables are in used
Content-Language: en-GB
To: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20220509074815.11881-1-suravee.suthikulpanit@amd.com>
 <Yn5YIfzmerwAM30M@8bytes.org> <1dfaf07e-040e-848b-db7c-86a107fd5cb3@amd.com>
 <YodMvV/8eii4KCLg@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YodMvV/8eii4KCLg@8bytes.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-05-20 09:09, Joerg Roedel wrote:
> Hi Suravee,
> 
> On Mon, May 16, 2022 at 07:27:51PM +0700, Suravee Suthikulpanit wrote:
>> Due to the new restriction (please see the IOMMU spec Rev 3.06-PUB - Apr 2021
>> https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf) where the use of
>> DTE[Mode]=0 is not supported on systems that are SNP-enabled (i.e. EFR[SNPSup]=1),
>> the IOMMU HW looks at the DTE[TV] bit to determine if it needs to handle the v1 page table.
>> When the HW encounters DTE entry with TV=1, V=1, Mode=0, it would generate
>> ILLEGAL_DEV_TABLE_ENTRY event.
> 
> Ah, that is the part I was missing, thanks.
> 
>> - I am still trying to see what is the best way to force Linux to not allow
>> Mode=0 (i.e. iommu=pt mode). Any thoughts?
> 
> I think this needs a general approach. First start in the AMD IOMMU
> driver:
> 
> 	1) Do not set DTE.TV=1 bit iff SNP-Support is enabled
> 	2) Fail to allocate passthrough domains when SNP support is
> 	   enabled.
> 
> Then test how the IOMMU core layer handles that. In fact the IOMMU layer
> needs to adjust its decisions so that:
> 
> 	1) It uses translated-mode by default
> 	2) passthrough domains are disallowed and can not be chosen, not
> 	   on the kernel command line and not at runtime.
> 
> Ideally this needs some kind of arch-callback to set the appropriate
> defaults.

The .def_domain type op already allows drivers to do exactly this sort 
of override. You could also conditionally reject 
IOMMU_DOMAIN_PASSTHROUGH in .domain_alloc for good measure, provided 
that (for now at least*) SNP is a global thing rather than per-instance.

Cheers,
Robin.

*Instance-aware .domain_alloc probably about 2 releases away at the 
current pace of landing the tree-wide prep ;)

>> - Also, it seems that the current iommu v2 page table use case, where GVA->GPA=SPA
>> will no longer be supported on system w/ SNPSup=1. Any thoughts?
> 
> Support for that is not upstream yet, it should be easy to disallow this
> configuration and just use the v1 page-tables when SNP is active. This
> can be handled entirely inside the AMD IOMMU driver.
> 
> Regards,
> 
> 	Joerg
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
