Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D23ECE58F
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 13:37:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257DA2064A
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 13:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257DA2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 02D18E52;
	Tue, 15 Oct 2019 13:37:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8E7B8C59
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 13:37:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0854D6D6
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 13:37:51 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id CAC062DF; Tue, 15 Oct 2019 15:37:49 +0200 (CEST)
Date: Tue, 15 Oct 2019 15:37:48 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 3/3] iommu/amd: Support multiple PCI DMA aliases in IRQ
	Remapping
Message-ID: <20191015133748.GC17570@8bytes.org>
References: <20191008221837.13067-1-logang@deltatee.com>
	<20191008221837.13067-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191008221837.13067-4-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Kit Chow <kchow@gigaio.com>
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

On Tue, Oct 08, 2019 at 04:18:37PM -0600, Logan Gunthorpe wrote:
> -static struct irq_remap_table *alloc_irq_table(u16 devid)
> +static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
> +				       void *data)
> +{
> +	struct irq_remap_table *table = data;
> +
> +	irq_lookup_table[alias] = table;
> +	set_dte_irq_entry(alias, table);
> +
> +	return 0;
> +}
> +
> +static int iommu_flush_dte_alias(struct pci_dev *pdev, u16 alias, void *data)
> +{
> +	struct amd_iommu *iommu = data;
> +
> +	iommu_flush_dte(iommu, alias);
> +
> +	return 0;
> +}

I think these two functions can be merged into one, saving one
pci_for_each_dma_alias() call below. You can lookup the iommu using the
amd_iommu_rlookup_table[alias] in the first function and issue the flush
there.


Regards,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
