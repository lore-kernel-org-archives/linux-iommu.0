Return-Path: <SRS0=qRzs=4A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4A9C2BA83
	for <iommu@archiver.kernel.org>; Wed, 12 Feb 2020 03:28:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A7512086A
	for <iommu@archiver.kernel.org>; Wed, 12 Feb 2020 03:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g/hs2xrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7512086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6BF99851D6;
	Wed, 12 Feb 2020 03:28:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AMyoTm3LhBIF; Wed, 12 Feb 2020 03:27:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BC9BC848BE;
	Wed, 12 Feb 2020 03:27:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9084EC1D88;
	Wed, 12 Feb 2020 03:27:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D7AEC07FE
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 03:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3470E851CC
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 03:27:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ffOqQwtHhfHa for <iommu@lists.linux-foundation.org>;
 Wed, 12 Feb 2020 03:27:56 +0000 (UTC)
X-Greylist: delayed 00:59:31 by SQLgrey-1.7.6
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60078.outbound.protection.outlook.com [40.107.6.78])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D6A56848BE
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 03:27:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUUPMkkfXxhAy6rkhb9niDb4FrVk8Up3PGWsH+a5rbMIDH0Sc0ZZCDISZzYv2fOWylrhS8ukCMGJeRNK7cN8XjzzCi+5AQrqdblMZwGZ/BnqaAwpqwKvh7SzsCr38FrJ9yxEZ3ir2TauJgf2ogpY2Ogy4dPn9ryMS6xdtubjidf30V3vrbXP3+cTm/6VNViHyhqapaKwZmgDnHvt27UtnJUSLQ6f5WQH1hcHXcpCncjmOlCNFi/52fCxVSQpIAkaLflmby6O8iYO9KTXgrB+tbOj+jkwyp8zOLRQBZomvhwGtg/IHZ3l8kYjlD3rU03TuAFlBox8Bxi2ig8bFgkCZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIrScfj5oSK92dcySCablajZXmZL3F5YvZAAJ9pHalQ=;
 b=gU5FIcl6Tn8IiJIUjXw9qROPbgI9jyJTvKDCLZFS/iT1Zl9turDoskIybwafDP8giW7j9YlwPtSsOf/DV1ES8/2NCynRDZ+jGD3iLYz+WfGXTEfcEep9s+YV978UNRVEAjZzgtQDKJ9f6gs1EwLC4/krhGQpvVNXURWEQJYwqo4IrnCbeh4KTiPpxMK1uCQ3Z9K+O8mL/vIleehtcU+qal1hzT3cf1upP7balS9RXYOWqNaKQwxemV/mLDyL3B2OYOS3wF4ode+Pygo+DkOKgfDrxFJy/wrlUsI86hTDUL0iBbk3ez4G4/cJrm51ecGRJ/lfUFhu/db1j0MpKQfDDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIrScfj5oSK92dcySCablajZXmZL3F5YvZAAJ9pHalQ=;
 b=g/hs2xrfomDv/qNqZTx/SgLqEYv5eaTUMGwUYOT2IgqUA7QfCRwBZ0c9Ydb3oK0Db7nmIBF2OaJtiPh0f9HWvqdrdd8UyHfW6wpIQjrOg98o9b1E0jmSgZ1zKMUtoHiPmpVL37xYdNlbO/AjIKVVMekO9hA1XDJf+VHt6K4VzGw=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (20.179.234.30) by
 VE1PR04MB6670.eurprd04.prod.outlook.com (20.179.233.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Tue, 11 Feb 2020 23:56:01 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b896:5bc0:c4dd:bd23%2]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 23:56:01 +0000
From: Leo Li <leoyang.li@nxp.com>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: RE: [PATCH] iommu/arm-smmu: fix the module name for disable_bypass
 parameter
Thread-Topic: [PATCH] iommu/arm-smmu: fix the module name for disable_bypass
 parameter
Thread-Index: AQHV4TQ+rYAmxRjidEu7CIluqOuss6gWqE4AgAABt3A=
Date: Tue, 11 Feb 2020 23:56:01 +0000
Message-ID: <VE1PR04MB6687C1D26EF252554E8831AE8F180@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <1581464215-24777-1-git-send-email-leoyang.li@nxp.com>
 <20200211234536.GK25745@shell.armlinux.org.uk>
