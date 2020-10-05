Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A086C4363A
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 15:53:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E4A2068E
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 15:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E4A2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ABBDC857CE;
	Mon,  5 Oct 2020 15:52:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UP0orvRlhiwH; Mon,  5 Oct 2020 15:52:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C4B9385778;
	Mon,  5 Oct 2020 15:52:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8B39C07FF;
	Mon,  5 Oct 2020 15:52:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4128C0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 15:52:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8D1132047C
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 15:52:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PbxkCwl49KAh for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 15:52:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by silver.osuosl.org (Postfix) with ESMTPS id 4F4ED2042E
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 15:52:53 +0000 (UTC)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2FA2428EAA9;
 Mon,  5 Oct 2020 16:52:51 +0100 (BST)
Date: Mon, 5 Oct 2020 17:52:47 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 1/3] iommu/io-pgtable-arm: Support coherency for Mali
 LPAE
Message-ID: <20201005175247.002bf8f0@collabora.com>
In-Reply-To: <07c4b74f-c87b-092c-3fc7-c005c8c65206@arm.com>
References: <cover.1600780574.git.robin.murphy@arm.com>
 <8df778355378127ea7eccc9521d6427e3e48d4f2.1600780574.git.robin.murphy@arm.com>
 <20201005165008.1f3b4e89@collabora.com>
 <07c4b74f-c87b-092c-3fc7-c005c8c65206@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Cc: robh@kernel.org, tomeu.vizoso@collabora.com, narmstrong@baylibre.com,
 khilman@baylibre.com, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 alyssa.rosenzweig@collabora.com, linux-amlogic@lists.infradead.org,
 will@kernel.org, linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com
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

On Mon, 5 Oct 2020 16:16:32 +0100
Steven Price <steven.price@arm.com> wrote:

> On 05/10/2020 15:50, Boris Brezillon wrote:
> > On Tue, 22 Sep 2020 15:16:48 +0100
> > Robin Murphy <robin.murphy@arm.com> wrote:
> >   
> >> Midgard GPUs have ACE-Lite master interfaces which allows systems to
> >> integrate them in an I/O-coherent manner. It seems that from the GPU's
> >> viewpoint, the rest of the system is its outer shareable domain, and so
> >> even when snoop signals are wired up, they are only emitted for outer
> >> shareable accesses. As such, setting the TTBR_SHARE_OUTER bit does
> >> indeed get coherent pagetable walks working nicely for the coherent
> >> T620 in the Arm Juno SoC.
> >>
> >> Reviewed-by: Steven Price <steven.price@arm.com>
> >> Tested-by: Neil Armstrong <narmstrong@baylibre.com>
> >> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >> ---
> >>   drivers/iommu/io-pgtable-arm.c | 11 ++++++++++-
> >>   1 file changed, 10 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> >> index dc7bcf858b6d..b4072a18e45d 100644
> >> --- a/drivers/iommu/io-pgtable-arm.c
> >> +++ b/drivers/iommu/io-pgtable-arm.c
> >> @@ -440,7 +440,13 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
> >>   				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
> >>   	}
> >>   
> >> -	if (prot & IOMMU_CACHE)
> >> +	/*
> >> +	 * Also Mali has its own notions of shareability wherein its Inner
> >> +	 * domain covers the cores within the GPU, and its Outer domain is
> >> +	 * "outside the GPU" (i.e. either the Inner or System domain in CPU
> >> +	 * terms, depending on coherency).
> >> +	 */
> >> +	if (prot & IOMMU_CACHE && data->iop.fmt != ARM_MALI_LPAE)
> >>   		pte |= ARM_LPAE_PTE_SH_IS;
> >>   	else
> >>   		pte |= ARM_LPAE_PTE_SH_OS;  
> > 
> > Actually, it still doesn't work on s922x :-/. For it to work I
> > correctly, I need to drop the outer shareable flag here.  
> 
> The logic here does seem a bit odd. Originally it was:
> 
> IOMMU_CACHE -> Inner shared (value 3)
> !IOMMU_CACHE -> Outer shared (value 2)
> 
> For Mali we're forcing everything to the second option. But Mali being 
> Mali doesn't do things the same as LPAE, so for Mali we have:
> 
> 0 - not shared
> 1 - reserved
> 2 - inner(*) and outer shareable
> 3 - inner shareable only
> 
> (*) where "inner" means internal to the GPU, and "outer" means shared 
> with the CPU "inner". Very confusing!
> 
> So originally we had:
> IOMMU_CACHE -> not shared with CPU (only internally in the GPU)
> !IOMMU_CACHE -> shared with CPU
> 
> The change above gets us to "always shared", dropping the SH_OS bit 
> would get us to not even shareable between cores (which doesn't sound 
> like what we want).

Thanks for this explanation.

> 
> It's not at all clear to me why the change helps, but I suspect we want 
> at least "inner" shareable.

Right. Looks like all this was caused by a bad conflict resolution
during a rebase. Sorry for the noise :-/.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
