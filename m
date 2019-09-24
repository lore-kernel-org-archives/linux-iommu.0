Return-Path: <SRS0=VpBQ=XT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3656C432C2
	for <iommu@archiver.kernel.org>; Tue, 24 Sep 2019 12:17:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B388E214AF
	for <iommu@archiver.kernel.org>; Tue, 24 Sep 2019 12:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B388E214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A4626CD1;
	Tue, 24 Sep 2019 12:17:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id ABAA4C90
	for <iommu@lists.linux-foundation.org>;
	Tue, 24 Sep 2019 12:17:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 49043102
	for <iommu@lists.linux-foundation.org>;
	Tue, 24 Sep 2019 12:17:02 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 Sep 2019 05:17:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,544,1559545200"; d="scan'208";a="203368825"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
	by fmsmga001.fm.intel.com with ESMTP; 24 Sep 2019 05:16:58 -0700
Received: from andy by smile with local (Exim 4.92.1)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1iCjkW-0001ct-P5; Tue, 24 Sep 2019 15:16:56 +0300
Date: Tue, 24 Sep 2019 15:16:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 5/5] iommu/amd: Switch to use acpi_dev_hid_uid_match()
Message-ID: <20190924121656.GV2680@smile.fi.intel.com>
References: <20190924120153.8382-1-andriy.shevchenko@linux.intel.com>
	<20190924120153.8382-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190924120153.8382-5-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Tue, Sep 24, 2019 at 03:01:53PM +0300, Andy Shevchenko wrote:
> Since we have a generic helper, drop custom implementation in the driver.

Actually we may get rid of match_hid_uid() completely and thus slightly speed
up get_acpihid_device_id().

I'll wait for other comments and then send v2.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iommu/amd_iommu.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 61de81965c44..bad1bcea4ea1 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -129,24 +129,11 @@ static inline int match_hid_uid(struct device *dev,
>  				struct acpihid_map_entry *entry)
>  {
>  	struct acpi_device *adev = ACPI_COMPANION(dev);
> -	const char *hid, *uid;
>  
>  	if (!adev)
>  		return -ENODEV;
>  
> -	hid = acpi_device_hid(adev);
> -	uid = acpi_device_uid(adev);
> -
> -	if (!hid || !(*hid))
> -		return -ENODEV;
> -
> -	if (!uid || !(*uid))
> -		return strcmp(hid, entry->hid);
> -
> -	if (!(*entry->uid))
> -		return strcmp(hid, entry->hid);
> -
> -	return (strcmp(hid, entry->hid) || strcmp(uid, entry->uid));
> +	return acpi_dev_hid_uid_match(adev, entry->hid, entry->uid) ? 0 : -ENODEV;
>  }
>  
>  static inline u16 get_pci_device_id(struct device *dev)
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
