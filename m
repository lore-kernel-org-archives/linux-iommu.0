Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFDCC43461
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 13:36:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF6420732
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 13:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF6420732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8271E869FD;
	Tue,  8 Sep 2020 13:36:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BOvjOn3RCrX8; Tue,  8 Sep 2020 13:36:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E239486964;
	Tue,  8 Sep 2020 13:36:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC92DC0859;
	Tue,  8 Sep 2020 13:36:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAB94C0051
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 13:36:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C662386A10
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 13:36:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B9xoJI-7Lksv for <iommu@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 13:36:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5B8EC86888
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 13:36:32 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id l9so17212612wme.3
 for <iommu@lists.linux-foundation.org>; Tue, 08 Sep 2020 06:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=g+fF122O7R17ki64qXX6rnyePilfcGBCv1/ck2Kz2cE=;
 b=DSLYtH2VBQZ2egLZJk2maAM0l+tB6K3vLMi0gD25EK0oNFvUHT0HiFEqAjXjMwudmi
 5WOi9RbqLasnGNOmr7+nZqjULW0fTv05O5ZyU7AfH+7mGUdcFI9j9vJJV9S397r4P2sj
 LxW5ZCOaGUuGGNrfnDPdl/hw2o50o44KGOvi40EhHegZddnuYunw7bwO3ChxsQYteGqd
 dTvSJlMXWZ/NttMWAx5YYVvX+tjlpY+ILJwd5neF8mWrRbEjIGqJ68Nc5uIlK+mD5gfA
 TMnH/2MoAlpzLEOaNtBjhe+j2X0CE4bVObXYM7i411EUm84AiomV8WwnNC21zvzjBcsf
 GVMA==
X-Gm-Message-State: AOAM530Urn2fR+zxWGAKXGZ+TxuGGGgoDv0g+OahyB5a8Q1kucpRWB+M
 sfEY8dgdDwCCFLLjf+uLMoE=
X-Google-Smtp-Source: ABdhPJw43xrSDZbM980Q1wyWmczcPUCg8AtgaZXw5a+lncrCANbP6dkN49Y+7fuL7XSHkRq9MvMZ7w==
X-Received: by 2002:a1c:678a:: with SMTP id b132mr4764047wmc.10.1599572190886; 
 Tue, 08 Sep 2020 06:36:30 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id v128sm31250006wme.2.2020.09.08.06.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 06:36:30 -0700 (PDT)
Date: Tue, 8 Sep 2020 13:36:29 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 18/46] x86/msi: Consolidate MSI allocation
Message-ID: <20200908133628.ekh2jbasjf6bxa5z@liuwe-devbox-debian-v2>
References: <20200826111628.794979401@linutronix.de>
 <20200826112332.466405395@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200826112332.466405395@linutronix.de>
User-Agent: NeoMutt/20180716
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
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

On Wed, Aug 26, 2020 at 01:16:46PM +0200, Thomas Gleixner wrote:
[...]
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1534,7 +1534,7 @@ static struct irq_chip hv_msi_irq_chip =
>  static irq_hw_number_t hv_msi_domain_ops_get_hwirq(struct msi_domain_info *info,
>  						   msi_alloc_info_t *arg)
>  {
> -	return arg->msi_hwirq;
> +	return arg->hwirq;
>  }

Acked-by: Wei Liu <wei.liu@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
