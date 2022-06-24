Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1B3C433EF
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 15:38:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BA3A425B1;
	Fri, 24 Jun 2022 15:38:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0BA3A425B1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S_NiCdbMdjqu; Fri, 24 Jun 2022 15:38:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7B88D425EE;
	Fri, 24 Jun 2022 15:38:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7B88D425EE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36CB1C0032;
	Fri, 24 Jun 2022 15:38:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F994C002D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 15:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3750D60DC6
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 15:38:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3750D60DC6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eh1I-4Tns7lg for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 15:38:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65C4460BD7
Received: from mailout.easymail.ca (mailout.easymail.ca [64.68.200.34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 65C4460BD7
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 15:38:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mailout.easymail.ca (Postfix) with ESMTP id 36ABB61F0C;
 Fri, 24 Jun 2022 15:38:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo09-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
 by localhost (emo09-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E8sVpuImiYNQ; Fri, 24 Jun 2022 15:38:22 +0000 (UTC)
Received: from mail.gonehiking.org (unknown [38.15.45.1])
 by mailout.easymail.ca (Postfix) with ESMTPA id E956B61EFC;
 Fri, 24 Jun 2022 15:38:21 +0000 (UTC)
Received: from [192.168.1.4] (internal [192.168.1.4])
 by mail.gonehiking.org (Postfix) with ESMTP id 146083EE4C;
 Fri, 24 Jun 2022 09:38:21 -0600 (MDT)
Message-ID: <c955bf95-838f-cc0a-8496-322b831e5648@gonehiking.org>
Date: Fri, 24 Jun 2022 09:38:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/3] scsi: BusLogic remove bus_to_virt
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-3-arnd@kernel.org>
 <7a6df2da-95e8-b2fd-7565-e4b7a51c5b63@gonehiking.org>
 <CAK8P3a0t_0scofn_2N1Q8wgJ4panKCN58AgnsJSVEj28K614oQ@mail.gmail.com>
From: Khalid Aziz <khalid@gonehiking.org>
In-Reply-To: <CAK8P3a0t_0scofn_2N1Q8wgJ4panKCN58AgnsJSVEj28K614oQ@mail.gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Miquel van Smoorenburg <mikevs@xs4all.net>,
 linux-scsi <linux-scsi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Denis Efremov <efremov@linux.com>, Mark Salyzyn <salyzyn@android.com>,
 Christoph Hellwig <hch@infradead.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Matt Wang <wwentao@vmware.com>, Parisc List <linux-parisc@vger.kernel.org>,
 alpha <linux-alpha@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>, Robin Murphy <robin.murphy@arm.com>
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
Reply-To: khalid@gonehiking.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 6/23/22 08:47, Arnd Bergmann wrote:
> 
> 
> Can you test it again with this patch on top?
> 
> diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
> index d057abfcdd5c..9e67f2ee25ee 100644
> --- a/drivers/scsi/BusLogic.c
> +++ b/drivers/scsi/BusLogic.c
> @@ -2554,8 +2554,14 @@ static void blogic_scan_inbox(struct
> blogic_adapter *adapter)
>          enum blogic_cmplt_code comp_code;
> 
>          while ((comp_code = next_inbox->comp_code) != BLOGIC_INBOX_FREE) {
> -               struct blogic_ccb *ccb = blogic_inbox_to_ccb(adapter,
> adapter->next_inbox);
> -               if (comp_code != BLOGIC_CMD_NOTFOUND) {
> +               struct blogic_ccb *ccb = blogic_inbox_to_ccb(adapter,
> next_inbox);
> +               if (!ccb) {
> +                       /*
> +                        * This should never happen, unless the CCB list is
> +                        * corrupted in memory.
> +                        */
> +                       blogic_warn("Could not find CCB for dma
> address 0x%x\n", adapter, next_inbox->ccb);
> +               } else if (comp_code != BLOGIC_CMD_NOTFOUND) {
>                          if (ccb->status == BLOGIC_CCB_ACTIVE ||
>                                          ccb->status == BLOGIC_CCB_RESET) {

Hi Arnd,

Driver works with this change. next_inbox is the correct pointer to pass.

Thanks,
Khalid
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
