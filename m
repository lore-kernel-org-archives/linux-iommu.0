Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F47C433F5
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 14:53:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A1C64169B;
	Tue, 31 May 2022 14:53:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0B1SUCFfG_26; Tue, 31 May 2022 14:53:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EC05E4175C;
	Tue, 31 May 2022 14:53:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE39CC0039;
	Tue, 31 May 2022 14:53:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35A27C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 14:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 159B082A56
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 14:53:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uFVrQJDp3-Mg for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 14:53:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::603])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5298F82813
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 14:53:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwHFt5ifQgnpoltNochqO7rP74Uvf5shSnswf3sB+2Dawhbpahdzk4zeTAmbOFGjJMi2tJB23QH7Vm00KT2D/3dg7QF9zSaeA13LCiv8pgqGzrRgKXXSnF6F5PYgeOenmvSMgV/Rnd5bHpmJyemz3DOJT1j77f5+oNaw2FTfF9noc+RY18ZtBcdGLU3BkHZvJgWOjKhaV05LCZeV48GR9d1U32RgYI5r7DZMszdDrdr7+vHuvQrdBFocnFVDSSUAJ1JUqjsqviMo0rdFCrfIQz/udoouLTZFoJ7S7CuUBOjz3//UOtxyC59hcqgRM7/F1039nLLp0j2n93JlUVrvvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nHypH3PL/Nd/fllOnYZFKkrt8qiUA9GpulPO/DYUCg=;
 b=JCOtVHBhByqT9OIte6030a+8/IZCT/kM0FHoWzwerC6HT4wFxsopUTJn4U8cXQ5CWbfSzNfJ0pjp0kvSGdt4n0Ek9bW81Vq5SQjM5l5kzRghly4uXprcDBpJ/SM8yY1x7RJFf2P/WXkQTskUm7t+BAcwvfneYFVezMJ7mYfoxw+G9eCV4HLcPoQxgPgv9RwX+ROz+GQdJh8HGhTBnufB67K1hAL+jkEdmmdpXqyWLdKeirXB4V9/CJODGxN/iaZpMKO0CyL9grIFBEPa3ih8b19hUeCtlC8rqn5QA5ePy65zMHHj5oM9Xzqh7xbmNQy2nWiPgS3+TpYTLGWcD7Y5+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nHypH3PL/Nd/fllOnYZFKkrt8qiUA9GpulPO/DYUCg=;
 b=ZrhBS6361nSLIHsMpZedu0aJfVhYg2W1JKGE5I+GkhNxCzfhEqZPTGABSAWdOa5AOf1ChpQ1SuFzi/4nDhN2x9VTSNbB00NLTXjKIh4WaDmEjjQNwTCIRuUEp70stsY9wjBggHnv7lRZ8mtKChNqQA1YbHHYbDKXVZLUu3PFTTuxp5mByos849zjb7aOPEXwrDgGwlhw6w9vnnz9s3j5dsrhcw7CPYezV3Bc8Res61oigQCNnDA+KK51a/Gyc81Tfs9FVr0IuVqzAhk970fQ9VdK2Ai1tVDu/ln/bVamyHaSyneww++WfYmlsivphw0ZYZThIN9qppobaZYcWVP8iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 14:53:03 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%9]) with mapi id 15.20.5314.012; Tue, 31 May 2022
 14:53:03 +0000
Date: Tue, 31 May 2022 11:53:01 -0300
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 01/12] iommu/vt-d: Use iommu_get_domain_for_dev() in
 debugfs
Message-ID: <20220531145301.GE1343366@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-2-baolu.lu@linux.intel.com>
 <20220527145910.GQ1343366@nvidia.com>
 <eda4d688-257b-d12a-56c0-0f9d3a10ef8c@linux.intel.com>
 <20220530121412.GX1343366@nvidia.com>
 <42623a73-c288-1c0d-7021-93caff4ffb6f@linux.intel.com>
 <20220531131052.GD1343366@nvidia.com>
 <60318d83-e22f-f922-436f-6c31bce24d59@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <60318d83-e22f-f922-436f-6c31bce24d59@linux.intel.com>
X-ClientProxiedBy: BL0PR02CA0144.namprd02.prod.outlook.com
 (2603:10b6:208:35::49) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6129369d-becb-4d1a-3b0a-08da43154377
