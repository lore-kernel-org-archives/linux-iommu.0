Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7357DC2B9F4
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 11:35:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EDA6613AD
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 11:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDA6613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC79F606DD;
	Tue, 22 Jun 2021 11:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00L_aq61zsEw; Tue, 22 Jun 2021 11:35:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8C36860604;
	Tue, 22 Jun 2021 11:35:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F072C0010;
	Tue, 22 Jun 2021 11:35:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DCE3C000E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 11:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05C51836CE
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 11:35:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7xDNWR4jhjFl for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 11:35:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0950A834BA
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 11:35:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F11DF31B;
 Tue, 22 Jun 2021 04:35:39 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFDAF3F694;
 Tue, 22 Jun 2021 04:35:35 -0700 (PDT)
Subject: Re: [PATCH 0/6] iommu: Enable devices to request non-strict DMA,
 starting with QCom SD/MMC
To: Douglas Anderson <dianders@chromium.org>, gregkh@linuxfoundation.org,
 rafael@kernel.org, rafael.j.wysocki@intel.com, will@kernel.org,
 joro@8bytes.org, bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
 adrian.hunter@intel.com, bhelgaas@google.com
References: <20210621235248.2521620-1-dianders@chromium.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <067dd86d-da7f-ac83-6ce6-b8fd5aba0b6f@arm.com>
Date: Tue, 22 Jun 2021 12:35:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210621235248.2521620-1-dianders@chromium.org>
Content-Language: en-GB
Cc: robdclark@chromium.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 saravanak@google.com, linux-arm-msm@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, linux-mmc@vger.kernel.org,
 quic_c_gdjako@quicinc.com, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-pci@vger.kernel.org,
 joel@joelfernandes.org, Dan Williams <dan.j.williams@intel.com>,
 rajatja@google.com, sonnyrao@chromium.org, vbadigan@codeaurora.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Doug,

On 2021-06-22 00:52, Douglas Anderson wrote:
> 
> This patch attempts to put forward a proposal for enabling non-strict
> DMA on a device-by-device basis. The patch series requests non-strict
> DMA for the Qualcomm SDHCI controller as a first device to enable,
> getting a nice bump in performance with what's believed to be a very
> small drop in security / safety (see the patch for the full argument).
> 
> As part of this patch series I am end up slightly cleaning up some of
> the interactions between the PCI subsystem and the IOMMU subsystem but
> I don't go all the way to fully remove all the tentacles. Specifically
> this patch series only concerns itself with a single aspect: strict
> vs. non-strict mode for the IOMMU. I'm hoping that this will be easier
> to talk about / reason about for more subsystems compared to overall
> deciding what it means for a device to be "external" or "untrusted".
> 
> If something like this patch series ends up being landable, it will
> undoubtedly need coordination between many maintainers to land. I
> believe it's fully bisectable but later patches in the series
> definitely depend on earlier ones. Sorry for the long CC list. :(

Unfortunately, this doesn't work. In normal operation, the default 
domains should be established long before individual drivers are even 
loaded (if they are modules), let alone anywhere near probing. The fact 
that iommu_probe_device() sometimes gets called far too late off the 
back of driver probe is an unfortunate artefact of the original 
probe-deferral scheme, and causes other problems like potentially 
malformed groups - I've been forming a plan to fix that for a while now, 
so I for one really can't condone anything trying to rely on it. 
Non-deterministic behaviour based on driver probe order for multi-device 
groups is part of the existing problem, and your proposal seems equally 
vulnerable to that too.

FWIW we already have a go-faster knob for people who want to tweak the 
security/performance compromise for specific devices, namely the sysfs 
interface for changing a group's domain type before binding the relevant 
driver(s). Is that something you could use in your application, say from 
an initramfs script?

Thanks,
Robin.

> Douglas Anderson (6):
>    drivers: base: Add the concept of "pre_probe" to drivers
>    drivers: base: Add bits to struct device to control iommu strictness
>    PCI: Indicate that we want to force strict DMA for untrusted devices
>    iommu: Combine device strictness requests with the global default
>    iommu: Stop reaching into PCIe devices to decide strict vs. non-strict
>    mmc: sdhci-msm: Request non-strict IOMMU mode
> 
>   drivers/base/dd.c             | 10 +++++--
>   drivers/iommu/dma-iommu.c     |  2 +-
>   drivers/iommu/iommu.c         | 56 +++++++++++++++++++++++++++--------
>   drivers/mmc/host/sdhci-msm.c  |  8 +++++
>   drivers/pci/probe.c           |  4 ++-
>   include/linux/device.h        | 11 +++++++
>   include/linux/device/driver.h |  9 ++++++
>   include/linux/iommu.h         |  2 ++
>   8 files changed, 85 insertions(+), 17 deletions(-)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
