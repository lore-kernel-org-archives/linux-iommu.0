Return-Path: <SRS0=eAvY=NW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B951C432BE
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 18:50:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09BC7610A8
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 18:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 09BC7610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B834160664;
	Tue, 31 Aug 2021 18:50:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qL3db2hjaVJt; Tue, 31 Aug 2021 18:50:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A7476605FC;
	Tue, 31 Aug 2021 18:50:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A3B4C001A;
	Tue, 31 Aug 2021 18:50:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31C57C000E
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 18:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1510A4015D
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 18:50:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com header.b="ZSTkQJ80";
 dkim=pass (2048-bit key) header.d=oracle.com header.b="SVDDDfi4";
 dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com
 header.b="D6uibUew"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ttYAVTa6VBOG for <iommu@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 18:50:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 555F04017B
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 18:50:12 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17VIiNBn030571; 
 Tue, 31 Aug 2021 18:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=iNC2T4q7ESgUAozNS8mERQ6/FitA8h005d3HLrdwM5g=;
 b=ZSTkQJ80v2weJwhA8mxQWUSCUmXk4p4IZXcCiTgLaOwe0vhOBaSQyJpp70rfr+u8Y85D
 hl8bCPrGr0HwPEq9nzfRY1fvutjYgzNhOarPJmfrqrFQP8S2yJWHQm72X/OikqSsaDfl
 IHZA62q6n/WpYURun3OkHPwvXFDYMfbMn0aB/GLhqFcB50sxN00IMQGv+NoMd5JRDRhZ
 pF++tiWuBMofgFDAhMW+HBqx2RXNPR7+DjqY6TbpkdNzEbl5Uywpgb3vTXZ9dO0Gqn1h
 Dna4c62Ym2CYocuq2XHJ0INXw0Ur2TkXMMtqz3mjLHgXw0WHkljXrlKWJ/i3oNBK5r5r oQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=iNC2T4q7ESgUAozNS8mERQ6/FitA8h005d3HLrdwM5g=;
 b=SVDDDfi4DZ6/nB9G30xa++0023zGMCJYPcBDa3eM7mR4KlDJ7KMXhi1j4mFcSRnzycIk
 j3DBbx/58dJk6e7fGmWbmRgGN5f+cz7/AKsxEAiM0/YmgdqgugevVVGrXxKz6ikVZbLK
 KdFGbWzaWENgbhko1RJSiht+rQooVFM1knKaTazzNQotlXJb8A0CJuDnG+x+QonxhOJU
 1nKqmcnK4sXyCtam0EXKi4mt6KLUVZsIc6AfZQrs3v7yXWJkCRoKCO2ebPxTNShaCKBY
 gwMBdfE6feO8AJX8HFx6tDvP0iL5SV7nogeUt4EpvrpXy26UzgZJsOc+bfdqZiPbWCsn mg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3ase02a4mf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Aug 2021 18:50:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17VIfd9k097012;
 Tue, 31 Aug 2021 18:50:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
 by aserp3020.oracle.com with ESMTP id 3aqcy58jvx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Aug 2021 18:50:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhtLPY4jNMuEP+ycyL7uO8wWI3NG9SeBqQuChNjq4CtpnBglo39GfBdItf2zk+o3uqFolg0muh7QlsDYTI5PA/CMPRqImUttDx/8dFzAGEW5DQ4y2uFQN2RLz0L9cvsILRjczXKIxy2b9DGmf8LH9jsTHJfT1KLZZHInRJLTdIs8yvfaowQJoP5npb4sSth4FDZ8jsSq57q8GZ3ubg8QP3X5si9mjpBiXz0/NViGnUYdpcDm1Vq27xXqsxZTSR2m2NaigPLVfCtkx/HN1/9hZbXFZ1ELjE5bvECw7wCcl5MrIbx/X5oE3jy7vCCF4dfcCMYQ4XpIRtBLWXCXtimSUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNC2T4q7ESgUAozNS8mERQ6/FitA8h005d3HLrdwM5g=;
 b=k7yjnl/AkN/LVTaqEQhyDa6sF6WWkcivE6qC4e3QDo7eVSSIjwe46Y98RGShDQgspEZTqSnvaebNexT8bOvwHK7/i7HzbX0yHpplYCBTaRyUBjBDZWtmNSrohF6HxfkuFo9NqCMKaMNjfvFmHYw6kXZvvfrkovZ3H5t0mZpmly6cYimXTTJOXFQpWddOS8KBZSbkaYk/coG2Tay96Ywzc89ye1UTo64WBdhpolX/HYL6TpwSELbuWdK882E3aMBKXtGupIFQum7F79NrEG/knoddxalDr72h45sLANP4h8L+anKji6kmmkNhzbKoIBoU7dI9Ruwnt2CvDqUldcY/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNC2T4q7ESgUAozNS8mERQ6/FitA8h005d3HLrdwM5g=;
 b=D6uibUew62aIQN4Ix0Fd3zxOOgw3LUQh+TF2JKzwHTeL+C7dErQ1hdya6UaGm8lr/1BW0O1X9Kn4vnWUwkyUG0AGQUkAfNhnuFieTXx22cJrc9Q7pva6M9/oGF2hR2P5mCcE3bukAL7jKcyPLDBhpjGrDxHIhDMjKweDLHSOtqc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by SJ0PR10MB4432.namprd10.prod.outlook.com (2603:10b6:a03:2df::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Tue, 31 Aug
 2021 18:50:02 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c%5]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 18:50:02 +0000
