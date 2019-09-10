Return-Path: <SRS0=BH3E=XF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523CBC3A5A2
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 08:08:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F7D208E4
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 08:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F7D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A21DFE53;
	Tue, 10 Sep 2019 08:08:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6AD42E48
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 08:08:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5196082B
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 08:08:29 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 0ED8E386; Tue, 10 Sep 2019 10:08:26 +0200 (CEST)
Date: Tue, 10 Sep 2019 10:08:23 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Kyung Min Park <kyung.min.park@intel.com>
Subject: Re: [PATCH] iommu/vt-d: Add Scalable Mode fault information
Message-ID: <20190910080823.GA3247@8bytes.org>
References: <1567793642-17063-1-git-send-email-kyung.min.park@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1567793642-17063-1-git-send-email-kyung.min.park@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: andriy.shevchenko@intel.com, ashok.raj@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	dwmw2@infradead.org, baolu.lu@intel.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Sep 06, 2019 at 11:14:02AM -0700, Kyung Min Park wrote:
> Intel VT-d specification revision 3 added support for Scalable Mode
> Translation for DMA remapping. Add the Scalable Mode fault reasons to
> show detailed fault reasons when the translation fault happens.
> 
> Link: https://software.intel.com/sites/default/files/managed/c5/15/vt-directed-io-spec.pdf
> 
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
> ---
>  drivers/iommu/dmar.c        | 77 ++++++++++++++++++++++++++++++++++++++++++---
>  include/linux/intel-iommu.h |  2 ++
>  2 files changed, 75 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index 1207e05..5cb63c5 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1532,6 +1532,64 @@ static const char *dma_remap_fault_reasons[] =
>  	"PCE for translation request specifies blocking",
>  };
>  
> +static const char * const dma_remap_sm_fault_reasons[] = {
> +	"SM: Invalid Root Table Address",
> +	"SM: TTM 0 for request with PASID",
> +	"SM: TTM 0 for page group request",
> +	"Unknown", "Unknown", "Unknown", "Unknown", "Unknown", /* 0x33-0x37 */
> +	"SM: Error attempting to access Root Entry",
> +	"SM: Present bit in Root Entry is clear",
> +	"SM: Non-zero reserved field set in Root Entry",
> +	"Unknown", "Unknown", "Unknown", "Unknown", "Unknown", /* 0x3B-0x3F */
> +	"SM: Error attempting to access Context Entry",
> +	"SM: Present bit in Context Entry is clear",
> +	"SM: Non-zero reserved field set in the Context Entry",
> +	"SM: Invalid Context Entry",
> +	"SM: DTE field in Context Entry is clear",
> +	"SM: PASID Enable field in Context Entry is clear",
> +	"SM: PASID is larger than the max in Context Entry",
> +	"SM: PRE field in Context-Entry is clear",
> +	"SM: RID_PASID field error in Context-Entry",
> +	"Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", /* 0x49-0x4F */

Maybe add the number (0x49-0x4f) to the respecting "Unknown" fields? If
we can't give a reason we should give the number for easier debugging in
the future. Same for the "Unknown" fields below.

Other than that, the patch looks good.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
