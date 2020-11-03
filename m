Return-Path: <SRS0=TrXs=EJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896BFC2D0A3
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 13:35:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F0D2224E
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 13:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F0D2224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4C73C20013;
	Tue,  3 Nov 2020 13:35:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ca3XMJvuTrnp; Tue,  3 Nov 2020 13:35:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3D2B520003;
	Tue,  3 Nov 2020 13:35:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17915C088B;
	Tue,  3 Nov 2020 13:35:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBCF9C0051
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 13:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C222286C39
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 13:35:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fyhm2gY9J4+3 for <iommu@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 13:35:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 13D8886C23
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 13:35:53 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 7FD9A433; Tue,  3 Nov 2020 14:35:51 +0100 (CET)
Date: Tue, 3 Nov 2020 14:35:50 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Enforce 4k mapping for certain IOMMU data
 structures
Message-ID: <20201103133549.GI22888@8bytes.org>
References: <20201028231824.56504-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201028231824.56504-1-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, Jon.Grimm@amd.com, brijesh.singh@amd.com,
 linux-kernel@vger.kernel.org
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

On Wed, Oct 28, 2020 at 11:18:24PM +0000, Suravee Suthikulpanit wrote:
> AMD IOMMU requires 4k-aligned pages for the event log, the PPR log,
> and the completion wait write-back regions. However, when allocating
> the pages, they could be part of large mapping (e.g. 2M) page.
> This causes #PF due to the SNP RMP hardware enforces the check based
> on the page level for these data structures.
> 
> So, fix by calling set_memory_4k() on the allocated pages.
> 
> Fixes: commit c69d89aff393 ("iommu/amd: Use 4K page for completion wait write-back semaphore")
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/init.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 82e4af8f09bb..75dc30226a7c 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -29,6 +29,7 @@
>  #include <asm/iommu_table.h>
>  #include <asm/io_apic.h>
>  #include <asm/irq_remapping.h>
> +#include <asm/set_memory.h>
>  
>  #include <linux/crash_dump.h>
>  
> @@ -672,11 +673,22 @@ static void __init free_command_buffer(struct amd_iommu *iommu)
>  	free_pages((unsigned long)iommu->cmd_buf, get_order(CMD_BUFFER_SIZE));
>  }
>  
> +static void *__init iommu_alloc_4k_pages(gfp_t gfp, size_t size)
> +{
> +	void *buf;
> +	int order = get_order(size);
> +
> +	buf = (void *)__get_free_pages(gfp, order);
> +	if (!buf)
> +		return buf;
> +	return set_memory_4k((unsigned long)buf, (1 << order)) ? NULL : buf;
> +}
> +

Please make the 4k split only if SNP is actually enabled in the system.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
