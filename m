Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB3DC2BB1D
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 02:00:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F14D206D9
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 02:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="gSC5ttgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F14D206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6FB1B2052A;
	Wed, 15 Apr 2020 02:00:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k9KeAURmi9Rx; Wed, 15 Apr 2020 02:00:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C7FCE204ED;
	Wed, 15 Apr 2020 02:00:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DB67C1D7D;
	Wed, 15 Apr 2020 02:00:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34D27C0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 02:00:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2FA0F2051F
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 02:00:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N0YD4LanQ7Xd for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 02:00:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400119.outbound.protection.outlook.com [40.107.140.119])
 by silver.osuosl.org (Postfix) with ESMTPS id 9695C204ED
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 02:00:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJF+4axQ3p25WNc9azufmlpUXd1y6nU/Wkv5lRQHf8TWHh+A5+1a+LGU6k3Q7D30NzlSNSaBJBl4EMNLc0Riz/W32fhQWHvOlfOukKzy9vv3rRv5N/JTM2I33YbGs3WAPVXCxlNnYsYIobekErAJfvqSb5Qzq/js1YwVxQYH5ZQdLzIFWfKoEwAK0/174kPq3WYRmAYuoM2eaw+VsTkcNJZr2vWuWDsd0tXCP3m9bKD7bo8X7wISqsPMuH9pG8yaHsta23/Hhm+MoCsZZ70UJE0RQusbEZa50j7VRqkqDvXcpRgumCXAnbyLnDQHcUfVLmB1aP/QUscAMx3DnPCXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW84VRQHUm8XVO+2rLPV9WEuX3gDX+ExJuC6NsIs+Zs=;
 b=VLsj5Cp5zmUokhNc3Q4ScOyJuBaGhAJX+4O873xplFMi3qV92wzT0Zfz37xO3GDB9uHyM4UUl5EuX1v65v1k4btRMJIaxc19lPb+6RteirKyl2Lc8ObBLsNtpgBZ9wx8JyQDecPAIVGBs7oTQ3z5arHmJa1ORzFXHT02akezEV4ErZ/OpP+jfNtVAWvl7JHRId1FH+HL6+zBPggpo/HCdrCrh7hA6q0WRtM93NOtlc8rgQ/x/d+Z1iualkGPDWuPKsd3fC1SY7eLmVGjFsuKL/t0Ego2PKnOX61SWrpc/+IKrJj3fNYWL1TeMm3U74Q5NOmZubeDQ0kT3uydcPUr8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW84VRQHUm8XVO+2rLPV9WEuX3gDX+ExJuC6NsIs+Zs=;
 b=gSC5ttgwmoBE9HoTMbPsWPK8MEMYmxJYVgc8W3SuiQYSjVgKoUBmVO/DgylTNCoVCU34gZP2LTomtk3ASTRkXKoZ+m1kJg6IAX7lWJJiot6HRgCOXG3zbEhhcnR/OWHGDd3LauEjCo7CiaZpfdk6QHUGDi9vCtr8WB3xbvf7mB8=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB3520.jpnprd01.prod.outlook.com (20.178.137.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15; Wed, 15 Apr 2020 02:00:08 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 02:00:08 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, 
 "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH] dt-bndings: iommu: renesas, ipmmu-vmsa: convert to
 json-schema
Thread-Topic: [PATCH] dt-bndings: iommu: renesas, ipmmu-vmsa: convert to
 json-schema
Thread-Index: AQHWEoBV45dVUwCDv0GH/0iVUxi6YKh5bfPg
Date: Wed, 15 Apr 2020 02:00:08 +0000
Message-ID: <TYAPR01MB454430982D630B6B7973C11BD8DB0@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1586773533-8893-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <fef59497-e5ef-bfe4-e845-389fd623783b@arm.com>
In-Reply-To: <fef59497-e5ef-bfe4-e845-389fd623783b@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 35be0a30-2028-4419-6a7e-08d7e0e0b98d
x-ms-traffictypediagnostic: TYAPR01MB3520:
x-microsoft-antispam-prvs: <TYAPR01MB352049823309AE4A7949DDB6D8DB0@TYAPR01MB3520.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYAPR01MB4544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(6506007)(53546011)(478600001)(9686003)(7696005)(110136005)(316002)(55016002)(2906002)(55236004)(4326008)(5660300002)(71200400001)(186003)(76116006)(33656002)(52536014)(66446008)(8936002)(66556008)(66946007)(64756008)(86362001)(66476007)(4744005)(54906003)(26005)(8676002)(81156014);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ttBIFz3kQMH8dB6SMg4SgzcZRj0057kIYtsgVHPsD2n0Jgzdz57GYKKo3PozhV5lcuP9rQRj/f1OnftIpy4UZ+LLI962QVn+byFmVcyBPmQwX1eA/s08TDq8Jdbbd+KIJdODKKeFTx3tSr6VLcqya9Put4ZHPLjvw0clVcrp7mIhrBuNvJ76XflvD8i7PUYPlUWPGMudReAojR7PlDd3LCZ0UuSZIJo1pH+Ohy6bbPxuCSwnCfAnUuicoNX+vVkKB8+Y2x1dnBHClWwOMz6zMwvY3Z283TaiP+i4Xis8WoYDOB38uG4dgJKGdEN3vS0umqGYrqKYKEeyTZNvM0PGInRm5Vkr+ZLlOZNYAeb4HMfJI8tyfvSzbVa85z1eHMrTlKNTk5BxIsuUWSY8bU7U1wFvTuO2oavHQ/j3VdcQ1Rwsr47DidUmWzpO+8bh7Faa
x-ms-exchange-antispam-messagedata: aqCgtKSbn94lR9PqGk+C/ASj2sBDswoH2ZqGWKLKeCdW8nUltGbxgM0Nl1MnHf/6pTYwj1l2jBAcOzfXq+RGaUTug3AuNPPsyzGmBY2R2c4EUGyf1ZbvXoVcL4ACy41FzDglrzIV0eOl9aQZ/5C8Ng==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35be0a30-2028-4419-6a7e-08d7e0e0b98d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 02:00:08.5723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HgLfysfL2PxvfDKC2itExWo40yPlLApEbJoj4ROxyur7lzaot8GzL7XJ9hHGQX6EXvVb0KMBIimoZcW5DhvP8Vvm78dbb0AaX+UdpzBMEfDL2CbiC3HubVSL3mFtHYwe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3520
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

Hi Robin,

> From: Robin Murphy, Sent: Wednesday, April 15, 2020 2:16 AM
> 
> On 2020-04-13 11:25 am, Yoshihiro Shimoda wrote:
> [...]
> > -Each bus master connected to an IPMMU must reference the IPMMU in its device
> > -node with the following property:
> > -
> > -  - iommus: A reference to the IPMMU in two cells. The first cell is a phandle
> > -    to the IPMMU and the second cell the number of the micro-TLB that the
> > -    device is connected to.
> 
> This definition of what the phandle argument means...
> 
> [...]
> > +  '#iommu-cells':
> > +    const: 1
>  > +
> 
> ...deserves to be captured in a description here.

Thank you for the comment! I'll fix this.

Best regards,
Yoshihiro Shimoda

> Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
