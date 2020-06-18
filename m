Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560A8C433DF
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:37:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09296206FA
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 15:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09296206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B1E2F88743;
	Thu, 18 Jun 2020 15:37:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p9jSQ93c6dRI; Thu, 18 Jun 2020 15:37:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8919A88700;
	Thu, 18 Jun 2020 15:37:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B646C088C;
	Thu, 18 Jun 2020 15:37:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73C70C016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:37:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 58D7C88743
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:37:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JBZHv-xE3hsj for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 15:37:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A283888700
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 15:37:48 +0000 (UTC)
IronPort-SDR: sWj0NA3jTTXQgYPB/ghVYSFXKn3r8Szi7z/Lryox4JL/y+6YdD1DZtfuRBc5JBljHJAE38CGeC
 4TTCeVUU3m+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="129979309"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; d="scan'208";a="129979309"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 08:37:47 -0700
IronPort-SDR: CzS5MoOz9LW2W8ufcf7VltJ40EwQvdPZ9f1UIByPKyXcF7fjAaxqMgTRiN1ED9CIyfAtjpBrfb
 JU43hSx3nDnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; d="scan'208";a="291807299"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
 by orsmga002.jf.intel.com with ESMTP; 18 Jun 2020 08:37:47 -0700
Date: Thu, 18 Jun 2020 08:37:47 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>
Subject: Re: [PATCH v2 02/12] ocxl: Change type of pasid to unsigned int
Message-ID: <20200618153747.GE15763@romley-ivt3.sc.intel.com>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-3-git-send-email-fenghua.yu@intel.com>
 <972dc2cb-9643-53af-b11d-ebb56d96053d@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <972dc2cb-9643-53af-b11d-ebb56d96053d@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: Dave Hansen <dave.hansen@intel.com>, H Peter Anvin <hpa@zytor.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, amd-gfx <amd-gfx@lists.freedesktop.org>,
 Ingo Molnar <mingo@redhat.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Yu-cheng Yu <yu-cheng.yu@intel.com>, Andrew Donnellan <ajd@linux.ibm.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Tony Luck <tony.luck@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Jun Pan <jacob.jun.pan@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi, Frederic,

On Thu, Jun 18, 2020 at 10:05:19AM +0200, Frederic Barrat wrote:
> =

> =

> Le 13/06/2020 =E0 02:41, Fenghua Yu a =E9crit=A0:
> >PASID is defined as "int" although it's a 20-bit value and shouldn't be
> >negative int. To be consistent with type defined in iommu, define PASID
> >as "unsigned int".
> =

> =

> It looks like this patch was considered because of the use of 'pasid' in
> variable or function names. The ocxl driver only makes sense on powerpc a=
nd
> shouldn't compile on anything else, so it's probably useless in the conte=
xt
> of that series.
> The pasid here is defined by the opencapi specification
> (https://opencapi.org), it is borrowed from the PCI world and you could
> argue it could be an unsigned int. But then I think the patch doesn't go =
far
> enough. But considering it's not used on x86, I think this patch can be
> dropped.

The first 3 patches clean up pasid and flag defitions to prepare for
following patches.

If you think this patch can be dropped, we will drop it.

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
