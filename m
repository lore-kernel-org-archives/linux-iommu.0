Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82172F36
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 16:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1slFCX/SKYEeSEHR2qYuc4D0RXDEVTouEnr7N772hBASjAToQRX10gQeBMpXt0cRfA/lf823Hu2rhnlRMDz2DfnIjfslkEpQCfX3oSrR2nfLLtzwm/P53hseYhLd+lbCFfAYWAWxVcxS2E4mMWX/0g04YwjpvbPJbOf3UKaSRqf/JJIpM/96hlRmlyShUn1b+8ludIRQ/lxcd6wF1+S+LSYH+SCSFMu32T2Bf5w0XJ5qeduYEWmp4r7o6BRgteL7ZSl65GuXME9cm3qZoIYFl1+w6vEnzLdlCV3wYyAZZ+sJKT7AWxQtyrA3ixj3E3ZAN5Ur5qeqp8cfmSOmCMpkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aI+7aFkzl4XIHsTGCouMslyjEMDzWv7dnC66GD4O8g8=;
 b=It615mC3EN51Wq4TIq+djy8Vyvrc9geIRk8WM0YgX5UorXm3hgQA0x8dHIKzqWvBc3SOjHAIc61+zZN2lsOjW6ocvYGLgZ7bwEngtyXEJy2lsGCBjtKiUYW0nHDAfbvl9SnplbBv3Zz5NSf1n0Tc8XvWcSUWKgroY6AdqdrcFACrksbV50QQv4+cEShRagWbAJYtX8jEzRLcKFiGBdc9afa9XqrjrbBKxbUjvYWpiRRr69pLT2icojxBGjyla+MsCzyRZW9hUdN0LWbj0g5EPvq2uczT0Vhxps0ML9ZOjqH1Hsa5LaJ0h5rwriWfRf7kntJcMYfjIMDdI9Um9yxJZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aI+7aFkzl4XIHsTGCouMslyjEMDzWv7dnC66GD4O8g8=;
 b=Ycnc7KyHLZa16kw48rGeTKUeCfmRpTy+5hBZrjA+Hm+Gl2F2Voj9U3XSqNuGRZlGUUKq8DX3u+7NDAORkIljs4/oDTkZ/qU8rQdeedvGa7eEWbuIdPJIHjPKkNHeRcu9SgVVFNp2reL2yMrkgSb94lFqlwctYgI+a3rpJI+5g6Afarqs52d5wd8zB/H+CbyAFaj8bR/5jemWNfBZ1u/rFF4We2voQrVb1W7kOzjIXPraCQPx9KXGy+6jWy4Zx/CMPhNQqBPEtEACsU98x4DkJwY/5yNRCB37vlafvhKSXy9LCX84bQFyIKIIlsCS/YYABf/G4t0st9aO5//mJkSTQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 16:52:19 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 16:52:19 +0000
Date: Wed, 7 Sep 2022 13:52:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v3 0/9] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Message-ID: <YxjMQpGYaHfsiuL+@nvidia.com>
References: <20220825063939.8360-1-vasant.hegde@amd.com>
 <77d2ea43-9752-b5f3-78ef-8cdae944eee4@amd.com>
 <05f9784b-15b6-2a9b-2d9e-19e1430f74e2@arm.com>
 <YxintMDEmzSXJUl5@8bytes.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxintMDEmzSXJUl5@8bytes.org>
