Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C1BC47080
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 17:27:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38AA3613AE
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 17:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AA3613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B0A683CB9;
	Tue,  1 Jun 2021 17:27:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TNX1ztV9iG5N; Tue,  1 Jun 2021 17:26:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id B895783CB7;
	Tue,  1 Jun 2021 17:26:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E19DC000E;
	Tue,  1 Jun 2021 17:26:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7BE1C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:26:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8385B402A9
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:26:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cNBFItWcxdSH for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 17:26:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::60a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 818FD400F4
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 17:26:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6EdIYP/nvCgd0zWHP9khLt6ueOoUbknZvi/u9A9hqSdIjtoY5IpTYuJw+neiCtQ36O/oD74pvEDDcpvPhu0ubMtRN1LdNWeevgwCk1MzIprmXge3Lxi1WwB75IP7kDqwjsBcmCSM3ArT3vypMhq0O7o53qFK5gi19Nyb+lSjqgoTdIKz/MfXg+bmdK0wg5kpL9R/Za/cyMreQt62k3KzIWWMABZqCYQHCQ5kM9txcKk6JgHx76CyQ3RcXQA0wyxBa+fvUUNRdFA3KiQO5EcWbNBs3owSKaObt56PGYjG4nwLLpQa3Srh3RWHePOtjwOvfryw1NKOcyFiRY3AA0IWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Aa9yT1F9dejnesVJMwlSsNfiZjsXTNsIm3Blf5Q8tk=;
 b=Ni2YSjko3veqjVT5N2ZYV15/jQNlotTKejqXiTpsq3TQGNsq48aGBG9QdKdqKYptsN+Zq6L+iDoJr3cg/DL35JG29wZxB6jPJ6wox6qqZd4c4pq4IlB4UHwY8fdT3SCqfEkDkg3x3ds5zZKM2IFm1dRUjbCp9R4wQ16DU6OouL6TwpdpEpcLnWeYdJEDglalFX1o8M7aZzQ/M1lGrrnw58/JaEm3CKOiJGqbOzc6Dn/VIqJsnchaY/wiYEnhaqr+5SQXLsf/cdFhlr1QGn6OO4VY2sN0l7nkrhup+jU7ApOb5Zr1CtdTKGhy1bsH1/U1nIgWqdz7lBFemEJN1dXpPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Aa9yT1F9dejnesVJMwlSsNfiZjsXTNsIm3Blf5Q8tk=;
 b=QoM5S+HO8y0vm2QQEoiz84ksWn+hzcAcyIxbubyj45v1ekCEJkKoqo3GlaIPSQBJctt3rchvsBGKEi7oSOZZlBonVfJrdCiJQAGpkPDy9ednPVMwSu/NXUFhvpP7ejLR3g47aIpVDOUxb4EDigsGnlxOnZc4E4YTfC35IiEzguOT6D863fSsmCFLNcthCGp+9jXb2OV0Pk9fuuIKKQ2Q4nfGbp6b/GO4J02/zJgFrKMkwgjPgFXVe/AEakRZPxthZEoGH1ajGaOUzpWyFugzi0u9mRRRhPT1rO33nvxePcBclH/PNFLnn+O36ycsaUr44lWiuvmIWiG8vNQTwBHG/A==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5125.namprd12.prod.outlook.com (2603:10b6:208:309::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 1 Jun
 2021 17:26:54 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 17:26:54 +0000
Date: Tue, 1 Jun 2021 14:26:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210601172652.GK1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528233649.GB3816344@nvidia.com>
 <786295f7-b154-cf28-3f4c-434426e897d3@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <786295f7-b154-cf28-3f4c-434426e897d3@linux.intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::28) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 BL1P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.21 via Frontend Transport; Tue, 1 Jun 2021 17:26:54 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lo8AG-00HXXY-Kc; Tue, 01 Jun 2021 14:26:52 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a017791-79e7-4910-8daf-08d92522731d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5125:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5125B0097B608CFC238A7CF7C23E9@BL1PR12MB5125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yhsxvw3EIYl4JIftsC+VVDJENF3KoJ4QS4fYQQD6X+6GCUyOeHKYn9YCPHziwm0BnzH50lG/QdKtJ5at5YpcBHioWz83jpOLvnUpB+CYkeLr/W0I3v7vQcn0AQaPozaDUbEXp9gwNFTzvD8hLH4PKzL6ji6jxU28kE5LEILCiS40ZtUehZljhK/jGV501SzE5I7O6I/WEkmev2qBudozXAv/aznM7jsJwek7CXddrAWTHwT0ork2pwSv90RUbnM0J0lBV2EF37Gb9Ca39t4NFJPolMtu04x5Plyox2AmRqLAC6xANPN3jhFQox5N+HAMt1vHvViglhiwfik0zRmanZ7R2//w/U2nU29AT0VxZtuMgBeyUQm2ppKE5tFFDkdyrhk/LyAx+1z0Gkk7D9KVZXomtOaAmSwghGp0cb/bMfarbqNZAcSwuzfh8B57IXhioIYLt4Y9UNpbV9+m93R+5gotzx/sYWOzsW81W3ptPxt4Rmh7QJL1fYv0M4ApUrcX88cVk1ImqIAvw2b1PziXeIw0+sSaptYYbYggYIy4E1KJ/l0FxfJxCVLhD5lFY89/nMfsWNiKb1TvCSfdAUZ5DlfhCXjNwmXJDRciEYvrRLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(8936002)(66476007)(66946007)(86362001)(4744005)(8676002)(36756003)(7416002)(2616005)(5660300002)(9746002)(26005)(6916009)(1076003)(2906002)(426003)(4326008)(54906003)(478600001)(66556008)(9786002)(33656002)(38100700002)(186003)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Zg+mmTkIWs+hTM1kn+udlf3hR3LAX+YFVJZH6tVKEwvWFL9fA8D9ITHvVLuz?=
 =?us-ascii?Q?G7as5g7jKDQn0Q2pYnyGYfPdQkwKPxhqZDRGZzy3xPQZhieC3dUbfu9r75b6?=
 =?us-ascii?Q?vM2ZecaWhrS9Q3idF7bgTZQdB5TSpbZ5fB3lMZkUMzKHTsMcXr739U2QY8o9?=
 =?us-ascii?Q?Cgr6mJE+S86RsYyKVXllpKMYKAoCTMRASp/T1Gy1UpPzY7zmprAUj/ITb575?=
 =?us-ascii?Q?aRRFK9XJz+TJV5d/l8pgq2q07r2SeXGOEVkN+FElkJcSgwNOA41b+vsv2J5a?=
 =?us-ascii?Q?GA8AEtHKTpA+qrXKoh4spxKldX76V3xJME63GCcKA2Cs0qBrQCJpmwGqHyRQ?=
 =?us-ascii?Q?0AJuwtxnlaxvW5eabh4QfMOXUC6S7pT5J9+l0HYxYkrZPcqvZGBZxxzOzWvl?=
 =?us-ascii?Q?MnCoT2u4zrIRppqWIg7/TYz3793AKnIX3Ug1HFIhzH9MB9T/b3QszFmVG5KS?=
 =?us-ascii?Q?bI60shUN69oZg9Q3c6l/TlhFKzBtcIl66Sjt+YfKQnr0cCjWvJKTw2xFsWoH?=
 =?us-ascii?Q?Fd41/g0usovdUvJgDTmNh+XREBTMLXALhcDiIY17leaLqtAPeZu2GTxFJ2jf?=
 =?us-ascii?Q?JJeyOaVeXQUkHP8iaiGFd/LHV+9GdxZO+3KstugCX8xHAcQwVPm5L6LbGQla?=
 =?us-ascii?Q?y9t9/LPdXD1toXd5i4MwJenSwNtioVRsEHOkKPcApo28ZQf+FJ+1uuHiq1UF?=
 =?us-ascii?Q?umEqrHAaE7PWI8fjrpiWIKTreDeCB3Aifbrig1wHqaWe3/YCKUZ6G4SYSk13?=
 =?us-ascii?Q?l0sCT6u0NutGgf+w6vbSD58Bs17QtX9Cbsw6JtXVPVjysZAt/Y6AuP+75Z4V?=
 =?us-ascii?Q?tLNVl6yIooZS09cgwz6z60139PZobGmxeDO2osnIcqZli7H/m7y6raQq1bg2?=
 =?us-ascii?Q?gmD43+MUu5CZqsnEVygpkGViEKVR3vzrelmPa8V2bMgDSJyeqrgWVzeFyg9S?=
 =?us-ascii?Q?KN+VyEEWH8sFt8yCN7cctyettVGdxH9IYEj+NBtn9jF9fQDfD/vG68M9vOer?=
 =?us-ascii?Q?AtptUKIrZgT3jRN4tAtbDFqcftdzs/FYzrHtu4aUXCDEG/q4qenRybBagNtS?=
 =?us-ascii?Q?TUwXie+GsKeIJ5EZNau2LjG2XmeW5EiyI2jGyAgng3CkIDFDRr3s7t1CWzQ9?=
 =?us-ascii?Q?VFv1NtT+KkZtxKjncSEfOAVhrVZ5WiBwbTr2+2TwnDFEJExjGG4BOk7kOzIc?=
 =?us-ascii?Q?KRhxoQ4XYBK5Y8siWAGoffB26QTRgecoA74I69nEsoxwN7yExnHNUtVx7HLI?=
 =?us-ascii?Q?dh0izDD1jYwy5oEip+5CHOWy98iYBHzr7cnH6S3AOMLesn9qPjcDHmRI9hgW?=
 =?us-ascii?Q?Ap8edLiq8TJdpeXGrY7YLsOz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a017791-79e7-4910-8daf-08d92522731d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 17:26:54.1780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HB3mtMEQeSGXTfztEa91mwcLi0lVmlxtDNg9oCdWyetLDKHlcxer4DYT9sKQaF3I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5125
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, David Gibson <david@gibson.dropbear.id.au>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>
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

On Tue, Jun 01, 2021 at 07:09:21PM +0800, Lu Baolu wrote:

> This version only covers 1) and 4). Do you think we need to support 2),
> 3) and beyond? 

Yes aboslutely. The API should be flexable enough to specify the
creation of all future page table formats we'd want to have and all HW
specific details on those formats.

> If so, it seems that we need some in-kernel helpers and uAPIs to
> support pre-installing a page table to IOASID. 

Not sure what this means..

> From this point of view an IOASID is actually not just a variant of
> iommu_domain, but an I/O page table representation in a broader
> sense.

Yes, and things need to evolve in a staged way. The ioctl API should
have room for this growth but you need to start out with some
constrained enough to actually implement then figure out how to grow
from there

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
