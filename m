Return-Path: <SRS0=hOEw=KX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF1AC4708D
	for <iommu@archiver.kernel.org>; Fri, 28 May 2021 20:16:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F27A61175
	for <iommu@archiver.kernel.org>; Fri, 28 May 2021 20:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F27A61175
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B003A60908;
	Fri, 28 May 2021 20:16:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id toydhVtKhfjw; Fri, 28 May 2021 20:16:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F75A608E8;
	Fri, 28 May 2021 20:16:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AEDAC000E;
	Fri, 28 May 2021 20:16:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A286AC0001
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 20:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 82F0740149
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 20:16:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5LoadM4WDNzi for <iommu@lists.linux-foundation.org>;
 Fri, 28 May 2021 20:16:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2061.outbound.protection.outlook.com [40.107.96.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 518BB400D4
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 20:16:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCBajrc/pC7K92AJ8mWcaNttsVSSv6xJHomDRCq/MMFMjFBS/FvQ7FrLGQb/NmdLOnFbovr7GQ7H8KBvV06rdG+Hx0mhUexf5ZcUPPWmHqDfzaUVehJPw+yrzjNLbBmAukBXBBrUIBy/gmNs8D4ITVn8bFXED5NO9c8K864BexqXIowqJWoG0bS+FrqsUUDz7/x/Diel2Q7x4Xbmm23BGoDyIahQBVq2TA6f+TlOWljydP6/wmA1GbuNwtvwj6QYlS7y1Ok/yOn1jatwxMJcFjqds2NsJhnTpyKuE0bVSDead0Q28UJk++V/u+WsNC586fHRghZdzCzIICyoz3tYcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSrZS3j5Ud9Ua3decRrevHQts9IkUB/2GxyUnWfay4k=;
 b=EKFx2VnsTf4LpMgD5wrgASUEUnzH9TOpXJB5WCBWpyZCpuwATFcv6I+yeRbPnt6z4VI1hWCR+V/mweNiF1Vvs71XgqtLWNpipH9jbe69NxIgNwD1YfbqiP36cyyoDFV8XuDCAMGtgyXH11HBSQKIp3d235cKIdK1BxFkRQu/BKFiZjr6ca+pHRywHUXO+kO6jnvibXvu7uEJ6cdlQAVwQ3zVKihZ7WDPWzqDJJVDRanLSwVEC/sBEIclbZq/ZDZTDVcXYxpCZo5+ktFuBxTI5gmBC+pm6+ecJ9Xz2CM6b153j8QY2w3VltTYS7z9q9rnYEkwdTCLutmyhPSwiCbNxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSrZS3j5Ud9Ua3decRrevHQts9IkUB/2GxyUnWfay4k=;
 b=WXKB0XA+rMjL474T5EwgtJ6p+FKdnNmF/tVgvfSmJ3mN1B1TAMCUDAF6Pfcmdqt9M5HeCUE1Zl+H45qPRE/a9SqkO/CYLkG6Ulwc5TSlWrneSR09jHtBbRvW29AVcmO2dIGDwYbi1HGdmieZ26Sl/8RKu1DAChxi/XNyGB1FLfwLuWYTLK0QMHkWJTsB9cM0/ezPe0j+vZ9rZU6Tno0HRSFeswxCTDBxyNETxOANJJ/AxO6+jYOCLPSCsuyBjauGXt1Urb0hmwCyhifnAmcuZXlS/j4TimMEEmYofssx1oNWqcrBtEjoYxtF9FjxACxKFHQPmmOj1Gdlc9DSFg1siw==
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 20:16:29 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.023; Fri, 28 May 2021
 20:16:29 +0000
Date: Fri, 28 May 2021 17:16:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210528201627.GQ1002214@nvidia.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YLEY6yAF1osdtS3e@myrica>
Content-Disposition: inline
In-Reply-To: <YLEY6yAF1osdtS3e@myrica>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR14CA0012.namprd14.prod.outlook.com
 (2603:10b6:208:23e::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by
 MN2PR14CA0012.namprd14.prod.outlook.com (2603:10b6:208:23e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 20:16:28 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lmiuB-00G45a-Qh; Fri, 28 May 2021 17:16:27 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43817778-9386-47ba-4818-08d922157a10
X-MS-TrafficTypeDiagnostic: BL1PR12MB5208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5208A71D9DF47A144DA6B2C1C2229@BL1PR12MB5208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KEsMyMcaWoF/npwOiOflXiWlaabhiucsjyWleRo0is1S7+DLg6UsCLYMS0FsZQak/dLLrGQzb3Qp7iUErIAxnRtEf/NjqdqP97TQ7Shf7w/IslMJqkF0GcF5iIT1irISNr9OKJ/KT0jjBFaBknfQUiO9gQO/AyFGJTibSCNoQCt93BgJzwENCpE13yStAV3WZ2F1XWEqpuismIVWkqcIdX2/1MtlKB/3v2As5I9kfbS19n+egnJ9MKEWfzmRP/4r+swVgHHtdBHCg6J0ib9vHQ0Of+vwvp6LaUXJoDqgelL8A2ec6Jwq8auddGSsVixH+qhh27cfD8KjSdB4z4zLhuY9i29NiOisTX7Lvn8OyieOyPohriybA9tIFywIzTwzNiqSt0fGxkMAK4cQ5xigmQX5RmpyZs/Te18VTTn2jxu9wtPA1PrBfBhiXxlNRQdXC9qCCgbjZQ7CMsv/8F0tptOwdIDgYnu04sEwFv9ZuMDJWiJRjOkEkauO4KN6SGMKH8dV3gx51hI2j4k2tMgBVcXwATFSXkdNIjj4WR/l7YDPtYLosLJpRDLDh1ZNt6QttQlcqGFJ8zWfF3hgz8Dy7y7CRcuhvOt6PSntI8xlNEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(6916009)(33656002)(26005)(66476007)(66556008)(1076003)(2616005)(5660300002)(9786002)(186003)(7416002)(38100700002)(426003)(9746002)(66946007)(2906002)(54906003)(36756003)(316002)(4326008)(83380400001)(86362001)(478600001)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?P63DCr8Q9Xj+LZoPgjvpaZQkpTwJ9gb3M4gQCFtY/U8f0+ue2zleOTuhK4hg?=
 =?us-ascii?Q?dJYNN2CSH8QPotel89JpdEuFa8tDegGJTgVI/VkwTZp4Xnd//X4l+lig7Pkq?=
 =?us-ascii?Q?Hd/E0F2tqgevU+0JhiamVtX5vEIPtlAtviP0asvUKChkBIkVFBAJBbAmYL5j?=
 =?us-ascii?Q?t2fw/x9W8ejnzFXZUPz9VQQ5A/dPTUR6Z8xmqRw+IqCB3lguO9WphNp+vb6d?=
 =?us-ascii?Q?1CVGHKvJlJMlglEu5OanKNxkUrhMOtBL/r34EtwSOowTFb5dWUrp3kv9gVao?=
 =?us-ascii?Q?mMclAiEu3v0hvjvW9Ym4PG8Fa7tmhBSJWY+NG6rTs2jqyQ9+AZ68f1H1SdMq?=
 =?us-ascii?Q?d3I+kjHRxkYZs9C6vfZdivi6O7DIx+EZMdvKI2YdETNAYDes4ITnMUYZJPlB?=
 =?us-ascii?Q?if7v24eWtpbnJfOv7hcDSNIgFXk4/V80X4ijbil1BgzXvyIPABzmtgLVCKcB?=
 =?us-ascii?Q?blol9bayb+NtT0EAuZ0RWDr7mZ3n8HsGNo2lD7hynlmg7gjo6H/FIossXoTM?=
 =?us-ascii?Q?+C+eLbbxSLbBDK00TWbNL6HP4MASeg4RklxjjaA/RWEh2OtQgknrkisDI4Rc?=
 =?us-ascii?Q?bVL7V3pGFakDeo5p5qNNDSRKMubvOt5yQHeJsE7HipbW8KB6TFNivaS/Lamx?=
 =?us-ascii?Q?eJTZu8a+p6+wIIkh3LxEqdB9JYaNHx7etYEogwVWxBnweF5tQJLGSovVNBZB?=
 =?us-ascii?Q?BaQJKn/VZAw9uJTuDU4WmpUu0TveACXzXQO+gyD/y6lr/0hLr8zOQ0rNCJPe?=
 =?us-ascii?Q?gzRJhLh5nh3oG0pVcbA76QsXB2Fac2eMWn2iwXjCE6hyzloBiuAoyyZdGhGk?=
 =?us-ascii?Q?+rrlJX+dLU3gTZ+e9MxBgMkn9/QteKN3AlhQdsatLYCaWACtOWxo7lGS56K2?=
 =?us-ascii?Q?7JyLjhPJqnwXYgqp7lpHesYJRQJYBC2UZ9Ns597kPV57Z0DlbUNRG4fhiQMV?=
 =?us-ascii?Q?sDvAoDCwssKqytUzPIp4EsAl0xcP25xHWtIuDoyYXsiRH1z+CW79nlpyPo+J?=
 =?us-ascii?Q?wvleGO9HYjS5OTj4ej1w9IkDv2spheIBZAFHwWQYcwhQ2YGERa7QX1ZYLU3A?=
 =?us-ascii?Q?VE6cSSdZISG9RLCr2V1Ao3C7NYY5DHRvDIBOFCMaoCvKaPxjY8eZ80NO319f?=
 =?us-ascii?Q?c3GCjSoaZkLJIjcMSwyAdwSP79JaeabsjxZtQ/j6nuT8RfPaT+H7lTYomWCc?=
 =?us-ascii?Q?xJkez8eSmKrhHImeNo2VyPC6slm5oF9kTeAzk1jASBzQX9jw+TMebh8VQLf1?=
 =?us-ascii?Q?eU1Nk6qi53d/l2wa3s+8OSyor13xZof5SJcgJrWS7jA+KFuHA9Y+PJbl2FYZ?=
 =?us-ascii?Q?bpudAxTvuW0xTQfg3BeYp1o7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43817778-9386-47ba-4818-08d922157a10
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 20:16:28.8714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BO1c26H8mKwYhIq6bISInK+ZgBMrMFHiwUsGXkbLgGbimGLafUqp/pl/ybl5iEm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)"
 <alex.williamson@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
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

On Fri, May 28, 2021 at 06:23:07PM +0200, Jean-Philippe Brucker wrote:

> Regarding the invalidation, I think limiting it to IOASID may work but it
> does bother me that we can't directly forward all invalidations received
> on the vIOMMU: if the guest sends a device-wide invalidation, do we
> iterate over all IOASIDs and issue one ioctl for each?  Sure the guest is
> probably sending that because of detaching the PASID table, for which the
> kernel did perform the invalidation, but we can't just assume that and
> ignore the request, there may be a different reason. Iterating is going to
> take a lot time, whereas with the current API we can send a single request
> and issue a single command to the IOMMU hardware.

I think the invalidation could stand some improvement, but that also
feels basically incremental to the essence of the proposal.

I agree with the general goal that the uAPI should be able to issue
invalidates that directly map to HW invalidations.

> Similarly, if the guest sends an ATC invalidation for a whole device (in
> the SMMU, that's an ATC_INV without SSID), we'll have to transform that
> into multiple IOTLB invalidations?  We can't just send it on IOASID #0,
> because it may not have been created by the guest.

For instance adding device labels allows an invalidate device
operation to exist and the "generic" kernel driver can iterate over
all IOASIDs hooked to the device. Overridable by the IOMMU driver.

> > Notes:
> > -   It might be confusing as IOASID is also used in the kernel (drivers/
> >     iommu/ioasid.c) to represent PCI PASID or ARM substream ID. We need
> >     find a better name later to differentiate.
> 
> Yes this isn't just about allocating PASIDs anymore. /dev/iommu or
> /dev/ioas would make more sense.

Either makes sense to me

/dev/iommu and the internal IOASID objects can be called IOAS (==
iommu_domain) is not bad

> >   * Get information about an I/O address space
> >   *
> >   * Supported capabilities:
> >   *	- VFIO type1 map/unmap;
> >   *	- pgtable/pasid_table binding
> >   *	- hardware nesting vs. software nesting;
> >   *	- ...
> >   *
> >   * Related attributes:
> >   * 	- supported page sizes, reserved IOVA ranges (DMA mapping);
> >   *	- vendor pgtable formats (pgtable binding);
> >   *	- number of child IOASIDs (nesting);
> >   *	- ...
> >   *
> >   * Above information is available only after one or more devices are
> >   * attached to the specified IOASID. Otherwise the IOASID is just a
> >   * number w/o any capability or attribute.
> >   *
> >   * Input parameters:
> >   *	- u32 ioasid;
> >   *
> >   * Output parameters:
> >   *	- many. TBD.
> 
> We probably need a capability format similar to PCI and VFIO.

Designing this kind of uAPI where it is half HW and half generic is
really tricky to get right. Probably best to take the detailed design
of the IOCTL structs later.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
