Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C489811C95
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 10:46:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEBxqGkAoxEH3uJRWNkDZm1cU7p+CXnTcdjmqIPdlaG3lVUxuTJNEwN1xmNmiReFiKIJ5dPFwSrY2YhK2h3kmODWCcQT1Tfn3mjbzAFE0CykUQktlRtKIHSe/EIpPquyAyE8WvM+4I+yTV+ov1uHpmIkK2I8K9Gg3SU4QgXbsKr8HHCn3W2/DoNJxrcukE4z0OMSltqPzVjTyQ1//fK0rvRcXiUQTM+GcZGjFXvw+ECfIxYdlJIYboEwcJx2okYn9sWOyzdP9bTKUBuVlmK6IWE66+oipjlUgGHJUQfqoU76TMvILNC45qCF/nPGUpdZuUbK/bl/lfzfzrladqyyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TNECGrbhmc2koh7zZ9BYtJiQOcvcUMgc42XqFoYfxc=;
 b=Ae/E9Qpnkzg8E7fOlTNvVHRWSSO+aoo0XcYhWjQuiBNdagjSWRcZty/1WlDT5oZnBaxb86Ogl+fqnr2vv61cYNy1hgjG/ca7JXdvMIyH6jQ6urpa+I2kdE4JMDkjgoOtMwXSl+jntPWZYgfRtzT64B1Xyxo2ZGCEXdvLFAqGlC8FLJw+Hz/86Hjtk7oO/Efm0Ztjox/yIZ+/hSKjC++A1wg4sAASJ0Krem3TX1dFrSnauXfg3xcTGixeaT0Ffaro1cl7l0HB0XGs88KPO8CKgNuK9PwgFybiQXKX2Nlqy8FF7xI0cUQjKFF67nqs2Dfso8r1OAMZakrzzRO5EO6Qpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TNECGrbhmc2koh7zZ9BYtJiQOcvcUMgc42XqFoYfxc=;
 b=hNgWqrp89liwTIm2S8MH+vIMWl+C4VXutH5nysQkP/qQZdZrWT5B0HjLm9eUVyRmtUvjG5Pf7Wk9CmtwO9Ci9gFZmidOg4BzuhywaHFT6TXJVHJ/PB59sZ4WXOCyFGzjiCoJwXvSIXbsCdxwJ+t/qwB95wQNjYTXVizEFpqDVI8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8428.eurprd04.prod.outlook.com (2603:10a6:102:1ce::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 10:46:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 10:46:13 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Peng Fan <peng.fan@nxp.com>
Subject: arm-smmu-v3 sharing SID
Thread-Topic: arm-smmu-v3 sharing SID
Thread-Index: AdmJdUs1QUi3X7zdTlmw0NCi0LcA1g==
Date: Thu, 18 May 2023 10:46:13 +0000
Message-ID:
 <DU0PR04MB94172CB3F138AD39E9B6DEEF887F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8428:EE_
x-ms-office365-filtering-correlation-id: abeaf20c-1163-45b2-2a39-08db578d19b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nrp4gS72yzFSW5UixvlYM8AXXeOGN9jTCZG/1rgih7JGUo9GDPAm0qupe0DBPtMMhUS7f+6SIqOxg24v6XRRnm4iZnFK30Yc3BusciSQe9/2PxXWyIzUeAy+PMbwms5FfmvVQajH2dFegws9Lv9sG8IeiOkyaPc7W5RBfBnD0Fk0iZk54m8FZp7YIEysZEEBtWHKdBjjfe4C+13pRR6BPfZZ4QnFkEODCcgk8rrFl8wFnvmBbeYvmkcm1OPbOc+rCMIxYsFXWdrBKKFs3mAtPlviyQCbt7xJxY0OqrXLvCpAoOTSWDn3k0Se/3ukxd4ffaCmx9mdZrczla+kyWng6oK0lcFKrM29VdFAhSRiFHzbajiV8L3yc/0r5dVWeFgaq0kk6QIGflfRxoLZPjulzx80J9yVtYYOKtUN+qmlPRgqeyYPkCXdCvp0MgA3DFF/MLBDr7EOfppTGsIoogQPJu6PbaSMfNWOAZbZXPUaOs4Ai7hrfaNIdEWO3VvQ0Q3xwcYLUmoGbS7SnCB9DKnt9xvyx5spsSYxpNYCPIr2nhSLSBC1RZ/YscNrW0dfMyaNmFA8dF798UAq+gyLjI3NzhVHq/xLhDOYg/m5+P06euHowfeqTPRZYejPNBrFxFzV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199021)(33656002)(8936002)(86362001)(41300700001)(8676002)(66476007)(66556008)(4326008)(122000001)(54906003)(38070700005)(316002)(66446008)(64756008)(66946007)(38100700002)(76116006)(44832011)(110136005)(4744005)(2906002)(478600001)(83380400001)(71200400001)(55016003)(7696005)(26005)(5660300002)(52536014)(9686003)(6506007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LFzp7K0E3MD93zTCCDmgjRXCeFxAJED3EaCpjIeM8xz6mT0RcLQsE7R3h168?=
 =?us-ascii?Q?HQq/9PrdAwbd53f7QzD6qvaUjWTcOCjDAY5vW02fUsoQ8ESMIfj+RCq11qto?=
 =?us-ascii?Q?J3f11OTi1bXyrVkbb+wXl8UzvgXvD+QlREKbz/FbAcoaKN/SYNPHhnRax7+L?=
 =?us-ascii?Q?aJULF7zTb2+j+hEY2Dr6gKoe5Ni851G3fQMlEShswAHlJBAZa3YSdSYN7tCL?=
 =?us-ascii?Q?YPIY/6TMqawkPrsuu4ZH6EWtpAH4/jbHa7quAwPhzlBs8wI0HmiknTk2L+/m?=
 =?us-ascii?Q?NO3D5arSbG/MYXPXMLSNcHuHieMzIgtCPqPIWR/sMBZi73LRLjEONL1xo8Rd?=
 =?us-ascii?Q?NvjdDWYW1aTXiMEXjZqf2xt0fNTE6PC6Xh+5Hi6T0vLxAcc6TVHCjqc6WRpU?=
 =?us-ascii?Q?NtM08j6wWl2eIQ3bNF1w/ARgiQE9bADhjoprbbaXX+YFWU45Tj570FJ169dV?=
 =?us-ascii?Q?NnLr9TiuLGlL7e6b6o1nxcYCQ2Evx2ac5MUjdV2pQKSTKsEYo2lQDyTI1jaY?=
 =?us-ascii?Q?4tU+cFh9bocp86AUDJvkPaT/de1mVTXGzKAxC2nM7/hdZ1E2mizgYQsWFgQF?=
 =?us-ascii?Q?SGrd/xG6Q4SU0PZr0GenGhnMgMo1ZpwIP3Y/PVBAJ2A+csQ1Sb9i5cxfcRhq?=
 =?us-ascii?Q?PHl/nWqSKMrEo7JNGrsn4sr4np1F1Sc8REp3LNXnCijzprRyEy6zLWTGug3R?=
 =?us-ascii?Q?jbRWx3srGm7NQilA8qxd+PJAhOiu4aAKbtfuJd9RBcR4AAEUtzMP2z3pktcg?=
 =?us-ascii?Q?QfB6fU8oXjCFdgzDTLpPRKOEfiE1QKSGX1p3FmdjT1TnkCORoEey0qRG8CZq?=
 =?us-ascii?Q?inuSEnG01gnxN+3vniDTJfsP0gxBkbGYN+PaWHa2wTpcqbKtiwGMpiXVlNy3?=
 =?us-ascii?Q?pt6IgklECX7qPuinouasW3G93ItGzFvvGIdn1Myf2gqxWh0rTlRynj5aR24B?=
 =?us-ascii?Q?DZmcudDeUN6WBCsFmY24ryEV3cBHHh/bzgOg0ZlLCSu1l44UUrzfJL6oKGKF?=
 =?us-ascii?Q?3ogJzDSHF7GQs261HTOzKrygyRxgk/iaLCWz0CsKYiv3aQSKVcrdX7+mJJMF?=
 =?us-ascii?Q?bf9KAcH94ij6P2wXjtXkZ4szlh2iJFfCRhuGrIi7MYWI7SKvZjDSRrPeCxFB?=
 =?us-ascii?Q?C7oVytO5nmD8hB071r4oMCQmziU+7kqYZTqPtoVlBKTspD5qVkr0tjk5+8yr?=
 =?us-ascii?Q?GL4phh1t4eiqeCxyQM3DePow1VyXPqWNpKCxkgj/SjaYxjMIHxHEMJJL2jgt?=
 =?us-ascii?Q?aQASqkt23W2bLTpY/+spPFhXzu8ubsZjlugdJmuEGM/badtCbf/O9MbdqnrH?=
 =?us-ascii?Q?yipNCbWu6y0OF4SFW8vb2i/zveFdr623/tRQ5gOkmiRLExsdjLJPOfFhahyF?=
 =?us-ascii?Q?AN3AQxveoBdvGIyUAhSkRuRn4unB8xrUpvAqFP47JAmFq2swd7d7kG6A2Q31?=
 =?us-ascii?Q?WE0St5WqGB5e5CGJ+dLnDZQd1XoiyC64wV9i0fTb2I9Ypm/RwOA8k4bCzBLQ?=
 =?us-ascii?Q?D1NPG9+913YzkHNvdydMLkWS9tvwlOC2D5zWO/a2xUEtjIltGWSq1wLbs8L1?=
 =?us-ascii?Q?+2Oq4fehhQBbl2NKk1w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abeaf20c-1163-45b2-2a39-08db578d19b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 10:46:13.5830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDYayHgZJLPqLFVXlIw1atkQr+0X9XJH6n2VMbRcaMu0l+wMev5kW/daMjZZ+u1K+B6vcYF7DBXr+Cc3umfrKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8428

Hi all,

Current arm-smmu-v3 driver does not support sharing SID,
If there are two devices sharing one SID, the smmu-v3 driver
will report "stream x already in tree".

We have an SOC that using smmu-v3, only supports limited
SIDs. From my understanding, the smmu-v3 hardware
supports SID sharing, but linux driver not support that.

I would like know is it ok to add support for sharing SID?
Something like to use common rb_add/find, not
smmu-v3 driver local rb tree add/find.

Thanks,
Peng.
