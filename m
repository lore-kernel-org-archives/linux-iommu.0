Return-Path: <SRS0=eKRE=6H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0634C2BA19
	for <iommu@archiver.kernel.org>; Thu, 23 Apr 2020 10:31:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869092076C
	for <iommu@archiver.kernel.org>; Thu, 23 Apr 2020 10:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S4S6Hd8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869092076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3791987DF9;
	Thu, 23 Apr 2020 10:31:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hhYoyHLSzsna; Thu, 23 Apr 2020 10:31:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D540084FAE;
	Thu, 23 Apr 2020 10:31:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C30B4C1797;
	Thu, 23 Apr 2020 10:31:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1516C0175
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 10:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 917AC2271C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 10:31:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G7ybvrIQ-rJg for <iommu@lists.linux-foundation.org>;
 Thu, 23 Apr 2020 10:31:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
 by silver.osuosl.org (Postfix) with ESMTPS id 37935226CF
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 10:31:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuT7Ycb122/IVmOUW81z3Rpc3WnGVd3Li1CVh25v158YcbWsfglr21urOVcnH8DVcIXP12SoRz9iiM1MZgo2JXILVUjNl68Chs3X8NI3KaYuacqI+sjJnr7XF/GR1BDk0t9NuLzXX8C8BCdKlsRbquu3h6Rp70MwscR9vQNaAhGIm5wWBaeatfBwoGlARyuBz4yOe/YCZ+J831EWl3AaYy+AdIdXFfHu4b/eK+K6am5QnH68hgaLmh6eQQVILcf5EKXsF3dGI0aoUq+bpWBW7qGUqGwLB2W77vTgZjOQfbobfzeHGeYMb248E3hX15e181/e+gqCRiCLmhvgFM/orQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6M5qOQdvppJ/csGHgi8tL9TScfquoj4T7qYwMmjc7Ig=;
 b=E35L/FNDkLgHGPLkSNAYVcJelMg7ezDzR1wO6XkkKay+xDZgg80hdmqp2hrOj3HgIGBGYObhIb/ntoP6l5WlM4LaMcjJGEmzzgKMcF2nuL1W3QIhzmfFE3QSExotVRRW5ucFx8EHWYzbNE3AXxP5lCUaOwFr0SSOLmivDjp5lBOCvkq9pDhH73UG2kPQC7AixyqcbHi+a+VVO1ngif7vxjSKE0E+7QM30D/bCManZifnbA3AcG1CpAGOFDRsUx5Lyif2y8XqG+JotKWV4AvVPpiiBn9ylTlxEPxBWMwPxT6arqEYqkhzur2MHYaLeqMfVdC2VYLW95U55+oQrvZ5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6M5qOQdvppJ/csGHgi8tL9TScfquoj4T7qYwMmjc7Ig=;
 b=S4S6Hd8h1u5CGSDREn1Y5GWUepGX2QAj7G51IR/+ESxX/fFP1co7LRx5aDPIs23zMD2wO2IlzLY2r5ynTqGx+KUHYTqzbDxXvRpWIBUvoAjU2FHgP95i83qzk/RUglKMQFkzJ6W6eGJtLaLb97GdcAUP9kUmwWGT1dh+np25NSo=
