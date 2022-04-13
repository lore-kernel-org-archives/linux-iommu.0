Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF6AC433EF
	for <iommu@archiver.kernel.org>; Wed, 13 Apr 2022 14:36:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1EC734048A;
	Wed, 13 Apr 2022 14:36:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kj3-fQebR0Jd; Wed, 13 Apr 2022 14:36:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ED3F24049D;
	Wed, 13 Apr 2022 14:36:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C226EC002F;
	Wed, 13 Apr 2022 14:36:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1228C002C
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 14:36:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A635B4049D
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 14:36:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8E_bu22Hh3n7 for <iommu@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 14:36:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::630])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7663C4048A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 14:36:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLL3oAu70hXEAuKLcjSEnWx1x8ZEkF/gDaSiAVx/zL0H1BRxQWZ2WiuDLQh4fCe4gjS4boTc44aImb/v7Xq/PnnC1Z602B/w0ZwjAiS2Cy2LRm7Yoyfog3FKsp4fjDXfxAwK85W8CvcQbk+ojv6ICjMC2SmJPEf7n4cFcd4SXbRinoSOyjEbXLCT9a65A8dIZACKha7tGmSTMfhjoJSOHD3M1oTpzxxMjeuUih8k5hlnSbDIESwgw8Tjx8ITrFSOBRlbxd6hAyd/CzuPLyl+9+6X1gcJTv7Ie5lDCFPjsIoxa8dhlXfnNLQfqiUONt2kanJ/JT9oxnd2xSnoS719WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVezsj4aR4HTN0NVBfDLP+4msdlad6fPT7gbdvwozN0=;
 b=eo7SuoMrL7OxFNPNvnVJeGLDzlDJ6rLly/rvrUyCVegFtIgG4k81AdkcFNWa+eEdFdaRnnZpsCzORsbZb6njTz0XxLf2dBAZnkeD81d+eEeIo89UhXslGh0/w4hW7uy0RLiYWN3F6yA4eZ5x+h7wc4i33tVZBfhtofLswKpvzAjFEa6MXPnrNs05nZ7SHRAYK8/tcAtfqZOndlWZ9ZdI/H/rG/nlY91og3gp48IT5FpRT2/WZw6+ltzz4E9dGkdPqLdqqT3o5febJJeHsm9fIsAneluPZpAkneICmRCc7NlNIduworrQOK4ts9DBx4xb2OuRAQNX6SXSk6HNObzFmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVezsj4aR4HTN0NVBfDLP+4msdlad6fPT7gbdvwozN0=;
 b=O1ozQyUnn9Tz2amZQamA9VXJyTuLnaLJcWJCYfpmv0ebfZMXxnXNY/lZEbjeShcMVk7y7P4FsSCIk6rhPvKmLr4I0H4q1Hcc3hanLANdNm9zbZK04d1aRS16LOFeO2W+Um66qwk6bySnGP/EYmf2OaNQpF3f0pwqgG3Io8jrPNTsziNzK42OOImX9nWDG7iXiJ6psK1khW1sqZcXiH5XXCkUK4wCAVAr5Dz1ZfCJ4t5TwuUcyvMz8ntCqmsrcpVVoK794x1o4otBFhNt/YkvbL4timZBzmoZeDwnpuRrkTSQ3IP5ymqKNlCPjzpObKvITGf4l2TQ0lnUsQc5wDOLOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR1201MB2471.namprd12.prod.outlook.com (2603:10b6:903:d0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 14:36:48 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5164.018; Wed, 13 Apr 2022
 14:36:47 +0000
Date: Wed, 13 Apr 2022 11:36:46 -0300
To: Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH RFC 07/12] iommufd: Data structure to provide IOVA to PFN
 mapping
