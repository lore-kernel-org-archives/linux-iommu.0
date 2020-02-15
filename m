Return-Path: <SRS0=Bnx6=4D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC070C7114E
	for <iommu@archiver.kernel.org>; Sat, 15 Feb 2020 21:10:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2FC42084E
	for <iommu@archiver.kernel.org>; Sat, 15 Feb 2020 21:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j47cd6VE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FC42084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8DE6F86146;
	Sat, 15 Feb 2020 21:10:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hSb0AQ8S9yzy; Sat, 15 Feb 2020 21:10:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EBBD786141;
	Sat, 15 Feb 2020 21:10:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4C59C0881;
	Sat, 15 Feb 2020 21:10:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40D18C0177
 for <iommu@lists.linux-foundation.org>; Sat, 15 Feb 2020 21:10:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2940B86146
 for <iommu@lists.linux-foundation.org>; Sat, 15 Feb 2020 21:10:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jfcx-K13S9u4 for <iommu@lists.linux-foundation.org>;
 Sat, 15 Feb 2020 21:10:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6B5D786141
 for <iommu@lists.linux-foundation.org>; Sat, 15 Feb 2020 21:10:50 +0000 (UTC)
Received: from localhost (mobile-166-175-186-165.mycingular.net
 [166.175.186.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 905702086A;
 Sat, 15 Feb 2020 21:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581801050;
 bh=tEClT3+bvoTgI32MP1CwIfXkOx2B0xPFE4PgnQ/bh48=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=j47cd6VEUSwkfygxE3Fl0jZ0+y96rV6rhCOwTbxqICgBpfUFlzCgbwqGdRnYiox7C
 WKpb0mZuAn05weV4GJBx36SsMMc64S7A1LA6rWCgZ5DLfuiiSr3UJMQigOngLYguLD
 3KhIlTuEB+wKTuzoV2SkhAffzCkX+GisJYG3Cb8A=
Date: Sat, 15 Feb 2020 15:10:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 02/11] PCI: Add ats_supported host bridge flag
Message-ID: <20200215211047.GA124796@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200213165049.508908-3-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 liviu.dudau@arm.com, guohanjun@huawei.com, frowand.list@gmail.com,
 corbet@lwn.net, will@kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, dwmw2@infradead.org, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 amurray@thegoodpenguin.co.uk
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

On Thu, Feb 13, 2020 at 05:50:40PM +0100, Jean-Philippe Brucker wrote:
> Each vendor has their own way of describing whether a host bridge
> supports ATS.  The Intel and AMD ACPI tables selectively enable or
> disable ATS per device or sub-tree, while Arm has a single bit for each
> host bridge.  For those that need it, add an ats_supported bit to the
> host bridge structure.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/pci/probe.c | 7 +++++++
>  include/linux/pci.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 512cb4312ddd..75c0a25af44e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -598,6 +598,13 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  	bridge->native_shpc_hotplug = 1;
>  	bridge->native_pme = 1;
>  	bridge->native_ltr = 1;
> +
> +	/*
> +	 * Some systems may disable ATS at the host bridge (ACPI IORT,
> +	 * device-tree), other filter it with a smaller granularity (ACPI DMAR
> +	 * and IVRS).
> +	 */
> +	bridge->ats_supported = 1;

The cover letter says it's important to enable ATS only if the host
bridge supports it.  From the other patches, it looks like we learn if
the host bridge supports ATS from either a DT "ats-supported" property
or an ACPI IORT table.  If that's the case, shouldn't the default here
be "ATS is *not* supported"?

>  }
>  
>  struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 3840a541a9de..9fe2e84d74d7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -511,6 +511,7 @@ struct pci_host_bridge {
>  	unsigned int	native_pme:1;		/* OS may use PCIe PME */
>  	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
>  	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
> +	unsigned int	ats_supported:1;
>  
>  	/* Resource alignment requirements */
>  	resource_size_t (*align_resource)(struct pci_dev *dev,
> -- 
> 2.25.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
