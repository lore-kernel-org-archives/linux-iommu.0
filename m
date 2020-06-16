Return-Path: <SRS0=6LHv=75=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD29C433DF
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 17:00:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01E720663
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 17:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01E720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8AF50878B9;
	Tue, 16 Jun 2020 17:00:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Nmz855g5DXe; Tue, 16 Jun 2020 17:00:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EAB9E87895;
	Tue, 16 Jun 2020 17:00:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D84C7C07FF;
	Tue, 16 Jun 2020 17:00:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37DA7C016E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 17:00:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 33564878A7
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 17:00:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h0jsdgUOf_ja for <iommu@lists.linux-foundation.org>;
 Tue, 16 Jun 2020 17:00:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5BAF887895
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 17:00:29 +0000 (UTC)
IronPort-SDR: KxaWE7CdHXhII5lM0Dtvn3QpwvZB9KKnTh3vjMWX9wBAOv8viSWWv7O5s7QW5KWMZXyxI75BbX
 EkzRY2C8VfNQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2020 10:00:17 -0700
IronPort-SDR: shXlJDB6Aa2I7qVQkpqzSISC/9/CbPOu9n9L7Pl4JZVPZQbC2aORL/Zi3VEf3kIBSNnoifV9z0
 o0yzMkUEcJDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; d="scan'208";a="273217899"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
 by orsmga003.jf.intel.com with ESMTP; 16 Jun 2020 10:00:16 -0700
Date: Tue, 16 Jun 2020 10:00:16 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v2 00/15] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200616170016.GC34820@otc-nc-03>
References: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
 <20200615100214.GC1491454@stefanha-x1.localdomain>
 <MWHPR11MB16451F1E4748DF97D6A1DDD48C9D0@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20200616154928.GF1491454@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200616154928.GF1491454@stefanha-x1.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Wu,
 Hao" <hao.wu@intel.com>, "Tian, Jun J" <jun.j.tian@intel.com>
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

On Tue, Jun 16, 2020 at 04:49:28PM +0100, Stefan Hajnoczi wrote:
> On Tue, Jun 16, 2020 at 02:26:38AM +0000, Tian, Kevin wrote:
> > > From: Stefan Hajnoczi <stefanha@gmail.com>
> > > Sent: Monday, June 15, 2020 6:02 PM
> > > 
> > > On Thu, Jun 11, 2020 at 05:15:19AM -0700, Liu Yi L wrote:
> > > > Shared Virtual Addressing (SVA), a.k.a, Shared Virtual Memory (SVM) on
> > > > Intel platforms allows address space sharing between device DMA and
> > > > applications. SVA can reduce programming complexity and enhance
> > > security.
> > > >
> > > > This VFIO series is intended to expose SVA usage to VMs. i.e. Sharing
> > > > guest application address space with passthru devices. This is called
> > > > vSVA in this series. The whole vSVA enabling requires QEMU/VFIO/IOMMU
> > > > changes. For IOMMU and QEMU changes, they are in separate series (listed
> > > > in the "Related series").
> > > >
> > > > The high-level architecture for SVA virtualization is as below, the key
> > > > design of vSVA support is to utilize the dual-stage IOMMU translation (
> > > > also known as IOMMU nesting translation) capability in host IOMMU.
> > > >
> > > >
> > > >     .-------------.  .---------------------------.
> > > >     |   vIOMMU    |  | Guest process CR3, FL only|
> > > >     |             |  '---------------------------'
> > > >     .----------------/
> > > >     | PASID Entry |--- PASID cache flush -
> > > >     '-------------'                       |
> > > >     |             |                       V
> > > >     |             |                CR3 in GPA
> > > >     '-------------'
> > > > Guest
> > > > ------| Shadow |--------------------------|--------
> > > >       v        v                          v
> > > > Host
> > > >     .-------------.  .----------------------.
> > > >     |   pIOMMU    |  | Bind FL for GVA-GPA  |
> > > >     |             |  '----------------------'
> > > >     .----------------/  |
> > > >     | PASID Entry |     V (Nested xlate)
> > > >     '----------------\.------------------------------.
> > > >     |             |   |SL for GPA-HPA, default domain|
> > > >     |             |   '------------------------------'
> > > >     '-------------'
> > > > Where:
> > > >  - FL = First level/stage one page tables
> > > >  - SL = Second level/stage two page tables
> > > 
> > > Hi,
> > > Looks like an interesting feature!
> > > 
> > > To check I understand this feature: can applications now pass virtual
> > > addresses to devices instead of translating to IOVAs?
> > > 
> > > If yes, can guest applications restrict the vSVA address space so the
> > > device only has access to certain regions?
> > > 
> > > On one hand replacing IOVA translation with virtual addresses simplifies
> > > the application programming model, but does it give up isolation if the
> > > device can now access all application memory?
> > > 
> > 
> > with SVA each application is allocated with a unique PASID to tag its
> > virtual address space. The device that claims SVA support must guarantee 
> > that one application can only program the device to access its own virtual
> > address space (i.e. all DMAs triggered by this application are tagged with
> > the application's PASID, and are translated by IOMMU's PASID-granular
> > page table). So, isolation is not sacrificed in SVA.
> 
> Isolation between applications is preserved but there is no isolation
> between the device and the application itself. The application needs to
> trust the device.

Right. With all convenience comes security trust. With SVA there is an
expectation that the device has the required security boundaries properly
implemented. FWIW, what is our guarantee today that VF's are secure from
one another or even its own PF? They can also generate transactions with
any of its peer id's and there is nothing an IOMMU can do today. Other than
rely on ACS. Even BusMaster enable can be ignored and devices (malicious
or otherwise) can generate after the BM=0. With SVM you get the benefits of

* Not having to register regions
* Don't need to pin application space for DMA.

> 
> Examples:
> 
> 1. The device can snoop secret data from readable pages in the
>    application's virtual memory space.

Aren't there other security technologies that can address this?

> 
> 2. The device can gain arbitrary execution on the CPU by overwriting
>    control flow addresses (e.g. function pointers, stack return
>    addresses) in writable pages.

I suppose technology like CET might be able to guard. The general
expectation is code pages and anything that needs to be protected should be
mapped nor writable.

Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
