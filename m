Return-Path: <SRS0=smho=GI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C6DC433DB
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 02:49:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0965C22581
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 02:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0965C22581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6971E87011;
	Tue,  5 Jan 2021 02:49:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2GJhJ-3kGk4a; Tue,  5 Jan 2021 02:48:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CCDC586FF0;
	Tue,  5 Jan 2021 02:48:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAC37C0893;
	Tue,  5 Jan 2021 02:48:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CD33C013A
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 02:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 345F7845CF
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 02:48:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yg6i6bDV-jMN for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 02:48:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
 by whitealder.osuosl.org (Postfix) with ESMTP id 67E1184320
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 02:48:55 +0000 (UTC)
Received: by ajax-webmail-mail-app2 (Coremail) ; Tue, 5 Jan 2021 10:48:32
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.25.254]
Date: Tue, 5 Jan 2021 10:48:32 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: dinghao.liu@zju.edu.cn
To: "Lu Baolu" <baolu.lu@linux.intel.com>
Subject: Re: Re: [PATCH] iommu/intel: Fix memleak in intel_irq_remapping_alloc
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20200917(3e19599d)
 Copyright (c) 2002-2021 www.mailtech.cn zju.edu.cn
In-Reply-To: <dda6e03a-147a-a482-4f31-f3dcb8aa47bd@linux.intel.com>
References: <20210102095029.29053-1-dinghao.liu@zju.edu.cn>
 <18add30d-a830-c531-6fd2-58a1898b157f@linux.intel.com>
 <50870a42.15f1a.176c66eaf92.Coremail.dinghao.liu@zju.edu.cn>
 <6e1ce9ac-ac17-2b16-84d3-a18c011768f2@linux.intel.com>
 <3b0b2129.17762.176c6e9114d.Coremail.dinghao.liu@zju.edu.cn>
 <dda6e03a-147a-a482-4f31-f3dcb8aa47bd@linux.intel.com>
MIME-Version: 1.0
Message-ID: <577ae864.1df8f.176d0722e45.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgDnrvCA0_Nflw0IAA--.1157W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgMQBlZdtR1gpwAAsz
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
Cc: Will Deacon <will@kernel.org>, kjlu@umn.edu, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw2@infradead.org>, Jiang Liu <jiang.liu@linux.intel.com>
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

> On 1/3/21 2:22 PM, dinghao.liu@zju.edu.cn wrote:
> >> On 2021/1/3 12:08, dinghao.liu@zju.edu.cn wrote:
> >>>> Hi,
> >>>>
> >>>> On 2021/1/2 17:50, Dinghao Liu wrote:
> >>>>> When irq_domain_get_irq_data() or irqd_cfg() fails
> >>>>> meanwhile i == 0, data allocated by kzalloc() has not
> >>>>> been freed before returning, which leads to memleak.
> >>>>>
> >>>>> Fixes: b106ee63abccb ("irq_remapping/vt-d: Enhance Intel IR driver to support hierarchical irqdomains")
> >>>>> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> >>>>> ---
> >>>>>     drivers/iommu/intel/irq_remapping.c | 2 ++
> >>>>>     1 file changed, 2 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> >>>>> index aeffda92b10b..cdaeed36750f 100644
> >>>>> --- a/drivers/iommu/intel/irq_remapping.c
> >>>>> +++ b/drivers/iommu/intel/irq_remapping.c
> >>>>> @@ -1354,6 +1354,8 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
> >>>>>     		irq_cfg = irqd_cfg(irq_data);
> >>>>>     		if (!irq_data || !irq_cfg) {
> >>>>>     			ret = -EINVAL;
> >>>>> +			kfree(data);
> >>>>> +			data = NULL;
> >>>>
> >>>> Do you need to check (i == 0) here? @data will not be used anymore as it
> >>>> goes to out branch, why setting it to NULL here?
> >>>>
> >>>
> >>> data will be passed to ire_data->chip_data when i == 0 and
> >>> intel_free_irq_resources() will free it on failure. Thus I
> >>
> >> Isn't it going to "goto out_free_data"? If "i == 0", the allocated @data
> >> won't be freed by intel_free_irq_resources(), hence memory leaking. Does
> >> this patch aim to fix this?
> >>
> >> Best regards,
> >> baolu
> >>
> > 
> > Correct, this is what I mean. When i > 0, data has been passed to
> > irq_data->chip_data, which will be freed in intel_free_irq_resources()
> > on failure. So there is no memleak in this case. The memleak only occurs
> > on failure when i == 0 (data has not been passed to irq_data->chip_data).
> 
> So how about
> 
> diff --git a/drivers/iommu/intel/irq_remapping.c 
> b/drivers/iommu/intel/irq_remapping.c
> index aeffda92b10b..685200a5cff0 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -1353,6 +1353,8 @@ static int intel_irq_remapping_alloc(struct 
> irq_domain *domain,
>                  irq_data = irq_domain_get_irq_data(domain, virq + i);
>                  irq_cfg = irqd_cfg(irq_data);
>                  if (!irq_data || !irq_cfg) {
> +                       if (!i)
> +                               kfree(data);
>                          ret = -EINVAL;
>                          goto out_free_data;
>                  }
> 
> > I set data to NULL after kfree() in this patch to prevent double-free
> > when the failure occurs at i > 0.
> 
> if i>0, @data has been passed and will be freed by
> intel_free_irq_resources() on the failure path. No need to free or
> clear, right?

Right, this is clearer. Thank you for your advice and I will resend a
new patch soon.

Regards,
Dinghao

> 
> Best regards,
> baolu
> 
> > 
> > Regards,
> > Dinghao
> > 
> >>> set it to NULL to prevent double-free. However, if we add
> >>> a check (i == 0) here, we will not need to set it to NULL.
> >>> If this is better, I will resend a new patch soon.
> >>>
> >>> Regards,
> >>> Dinghao
> >>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
