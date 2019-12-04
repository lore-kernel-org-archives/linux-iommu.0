Return-Path: <SRS0=Oyzs=Z2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B7DC43603
	for <iommu@archiver.kernel.org>; Wed,  4 Dec 2019 16:40:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F2572053B
	for <iommu@archiver.kernel.org>; Wed,  4 Dec 2019 16:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pjJ78PJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2572053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2F03588496;
	Wed,  4 Dec 2019 16:40:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YFv+dQMGJBlJ; Wed,  4 Dec 2019 16:40:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1DC1588461;
	Wed,  4 Dec 2019 16:40:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0888CC1DD6;
	Wed,  4 Dec 2019 16:40:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC28EC077D
 for <iommu@lists.linux-foundation.org>; Wed,  4 Dec 2019 16:40:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C907B87C0D
 for <iommu@lists.linux-foundation.org>; Wed,  4 Dec 2019 16:40:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xt09cfrkSjRm for <iommu@lists.linux-foundation.org>;
 Wed,  4 Dec 2019 16:40:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr820072.outbound.protection.outlook.com [40.107.82.72])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 010FB87CDA
 for <iommu@lists.linux-foundation.org>; Wed,  4 Dec 2019 16:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pdl82coXhRlB7EEf0JrX6i+uLTJZUkwlrG/2H2+rr0nlP+Wg1x6GNGPT44EX7VEPT6AFE37LqGQrhigEOyayGVSiaqQunVd91eWrnYUwvd+WO85Q/ozI3Ym/gQMLLNvjQAdRcXAtgEbAbds7a5IUHNaW4Vykt7cnKZbypmU/FX1z+4hjOfZWROgsqLbJl776hA2HD68ObQjNdCxyeu/Ty2wy6OGPZuggvgx+5T6LXFkntUi/6gVPUq5+IeTwTuRByDNuTXM8ztPPmrIiTwMqcZxpBjKx80NgjgDy19eDX2QoepDhxNNKDYkuseKEWocR3wVBLoraDYj8QxEPF0QH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmNgH8lC6OtF278NaFUurKPVVtI0rLNLbs/Po+U6yXs=;
 b=lGzUINm9wapccfgfEG2R8WjXtVo+aGVLfzwynDMRBl+qd+Ms2BjQV/rr/2i+8cLYP2QJrd0Dm3hcToarvSVQmJ0ysF+Ch1UZ0330CxVlUWEBvtjs4YMgp/eh24aLFKIWFRDn7Qy+ggNKD6shF550ftBRqsNM1jUaCxPc2LF8RbRbYq9+JP93Y6zEn3ySpaV3wowDHFIieKSdGKmKxGM38IPF2k8kOuEiJCQTR7XR4O38/Dahbyx42ts8Pr8kdDm7chmK6S9qO27HiUC7iq1tAx/oCqeIgi8T04eRyBi7xNJUVs4uj1wi8HdpR0b3GAUXjx7jutc8Pyfj82lG9Y11/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmNgH8lC6OtF278NaFUurKPVVtI0rLNLbs/Po+U6yXs=;
 b=pjJ78PJMCgAnyLQZxvDJP6vMgTyaf/eVrW3kwED6C7Y3FPaxB+zg5UfQbk++Jn+tj1/TZV0dLu91ySvOanB2k4x1hK/L85FMZpunIqHnRj6r4+FB7cpGj0iTrfjN/pGWbFvC8gyWqJa+SRzcO5c7hEh+o9PmsumTVOaz9smhHTA=
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1823.namprd12.prod.outlook.com (10.175.55.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 4 Dec 2019 16:08:30 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f%3]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 16:08:30 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Lucas Stach <dev@lynxeye.de>, Kai-Heng Feng <kai.heng.feng@canonical.com>, 
 "joro@8bytes.org" <joro@8bytes.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
Thread-Topic: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
Thread-Index: AQHVpsBguKm4D8iWWkiQt39oc44V0aelPBeAgAHRwGCAAx4xYA==
Date: Wed, 4 Dec 2019 16:08:30 +0000
Message-ID: <MWHPR12MB135851B49EEDEE17DE873506F75D0@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <20191129142154.29658-1-kai.heng.feng@canonical.com>
 <5b2097e8c4172a8516fcfc8c56dc98e3d105ffe2.camel@lynxeye.de>
 <MWHPR12MB1358891F2AC2AAA41E9BA835F7430@MWHPR12MB1358.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR12MB1358891F2AC2AAA41E9BA835F7430@MWHPR12MB1358.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81a79a65-7d2d-48c3-1966-08d778d4347d
