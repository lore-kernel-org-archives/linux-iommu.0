Return-Path: <SRS0=Z2AP=ZY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC9DC432C3
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 16:36:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1728C2071F
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 16:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VsG4B7Fm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1728C2071F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D5FCD20768;
	Mon,  2 Dec 2019 16:36:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LCydCydAfpEv; Mon,  2 Dec 2019 16:36:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C7B3B20551;
	Mon,  2 Dec 2019 16:36:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A12E8C1797;
	Mon,  2 Dec 2019 16:36:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67DBFC087F
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 16:36:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 45BF820768
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 16:36:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ka0aSgpGnxKG for <iommu@lists.linux-foundation.org>;
 Mon,  2 Dec 2019 16:36:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750047.outbound.protection.outlook.com [40.107.75.47])
 by silver.osuosl.org (Postfix) with ESMTPS id 837EE20551
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 16:36:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHhdbGOL8+OvYev3Q5h8mY/CrA8mfSLJEVvNd5SY3VcOeF8DPjHTJNS/UhkEdIIzIk8pqAdmitWw8LVy5Vq44Nizt07tUE0LOrnwcz2lzd9xMoUyFKso+kgBO5wIdh9CJZXwTAtvQ4oMoxjuqVDCuZANzaZiUB/7pkoExIJMOZyKDThP15V6w/Pn+sWBHUofKY4AsvA/fGzjsWVhjZ2CRy7ZVdZKP9veSBGdWyLCsNFocQGLirQIFhXoP5OhdHEXrDBxgyJJKCfSokuZViE8IONbsYX0n59HOYa1ySqcOrE+Eryw6S2cL1lwMmuI03aJBmcJmB/AMzQMpx2n92o30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx5YWtc6I5Mg9xMqRc4g5g0bNtSPaKsedMJs0Dvfzfc=;
 b=AqpTZnWnKaFEwdLu2j+NzVWZTSxrG4m02ErJoAmDpEN7T8WgafFhlVj+oDVAArU7iZDv/1Pbll2YgCkP+NtDIARJIRVy0hpdoSOe0a0hJqqrJ2o/etAzWhuql9vhjkCyILCeQb/H8KvEgaOJdmTChGfGh2j1mbaO2/OMVcmKNMOt1WiKL9eeTk/1ai3k9o+Q3wksA87CtoXaUFRcquUOv4olnOPbx/VaPQx0QNgAyCZEp3KU8m62MRc4Ms2h2OKnAsw6uOCsOBDjqlEv+kYn5mVCyFU9zHeEZ77rcEQ3nsjkhT6D7pw90rLaZ3EGsIVWD3NERZed3NgVVJspK/iZ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx5YWtc6I5Mg9xMqRc4g5g0bNtSPaKsedMJs0Dvfzfc=;
 b=VsG4B7FmJOJS8J45OCIGpbEQsrLzsBQs5uhQoyD9TBlP16GkRcvAujOFPSDRGk4QQdnfykDnh4g2rMRuh7msuiSl5qZpzu5Q6u9nWGqjWMayVqBsJMVb3KvyeuqhdSZ6jiPqORHE1MlJjvwEb99BMu73YB2fAm7XWc04rML0lXQ=
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1936.namprd12.prod.outlook.com (10.175.56.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 16:36:43 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 16:36:42 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Lucas Stach <dev@lynxeye.de>, Kai-Heng Feng <kai.heng.feng@canonical.com>, 
 "joro@8bytes.org" <joro@8bytes.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
Thread-Topic: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
Thread-Index: AQHVpsBguKm4D8iWWkiQt39oc44V0aelPBeAgAHRwGA=
Date: Mon, 2 Dec 2019 16:36:42 +0000
Message-ID: <MWHPR12MB1358891F2AC2AAA41E9BA835F7430@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <20191129142154.29658-1-kai.heng.feng@canonical.com>
 <5b2097e8c4172a8516fcfc8c56dc98e3d105ffe2.camel@lynxeye.de>
In-Reply-To: <5b2097e8c4172a8516fcfc8c56dc98e3d105ffe2.camel@lynxeye.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea1878a8-fac6-4dc2-0a8b-08d77745d074
x-ms-traffictypediagnostic: MWHPR12MB1936:|MWHPR12MB1936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1936F823EA139D6808CE64BBF7430@MWHPR12MB1936.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(189003)(199004)(13464003)(110136005)(54906003)(5660300002)(6636002)(7736002)(256004)(14444005)(71190400001)(55016002)(6506007)(81156014)(71200400001)(6436002)(33656002)(4326008)(66066001)(6246003)(14454004)(478600001)(966005)(2501003)(86362001)(25786009)(2906002)(3846002)(45080400002)(6116002)(6306002)(66946007)(316002)(9686003)(229853002)(66556008)(76176011)(66446008)(7696005)(52536014)(76116006)(74316002)(305945005)(11346002)(446003)(99286004)(186003)(26005)(81166006)(66476007)(102836004)(8676002)(8936002)(64756008)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1936;
 H:MWHPR12MB1358.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2IaOJCxpBgPn0lbPxuRo/l6ThleHjqnL1vofXGVZbThg0zpTnxvwXpg2lIF1peRAnvyfFfJoH4go0h3HUn7pmpTNtLYORWUH7Y2uRSgN+ceO6YcQ81nwvT5yERm91OQ8y/uv1GwNL8iBUyii692zsBykxRToOKhnzT5ank8kd//pRVDeVYtyiCyb7TSd8qANzEUrGoEvSNaYt6cGa25L/4R+wcygs/enI6XYlwm35A6isl6mP6voK+jdANSIj26a9d/fnVebDrOy6b4i37nEw0RSARQU+b2OxsO6pNa9Gnto34a/Ss7j7a77fEomD5yJvlusxe2tBiRhxOXcz0rbeLluDacOA0bY+0zRGlufpFxnTAL402RO3qgXChxSgGwFr0X7KpkhcUpiq1SqsqGBbW3HU6nwqjNWOYV5kMBc2Ma/r6J4+UnJjFGkenJdZqxz
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1878a8-fac6-4dc2-0a8b-08d77745d074
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 16:36:42.8789 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: orAiYRdyKAfQ90R3JcERFzyfs/zbILTXFtow24+3lpVgoGkp2V/p5picH1FEQmSROdSWjlqfbWXlPrHoGgprIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1936
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
> From: Lucas Stach <dev@lynxeye.de>
> Sent: Sunday, December 1, 2019 7:43 AM
> To: Kai-Heng Feng <kai.heng.feng@canonical.com>; joro@8bytes.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge
> systems
> 
> Am Freitag, den 29.11.2019, 22:21 +0800 schrieb Kai-Heng Feng:
> > Serious screen flickering when Stoney Ridge outputs to a 4K monitor.
> >
> > According to Alex Deucher, IOMMU isn't enabled on Windows, so let's do
> > the same here to avoid screen flickering on 4K monitor.
> 
> This doesn't seem like a good solution, especially if there isn't a method for
> the user to opt-out.  Some users might prefer having the IOMMU support to
> 4K display output.
> 
> But before using the big hammer of disabling or breaking one of those
> features, we should take a look at what's the issue here. Screen flickering
> caused by the IOMMU being active hints to the IOMMU not being able to
> sustain the translation bandwidth required by the high- bandwidth
> isochronous transfers caused by 4K scanout, most likely due to insufficient
> TLB space.
> 
> As far as I know the framebuffer memory for the display buffers is located in
> stolen RAM, and thus contigous in memory. I don't know the details of the
> GPU integration on those APUs, but maybe there even is a way to bypass the
> IOMMU for the stolen VRAM regions?
> 
> If there isn't and all GPU traffic passes through the IOMMU when active, we
> should check if the stolen RAM is mapped with hugepages on the IOMMU
> side. All the stolen RAM can most likely be mapped with a few hugepage
> mappings, which should reduce IOMMU TLB demand by a large margin.

The is no issue when we scan out of the carve out region.  The issue occurs when we scan out of regular system memory (scatter/gather).  Many newer laptops have very small carve out regions (e.g., 32 MB), so we have to use regular system pages to support multiple high resolution displays.  The problem is, the latency gets too high at some point when the IOMMU is involved.  Huge pages would probably help in this case, but I'm not sure if there is any way to guarantee that we get huge pages for system memory.  I guess we could use CMA or something like that.

Alex

> 
> Regards,
> Lucas
> 
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Bug:
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitl
> >
> ab.freedesktop.org%2Fdrm%2Famd%2Fissues%2F961&amp;data=02%7C01%
> 7Calexa
> >
> nder.deucher%40amd.com%7C30540b2bf2be417c4d9508d7765bf07f%7C3dd
> 8961fe4
> >
> 884e608e11a82d994e183d%7C0%7C0%7C637108010075463266&amp;sdata=1
> ZIZUWos
> > cPiB4auOY10jlGzoFeWszYMDBQG0CtrrOO8%3D&amp;reserved=0
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v2:
> > - Find Stoney graphics instead of host bridge.
> >
> >  drivers/iommu/amd_iommu_init.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/amd_iommu_init.c
> > b/drivers/iommu/amd_iommu_init.c index 568c52317757..139aa6fdadda
> > 100644
> > --- a/drivers/iommu/amd_iommu_init.c
> > +++ b/drivers/iommu/amd_iommu_init.c
> > @@ -2516,6 +2516,7 @@ static int __init early_amd_iommu_init(void)
> >  	struct acpi_table_header *ivrs_base;
> >  	acpi_status status;
> >  	int i, remap_cache_sz, ret = 0;
> > +	u32 pci_id;
> >
> >  	if (!amd_iommu_detected)
> >  		return -ENODEV;
> > @@ -2603,6 +2604,16 @@ static int __init early_amd_iommu_init(void)
> >  	if (ret)
> >  		goto out;
> >
> > +	/* Disable IOMMU if there's Stoney Ridge graphics */
> > +	for (i = 0; i < 32; i++) {
> > +		pci_id = read_pci_config(0, i, 0, 0);
> > +		if ((pci_id & 0xffff) == 0x1002 && (pci_id >> 16) == 0x98e4) {
> > +			pr_info("Disable IOMMU on Stoney Ridge\n");
> > +			amd_iommu_disabled = true;
> > +			break;
> > +		}
> > +	}
> > +
> >  	/* Disable any previously enabled IOMMUs */
> >  	if (!is_kdump_kernel() || amd_iommu_disabled)
> >  		disable_iommus();
> > @@ -2711,7 +2722,7 @@ static int __init state_next(void)
> >  		ret = early_amd_iommu_init();
> >  		init_state = ret ? IOMMU_INIT_ERROR :
> IOMMU_ACPI_FINISHED;
> >  		if (init_state == IOMMU_ACPI_FINISHED &&
> amd_iommu_disabled) {
> > -			pr_info("AMD IOMMU disabled on kernel command-
> line\n");
> > +			pr_info("AMD IOMMU disabled\n");
> >  			init_state = IOMMU_CMDLINE_DISABLED;
> >  			ret = -EINVAL;
> >  		}

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
