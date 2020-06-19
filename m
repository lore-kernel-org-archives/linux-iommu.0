Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1966CC433E0
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 03:30:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4A520776
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 03:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="HBeQDnXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4A520776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 658AC27355;
	Fri, 19 Jun 2020 03:30:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Pv4JsTKtT0W; Fri, 19 Jun 2020 03:30:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 18EE92734A;
	Fri, 19 Jun 2020 03:30:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0236C088C;
	Fri, 19 Jun 2020 03:30:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A325C016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 03:30:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7118B88D06
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 03:30:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BQlSqfUDe2-1 for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 03:30:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1B97D88CAA
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 03:30:33 +0000 (UTC)
IronPort-SDR: qfEs77yTqciPfYun/6l7asGkYewzKD1rttKGHhcF8msx8G9DzgDt3Mm1ZnQ+R42MSUcOaJOdyT
 fRspBTyHiCVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="130187172"
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; d="scan'208";a="130187172"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 20:30:30 -0700
IronPort-SDR: ILejYGpf8tJ5RVlx7nG68oG/TLMLlO4myTWawvNMBtaQD9fQ8WvTsAPcdDFBTm7lS10yDXC+tj
 OZGyCE7auLtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; d="scan'208";a="352613172"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga001.jf.intel.com with ESMTP; 18 Jun 2020 20:30:27 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jun 2020 20:30:26 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 18 Jun 2020 20:30:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 18 Jun 2020 20:30:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cf2yq/FuUIf56QdPSRe9nytk7V9IKAhj8dDr9EZJzbxwQaxryFvZV/g+jKQ3TvQi4hlDWIehzBiDSCUO4kEOtw/ZrpeweMv99VCEa+um+RnYBoU2Io9+hByZcngPuANZLx8qZCBc3AHunNuYcisXR/2c2rTX0202C/lf+wUcZYMZttbUDSCnXTlz+xtnMGuDzlPuG52DOMpSgpXeMyT5FA5M8DCH7RvaQJyfyX/g1xOmMlwHiBMJo6dhHnxobuLLTBKuOUrTTO6MgjXgeiyLVmZgcNJcXa6ALJKikqPuOay4A/+rmNoPI5lmx3w3N5kmtGVZUoljjMeyO7UpP8Ss3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3F8rObAL2OIzmTj3JZZYDiJ4vSRDF5mtfR7WxXAyK8=;
 b=WC9FCUyL3G8yQpkUyfQ7Xg96sxZQHJX3gAApGHTNwafaZAcfp4cRVvX4lb55pfOYMaSzdZRIkKV7JrLwZnrbkoAOHWfusdN3ckxYWezxtNsQJ3NJq+SXlm89h+VjtFxqlYYxpZxwcV5lArQVrkzhgL0OD28HVMtXHeWZW81kP+Uo+UM+gcPP+8sqid8uPeLeYzzQ5IVvHmMhTDfpCOIv8QXjkAO5PQnz5L83KMpjPJ+Iops1imwZqBlMbwiSmlCGSltU/tY11AhSLAfCjCIN3JVYC3RHgi6JIcIOnP/ieIaeB6thLQJae7SdrxBoMPVQoNwA3x62I8mF0R8yKSp8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3F8rObAL2OIzmTj3JZZYDiJ4vSRDF5mtfR7WxXAyK8=;
 b=HBeQDnXzy5caNppShbfcv+YJrX+pkr27ZNy8SvxWxGBn5IRt338Nu1UvF9CWqZP9H3KYL6FKwmY6coZ0uKfb75gWdsJaylkPBpnGYNCF1cyhJLqh0kHk6bBlTT9eejVf4QPxjJU2Hr2Oisc16ip4zuMSKBTYEuCwBw0Xj7Rlpa8=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1787.namprd11.prod.outlook.com (2603:10b6:3:112::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Fri, 19 Jun 2020 03:30:25 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c%6]) with mapi id 15.20.3109.023; Fri, 19 Jun 2020
 03:30:24 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v2 1/3] docs: IOMMU user API