x-ms-traffictypediagnostic: MWHPR12MB1823:|MWHPR12MB1823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB18238431C93C6C3827154F69F75D0@MWHPR12MB1823.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(13464003)(189003)(199004)(186003)(6636002)(52536014)(2501003)(45080400002)(6116002)(6506007)(53546011)(498600001)(25786009)(26005)(102836004)(14454004)(4326008)(966005)(99286004)(64756008)(6246003)(110136005)(86362001)(54906003)(66476007)(66556008)(66946007)(76116006)(66446008)(81166006)(81156014)(8676002)(8936002)(11346002)(5660300002)(305945005)(6306002)(9686003)(7736002)(71190400001)(3846002)(229853002)(55016002)(33656002)(71200400001)(6436002)(74316002)(7696005)(14444005)(2906002)(76176011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1823;
 H:MWHPR12MB1358.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BcZgiAlnLXvSDZJdiG6U8Y9RmhdGgbmyQp/5FBEoDe6nWYnRZW7QE9vSs4xGp5YtH4rBn8e4vsmYM90R/w6oTOrFoGnBEbWaG5cJZpnbV7ka/7bYXKDLBAyCMrisAMCmBZBvdPPVVBj/GJRTdnHD05kB/dE2xEHQfeCmoRdAgLsUwERmq0zCKpGFmyUiw6Y1V/b0GLVYVHTg9tpkpkkt9QGVMhx1rsnei2wKTvcQ4CwF8BF2hqyyUwQbkKKjqRdJWAgt1dadvRM9egYYJT+yQ5TVgZHWOEB4UBOEMu1BFqknCqNzpAI0xL8Hj9R9QXOWdE2Yeyu4ihKKmxCt3WJq1yscWc4j8rBnLnZbckl39AQa71gXrdIKFdsVbiZfdCf1+sEcadkX6TyWs/GH3ou79xduttTkHdtBXNkLVMBCSRKWNYYUnnHgERQ7fyfIx6tsGuDmBOIkH2FJJ9e9j+LdEgcIH49PzyBGHfn989bl72ZKaGLHGw2udq5dO+7oQefGYwyhNSgq2/r3xHJe0gLAZjXmp7aXFquU8vbf2P0R4Yg=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a79a65-7d2d-48c3-1966-08d778d4347d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 16:08:30.3328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uSDg7NAOxAT2/o/PzawoIo8wLl4wUwT9mlHOumoitwDIFrBapwL1EOIF4O2IJK9SSBOqrpNOxYkxsme5iawZ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1823
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

> -----Original Message-----
> From: Deucher, Alexander
> Sent: Monday, December 2, 2019 11:37 AM
> To: Lucas Stach <dev@lynxeye.de>; Kai-Heng Feng
> <kai.heng.feng@canonical.com>; joro@8bytes.org; Koenig, Christian
> (Christian.Koenig@amd.com) <Christian.Koenig@amd.com>
> Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge
> systems
> 
> > -----Original Message-----
> > From: Lucas Stach <dev@lynxeye.de>
> > Sent: Sunday, December 1, 2019 7:43 AM
> > To: Kai-Heng Feng <kai.heng.feng@canonical.com>; joro@8bytes.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
> > iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge
> > systems
> >
> > Am Freitag, den 29.11.2019, 22:21 +0800 schrieb Kai-Heng Feng:
> > > Serious screen flickering when Stoney Ridge outputs to a 4K monitor.
> > >
> > > According to Alex Deucher, IOMMU isn't enabled on Windows, so let's
> > > do the same here to avoid screen flickering on 4K monitor.
> >
> > This doesn't seem like a good solution, especially if there isn't a
> > method for the user to opt-out.  Some users might prefer having the
> > IOMMU support to 4K display output.
> >
> > But before using the big hammer of disabling or breaking one of those
> > features, we should take a look at what's the issue here. Screen
> > flickering caused by the IOMMU being active hints to the IOMMU not
> > being able to sustain the translation bandwidth required by the high-
> > bandwidth isochronous transfers caused by 4K scanout, most likely due
> > to insufficient TLB space.
> >
> > As far as I know the framebuffer memory for the display buffers is
> > located in stolen RAM, and thus contigous in memory. I don't know the
> > details of the GPU integration on those APUs, but maybe there even is
> > a way to bypass the IOMMU for the stolen VRAM regions?
> >
> > If there isn't and all GPU traffic passes through the IOMMU when
> > active, we should check if the stolen RAM is mapped with hugepages on
> > the IOMMU side. All the stolen RAM can most likely be mapped with a
> > few hugepage mappings, which should reduce IOMMU TLB demand by a
> large margin.
> 
> The is no issue when we scan out of the carve out region.  The issue occurs
> when we scan out of regular system memory (scatter/gather).  Many newer
> laptops have very small carve out regions (e.g., 32 MB), so we have to use
> regular system pages to support multiple high resolution displays.  The
> problem is, the latency gets too high at some point when the IOMMU is
> involved.  Huge pages would probably help in this case, but I'm not sure if
> there is any way to guarantee that we get huge pages for system memory.  I
> guess we could use CMA or something like that.

Thomas recently sent out a patch set to add huge page support to ttm:
https://patchwork.freedesktop.org/series/70090/
We'd still need a way to guarantee huge pages for the display buffer.

Alex

> 
> Alex
> 
> >
> > Regards,
> > Lucas
> >
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Bug:
> > >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgi
> > > tl
> > >
> >
> ab.freedesktop.org%2Fdrm%2Famd%2Fissues%2F961&amp;data=02%7C01%
> > 7Calexa
> > >
> >
> nder.deucher%40amd.com%7C30540b2bf2be417c4d9508d7765bf07f%7C3dd
> > 8961fe4
> > >
> >
> 884e608e11a82d994e183d%7C0%7C0%7C637108010075463266&amp;sdata=1
> > ZIZUWos
> > > cPiB4auOY10jlGzoFeWszYMDBQG0CtrrOO8%3D&amp;reserved=0
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > > v2:
> > > - Find Stoney graphics instead of host bridge.
> > >
> > >  drivers/iommu/amd_iommu_init.c | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iommu/amd_iommu_init.c
> > > b/drivers/iommu/amd_iommu_init.c index 568c52317757..139aa6fdadda
> > > 100644
> > > --- a/drivers/iommu/amd_iommu_init.c
> > > +++ b/drivers/iommu/amd_iommu_init.c
> > > @@ -2516,6 +2516,7 @@ static int __init early_amd_iommu_init(void)
> > >  	struct acpi_table_header *ivrs_base;
> > >  	acpi_status status;
> > >  	int i, remap_cache_sz, ret = 0;
> > > +	u32 pci_id;
> > >
> > >  	if (!amd_iommu_detected)
> > >  		return -ENODEV;
> > > @@ -2603,6 +2604,16 @@ static int __init early_amd_iommu_init(void)
> > >  	if (ret)
> > >  		goto out;
> > >
> > > +	/* Disable IOMMU if there's Stoney Ridge graphics */
> > > +	for (i = 0; i < 32; i++) {
> > > +		pci_id = read_pci_config(0, i, 0, 0);
> > > +		if ((pci_id & 0xffff) == 0x1002 && (pci_id >> 16) == 0x98e4) {
> > > +			pr_info("Disable IOMMU on Stoney Ridge\n");
> > > +			amd_iommu_disabled = true;
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > >  	/* Disable any previously enabled IOMMUs */
> > >  	if (!is_kdump_kernel() || amd_iommu_disabled)
> > >  		disable_iommus();
> > > @@ -2711,7 +2722,7 @@ static int __init state_next(void)
> > >  		ret = early_amd_iommu_init();
> > >  		init_state = ret ? IOMMU_INIT_ERROR :
> > IOMMU_ACPI_FINISHED;
> > >  		if (init_state == IOMMU_ACPI_FINISHED &&
> > amd_iommu_disabled) {
> > > -			pr_info("AMD IOMMU disabled on kernel command-
> > line\n");
> > > +			pr_info("AMD IOMMU disabled\n");
> > >  			init_state = IOMMU_CMDLINE_DISABLED;
> > >  			ret = -EINVAL;
> > >  		}

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
