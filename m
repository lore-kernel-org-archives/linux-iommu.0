Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4C2C49EAB
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 13:38:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9210E61400
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 13:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9210E61400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69BDE605E3;
	Thu, 24 Jun 2021 13:38:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iaZPvVM0eAuK; Thu, 24 Jun 2021 13:38:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 76D10605A6;
	Thu, 24 Jun 2021 13:38:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54947C001A;
	Thu, 24 Jun 2021 13:38:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A20BEC000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:38:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8446C605B7
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:38:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h6KDzap-m0rN for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 13:38:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 16288605A6
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:38:20 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3923361002;
 Thu, 24 Jun 2021 13:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1624541900;
 bh=+IAFywe/fQNi3yGadTzdfNAMDo97W+pVUgJlXiEOuT8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Zgrt8sAOUKv4aq0TAmi/6ugV5pAIMt9nN5X2GqMqbVzBs0rIDqvfl9v3Rw1sNMKsl
 cRDDLduiEb/vFKo2y+shFY6Vy4cmO6ixmrSknVR0tUeE958MWQGMl6xMx87iTN1jxp
 Om9wOnn1JosUsE5Xd3Ttb53ewALmoSYK+bzQ7qmc=
Date: Thu, 24 Jun 2021 15:38:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 3/6] PCI: Indicate that we want to force strict DMA for
 untrusted devices
Message-ID: <YNSKyu/a8S3Qywbc@kroah.com>
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.3.I7accc008905590bb2b46f40f91a4aeda5b378007@changeid>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210621165230.3.I7accc008905590bb2b46f40f91a4aeda5b378007@changeid>
Cc: ulf.hansson@linaro.org, rafael@kernel.org, linux-pci@vger.kernel.org,
 joel@joelfernandes.org, rajatja@google.com, will@kernel.org,
 robdclark@chromium.org, saravanak@google.com, rafael.j.wysocki@intel.com,
 quic_c_gdjako@quicinc.com, vbadigan@codeaurora.org,
 linux-arm-msm@vger.kernel.org, bhelgaas@google.com, sonnyrao@chromium.org,
 linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com
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

On Mon, Jun 21, 2021 at 04:52:45PM -0700, Douglas Anderson wrote:
> At the moment the generic IOMMU framework reaches into the PCIe device
> to check the "untrusted" state and uses this information to figure out
> if it should be running the IOMMU in strict or non-strict mode. Let's
> instead set the new boolean in "struct device" to indicate when we
> want forced strictness.
> 
> NOTE: we still continue to set the "untrusted" bit in PCIe since that
> apparently is used for more than just IOMMU strictness. It probably
> makes sense for a later patchset to clarify all of the other needs we
> have for "untrusted" PCIe devices (perhaps add more booleans into the
> "struct device") so we can fully eliminate the need for the IOMMU
> framework to reach into a PCIe device.

It feels like the iommu code should not be messing with pci devices at
all, please don't do this.

Why does this matter?  Why wouldn't a pci device use "strict" iommu at
all times?  What happens if it does not?  Why are PCI devices special?

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