In-Reply-To: <20200211234536.GK25745@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1e6c1a86-82a7-420f-6428-08d7af4df2e9
x-ms-traffictypediagnostic: VE1PR04MB6670:
x-microsoft-antispam-prvs: <VE1PR04MB667081197ECDBC5C6B8A0A9E8F180@VE1PR04MB6670.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(186003)(8936002)(45080400002)(26005)(54906003)(4326008)(8676002)(6506007)(53546011)(6916009)(5660300002)(966005)(71200400001)(7696005)(81156014)(81166006)(64756008)(2906002)(66946007)(66556008)(316002)(66446008)(66476007)(76116006)(33656002)(9686003)(52536014)(478600001)(55016002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6670;
 H:VE1PR04MB6687.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ztammonGeAXeH6VfVfI75OVV9Khhg2PnA3qnNZF+hE2F7C+nYU5c3qHBwovwo3EAkNvDrS3XCkdBEK3VNdPs0kvzD/zbThOvKYKNlamYeNp27s5RpVXMGO1OQ9e3knO9Maq5Uk1CV4IkmN2g5DNGr8nMRdVLqVFccM7LFwOk+tjX/P9NCKouBFC4EAFxJhJNKiEDZWuvmmCGmOTD6EoPXNDlzu9SbHVETrl1Ixom8hIhoTGYiHvqAln1dz+s8HxDp4/DaQF1ZrCeeJZRyJkfMqWtr22MV6n2Jm0eEpRvfklhQZl03S2DTD6jgR4iWzeqhNUwhuevdc9WG+5Fx8+NEzctWmZTq0PHAbbndLLkg4FPXqHyHV66bSJMZ90yFuFkErGTYRwmxSGEkHKmIY0B2VNuaRTNSCA32b+bJJxLTd+wVZ59TGUpZKbudi+G2RLdyf9OPOzD70otFnBPnCJQHilfasF2IYzkUkrhVFN0JCIrhGpdlU+jV+nYUdvMLa9Q0liP5L5J/99b+O4SyUr2dLMZCdoSnAdZ7+7DHNtxXB24/dHrEhUedT9A1b65NvLxy/adWqUVZxRXp6bs1kcQxErwSbyLpFYvCpDYk51EtdDscWa5ffkdeGGQ0s/YAepm
x-ms-exchange-antispam-messagedata: BkORNlyxH41qiXXhcidUxmJcBMdv7dGvLWU1860RdsTyfCzN2K55PQr0tIPa/MuAZ2vxF22Atih2FtmHoW2vPH1KE2iIaDc1oKaOuGfvNjbQH1MeRuy+IeflSg5zfhAlxHuTe41KZj2Q8eAefX27dg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6c1a86-82a7-420f-6428-08d7af4df2e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 23:56:01.7639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iyxPkrevjxiisfczejcN9OmIDRHs9h1T+fof3GyEwX9KTL+/ZGmKR8vlU4OVFMFINhz/uNVzF3shhcjZyMygkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6670
Cc: Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
> From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
> Sent: Tuesday, February 11, 2020 5:46 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Joerg Roedel <joro@8bytes.org>; Will Deacon <will.deacon@arm.com>;
> Robin Murphy <robin.murphy@arm.com>; iommu@lists.linux-
> foundation.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH] iommu/arm-smmu: fix the module name for
> disable_bypass parameter
> 
> On Tue, Feb 11, 2020 at 05:36:55PM -0600, Li Yang wrote:
> > Since commit cd221bd24ff5 ("iommu/arm-smmu: Allow building as a
> > module"), there is a side effect that the module name is changed from
> > arm-smmu to arm-smmu-mod.  So the kernel parameter for
> disable_bypass
> > need to be changed too.  Fix the Kconfig help and error message to the
> > correct parameter name.
> 
> Hmm, this seems to be a user-visible change - so those of us who have been
> booting with "arm-smmu.disable_bypass=0" now need to change that
> depending on which kernel is being booted - which is not nice, and makes
> the support side on platforms that need this kernel parameter harder.

I agree.  Probably a better fix is to update the Makefile to change the module name back to the original one.

Regards,
Leo

> 
> >
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > ---
> >  drivers/iommu/Kconfig    | 2 +-
> >  drivers/iommu/arm-smmu.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig index
> > d2fade984999..fb54be903c60 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -415,7 +415,7 @@ config
> ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
> >  	  hardcode the bypass disable in the code.
> >
> >  	  NOTE: the kernel command line parameter
> > -	  'arm-smmu.disable_bypass' will continue to override this
> > +	  'arm-smmu-mod.disable_bypass' will continue to override this
> >  	  config.
> >
> >  config ARM_SMMU_V3
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index
> > 16c4b87af42b..2ffe8ff04393 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -512,7 +512,7 @@ static irqreturn_t arm_smmu_global_fault(int irq,
> void *dev)
> >  		if
> (IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT) &&
> >  		    (gfsr & ARM_SMMU_sGFSR_USF))
> >  			dev_err(smmu->dev,
> > -				"Blocked unknown Stream ID 0x%hx; boot
> with \"arm-smmu.disable_bypass=0\" to allow, but this may have security
> implications\n",
> > +				"Blocked unknown Stream ID 0x%hx; boot
> with
> > +\"arm-smmu-mod.disable_bypass=0\" to allow, but this may have
> > +security implications\n",
> >  				(u16)gfsynr1);
> >  		else
> >  			dev_err(smmu->dev,
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists
> > .infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-
> kernel&amp;data=02%7C0
> >
> 1%7Cleoyang.li%40nxp.com%7Cf2f7f3c7c8fa4df0fb0608d7af4c84d1%7C686ea
> 1d3
> >
> bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637170615487429054&amp;sdata=
> NO4VZ1
> > sSMKyeXiL%2BUc5K6gIW5Uld%2BRsGAICLgI2nnd8%3D&amp;reserved=0
> >
> 
> --
> RMK's Patch system:
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww
> .armlinux.org.uk%2Fdeveloper%2Fpatches%2F&amp;data=02%7C01%7Cleoy
> ang.li%40nxp.com%7Cf2f7f3c7c8fa4df0fb0608d7af4c84d1%7C686ea1d3bc2b4
> c6fa92cd99c5c301635%7C0%7C0%7C637170615487429054&amp;sdata=eMRT
> wZGZPeq3DvkBwjBjGbsS1Qsy3LYMnjH%2B9FJm2aE%3D&amp;reserved=0
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps
> up According to speedtest.net: 11.9Mbps down 500kbps up
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
