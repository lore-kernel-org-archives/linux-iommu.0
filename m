Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079A6C49EA6
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 13:43:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E6F613F3
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 13:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E6F613F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5E8583CCA;
	Thu, 24 Jun 2021 13:43:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GB9Sqbss3zRn; Thu, 24 Jun 2021 13:43:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9BB3B83B5C;
	Thu, 24 Jun 2021 13:43:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7867FC001A;
	Thu, 24 Jun 2021 13:43:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD0A8C000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:43:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ABC9E83CCA
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:43:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qCp9njDWsJo6 for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 13:43:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 12E9F83B5C
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 13:43:28 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3206861057;
 Thu, 24 Jun 2021 13:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1624542208;
 bh=hRckpi5VkGxaL5vSwwKHDFfALYzxZOvFQpIv1uvauvM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eR3j4tJEMffYTFhMXxw8pGFP6btHuKW2ZhmD8KKSMaMEzBtVCdpcqPosqKFjRmEVd
 LXyeDZI72LtPpFTuZvyvtgeaqF9kS2ljg9CnXKPOLkIEsFKADjtBzZqvasU41av9VU
 IiIbZy9TQkz1lTNN8seLd6Wv7OoDi4t//kz/qBKY=
Date: Thu, 24 Jun 2021 15:43:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 6/6] mmc: sdhci-msm: Request non-strict IOMMU mode
Message-ID: <YNSL/r+fOz6KMuwI@kroah.com>
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.6.Icde6be7601a5939960caf802056c88cd5132eb4e@changeid>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210621165230.6.Icde6be7601a5939960caf802056c88cd5132eb4e@changeid>
Cc: ulf.hansson@linaro.org, rafael@kernel.org, linux-pci@vger.kernel.org,
 joel@joelfernandes.org, rajatja@google.com, will@kernel.org,
 robdclark@chromium.org, saravanak@google.com, rafael.j.wysocki@intel.com,
 quic_c_gdjako@quicinc.com, Andy Gross <agross@kernel.org>,
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

On Mon, Jun 21, 2021 at 04:52:48PM -0700, Douglas Anderson wrote:
> IOMMUs can be run in "strict" mode or in "non-strict" mode. The
> quick-summary difference between the two is that in "strict" mode we
> wait until everything is flushed out when we unmap DMA memory. In
> "non-strict" we don't.
> 
> Using the IOMMU in "strict" mode is more secure/safer but slower
> because we have to sit and wait for flushes while we're unmapping. To
> explain a bit why "non-strict" mode is unsafe, let's imagine two
> examples.
> 
> An example of "non-strict" being insecure when reading from a device:
> a) Linux driver maps memory for DMA.
> b) Linux driver starts DMA on the device.
> c) Device write to RAM subject to bounds checking done by IOMMU.
> d) Device finishes writing to RAM and signals transfer is finished.
> e) Linux driver starts unmapping DMA memory but doesn't flush.

Why doesn't it "flush"?

> f) Linux driver validates that the data in memory looks sane and that
>    accessing it won't cause the driver to, for instance, overflow a
>    buffer.
> g) Device takes advantage of knowledge of how the Linux driver works
>    and sneaks in a modification to the data after the validation but
>    before the IOMMU unmap flush finishes.
> h) Device has now caused the Linux driver to access memory it
>    shouldn't.

So you are now saying we need to not trust hardware?  If so, that's a
massive switch for how the kernel needs to work right?

And what driver does f) and allows g) to happen?  That would be a normal
bug anyway, why not just fix the driver?

> An example of "non-strict" being insecure when writing to a device:
> a) Linux driver writes data intended for the device to RAM.
> b) Linux driver maps memory for DMA.
> c) Linux driver starts DMA on the device.
> d) Device reads from RAM subject to bounds checking done by IOMMU.
> e) Device finishes reading from RAM and signals transfer is finished.
> f) Linux driver starts unmapping DMA memory but doesn't flush.

Why does it not flush?

What do you mean by "flush"

> g) Linux driver frees memory and returns it to the pool.

What pool?

> h) Memory is allocated for another purpose.

Allocated by what?

We have memory allocators that write over the data when freed, why not
just use this if you are concerned about this type of issue?

> i) Device takes advantage of the period of time before IOMMU flush to
>    read memory that it shouldn't have had access to.

What memory would that be?

And if you really care about these issues, are you not able to take the
"hit" for the flush all the time as that is a hardware thing, not a
software thing.  Why not just always take advantage of that, no driver
changes needed?

And this isn't going to work, again, because the "pre_probe" isn't going
to be acceptable, sorry.

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
