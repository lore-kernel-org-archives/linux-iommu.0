Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74131C433DB
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 17:16:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBAEA64F2C
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 17:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBAEA64F2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 864BB83ACA;
	Tue,  2 Mar 2021 17:16:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L9qPZmJdOFXK; Tue,  2 Mar 2021 17:16:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69C1583AB7;
	Tue,  2 Mar 2021 17:16:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FDFFC000B;
	Tue,  2 Mar 2021 17:16:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 701A8C0001
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 17:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A4B683AB7
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 17:16:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NhsbnIf1FtvU for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 17:16:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5835A83ABB
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 17:16:06 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B603e72d50001>; Tue, 02 Mar 2021 09:16:05 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Mar
 2021 17:16:04 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Mar
 2021 17:15:55 +0000
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 2 Mar 2021 17:15:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UisxayQgSA4FpKnGtW+fwOD1zHuG9pxno1f8UvK3TayBvQfA/B3qHNSK1k2bGzM+8+WQhfB5Enk/sw70aqR7+UXXqUbrWpkTlTc7C+CXag1ttev4/9kaG9KuxGRkVyWG/tSCrOH7nRuBAsLOHpSw0xad5qSF84BXzV/VQfm/YHRxb3mUVTACPdqxNytTsHpuF9MBeWj8PgMQWOD1K6XwelAvp7Zm0zqw85FVehCcDmdlH9ouInRMtjfX872vL2emqH+0eKf3qVRvT9sWstyQ1hXla2DsbegJlheBuTz5ZN7ppSdlmi9XVkih0ydn+E/zIJNtpufAsq7NM8hUuUnjMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oQlEGY42G/OLU9PJunjf7j8qctAJH22IeNnf2g4K0A=;
 b=H9sehWf05Sf5GZVlBTRSY/Tq7Wyxbj+Lkl92ZvFvPE2rOWtdutBAJvOttbaUaUNcN1rEhJoeLbziwmQC5no6tGf836ZMlln0bX90NaL8mCyPO5h8rKE1q6sZtrwXdb4OhLVZAUkk9gNZMkaxI6igcY/vYtyFMFCvn76Q5ws+vWyx24VkjNvWfnn5sXSlsHHwZhhDaAF4iKSmeVFiQppWZAGoefW5msGACqo+LT3jmsmUQm12kFA21KtGsFeTMkodPGn2noskQcllHb0Ni3o27Dlp7jALLXF3OJUzMfxxqn12PLOwyk90eDLHbpe6tEkN1f5vyqocqDe/G3AjVuoq7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1243.namprd12.prod.outlook.com (2603:10b6:3:74::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Tue, 2 Mar
 2021 17:15:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3912.017; Tue, 2 Mar 2021
 17:15:52 +0000
Date: Tue, 2 Mar 2021 13:15:51 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [Patch v8 04/10] vfio/type1: Support binding guest page tables
 to PASID
Message-ID: <20210302171551.GK4247@nvidia.com>
References: <20210302203545.436623-1-yi.l.liu@intel.com>
 <20210302203545.436623-5-yi.l.liu@intel.com>
 <20210302125628.GI4247@nvidia.com> <20210302091319.1446a47b@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20210302091319.1446a47b@jacob-builder>
X-ClientProxiedBy: MN2PR19CA0021.namprd19.prod.outlook.com
 (2603:10b6:208:178::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 MN2PR19CA0021.namprd19.prod.outlook.com (2603:10b6:208:178::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Tue, 2 Mar 2021 17:15:52 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lH8ch-004GgH-1X; Tue, 02 Mar 2021 13:15:51 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614705365; bh=3oQlEGY42G/OLU9PJunjf7j8qctAJH22IeNnf2g4K0A=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType:X-Header;
 b=fZ3amAQSGUUdVYItRVwWYaLI1JP4P62+SmtzHY5gHB4qez+BySeNe+yYRvYVUge1/
 7op6B7HL6ypWZsrxjF+juTNXMUfbDRfH25iehP+bf97T4PmsoaJEBIK+Z8j+G94NFu
 ChMBKeqM3A/I1fI4EQoraiubzH3yHH5mNulT9Kua35O9oXpf5aHLqrErqVwoOECqMR
 qW+vVaTzxnxawQmZ9I+V0PVFFfXpM/bn+5jGMbH500WaqytBfwF6Nt0XcrR7oBCPj6
 LW7ZHBmkrdRmVfqbX4uO5vHKF7Sh63iLiZ21kq7fN8B0tVl+K2B/Ynf7T+3VSQzSM4
 diPkj+o9/5/Jw==
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

On Tue, Mar 02, 2021 at 09:13:19AM -0800, Jacob Pan wrote:
> Hi Jason,
> 
> On Tue, 2 Mar 2021 08:56:28 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Wed, Mar 03, 2021 at 04:35:39AM +0800, Liu Yi L wrote:
> > >  
> > > +static int vfio_dev_bind_gpasid_fn(struct device *dev, void *data)
> > > +{
> > > +	struct domain_capsule *dc = (struct domain_capsule *)data;
> > > +	unsigned long arg = *(unsigned long *)dc->data;
> > > +
> > > +	return iommu_uapi_sva_bind_gpasid(dc->domain, dev,
> > > +					  (void __user *)arg);  
> > 
> > This arg buisness is really tortured. The type should be set at the
> > ioctl, not constantly passed down as unsigned long or worse void *.
> > 
> > And why is this passing a __user pointer deep into an iommu_* API??
> > 
> The idea was that IOMMU UAPI (not API) is independent of VFIO or other user
> driver frameworks. The design is documented here:
> Documentation/userspace-api/iommu.rst
> IOMMU UAPI handles the type and sanitation of user provided data.

Why? If it is uapi it has defined types and those types should be
completely clear from the C code, not obfuscated.

I haven't looked at the design doc yet, but this is a just a big red
flag, you shouldn't be tunneling one subsytems uAPI through another
subsystem.

If you need to hook two subsystems together it should be more
directly, like VFIO takes in the IOMMU FD and 'registers' itself in
some way with the IOMMU then you can do the IOMMU actions through the
IOMMU FD and it can call back to VFIO as needed.

At least in this way we can swap VFIO for other things in the API.

Having every subsystem that wants to implement IOMMU also implement
tunneled ops seems very backwards.

> Could you be more specific about your concerns?

Avoid using unsigned long, void * and flex arrays to describe
concretely typed things.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