Received: from DB7PR04MB4986.eurprd04.prod.outlook.com (2603:10a6:10:13::25)
 by DB7PR04MB4812.eurprd04.prod.outlook.com (2603:10a6:10:1f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 09:56:54 +0000
Received: from DB7PR04MB4986.eurprd04.prod.outlook.com
 ([fe80::4a9:a633:614e:e055]) by DB7PR04MB4986.eurprd04.prod.outlook.com
 ([fe80::4a9:a633:614e:e055%5]) with mapi id 15.20.2921.030; Thu, 23 Apr 2020
 09:56:54 +0000
From: Makarand Pawagi <makarand.pawagi@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [EXT] Re: [RFC PATCH 1/4] bus: fsl-mc: add custom .dma_configure
 implementation
Thread-Topic: [EXT] Re: [RFC PATCH 1/4] bus: fsl-mc: add custom .dma_configure
 implementation
Thread-Index: AQHWEzzGCphWxMVUqEOo/dCSUI/lE6h6cPgAgAqNkhA=
Date: Thu, 23 Apr 2020 09:56:54 +0000
Message-ID: <DB7PR04MB4986A6CBC2EE03D8BA8D32DEEBD30@DB7PR04MB4986.eurprd04.prod.outlook.com>
References: <20200227100542.13819-1-laurentiu.tudor@nxp.com>
 <20200325125109.GA5430@red-moon.cambridge.arm.com>
 <499fbf9a-416f-d7c7-0655-881d92138a6c@nxp.com>
 <20200414143211.GA14905@red-moon.cambridge.arm.com>
 <d37ca4e3-58cb-9d6f-3a98-5e4a21ca948b@nxp.com>
 <78086898-d54f-63d0-f1f4-301ef2a8ea83@arm.com>
In-Reply-To: <78086898-d54f-63d0-f1f4-301ef2a8ea83@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=makarand.pawagi@nxp.com; 
x-originating-ip: [122.169.134.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f998f85-c0c4-4c5b-8b28-08d7e76ca756
x-ms-traffictypediagnostic: DB7PR04MB4812:|DB7PR04MB4812:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB481222A30925551CD83C252FEBD30@DB7PR04MB4812.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4986.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(7416002)(478600001)(76116006)(66946007)(186003)(8676002)(54906003)(110136005)(4326008)(44832011)(30864003)(5660300002)(71200400001)(33656002)(316002)(55016002)(7696005)(86362001)(9686003)(6506007)(66446008)(2906002)(64756008)(66476007)(66556008)(81156014)(53546011)(26005)(8936002)(52536014)(142923001);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PMVkYYNAgqYW2g0DiJb4Kxis3MYiPExxcHDNnazZ3Rf4lM7Ipe4Xr9Vq9JdFTmivBo5aRp2a1uuqe77LLcN1hnnjsY68YIMtsqPtn/cxv1UITnrjaM+Vn0KH9GHwWlBeJ4JT90i4K11aGQ8IsWSHYFeVeUiXqRiwF8ogdHmQdpk33nR0i3+6rZ9/Udz3cc5QYI58Gk8vV+ea/QcQE1WK6B2LeMq3Wn1v2wR36ytNxaBgUjqXpoRmLcR2ol9vnT4sEAiWOOHkfpM7CuO+qMNxnL/fCz8zBuxFgttXqPt4R6032We6xP9vopfmtdn4fqOEjkbXdoqFHPMBk3LreYWwiFsdXpi/0NeaOxqeP5H1f5JsYui4HxLoeFBHzSnFcGGJgB6pm2mf99AW4kIoMfqSUW8x5ir3OrdS6qShgOzE4b6DnJvGZoMwCTo/IN19SG9Z2Kf7sKVrhAWosEwuTOKUwGpWwItx3BiMKwfqjG5phOgahe2/nEHsoeDYBwIte9Nk
x-ms-exchange-antispam-messagedata: lZjPInxyBxucXg0VxA67rbdjsOH9Z1ltOmn5HYZ1pJDe/Whc3KA0Qevvxq0kwFqxRhkxw6ACjRT3hB9WsOyIaklIDK4nprlDGWDUquDiZ63oaX/R3iCEv/XurCrIKsw+YpDH3AHSve0ndbR93a2gxg==
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f998f85-c0c4-4c5b-8b28-08d7e76ca756
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 09:56:54.2577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRth3hRQCYmb4GSlPwzvGVN4lsRabt2c3LKC+Z/qpwXaLML3eCnFsCfrEBs2Bpm5xaIfKwSuizLWN5rBk8ZSRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4812
Cc: Calvin Johnson <calvin.johnson@nxp.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>, Pankaj Bansal <pankaj.bansal@nxp.com>,
 "Diana Madalina Craciun \(OSS\)" <diana.craciun@oss.nxp.com>,
 "jon@solid-run.com" <jon@solid-run.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Cristi Sovaiala <cristian.sovaiala@nxp.com>,
 "jason@lakedaemon.net" <jason@lakedaemon.net>, Varun Sethi <V.Sethi@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "Stuart.Yoder@arm.com" <Stuart.Yoder@arm.com>
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
> From: Robin Murphy <robin.murphy@arm.com>
> Sent: Wednesday, April 15, 2020 11:02 PM
> To: Laurentiu Tudor <laurentiu.tudor@nxp.com>; Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>
> Cc: linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org; linux-arm-
> kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> ard.biesheuvel@linaro.org; Ioana Ciornei <ioana.ciornei@nxp.com>; Diana
> Madalina Craciun (OSS) <diana.craciun@oss.nxp.com>; maz@kernel.org;
> jon@solid-run.com; Pankaj Bansal <pankaj.bansal@nxp.com>; Makarand
> Pawagi <makarand.pawagi@nxp.com>; Calvin Johnson
> <calvin.johnson@nxp.com>; Varun Sethi <V.Sethi@nxp.com>; Cristi Sovaiala
> <cristian.sovaiala@nxp.com>; Stuart.Yoder@arm.com; jeremy.linton@arm.com;
> joro@8bytes.org; tglx@linutronix.de; jason@lakedaemon.net
> Subject: [EXT] Re: [RFC PATCH 1/4] bus: fsl-mc: add custom .dma_configure
> implementation
> 
> Caution: EXT Email
> 
> On 2020-04-15 4:44 pm, Laurentiu Tudor wrote:
> >
> >
> > On 4/14/2020 5:32 PM, Lorenzo Pieralisi wrote:
> >> On Wed, Mar 25, 2020 at 06:48:55PM +0200, Laurentiu Tudor wrote:
> >>> Hi Lorenzo,
> >>>
> >>> On 3/25/2020 2:51 PM, Lorenzo Pieralisi wrote:
> >>>> On Thu, Feb 27, 2020 at 12:05:39PM +0200, laurentiu.tudor@nxp.com
> wrote:
> >>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>>>>
> >>>>> The devices on this bus are not discovered by way of device tree
> >>>>> but by queries to the firmware. It makes little sense to trick the
> >>>>> generic of layer into thinking that these devices are of related
> >>>>> so that we can get our dma configuration. Instead of doing that,
> >>>>> add our custom dma configuration implementation.
> >>>>>
> >>>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>>>> ---
> >>>>>   drivers/bus/fsl-mc/fsl-mc-bus.c | 31
> ++++++++++++++++++++++++++++++-
> >>>>>   1 file changed, 30 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c
> >>>>> b/drivers/bus/fsl-mc/fsl-mc-bus.c index 36eb25f82c8e..eafaa0e0b906
> >>>>> 100644
> >>>>> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> >>>>> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> >>>>> @@ -132,11 +132,40 @@ static int fsl_mc_bus_uevent(struct device
> *dev, struct kobj_uevent_env *env)
> >>>>>   static int fsl_mc_dma_configure(struct device *dev)
> >>>>>   {
> >>>>>           struct device *dma_dev = dev;
> >>>>> + struct iommu_fwspec *fwspec;
> >>>>> + const struct iommu_ops *iommu_ops; struct fsl_mc_device *mc_dev
> >>>>> + = to_fsl_mc_device(dev); int ret;
> >>>>> + u32 icid;
> >>>>>
> >>>>>           while (dev_is_fsl_mc(dma_dev))
> >>>>>                   dma_dev = dma_dev->parent;
> >>>>>
> >>>>> - return of_dma_configure(dev, dma_dev->of_node, 0);
> >>>>> + fwspec = dev_iommu_fwspec_get(dma_dev); if (!fwspec)
> >>>>> +         return -ENODEV;
> >>>>> + iommu_ops = iommu_ops_from_fwnode(fwspec->iommu_fwnode);
> >>>>> + if (!iommu_ops)
> >>>>> +         return -ENODEV;
> >>>>> +
> >>>>> + ret = iommu_fwspec_init(dev, fwspec->iommu_fwnode, iommu_ops);
> >>>>> + if (ret)
> >>>>> +         return ret;
> >>>>> +
> >>>>> + icid = mc_dev->icid;
> >>>>> + ret = iommu_fwspec_add_ids(dev, &icid, 1);
> >>>>
> >>>> I see. So with this patch we would use the MC named component only
> >>>> to retrieve the iommu_ops
> >>>
> >>> Right. I'd also add that the implementation tries to follow the
> >>> existing standard .dma_configure implementations, e.g.
> >>> of_dma_configure + of_iommu_configure. I'd also note that similarly
> >>> to the ACPI case, this MC FW device is probed as a platform device
> >>> in the DT scenario, binding here [1].
> >>> A similar approach is used for the retrieval of the msi irq domain,
> >>> see following patch.
> >>>
> >>>> - the streamid are injected directly here bypassing OF/IORT bindings
> translations altogether.
> >>>
> >>> Actually I've submitted a v2 [2] that calls into .of_xlate() to
> >>> allow the smmu driver to do some processing on the raw streamid
> >>> coming from the firmware. I have not yet tested this with ACPI but
> >>> expect it to work, however, it's debatable how valid is this
> >>> approach in the context of ACPI.
> >>
> >> Actually, what I think you need is of_map_rid() (and an IORT
> >> equivalent, that I am going to write - generalizing iort_msi_map_rid()).
> >>
> >> Would that be enough to enable IORT "normal" mappings in the MC bus
> >> named components ?
> >>
> >
> > At a first glance, looks like this could very well fix the ACPI
> > scenario, but I have some unclarities on the approach:
> >   * are we going to rely in DT and ACPI generic layers even if these
> > devices are not published / enumerated through DT or ACPI tables?
> 
> Assuming you mean the DPRC devices rather than the MC itself, then yes; in that
> sense it's exactly the same as how we treat dynamically-discovered PCI devices.
> 
> >   * the firmware manages and provides discrete streamids for the
> > devices it exposes so there's no translation involved. There's no
> >     requestor_id / input_id involved but it seems that we would still
> > do some kind of translation relying for this on the DT/ACPI functions.
> 
> Wrong - last time I looked, what that firmware actually manages are
> *ICIDs* for the devices, not SMMU Stream IDs or GIC Device IDs; what DT/ACPI
> specifies is a translation from ICID to Stream ID/Device ID. The ICID is very much
> the requester/input ID for that translation. Yes, in practice the "translation" is
> effectively always a trivial identity mapping, but conceptually it most definitely
> exists. Yes, the subtlety is incredibly easy to overlook because it's basically
> drawing a distinction between one end of some wires vs. the other end, but it
> matters.
> 
> (and of course "trivial 1:1 translation" isn't even true in the case of SMMU
> Stream ID values, since IIRC they are really composed of 5 different inputs, only
> one of which is (part of) the incoming ICID)
> 
> >   * MC firmware has its own stream_id (e.g. on some chips 0x4000,
> > others 0xf00, so outside the range of stream_ids used for the mc devices)
> >     while for the devices on this bus, MC allocates stream_ids from a
> > range (e.g. 0x17 - 0x3f). Is it possible to describe this in the IORT table?
> 
> If it represents a unique ICID allocated to the MC itself, then sure, it simply goes
> through the mapping like anything else. Just like a PCI host bridge owns
> requester ID 0:0.0 and thus whatever Stream ID/Device ID that might map to.
> 
> If (for the sake of argument, because AIUI everything is an ICID in this particular
> case) it's some hard-wired thing that exists in Stream ID/Device ID space only,
> then it's a little trickier, but still in scope. In DT we have a lovely distinction
> between between "originating from the node" and "translated through the
> node", e.g. "msi-parent" vs.
> "msi-map"; IORT is not quite as clear-cut, but there are at least a few options. If
> the valid input ID space is smaller than 32 bits, then the "Named Component as
> bridge" binding could simply define special out-of-range values to represent IDs
> originating from the bridge itself, such that the NC driver knows what to do and
> from IORT's point of view everything is just a normal mapping. Alternatively
> there's already the example of SMMUv3 where we can have a mix of the normal
> mappings from Stream ID to Device ID for the upstream masters plus a single
> mapping for the SMMU's own Device ID - admittedly that depends on the
> additional SMMUv3-specific Device ID Mapping Index property, but if necessary
> it might be workable to have a de-facto interface for NCs that only considers
> single mappings when configuring the NC itself, and only considers normal
> mappings when configuring its children. Or maybe define a new mapping flag or
> NC property if there's a real need to specify such a situation unambiguously at
> the IORT level.
> 
> >   * Regarding the of_map_rid() use you mentioned, I was planning to
> > decouple the mc bus from the DT layer by dropping the use of
> > of_map_rid(), see patch 4.
> > I briefly glanced over the iort code and spotted this static function:
> > iort_iommu_xlate(). Wouldn't it also help, of course after making it public?
> 
> I won't speak for Lorenzo or claim we've agreed on an approach at all (not least
> because in all honesty we haven't really discussed it beyond these various email
> threads), but FWIW my vision is that ultimately the DT/ACPI code would expose
> a *_dma_configure() interface that takes an optional input ID, or (perhaps more
> likely) an explicit pair of interfaces for "configure this regular device" and
> "configure this device based on this 'host' device and this ID", and it becomes
> the bus code's responsibility to pass the right device(s) and deal with multiple IDs
> (i.e. for starters all the PCI alias stuff goes back to the PCI code where it really
> should be, rather than having multiple copies of magic PCI awareness deep
> down in DT/ACPI code).
> 
> Robin.
 
Hi Lorenzo, Robin,

What we definitely need is the correct representation of the MC in ACPI case. To achieve that we will define it as Platform Device but not with EFI_ACPI_IORT_ID_MAPPING_FLAGS_SINGLE.
Also for the Named Component Node we will have .NumIdMappings = 2. One mapping will have the range of IDs for DPRC device and a separate table will have the ID for MC device itself.

Having said this, the patch set which is currently under discussion doesn't cater this representation, but solution proposed by Lorenzo and Robin is in that direction only and we in theory agree to that.
But further to this needs few clarifications as well.

Now for ACPI case what we definitely need is the option to take Input ID into the consideration for Platform device if it is not with Single ID mapping flag. We can handle both MSI and IOMMU cases with that, and in fact a patch with this implementation for MSI is already posted by Pankaj and under review, and we would need similar approach for IOMMU case as well. I would appreciate if Lorenzo can elaborate more on how he is going to generalize iort_msi_map_rid() function.

For DT case, currently MC is represented as a separate bus just like PCI. It would not make sense to keep it that way while in ACPI case it is represented in a different way. Because of this we would like to take a similar approach with the DT as well.
Please post your patches with the changes you mentioned earlier, and meanwhile we will also do some PoC activity for both ACPI and DT case and will post a new set of patch with that.

--Thanks
Makarand






 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