Thread-Topic: [PATCH v2 1/3] docs: IOMMU user API
Thread-Index: AQHWP6WkhOQLPQDE2EquIdJoSq1UYKjTj/yAgABESYCAAA2bgIAAP1SAgAdDUQCAAPjyYIAAJcYAgAJxwoCAADPkoIAAIdmAgAAFjiA=
Date: Fri, 19 Jun 2020 03:30:24 +0000
Message-ID: <DM5PR11MB14355A49810AA611DD8540D9C3980@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1591848735-12447-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200611094741.6d118fa8@w520.home>	<20200611125205.1e0280d3@jacob-builder>
 <20200611144047.79613c32@x1.home>	<20200611172727.78dbb822@jacob-builder>
 <20200616082212.0c1611dd@jacob-builder>
 <DM5PR11MB1435DD578488DA08A1E699ACC39A0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <MWHPR11MB164595B754BE441255902DCA8C9A0@MWHPR11MB1645.namprd11.prod.outlook.com>
 <20200618154805.049219db@w520.home>
 <DM5PR11MB1435FA1C517087E8C5DEACB3C3980@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20200618205457.6969f9a7@x1.home>
In-Reply-To: <20200618205457.6969f9a7@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dee266e4-581c-47fa-7058-08d814011ac2
x-ms-traffictypediagnostic: DM5PR11MB1787:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1787D14B54C3112C7CAE9BFCC3980@DM5PR11MB1787.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0439571D1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cGGSTtlliDJTSeY/zzKB9qPnXG3UMz/lkVwwVHpQhxBUTmmUZwJpxyy/R5NRVZgLzS2mCjq9rPcXNfKwyS3BbQlKZcOxK0VZvpBhAbF0mfUdHleTWO5oqQGyBU0SBp32gPWTgzMKhMKtS7AG5rtR7mXW1dAonA0xFyMO2PR4FewgrBMzIZOOst3jCRZGNsfn478c/m//LEdAZQ4MLfTpqSC1cpARqJZnuKGJqekUdgW8xjhnfbDEGPc3ZmvmMVwSlScyApZyVXdTqMoaT7z+lHi4vJ72F2kSiNaYvVKZTUEFSLB5BiDNNnaYEtmTDTPU9eKxkl1L0/+SYHTqj5dRIA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(83380400001)(9686003)(478600001)(76116006)(7696005)(66946007)(5660300002)(66556008)(64756008)(6506007)(316002)(66476007)(86362001)(66446008)(7416002)(52536014)(186003)(26005)(4326008)(8676002)(71200400001)(33656002)(2906002)(6916009)(54906003)(8936002)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ensueAVencdZhli8atWEyVmgVAXJ2TjQdq/CI+Nz7PW7c3XlkULDrdNgNnSLUXgSQ4xB21kdIIRqGtgiPG/pLGw8sbGjG+Fu4SLYr7pX6Aur03y+4uLPx0o0o694WfOcoPIyHuItZ0SOFeU8ghyq0W9W7wZeyJxoR/Tn23T8gEVUPt3w6aMq2BpkOVzNVBjkYfUX/fBacUvr5WWEQvKzD5raBwh9kbjwUqn9QFX47kZoqbcwosx6db6YWpFqZJyLCYVIac7cDIz9036oK6kDlhG8mQphzCA6LeaT25i9VxOoUjWg844QRyYyK7BuvRgCIVIJUYjEpLzPOAwanxj7/+vPN0WRZkDKMyJCB9UyMzDFYVBoYunSQgfw/GfbbaxaDKHLzGMfx7mtdWjAE3gQmooROgTGE5yIW4foURJPo5bVdzZQ4IM1EQe89zMNgai1fPoAlBP9JQ9XB6Z18ieVpoSCnpcwISbCmy6HPuKhUqd1PFreLO8bIeI4ilGwwnIH
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dee266e4-581c-47fa-7058-08d814011ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2020 03:30:24.8828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MOBUqi3YuSjJ5xM1WwmXwwraTW5noIJvVUlbkC4RKwf+pldfXZoX+Ve1ANZ5zQ1L49Ex49Rei9VQJE7qvRHeZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1787
X-OriginatorOrg: intel.com
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan
 Corbet <corbet@lwn.net>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, David
 Woodhouse <dwmw2@infradead.org>
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

