Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190D41CBEA6
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725638500; cv=fail; b=an6KnxJdSNPlQNPMfz6Ckvml3A/d5m5cvbgxH6pR+OqAsNS5s+zc7GMU1SSu5jYa5DL61PHNyw82USLsKBxd8k7f1LYfWNgc9IZWaYzRo1PhAa2EUJPXmkV1yQTqWtA4ROWgEn8DJG9LsQt+otg0jS1hAtXuyI1a6Uz+p/GEa+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725638500; c=relaxed/simple;
	bh=YvWdMoSH+T+FJ9MbMxCwo/ydBMvhG49Y8MTGjLNz+Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L+efIPCkiUJubX26v9EL2JxtXWrw1B7/LjoKCHXAMTExrRoqcDkkqoBJZWCTvtTcqvwlwNiEPkZf53irwoj6psIusMGNbPKfYAp9vg5vXWhfTfQ3nX+CEIfUgnU7vXVCyTQzAsj6son6Nwi60xRax31JMcArGLHkClCbcbOq330=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ipAeKvf2; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ipAeKvf2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zU6NYob5FO2v5/2lVnZjt8H/KKX0dVjaxi4bbi6PH8aB7/jMBFcuTM4AKqM2O0uf3QTmHFREVijROm19x191bULjcWA/I7XC2JJv2Gqvb9g8rn6xfVUpTql6k83IwvKCrz6IghpkR2D+QhLzpWTHIc2OLWvPuNEfX97Ewp6xvs8jclPtuoMJauMz37ofJaSaQOZSrCGP0T+ppHcVpuRfQ1PRuuBE6yEIv3FiehjRJOOq8kFBMSnnGCIGFOD5H00QRJNi9DCe6pMdpzZe2ELPXDvSEv1vFfcM9r3SYrXCqXVOiuOSNZW3IvtaCuaPzVZzhlkwFe4pnjVVMM7HubbBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mvzs9FXXe3XnJTNlorM61S1ZCmoiNhwAtn3pLjd1UM=;
 b=aO1dZHOH5jMqpq86DGp36WGDbOg45xmCiJZmPLwkoIwKE45yB/v16V+HX8B6Jh2fO2Oeyy5iPcBo1HtZiJpuPOQBG+rfH+r6iSDuh4NDCvbZwq9MrSHGpXKqE8invTtC5zJZCqOA6xDSR0bGDIUG9++wBtojUwS6QzkfHuggkiLE0ADhHzHm7XpVGVQyu92nQijxieDSoF+mbppsDIG+JdYYIY9Qp8rYhqCS4kYXSQxz++G/Hm2nacnDgr7n5Nvv0lRT223U5j/4wYl5jFsscQcOrghk8C0IHedd5NtSVPx9B+ol1+yAljAwU/k9l1NjpV2enbcu8a5C9vKNIFE4lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mvzs9FXXe3XnJTNlorM61S1ZCmoiNhwAtn3pLjd1UM=;
 b=ipAeKvf2CENDD5co1dyCsWF0O3K7tUq6uL4y6m9d4cn2sXXb+B8em72nz1e0CkX4ly1eSifry0XAghWFjoyKK4AuFmFx3ldVJXzbizRV1tMkiLnStiG06hHdOP3ThlmbTZZ5C2HIvmovAw6KrTcN1D4ZzEfH9VlfKDA/H69G5E1Hj+FP9fixJBqk7pocdQPFlIxRZRIpSv1tDr8+AM7eTiVnWSoeId9VOwPLgXaQIeKri2SFpCa25FWG8dNFp03CtnvcBLypTA7BrYJbWDba5GMLsJJYh9OvbeXRjld8t7DgMI+oXgSAd5n2NGHLEzhZhWYBs1PIwaKtjhXEMApWdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 16:01:34 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 16:01:34 +0000
Date: Fri, 6 Sep 2024 13:01:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, ubizjak@gmail.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v2 3/5] iommu/amd: Introduce helper functions to access
 and update 256-bit DTE
