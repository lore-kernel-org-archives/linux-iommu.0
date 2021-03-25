Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FD5C433C1
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 19:08:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718DA61A2B
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 19:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718DA61A2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2686D40F54;
	Thu, 25 Mar 2021 19:08:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N3CuhE3zcNHk; Thu, 25 Mar 2021 19:07:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id E51AE40F29;
	Thu, 25 Mar 2021 19:07:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE767C000D;
	Thu, 25 Mar 2021 19:07:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDEDCC000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 19:07:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C431584ACA
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 19:07:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="4XFXwdCP";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="lyXPJZS4"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iqiKCdV0l_xO for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 19:07:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3121E84ACC
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 19:07:57 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1616699275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vtkjjMXc3X2xxjn4WLNIi05eZwUjk0KJeKHvjJH0OKM=;
 b=4XFXwdCPgfny2nQClwNVfiwdraGbkPGPppRfktfYETZ9Bg4J/lyP/M+pJ4dx6+IqxJWKrZ
 QYajJSfwifCa9bZ96AB+ThBHFBAcRpQDhgpk8L3AGcpsKf+BgTI76gGQDkCDcvQReh7/uk
 mm5XUU4so0eShIWemNpMIFMJ5tLKm/pNuuQJPTqcm589FyW2CBUj9R689rOjV3Lx1r35EB
 UF4sIlac1S7bWf+Z1GDn6XMhIxSkGqCkdYQYfCqncAs3jimI9fkI+G39o6+BQxONHCw+j2
 1hPmfYjTNWh0TOEfcgvM9/94Tm1F7u0WFfgDpK0wSbiz6v33q5VkM/FBNKC+sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1616699275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vtkjjMXc3X2xxjn4WLNIi05eZwUjk0KJeKHvjJH0OKM=;
 b=lyXPJZS4dqguIAr1rEeaFfjrDt/5jKGhDz2dyy3YzObmcB0hkXXkGkWcyfB03MSQRX/SpJ
 piMoKy2++H9bL7DQ==
To: Marc Zyngier <maz@kernel.org>, Megha Dey <megha.dey@intel.com>
Subject: Re: [Patch V2 12/13] irqchip: Add IMS (Interrupt Message Store) driver
In-Reply-To: <87zgyrqgbm.wl-maz@kernel.org>
References: <1614370277-23235-1-git-send-email-megha.dey@intel.com>
 <1614370277-23235-13-git-send-email-megha.dey@intel.com>
 <87zgyrqgbm.wl-maz@kernel.org>
Date: Thu, 25 Mar 2021 20:07:54 +0100
Message-ID: <87eeg3vyph.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: alex.williamson@redhat.com, kevin.tian@intel.com, tony.luck@intel.com,
 dave.jiang@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 ravi.v.shankar@intel.com, linux-pci@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jgg@mellanox.com, bhelgaas@google.com, dan.j.williams@intel.com,
 dwmw@amazon.co.uk
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

On Thu, Mar 25 2021 at 17:43, Marc Zyngier wrote:
> On Fri, 26 Feb 2021 20:11:16 +0000,
> Megha Dey <megha.dey@intel.com> wrote:
>> +
>> +#include <linux/irqchip/irq-ims-msi.h>
>> +
>> +#ifdef CONFIG_IMS_MSI_ARRAY
>
> Given that this covers the whole driver, what is this #defined used
> for? You might as well make the driver depend on this config option.

That's a leftover from the initial version I wrote which had also
support for IMS_MSI_QUEUE to store the message in queue memory, but we
have no use case yet for it.

But yes, as things stand now it does not make any sense and IIRC at the
end they do not share anything in the C file except for some includes at
the very end.

Thanks,

        tglx


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
