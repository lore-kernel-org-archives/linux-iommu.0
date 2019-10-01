Return-Path: <SRS0=VD3v=X2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65478ECE587
	for <iommu@archiver.kernel.org>; Tue,  1 Oct 2019 13:05:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408DF205C9
	for <iommu@archiver.kernel.org>; Tue,  1 Oct 2019 13:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408DF205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0B8F4117C;
	Tue,  1 Oct 2019 13:05:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CA6DE1172
	for <iommu@lists.linux-foundation.org>;
	Tue,  1 Oct 2019 13:04:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 75C5F8B1
	for <iommu@lists.linux-foundation.org>;
	Tue,  1 Oct 2019 13:04:49 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	01 Oct 2019 06:04:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; d="scan'208";a="203225613"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
	by orsmga002.jf.intel.com with ESMTP; 01 Oct 2019 06:04:44 -0700
Received: from andy by smile with local (Exim 4.92.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1iFHpb-0000ZP-1D; Tue, 01 Oct 2019 16:04:43 +0300
Date: Tue, 1 Oct 2019 16:04:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 5/6] mmc: sdhci-acpi: Switch to use
	acpi_dev_hid_uid_match()
Message-ID: <20191001130443.GN32742@smile.fi.intel.com>
References: <20190924193739.86133-1-andriy.shevchenko@linux.intel.com>
	<20190924193739.86133-6-andriy.shevchenko@linux.intel.com>
	<77ce4e34-6692-e54e-0f2f-6b8829d1e9f5@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <77ce4e34-6692-e54e-0f2f-6b8829d1e9f5@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org
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

On Tue, Oct 01, 2019 at 03:37:08PM +0300, Adrian Hunter wrote:
> On 24/09/19 10:37 PM, Andy Shevchenko wrote:
> > Since we have a generic helper, drop custom implementation in the driver.

> > -	if (strcmp(hid, "QCOM8051"))
> > +	if (acpi_dev_hid_uid_match(adev, "QCOM8051", NULL))
> 
> Logic is inverted

Good catch! I forgot to double check it here while below it's okay...

> > -	if (strcmp(hid, "QCOM8051"))
> > +	if (!acpi_dev_hid_uid_match(adev, "QCOM8051", NULL))

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