Date: Tue, 31 Aug 2021 14:49:58 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] swiotlb: use depends on for DMA_RESTRICTED_POOL
Message-ID: <YS551niE8F5HzIaw@localhost.localdomain>
References: <20210827034802.1065294-1-tientzu@chromium.org>
 <20210831151746.GB32001@willie-the-truck>
Content-Disposition: inline
In-Reply-To: <20210831151746.GB32001@willie-the-truck>
X-ClientProxiedBy: MN2PR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:208:23b::7) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (130.44.160.152) by
 MN2PR11CA0002.namprd11.prod.outlook.com (2603:10b6:208:23b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.21 via Frontend Transport; Tue, 31 Aug 2021 18:50:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e6382b4-83f1-4778-88da-08d96cb0242f
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4432:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB443220C3BC260E1849DE364B89CC9@SJ0PR10MB4432.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7DPgJexKdGx4uWIiqTZI0wAQ/HI76Z33xzvfn5qb8Fnx8SspxD50Y/tprlQBAAppBhqbpRtqrND4hAcQ7c/s6LSFkdi0BJrxCZCve8dYqNcbVgUgfAOxtAhYq9Hs/Ou1lLlFZZuaXmoXHnWCTFfrri/kYZXOtdixVlVs/nHLsINXqTE86RnOVn9RkeVFRrjzuGIlAJ5MvLChdGhShN8A+sPhacBO4uHBk+K8wQZnDEXPeVGtjsj9D0K8t8x0TG/N4f3xeZ/RcEoKznGC8OdPOi5mDvzZg5v9Oy0501HXP17vTAwW2ZxvjD1RjuF6TEajSnWOhHbsWovIZzoTYabgS/zPjcOV4SAXZK+hurzHW0QY2ZHA9Z0wUD9XZoxIH9LNydlmyEVLze5XgIzr4WCf+RMyECRmXNFFDS+dgvTBrSUUmIp51ObpjHMjGVrif2VDcrCfTJRL7mpmNv/axPJzPEybgWMBmXYWmkyGwrfxh9+4KDZhvnY7bI7DBei/OenvgNRMvQdhuOEihA6HtkQo404P9hR+cFCpg5/W31NxqWsG8+6Mrv4+O3o3NRWza0cY9yWRLl4di15dlVKg3bAspfRBWOzrhxc8V1d9neelLNstkZav8VNxortyAwWJSXCZhDgAd4bDl2cu9cPSTfsIK/4a74oKYPV9KxC4W3Ic0kdCn7Shy+qOL0YVie4e103Pzb4x6zlMIJWQWVMApdoqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2999.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(376002)(346002)(366004)(39860400002)(136003)(5660300002)(83380400001)(2906002)(478600001)(86362001)(316002)(956004)(8676002)(9686003)(8936002)(55016002)(38100700002)(6666004)(26005)(6916009)(52116002)(38350700002)(186003)(66946007)(7696005)(66476007)(4326008)(66556008)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j3UFpt4SWDR/cRm++HkSlzoP/kpXHi7KGHqdM5avmFmkXjHnB72qgOPvEprZ?=
 =?us-ascii?Q?ZrE1erhoddXBJoCfZAArNqtgIZMBzT4gigiB/meFyBr8iJp7OZKbsSfKIVLu?=
 =?us-ascii?Q?3PZRVyMd4aHZ0WvlCo09B2KEpJ2PiHclzYhVR/5zunoJwGLb4DSiEotdXLvn?=
 =?us-ascii?Q?DJJvnYBCq/SDd1DriiRGkLPI4PSeoLRn9VBw5QpDqaS1WZ7Vcbq010ZYZp/d?=
 =?us-ascii?Q?u6AW6HWuuNcx/b6WJ3IAbFZU/7uBwQ/XRYXpbUub/aQ0NjheuS+EyTGJO96L?=
 =?us-ascii?Q?7cL52yYfVPEYZ8A81QTyb6cbF/MtngaiIA6JawDbqDEJ3qgStGYcLJJd9aAX?=
 =?us-ascii?Q?HoA6jyqU87XpRCjCu4ZMQmjbn5sQf1C1nA4OH1Wlye7rMYuRkFHMsylhQFWV?=
 =?us-ascii?Q?Sv4pVlvzljoRkN9RwVwLQm1V7kAgZWL/NxDgduAxOyoVuCTBXJpqGJV4dcKL?=
 =?us-ascii?Q?+KSawqDn+89GgxCXiHVgndDaRkZqjYQCq4y5NBWooEieOAYvm9mCEzCDDOT7?=
 =?us-ascii?Q?x7fl+o3+l4rGGNtkO/jkvUw3Ur9T6u5BcJgdloSl+PZ/kcMw8TcEPUX05n//?=
 =?us-ascii?Q?MGFEtp6iQij0IdGTzDgmiUfBQZPEB2wRiAaCVhflEziB2NpFQgiLDqYNimQW?=
 =?us-ascii?Q?wnKbd+0pplQ7JHiShuE8kHqts6n2kFBYY+KaVEHaxsY8+A9NFaan7LOaFVkf?=
 =?us-ascii?Q?EddnKn54eQR2jAk/u4ABP9uL44VdK+34r09R4HecMxOdSUvpCu28dCQA0j5x?=
 =?us-ascii?Q?1rJVTC9GtIEmAUBvhbBCddv+PHEAFqZDCtBNfVUBm/iVXPlApu7vnCWI/CIJ?=
 =?us-ascii?Q?QhxIsRUWZuiF7Gbv7LxtOoOqhUZJZM3KN37y0sVZeVGyEC5VRo5Pqmj/Jp5h?=
 =?us-ascii?Q?tQEWnAi4EOj3VZ8h70zJDsKtSiECZOGjIvUNhHpN7FsOCXBNxYkm15Hpzyqw?=
 =?us-ascii?Q?JLsTjPVAdRV+8teCblo9PhAcN8huzThg9OGXAUI0T8r6yz5n9oT6UlGcp+TU?=
 =?us-ascii?Q?ZF0eWWX9YknR9V5Cyr5/2FEsgww5T/0PRhEbc/TYaSi7RK/6rim6B01yjGXf?=
 =?us-ascii?Q?wm+t65lP6MiUx4oVvha3JXsVzY24lebe4zXbPWvJv4AnZg0zqdYDnPMOIkpO?=
 =?us-ascii?Q?yvPLLByQ2Gtz8MnyjVgSQveA8Jd+CkcHDfDL6I5ogVEINivSWhegGCugzu0K?=
 =?us-ascii?Q?T7Bluk2skqY+myPMcJZppex7gcK6K06XPQRBOD4W6iAe0O3mgaCT98X37oKL?=
 =?us-ascii?Q?cqinDgoMcaQFpZWW+0DmZiG87QGpAwipYvDaj/1CJpxIxIR9FuY+9TgURH8c?=
 =?us-ascii?Q?PJsjmB0+ITCCBzL+enLmxvni?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6382b4-83f1-4778-88da-08d96cb0242f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 18:50:02.8393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+04csIlkC8vpILov5A+Ld9Z07Q2z8U2e5ghuoKqC8txhMudU8xirg6h4P+/dhqDlXmRuCOF9eG9RnTBKMMvcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4432
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310103
X-Proofpoint-GUID: eSh9bh8ughdRcKPlBrGrXzKkapqQgDUS
X-Proofpoint-ORIG-GUID: eSh9bh8ughdRcKPlBrGrXzKkapqQgDUS
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Claire Chang <tientzu@chromium.org>, robin.murphy@arm.com, hch@lst.de,
 linux@roeck-us.net
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

On Tue, Aug 31, 2021 at 04:17:47PM +0100, Will Deacon wrote:
> On Fri, Aug 27, 2021 at 11:48:02AM +0800, Claire Chang wrote:
> > Use depends on instead of select for DMA_RESTRICTED_POOL; otherwise it
> > will make SWIOTLB user configurable and cause compile errors for some
> > arch (e.g. mips).
> > 
> > Fixes: 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization")
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > ---
> >  kernel/dma/Kconfig | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> > index fd4db714d86b..1b02179758cb 100644
> > --- a/kernel/dma/Kconfig
> > +++ b/kernel/dma/Kconfig
> > @@ -82,8 +82,7 @@ config SWIOTLB
> >  
> >  config DMA_RESTRICTED_POOL
> >  	bool "DMA Restricted Pool"
> > -	depends on OF && OF_RESERVED_MEM
> > -	select SWIOTLB
> > +	depends on OF && OF_RESERVED_MEM && SWIOTLB
> >  	help
> >  	  This enables support for restricted DMA pools which provide a level of
> >  	  DMA memory protection on systems with limited hardware protection
> 
> Acked-by: Will Deacon <will@kernel.org>

I put it in linux-next and devel/for-linus-5.15.

I will wait a day and see if there are any issues with linux-next and if
not will send out a GIT pull.

Thanks!


> 
> Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
