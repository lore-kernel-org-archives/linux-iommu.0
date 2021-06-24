Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775F0C49EA6
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 13:35:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BF3C61002
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 13:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF3C61002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4B9960610;
	Thu, 24 Jun 2021 13:35:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uDz71t36VLtL; Thu, 24 Jun 2021 13:35:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D2A1960594;
	Thu, 24 Jun 2021 13:35:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8FC7C001A;
	Thu, 24 Jun 2021 13:35:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB5CDC000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA10B400D4
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:35:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vjw2xygk5lgt for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 13:35:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 38E90400C4
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:35:27 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C60B613DC;
 Thu, 24 Jun 2021 13:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1624541726;
 bh=Im8AJ/xzLG5igrCZBPvx/X/s8SqGh6KWTqyck17cCoQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JMLHRQ28OMZLW0wpvUm9Xlwqyt9Io+/duHqoiOloEkUkX/Z+6wqU/OyjDHWs6Lntt
 5QIdEoOiCKJecySIuqaNnTytjdIkfTjeATJDukQ/7TLjS1RN5+KZWhulco76hoOX9F
 U6o29EcMkWGSpT+pTyVkK77jJjZVWw2k/R93MySk=
Date: Thu, 24 Jun 2021 15:35:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/6] drivers: base: Add the concept of "pre_probe" to
 drivers
Message-ID: <YNSKHAiS3qIOwDVA@kroah.com>
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.1.Id4ee5788c993294f66542721fca7719c00a5d8f3@changeid>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210621165230.1.Id4ee5788c993294f66542721fca7719c00a5d8f3@changeid>
Cc: ulf.hansson@linaro.org, rafael@kernel.org, linux-pci@vger.kernel.org,
 joel@joelfernandes.org, rajatja@google.com, will@kernel.org,
 robdclark@chromium.org, saravanak@google.com, rafael.j.wysocki@intel.com,
 quic_c_gdjako@quicinc.com, Geert Uytterhoeven <geert@linux-m68k.org>,
 vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org, bhelgaas@google.com,
 sonnyrao@chromium.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
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

On Mon, Jun 21, 2021 at 04:52:43PM -0700, Douglas Anderson wrote:
> Right now things are a bit awkward if a driver would like a chance to
> run before some of the more "automatic" things (pinctrl, DMA, IOMMUs,
> ...) happen to a device. This patch aims to fix that problem by
> introducing the concept of a "pre_probe" function that drivers can
> implement to run before the "automatic" stuff.
> 
> Why would you want to run before the "automatic" stuff? The incentive
> in my case is that I want to be able to fill in some boolean flags in
> the "struct device" before the IOMMU init runs. It appears that the
> strictness vs. non-strictness of a device's iommu config is determined
> once at init time and can't be changed afterwards. However, I would
> like to avoid hardcoding the rules for strictness in the IOMMU
> driver. Instead I'd like to let individual drivers be able to make
> informed decisions about the appropriateness of strictness
> vs. non-strictness.
> 
> The desire for running code pre_probe is likely not limited to my use
> case. I believe that the list "qcom_smmu_client_of_match" is hacked
> into the iommu driver specifically because there was no real good
> framework for this. For the existing list it wasn't _quite_ as ugly as
> my needs since the decision could be made solely on compatible string,
> but it still feels like it would have been better for individual
> drivers to run code and setup some state rather than coding up a big
> list in the IOMMU driver.
> 
> Even without this patch, I believe it is possible for a driver to run
> before the "automatic" things by registering for
> "BUS_NOTIFY_BIND_DRIVER" in its init call, though I haven't personally
> tested this. Using the notifier is a bit awkward, though, and I'd
> rather avoid it. Also, using "BUS_NOTIFY_BIND_DRIVER" would require
> drivers to stop using the convenience module_platform_driver() helper
> and roll a bunch of boilerplate code.
> 
> NOTE: the pre_probe here is listed in the driver structure. As a side
> effect of this it will be passed a "struct device *" rather than the
> more specific device type (like the "struct platform_device *" that
> most platform devices get passed to their probe). Presumably this
> won't cause trouble and it's a lot less code to write but if we need
> to make it more symmetric that's also possible by touching more files.

No, please please no.

If a bus really wants to do crud like this, it can do it in it's own
probe callback, the driver core doesn't need to mess with this.

If you need to mess with iommu values in struct device, again, do that
in the bus core for the devices on that specific bus, that's where those
values are supposed to be set anyway, right?

If the iommu drivers need to be run before a specific bus is
initialized, then fix that there, the driver core does not need to care
about this at all.

so a big NACK on this one, sorry.

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
