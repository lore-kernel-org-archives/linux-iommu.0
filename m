Return-Path: <SRS0=xM8W=A2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6E3C433E2
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 13:05:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECCF520658
	for <iommu@archiver.kernel.org>; Wed, 15 Jul 2020 13:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="11WLdv3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCF520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BA50220487;
	Wed, 15 Jul 2020 13:05:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6M+By1Nj8JPu; Wed, 15 Jul 2020 13:05:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E4477203E7;
	Wed, 15 Jul 2020 13:05:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3F6BC07FF;
	Wed, 15 Jul 2020 13:05:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3972DC0733
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 13:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1AD4220487
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 13:05:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aqYSr76eyu16 for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jul 2020 13:05:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 01862203E7
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jul 2020 13:05:09 +0000 (UTC)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 659CC20657;
 Wed, 15 Jul 2020 13:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594818309;
 bh=/JbnkKca9isth2Byqb4RT/WZLJphSaAVAFp0XT01uu0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=11WLdv3zamDVHmM6A7sD3vIrgCjWwh2+roNC+ngAh1r1bKzwRyZN5Hv+dK7odXwI5
 Z96N6IXf1vw98heHULxcTXjVl85NZfzyR30Aywy25KKdwDK5SlEJumKgoTpN0pRPd3
 3TcKkQHsxLcEAqtcWXhh1ufg29KGZjgEkTtjUSf0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jvh5v-00BzoN-VJ; Wed, 15 Jul 2020 14:05:08 +0100
MIME-Version: 1.0
Date: Wed, 15 Jul 2020 14:05:07 +0100
From: Marc Zyngier <maz@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 11/12] bus/fsl-mc: Refactor the MSI domain creation in
 the DPRC driver
In-Reply-To: <20200619082013.13661-12-lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-12-lorenzo.pieralisi@arm.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <bd07f44dad1d029e0d023202cbf5fc94@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lorenzo.pieralisi@arm.com,
 linux-arm-kernel@lists.infradead.org, diana.craciun@oss.nxp.com,
 iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh+dt@kernel.org,
 rjw@rjwysocki.net, joro@8bytes.org, guohanjun@huawei.com, bhelgaas@google.com,
 sudeep.holla@arm.com, robin.murphy@arm.com, catalin.marinas@arm.com,
 will@kernel.org, makarand.pawagi@nxp.com, laurentiu.tudor@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-pci@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, Makarand Pawagi <makarand.pawagi@nxp.com>,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Diana Craciun <diana.craciun@oss.nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-06-19 09:20, Lorenzo Pieralisi wrote:
> From: Diana Craciun <diana.craciun@oss.nxp.com>
> 
> The DPRC driver is not taking into account the msi-map property
> and assumes that the icid is the same as the stream ID. Although
> this assumption is correct, generalize the code to include a
> translation between icid and streamID.
> 
> Furthermore do not just copy the MSI domain from parent (for child
> containers), but use the information provided by the msi-map property.
> 
> If the msi-map property is missing from the device tree retain the old
> behaviour for backward compatibility ie the child DPRC objects
> inherit the MSI domain from the parent.
> 
> Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> ---
>  drivers/bus/fsl-mc/dprc-driver.c            | 31 ++++++---------------
>  drivers/bus/fsl-mc/fsl-mc-bus.c             |  4 +--
>  drivers/bus/fsl-mc/fsl-mc-msi.c             | 31 +++++++++++++--------
>  drivers/bus/fsl-mc/fsl-mc-private.h         |  6 ++--
>  drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 15 +++++++++-
>  5 files changed, 47 insertions(+), 40 deletions(-)

For this patch and the following one:

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
