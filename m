Return-Path: <SRS0=AgN4=X4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EA5C4CED1
	for <iommu@archiver.kernel.org>; Thu,  3 Oct 2019 10:01:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FE592133F
	for <iommu@archiver.kernel.org>; Thu,  3 Oct 2019 10:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2WgVKBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE592133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EDBB513D3;
	Thu,  3 Oct 2019 10:01:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2DD5313D1
	for <iommu@lists.linux-foundation.org>;
	Thu,  3 Oct 2019 10:01:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ua1-f67.google.com (mail-ua1-f67.google.com
	[209.85.222.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9752D89D
	for <iommu@lists.linux-foundation.org>;
	Thu,  3 Oct 2019 10:01:06 +0000 (UTC)
Received: by mail-ua1-f67.google.com with SMTP id j5so678289uak.12
	for <iommu@lists.linux-foundation.org>;
	Thu, 03 Oct 2019 03:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ML7iGjCkdk3T2RUYqxLIiWX6QK9V+cTAyo+lZTGYhEg=;
	b=k2WgVKBMUG6BnJ7WwXT6WneVf49y81sfCSZmPfn4mNlx3geInIen0RP3hPUbg/jkXm
	epQR2qrp2xxsefUoDIQx0BIsoTQSx1xF8K6pwuCU2c1EuO+oj9oEnidz3dFC+VBQiAZl
	aI3o8KTvSSY4rBGL0vRHcaeBVAGFJvxRjkE4XaDcYcQY+spQepqqgLhBsdGOay95Jv+L
	/a7aiJFJJvZxf2Wtj5WsgPLsmo06HHbLfQs7Q+fAnVNxDh0Yb8kBeK9jVAIqZrBVYTjQ
	JevdRziG3ApzhBJ/oTGw35uFFzHKk6Mz7Ui0nPUgahL3ZOUPwx95+jf3h7Bw2zj95+Dp
	4wzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ML7iGjCkdk3T2RUYqxLIiWX6QK9V+cTAyo+lZTGYhEg=;
	b=Q9EMhtE9g2/DD4Id5HGATXoPf+17zCDjcL4N2TbQ2kB7BKUztG9I7ZrKyDejmNldWJ
	L+cnwVbp9hM5a59mtAsA3mL4DlkPABR8y2z5tliJPRQo3s5qPpTP3wXkB/RjH/KhMUt+
	LDmdH4gO/deneDGixwXrOB7ZE6oeFAGbxmNGaOA0034spESDKYysRDkeZnHpF1H3K4g8
	uvFzerBTg3+WIRa2nJANu/rKjEbSEdGZa6pS6AZxtgbIKuoUqITpYikC+7apsGZ9RjxB
	PuT1hU7vfQEI/vaWJ8J83fBN6/dmXL2bDFkXDN7cVWhdBIls9C3MGyyHXZH1UnAroLlR
	D2mA==
X-Gm-Message-State: APjAAAVsC1fx1C0nUDi1maGMtug+lYbk+s+rOFQxR5ES2G3W5Kk+Mlax
	xEICg/7f19p1CEtmEBHwzzP28h4SUfDIYIW8H2XZOg==
X-Google-Smtp-Source: APXvYqxdtcpDHsTAYowYb9631c0RBuYsoH8cHEL10avvjnLuGotCXrQZLi8185Qxw90DxHswtjDxgdlZmu0frmN+y+M=
X-Received: by 2002:ab0:1856:: with SMTP id j22mr4554523uag.19.1570096865564; 
	Thu, 03 Oct 2019 03:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191001142725.30857-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20191001142725.30857-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Oct 2019 12:00:29 +0200
Message-ID: <CAPDyKFq_HPDW5i5ND_df4GJsnaOowHWbFTkgCCOP6w9ar2uo6w@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] ACPI / utils: add new helper for HID/UID match
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Adrian Hunter <adrian.hunter@intel.com>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
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

On Tue, 1 Oct 2019 at 16:27, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
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
> --
> 2.23.0
>

I guess Rafael intend to pick this up for v5.5?

In any case, for the mmc patch, feel free to add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