Message-ID: <20240906160132.GJ1358970@nvidia.com>
References: <20240829180726.5022-1-suravee.suthikulpanit@amd.com>
 <20240829180726.5022-4-suravee.suthikulpanit@amd.com>
 <20240829192804.GJ3773488@nvidia.com>
 <4c72db01-448a-4bda-89e0-9c92a2f89154@amd.com>
 <20240905182105.GZ1358970@nvidia.com>
 <7536443a-9871-49f3-a42b-28320dc57fc4@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7536443a-9871-49f3-a42b-28320dc57fc4@amd.com>
X-ClientProxiedBy: MN2PR15CA0053.namprd15.prod.outlook.com
 (2603:10b6:208:237::22) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: dff7f092-e17d-49e5-1647-08dcce8d2e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FnRKN1zS2S77wZcCLmrQyBWF0A2/fGYn33TW+TcqnVpJCn8Z2eNDMm70cbir?=
 =?us-ascii?Q?fkaLCALka05p4La/vC3TB2sx3jxF4bcxUQCow9oB8veBCkEK6vydgpoPCrI4?=
 =?us-ascii?Q?3vgE/UxvXPZJbZm6bTMTBmAuLInB/1HH6vli+e8DQQp5lnO1NMNnH60J5r+T?=
 =?us-ascii?Q?wdDg5ZPgQbZ/qVFf+RURrFiRmev3Q43f3LSNLnbFAkFevVcYgdkiFbs4Y0dR?=
 =?us-ascii?Q?yuxrvcyEc1qNM6KLTDYfh4182y6MYbYbQxx9Yz/Lct8iKQrYBVuhU9+QCgc9?=
 =?us-ascii?Q?abuaLLO7n9Rd1lMC5VXkUEH/eJNwBsO7VA3PrfbKdErjDDQow12LzNiXORg5?=
 =?us-ascii?Q?PQLP1uXffv4rd29pDaoG2cxGOH6lXwKwZV3G0G2h3VlaXHaUeaZUQC9KfUqq?=
 =?us-ascii?Q?pBOqAcfi6BtyfvWUZrfHLSuy9T1yBGf+2Qtbuu4EukPNLjK+XevVxLr4R/Q3?=
 =?us-ascii?Q?73YXbrFcSbr+h6HuXzjzuLLCr7A1bt3sY9dV4GKr1qdkqgLka7l3LArgJkiX?=
 =?us-ascii?Q?0TVnB+KhDmyxz+/QPLZ7NWnfcIOj7Pg2k7616e3AwEeJ93m6bxaVtEHj2Ehn?=
 =?us-ascii?Q?3xTTn/HdD4QxMo42OdgbT77N+TjzQY+YoKDlfhT58Yh6v77zgwbEaixbgyRr?=
 =?us-ascii?Q?9cTEZJImZofeHXatlwLbRW6Eyg9H6OFrDdOLtpzwvi/JB98DswnB6V3TEYZF?=
 =?us-ascii?Q?M3GzmSGuTciA1MV7KcP6Aodtm5XQoCne5PJ5zTDffChj6u8TryVxsouIATdv?=
 =?us-ascii?Q?f8QC8x/Zim0h48X8FA1Akw2ooucUYMyRmDVS5iXaPZC8NKkeh2mmfOWG+XWp?=
 =?us-ascii?Q?7SW8RjLzc3Vn1XUPntLZU4wjhUKNVOxXP6KX7vkKuRjRD5DztjdKOFngFi1o?=
 =?us-ascii?Q?l+fePGRGcCDksxL7iqCaYikSL9H3Ue/uMueXkW5qzUbpC0GTOvO5/wbDy9iV?=
 =?us-ascii?Q?mjWRQaN4yqH8GYj6oEn9ktuO0N2M9CZfBM8TvPeofLkRfId2ToXkDe9DFeLt?=
 =?us-ascii?Q?LAc/LnWI1cRgHzI/pbwnxAHL2FUXCOZ7mECBBud6MRb8SF2gMDU4HXE6ic7N?=
 =?us-ascii?Q?UqGEUrw3927xEb+ZdycKUdt81AYvjGtCrQTY2D5f0YbcuFkEMrq4+NRANdRW?=
 =?us-ascii?Q?jgf9NgO//OJjtZi5pgjWyWJQqj9Z8u6l81nBAVk5ZDnrCztrDAtuqkKCk/+3?=
 =?us-ascii?Q?nDz7mRIVTgd8qx2V2Be5X+pb7K7/yjlIyB6U6WnSg5JFCv2iRggN+YaT+vB6?=
 =?us-ascii?Q?N6tTBvtQxYxzXnO978ebo4tg1VGk+HLIZp38wY1EsL1iLnrwQd0rMskd2aah?=
 =?us-ascii?Q?U38UVIgZFh44gwP7Ui6NhthWx8vcLkmA5iuvRoZc2ioQog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mjwVsv3/FuyV9WE7ue1Oh49wgDndgF17wEicu8xZENS7GCOWRfDniid3jvd7?=
 =?us-ascii?Q?+zzpVWHsvezePs1BbXaYAsg+lA+FvAMWFgWFGF1f1ViNcZumgDPDHl4NXOHr?=
 =?us-ascii?Q?GlWEX0ERKbA/9g9OX4Ar1duH5jL/cb4LjQv0odxQ9B9rNOjlqnxu9LlVOSW+?=
 =?us-ascii?Q?keXmJuFEJcNowXdKLqdevz3nNWifrPOsvWG8/2sER52NW0fh5oqLH5brgeRE?=
 =?us-ascii?Q?OZ88IaF0wOl0DPB5Av4nf5KEz+vf5LZg9EDOwwYX/9vzhFGhQL5t2ZF1CJ4D?=
 =?us-ascii?Q?2CqAaAi9YoMm/PwTA0+Yi+3KokPjEVfHhVPe9Mo/mZGMGzWwDjGxGq95RtrE?=
 =?us-ascii?Q?x86OSuQUp8tWUC9uiprCX3AuOY8mky0Mnh7FRUjkmOgyVnx8IHj86VjUVf5U?=
 =?us-ascii?Q?TWkTdqVG1aQX5hA6ti3A310rdGMwlmShSmaz9pZYB0dFD3EuTYc/oWo9kfL9?=
 =?us-ascii?Q?50+VopenPxxruj72FHgWqIwk174fzloM5LyjcwiK0H9y5xToeYi9ouTEwOxe?=
 =?us-ascii?Q?mTCEBxVy4/BKY3PdskEAYSQI0fq4+Cv+vYrj/Qekt9ftN0Ush+1tZ7LOpnwR?=
 =?us-ascii?Q?mQiNLxN5w/K6dL+4O8MUEAQbfWX89bCa6MfxCL+0TSPz4grH50+3XoCER3Nc?=
 =?us-ascii?Q?qOcMwgRtnnPkxdZGn3EP3BoeTdKn70oEq5PxBoY9QXvF+vdOPPILzKxNTjaA?=
 =?us-ascii?Q?PxdPxy7jVy2fszH/2cBVQ3Y5AE2Cc55+Rxp5tL55vIhUS505GohMNTbH/x9t?=
 =?us-ascii?Q?/F4zKf2aDTzybgtT87016RQ1xQIv3L0t2ggNUyqpICl+MBEgaGesiqRvN7a6?=
 =?us-ascii?Q?gq2CLFhcVCHK28Ev3EmtQ8zC2Wh7fOb5aHXjWMELshwJw5+uvIkWhC+dD8oP?=
 =?us-ascii?Q?RgeWuzqGDHrI4LV1FI6LxiOudzveNy97YzD5MdUtO+apsd37KlznpHNNB6Ao?=
 =?us-ascii?Q?GRlswnksziQW2qROJFPCi8NaG0GrAKI1Qi2faPh/sZGQwzwzjsYtrxPlxvWH?=
 =?us-ascii?Q?p7QPH9OoSkfXo5yhQxrI7lrjNf5wlw6Yo4FM+lpkzG2gmpUgnUMJwu28NiSl?=
 =?us-ascii?Q?cYHLoj0OTJyVyJ6kg0WTzsH4CGoSLAUPQqkqkdUcV/vO8HIIxdKjueK5yV1z?=
 =?us-ascii?Q?4aFZV92s2hWIi4mXvt7mrP/lUN9qOSN9KlGOZCTaR0uj014cjLnF+xnM1EUl?=
 =?us-ascii?Q?SP2p/x70CFo3K6+VOw8cOTF8KbpU3cEQcbg2eqo050Qmxxu78PyN6qN9ACsa?=
 =?us-ascii?Q?nZEHy0K+Erv0wlXpUlF6p0wkmBEuhbg1ac9XlbtS35sVSryilXPDxl5FSF/H?=
 =?us-ascii?Q?sNxGubQmzfGAc3yoGZ0UJtZ75x8efBpts1BKgJAl/fdiMc6zqFAELSkSnBQa?=
 =?us-ascii?Q?DC0Md9K4QFJOoZcTKBZDUjj4zPaYEsEUtVb+XxDnzfpthe3I/7x0dMGHW9zt?=
 =?us-ascii?Q?H5hoTHen03erMnRuXih21jFdpvO0OF2EQ/EPD4HYS24vEoXJyr1rO6XSPTWI?=
 =?us-ascii?Q?bpIY0Mb2y8OgSX+pn43aNZalNhG6qbNpDwUeKnVdNzesR8nCX7CZzAefF2Vl?=
 =?us-ascii?Q?Hgq7FGRTmeXjgjTdzwt4WT3w4W87/LbMTS1B56wv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff7f092-e17d-49e5-1647-08dcce8d2e56
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 16:01:34.4419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJdQ2HWVFlV2Nh8N/Ec7U44+QFxPDqw60TW39CrL+cdLE/AbehbB8aGBbaMrfoHj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481

