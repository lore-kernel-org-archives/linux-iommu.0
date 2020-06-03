Return-Path: <SRS0=U3VV=7Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF856C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 14:55:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7658520738
	for <iommu@archiver.kernel.org>; Wed,  3 Jun 2020 14:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7658520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3065887AC8;
	Wed,  3 Jun 2020 14:55:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UBd40kiXkX6l; Wed,  3 Jun 2020 14:55:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4EF17879E1;
	Wed,  3 Jun 2020 14:54:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CF61C0178;
	Wed,  3 Jun 2020 14:54:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E389CC016E
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 14:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CBAE684B46
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 14:54:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mgKgAz9OqdON for <iommu@lists.linux-foundation.org>;
 Wed,  3 Jun 2020 14:54:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0424A84ABB
 for <iommu@lists.linux-foundation.org>; Wed,  3 Jun 2020 14:54:54 +0000 (UTC)
IronPort-SDR: nmOogt8UE/9bFBUM4mUaxen+Ke4rNIdrSsl4+AbDkknoqKgKB0CLHnobTR8C58TLUM1/eG2KSF
 /7+a7+Jf/Dlw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2020 07:54:54 -0700
IronPort-SDR: Na/zi5dWpOxM01SPF1+rbTUPlBzY0vjHthSG6Ni6xBFD3i9x1SJi0Ajc5fM/USa4TUtX5uaSRy
 xDQzcNFyX0iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; d="scan'208";a="378127274"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
 by fmsmga001.fm.intel.com with SMTP; 03 Jun 2020 07:54:49 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 03 Jun 2020 17:54:48 +0300
Date: Wed, 3 Jun 2020 17:54:48 +0300
From: Mika Westerberg <mika.westerberg@intel.com>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] iommu/vt-d: Don't apply gfx quirks to untrusted devices
Message-ID: <20200603145448.GU247495@lahna.fi.intel.com>
References: <20200603130317.94672-1-rajatja@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200603130317.94672-1-rajatja@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: tbroch@google.com, pmalani@google.com, Ashok Raj <ashok.raj@intel.com>,
 rajatxjain@gmail.com, zsm@google.com, linux-kernel@vger.kernel.org,
 lalithambika.krishnakumar@intel.com, iommu@lists.linux-foundation.org,
 mnissler@google.com, bleung@google.com, levinale@google.com,
 David Woodhouse <dwmw2@infradead.org>
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

On Wed, Jun 03, 2020 at 06:03:17AM -0700, Rajat Jain wrote:
> Currently, an external malicious PCI device can masquerade the VID:PID
> of faulty gfx devices, and thus apply iommu quirks to effectively
> disable the IOMMU restrictions for itself.
> 
> Thus we need to ensure that the device we are applying quirks to, is
> indeed an internal trusted device.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>

Looks good now, thanks!

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
