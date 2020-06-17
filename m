Return-Path: <SRS0=yzgR=76=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF7DC433E1
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 19:53:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A619621548
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 19:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="u3Wa8m8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A619621548
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6B8AD878AF;
	Wed, 17 Jun 2020 19:53:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7oNyqFM3qqlK; Wed, 17 Jun 2020 19:53:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 08B01878B0;
	Wed, 17 Jun 2020 19:53:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D62B7C07FF;
	Wed, 17 Jun 2020 19:53:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5B2FC016E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 19:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A8316880B4
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 19:53:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PlF9RJoiF8i2 for <iommu@lists.linux-foundation.org>;
 Wed, 17 Jun 2020 19:53:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9DF368808E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 19:53:44 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id g139so1258418lfd.10
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 12:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=652Df2r0/DgKireW06s96KgNYOn5wGhQAsXaGuNmXIU=;
 b=u3Wa8m8AA+KUbrW2ZJpwKkh5OV+uw6/tbYieNTCpV+g/fKZMa/424dnXDq9k1pZPsC
 R3FzepNEt9eHmKEZLsQB6039RHnI2oLz4CeV+LIiyjsGAuVvKHjPqJBF3Os+Yu3DAD8h
 eayE3aq6KDW1uRolK2PO0BBU19aNm/+f0ZClqWN+6CBGWa1oZWt3Q1ccsHsxPC9fP8Fo
 fRbkAnztmRQIhCW37CvRuaE6qD0vU9+o9o/RIpz49UZIQk8W128R+KBu/KuSbu6ST/8e
 pUQ0WdEBLZ+YsiIPD892IivctXxTZsc2P7241Yy2nkAjGpLCkDQM5X2GbJvBqr2rZVAY
 UQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=652Df2r0/DgKireW06s96KgNYOn5wGhQAsXaGuNmXIU=;
 b=UJUyYD57wzWdj6hAagwU7+wTCOXpk2+KEw/oQuB5Za6vRmqdFDG5v9+ULcJdFdPKsl
 7lqKZY2/EM8VpV3JSGKEc2RB0ZhEAYQifmDADbM5Ka8GRFbh3GwsIm65U9+G7vJg2HPt
 iKJdMabBiDH5EYFBtEUUQR0wE5JBPTc1B+LJrlJRcOGWXJuxYxzuEtIAW0R3TKMfnpS0
 aKBiMbTb2SeGb5ZBtlyCaQv3YjGX+rDQGL8zBWqNBW/QNKabIubUQrzeuBKPaFVzsBIN
 ERuOzOSF8e+5fp9uwjGXGYhGZmpAH4LRrZHRfWInXI3YrRNjV8XR+o+mYip/c0P4eSJY
 MFIw==
X-Gm-Message-State: AOAM5301qrZlKVgiSdux9KYh35UpXcCQbN59WuYRTDKsCTIf70LZr/mY
 NJR/PslUOUixAq2BmItbfEBGSNnYjw9C8V8f168cKg==
X-Google-Smtp-Source: ABdhPJyNvJoaAN28/Zg/o9OICE/84/JjfeagXh8bzJTkYAwiivCGPGUzVM1fri9Qg8kksG9nggUrDgCqrfFwoV4dkhw=
X-Received: by 2002:ac2:41d4:: with SMTP id d20mr299095lfi.204.1592423622439; 
 Wed, 17 Jun 2020 12:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200616011742.138975-1-rajatja@google.com>
 <20200616011742.138975-4-rajatja@google.com>
 <20200616073249.GB30385@infradead.org>
 <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
 <20200617073100.GA14424@infradead.org>
In-Reply-To: <20200617073100.GA14424@infradead.org>
Date: Wed, 17 Jun 2020 12:53:03 -0700
Message-ID: <CACK8Z6FecYkAYQh4sm4RbAQ1iwb9gexqgY9ExD9BH2p-5Usj=g@mail.gmail.com>
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
To: Christoph Hellwig <hch@infradead.org>
Cc: Todd Broch <tbroch@google.com>, linux-pci <linux-pci@vger.kernel.org>,
 "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
 Diego Rivas <diegorivas@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, Raj Ashok <ashok.raj@intel.com>,
 linux-acpi@vger.kernel.org, Christian Kellner <christian@kellner.me>,
 Mattias Nissler <mnissler@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Len Brown <lenb@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
 Prashant Malani <pmalani@google.com>, Aaron Durbin <adurbin@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bernie Keany <bernie.keany@intel.com>, Duncan Laurie <dlaurie@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Oliver O'Halloran <oohall@gmail.com>,
 Benson Leung <bleung@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Alex Levin <levinale@google.com>
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

Hi Greg, Christoph,

On Wed, Jun 17, 2020 at 12:31 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jun 16, 2020 at 12:27:35PM -0700, Rajat Jain wrote:
> > Need clarification. The flag "untrusted" is currently a part of
> > pci_dev struct, and is populated within the PCI subsystem.
>
> Yes, and that is the problem.
>
> >
> > 1) Is your suggestion to move this flag as well as the attribute to
> > device core (in "struct device")? This would allow other buses to
> > populate/use this flag if they want. By default it'll be set to 0 for
> > all devices (PCI subsystem will populate it based on platform info,
> > like it does today).
> >
> > OR
> >
> > 2) Are you suggesting to keep the "untrusted" flag within PCI, but
> > attach the sysfs attribute to the base device? (&pci_dev->dev)?
>
> (1).  As for IOMMUs and userspace policy it really should not matter
> what bus a device is on if it is external and not trustworthy.

Sure. I can move the flag to the "struct device" (and likely call
it "external" instead of "untrusted" so as to make it suitable for
more use cases later).  The buses can fill this up if they know which
devices are external and which ones are not (otherwise it will be 0 by
default). The PCI can fill this up like it does today, from platform
info (ACPI / Device tree). Greg, how does this sound?

Thanks,

Rajat
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
