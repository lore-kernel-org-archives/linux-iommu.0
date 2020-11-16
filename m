Return-Path: <SRS0=dfl9=EW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660CCC4742C
	for <iommu@archiver.kernel.org>; Mon, 16 Nov 2020 12:50:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C09222EC
	for <iommu@archiver.kernel.org>; Mon, 16 Nov 2020 12:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C09222EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9C58B85EB4;
	Mon, 16 Nov 2020 12:50:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qx9lhq3ebOVV; Mon, 16 Nov 2020 12:50:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 081D885EA4;
	Mon, 16 Nov 2020 12:50:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1F34C0800;
	Mon, 16 Nov 2020 12:50:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B312C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 12:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 896B4855FF
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 12:50:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 79N02bbPxl8i for <iommu@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 12:50:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DF343867FD
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 12:50:49 +0000 (UTC)
IronPort-SDR: 7PQzPy3CsHP8pN5zn8O6FQw3bH+J3L0vVQ/XicaPuqRV9fnX8c21tGilzdhqQHjZIzIu/ToLNw
 JLrRm5RDz0CQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="232356594"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; d="scan'208";a="232356594"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2020 04:50:41 -0800
IronPort-SDR: pjbCtcfsqxuDEzk4ztyIKCUi9dy3iW0ILklBigT8tTdytW+E8PG9A1yk/KJqKaM1OE+uXZe2oq
 gFgJn9gqbffg==
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; d="scan'208";a="358453174"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.59])
 ([10.254.215.59])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2020 04:50:38 -0800
Subject: Re: iommu/vt-d: Cure VF irqdomain hickup
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20200826111628.794979401@linutronix.de>
 <20201112125531.GA873287@nvidia.com> <87mtzmmzk6.fsf@nanos.tec.linutronix.de>
 <87k0uqmwn4.fsf@nanos.tec.linutronix.de>
 <87d00imlop.fsf@nanos.tec.linutronix.de>
 <CAMuHMdXA7wfJovmfSH2nbAhN0cPyCiFHodTvg4a8Hm9rx5Dj-w@mail.gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <686f0416-e408-7e6b-0fc1-8cddcd479bb6@linux.intel.com>
Date: Mon, 16 Nov 2020 20:50:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXA7wfJovmfSH2nbAhN0cPyCiFHodTvg4a8Hm9rx5Dj-w@mail.gmail.com>
Content-Language: en-US
Cc: Itay Aveksis <itayav@nvidia.com>, Ziyad Atiyyeh <ziyadat@nvidia.com>,
 linux-pci <linux-pci@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>,
 the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Marc Zyngier <maz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>
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

On 2020/11/16 17:47, Geert Uytterhoeven wrote:
> Hi Thomas,
> 
> On Thu, Nov 12, 2020 at 8:16 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> The recent changes to store the MSI irqdomain pointer in struct device
>> missed that Intel DMAR does not register virtual function devices.  Due to
>> that a VF device gets the plain PCI-MSI domain assigned and then issues
>> compat MSI messages which get caught by the interrupt remapping unit.
>>
>> Cure that by inheriting the irq domain from the physical function
>> device.
>>
>> That's a temporary workaround. The correct fix is to inherit the irq domain
>> from the bus, but that's a larger effort which needs quite some other
>> changes to the way how x86 manages PCI and MSI domains.
>>
>> Fixes: 85a8dfc57a0b ("iommm/vt-d: Store irq domain in struct device")
>> Reported-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>   drivers/iommu/intel/dmar.c |   19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -333,6 +333,11 @@ static void  dmar_pci_bus_del_dev(struct
>>          dmar_iommu_notify_scope_dev(info);
>>   }
>>
>> +static inline void vf_inherit_msi_domain(struct pci_dev *pdev)
>> +{
>> +       dev_set_msi_domain(&pdev->dev, dev_get_msi_domain(&pdev->physfn->dev));
> 
> If CONFIG_PCI_ATS is not set:
> 
>      error: 'struct pci_dev' has no member named 'physfn'
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/14400927/

Maybe pci_physfn() helper should be used here.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
