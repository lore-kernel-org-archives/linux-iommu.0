Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AEBC433E4
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 07:57:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557A02074B
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 07:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsJgQucN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557A02074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2B42D226E5;
	Thu, 16 Jul 2020 07:57:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J1XYunLTfYMa; Thu, 16 Jul 2020 07:57:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 67D9B20532;
	Thu, 16 Jul 2020 07:57:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FE6BC0893;
	Thu, 16 Jul 2020 07:57:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5FACC0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 07:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D44FF88D9C
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 07:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BFQozd_k2uWM for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 07:57:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 80B4388DCE
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 07:57:08 +0000 (UTC)
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3472120657;
 Thu, 16 Jul 2020 07:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594886228;
 bh=lF6V4pThpgd1ETqa/+C0kE0OsT7SQmJj3FXX4kf+cNU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=VsJgQucNe+tORSuGENCHPNa2BMvAsbolf2wFejeM2VFlX2cbvvZUjPeT2UhxohJQv
 u4qIHJNBHt7wYmWQnDf9Ow829zQsoMD8NiqTe1Ebs+tmttdHnQMVmV+OuwzzjBm5S5
 T/6aNfgNS271UBnzQ227W+foVJvVP2lSFXLJEcIs=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jvylO-00CEd7-OZ; Thu, 16 Jul 2020 08:57:06 +0100
MIME-Version: 1.0
Date: Thu, 16 Jul 2020 08:57:06 +0100
From: Marc Zyngier <maz@kernel.org>
To: Makarand Pawagi <makarand.pawagi@nxp.com>
Subject: Re: [EXT] Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for
 fsl-mc
In-Reply-To: <DB7PR04MB498603933E805C0E4053D4B7EB7F0@DB7PR04MB4986.eurprd04.prod.outlook.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-13-lorenzo.pieralisi@arm.com>
 <a7845603-9bc9-9099-dfc4-19b7bc4f4e44@nxp.com>
 <20200709091950.GA18149@e121166-lin.cambridge.arm.com>
 <DB7PR04MB4986D1A0BB7B685911DF4831EB640@DB7PR04MB4986.eurprd04.prod.outlook.com>
 <203372be-144c-54ba-d011-30d0746dd615@nxp.com>
 <DB7PR04MB4986C63772CB47A2A827D028EB640@DB7PR04MB4986.eurprd04.prod.outlook.com>
 <d41589da-c2f9-a750-f57a-25dccf51e69f@oss.nxp.com>
 <DB7PR04MB4986A56021750A3D104CA244EB640@DB7PR04MB4986.eurprd04.prod.outlook.com>
 <20200715100636.GA31330@e121166-lin.cambridge.arm.com>
 <DB7PR04MB498603933E805C0E4053D4B7EB7F0@DB7PR04MB4986.eurprd04.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <20ac0bcf43a621e7b51d9badb91d2a71@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: makarand.pawagi@nxp.com, lorenzo.pieralisi@arm.com,
 diana.craciun@oss.nxp.com, laurentiu.tudor@nxp.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, robh+dt@kernel.org, rjw@rjwysocki.net,
 joro@8bytes.org, guohanjun@huawei.com, bhelgaas@google.com,
 sudeep.holla@arm.com, robin.murphy@arm.com, catalin.marinas@arm.com,
 will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Cc: devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
 Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 "Diana Madalina Craciun
 \(OSS\)" <diana.craciun@oss.nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On 2020-07-16 04:23, Makarand Pawagi wrote:
>> -----Original Message-----
>> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

[...]

>> Anyway - you need to seek feedback from Marc on whether patches
>> 11 and 12 are OK from an irqchip perspective, it is possible we can 
>> take the rest
>> of the series independently if everyone agrees but I don't necessarily 
>> see a
>> reason for that.
>> 
>> Long story short: you need Marc's ACK on [11-12], it is your code.
>> 
> Hi Marc, can you please review/ack this patch?

https://lore.kernel.org/linux-acpi/bd07f44dad1d029e0d023202cbf5fc94@kernel.org/

         M.
-- 
Jazz is not dead. It just smells funny...
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
