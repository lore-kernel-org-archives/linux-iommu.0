Return-Path: <SRS0=6LHv=75=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83292C433DF
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 19:56:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F052B207C4
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 19:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QOMab6ZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F052B207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8F8E625067;
	Tue, 16 Jun 2020 19:56:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EWGCfOhzoUAy; Tue, 16 Jun 2020 19:56:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4832A2045C;
	Tue, 16 Jun 2020 19:56:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2864EC0888;
	Tue, 16 Jun 2020 19:56:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC798C016E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 19:56:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9AC6F87926
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 19:56:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vFb70S5wtorO for <iommu@lists.linux-foundation.org>;
 Tue, 16 Jun 2020 19:56:27 +0000 (UTC)
X-Greylist: delayed 00:28:10 by SQLgrey-1.7.6
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B984B84553
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 19:56:26 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id 9so25117899ljc.8
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 12:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G+QuAOUfD+yaHMOx7JS6V2Ec/laXvrlFy0R9vzQGqF4=;
 b=QOMab6ZBai8eX39llL4QAiuIVWOQ0kfvL9ywteJNjgzhCzjyOqdlLEs34RuWRfNLLY
 UBmJ+sjmxHSY9KClbzPYRcmHfIbDr3RgcQIUrbh/HgB4x65p5TjwXtES2J8FIy5PzqLb
 qNhgVYP39gDxMPl9bQhhUq4S3zMv9UfF/pmETt8VJF4G41Qcz/1zK2PnlCpJF0fz/S6h
 PxHy+BSAWFuylkqNZeMw7xFvJ8qR/7v1dKWfEPia1fKfpNNvfy691K7fCJ3W9iR5AH/V
 gFeKsPsrdm5Ge3TmLS1y0qxW2m4XjgJOTWFoy9c831CRjVEIM34ATLROHfUGg4Z8jDHa
 f9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G+QuAOUfD+yaHMOx7JS6V2Ec/laXvrlFy0R9vzQGqF4=;
 b=j0Ffn7TbPeQXWr0kBHX+PbQrPssM3MpGOydXYsAP/kTuugI0yQSEvcDjTcuCTv4J2u
 DEBycjerXDkbDN28KvElRPh/S8R2I/j8fuMcxPDSarKixkZ9sLNVX9Kv84L/idSer/8a
 lI4OIOK6bd1cL/O0gi3RdEtoF99kZOvW4M1qq+LNX8c/XashGOMUvppUcVeosquhZOse
 q1ixBdm2iy1GFLhDX7dovGWnXE7cSFWnaaHFwitWLwZ4DAAOG/rZWFAdL2TigrPLTvF6
 /uHnTY9mbeZfrmjnYE3MgbjiZqgRWfpio/BjLtx2yqBRIqm1bKh9ibI9P4SPV6LkLSZk
 9Y2Q==
X-Gm-Message-State: AOAM530XB407/puiHX5Ysh4qq4GbtnDUWka7zTUWisPbrHBX7ASeBc8L
 4+spc7CmNqg4cXQtdJ8Ft3tJQIQKEgGkfr/4glaLgsM1
X-Google-Smtp-Source: ABdhPJx83rVoJ1GBvQYrxBN8PD8VfhKiX7Lt1xY67EOoosPeSf9MmyLDKhdSIeUD5mQ+yLl+8Gvp2zP5Y6zZkNEG/uk=
X-Received: by 2002:a2e:908f:: with SMTP id l15mr1993656ljg.307.1592335693925; 
 Tue, 16 Jun 2020 12:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200616011742.138975-1-rajatja@google.com>
 <20200616011742.138975-4-rajatja@google.com>
 <20200616073249.GB30385@infradead.org>
In-Reply-To: <20200616073249.GB30385@infradead.org>
Date: Tue, 16 Jun 2020 12:27:35 -0700
Message-ID: <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
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

On Tue, Jun 16, 2020 at 12:32 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jun 15, 2020 at 06:17:42PM -0700, Rajat Jain via iommu wrote:
> > This is needed to allow the userspace to determine when an untrusted
> > device has been added, and thus allowing it to bind the driver manually
> > to it, if it so wishes. This is being done as part of the approach
> > discussed at https://lkml.org/lkml/2020/6/9/1331
>
> Please move the attribute to struct device instead of further
> entrenching it in PCIe.

Need clarification. The flag "untrusted" is currently a part of
pci_dev struct, and is populated within the PCI subsystem.

1) Is your suggestion to move this flag as well as the attribute to
device core (in "struct device")? This would allow other buses to
populate/use this flag if they want. By default it'll be set to 0 for
all devices (PCI subsystem will populate it based on platform info,
like it does today).

OR

2) Are you suggesting to keep the "untrusted" flag within PCI, but
attach the sysfs attribute to the base device? (&pci_dev->dev)?

Thanks,

Rajat

>  I'm starting to grow tired of saying this
> every other week while you guys are all moving into the entirely
> wrong direction.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