X-MS-TrafficTypeDiagnostic: MN0PR12MB5737:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5737F55DC7BAC51052533E8BC2DC9@MN0PR12MB5737.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tOa+ekzzaF80kuOXGxR7fCu+BJn25Ab/k5u+pjLEL2uug/wu+4K7ykwA35ZXULt5ceal6FXb5GUEo9H594VuqTy2cT+4ySvUzDaeHdtA8pK8w0Tmgghxf/potK/13Uh9WWPYuNkzrzv878JNo2Wrt64e8jsQx6a5TLC9tRL7IKWbuxe77myEFMFLydkRAJM20GSEARywUB9ZAZUUk/6ELxflvr80aKhl8qpp1V/f56ptKZ6oK1IdQpKvz7iCiPX/nqnRDruBxEUuueyd03QJYMIaca5aO0hBh4eCxfH3xQe5UqCM5WXRbKTfXrwYET+/c6PND/Mxjc3qu0SpkgFRq2W3695zXH5M1OfpXXlTa0UUhbBbGHBkB60/FmmyLRAM12adNCmkcqARHk6z3EeFv52uWWC72WTZ2h3RQ3QE/4htjXi4KmqS1FY9en9V9G27To5DMDxJWBxTCWg7n6CiUEyNI0mbnfkkO2XzJcuveLcVKbQky/ZGzIGsZqgAAnEcGgiMwbMVIGDYJ/RbAcCkBXwxiUr7hSuEzR1FPUWKjY1XptQhCm7UTXi0HRiANqfOTm+xtIjOpQ/hgDMBVeXi+b0GGMxXuVOQyyU3tDdGpIuG4BhPHfPqzT4NxweCkAwwIzrRWi2ak4j3uAmY6udyVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(86362001)(66946007)(4326008)(8676002)(66476007)(66556008)(186003)(53546011)(5660300002)(7416002)(6486002)(33656002)(508600001)(83380400001)(8936002)(2906002)(6916009)(54906003)(36756003)(316002)(38100700002)(1076003)(2616005)(6512007)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M8SWigRHYUC8yl6HAnIA8Su/AH/qbLkHH2gQOpHWPBGBU6iDyONI24yONjxW?=
 =?us-ascii?Q?YrZUtvsGbFmERLOLuu4fKFJe7NHEDDSgZMmM8B2GjBcX7r982DhzXqjXEpbN?=
 =?us-ascii?Q?LFMocPuhHwJ4TzTtV3jxEYqxYT8l+85Y27SjHqsjXXaITKvoudN8cx8kpW2Y?=
 =?us-ascii?Q?r7HT5EYxCc30lPy/MCiEXg0MIVn9TmwalE/lHQwGXKjYYBpY+WZZewmWTgwx?=
 =?us-ascii?Q?SX5KtzYN9yH6OJ+LwIunM0fkqX/EK+JZGImGY9iVM7sHWJTYldRa1uRn2jCT?=
 =?us-ascii?Q?f7R3rdMLwnwq03P05j8I9cColcpuPeTJDeeNwhA14qQJ/akGf8cD1Y/AS8qf?=
 =?us-ascii?Q?d3gOZN9DXLIbxJmZKP0JizHyAllYdC0i91ASFbWelIRsvFAszeUhywou5ubG?=
 =?us-ascii?Q?yVD7KLa4xA6AsCz1DIdKvcRLS3MqZgvuSUlBZodmUZs4Aju3/UkHLFjIbshj?=
 =?us-ascii?Q?D6ytfUPBBMTU7rH4xzwwag5xabvhUDsI+J4+y6E3zGeUXatZeMGs4x3bMTl9?=
 =?us-ascii?Q?5qxdfRGKnOtQ6XwKaTjMfl5FmRWu9c7ACJQLxnXkykyExopGxGhmN9YFNvxe?=
 =?us-ascii?Q?K3rV6+WVZNOtELkXKEgad25LbPa3FRQA1yMZxDRfRr9vmaElln2UWZK2CpGc?=
 =?us-ascii?Q?J5XB7k+5NX9OHxIQDXlpRp3KWTUsVMu0wFiPfhVbQrFcKiOTets0tzkT42CB?=
 =?us-ascii?Q?Av4YLTXd28ZdZiqSdX1r0piADEZI9SJ9tPldZFC96ZWohlvexF0gzNdvKQN5?=
 =?us-ascii?Q?QtK7gKPJqwoFye67DhCKnErwdr2liBi4i0gBvt9Ho4uu+6vw7wZ7q3mIzL/8?=
 =?us-ascii?Q?C+u47WjB82DxgaUI3lQYHoz3RBoN6DPGU670yOwaRt64KcXHAFJGf79NYYoY?=
 =?us-ascii?Q?wf5ITTEvkNDfU6Lq0hOF3a58OZuhTfE6kS9UNmGIn5dK532bhl5ay70sf/dN?=
 =?us-ascii?Q?WSpta4rXyKKD2OsuO6pG9JUdoN26Buvii6LQyJQ+0FaG1qpeu5RQDJl+PKTX?=
 =?us-ascii?Q?0n5lR8/ZjwFBkDuNFM33XuB6blX6LQdLww2BNFmKlS4qyH61w2e8VoawtScT?=
 =?us-ascii?Q?uqG0C8hD6h+AXQoodb58QrM3vicrIAaRMP0aZuS9u0c/eMtuP6dJVmIRXX1b?=
 =?us-ascii?Q?ctZE1PKwTwihKL94QWOvfLtFAvaOY5Lk3x0CDLZLfNMePDwiSyk9NK3mV5DI?=
 =?us-ascii?Q?lGfliOTX8TXKnnzjAJx4xHHrVamXcK3SNsbaZnMtqM3sKGVv6ulepjTGgBTF?=
 =?us-ascii?Q?pQ+R2gC5tz/ccUvkpgHiHPXUziLmfQpJ+6nFpePKezuN5ERW3HyHgvzPeLw/?=
 =?us-ascii?Q?i1tP4ZQbGsMr6fea4eACxlsawej8Q9VodADY/oLyefv6jbl5HXNgNyPyDhnL?=
 =?us-ascii?Q?7+ZPyoU0f7OJVGNkXZU/C/mfapBGDcufgzGwQzLxpEeruvfz5QzXO9RGgU/6?=
 =?us-ascii?Q?8v3JUulFyiJY9/7QRHCTs+yJbrDL49mi7scY8SP1pAYPzYpFIhkmunNZrioK?=
 =?us-ascii?Q?zBZ7MIJyG7izvnb6OHwkZjga67Qzjsm6QWHU5bKqOzPhQpCZ8LGll78u90is?=
 =?us-ascii?Q?iHl8d01LJdoSXtYurNwcLXN8a60RYcvHJv+YKQvj9ruDFPbR70c+epclVC2d?=
 =?us-ascii?Q?Q/ajs1vYcBbIGDSBj1qHclITyKxOQEQAVLcWqVY6jvLjXrd5q4VM/vt2dfZ/?=
 =?us-ascii?Q?W8rlCaPMd9nf5Lc0uTVJrH/xH+9Gcq8N5XNDrQiXMIFtZzR/MYJcxtZzQoh/?=
 =?us-ascii?Q?NNClkmW+Ww=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6129369d-becb-4d1a-3b0a-08da43154377
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 14:53:03.3326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OpIW/fUhuTi2Sp/HDSqgAJhVuLcP7kn1ZTevI59g/Vi6MPT82hkToNSTjJgpuFs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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