On Fri, Sep 06, 2024 at 09:08:06PM +0700, Suthikulpanit, Suravee wrote:
> On 9/6/2024 1:21 AM, Jason Gunthorpe wrote:
> > > > I don't think you should restore, this should reflect a locking error
> > > > but we still need to move forward and put some kind of correct
> > > > data.. The code can't go backwards so it should try to move forwards..
> > > In case of error, what if we pr_warn and put the device in blocking mode
> > > since we need to prevent malicious DMAs.
> > IMHO a WARN_ON is fine, and alerts to the possible machine corruption
> > No need to do blocking, you should have a perfectly valid target DTE
> > that represents the state the HW is expected to be in. Resolve the
> > race by making it bin that state and move forwards.
> 
> What do you mean by "making it bin that state".

Sorry, "be in that state"

> > The guidelines in "2.2.2.2 Making Device Table Entry Changes" make
> > this clear. The indivudal CPU writes smaller than 256 bits have to be
> > sequenced right.
> 
> For the interrupt remapping part, no special step is needed if we can write
> do 64-bit write. 

Yes

> Similary, for the address translation part, no special step is
> needed if we can do 128-bit write.

Except for GuestPagingMode, as below.

> > This section looks like it was written before translation bits were
> > placed in the other 128 bit word - it assumes a single 128 bit write
> > is always sufficient which isn't true anymore.
> > 
> > So you still have the issue of having to decide if you write 128 bit
> > [0] or [1] first.
> 
> The GuestPagingMode bit is in effect when GV=1. So, the higher 128-bit
> (which contains GuestPagingMode bit) should be written first, and follow by
> lower 128-bit (which contans GV bit).

Yes, exactly. That is what I mean by ordering.

When clearing GV=0 you have to do the reverse ordering, write the low
128 then the high.

Jason
