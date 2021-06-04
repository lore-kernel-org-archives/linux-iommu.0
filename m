Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEAAC07E94
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 12:09:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6542561417
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 12:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6542561417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2575A40488;
	Fri,  4 Jun 2021 12:09:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zBSZ7XXrusAg; Fri,  4 Jun 2021 12:09:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FF5D4049F;
	Fri,  4 Jun 2021 12:09:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44304C000D;
	Fri,  4 Jun 2021 12:09:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0D54C0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 12:09:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C8D19606D4
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 12:09:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Puoz00n3EG9 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 12:09:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C544D60679
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 12:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gB9m3sbnQWWUP8F1VHc4f8PLurTaxQFJvEb5LBtVT9TEfQ3bYhsXHF7KPAUyewjEiiHoSjZW82ERdqliQ7Gzf57e23Kc0CpCggDJO4qdvGiKDee/4JmJJiqh1OXaXDqZN8azlTVSH3xd1M+Ig+/fvgMX6OtXkY2BIfMMy7uUXlUYjTJAMK/2eaUZPQNA/5gM58LHP68m8iydfbzDzJmE84Yk5wVn+4coafoGSQ0cyVpOEf/2SmdYFSjnFnSE0XcOLwIN38dewji0eLxiO6F/H3vNofWwRUKnPoaVBjvkACbU0lIJP1y37zjWXH9ih+zL+vBRUeWSmWKff9J4N1+V4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qTGbLluedWdVuFPi27kVx9naDYDJkti07OogxOs4Zk=;
 b=G+LM+0fhyahNs5+ppyl02Eae/DEAVb5K4p9t6qEdYNbHw7Wgc+YaKVAzUjOCQbWcWAoGdPpp5zpPyvDxqDudVgBuPJ4pc3WeuEE2JypuexVPsEonTh/Q9HqjuJ5rp9Zc2DMPfVdyw/bgw4pw3Lwr8k8TqYqYsnrT3ZX9a26B7y2ThT9FiQFWPCRXHMahbiuVEkb9Es2s00A5ZNO7ttc+iKp85dpnRF9Q4daAaoOx6AHbVO6kypuJG/o7c/8Ow3VfcJWCeHBGml8JbuiNtZoUhtoh1CvZ4UKcaDBq5+filP5ZvTGGhx4o+xITHobLdQ8u7fibQkji0/vHCwbSd0driA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qTGbLluedWdVuFPi27kVx9naDYDJkti07OogxOs4Zk=;
 b=kDmst+XvpW11pRsBQpCA386YGHQyrjE0jvmfgG4KF3m5HgbwDJa0b56ElOflJRduvrn1N4XjQQX32DPYx52TIHa7xyWUEpOvLNa6OQdUu9IQzbJo2WVzip7y2XTpodTyS8aETwGOMq4g4563jEqlcKD0u6AoqBq98Za9zbWIB54tNJ2x9MoKxYLyPTN4bwwx6R6UTBBCO2cThSME8jEPM/NoidQQ71Nvw+AZKmCyqJ875E4Uanz0RPJ4G3VoI2ZGunmm4TE8g1CZ1I9zf/Jeu/BwJJvJDzfz6F7SfoyPJnzQTevGY+lK1nnsonrHpGSFpkn4siP1KIna3uWm1gtbQA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5029.namprd12.prod.outlook.com (2603:10b6:208:310::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 12:09:04 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 12:09:04 +0000
Date: Fri, 4 Jun 2021 09:09:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210604120903.GI1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210528233649.GB3816344@nvidia.com>
 <MWHPR11MB188621A9D1181A414D5491198C3C9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210603130519.GY1002214@nvidia.com>
 <MWHPR11MB1886B04D5A3D212B5623EB978C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886B04D5A3D212B5623EB978C3B9@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR16CA0049.namprd16.prod.outlook.com
 (2603:10b6:208:234::18) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR16CA0049.namprd16.prod.outlook.com (2603:10b6:208:234::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Fri, 4 Jun 2021 12:09:04 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lp8dL-001dDd-7P; Fri, 04 Jun 2021 09:09:03 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfc0d0e5-16cf-4e2e-20eb-08d927518bc1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5029:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5029B2A335B5B4A5FA9219C3C23B9@BL1PR12MB5029.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T1j50GwAdg0TiMKgC6oYqvGoCaEA6e/G/y8ZEX0ub6zV8WYnAM/mOepuU4/s2D/a9TaQ1DM9TeVhi9JWHO6kccYiXTRZAg/OCfNDtNaBvB9RQ4c4sHkr23DVpK3SnglGVYlakE9osea1g96cWvQxIpeN2pzJduBeChkIDCc6TS6iJDhXu6R5sjAJ2kiqs2/AvS/xIQQrBYhxtJG5IESxa7Dfz0HnyLwSNZkojd6JizmHy7plC0rzbj3mRvJYWj9uwYm8f2Ieu09XZ4nLf/St2hiNBD+ftkueabjT491DcFecfklpjRAiuFlJNogEEMH82qD73jrzXumdhUYjohMUZAQPlwtnyNOGkvlcCHPhBVzsMYSHHMQ4kOgZPnym80cTGuOXmv/A7UoGZcBLjJX7URqSuxeWAD8sVeKapnsJwTYDPIsF5KH6jdJNso2dDGGgTqdTo+iXyTxs8wgMi3+YqR6uYV4lYqdzrBY/K/Z2F0mgzfAnrp7Pj9nTTFAzQ05h3ZMSgknWWBmQ9nQFrTCyodUjhSLzpvdvouwzbCSe28Za+UiCyCW2ZTMzmQZrHwYOYIvpdnjIAKAwm233yUvhh6a5HBEZeLDrNXUAtWQ+KhA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(1076003)(2616005)(426003)(4326008)(26005)(66556008)(33656002)(5660300002)(66946007)(66476007)(6916009)(9786002)(9746002)(316002)(83380400001)(8676002)(186003)(7416002)(36756003)(478600001)(38100700002)(86362001)(54906003)(8936002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lSQsUcPQfgQ8e7t131sGUzKpgMRDGZ5F58X3SYVZdkrX7Tb74YY4DqL6FQsj?=
 =?us-ascii?Q?jwfO1xGe07tAgDVQ8FEsqTuqFE1QzRvXkZc84aqpk80ViiDpzMnod2cS3iWq?=
 =?us-ascii?Q?hxl0rr8x+cBFqNmKaIB47x6X0oo09Ct/NKLPDv52z1OG2NV1PfAFF1nzwN3q?=
 =?us-ascii?Q?NWd2Z1azqvx/6MQvW5EH85vhTYdqyFPhjT30ZycveyTirKN7lylX7PCHTGQP?=
 =?us-ascii?Q?FMdfYSTrN8ZGt1lpcFsy1ipDyG6lCgI6tnwK8lgVgp876xdIlgqpYKX6zRk7?=
 =?us-ascii?Q?m+blNvLmwMVhIA+3ETJC3R07ThDVD8eI6EOK0wE8NqGdfWA0f+Ume7ri49ql?=
 =?us-ascii?Q?KNXyVzSInkqZrtKr7pePNXeSlkTrfuR/4Ult+kneN3eKy+rz6zHWZNSc/0ri?=
 =?us-ascii?Q?ypdSWXpXTpWcR2ub8vbzmPjvplB5RxU5KToifOi8DYGxKcVWgJcpLk2RWY64?=
 =?us-ascii?Q?MoRWOgQTgQQ3mnsKELmgFyUgRwi8IRU/0Yh3WagAMM6T+BnrsWmsXAnZ/1JW?=
 =?us-ascii?Q?IbIyJD+zuaQIUZr7lvdfHO5PjwvgQJs1C2N4lw0Qy6s/Yji1oFAkxbHTCG+A?=
 =?us-ascii?Q?WXxnD99bTxRPK4OCgcqY98TbVRalxzZV4JybfcgHH/CIbn7KGg2jOLc9eiaI?=
 =?us-ascii?Q?rgYZteVqq32w+BWfsRa2EkDbS9GGg1bY3WIkz9uOA1RqXcPlMLWRw4KDcdmt?=
 =?us-ascii?Q?Z8dGk/NkbDurKgW8R2u42omfDoOdDFvWTlGFoxpp3FC4rtp1F6MJWqgY2AIE?=
 =?us-ascii?Q?jgOy6G+I0e/Uj6/hO8xCN0Rx0nPIzmOZwIMtpVZLDWAf4xs0emECSnu9nucz?=
 =?us-ascii?Q?MlF4ewUUsBKH20bybn5oayy8WkDVEoRvNR02y9SsKlTQcbcD94laV8oFl2PJ?=
 =?us-ascii?Q?NBS56cwCsV/qRvKz6iFYgqeamC0VCMpbFtdJ28gSYqOWL6u43ZSOJf57xtlD?=
 =?us-ascii?Q?ZDftotx0HKXWIpsReDfXlyY8k3UWd/wfRb8svG7q2Q45/gxIVX5YD6oFfi1y?=
 =?us-ascii?Q?7wHVxMYAfV98qCGvzhY3z1HL1HAiT01tUSWXVQo1TLFqOIj+rNUl095/SNxY?=
 =?us-ascii?Q?2ryATu5tvDO6dukNrr8pBQzYM3++clOJB6yaMFjbwf6fGUiQhNSIQAE0EXoi?=
 =?us-ascii?Q?G5ji2U+Y3PNxd7iVyoQsFgBO5E1QV35UqxlziA0ktJpwr9hXqkgCq8jh1zXY?=
 =?us-ascii?Q?A2INJCGrIC/JAO3hqZBEk550UxeB3krx37sEIkEWb2B1zwdKut3gpvYsWiem?=
 =?us-ascii?Q?bBs1BPUjKYj4eA9QmNH2p9ifW8RYt74V4HiLLrtBWOqCcbVPC816SEF0Fl22?=
 =?us-ascii?Q?8AbuqooGEor3IEZ+KbJCJciO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc0d0e5-16cf-4e2e-20eb-08d927518bc1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 12:09:04.3375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9MFpVoP3vtG4dJaUCZWdJQMl2lJAnqLrxq8CtfAHzMhGw2xI+ceVZf1nyFVrPxR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5029
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Fri, Jun 04, 2021 at 06:37:26AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe
> > Sent: Thursday, June 3, 2021 9:05 PM
> > 
> > > >
> > > > 3) Device accepts any PASIDs from the guest. No
> > > >    vPASID/pPASID translation is possible. (classic vfio_pci)
> > > > 4) Device accepts any PASID from the guest and has an
> > > >    internal vPASID/pPASID translation (enhanced vfio_pci)
> > >
> > > what is enhanced vfio_pci? In my writing this is for mdev
> > > which doesn't support ENQCMD
> > 
> > This is a vfio_pci that mediates some element of the device interface
> > to communicate the vPASID/pPASID table to the device, using Max's
> > series for vfio_pci drivers to inject itself into VFIO.
> > 
> > For instance a device might send a message through the PF that the VF
> > has a certain vPASID/pPASID translation table. This would be useful
> > for devices that cannot use ENQCMD but still want to support migration
> > and thus need vPASID.
> 
> I still don't quite get. If it's a PCI device why is PASID translation required?
> Just delegate the per-RID PASID space to user as type-3 then migrating the 
> vPASID space is just straightforward.

This is only possible if we get rid of the global pPASID allocation
(honestly is my preference as it makes the HW a lot simpler)

Without vPASID the migration would need pPASID's on the RID that are
guarenteed free.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
