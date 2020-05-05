Return-Path: <SRS0=kPPe=6T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B66DC47254
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 14:56:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05570206B9
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 14:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05570206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C3BC2878EE;
	Tue,  5 May 2020 14:56:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Etc63Ni1sgcT; Tue,  5 May 2020 14:56:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1106886DF0;
	Tue,  5 May 2020 14:56:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF59BC0859;
	Tue,  5 May 2020 14:56:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B5D4C0175
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 14:56:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1D40424AF5
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 14:56:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZK5ql+ATDWlN for <iommu@lists.linux-foundation.org>;
 Tue,  5 May 2020 14:56:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id 9A6FD2413D
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 14:56:07 +0000 (UTC)
IronPort-SDR: SwVDGJ4YYkuMrqaXQh383dk3qew1vOG39cbFQIHtkLSmYCpvk6YhMBb2hkNn9GZOI4jGdoXiWu
 ucMjfkIQ72Ag==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2020 07:56:06 -0700
IronPort-SDR: 3Dvi1ejqJAT0ii4H3bhyjVLjuLdN2tBgeX+c/L56IS1TSdvC0/Ceit4FGYGFx4NJGifMt8HDih
 CO6rC90DOOqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; d="scan'208";a="250919303"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
 by fmsmga008.fm.intel.com with ESMTP; 05 May 2020 07:56:06 -0700
Date: Tue, 5 May 2020 07:56:06 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] iommu: Relax ACS requirement for RCiEP devices.
Message-ID: <20200505145605.GA13690@otc-nc-03>
References: <1588653736-10835-1-git-send-email-ashok.raj@intel.com>
 <20200504231936.2bc07fe3@x1.home>
 <20200505061107.GA22974@araj-mobl1.jf.intel.com>
 <20200505080514.01153835@x1.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200505080514.01153835@x1.home>
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

On Tue, May 05, 2020 at 08:05:14AM -0600, Alex Williamson wrote:
> On Mon, 4 May 2020 23:11:07 -0700
> "Raj, Ashok" <ashok.raj@intel.com> wrote:
> 
> > Hi Alex
> > 
> > + Joerg, accidently missed in the Cc.
> > 
> > On Mon, May 04, 2020 at 11:19:36PM -0600, Alex Williamson wrote:
> > > On Mon,  4 May 2020 21:42:16 -0700
> > > Ashok Raj <ashok.raj@intel.com> wrote:
> > >   
> > > > PCIe Spec recommends we can relax ACS requirement for RCIEP devices.
> > > > 
> > > > PCIe 5.0 Specification.
> > > > 6.12 Access Control Services (ACS)
> > > > Implementation of ACS in RCiEPs is permitted but not required. It is
> > > > explicitly permitted that, within a single Root Complex, some RCiEPs
> > > > implement ACS and some do not. It is strongly recommended that Root Complex
> > > > implementations ensure that all accesses originating from RCiEPs
> > > > (PFs and VFs) without ACS capability are first subjected to processing by
> > > > the Translation Agent (TA) in the Root Complex before further decoding and
> > > > processing. The details of such Root Complex handling are outside the scope
> > > > of this specification.
> > > > 
> > > 
> > > Is the language here really strong enough to make this change?  ACS is
> > > an optional feature, so being permitted but not required is rather
> > > meaningless.  The spec is also specifically avoiding the words "must"
> > > or "shall" and even when emphasized with "strongly", we still only have
> > > a recommendation that may or may not be honored.  This seems like a
> > > weak basis for assuming that RCiEPs universally honor this
> > > recommendation.  Thanks,
> > >   
> > 
> > We are speaking about PCIe spec, where people write it about 5 years ahead
> > and every vendor tries to massage their product behavior with vague
> > words like this..  :)
> > 
> > But honestly for any any RCiEP, or even integrated endpoints, there 
> > is no way to send them except up north. These aren't behind a RP.
> 
> But they are multi-function devices and the spec doesn't define routing
> within multifunction packages.  A single function RCiEP will already be
> assumed isolated within its own group.

That's right. The other two devices only have legacy PCI headers. So 
they can't claim to be RCiEP's but just integrated endpoints. The legacy
devices don't even have a PCIe header.

I honestly don't know why these are groped as MFD's in the first place.

>  
> > I did check with couple folks who are part of the SIG, and seem to agree
> > that ACS treatment for RCiEP's doesn't mean much. 
> > 
> > I understand the language isn't strong, but it doesn't seem like ACS should
> > be a strong requirement for RCiEP's and reasonable to relax.
> > 
> > What are your thoughts? 
> 
> I think hardware vendors have ACS at their disposal to clarify when
> isolation is provided, otherwise vendors can submit quirks, but I don't
> see that the "strongly recommended" phrasing is sufficient to assume
> isolation between multifunction RCiEPs.  Thanks,

You point is that integrated MFD endpoints, without ACS, there is no 
gaurantee to SW that they are isolated.

As far as a quirk, do you think:
	- a cmdline optput for integrated endpoints, and RCiEP's suffice?
	  along with a compile time default that is strict enforcement
	- typical vid/did type exception list?

A more generic way to ask for exception would be scalable until we can stop
those type of integrated devices. Or we need to maintain these device lists
for eternity. 

Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
