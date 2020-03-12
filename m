Return-Path: <SRS0=xT8t=45=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBA5C5ACBF
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 21:02:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DF60206BE
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 21:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdwLzcJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF60206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D06D72035C;
	Thu, 12 Mar 2020 21:02:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gh1JNRRpcHnr; Thu, 12 Mar 2020 21:02:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 569A32012D;
	Thu, 12 Mar 2020 21:02:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C87DC089F;
	Thu, 12 Mar 2020 21:02:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48D20C0177
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 21:02:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3FFFD86B93
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 21:02:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dpyPW0HPa6Zm for <iommu@lists.linux-foundation.org>;
 Thu, 12 Mar 2020 21:01:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C570A86B91
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 21:01:59 +0000 (UTC)
Received: from localhost (mobile-166-175-186-165.mycingular.net
 [166.175.186.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 158B320674;
 Thu, 12 Mar 2020 21:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584046919;
 bh=/e9LLeJ5dACgdtAw3HHaj6wtWKVc0kxLbLGS8/Q25qw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=EdwLzcJvSjpI3Th7mp7lKFatB+Yn47XEfNY+YgjNT3ENbyGBE0r12eGlfupHp5IcO
 TT8zsQMtI4TjFzhyJjyXL5LlLSL1a5GlHXoya30uKdsCtQVAkqrDLP566944IgMvPi
 nkoB08xDowbPCi+qj0dPDSH9lPbxsLbhzikPdbJs=
Date: Thu, 12 Mar 2020 16:01:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 05/11] PCI/ATS: Gather checks into pci_ats_supported()
Message-ID: <20200312210157.GA180471@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200311124506.208376-6-jean-philippe@linaro.org>
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

On Wed, Mar 11, 2020 at 01:45:00PM +0100, Jean-Philippe Brucker wrote:
> IOMMU drivers need to perform several tests when checking if a device
> supports ATS.  Move them all into a new function that returns true when
> a device and its host bridge support ATS.
> 
> Since pci_enable_ats() now calls pci_ats_supported(), the following
> new checks are now common:
> * whether a device is trusted.  Devices plugged into external-facing
>   ports such as thunderbolt are untrusted.
> * whether the host bridge supports ATS, which defaults to true unless
>   the firmware description states that ATS isn't supported by the host
>   bridge.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/ats.c       | 30 +++++++++++++++++++++++++++++-
>  include/linux/pci-ats.h |  3 +++
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 390e92f2d8d1..bbfd0d42b8b9 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -30,6 +30,34 @@ void pci_ats_init(struct pci_dev *dev)
>  	dev->ats_cap = pos;
>  }
>  
> +/**
> + * pci_ats_supported - check if the device can use ATS
> + * @dev: the PCI device
> + *
> + * Returns true if the device supports ATS and is allowed to use it, false
> + * otherwise.
> + */
> +bool pci_ats_supported(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *bridge;
> +
> +	if (!dev->ats_cap)
> +		return false;
> +
> +	if (dev->untrusted)
> +		return false;
> +
> +	bridge = pci_find_host_bridge(dev->bus);
> +	if (!bridge)
> +		return false;
> +
> +	if (!bridge->ats_supported)
> +		return false;
> +
> +	return true;

I assume this is the same as

  return bridge->ats_supported;

Only "assuming" because I'm not a C language lawyer, but I assume it
does the obvious conversion from unsigned:1 to bool.

> +}
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
