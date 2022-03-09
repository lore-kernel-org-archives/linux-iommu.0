Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C91C433F5
	for <iommu@archiver.kernel.org>; Wed,  9 Mar 2022 06:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5473F607B0;
	Wed,  9 Mar 2022 06:18:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RFAsvwPQ_M7K; Wed,  9 Mar 2022 06:18:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 16F7560797;
	Wed,  9 Mar 2022 06:18:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E14CDC001D;
	Wed,  9 Mar 2022 06:18:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0B0CC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 06:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BADD7812DD
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 06:18:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F05K3qxyc9EO for <iommu@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 06:18:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C1330812A1
 for <iommu@lists.linux-foundation.org>; Wed,  9 Mar 2022 06:18:46 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id A4A1568AFE; Wed,  9 Mar 2022 07:18:40 +0100 (CET)
Date: Wed, 9 Mar 2022 07:18:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 11/12] swiotlb: merge swiotlb-xen initialization into
 swiotlb
Message-ID: <20220309061840.GA31435@lst.de>
References: <20220301105311.885699-1-hch@lst.de>
 <20220301105311.885699-12-hch@lst.de>
 <6a22ea1e-4823-5c3b-97ee-a29155404a0d@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a22ea1e-4823-5c3b-97ee-a29155404a0d@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org, linux-ia64@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 tboot-devel@lists.sourceforge.net, xen-devel@lists.xenproject.org,
 David Woodhouse <dwmw2@infradead.org>, Tom Lendacky <thomas.lendacky@amd.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org, Juergen Gross <jgross@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

On Tue, Mar 08, 2022 at 04:38:21PM -0500, Boris Ostrovsky wrote:
>
> On 3/1/22 5:53 AM, Christoph Hellwig wrote:
>> Allow to pass a remap argument to the swiotlb initialization functions
>> to handle the Xen/x86 remap case.  ARM/ARM64 never did any remapping
>> from xen_swiotlb_fixup, so we don't even need that quirk.
>
>
> Any chance this patch could be split? Lots of things are happening here and it's somewhat hard to review. (Patch 7 too BTW but I think I managed to get through it)

What would be your preferred split?

>> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
>> index e0def4b1c3181..2f2c468acb955 100644
>> --- a/arch/x86/kernel/pci-dma.c
>> +++ b/arch/x86/kernel/pci-dma.c
>> @@ -71,15 +71,12 @@ static inline void __init pci_swiotlb_detect(void)
>>   #endif /* CONFIG_SWIOTLB */
>>     #ifdef CONFIG_SWIOTLB_XEN
>> -static bool xen_swiotlb;
>> -
>>   static void __init pci_xen_swiotlb_init(void)
>>   {
>>   	if (!xen_initial_domain() && !x86_swiotlb_enable)
>>   		return;
>
>
> Now that there is a single call site for this routine I think this check can be dropped. We are only called here for xen_initial_domain()==true.

The callsite just checks xen_pv_domain() and itself is called
unconditionally during initialization.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
