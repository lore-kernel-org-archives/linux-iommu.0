Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA12ECE588
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 16:16:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682752064A
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 16:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682752064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2F927E6C;
	Tue, 15 Oct 2019 16:16:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E64E2E57
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 16:16:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 627526C5
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 16:16:48 +0000 (UTC)
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtp (Exim 4.89)
	(envelope-from <logang@deltatee.com>)
	id 1iKPV8-0007So-SM; Tue, 15 Oct 2019 10:16:47 -0600
To: Joerg Roedel <joro@8bytes.org>
References: <20191008221837.13067-1-logang@deltatee.com>
	<20191008221837.13067-4-logang@deltatee.com>
	<20191015133748.GC17570@8bytes.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6485fb62-cdb4-21e7-552d-1aa84a196458@deltatee.com>
Date: Tue, 15 Oct 2019 10:16:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015133748.GC17570@8bytes.org>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kchow@gigaio.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, joro@8bytes.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 3/3] iommu/amd: Support multiple PCI DMA aliases in IRQ
	Remapping
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
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



On 2019-10-15 7:37 a.m., Joerg Roedel wrote:
> On Tue, Oct 08, 2019 at 04:18:37PM -0600, Logan Gunthorpe wrote:
>> -static struct irq_remap_table *alloc_irq_table(u16 devid)
>> +static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
>> +				       void *data)
>> +{
>> +	struct irq_remap_table *table = data;
>> +
>> +	irq_lookup_table[alias] = table;
>> +	set_dte_irq_entry(alias, table);
>> +
>> +	return 0;
>> +}
>> +
>> +static int iommu_flush_dte_alias(struct pci_dev *pdev, u16 alias, void *data)
>> +{
>> +	struct amd_iommu *iommu = data;
>> +
>> +	iommu_flush_dte(iommu, alias);
>> +
>> +	return 0;
>> +}
> 
> I think these two functions can be merged into one, saving one
> pci_for_each_dma_alias() call below. You can lookup the iommu using the
> amd_iommu_rlookup_table[alias] in the first function and issue the flush
> there.

Makes sense, thanks.

I'll rework this and send a v2 shortly.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