X-ClientProxiedBy: BLAPR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:208:335::28) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f13d037a-1095-4553-b488-08da90f153de
X-MS-TrafficTypeDiagnostic: DS0PR12MB7629:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y75BpqKJXujHpjwx0eCzx1nSYPfyQCLtnna3IUrms3Cl+6+VoLliEWgzo4sdVlKzD86dmtfFub224bov7u4CzuCBYAG8Pf2H+SVTztHz3yBvSKAJgqsY+eKWe01WxrZP3LQS54UX412dzwyDmWmR0H9orRgABjw8jkL65h4I7MXwQDK6+L4lF1Abtti2oc2ZDQFWrhZAu889KHluMrMq90K1sNlf6RE0jVerzMQupXVlq/A6r238ywtKUoxuOjxHsxdASYj4KEf+FcvdoM0dFon1JzuMOQRQNasv8PvulRwH4Q3cyYlLDI3Oab4rdGg5/cuyi3Ox3xEqUYA7AR33UqXTiSKIuIFNlHDBg0asYVRevCVYWzNqBQA2hoqE1fYsQcVxKx9Xs+U3lyzElm1mGdAP09BcmM8x1QcEpR60fKGApahnnS6WbxqNxsaHzibRHWZ0zn2TXREl5AZseEJo3GRtePgqKlBM9G98Sv9bdsmPa92vcNP5p57THHkOoJr85T5Bxow1hZ/V4bUVEUz5Lzxv7URigE8axuMLh+Ip+RQUMwHhn5uNqdxyjHhL6PCSj0+uOrAwTKEHhsFbiOdZMUxeTC41hpTvKvWHzYQPIDLLCBQGyD+dfF/cwwg14bViV3Mc6OiDlhy5nzozXrGEN/DeIxw8gi7HKDwwYzyYpDfuX5UyFMx1kfrLbwu+OxUMn+xnG2KaCiKx+409GUP+k3biAaWTjNkjfYg8Nt7Oi2ho3IbAgy8dWY1V0CaQixXT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(186003)(86362001)(2616005)(38100700002)(8676002)(6916009)(54906003)(66476007)(4326008)(66556008)(36756003)(2906002)(316002)(4744005)(66946007)(5660300002)(26005)(41300700001)(6512007)(8936002)(6486002)(478600001)(6506007)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KgeJvCRmmjrcgEEFftxLn0SUqRKUYEN5H8BvqLgqQU3ruayO2fiPwcUDY3RX?=
 =?us-ascii?Q?MYPoNFrR001+s1ez9WhQ1B88JQBhjjRZizzdeJI3KtZV/ZkOGzlTQaoRp9c4?=
 =?us-ascii?Q?PXEFQZgDoys429cP+Nm/sMc2hz5bbVwAHOFXNoEAiiT6SC7hTcnFCObnbjUo?=
 =?us-ascii?Q?q9x8AT+I2X7eo4ZB2jHSZFLWNpI6sUfxq0XLoZlTGEy5yTCWBWpux0ZqHHtD?=
 =?us-ascii?Q?4WQC8EXetERHMYhv3TFBHIJShY/Ht/pDCyEpg+yoMD+emiLaq7i9fawq/PEG?=
 =?us-ascii?Q?0VO3IrPRITcbtn3xu7+Y7dXZc9UTV91MEaHBafP/zeMizr28owimRis2AgHW?=
 =?us-ascii?Q?N8Z7YRYsgVLVp+gdvlMcujm9Qunx6jOAnkRmaVzSjTrK/iIt4R0j1MUQbOoO?=
 =?us-ascii?Q?+pQHGZ0i1jzimYqnE//tmrvFgEGPrEO23052JGOVkSj/4KCSWINAgmiFM1vB?=
 =?us-ascii?Q?nBYGbJOVOtBass9mfz57PeraYnuOp2jgPMCQwa7Q1FGQ5TX1Nw2VItW5FutO?=
 =?us-ascii?Q?9n6Kam1YoGwOTYzEWsewGXDN7sPqdzT4lLJWluVOwZhRk6sqUw1oHoVmOBDF?=
 =?us-ascii?Q?s36WxaLmWH08ktj5Lp5OXxfe3Kla6fR1O9+Yzgt/Z6vyMNE1KBK0wu5H4Hkt?=
 =?us-ascii?Q?kFoS72rtTbZTxKOSYwQGghBnf9EU45zemxh7sMWXV+6kNKW+bZEo5Ezmw0RP?=
 =?us-ascii?Q?ch8tQLQPuNsagAbJxWkgPpB8SPa+2ZYt65VLnxUcyitDJl/Zuzj53jODMVKJ?=
 =?us-ascii?Q?aaG/x9Db3vtevkabkG4CuCAOJ4bYUMObZVK0l3LCeS+/dp8g/ynUV6w/YtNr?=
 =?us-ascii?Q?vq3FCMyv9mbqSU0QDbznjozHfyjJNW1JeVXO0hCrTBjiV+cyp6Cr+2XQQX0h?=
 =?us-ascii?Q?FHq6VeAuL42ltz6cS3/mrF2D09Gqu1BkWCjKFRAK75CtwJKyu2DQvY/OOHkT?=
 =?us-ascii?Q?2/xFUPTa/ST4PK9gS7mgfjJEDUAIx6LHEJFa6bAvwxjtuDvqi8x2RIJERa41?=
 =?us-ascii?Q?9DdcQiPbHYKym/H4NERPFQwS8XGxEUPcC3EPNBGFFBkvYQdbrHeyIyF3QuL3?=
 =?us-ascii?Q?vlvvxI+HXDl4oyx85JQSGsHo71Xv2gr2qBops78domdBFcsEQMfg4MGs+2N2?=
 =?us-ascii?Q?WpG74L7kvo5haA9aRUEn7FpINLBOTE/hdam3ciDoLYdvuP/KCyFWDDJx/Sth?=
 =?us-ascii?Q?Y73c/MIGu0hBtJPR/yjBgjLYudr+FzKOwHYyJXCHIj+Xrc8Qr35Xp/2tbEyw?=
 =?us-ascii?Q?zqpi694WwVWzsheC+1WmLE3eLzJOU294LjtuSInD3fD7xEsFvQsWfBYDlBZW?=
 =?us-ascii?Q?Rx0yDwW4Lu/hDyzyUyvUDLCkJrwe7QeA58nbMs18fNi/pzSJdw9XFNHrCW+s?=
 =?us-ascii?Q?QFVIafa+RQPn7vvp6VzW9roTDkSo4BIyTC/3Aih16PLjMG/poP33TUCOKkP5?=
 =?us-ascii?Q?Yy9p9X54Q2arFXL9Z6z6TKGQcj1ZbFwsWnyWaf0V5KNnIQvCWBTecI75cE/A?=
 =?us-ascii?Q?aQoKsrXl3tqxVlDPcHG6U4/cX0G7AfvEXkmJ0nn9t3XyjDj498Venp8HyKjp?=
 =?us-ascii?Q?HZPzV+N27EYUAW6wVbPskF3Sp4003shJnFSF1Imr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13d037a-1095-4553-b488-08da90f153de
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 16:52:19.6218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPIDtugLXZi+yZCtDB+LzZzwUGPHihDG8womVWYevsXS1tvZX1NfTUQFZSDL7mUy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629

On Wed, Sep 07, 2022 at 04:16:20PM +0200, Joerg Roedel wrote:
> On Tue, Sep 06, 2022 at 05:35:13PM +0100, Robin Murphy wrote:
> > Will this series also mean that the domain shenanigans in
> > amd_iommu_init_device() can be replaced by just making sure the GPU gets the
> > proper type of v2 default domain in the first place, so KFD can use its
> > PASIDs on top of that directly, and the audio driver problem goes away
> > naturally?
> 
> Yes, on IOMMUs supporting v2 page-tables and declaring a default PASID
> this hack can go away. Unfortunately a lot of AMD IOMMUs in the field do
> not, so the identity mapping hack needs to stay around.

Why can an identity map be attached to the RID in v2, but not a full
translation? It seems like a very strange design that entering PASID
mode completely breaks RID support..

Jason
