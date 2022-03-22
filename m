Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20269C433F5
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 20:10:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B901260DF6;
	Tue, 22 Mar 2022 20:10:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MtkpwVyVGdWl; Tue, 22 Mar 2022 20:10:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8D5E360DE5;
	Tue, 22 Mar 2022 20:10:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60EB6C0012;
	Tue, 22 Mar 2022 20:10:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3350FC000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 20:10:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1552841864
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 20:10:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wUCpps1wf0VF for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 20:10:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 842E541863
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 20:10:32 +0000 (UTC)
Received: by mail-pf1-x42a.google.com with SMTP id u17so19069067pfk.11
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yxRoOuDAQ32T7epvmjmCMUDa2ze+iRE6nt0uAlg4Cn4=;
 b=lmELaTz7WP/HCCZzx81ngJJsBsHi+8NNkFAdHtPQ8AA9Up+PwmmEc27JoRzPCC3bGF
 ypk4x3onyQ3gaTiIYEwIDn5jRK/vCJg3N5JhJf6RAjv4NRF5GENUps0Ntr+1PcidHWaB
 2a6jKQMajECNEYH6nQUEqAFRtx2s1//6L8S/oUjHhiCItaEBkG9fYZMeHRARLVRof+fU
 VeqU2FeJGUYPCNnYajwC2MZNe12kKcEphyLwe+XM0C13pKnxJoNN8QEk0KXf4o5afx/X
 Kq+6r3tYjHYxjwRpkEyKGU0QDVqvlg29oIG0TAs3YSO/LyFvemSnXsoHZLDq+hg0KcvL
 9tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yxRoOuDAQ32T7epvmjmCMUDa2ze+iRE6nt0uAlg4Cn4=;
 b=10TeujkCxJ66dm4M+X+7hAzRsCxRbvzB+H9BdIsimeg6xhNE49HeBna07diEmFMyMJ
 D0NNxT9hDEGJhK3wnDb14yNpbmH63rTGgFJFQgwpAC5Vj/PH5Dh0W/5Kx5KyiXLctM/+
 rrb0wUL3j6G3GAkJOX1vaE25DvjVxuBMHo2v3mg+ybYGiw3OQLLhJRuj/VIy78nFR3SM
 Av81wuvFG4qfuIRQOwasL/0Llh1A8uqCHaPiVfZ3AGa5KRe5jNZPAlIFtILAGC4OPYgM
 /xHVbiSJpbrIng+vOyIgsjuj1Oxsk0Iae2/opIxZmZBbQ0q068byTpJv0+gfNFoCn0zV
 9M2A==
X-Gm-Message-State: AOAM5306aSq2xBuanQxiLpYky79VLCuT4Crx2/aAIqtN2a5m+SjZ3hAy
 6KEuws+pBKqC4la3GBltVDJZwuLUlNKUGIBJZtQUIA==
X-Google-Smtp-Source: ABdhPJyiLa4J6HZobaRPPLdsxYqNc7OtUXhU/czFKSJbwUv9zO/SiqHx4I4DyNmue6FaGBfUb/DumAGOIvZe5zD0WZc=
X-Received: by 2002:a63:416:0:b0:386:66e:33d9 with SMTP id
 22-20020a630416000000b00386066e33d9mr833745pge.146.1647979831669; 
 Tue, 22 Mar 2022 13:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220320062907.3272903-1-rajatja@google.com>
 <YjmQq1DvWnJwUh6R@infradead.org>
 <CAJZ5v0h9TnUELahzkO59Vqoio1QRHfixk58Yxgffa72rmEBgOA@mail.gmail.com>
In-Reply-To: <CAJZ5v0h9TnUELahzkO59Vqoio1QRHfixk58Yxgffa72rmEBgOA@mail.gmail.com>
Date: Tue, 22 Mar 2022 13:09:55 -0700
Message-ID: <CACK8Z6Fz-TPW1fMpQB09fw11neq8eyn89XB8vy0ioB5zB0Hb9Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PCI: Rename "pci_dev->untrusted" to
 "pci_dev->poses_dma_risk"
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Rajat Jain <rajatxjain@gmail.com>, Will Deacon <will@kernel.org>,
 Pavel Machek <pavel@denx.de>, Linux PCI <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Bjorn Helgaas <helgaas@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Oliver O'Halloran <oohall@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jesse Barnes <jsbarnes@google.com>, Dmitry Torokhov <dtor@google.com>,
 Len Brown <lenb@kernel.org>
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
From: Rajat Jain via iommu <iommu@lists.linux-foundation.org>
Reply-To: Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Mar 22, 2022 at 4:12 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Mar 22, 2022 at 10:02 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Sat, Mar 19, 2022 at 11:29:05PM -0700, Rajat Jain wrote:
> > > Rename the field to make it more clear, that the device can execute DMA
> > > attacks on the system, and thus the system may need protection from
> > > such attacks from this device.
> > >
> > > No functional change intended.
> > >
> > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > ---
> > > v4: Initial version, created based on comments on other patch
> >
> > What a horrible name.  Why not untrusted_dma which captures the
> > intent much better?
>
> FWIW, I like this one much better too.

Sure, no problems. I can change the name to "untrusted_dma".

Mika, can I carry forward your "Reviewed-by" tag with this name change too?

Thanks & Best Regards,

Rajat
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
