Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9FDC433E4
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 23:57:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F8021897
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 23:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F8021897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B70402635C;
	Mon, 13 Jul 2020 23:57:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J5OrQEF9W6hC; Mon, 13 Jul 2020 23:57:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 11CD7204FF;
	Mon, 13 Jul 2020 23:57:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAEB4C0888;
	Mon, 13 Jul 2020 23:57:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 448D0C0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 23:57:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3F00287D04
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 23:57:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qr2CfhvTOXaC for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 23:57:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AAD2587CEC
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 23:57:54 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id c16so15441867ioi.9
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 16:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7c5zEhAAZe4ARtWE37/DC1WUrD4G1u+Olxon0OQTcTY=;
 b=IFdJJNIXzXBxBiXjcQ9fWJFCYbHBY+vFnYFaAOOOS2s8VJNlICmZtVoauvcQrLl3UG
 xwQyUl1UTjPAbtweCVkEk5hBlxK0BHPR2CsB1wmR1kHSsjrHgDr9rkvaXDjb9f4sd+vp
 G9C1vAJ7QkArWBPkDRzrcpLiM3AzWt5ZZ06zV3oryu+8pWTZPJH3LnfAfxDVuIFcnVSh
 eHaqu23IGMSf7lAK2C1zPwSwv4xlUglK0dSMsK3SaVtj2ECl2yuWkPFT/aLBoDvLQEsj
 9pVOXiVUxoqf+56rubHQedOGweJSBSgF7KjaCfMjRl4c9bH6x49/97cUbwrfA+FYGXG/
 IsMg==
X-Gm-Message-State: AOAM532VICmy+xWhJoL2rs6aiiV4FJZYAFBMyPo4dWwJQRt6/E0HzWpd
 0kw3Ng2uYWDqgewOsRpnLA==
X-Google-Smtp-Source: ABdhPJzk0xad7Wqvui02rA9XsQsYeJbjiQrhI195AJtDwQfLcpp3zuMxhjsKkSZEBtUKqrliJBcwUQ==
X-Received: by 2002:a6b:8d4d:: with SMTP id p74mr2302931iod.173.1594684674059; 
 Mon, 13 Jul 2020 16:57:54 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id k1sm9003186ilr.35.2020.07.13.16.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 16:57:53 -0700 (PDT)
Received: (nullmailer pid 959222 invoked by uid 1000);
 Mon, 13 Jul 2020 23:57:51 -0000
Date: Mon, 13 Jul 2020 17:57:51 -0600
From: Rob Herring <robh@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 06/12] of/iommu: Make of_map_rid() PCI agnostic
Message-ID: <20200713235751.GA959175@bogus>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-7-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200619082013.13661-7-lorenzo.pieralisi@arm.com>
Cc: devicetree@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Makarand Pawagi <makarand.pawagi@nxp.com>, Marc Zyngier <maz@kernel.org>,
 Diana Craciun <diana.craciun@oss.nxp.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robin Murphy <robin.murphy@arm.com>,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

On Fri, 19 Jun 2020 09:20:07 +0100, Lorenzo Pieralisi wrote:
> There is nothing PCI specific (other than the RID - requester ID)
> in the of_map_rid() implementation, so the same function can be
> reused for input/output IDs mapping for other busses just as well.
> 
> Rename the RID instances/names to a generic "id" tag.
> 
> No functionality change intended.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/iommu/of_iommu.c |  4 ++--
>  drivers/of/base.c        | 42 ++++++++++++++++++++--------------------
>  drivers/of/irq.c         |  2 +-
>  include/linux/of.h       |  4 ++--
>  4 files changed, 26 insertions(+), 26 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
