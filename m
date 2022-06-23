Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5A4CCA47C
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 20:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECD0184807;
	Thu, 23 Jun 2022 20:36:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ECD0184807
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CPzm4Rqy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7W2e9HapH0om; Thu, 23 Jun 2022 20:36:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AF44F8479E;
	Thu, 23 Jun 2022 20:36:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF44F8479E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C3B3C0032;
	Thu, 23 Jun 2022 20:36:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00D5DC002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 20:35:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB9D6401E1
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 20:35:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BB9D6401E1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CPzm4Rqy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ELAVocTdxu84 for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 20:35:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E2E1440101
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E2E1440101
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 20:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656016556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jBmUQROEGSBi6KZ4o9E9bBpH1DEN5yNQ4K8Bp+Z/iq4=;
 b=CPzm4RqyO4RL06TxxQKf9e7y7T4S0v1ZjCJwe3FuMIVccdIILiEf4v19uGvtyeV0/5j1xJ
 HVeOUDjgxTz+jFE2JF9KdWosM9+Pv+qZNiF+T4qi5lVqhgGDYG6nqy/ugWzcjzw8aY9Xyl
 wOqFFrpxYWEbyHmjF9pR8q5tKSbPbk8=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-X6y5ZgA_O2We_t9BuWiwsQ-1; Thu, 23 Jun 2022 16:35:54 -0400
X-MC-Unique: X6y5ZgA_O2We_t9BuWiwsQ-1
Received: by mail-io1-f69.google.com with SMTP id
 q13-20020a5d9f0d000000b00669c03397f7so285048iot.10
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 13:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=jBmUQROEGSBi6KZ4o9E9bBpH1DEN5yNQ4K8Bp+Z/iq4=;
 b=jE6qokz1nZ86y3AELSVZWjgvwtH58aaVRpX2df0CBGL1SvKeiPfZh0DFC9V38x9+3Q
 kTmgLkUwiMSCVMnEPNns51QPlofcN+Ix6bFVGMZORUbZUQP8hGY59NpbtDQDcsLYMMys
 KrQNxlCcBYWa8N1+li0IXl33cOmJ4epBYJcYXgefFC6g10KBZgwAypQDe0bO8WPlFJ8t
 fpQqDSbosF6AJhkAFmO1X7ODZxMag9mUdbAvgzX4vjVGdFyulvI7FFjtWpTxXMT7++qq
 8T4exi+IkmMunDl2Ikw1Z+CVLb7bf/QTclhx3Ae6l8CYlKsI2o81m4y6el0IFRrRyHbB
 28cw==
X-Gm-Message-State: AJIora+ZKp5oQjKwDBcutP1NKeNNffTG6j/vcZHJQtLMZRwgl2sGsnBY
 ESz4kAdCLm/I64MWhOxp72GBPyc+ORFGf8q5HIV5gkA1Yp/don6HMyKzJswczQi6ctcCFwBeS54
 zbVHsUAjEcFCh48u6/NWxWWvrB5tExw==
X-Received: by 2002:a02:c503:0:b0:339:ec67:b0a4 with SMTP id
 s3-20020a02c503000000b00339ec67b0a4mr2600641jam.27.1656016554288; 
 Thu, 23 Jun 2022 13:35:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uY4A4ulPkvl+0HkPHVJxiXM5mroTpWUdfuh0+GS53HXI+mhS1f3l3m2WS35NzqHwDBGAYR9g==
X-Received: by 2002:a02:c503:0:b0:339:ec67:b0a4 with SMTP id
 s3-20020a02c503000000b00339ec67b0a4mr2600627jam.27.1656016553968; 
 Thu, 23 Jun 2022 13:35:53 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 w16-20020a02cf90000000b00339c3906b08sm151280jar.177.2022.06.23.13.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jun 2022 13:35:53 -0700 (PDT)
Date: Thu, 23 Jun 2022 14:35:52 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2 1/2] vfio/type1: Simplify bus_type determination
Message-ID: <20220623143552.634779e0.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB5276A79834CCB5954A3025DF8CB59@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <b1d13cade281a7d8acbfd0f6a33dcd086207952c.1655898523.git.robin.murphy@arm.com>
 <20220622161721.469fc9eb.alex.williamson@redhat.com>
 <BN9PR11MB5276A79834CCB5954A3025DF8CB59@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "jgg@nvidia.com" <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
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

On Thu, 23 Jun 2022 08:46:45 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Thursday, June 23, 2022 6:17 AM
> >   
> > >
> > >  	ret = -EIO;
> > > -	domain->domain = iommu_domain_alloc(bus);
> > > +	domain->domain = iommu_domain_alloc(iommu_api_dev->dev-
> > >bus);  
> > 
> > It makes sense to move away from a bus centric interface to iommu ops
> > and I can see that having a device interface when we have device level
> > address-ability within a group makes sense, but does it make sense to
> > only have that device level interface?  For example, if an iommu_group
> > is going to remain an aspect of the iommu subsystem, shouldn't we be
> > able to allocate a domain and test capabilities based on the group and
> > the iommu driver should have enough embedded information reachable
> > from
> > the struct iommu_group to do those things?  This "perform group level
> > operations based on an arbitrary device in the group" is pretty klunky.
> > Thanks,
> >   
> 
> This sounds a right thing to do.
> 
> btw another alternative which I'm thinking of is whether vfio_group
> can record the bus info when the first device is added to it in
> __vfio_register_dev(). Then we don't need a group interface from
> iommu to test if vfio is the only user having such requirement.

That might be more simple, but it's just another variation on vfio
picking an arbitrary device from a group to satisfy the iommu interface
rather than operating on an iommu subsystem provided object.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
