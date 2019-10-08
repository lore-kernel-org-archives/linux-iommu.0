Return-Path: <SRS0=3Hvu=YB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38E9C4360C
	for <iommu@archiver.kernel.org>; Tue,  8 Oct 2019 13:54:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F53206BB
	for <iommu@archiver.kernel.org>; Tue,  8 Oct 2019 13:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F53206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 525B4FE2;
	Tue,  8 Oct 2019 13:54:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8A7BFFE0
	for <iommu@lists.linux-foundation.org>;
	Tue,  8 Oct 2019 13:54:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8F4C68AC
	for <iommu@lists.linux-foundation.org>;
	Tue,  8 Oct 2019 13:54:52 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 Oct 2019 06:54:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; d="scan'208";a="192580434"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
	by fmsmga008.fm.intel.com with ESMTP; 08 Oct 2019 06:54:50 -0700
Received: from andy by smile with local (Exim 4.92.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1iHpwv-0002BP-9u; Tue, 08 Oct 2019 16:54:49 +0300
Date: Tue, 8 Oct 2019 16:54:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 6/6] iommu/amd: Switch to use acpi_dev_hid_uid_match()
Message-ID: <20191008135449.GK32742@smile.fi.intel.com>
References: <20190924193739.86133-1-andriy.shevchenko@linux.intel.com>
	<20190924193739.86133-7-andriy.shevchenko@linux.intel.com>
	<20191007152848.GA20456@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191007152848.GA20456@8bytes.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Adrian Hunter <adrian.hunter@intel.com>,
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

On Mon, Oct 07, 2019 at 05:28:48PM +0200, Joerg Roedel wrote:
> On Tue, Sep 24, 2019 at 10:37:39PM +0300, Andy Shevchenko wrote:
> > Since we have a generic helper, drop custom implementation in the driver.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/iommu/amd_iommu.c | 30 +++++-------------------------
> >  1 file changed, 5 insertions(+), 25 deletions(-)
> 
> Acked-by: Joerg Roedel <jroedel@suse.de>

Thanks!
There is v3 available, does it apply to it?

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
