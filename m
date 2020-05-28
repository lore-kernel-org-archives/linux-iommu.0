Return-Path: <SRS0=4TkS=7K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6014BC433DF
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 16:33:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2025B20829
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 16:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2025B20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E2C5187DDD;
	Thu, 28 May 2020 16:33:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nf6b7adRokAW; Thu, 28 May 2020 16:33:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6573387AC5;
	Thu, 28 May 2020 16:33:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F7AFC088D;
	Thu, 28 May 2020 16:33:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57C40C016F
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 16:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 46B4087D56
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 16:33:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hwSf7AMV7Yrd for <iommu@lists.linux-foundation.org>;
 Thu, 28 May 2020 16:33:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3735787AC5
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 16:33:20 +0000 (UTC)
IronPort-SDR: laAP8v0KQM91jSGaz3K3ve+7Vj9DiXs7GWRzQDAZ8rC0Q9GKXt77BfmzTldH5bF4fnyT8oAmh0
 ro7ydVRVaOsA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 09:33:15 -0700
IronPort-SDR: g+sBksrbZ/XPPBDhZNXgLL2wNxU+emyH9f97Pnz6m4VoyQfhHez3cx0vTlXK0xPEnkI0Os675G
 e4jdi87hHCwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; d="scan'208";a="310974192"
Received: from ssp-nc-cdi361.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
 by FMSMGA003.fm.intel.com with ESMTP; 28 May 2020 09:33:15 -0700
Date: Thu, 28 May 2020 09:33:15 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] iommu: Relax ACS requirement for Intel RCiEP devices.
Message-ID: <20200528163315.GA6461@otc-nc-03>
References: <1590531455-19757-1-git-send-email-ashok.raj@intel.com>
 <20200526170715.18c0ee98@x1.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200526170715.18c0ee98@x1.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Ashok Raj <ashok.raj@intel.com>, Darrel Goeddel <DGoeddel@forcepoint.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Mark Scott <mscott@forcepoint.com>,
 Romil Sharma <rsharma@forcepoint.com>, Bjorn Helgaas <bhelgaas@google.com>
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

Hi Alex

On Tue, May 26, 2020 at 05:07:15PM -0600, Alex Williamson wrote:
> > ---
> >  drivers/iommu/iommu.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 2b471419e26c..31b595dfedde 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1187,7 +1187,18 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
> >  	struct pci_dev *tmp = NULL;
> >  	struct iommu_group *group;
> >  
> > -	if (!pdev->multifunction || pci_acs_enabled(pdev, REQ_ACS_FLAGS))
> > +	/*
> > +	 * Intel VT-d Specification Section 3.16, Root-Complex Peer to Peer
> > +	 * Considerations manadate that all transactions in RCiEP's and
> > +	 * even Integrated MFD's *must* be sent up to the IOMMU. P2P is
> > +	 * only possible on translated addresses. This gives enough
> > +	 * guarantee that such devices can be forgiven for lack of ACS
> > +	 * support.
> > +	 */
> > +	if (!pdev->multifunction ||
> > +	    (pdev->vendor == PCI_VENDOR_ID_INTEL &&
> > +	     pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END) ||
> > +	     pci_acs_enabled(pdev, REQ_ACS_FLAGS))
> >  		return NULL;
> >  
> >  	for_each_pci_dev(tmp) {
> 
> Hi Ashok,
> 
> As this is an Intel/VT-d standard, not a PCIe standard, why not
> implement this in pci_dev_specific_acs_enabled() with all the other
> quirks?  Thanks,

Yes, that sounds like the right place.. I have a new patch, once its tested
i'll resend it. Thanks for pointing it out.

Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
