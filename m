Return-Path: <SRS0=o8L7=U6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD09C0650E
	for <iommu@archiver.kernel.org>; Mon,  1 Jul 2019 18:00:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A1921721
	for <iommu@archiver.kernel.org>; Mon,  1 Jul 2019 18:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="ap9MFCaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A1921721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=teo-en-ming-corp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 7F70D4778;
	Mon,  1 Jul 2019 18:00:36 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AB57ECC7
	for <iommu@lists.linux-foundation.org>;
	Mon,  1 Jul 2019 18:00:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from APC01-SG2-obe.outbound.protection.outlook.com
	(mail-eopbgr1310041.outbound.protection.outlook.com [40.107.131.41])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 56FE284C
	for <iommu@lists.linux-foundation.org>;
	Mon,  1 Jul 2019 18:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=teoenmingcorp.onmicrosoft.com;
	s=selector1-teoenmingcorp-onmicrosoft-com; 
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=GSX5eHAds56LFycRwx9kCc0gXBzpbLqq1pNQ75fswiE=;
	b=ap9MFCaY9SBxpSJccP23IKIY8sS8lqmuzX0OqIFYFOr8AsXQTSTUP83eUq8BQ27TXEB1LgNLKhbm2Yf3sluocZFIx4mrkbmAjFW+XUbl6DaeWVe3vZcNqQ3jdd71szlNe67c6Xagn0LDIEcoGEog/D1kg8MzCXv+/JU3nFYrTcs=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
	SG2PR01MB3286.apcprd01.prod.exchangelabs.com (20.178.152.10) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2032.18; Mon, 1 Jul 2019 18:00:28 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
	([fe80::d503:3d71:ce06:19d2]) by
	SG2PR01MB2141.apcprd01.prod.exchangelabs.com
	([fe80::d503:3d71:ce06:19d2%6]) with mapi id 15.20.2032.019;
	Mon, 1 Jul 2019 18:00:28 +0000
From: Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Is IOMMU a generic name for Intel VT-d and AMD IOV?
Thread-Topic: Is IOMMU a generic name for Intel VT-d and AMD IOV?
Thread-Index: AdUwNr/7GQ1nOIn6QkSdjrmB6x4I4Q==
Date: Mon, 1 Jul 2019 18:00:28 +0000
Message-ID: <SG2PR01MB21418760C69CE520B641746687F90@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fec1ab31-73a1-4e1c-5766-08d6fe4e005a
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
	SRVR:SG2PR01MB3286; 
x-ms-traffictypediagnostic: SG2PR01MB3286:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <SG2PR01MB3286BF7F5E1B0217DB8C1B0487F90@SG2PR01MB3286.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(346002)(396003)(376002)(39830400003)(136003)(366004)(189003)(199004)(107886003)(66446008)(508600001)(71200400001)(71190400001)(26005)(4326008)(5640700003)(55016002)(33656002)(6306002)(4744005)(2906002)(9686003)(2351001)(25786009)(68736007)(66066001)(66946007)(53936002)(8676002)(1730700003)(305945005)(74316002)(7736002)(81156014)(7696005)(2501003)(6916009)(73956011)(99286004)(76116006)(102836004)(6116002)(316002)(476003)(3846002)(5660300002)(966005)(6506007)(186003)(52536014)(14454004)(6436002)(8936002)(486006)(66556008)(66476007)(64756008)(86362001)(81166006)(256004)(41533002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:SG2PR01MB3286;
	H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
	designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5y553LI6vxKPyHYFL385AnWNevjXSTtPiGMP7TjUaoQ61LCcEkceUNnjgkwh/FhCfV2sne68I19muzjpwykDfxhAz+nA89+gsWLCWwd/W8oM9/mO9aL9iCmQV28N7y3r7fq3SD9agwDWlE2RDz2JdvxLYCk3xV2jkqmxQiAYfq1Pz0OcbjpE1n+UXF0oDiWK7B/B2zhS/WQVE1Lzcnsm7wHUZjdcv+KJt/XtUu166kcGZwR4ElZ2qhkASrml8edypfV41QnU0WNU5G/sHCnGpr3f63ODW5F8E44kYEyPWYCrA93ygShR2z11JrKiXnbRQfMm2mk/lg6QKHsd48RQUUhSvNwSP+Vu2IZEa015Dkhztlr/+ftb/vvrHxj/aMJCvps4xenNonktEI6Qs9fEvZTsFreT7roVy5ByU3OIEwQ=
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec1ab31-73a1-4e1c-5766-08d6fe4e005a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 18:00:28.6038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ceo@teo-en-ming-corp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3286
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

Good morning from Singapore,

Is IOMMU a generic name for Intel VT-d and AMD IOV?

Thank you.




-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
