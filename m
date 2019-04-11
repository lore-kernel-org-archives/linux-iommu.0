Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B9CC10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 08:44:29 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C391204EC
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 08:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C391204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 60E3F2382;
	Thu, 11 Apr 2019 08:44:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 89507237D
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 08:44:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6E0AAF4
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 08:44:10 +0000 (UTC)
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id BB41021860;
	Thu, 11 Apr 2019 10:44:07 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id 96C9C21869;
	Thu, 11 Apr 2019 10:44:07 +0200 (CEST)
Subject: Re: [PATCH v1 3/3] arm64: dts: qcom: msm8998: Add PCIe PHY and RC
	nodes
To: Stanimir Varbanov <svarbanov@mm-sol.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>
References: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr>
	<186f7ca2-84e2-a37e-79e6-f1fec8e25374@free.fr>
	<3f32cfb9-6528-9f5e-85db-cee89fdcfc5d@mm-sol.com>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <8ee2ca1b-2a0d-0c98-f770-a47b5b529295@free.fr>
Date: Thu, 11 Apr 2019 10:44:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3f32cfb9-6528-9f5e-85db-cee89fdcfc5d@mm-sol.com>
Content-Language: en-US
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ;
	Thu Apr 11 10:44:07 2019 +0200 (CEST)
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
Message-ID: <20190411084407.5KyF2yOqdvEO3dFXJf9RjjeOb7NyNu2kkoJz0dwdqj8@z>

On 10/04/2019 17:32, Stanimir Varbanov wrote:

> Few comments inline.

I'll send v3.

Changes:
	- Move all X-names props *after* corresponding X(s) prop
	- Drop comments


>> +			iommu-map = <0x100 &anoc1_smmu 0x1480 1>;
> 
> iommu-map-mask? It is optional but I had to ask :)

The only RID in the system is 0x100.

# lspci
00:00.0 PCI bridge: Qualcomm Device 0105
01:00.0 Ethernet controller: Qualcomm Atheros AR8151 v2.0 Gigabit Ethernet (rev c0)

Since we just want to map 0x100, we don't need an iommu-map-mask.


>> +			/* PCIe Fundamental Reset */
> 
> this comment is useless :) please drop it

IMO, "perst" is a poor name. Can you guess what it stands for?

Regards.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
