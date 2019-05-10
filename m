Return-Path: <SRS0=MPmd=TK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40582C04A6B
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 13:19:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F4FC2177B
	for <iommu@archiver.kernel.org>; Fri, 10 May 2019 13:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cJF7GBJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4FC2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BDE9BE60;
	Fri, 10 May 2019 13:19:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C552BDA8
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 13:19:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-eopbgr150043.outbound.protection.outlook.com [40.107.15.43])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 19725831
	for <iommu@lists.linux-foundation.org>;
	Fri, 10 May 2019 13:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=FMreRoyjvzdaBHHwIpcoxTjZVm7qt64uXdzQIJ+ePgY=;
	b=cJF7GBJ675FWn2Pt6sBCfatFDpOT3ZwXz59id0Gc0UarysJaSbTx2ogOybK9fHW6Mhxpe+7EenaP+7ZaBlM9pVqORm82yomR31ES2gpGiOitHkob2rhGecdhl0c97ARF2OAJol4pDVDkdyCRwZYfIlP9W+vYehKzSu6NhPwOTDs=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
	VI1PR0401MB2351.eurprd04.prod.outlook.com (10.169.133.154) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1878.20; Fri, 10 May 2019 13:19:06 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
	([fe80::5e3:7122:7d0e:7fb7]) by
	VI1PR0401MB2496.eurprd04.prod.outlook.com
	([fe80::5e3:7122:7d0e:7fb7%3]) with mapi id 15.20.1878.022;
	Fri, 10 May 2019 13:19:05 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>
Subject: RE: [ARM SMMU] Dynamic StreamID allocation
Thread-Topic: [ARM SMMU] Dynamic StreamID allocation
Thread-Index: AdUHKxeT0UQZA1BdS6SusO/TAZQ/qAAB0c5w
Date: Fri, 10 May 2019 13:19:05 +0000
Message-ID: <VI1PR0401MB24962EFD4057D823075230C6F10C0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
References: <VI1PR0401MB24969CE24E4FB91EC8551DEBF10C0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0401MB24969CE24E4FB91EC8551DEBF10C0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=pankaj.bansal@nxp.com; 
x-originating-ip: [92.120.0.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6eaf08c-4a57-45ff-fa2a-08d6d54a1407
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:VI1PR0401MB2351; 
x-ms-traffictypediagnostic: VI1PR0401MB2351:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <VI1PR0401MB235198040DCA0B3957DEF05EF10C0@VI1PR0401MB2351.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(376002)(396003)(136003)(366004)(346002)(13464003)(199004)(189003)(7696005)(54906003)(110136005)(25786009)(33656002)(8936002)(6306002)(81166006)(81156014)(476003)(8676002)(486006)(11346002)(2940100002)(53936002)(99286004)(74316002)(7736002)(316002)(76176011)(6246003)(305945005)(66066001)(9686003)(446003)(55016002)(4326008)(66946007)(86362001)(73956011)(26005)(5660300002)(64756008)(186003)(66446008)(66476007)(102836004)(66556008)(52536014)(14454004)(68736007)(6506007)(53546011)(3846002)(44832011)(966005)(6436002)(14444005)(71190400001)(6116002)(2906002)(71200400001)(256004)(76116006)(229853002)(478600001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2351;
	H:VI1PR0401MB2496.eurprd04.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3W3kPrYZn80bOoAvCx/hyG4D4gaV6HIRrcbo84tpfxGQ4MFnNJQcyik4gpuZX4QpuP4/AS4YTECEYejcAale62TTnA8wWvUaJ6ibTcRGv8mkSmGP/8Hc0AMfO1fQkT3RUZ6S5qCxLtYp/omrottaYNNFxA7qs6LdzW4RXavEpMPqSJguM8Iy4Ni/6Lk2vefg5h5ZgKByRCAhZvq2mKhGGZFWdDNkyc7BWnuWVlGJBgST6rm+UweFM+8SsiZpkxzLrf0ihCNpiyr1YvzV13TdEBv/E2z4Vu+T3rXOYrj3Au4kHBYo5uZ1qUUlOynKtSfHj3l+MGTjuNWqus7cdLHm/Y+ankLmEa9jbL9p7mYWqTo34tyQnBfiBdQ+kNc5xcKe2vSyDspZ6DjnoaD0qS43NpDweSdmKYbHbL+x6mFUduQ=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6eaf08c-4a57-45ff-fa2a-08d6d54a1407
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 13:19:05.8726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2351
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Varun Sethi <V.Sethi@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Correction: we use ARM SMMU-500.
Corresponding bindings are : https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/iommu/arm,smmu.txt#L49

The #iommu-cells is 1 in our SOC: https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi#L693

Regards,
Pankaj Bansal

> -----Original Message-----
> From: Pankaj Bansal
> Sent: Friday, 10 May, 2019 06:04 PM
> To: Will Deacon <will.deacon@arm.com>; Robin Murphy
> <robin.murphy@arm.com>; Joerg Roedel <joro@8bytes.org>
> Cc: linux-arm-kernel@lists.infradead.org; iommu@lists.linux-foundation.org;
> Varun Sethi <V.Sethi@nxp.com>; Nipun Gupta <nipun.gupta@nxp.com>
> Subject: [ARM SMMU] Dynamic StreamID allocation
> 
> Hi Will/Robin/Joerg,
> 
> I am s/w engineer from NXP India Pvt. Ltd.
> We are using SMMU-V3 in one of NXP SOC.
> I have a question about the SMMU Stream ID allocation in linux.
> 
> Right now the Stream IDs allocated to a device are mapped via device tree to
> the device.
> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindin
> gs/iommu/arm,smmu-v3.txt#L39
> 
> As the device tree is passed from bootloader to linux, we detect all the stream
> IDs needed by a device in bootloader and add their IDs in respective device
> nodes.
> For each PCIE Endpoint (a unique BDF (Bus Device Function)) on PCIE bus, we are
> assigning a unique Stream ID in bootloader.
> 
> However, this poses an issue with PCIE hot plug.
> If we plug in a pcie device while linux is running, a unique BDF is assigned to the
> device, for which there is no stream ID in device tree.
> 
> How can this problem be solved in linux?
> 
> Is there a way to assign (and revoke) stream IDs at run time?
> 
> Regards,
> Pankaj Bansal

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
