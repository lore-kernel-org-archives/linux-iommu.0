Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02CAC433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 20:39:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4D964F49
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 20:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4D964F49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3354D60660;
	Fri, 12 Mar 2021 20:39:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 73hyHtpmDn3t; Fri, 12 Mar 2021 20:39:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C93560661;
	Fri, 12 Mar 2021 20:39:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9C15C000A;
	Fri, 12 Mar 2021 20:39:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0916C0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 20:39:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D6F1143083
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 20:39:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R0geoC7WB5ko for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 20:39:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 426BA414D8
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 20:39:38 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CA2864F4F;
 Fri, 12 Mar 2021 20:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615581577;
 bh=9xbU4dGm9+BmmqkFklPfuZZosdug6fd3AsnEv7H5YFw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=HwKo5k8pp1FCYm+q0FK8hZDzmOtZx9D48iVHE47cQK63UFdrBQCVKqUKLkgEBggln
 9ztDXjeFMO5NtU6M81ttmz3YIzjAGdpaoj3WUyaTpYbLYPOIKTitTDDSUkBhPVh3ei
 uZsnO60vXuNiDQWVZ67GOIH2ex/69BES8gJ7TKBgxsWmrOjmXpp0jtb76zJB+drQ+5
 ttjsPLmcKVIKwI3YB6xyobjyZP8xBLzeJdU5wwcKBBOdxC6tVTrjKJeom0pbVqECZk
 AfgwD4VNAjFL9YMwxOIBwj+mIvgXP13JwgZm35A3RHZfv+EulcxAypQ0uvjMBrvARD
 TGvtqBg9cRwfw==
Date: Fri, 12 Mar 2021 14:39:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH v2 01/11] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
Message-ID: <20210312203936.GA2286981@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210311233142.7900-2-logang@deltatee.com>
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ira Weiny <iweiny@intel.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, linux-block@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Jason Ekstrand <jason@jlekstrand.net>, John Hubbard <jhubbard@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

On Thu, Mar 11, 2021 at 04:31:31PM -0700, Logan Gunthorpe wrote:
> In order to call this function from a dma_map function, it must not sleep.
> The only reason it does sleep so to allocate the seqbuf to print
> which devices are within the ACS path.

s/this function/upstream_bridge_distance_warn()/ ?
s/so to/is to/

Maybe the subject could say something about the purpose, e.g., allow
calling from atomic context or something?  "Pass gfp_mask flags" sort
of restates what we can read from the patch, but without the
motivation of why this is useful.

> Switch the kmalloc call to use a passed in gfp_mask  and don't print that
> message if the buffer fails to be allocated.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/p2pdma.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 196382630363..bd89437faf06 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -267,7 +267,7 @@ static int pci_bridge_has_acs_redir(struct pci_dev *pdev)
>  
>  static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
>  {
> -	if (!buf)
> +	if (!buf || !buf->buffer)
>  		return;
>  
>  	seq_buf_printf(buf, "%s;", pci_name(pdev));
> @@ -495,25 +495,26 @@ upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
>  
>  static enum pci_p2pdma_map_type
>  upstream_bridge_distance_warn(struct pci_dev *provider, struct pci_dev *client,
> -			      int *dist)
> +			      int *dist, gfp_t gfp_mask)
>  {
>  	struct seq_buf acs_list;
>  	bool acs_redirects;
>  	int ret;
>  
> -	seq_buf_init(&acs_list, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
> -	if (!acs_list.buffer)
> -		return -ENOMEM;
> +	seq_buf_init(&acs_list, kmalloc(PAGE_SIZE, gfp_mask), PAGE_SIZE);
>  
>  	ret = upstream_bridge_distance(provider, client, dist, &acs_redirects,
>  				       &acs_list);
>  	if (acs_redirects) {
>  		pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
>  			 pci_name(provider));
> -		/* Drop final semicolon */
> -		acs_list.buffer[acs_list.len-1] = 0;
> -		pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
> -			 acs_list.buffer);
> +
> +		if (acs_list.buffer) {
> +			/* Drop final semicolon */
> +			acs_list.buffer[acs_list.len - 1] = 0;
> +			pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
> +				 acs_list.buffer);
> +		}
>  	}
>  
>  	if (ret == PCI_P2PDMA_MAP_NOT_SUPPORTED) {
> @@ -566,7 +567,7 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
>  
>  		if (verbose)
>  			ret = upstream_bridge_distance_warn(provider,
> -					pci_client, &distance);
> +					pci_client, &distance, GFP_KERNEL);
>  		else
>  			ret = upstream_bridge_distance(provider, pci_client,
>  						       &distance, NULL, NULL);
> -- 
> 2.20.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
