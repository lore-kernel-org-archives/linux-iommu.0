Return-Path: <SRS0=dfl9=EW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810E6C4742C
	for <iommu@archiver.kernel.org>; Mon, 16 Nov 2020 12:50:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE587222B9
	for <iommu@archiver.kernel.org>; Mon, 16 Nov 2020 12:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aEs2krwq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2/MsSG7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE587222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6741087119;
	Mon, 16 Nov 2020 12:50:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id moW52qCGVpTO; Mon, 16 Nov 2020 12:50:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C628C8710B;
	Mon, 16 Nov 2020 12:50:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DA77C0800;
	Mon, 16 Nov 2020 12:50:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19782C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 12:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0B79B2047B
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 12:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OTYqNSzoz4Ji for <iommu@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 12:50:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by silver.osuosl.org (Postfix) with ESMTPS id D7C3320014
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 12:50:36 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1605531033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0MZk8f05zzIV7Ttfy5YcrIRRf3Ks113ilZvj4y+g/U4=;
 b=aEs2krwqPJ5mncHAdF1YpE/lMEDDjlcz7iqKbOyZpZsY/f5uD7btQ7ZtbVF1m0VUrxBBYY
 /NmlpfD+lDAWr+jFZ1LI7D+baDhdxVQYvEThXbsaw0u/P505555eqUTPPkOmmgPEJC5c41
 hLHY497BOs49EMjQsmeEa/TCmd/8IgbWp0mAIFg1I0rwBLiidqd2yawOVHTIIGblKki72P
 uU7yHmaWFxb0GAzley08IBzxvR/UQqBaH0/M1weOTpxoKKMOnxYc6MfMQ07DTDY7/IjEcW
 ajRYjH/sV8IyM6VR94qsA5AiV0NGIQc6GriZQmwK8Dm/89rxobYk6y6lztU2Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1605531033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0MZk8f05zzIV7Ttfy5YcrIRRf3Ks113ilZvj4y+g/U4=;
 b=2/MsSG7CjQLYFTCWmCzdOxzaBv33PtlagCdIBlyEhwQgyKbUIZyEh4xZmT0oEgioFkXStT
 5cqgyGxf6iGQBnDQ==
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: iommu/vt-d: Cure VF irqdomain hickup
In-Reply-To: <CAMuHMdXA7wfJovmfSH2nbAhN0cPyCiFHodTvg4a8Hm9rx5Dj-w@mail.gmail.com>
References: <20200826111628.794979401@linutronix.de>
 <20201112125531.GA873287@nvidia.com> <87mtzmmzk6.fsf@nanos.tec.linutronix.de>
 <87k0uqmwn4.fsf@nanos.tec.linutronix.de>
 <87d00imlop.fsf@nanos.tec.linutronix.de>
 <CAMuHMdXA7wfJovmfSH2nbAhN0cPyCiFHodTvg4a8Hm9rx5Dj-w@mail.gmail.com>
Date: Mon, 16 Nov 2020 13:50:32 +0100
Message-ID: <87lff1zcrr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Geert,

On Mon, Nov 16 2020 at 10:47, Geert Uytterhoeven wrote:
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
>>  drivers/iommu/intel/dmar.c |   19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -333,6 +333,11 @@ static void  dmar_pci_bus_del_dev(struct
>>         dmar_iommu_notify_scope_dev(info);
>>  }
>>
>> +static inline void vf_inherit_msi_domain(struct pci_dev *pdev)
>> +{
>> +       dev_set_msi_domain(&pdev->dev, dev_get_msi_domain(&pdev->physfn->dev));
>
> If CONFIG_PCI_ATS is not set:
>
>     error: 'struct pci_dev' has no member named 'physfn'
>

thanks for pointing that out. Yet moar ifdeffery, oh well...

Thanks,

        tglx

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
