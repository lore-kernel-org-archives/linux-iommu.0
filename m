Return-Path: <SRS0=codQ=S4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC68BC43218
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 14:06:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66DC2077B
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 14:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66DC2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4C8B827DF;
	Fri, 26 Apr 2019 14:06:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7A7D32345
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 14:04:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0656E860
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 14:04:32 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 2E59F447; Fri, 26 Apr 2019 16:04:31 +0200 (CEST)
Date: Fri, 26 Apr 2019 16:04:29 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Tom Murphy <tmurphy@arista.com>
Subject: Re: [PATCH v1] iommu/amd: flush not present cache in iommu_map_page
Message-ID: <20190426140429.GG24576@8bytes.org>
References: <20190424165051.13614-1-tmurphy@arista.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190424165051.13614-1-tmurphy@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	murphyt7@tcd.ie
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190426140429.RfweHWP4h0jIuU_tNjb7l_qlM5-Kq60eQ9UJUC7_oL4@z>

On Wed, Apr 24, 2019 at 05:50:51PM +0100, Tom Murphy wrote:
> check if there is a not-present cache present and flush it if there is.
> 
> Signed-off-by: Tom Murphy <tmurphy@arista.com>
> ---
>  drivers/iommu/amd_iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index f7cdd2ab7f11..91fe5cb10f50 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1637,6 +1637,11 @@ static int iommu_map_page(struct protection_domain *dom,
>  
>  	update_domain(dom);
>  
> +	if (unlikely(amd_iommu_np_cache && !dom->updated)) {
> +		domain_flush_pages(dom, bus_addr, page_size);
> +		domain_flush_complete(dom);
> +	}
> +

The iommu_map_page function is called once per physical page that is
mapped, so in the worst case for every 4k mapping established. So it is
not the right place to put this check in.

From a quick glance this check belongs into the map_sg() and the
amd_iommu_map() function, but without the dom->updated check.

Besides, to really support systems with np-cache in a way that doesn't
destroy all performance, the driver also needs range-flushes for IOTLBs.
Currently it can only flush a 4k page of the full address space of a
domain. But that doesn't mean we shouldn't fix the missing flushes now.

So please re-send the patch with the check at the two places I pointed
out above.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
