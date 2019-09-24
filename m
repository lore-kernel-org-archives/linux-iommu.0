Return-Path: <SRS0=VpBQ=XT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FC8C432C1
	for <iommu@archiver.kernel.org>; Tue, 24 Sep 2019 09:21:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C691C214AF
	for <iommu@archiver.kernel.org>; Tue, 24 Sep 2019 09:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C691C214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 80C2AC77;
	Tue, 24 Sep 2019 09:21:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E2B2AC74
	for <iommu@lists.linux-foundation.org>;
	Tue, 24 Sep 2019 09:21:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C309E8AA
	for <iommu@lists.linux-foundation.org>;
	Tue, 24 Sep 2019 09:21:06 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 908003A2; Tue, 24 Sep 2019 11:21:04 +0200 (CEST)
Date: Tue, 24 Sep 2019 11:21:01 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Andrei Dulea <adulea@amazon.de>
Subject: Re: [PATCH 1/4] iommu/amd: Fix pages leak in free_pagetable()
Message-ID: <20190924092101.GA11453@8bytes.org>
References: <20190913144231.21382-1-adulea@amazon.de>
	<20190913144231.21382-2-adulea@amazon.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190913144231.21382-2-adulea@amazon.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org,
	Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
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

Hi Andrei,

On Fri, Sep 13, 2019 at 04:42:28PM +0200, Andrei Dulea wrote:
> Take into account the gathered freelist in free_sub_pt(), otherwise we
> end up leaking all that pages.
> 
> Fixes: 409afa44f9ba ("iommu/amd: Introduce free_sub_pt() function")
> Signed-off-by: Andrei Dulea <adulea@amazon.de>
> ---
>  drivers/iommu/amd_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 1ed3b98324ba..138547446345 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1425,7 +1425,7 @@ static void free_pagetable(struct protection_domain *domain)
>  	BUG_ON(domain->mode < PAGE_MODE_NONE ||
>  	       domain->mode > PAGE_MODE_6_LEVEL);
>  
> -	free_sub_pt(root, domain->mode, freelist);
> +	freelist = free_sub_pt(root, domain->mode, freelist);

What a stupid mistake, thanks for fixing this. That is a clear example
which shows that we need more reviewers. Applied the whole series.


Thanks again,

       Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
