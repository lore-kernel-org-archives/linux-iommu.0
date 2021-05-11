Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C01C43461
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:05:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584466192A
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 16:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584466192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 115A383C9D;
	Tue, 11 May 2021 16:05:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VYEPlRf3bRB8; Tue, 11 May 2021 16:05:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAE3783CC7;
	Tue, 11 May 2021 16:05:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B96B3C000E;
	Tue, 11 May 2021 16:05:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B4F3C0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:05:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 738B240408
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:05:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IN2Y9QoK7Gd8 for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 16:05:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C7E740407
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 16:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620749145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VZKhZh9rreTRPd4zpdyIwtNRUh5ttKTpBqZ0LlHmIQ0=;
 b=WsW3jFQoJG2aTEkICNi6n+7ai10mZ4p+J810RUKNpD4qQs3ZlceVNswGuqoA3ax71N9LdX
 jE21BRw1xqjvn/Zys1xPfTfiEFDO2/d9DJ5BxKXZv2gaIm7LrWPNg7UUW2Ysj8IuxeuRFl
 T9chFw2l8ml6TlgmzX/djqjCWUbNUbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-bChFT7ESMtyqf2dZFYH_2g-1; Tue, 11 May 2021 12:05:40 -0400
X-MC-Unique: bChFT7ESMtyqf2dZFYH_2g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC08F80EDB9;
 Tue, 11 May 2021 16:05:37 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 471751037F29;
 Tue, 11 May 2021 16:05:35 +0000 (UTC)
Subject: Re: [PATCH 02/16] PCI/P2PDMA: Avoid pci_get_slot() which sleeps
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-3-logang@deltatee.com>
From: Don Dutile <ddutile@redhat.com>
Message-ID: <09f6c713-5ae6-035c-c0ab-a8bd0fac7a79@redhat.com>
Date: Tue, 11 May 2021 12:05:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-3-logang@deltatee.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 4/8/21 1:01 PM, Logan Gunthorpe wrote:
> In order to use upstream_bridge_distance_warn() from a dma_map function,
> it must not sleep. However, pci_get_slot() takes the pci_bus_sem so it
> might sleep.
>
> In order to avoid this, try to get the host bridge's device from
> bus->self, and if that is not set, just get the first element in the
> device list. It should be impossible for the host bridge's device to
> go away while references are held on child devices, so the first element
> should not be able to change and, thus, this should be safe.
Bjorn:
Why wouldn't (shouldn't?) the bus->self field be set for a host bridge device?
Should this situation be repaired in the host-brige config/setup code elsewhere in the kernel.
... and here, a check-and-fail with info of what doesn't have it setup (another new pci function to do the check & prinfo), so it can point to the offending host-bridge, and thus, the code that needs to be updated?


> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/pci/p2pdma.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index bd89437faf06..473a08940fbc 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -311,16 +311,26 @@ static const struct pci_p2pdma_whitelist_entry {
>   static bool __host_bridge_whitelist(struct pci_host_bridge *host,
>   				    bool same_host_bridge)
>   {
> -	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
>   	const struct pci_p2pdma_whitelist_entry *entry;
> +	struct pci_dev *root = host->bus->self;
>   	unsigned short vendor, device;
>   
> +	/*
> +	 * This makes the assumption that the first device on the bus is the
> +	 * bridge itself and it has the devfn of 00.0. This assumption should
> +	 * hold for the devices in the white list above, and if there are cases
> +	 * where this isn't true they will have to be dealt with when such a
> +	 * case is added to the whitelist.
> +	 */
>   	if (!root)
> +		root = list_first_entry_or_null(&host->bus->devices,
> +						struct pci_dev, bus_list);
> +
> +	if (!root || root->devfn)
>   		return false;
>   
>   	vendor = root->vendor;
>   	device = root->device;
> -	pci_dev_put(root);
>   
>   	for (entry = pci_p2pdma_whitelist; entry->vendor; entry++) {
>   		if (vendor != entry->vendor || device != entry->device)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
