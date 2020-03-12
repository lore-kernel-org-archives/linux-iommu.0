Return-Path: <SRS0=xT8t=45=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85663C5ACC0
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 21:21:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F476206CD
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 21:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqRSOd7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F476206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2947786CA7;
	Thu, 12 Mar 2020 21:21:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t9NHly7AdXeS; Thu, 12 Mar 2020 21:21:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8EDDF86055;
	Thu, 12 Mar 2020 21:21:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80DD3C18D3;
	Thu, 12 Mar 2020 21:21:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F904C0177
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 21:21:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 77ADF8858A
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 21:21:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EEBB1rbY-Iv9 for <iommu@lists.linux-foundation.org>;
 Thu, 12 Mar 2020 21:21:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5A3588857D
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 21:21:26 +0000 (UTC)
Received: from localhost (mobile-166-175-186-165.mycingular.net
 [166.175.186.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AE8B3206BE;
 Thu, 12 Mar 2020 21:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584048086;
 bh=7QxQN2DwLQDaVoXZb2JtRCzxu6x2CTMFwMZ1K7jh2Tw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=QqRSOd7LF3x7XcKV2ckDTs7eei1HR1cy25PL5NuTve+HDQbfdSyp8CF+vk+l6giQ4
 u3TU2kj8GRNgjxzk74X0Ojxauu/0EYksv/nxCZHLDY0/m+lr+Nj2deVAcUKn/iC3Mx
 8/LOU5eJCGAMcwqjgAe1ZLJi8w879jpNlPq1YdfQ=
Date: Thu, 12 Mar 2020 16:21:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 02/11] PCI: Add ats_supported host bridge flag
Message-ID: <20200312212124.GA178131@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200311124506.208376-3-jean-philippe@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
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

On Wed, Mar 11, 2020 at 01:44:57PM +0100, Jean-Philippe Brucker wrote:
> Each vendor has their own way of describing whether a host bridge
> supports ATS.  The Intel and AMD ACPI tables selectively enable or
> disable ATS per device or sub-tree, while Arm has a single bit for each
> host bridge.  For those that need it, add an ats_supported bit to the
> host bridge structure.

Can you mention the specific ACPI tables here in the commit log?

Maybe elaborate on the "for those that need it" bit?  I'm not sure if
you need it for the cases where DT or ACPI tells us directly for the
host bridge, or if you need it for the more selective cases?

I guess in one sense you *always* need it since you check the cached
bit later.

I don't understand the implications of this, especially the selective
situation.  Given your comment from the first posting, I thought this
was a property of the host bridge, so I don't know what it means to
say some devices support ATS but others don't.

> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v1->v2: try to improve the comment
> ---
>  drivers/pci/probe.c | 8 ++++++++
>  include/linux/pci.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 512cb4312ddd..b5e36f06b40a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -598,6 +598,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  	bridge->native_shpc_hotplug = 1;
>  	bridge->native_pme = 1;
>  	bridge->native_ltr = 1;
> +
> +	/*
> +	 * Some systems (ACPI IORT, device-tree) declare ATS support at the host
> +	 * bridge, and clear this bit when ATS isn't supported. Others (ACPI
> +	 * DMAR and IVRS) declare ATS support with a smaller granularity, and
> +	 * need this bit set.
> +	 */
> +	bridge->ats_supported = 1;
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
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
