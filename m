Return-Path: <SRS0=wR7u=ZM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5FEC432C0
	for <iommu@archiver.kernel.org>; Wed, 20 Nov 2019 17:48:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B14172068D
	for <iommu@archiver.kernel.org>; Wed, 20 Nov 2019 17:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4N3n5Pd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14172068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9E1F6886AA;
	Wed, 20 Nov 2019 17:48:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xOLwoCRFxON9; Wed, 20 Nov 2019 17:48:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0B64A886A6;
	Wed, 20 Nov 2019 17:48:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3073C1DD8;
	Wed, 20 Nov 2019 17:48:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16CEDC18DA
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 17:48:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 047F086DA9
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 17:48:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5vpJEynNHm5X for <iommu@lists.linux-foundation.org>;
 Wed, 20 Nov 2019 17:48:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3DFF186DA1
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 17:48:54 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id t26so1762032wmi.0
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 09:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Gb5aW3R/KOwRkVEvqWdyeVDOFlNOArlGLF6/Wf4S7KY=;
 b=o4N3n5Pd7xMvM3x6YL9p7RkLA0EaB/gwGYDulzXpofsMxMfBVWzMxAYm+VAQafUko9
 uGE+Mm3kQsnpCU/PRAcHHpEmsCyW4quf2NcgU0OC0k5Z9kL3e2ONCUQGTdvWSu57Ir37
 Nl/GXiX+9oEFJuUY2QxToBjBCh0hDTWFm4pxxnapc6gndzXSMPM16dh8jnmN+jo9YxMm
 Rp8zhNM4Luchw1G2R5zZoACrL2AlIC1gRWVOCMgKJLEvqj0qluAao6YLldT8MG1zscDL
 qMnU9qGaOTo61E38pKd7uxcDP6NIigQAyxy8dge1PUq/84Vr6srhVZIb2Gt4bUzVPe/2
 kdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Gb5aW3R/KOwRkVEvqWdyeVDOFlNOArlGLF6/Wf4S7KY=;
 b=myTeQmK6rqOKcT1Khxir86oXi/JKdFoxjDGFZeLr89Jd4hoiNJsCIMa+PoAkvaAPU9
 2MdaQ7SF0GzOteX/o8CyMBx17rpThVKlCnt0f9xcdp/E8DU+a/TQOkdCg2wlsgAHGDtw
 FRmGKNAIuJ88irNoaCZhCKLiNCf+kqN1cokVJmF1fqjZVnzrkXeTlqOqjMYm4SFHm4ud
 EomFlJKrhKn8SmFjnhDrGL0fqaGbAhimUCX3nO2jNpus5+Um9yUfahMRrrhXaNrhOlWI
 lBUko8XO6+nI4orK4WAjtDjvottOoAIBam4oJrEOiqRrFp5ZRmw8ymmg46I1YwQcGGm9
 gJNA==
X-Gm-Message-State: APjAAAVfmjJsGXFVhELichPy4tGE0ZBEkEV4tB1Hh3cSvX4si/odC8KQ
 NuK2syxlF5qPHWxJLZOcfNs=
X-Google-Smtp-Source: APXvYqwXdDQUtrOZSro2T2/CaWB+MPqo3m0UdZTaIiLCvG0M8O7HDp8aMnaddseMLcQwky08IkX0ag==
X-Received: by 2002:a05:600c:210b:: with SMTP id
 u11mr4849653wml.170.1574272132571; 
 Wed, 20 Nov 2019 09:48:52 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
 by smtp.gmail.com with ESMTPSA id t14sm31266663wrw.87.2019.11.20.09.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2019 09:48:51 -0800 (PST)
Subject: Re: [PATCH] Ensure pci transactions coming from PLX NTB are handled
 when IOMMU is turned on
To: James Sewart <jamessewart@arista.com>, iommu@lists.linux-foundation.org
References: <A3FA9DE1-2EEF-41D8-9AC2-B1F760E7F5D5@arista.com>
 <0B8FAD0D-B598-4CEA-A614-67F4C7C5B9CA@arista.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <5c3b56dd-7088-e544-6628-01506f7b84e8@gmail.com>
Date: Wed, 20 Nov 2019 17:48:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0B8FAD0D-B598-4CEA-A614-67F4C7C5B9CA@arista.com>
Content-Language: en-US
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 Dmitry Safonov <dima@arista.com>
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

+Cc: linux-pci@vger.kernel.org
+Cc: Bjorn Helgaas <bhelgaas@google.com>
+Cc: Logan Gunthorpe <logang@deltatee.com>

On 11/5/19 12:17 PM, James Sewart wrote:
> Any comments on this?
> 
> Cheers,
> James.
> 
>> On 24 Oct 2019, at 13:52, James Sewart <jamessewart@arista.com> wrote:
>>
>> The PLX PEX NTB forwards DMA transactions using Requester ID's that don't exist as
>> PCI devices. The devfn for a transaction is used as an index into a lookup table
>> storing the origin of a transaction on the other side of the bridge.
>>
>> This patch aliases all possible devfn's to the NTB device so that any transaction
>> coming in is governed by the mappings for the NTB.
>>
>> Signed-Off-By: James Sewart <jamessewart@arista.com>
>> ---
>> drivers/pci/quirks.c | 22 ++++++++++++++++++++++
>> 1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 320255e5e8f8..647f546e427f 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -5315,6 +5315,28 @@ SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
>> SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
>> SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
>>
>> +/*
>> + * PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints. These IDs
>> + * are used to forward responses to the originator on the other side of the
>> + * NTB. Alias all possible IDs to the NTB to permit access when the IOMMU is
>> + * turned on.
>> + */
>> +static void quirk_PLX_NTB_dma_alias(struct pci_dev *pdev)
>> +{
>> +	if (!pdev->dma_alias_mask)
>> +		pdev->dma_alias_mask = kcalloc(BITS_TO_LONGS(U8_MAX),
>> +					      sizeof(long), GFP_KERNEL);
>> +	if (!pdev->dma_alias_mask) {
>> +		dev_warn(&pdev->dev, "Unable to allocate DMA alias mask\n");
>> +		return;
>> +	}
>> +
>> +	// PLX NTB may use all 256 devfns
>> +	memset(pdev->dma_alias_mask, U8_MAX, (U8_MAX+1)/BITS_PER_BYTE);
>> +}
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b0, quirk_PLX_NTB_dma_alias);
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b1, quirk_PLX_NTB_dma_alias);
>> +
>> /*
>>  * On Lenovo Thinkpad P50 SKUs with a Nvidia Quadro M1000M, the BIOS does
>>  * not always reset the secondary Nvidia GPU between reboots if the system
>> -- 
>> 2.19.1
>>
>>
> 

Thanks,
          Dmitry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
