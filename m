Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30F1C49EAB
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 13:37:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A54613F6
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 13:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A54613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3967C83CD1;
	Thu, 24 Jun 2021 13:37:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gbo2bM1kT2WV; Thu, 24 Jun 2021 13:37:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2F70983C2A;
	Thu, 24 Jun 2021 13:37:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07AD3C001A;
	Thu, 24 Jun 2021 13:37:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C71C9C000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:36:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B2993415C5
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:36:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KRsBBNDjMXBL for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 13:36:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7533415C2
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:36:57 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3EA2613EB;
 Thu, 24 Jun 2021 13:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1624541817;
 bh=g0zux5mruXr8HgwB0J/Fg2ET0cGWJ+eO/WgbobZer78=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MnmTzlvS04mRBfahmUtH3yzTTGvsVHhdNFYf3l3iseIf39pEAh4JE4jSnyR2UppWJ
 CDpwlF/glmCJ4fKm3UqgkdW9J4VDJN6bDrCrvdl4aUyTlaywsra5opQSPuC8Ozkxpg
 dZ1ObbX9YCUcZNB/d6C7WJAWNrp7h6ETzueX1SH0=
Date: Thu, 24 Jun 2021 15:36:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/6] drivers: base: Add bits to struct device to control
 iommu strictness
Message-ID: <YNSKdhMACa9LFuVN@kroah.com>
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.2.Icfe7cbb2cc86a38dde0ee5ba240e0580a0ec9596@changeid>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210621165230.2.Icfe7cbb2cc86a38dde0ee5ba240e0580a0ec9596@changeid>
Cc: ulf.hansson@linaro.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 rafael@kernel.org, linux-pci@vger.kernel.org, joel@joelfernandes.org,
 rajatja@google.com, will@kernel.org, robdclark@chromium.org,
 saravanak@google.com, rafael.j.wysocki@intel.com, quic_c_gdjako@quicinc.com,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, vbadigan@codeaurora.org,
 linux-arm-msm@vger.kernel.org, bhelgaas@google.com,
 Dan Williams <dan.j.williams@intel.com>, sonnyrao@chromium.org,
 Randy Dunlap <rdunlap@infradead.org>, linux-mmc@vger.kernel.org,
 adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

On Mon, Jun 21, 2021 at 04:52:44PM -0700, Douglas Anderson wrote:
> How to control the "strictness" of an IOMMU is a bit of a mess right
> now. As far as I can tell, right now:
> * You can set the default to "non-strict" and some devices (right now,
>   only PCI devices) can request to run in "strict" mode.
> * You can set the default to "strict" and no devices in the system are
>   allowed to run as "non-strict".
> 
> I believe this needs to be improved a bit. Specifically:
> * We should be able to default to "strict" mode but let devices that
>   claim to be fairly low risk request that they be run in "non-strict"
>   mode.
> * We should allow devices outside of PCIe to request "strict" mode if
>   the system default is "non-strict".
> 
> I believe the correct way to do this is two bits in "struct
> device". One allows a device to force things to "strict" mode and the
> other allows a device to _request_ "non-strict" mode. The asymmetry
> here is on purpose. Generally if anything in the system makes a
> request for strictness of something then we want it strict. Thus
> drivers can only request (but not force) non-strictness.
> 
> It's expected that the strictness fields can be filled in by the bus
> code like in the patch ("PCI: Indicate that we want to force strict
> DMA for untrusted devices") or by using the new pre_probe concept
> introduced in the patch ("drivers: base: Add the concept of
> "pre_probe" to drivers").
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  include/linux/device.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index f1a00040fa53..c1b985e10c47 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -449,6 +449,15 @@ struct dev_links_info {
>   *		and optionall (if the coherent mask is large enough) also
>   *		for dma allocations.  This flag is managed by the dma ops
>   *		instance from ->dma_supported.
> + * @force_strict_iommu: If set to %true then we should force this device to
> + *			iommu.strict regardless of the other defaults in the
> + *			system. Only has an effect if an IOMMU is in place.

Why would you ever NOT want to do this?

> + * @request_non_strict_iommu: If set to %true and there are no other known
> + *			      reasons to make the iommu.strict for this device,
> + *			      then default to non-strict mode. This implies
> + *			      some belief that the DMA master for this device
> + *			      won't abuse the DMA path to compromise the kernel.
> + *			      Only has an effect if an IOMMU is in place.

This feels in contrast to the previous field you just added, how do they
both interact?  Would an enum work better?

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
