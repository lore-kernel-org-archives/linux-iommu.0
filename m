Return-Path: <SRS0=dQER=OH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D20C433F5
	for <iommu@archiver.kernel.org>; Fri, 17 Sep 2021 16:28:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD1960F6D
	for <iommu@archiver.kernel.org>; Fri, 17 Sep 2021 16:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1CD1960F6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6F7A40434;
	Fri, 17 Sep 2021 16:28:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FXA6KxcixQBa; Fri, 17 Sep 2021 16:28:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B544E40384;
	Fri, 17 Sep 2021 16:28:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EEE0C0011;
	Fri, 17 Sep 2021 16:28:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63DA7C000D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 16:28:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 45247840CF
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 16:28:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cZzqrFsBqNCs for <iommu@lists.linux-foundation.org>;
 Fri, 17 Sep 2021 16:28:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A0CE8406F
 for <iommu@lists.linux-foundation.org>; Fri, 17 Sep 2021 16:28:46 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D155160555;
 Fri, 17 Sep 2021 16:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631896126;
 bh=RRE6NMda31/dIqqeP4g2Zg1MqUaKnLsM3Ro/I9LVt3w=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=IBbNMhquNK9liwy6lIWmdPIXzOZVsmIh3XmUdeu0OCTs9jMQRFZj4wNKUIerdiVKo
 mBMDO993ITGHINd9RLo1DY66iD3VOGkNh0ua2l7uUucIPa9VgX2bJ3+P0Wr0K7/+HG
 og0S6Mz5MOJn7XReD5EeUMdc7TA2gihk25XztwGh86GImWJqlCB0TDSX67KV04NaMv
 p0osTnLc/lTsOfpedLQ+EjMmJ/gAqIX/e1CLxFaP52jp3kxgAwF0cddgUxqB22Gld3
 JCAGcSeUs7Bd1NpgzoHU2PijOf49moRGDvKEylzevEZ2zsFtcDoaQ8cwiS5GKTUyN4
 Jjblai00CbORg==
Date: Fri, 17 Sep 2021 11:28:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan Beulich <jbeulich@suse.com>
Subject: Re: [PATCH v2 2/4] PCI: only build xen-pcifront in PV-enabled
 environments
Message-ID: <20210917162844.GA1722208@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3a7f6c9b-215d-b593-8056-b5fe605dafd7@suse.com>
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Konrad Wilk <konrad.wilk@oracle.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, "hch@lst.de" <hch@lst.de>
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

s/only/Only/ in subject

On Fri, Sep 17, 2021 at 12:48:03PM +0200, Jan Beulich wrote:
> The driver's module init function, pcifront_init(), invokes
> xen_pv_domain() first thing. That construct produces constant "false"
> when !CONFIG_XEN_PV. Hence there's no point building the driver in
> non-PV configurations.

Thanks for these bread crumbs.  xen_domain_type is set to
XEN_PV_DOMAIN only by xen_start_kernel() in enlighten_pv.c, which is
only built when CONFIG_XEN_PV=y, so even I can verify this :)

> Drop the (now implicit and generally wrong) X86 dependency: At present,
> XEN_PV con only be set when X86 is also enabled. In general an
> architecture supporting Xen PV (and PCI) would want to have this driver
> built.

s/con only/can only/

> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> v2: Title and description redone.
> 
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -110,7 +110,7 @@ config PCI_PF_STUB
>  
>  config XEN_PCIDEV_FRONTEND
>  	tristate "Xen PCI Frontend"
> -	depends on X86 && XEN
> +	depends on XEN_PV
>  	select PCI_XEN
>  	select XEN_XENBUS_FRONTEND
>  	default y
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
