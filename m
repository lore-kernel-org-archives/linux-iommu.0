Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057D7C433F5
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 22:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9809D41773;
	Wed,  6 Apr 2022 22:07:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jVHv5z_AjUN2; Wed,  6 Apr 2022 22:07:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 306E841600;
	Wed,  6 Apr 2022 22:07:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01158C002C;
	Wed,  6 Apr 2022 22:07:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3DA2C0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 22:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BADAA60DCB
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 22:07:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="rTC+MTir";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="l/De9Ow9"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R2kuB-NkQCBa for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 22:07:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 28CA660AEC
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 22:07:22 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1649282839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=52XeoShnHmdAQ+XobvAW3OjjBZFsGfa67mgB/KHswHw=;
 b=rTC+MTir7K3GQwjDaTnq/Dtgs9ZArTDUo8SEVZ8/M7l0Ij82aZQsxfxt4MSQvDZPqhzjbe
 KmAvC/1zLhXu9TrKuiWPVKsLn5MkyxZifWmaI51hUsVzMe0GDKkIWnzWUHhVTGRrnRGhjq
 CPvfqO/kjVbIhCUE1MYr/B7f0pAb0dfqz4tJo1i3kltxcKiulF8Amz9MStp5aiBF/OTg59
 bXSaUVq2t1wWWpZbtctl9uOmg1cKLed7IhXjmITB4bhTVpfo6majJv+iwx1LHnCAkSm1k1
 9jlnuq5Tg7dEz82ISrh4peEjS5Xc3bEjIsKWPZv3e/zZ+bMPHUImxf/kov3uWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1649282839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=52XeoShnHmdAQ+XobvAW3OjjBZFsGfa67mgB/KHswHw=;
 b=l/De9Ow9qS0nayBe3dC2SF/mqKKOsu2s5yJnnCR+HzzwO6gGPHvUKa7HHa8ezn5dzKZ2ry
 un2P6HyZnfHvUxAg==
To: Reto Buerki <reet@codelabs.ch>, dwmw2@infradead.org
Subject: Re: [PATCH v3 12/35] x86/msi: Provide msi message shadow structs
In-Reply-To: <20220406083624.38739-1-reet@codelabs.ch>
References: <20201024213535.443185-13-dwmw2@infradead.org>
 <20220406083624.38739-1-reet@codelabs.ch>
Date: Thu, 07 Apr 2022 00:07:18 +0200
Message-ID: <87sfqpzx0p.ffs@tglx>
MIME-Version: 1.0
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
 decui@microsoft.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, maz@misterjones.org, pbonzini@redhat.com
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

On Wed, Apr 06 2022 at 10:36, Reto Buerki wrote:
> While working on some out-of-tree patches, we noticed that assignment to
> dmar_subhandle of struct x86_msi_data lead to a QEMU warning about
> reserved bits in MSI data being set:
>
> qemu-system-x86_64: vtd_interrupt_remap_msi: invalid IR MSI (sid=256, address=0xfee003d8, data=0x10000)
>
> This message originates from hw/i386/intel_iommu.c in QEMU:
>
> #define VTD_IR_MSI_DATA_RESERVED (0xffff0000)
> if (origin->data & VTD_IR_MSI_DATA_RESERVED) { ... }
>
> Looking at struct x86_msi_data, it appears that it is actually 48-bits in size
> since the bitfield containing the vector, delivery_mode etc is 2 bytes wide
> followed by dmar_subhandle which is 32 bits. Thus assignment to dmar_subhandle
> leads to bits > 16 being set.
>
> If I am not mistaken, the MSI data field should be 32-bits wide for all
> platforms (struct msi_msg, include/linux/msi.h). Is this analysis
> correct or did I miss something wrt. handling of dmar_subhandle?

It's correct and I'm completely surprised that this went unnoticed
for more than a year. Where is that brown paperbag...

Thanks,

        tglx

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