Hi Alex,

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Friday, June 19, 2020 10:55 AM
> 
> On Fri, 19 Jun 2020 02:15:36 +0000
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> 
> > Hi Alex,
> >
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Friday, June 19, 2020 5:48 AM
> > >
> > > On Wed, 17 Jun 2020 08:28:24 +0000
> > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > >
> > > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > > Sent: Wednesday, June 17, 2020 2:20 PM
> > > > >
> > > > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > > > Sent: Tuesday, June 16, 2020 11:22 PM
> > > > > >
> > > > > > On Thu, 11 Jun 2020 17:27:27 -0700 Jacob Pan
> > > > > > <jacob.jun.pan@linux.intel.com> wrote:
> > > > > >
> > > > > > > >
> > > > > > > > But then I thought it even better if VFIO leaves the
> > > > > > > > entire
> > > > > > > > copy_from_user() to the layer consuming it.
> > > > > > > >
> > > > > > > OK. Sounds good, that was what Kevin suggested also. I just
> > > > > > > wasn't sure how much VFIO wants to inspect, I thought VFIO
> > > > > > > layer wanted to do a sanity check.
> > > > > > >
> > > > > > > Anyway, I will move copy_from_user to iommu uapi layer.
> > > > > >
> > > > > > Just one more point brought up by Yi when we discuss this offline.
> > > > > >
> > > > > > If we move copy_from_user to iommu uapi layer, then there will
> > > > > > be
> > > > > multiple
> > > > > > copy_from_user calls for the same data when a VFIO container
> > > > > > has
> > > > > multiple domains,
> > > > > > devices. For bind, it might be OK. But might be additional
> > > > > > overhead for TLB
> > > > > flush
> > > > > > request from the guest.
> > > > >
> > > > > I think it is the same with bind and TLB flush path. will be
> > > > > multiple copy_from_user.
> > > >
> > > > multiple copies is possibly fine. In reality we allow only one
> > > > group per nesting container (as described in patch [03/15]), and
> > > > usually there is just one SVA-capable device per group.
> > > >
> > > > >
> > > > > BTW. for moving data copy to iommy layer, there is another point
> > > > > which need to consider. VFIO needs to do unbind in bind path if
> > > > > bind failed, so it will assemble unbind_data and pass to iommu
> > > > > layer. If iommu layer do the copy_from_user, I think it will be failed. any
> idea?
> > >
> > > If a call into a UAPI fails, there should be nothing to undo.
> > > Creating a partial setup for a failed call that needs to be undone
> > > by the caller is not good practice.
> >
> > is it still a problem if it's the VFIO to undo the partial setup
> > before returning to user space?
> 
> Yes.  If a UAPI function fails there should be no residual effect.

ok. the iommu_sva_bind_gpasid() is per device call. There is no residual
effect if it failed. so no partial setup will happen per device.

but VFIO needs to use iommu_group_for_each_dev() to do bind, so
if iommu_group_for_each_dev() failed, I guess VFIO needs to undo
the partial setup for the group. right?

> > > > This might be mitigated if we go back to use the same bind_data
> > > > for both bind/unbind. Then you can reuse the user object for unwinding.
> > > >
> > > > However there is another case where VFIO may need to assemble the
> > > > bind_data itself. When a VM is killed, VFIO needs to walk
> > > > allocated PASIDs and unbind them one-by-one. In such case
> > > > copy_from_user doesn't work since the data is created by kernel.
> > > > Alex, do you have a suggestion how this usage can be supported?
> > > > e.g. asking IOMMU driver to provide two sets of APIs to handle user/kernel
> generated requests?
> > >
> > > Yes, it seems like vfio would need to make use of a driver API to do
> > > this, we shouldn't be faking a user buffer in the kernel in order to
> > > call through to a UAPI.  Thanks,
> >
> > ok, so if VFIO wants to issue unbind by itself, it should use an API
> > which passes kernel buffer to IOMMU layer. If the unbind request is
> > from user space, then VFIO should use another API which passes user
> > buffer pointer to IOMMU layer. makes sense. will align with jacob.
> 
> Sounds right to me.  Different approaches might be used for the driver API versus
> the UAPI, perhaps there is no buffer.  Thanks,

thanks for your coaching. It may require Jacob to add APIs in iommu layer
for the two purposes.

Regards,
Yi Liu

> Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