Message-ID: <20220413143646.GQ2120790@nvidia.com>
References: <7-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <17c0e7f2-77ee-0837-4d81-ee6254455ab7@intel.com>
Content-Disposition: inline
In-Reply-To: <17c0e7f2-77ee-0837-4d81-ee6254455ab7@intel.com>
X-ClientProxiedBy: MN2PR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e17b5793-d52b-4588-0b5b-08da1d5b0a18
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2471:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2471F9BC953B4BFC624D4EE7C2EC9@CY4PR1201MB2471.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S/r7S3VKlprgxNVOIw8BVgYZDISar+ZspkhmO4JBu0YXf9pnW0N1Qi8kClBa5w15CQuUWA2wc+Hys978eokTb8q9su/T/fX7w2N5DGM3DHpaY8JiphyN2iJZhNcg6AgKH5aEdStRWmr/vAOZd9VjH+PcztsRCbe+0X+XDNB8+f29PMjcLN3Ydz8OOQrBfp6h5dtIIryPsc4GTR4X9/PXEfBW2Py5jcGiTqu714Pb1JnB4e38HgG3FFNs1gY4vLWeJW63CP3jcBOubehLcJN/08mnLmWcZZ5zkenWaw4coSsxIhX6GhCCmHelE21W5XeJyydZ7SL9hvmczcSbl9pGWy2/XELM7VwXLbht2LBqxNF1tTPawFrTyzO6QPVWegyEcSwOTVglj34mhP5+kE9fgNmMibM4kolV4dG/9cRUU9lfBCxFf687tXV7xuv8SDwBAjC4T7YGut6y9Ol/rAcRsaLFhtt/G5zfIV9cKKnUc3pnpWXaqOkSIwjR5ISI9A680wuw8cpU+tiRlmpll9h3aHSaaE2fJZBzD7tdGJFxUiVRcq7k67Vibm33810rct6Vm2NorwsBTVpmNNz8GS5yP05YByigsL/g05dNcyUrgpdT/BqYNqyHHGMSbLO33c+8uJMtrkH2PlGlFxjOUMFBeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(1076003)(2616005)(83380400001)(2906002)(186003)(86362001)(38100700002)(33656002)(26005)(54906003)(4326008)(6916009)(6512007)(508600001)(6506007)(316002)(36756003)(5660300002)(7416002)(66946007)(8676002)(66476007)(66556008)(8936002)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ry06cqZ0VBXW8m6Lvj9cYDBSKjPaO5zkURT7sPm6sTvY/HhB+YTXRepmaIwk?=
 =?us-ascii?Q?93URB81kTkQ4O5dhB1oHi8nLtX+ufpG4LnTgbiSLtEJAzYQ6xPEfzLHQfud4?=
 =?us-ascii?Q?AVkvRbAhFVKSqWuMrgIKYHcYo4Nb2lrxIKp7e7jdLo6iRMRVr5aTl8fksEom?=
 =?us-ascii?Q?dDgCaUmD1FqiHWCbLHR6LuHHBf7XDmBgDL9s8HzLM2fxBKUpoHqumyD5LwPC?=
 =?us-ascii?Q?e9QKoadRIvYke2zlY7aYNGjdOMr/1xxBC+AV1qK5tIvpTt912CO2OibggsEe?=
 =?us-ascii?Q?nQsI1VFbZNBG1kSVECIQ52mk1GzxNEBJY8l+5HHLDo1PfV6kE6aSbcwVQHGB?=
 =?us-ascii?Q?adPOriTwxlsfWJrjlRVtJyWQQyf8rC55awNxr9oEy9w7qVWObaFCRUBZppbJ?=
 =?us-ascii?Q?DUDA4V4pl4L+sMGJLWAvDw29Ej6EbtoeOYb/ZZFbunSE93ix4o5C5XFNo9UE?=
 =?us-ascii?Q?CiRUZUtjkR7Snh19NwMxzeCrlj9aUW5VXgJoDb427n5FtO+XLPD2w/zn5jQv?=
 =?us-ascii?Q?oMBDSL+HBidwD3e4DNeOzk7Uq+25ID9OMYBgJ2hW91fL3xxp3buegLWvZaUj?=
 =?us-ascii?Q?aJPTG/VZAWkTh5HsBFFPZW1mOuwSY2j6Wfap9bvwFA4Pjs7233YD7Ztx3TmC?=
 =?us-ascii?Q?S1TVlqFRXDamhDbTwN9iL7pcX4IV93F//VIJtOAdffMavDqtJ1WsFa8k0JPa?=
 =?us-ascii?Q?Xybbc7QOgZ+45tCoiSxTx6nA/1w7vsmX9ylAtAntZlvY6byQ92cCM+xDVQUT?=
 =?us-ascii?Q?QROTb7Eltcx0YIzP0WoTFlmmAEk97YM0QyXTE41BP9FV68ln0bA5xa4d/S00?=
 =?us-ascii?Q?MqMaRnPZQTNh1D/ZRSAhKO6b5rKUVT7xM6AFnNF52gktAZfTCemtD64ln05r?=
 =?us-ascii?Q?wk0BfmiwRDLJHNsmDS0/M6T7v4A5xcKMbGnC23EBw7uZWi0gQ6VL4Dzh0wkw?=
 =?us-ascii?Q?nh+tvhqyg9nEDa9u9YoGSb5am6A3c0QoAv3043IeRBMl5ZEXFtKs2eYHfEXO?=
 =?us-ascii?Q?0Js8mPP/eb6z6rhjqilYbh6hd+0zuSzKS2VaLfgN+2boSpKXq1UpQ6Rx2zJZ?=
 =?us-ascii?Q?vfCUFvVSp5vIleyJEOnGU6Lmrh7sd5s1utfbzr9IZ2sfXLwr0ZeFdilCcT2x?=
 =?us-ascii?Q?O5edDGwJzG/zCD3euEqKzjGLDM6uua3rs15/yEWVIS5L2ufasFn4p2OGnGNn?=
 =?us-ascii?Q?lPBwGORqSaXxDEc/yKuAcf0GIp+aWlNiEfp1dsTxhNlI96aVe5UHiueddr5n?=
 =?us-ascii?Q?ICZVS76mOSzX1X2kv5FLErUARY2hbGnBwijMzMUuychJaSCqPNbjZm7Gy8yW?=
 =?us-ascii?Q?aUC3VRRglIxPrsIVJ0Qpbj6lKxQpJ5999ISEAAuheJyvQIDfvXxJrIqLyy/5?=
 =?us-ascii?Q?VrGZsmuMDH70L3pD2w+H8Exp4LrIIhahoJC0dQt/FRxRZMZwt2t7UeJ0Pt7E?=
 =?us-ascii?Q?OJg7jkWn3TK/i9R2lUb1SDsIgoYxCKYIaFrXgLXTh9Sua5/wNAYALGlERBoQ?=
 =?us-ascii?Q?LZ+0ScEHEt+795ZGih8rvG+8BA1zHFuBN7Cn9+D1XuseLEYwlD6X5h6KVsE+?=
 =?us-ascii?Q?y8ZRvp1staw4ImcftmJVEbHohDd936Pv5h5QJIai6JckrpCrmJHSRoJwFlSL?=
 =?us-ascii?Q?boL1+jEdOI81C+F7TP4Ea6oYPIaD72XFGTov2TIdNo0dStAbnoYVlf9S5oF0?=
 =?us-ascii?Q?zm9iNkfxZiTeHtH8l+XFlEdUz2FvBtAImhGIhhT0Wfmpxt7JZXwrh13jVo+D?=
 =?us-ascii?Q?ECMGcP7I9w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17b5793-d52b-4588-0b5b-08da1d5b0a18
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 14:36:47.6017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyQSYo/onYyN623ZPMpfGsibvQZ0X6NsEZ6Zz1VcYT0n+RvAqPTIudrUiaRBT39M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2471
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 iommu@lists.linux-foundation.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Apr 13, 2022 at 10:02:58PM +0800, Yi Liu wrote:
> > +/**
> > + * iopt_unmap_iova() - Remove a range of iova
> > + * @iopt: io_pagetable to act on
> > + * @iova: Starting iova to unmap
> > + * @length: Number of bytes to unmap
> > + *
> > + * The requested range must exactly match an existing range.
> > + * Splitting/truncating IOVA mappings is not allowed.
> > + */
> > +int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
> > +		    unsigned long length)
> > +{
> > +	struct iopt_pages *pages;
> > +	struct iopt_area *area;
> > +	unsigned long iova_end;
> > +	int rc;
> > +
> > +	if (!length)
> > +		return -EINVAL;
> > +
> > +	if (check_add_overflow(iova, length - 1, &iova_end))
> > +		return -EOVERFLOW;
> > +
> > +	down_read(&iopt->domains_rwsem);
> > +	down_write(&iopt->iova_rwsem);
> > +	area = iopt_find_exact_area(iopt, iova, iova_end);
> 
> when testing vIOMMU with Qemu using iommufd, I hit a problem as log #3
> shows. Qemu failed when trying to do map due to an IOVA still in use.
> After debugging, the 0xfffff000 IOVA is mapped but not unmapped. But per log
> #2, Qemu has issued unmap with a larger range (0xff000000 -
> 0x100000000) which includes the 0xfffff000. But iopt_find_exact_area()
> doesn't find any area. So 0xfffff000 is not unmapped. Is this correct? Same
> test passed with vfio iommu type1 driver. any idea?

There are a couple of good reasons why the iopt_unmap_iova() should
proccess any contiguous range of fully contained areas, so I would
consider this something worth fixing. can you send a small patch and
test case and I'll fold it in?

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
