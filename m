Return-Path: <SRS0=QcZA=YE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B36C47404
	for <iommu@archiver.kernel.org>; Fri, 11 Oct 2019 09:25:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03012196E
	for <iommu@archiver.kernel.org>; Fri, 11 Oct 2019 09:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03012196E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9D5FA13EF;
	Fri, 11 Oct 2019 09:25:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 55D8513E1
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 09:16:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
	[79.96.170.134])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B3D7A5D3
	for <iommu@lists.linux-foundation.org>;
	Fri, 11 Oct 2019 09:16:46 +0000 (UTC)
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO
	kreacher.localnet)
	by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer
	0.83.292) id 2945faddd0b39e2b; Fri, 11 Oct 2019 11:16:43 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/6] ACPI / utils: add new helper for HID/UID match
Date: Fri, 11 Oct 2019 11:16:43 +0200
Message-ID: <6926760.z8q4ev7VEa@kreacher>
In-Reply-To: <20191001142725.30857-1-andriy.shevchenko@linux.intel.com>
References: <20191001142725.30857-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
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

On Tuesday, October 1, 2019 4:27:19 PM CEST Andy Shevchenko wrote:
> There are few users outside of ACPI realm that re-introduce a custom
> solution to match ACPI device against HID/UID. Add a generic helper for
> them.
> 
> The series is supposed to go via linux-pm tree.
> 
> In v3:
> - correct logic in sdhci-acpi for qcom devices (Adrian)
> - add Mika's Ack
> 
> In v2:
> - add patch 2 due to latent issue in the header (lkp)
> - get rid of match_hid_uid() completely in patch 6
> 
> Andy Shevchenko (6):
>   ACPI / utils: Describe function parameters in kernel-doc
>   ACPI / utils: Move acpi_dev_get_first_match_dev() under CONFIG_ACPI
>   ACPI / utils: Introduce acpi_dev_hid_uid_match() helper
>   ACPI / LPSS: Switch to use acpi_dev_hid_uid_match()
>   mmc: sdhci-acpi: Switch to use acpi_dev_hid_uid_match()
>   iommu/amd: Switch to use acpi_dev_hid_uid_match()
> 
>  drivers/acpi/acpi_lpss.c      | 21 +++------------
>  drivers/acpi/utils.c          | 32 +++++++++++++++++++++++
>  drivers/iommu/amd_iommu.c     | 30 ++++-----------------
>  drivers/mmc/host/sdhci-acpi.c | 49 ++++++++++++-----------------------
>  include/acpi/acpi_bus.h       |  8 +++---
>  include/linux/acpi.h          |  6 +++++
>  6 files changed, 67 insertions(+), 79 deletions(-)
> 
> 

Applying the series (with the tags given so far) as 5.5 material, thanks!




_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
