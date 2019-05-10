Return-Path: <SRS0=MPmd=TK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618F7C04A6B
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 13:36:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394E42177B
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 13:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394E42177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F354AE8E;
	Fri, 10 May 2019 13:36:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E6E3DE6C
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 13:36:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 8800C1FB
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 13:36:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07E4EA78;
	Fri, 10 May 2019 06:36:56 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 133933F575;
	Fri, 10 May 2019 06:36:51 -0700 (PDT)
Subject: Re: [ARM SMMU] Dynamic StreamID allocation
To: Pankaj Bansal <pankaj.bansal@nxp.com>, Will Deacon <will.deacon@arm.com>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
References: <VI1PR0401MB24969CE24E4FB91EC8551DEBF10C0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <f0c3abd6-7b9f-8b68-14fa-3c6cf393ddc9@arm.com>
Date: Fri, 10 May 2019 14:36:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <VI1PR0401MB24969CE24E4FB91EC8551DEBF10C0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
Content-Language: en-US
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Varun Sethi <V.Sethi@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 10/05/2019 13:33, Pankaj Bansal wrote:
> Hi Will/Robin/Joerg,
> 
> I am s/w engineer from NXP India Pvt. Ltd.
> We are using SMMU-V3 in one of NXP SOC.
> I have a question about the SMMU Stream ID allocation in linux.
> 
> Right now the Stream IDs allocated to a device are mapped via device tree to the device.
> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt#L39
> 
> As the device tree is passed from bootloader to linux, we detect all the stream IDs needed by a device in bootloader and add their IDs in respective device nodes.
> For each PCIE Endpoint (a unique BDF (Bus Device Function)) on PCIE bus, we are assigning a unique Stream ID in bootloader.
> 
> However, this poses an issue with PCIE hot plug.
> If we plug in a pcie device while linux is running, a unique BDF is assigned to the device, for which there is no stream ID in device tree.
> 
> How can this problem be solved in linux?

Assuming the streamID associated to a BDF is predictable (streamID = BDF
+ constant), using the iommu-map property should just work:

https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/pci/pci-iommu.txt

It describes the streamIDs of all possible BDFs, including hotplugged
functions.

Thanks,
Jean

> 
> Is there a way to assign (and revoke) stream IDs at run time?
> 
> Regards,
> Pankaj Bansal
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