On Tue, May 31, 2022 at 10:11:18PM +0800, Baolu Lu wrote:
> On 2022/5/31 21:10, Jason Gunthorpe wrote:
> > On Tue, May 31, 2022 at 11:02:06AM +0800, Baolu Lu wrote:
> > 
> > > For case 2, it is a bit weird. I tried to add a rwsem lock to make the
> > > iommu_unmap() and dumping tables in debugfs exclusive. This does not
> > > work because debugfs may depend on the DMA of the devices to work. It
> > > seems that what we can do is to allow this race, but when we traverse
> > > the page table in debugfs, we will check the validity of the physical
> > > address retrieved from the page table entry. Then, the worst case is to
> > > print some useless information.
> > 
> > Sounds horrible, don't you have locking around the IOPTEs of some
> > kind? How does updating them work reliably?
> 
> There's no locking around updating the IOPTEs. The basic assumption is
> that at any time, there's only a single thread manipulating the mappings
> of the range specified in iommu_map/unmap() APIs. Therefore, the race
> only exists when multiple ranges share some high-level IOPTEs. The IOMMU
> driver updates those IOPTEs using the compare-and-exchange atomic
> operation.

Oh? Did I miss where that was documented as part of the iommu API?

Daniel posted patches for VFIO to multi-thread iommu_domin mapping.

iommufd goes out of its way to avoid this kind of serialization so
that userspace can parallel map IOVA.

I think if this is the requirement then the iommu API needs to
provide a lock around the domain for the driver..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
