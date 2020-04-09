Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB21C2BA80
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 09:15:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6107D20757
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 09:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6107D20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3853020372;
	Thu,  9 Apr 2020 09:15:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NidPY0UvTZwE; Thu,  9 Apr 2020 09:15:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2BC7C2036B;
	Thu,  9 Apr 2020 09:15:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C481C1D7E;
	Thu,  9 Apr 2020 09:15:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57C67C0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 09:15:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4108620372
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 09:15:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kkPbzBhKIhTG for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 09:15:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by silver.osuosl.org (Postfix) with ESMTPS id 471802036B
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 09:15:36 +0000 (UTC)
IronPort-SDR: XtI9osndr7bSyunydo88dTTbplUWm6cIyXnzBda/3VuXQLEDGcjE9FTPNSXrF4xy9tiJ40m7Le
 lqJbPGt5l92A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 02:15:35 -0700
IronPort-SDR: LKI2mMlF5gRpfCpUQKmtzZ9HxbE2ZCqbs8lOz4VEi0+4c9z2xO8vzNilg/v2NJuYCA6ZkGE25f
 Tbc1DvUcnVCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,362,1580803200"; d="scan'208";a="270024062"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga002.jf.intel.com with ESMTP; 09 Apr 2020 02:15:35 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Apr 2020 02:15:34 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Apr 2020 02:15:33 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.191]) with mapi id 14.03.0439.000;
 Thu, 9 Apr 2020 17:15:30 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [PATCH v1 6/8] vfio/type1: Bind guest page tables to host
Thread-Topic: [PATCH v1 6/8] vfio/type1: Bind guest page tables to host
Thread-Index: AQHWAEUdkW8K+/kg/06c7098DvJyv6hgm8wAgANYlCCAAK00AIAA6IawgAEUvACABu4SMIACfjcAgACRzFA=
Date: Thu, 9 Apr 2020 09:15:29 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A228CCA@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-7-git-send-email-yi.l.liu@intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FF98F@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A21D8C6@SHSMSX104.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D805F75@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A21ED01@SHSMSX104.ccr.corp.intel.com>
 <20200403083407.GB1269501@myrica>
 <A2975661238FB949B60364EF0F2C25743A224C8F@SHSMSX104.ccr.corp.intel.com>
 <20200409082846.GE2435@myrica>
In-Reply-To: <20200409082846.GE2435@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Thursday, April 9, 2020 4:29 PM
> To: Liu, Yi L <yi.l.liu@intel.com>
> 
> On Tue, Apr 07, 2020 at 10:33:25AM +0000, Liu, Yi L wrote:
> > Hi Jean,
> >
> > > From: Jean-Philippe Brucker < jean-philippe@linaro.org >
> > > Sent: Friday, April 3, 2020 4:35 PM
> > > Subject: Re: [PATCH v1 6/8] vfio/type1: Bind guest page tables to host
> > >
> > > On Thu, Apr 02, 2020 at 08:05:29AM +0000, Liu, Yi L wrote:
> > > > > > > > static long vfio_iommu_type1_ioctl(void *iommu_data,
> > > > > > > >  		default:
> > > > > > > >  			return -EINVAL;
> > > > > > > >  		}
> > > > > > > > +
> > > > > > > > +	} else if (cmd == VFIO_IOMMU_BIND) {
> > > > > > >
> > > > > > > BIND what? VFIO_IOMMU_BIND_PASID sounds clearer to me.
> > > > > >
> > > > > > Emm, it's up to the flags to indicate bind what. It was proposed to
> > > > > > cover the three cases below:
> > > > > > a) BIND/UNBIND_GPASID
> > > > > > b) BIND/UNBIND_GPASID_TABLE
> > > > > > c) BIND/UNBIND_PROCESS
> > > > > > <only a) is covered in this patch>
> > > > > > So it's called VFIO_IOMMU_BIND.
> > > > >
> > > > > but aren't they all about PASID related binding?
> > > >
> > > > yeah, I can rename it. :-)
> > >
> > > I don't know if anyone intends to implement it, but SMMUv2 supports
> > > nesting translation without any PASID support. For that case the name
> > > VFIO_IOMMU_BIND_GUEST_PGTBL without "PASID" anywhere makes more
> sense.
> > > Ideally we'd also use a neutral name for the IOMMU API instead of
> > > bind_gpasid(), but that's easier to change later.
> >
> > I agree VFIO_IOMMU_BIND is somehow not straight-forward. Especially, it may
> > cause confusion when thinking about VFIO_SET_IOMMU. How about using
> > VFIO_NESTING_IOMMU_BIND_STAGE1 to cover a) and b)? And has another
> > VFIO_BIND_PROCESS in future for the SVA bind case.
> 
> I think minimizing the number of ioctls is more important than finding the
> ideal name. VFIO_IOMMU_BIND was fine to me, but if it's too vague then
> rename it to VFIO_IOMMU_BIND_PASID and we'll just piggy-back on it for
> non-PASID things (they should be rare enough).
maybe we can start with VFIO_IOMMU_BIND_PASID. Actually, there is
also a discussion on reusing the same ioctl and vfio structure for
pasid_alloc/free, bind/unbind_gpasid. and cache_inv. how about your
opinion?

https://lkml.org/lkml/2020/4/3/833

Regards,
Yi Liu



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
