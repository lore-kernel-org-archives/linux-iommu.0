Return-Path: <SRS0=+ySY=UK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B880FC4646D
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 15:55:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4682080A
	for <iommu@archiver.kernel.org>; Tue, 11 Jun 2019 15:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4682080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 542EEF4F;
	Tue, 11 Jun 2019 15:55:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6FE8EF4A
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 15:55:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 0BCC6174
	for <iommu@lists.linux-foundation.org>;
	Tue, 11 Jun 2019 15:55:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FA9B337;
	Tue, 11 Jun 2019 08:55:31 -0700 (PDT)
Received: from redmoon (unknown [10.1.196.255])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EBD63F246;
	Tue, 11 Jun 2019 08:55:29 -0700 (PDT)
Date: Tue, 11 Jun 2019 16:55:21 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [PATCH v1 0/3] PCIe and AR8151 on APQ8098/MSM8998
Message-ID: <20190611155521.GA18411@redmoon>
References: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Jeffrey Hugo <jhugo@codeaurora.org>, MSM <linux-arm-msm@vger.kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Evan Green <evgreen@chromium.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Manu Gautam <mgautam@codeaurora.org>,
	iommu <iommu@lists.linux-foundation.org>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, Mar 28, 2019 at 05:59:48PM +0100, Marc Gonzalez wrote:
> Hello everyone,
> 
> After a lot of poking, I am finally able to use the AR8151 ethernet on the APQ8098 board.
> The magic bits are the iommu-map prop and the PCIE20_PARF_BDF_TRANSLATE_N setup.
> 
> The WIP thread is archived here:
> https://marc.info/?t=155059539200004&r=1&w=2
> 
> 
> Marc Gonzalez (3):
>   PCI: qcom: Setup PCIE20_PARF_BDF_TRANSLATE_N
>   arm64: dts: qcom: msm8998: Add PCIe SMMU node
>   arm64: dts: qcom: msm8998: Add PCIe PHY and RC nodes
> 
>  arch/arm64/boot/dts/qcom/msm8998.dtsi  | 93 ++++++++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom.c |  4 ++
>  2 files changed, 97 insertions(+)

Marc,

what's the plan with this series ? Please let me know so that
I can handle it correctly in the PCI patch queue, I am not
sure by reading comments it has evolved much since posting.

Thanks,
Lorenzo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
