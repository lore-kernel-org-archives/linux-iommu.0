Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DC2C10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 09:39:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9001520818
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 09:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9001520818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4B88521D5;
	Thu, 11 Apr 2019 09:39:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D2A8E1D87
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 09:38:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6B6D876D
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 09:38:51 +0000 (UTC)
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id 0A6C2217FB;
	Thu, 11 Apr 2019 11:38:50 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id DF9CE217F7;
	Thu, 11 Apr 2019 11:38:49 +0200 (CEST)
Subject: Re: [PATCH v1 3/3] arm64: dts: qcom: msm8998: Add PCIe PHY and RC
	nodes
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>
References: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr>
	<186f7ca2-84e2-a37e-79e6-f1fec8e25374@free.fr>
	<3f32cfb9-6528-9f5e-85db-cee89fdcfc5d@mm-sol.com>
	<8ee2ca1b-2a0d-0c98-f770-a47b5b529295@free.fr>
	<8ada0472-0692-2f03-b52f-c1702bb0c33d@mm-sol.com>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <8d890fdf-233e-5454-2696-fe30bd73f54c@free.fr>
Date: Thu, 11 Apr 2019 11:38:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8ada0472-0692-2f03-b52f-c1702bb0c33d@mm-sol.com>
Content-Language: en-US
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ;
	Thu Apr 11 11:38:50 2019 +0200 (CEST)
Cc: Jeffrey Hugo <jhugo@codeaurora.org>, MSM <linux-arm-msm@vger.kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Evan Green <evgreen@chromium.org>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Manu Gautam <mgautam@codeaurora.org>,
	iommu <iommu@lists.linux-foundation.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411093849.PIjr39i3VDF0Fb67O8QTRFYOOLKr4gRBXYzVvwBtdeg@z>

On 11/04/2019 11:09, Stanimir Varbanov wrote:

> On 4/11/19 11:44 AM, Marc Gonzalez wrote:
> 
>> Since we just want to map 0x100, we don't need an iommu-map-mask.
> 
> Do you see warnings during boot about missing property?

Absent iommu-map-mask property is expected. No warning:

https://elixir.bootlin.com/linux/latest/source/drivers/of/base.c#L2245

	/* The default is to select all bits. */
	map_mask = 0xffffffff;

	/*
	 * Can be overridden by "{iommu,msi}-map-mask" property.
	 * If of_property_read_u32() fails, the default is used.
	 */
	if (map_mask_name)
		of_property_read_u32(np, map_mask_name, &map_mask);


>>>> +			/* PCIe Fundamental Reset */
>>>
>>> this comment is useless :) please drop it
>>
>> IMO, "perst" is a poor name. Can you guess what it stands for?
> 
> The name is got from PCIE base specification. See 6.6.1.
> Conventional Reset from "PCI EXPRESS BASE SPECIFICATION, REV. 3.0"

Indeed... Well, "perst" still sucks :-p

Regards.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
