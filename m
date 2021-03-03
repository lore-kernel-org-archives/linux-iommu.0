Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72905C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 19:45:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2AFD64EDF
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 19:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2AFD64EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B51D83F1B;
	Wed,  3 Mar 2021 19:45:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t18n3N28PUrB; Wed,  3 Mar 2021 19:45:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EB1983AB9;
	Wed,  3 Mar 2021 19:45:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5123CC000A;
	Wed,  3 Mar 2021 19:45:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E44C2C0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 19:45:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CABCB83CA7
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 19:45:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vpSoW8OSRQ9J for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 19:45:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6616683AB9
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 19:45:34 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B603fe75d0005>; Wed, 03 Mar 2021 11:45:33 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Mar
 2021 19:45:27 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 3 Mar 2021 19:45:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvCSz8nvfc7lCW5PyLxPuLPz5EDB8yav5WbaLvVgBh2aGziTea9RXfYmzLRYZI3Wp3fQvXLVoH8jEFJcbxD1TjbCBMw0VCHAP6B6UQQaPK8AaNjrWGnfFW1KrLGGCSpfLMK2b02ZC5DS3odD8gv7t+V+Hn5WEA/dzgR+Igmt4Y15eLQDXY8zq8LUbPWtJxZr8vBjJGdAp4pGm8wp6+lCZ3pvRwEcwIxL4nI/NpRvfjJgrmS3sTyjMBiOQcC+avZvCSSBg33tyEHQzeLgC/CqJ1IlGEvs+F2DTiun2qR+i8/eXaB+WDmZEaf6h+Nm0oaQ40i1PNO8vm0JwAUUmbcZ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESjraPQ1U+x3dvWd7l3HBKlTBu3ySX2nWO4QM44ApEU=;
 b=jSR3cs3NmxaL0zez1GjX7GjJU1t0Kn0y/Tr8s6tLQnFHKw4jd3ts3ewv/GcPQTnGE3Moz7zRan74v7eu0QnUg2VXW1qugMRHWbxYiCobtPl/MrDWFbd+rCpMwW16xScy5HaZ+sukjw9NtUTJLjD1qG0obCuo5X+yfQwyI5lE931py6MaRFJ5B+QKSq8kYVMWrYK5j+/tKgsqZLWPUAS9twP0I5CH/8KtYxLwZdF00/eQdMXFLZl6oRGSGOTC3a3EGxt90dqBUmiNs0yMm56vNtpfPX2ePGWI/eMnWQB+UNTVSOsSf6TnO0WdchfmiU3Eqc9P1nwcW0jVX0+0yobkqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1436.namprd12.prod.outlook.com (2603:10b6:3:78::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Wed, 3 Mar 2021 19:45:25 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 19:45:25 +0000
Date: Wed, 3 Mar 2021 15:45:23 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [Patch v8 04/10] vfio/type1: Support binding guest page tables
 to PASID
Message-ID: <20210303194523.GX4247@nvidia.com>
References: <20210302203545.436623-1-yi.l.liu@intel.com>
 <20210302203545.436623-5-yi.l.liu@intel.com>
 <20210302125628.GI4247@nvidia.com> <20210302091319.1446a47b@jacob-builder>
 <20210302171551.GK4247@nvidia.com> <20210303114212.1cd86579@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20210303114212.1cd86579@jacob-builder>
X-ClientProxiedBy: BL1PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:208:256::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 BL1PR13CA0005.namprd13.prod.outlook.com (2603:10b6:208:256::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend
 Transport; Wed, 3 Mar 2021 19:45:25 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lHXQx-006HY0-UI; Wed, 03 Mar 2021 15:45:23 -0400
X-Header: ProcessedBy-CMR-outbound
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, vivek.gautam@arm.com, jasowang@redhat.com,
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

On Wed, Mar 03, 2021 at 11:42:12AM -0800, Jacob Pan wrote:
> Hi Jason,
> 
> On Tue, 2 Mar 2021 13:15:51 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Tue, Mar 02, 2021 at 09:13:19AM -0800, Jacob Pan wrote:
> > > Hi Jason,
> > > 
> > > On Tue, 2 Mar 2021 08:56:28 -0400, Jason Gunthorpe <jgg@nvidia.com>
> > > wrote: 
> > > > On Wed, Mar 03, 2021 at 04:35:39AM +0800, Liu Yi L wrote:  
> > > > >  
> > > > > +static int vfio_dev_bind_gpasid_fn(struct device *dev, void *data)
> > > > > +{
> > > > > +	struct domain_capsule *dc = (struct domain_capsule *)data;
> > > > > +	unsigned long arg = *(unsigned long *)dc->data;
> > > > > +
> > > > > +	return iommu_uapi_sva_bind_gpasid(dc->domain, dev,
> > > > > +					  (void __user *)arg);    
> > > > 
> > > > This arg buisness is really tortured. The type should be set at the
> > > > ioctl, not constantly passed down as unsigned long or worse void *.
> > > > 
> > > > And why is this passing a __user pointer deep into an iommu_* API??
> > > >   
> > > The idea was that IOMMU UAPI (not API) is independent of VFIO or other
> > > user driver frameworks. The design is documented here:
> > > Documentation/userspace-api/iommu.rst
> > > IOMMU UAPI handles the type and sanitation of user provided data.  
> > 
> > Why? If it is uapi it has defined types and those types should be
> > completely clear from the C code, not obfuscated.
> > 
> From the user's p.o.v., it is plain c code nothing obfuscated. As for
> kernel handling of the data types, it has to be answered by the bigger
> question of how we deal with sharing IOMMU among multiple subsystems with
> UAPIs.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1614800733; bh=ESjraPQ1U+x3dvWd7l3HBKlTBu3ySX2nWO4QM44ApEU=;
	h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
	 From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-Header;
	b=Jyxs64SLsrGfmoPaAHc58Bpre6/+/wDGs/dAMDviWTwRc+2Miw0+jOBGQXNLz/lE8
	 KbS/K02BZmgn/jJwl994Po6nS3kGgTg0of6AFSd2MqtaZPMx+aMJ3prec9hwpHaXmN
	 SiosC+FviWoFQHmEvWSQoVeEMS093zQ+sjcsymUkMXYHGYQRqebW101Mii6/0hT3iv
	 Su4YvAyaKmOpWT8sayI4K0ICIhRxWAOT5P78FrXofij9o3X9T9F/9Bo+S5BWSCMzMr
	 +dM2KsTd4Ecac9hNemigs87T/tiCh50XaZoc8WMRFWGYMpha6KFdCV5wWL0Yzauyt7
	 H7uCWkmg/QTCw==

As I said, don't obfuscate types like this in the kernel. It is not
good style.

> However, IOMMU is a system device which has little value to be exposed to
> the userspace. Not to mention the device-IOMMU affinity/topology. VFIO
> nicely abstracts IOMMU from the userspace, why do we want to reverse that?

The other patch was talking about a /dev/ioasid - why can't this stuff
be run over that?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
