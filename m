Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C784EC433E3
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 21:56:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 978E12073E
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 21:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMhKMpQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978E12073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6F176881E1;
	Tue, 30 Jun 2020 21:56:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G8BMhX1jikH3; Tue, 30 Jun 2020 21:56:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9825C881E0;
	Tue, 30 Jun 2020 21:56:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DC3BC0865;
	Tue, 30 Jun 2020 21:56:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52DCFC016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:56:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4B6D088553
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:56:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gIEnUoEONNqW for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 21:56:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C3DF1884F4
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:56:56 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 81E7D20780
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593554216;
 bh=Adv2/880uaGmJ4dh7B8Ggp1jOzWVuFLpdGHKuacuBSw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=GMhKMpQXblH1a/O0fh0GOyzv0WdIbAgigYUIXgIAMqAQBQYyuGUUiR7a4bXIbrKXP
 jSMkLwxseVcB08wHZ8iOBf9Ur1bnzq1KAVWRVjtAtDx2Jydyl5PDsl3h2NRgufA90O
 GfgsXG1AM3yGjmVEv5NbLUZnyer9jMJLB0Hf0fNU=
Received: by mail-ot1-f43.google.com with SMTP id 76so5334593otu.9
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 14:56:56 -0700 (PDT)
X-Gm-Message-State: AOAM530DpyOa5EwQaAjDB5I+CQKaEXOoWoqqE5vn052zbNEkPwKJ6oBW
 barm433gksv2aTdEqbk8sqPOM5LFGjPrGqzQ3w==
X-Google-Smtp-Source: ABdhPJyKDbfQDtx3HWuOj8pgh2vtwwUduqe+y/gv6f3hKh8dipeWe6XCyppTBRvPXxLq1UHPOfwznTH5xUq/MCLPMuw=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr18672129otb.107.1593554215926; 
 Tue, 30 Jun 2020 14:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-11-lorenzo.pieralisi@arm.com>
In-Reply-To: <20200619082013.13661-11-lorenzo.pieralisi@arm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 30 Jun 2020 15:56:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLPScU4be1tatPFqL4BpBdm5KgwzT79Hyjm_atAHPgm3Q@mail.gmail.com>
Message-ID: <CAL_JsqLPScU4be1tatPFqL4BpBdm5KgwzT79Hyjm_atAHPgm3Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] of/irq: Make of_msi_map_rid() PCI bus agnostic
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Marc Zyngier <maz@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Makarand Pawagi <makarand.pawagi@nxp.com>, linux-acpi@vger.kernel.org,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Fri, Jun 19, 2020 at 2:20 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> There is nothing PCI bus specific in the of_msi_map_rid()
> implementation other than the requester ID tag for the input
> ID space. Rename requester ID to a more generic ID so that
> the translation code can be used by all busses that require
> input/output ID translations.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/of/irq.c       | 28 ++++++++++++++--------------
>  drivers/pci/msi.c      |  2 +-
>  include/linux/of_irq.h |  8 ++++----
>  3 files changed, 19 insertions(+), 19 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
