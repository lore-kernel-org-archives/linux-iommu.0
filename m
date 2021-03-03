Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37596C433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 19:40:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9202664EEC
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 19:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9202664EEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31AB74B058;
	Wed,  3 Mar 2021 19:40:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id APOFSVM359Qc; Wed,  3 Mar 2021 19:40:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id B73554AD93;
	Wed,  3 Mar 2021 19:39:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88D4FC000A;
	Wed,  3 Mar 2021 19:39:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2A0EC0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 19:39:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCBE54013C
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 19:39:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BeltBRKVcU52 for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 19:39:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 24CEB400E1
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 19:39:58 +0000 (UTC)
IronPort-SDR: yKu6uN2FT5kqB6uo9vzPpy4XxgoBCtbfAnCCbvJPHVK740nEIhzRlaLa5V/RCj3/pEHW4UoLj7
 0X34HYqpUbpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="187384193"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; d="scan'208";a="187384193"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 11:39:56 -0800
IronPort-SDR: OdWGxtDOTrbt2xAehg361Kyac1/DrJMpD2/y6cI5y2BRW5S4BA85lehFEoc8rHcWhexqlqbAbe
 RjtgNnQeWrjg==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; d="scan'208";a="384112777"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 11:39:56 -0800
Date: Wed, 3 Mar 2021 11:42:12 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [Patch v8 04/10] vfio/type1: Support binding guest page tables
 to PASID
Message-ID: <20210303114212.1cd86579@jacob-builder>
In-Reply-To: <20210302171551.GK4247@nvidia.com>
References: <20210302203545.436623-1-yi.l.liu@intel.com>
 <20210302203545.436623-5-yi.l.liu@intel.com>
 <20210302125628.GI4247@nvidia.com>
 <20210302091319.1446a47b@jacob-builder>
 <20210302171551.GK4247@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, vivek.gautam@arm.com, Jason Wang <jasowang@redhat.com>,
 stefanha@gmail.com, yi.y.sun@intel.com, alex.williamson@redhat.com,
 iommu@lists.linux-foundation.org, Lingshan.Zhu@intel.com, hao.wu@intel.com,
 jun.j.tian@intel.com
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

Hi Jason,

On Tue, 2 Mar 2021 13:15:51 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Mar 02, 2021 at 09:13:19AM -0800, Jacob Pan wrote:
> > Hi Jason,
> > 
> > On Tue, 2 Mar 2021 08:56:28 -0400, Jason Gunthorpe <jgg@nvidia.com>
> > wrote: 
> > > On Wed, Mar 03, 2021 at 04:35:39AM +0800, Liu Yi L wrote:  
> > > >  
> > > > +static int vfio_dev_bind_gpasid_fn(struct device *dev, void *data)
> > > > +{
> > > > +	struct domain_capsule *dc = (struct domain_capsule *)data;
> > > > +	unsigned long arg = *(unsigned long *)dc->data;
> > > > +
> > > > +	return iommu_uapi_sva_bind_gpasid(dc->domain, dev,
> > > > +					  (void __user *)arg);    
> > > 
> > > This arg buisness is really tortured. The type should be set at the
> > > ioctl, not constantly passed down as unsigned long or worse void *.
> > > 
> > > And why is this passing a __user pointer deep into an iommu_* API??
> > >   
> > The idea was that IOMMU UAPI (not API) is independent of VFIO or other
> > user driver frameworks. The design is documented here:
> > Documentation/userspace-api/iommu.rst
> > IOMMU UAPI handles the type and sanitation of user provided data.  
> 
> Why? If it is uapi it has defined types and those types should be
> completely clear from the C code, not obfuscated.
> 
From the user's p.o.v., it is plain c code nothing obfuscated. As for
kernel handling of the data types, it has to be answered by the bigger
question of how we deal with sharing IOMMU among multiple subsystems with
UAPIs.

> I haven't looked at the design doc yet, but this is a just a big red
> flag, you shouldn't be tunneling one subsytems uAPI through another
> subsystem.
>
> If you need to hook two subsystems together it should be more
> directly, like VFIO takes in the IOMMU FD and 'registers' itself in
> some way with the IOMMU then you can do the IOMMU actions through the
> IOMMU FD and it can call back to VFIO as needed.
> 
> At least in this way we can swap VFIO for other things in the API.
> 
> Having every subsystem that wants to implement IOMMU also implement
> tunneled ops seems very backwards.
>
Let me try to understand your proposal, you are saying:
1. Create a new user interface such that FDs can be obtained as a reference
to an IOMMU.
2. Handle over the IOMMU FD to VFIO or other subsystem which wish to
register for IOMMU service.

However, IOMMU is a system device which has little value to be exposed to
the userspace. Not to mention the device-IOMMU affinity/topology. VFIO
nicely abstracts IOMMU from the userspace, why do we want to reverse that?

With this UAPI layering approach, we converge common code at the IOMMU
layer. Without introducing new user interfaces, we can support multiple
subsystems that want to use IOMMU service. e.g. VDPA and VFIO.

> > Could you be more specific about your concerns?  
> 
> Avoid using unsigned long, void * and flex arrays to describe
> concretely typed things.
> 
> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
