Return-Path: <SRS0=wR7u=ZM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C84C43215
	for <iommu@archiver.kernel.org>; Wed, 20 Nov 2019 19:53:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 715982071F
	for <iommu@archiver.kernel.org>; Wed, 20 Nov 2019 19:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715982071F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3E3BD81D35;
	Wed, 20 Nov 2019 19:53:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bLNABXjz-6Ay; Wed, 20 Nov 2019 19:53:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2E6F581C8D;
	Wed, 20 Nov 2019 19:53:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16AF1C1DD8;
	Wed, 20 Nov 2019 19:53:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D92EC18DA
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 19:53:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7275984187
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 19:53:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IZX6Essfrkgi for <iommu@lists.linux-foundation.org>;
 Wed, 20 Nov 2019 19:53:33 +0000 (UTC)
X-Greylist: delayed 00:22:38 by SQLgrey-1.7.6
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6AB9A8407F
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 19:53:33 +0000 (UTC)
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230]
 helo=[192.168.11.155])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1iXVgh-00024K-6G; Wed, 20 Nov 2019 12:30:52 -0700
To: Dmitry Safonov <0x7f454c46@gmail.com>,
 James Sewart <jamessewart@arista.com>, iommu@lists.linux-foundation.org
References: <A3FA9DE1-2EEF-41D8-9AC2-B1F760E7F5D5@arista.com>
 <0B8FAD0D-B598-4CEA-A614-67F4C7C5B9CA@arista.com>
 <5c3b56dd-7088-e544-6628-01506f7b84e8@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c683ec65-40a9-6430-ae85-ce3934ed8af5@deltatee.com>
Date: Wed, 20 Nov 2019 12:30:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5c3b56dd-7088-e544-6628-01506f7b84e8@gmail.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: bhelgaas@google.com, linux-pci@vger.kernel.org,
 dima@arista.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jamessewart@arista.com, 0x7f454c46@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] Ensure pci transactions coming from PLX NTB are handled
 when IOMMU is turned on
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>
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



On 2019-11-20 10:48 a.m., Dmitry Safonov wrote:
> +Cc: linux-pci@vger.kernel.org
> +Cc: Bjorn Helgaas <bhelgaas@google.com>
> +Cc: Logan Gunthorpe <logang@deltatee.com>
> 
> On 11/5/19 12:17 PM, James Sewart wrote:
>> Any comments on this?
>>
>> Cheers,
>> James.
>>
>>> On 24 Oct 2019, at 13:52, James Sewart <jamessewart@arista.com> wrote:
>>>
>>> The PLX PEX NTB forwards DMA transactions using Requester ID's that don't exist as
>>> PCI devices. The devfn for a transaction is used as an index into a lookup table
>>> storing the origin of a transaction on the other side of the bridge.
>>>
>>> This patch aliases all possible devfn's to the NTB device so that any transaction
>>> coming in is governed by the mappings for the NTB.
>>>
>>> Signed-Off-By: James Sewart <jamessewart@arista.com>
>>> ---
>>> drivers/pci/quirks.c | 22 ++++++++++++++++++++++
>>> 1 file changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index 320255e5e8f8..647f546e427f 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -5315,6 +5315,28 @@ SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
>>> SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
>>> SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
>>>
>>> +/*
>>> + * PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints. These IDs
>>> + * are used to forward responses to the originator on the other side of the
>>> + * NTB. Alias all possible IDs to the NTB to permit access when the IOMMU is
>>> + * turned on.
>>> + */
>>> +static void quirk_PLX_NTB_dma_alias(struct pci_dev *pdev)
>>> +{
>>> +	if (!pdev->dma_alias_mask)
>>> +		pdev->dma_alias_mask = kcalloc(BITS_TO_LONGS(U8_MAX),
>>> +					      sizeof(long), GFP_KERNEL);
>>> +	if (!pdev->dma_alias_mask) {
>>> +		dev_warn(&pdev->dev, "Unable to allocate DMA alias mask\n");
>>> +		return;
>>> +	}
>>> +
>>> +	// PLX NTB may use all 256 devfns
>>> +	memset(pdev->dma_alias_mask, U8_MAX, (U8_MAX+1)/BITS_PER_BYTE);

I think it would be better to create a pci_add_dma_alias_range()
function instead of directly accessing dma_alias_mask. We could then use
that function to clean up quirk_switchtec_ntb_dma_alias() which is
essentially doing the same thing.

It's also quite ugly that you're allocating with kcalloc here instead of
bitmap_zalloc() seeing it will be free'd with bitmap_free(). Also, you
should probably use bitmap_set() instead of memset().

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
