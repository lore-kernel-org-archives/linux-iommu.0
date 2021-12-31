Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C9FC433EF
	for <iommu@archiver.kernel.org>; Fri, 31 Dec 2021 00:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1C18440438;
	Fri, 31 Dec 2021 00:37:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dmbqb2jpvInO; Fri, 31 Dec 2021 00:37:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8F40540178;
	Fri, 31 Dec 2021 00:37:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B2DFC001E;
	Fri, 31 Dec 2021 00:37:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EEF6C0012
 for <iommu@lists.linux-foundation.org>; Fri, 31 Dec 2021 00:37:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 30D1D401C2
 for <iommu@lists.linux-foundation.org>; Fri, 31 Dec 2021 00:37:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MkpVtS-5o5Q8 for <iommu@lists.linux-foundation.org>;
 Fri, 31 Dec 2021 00:37:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2043.outbound.protection.outlook.com [40.107.102.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8647F40178
 for <iommu@lists.linux-foundation.org>; Fri, 31 Dec 2021 00:37:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSX/ud+0c1ffKak5U/Oiy74l7C3gJR9Su0lfU7vAXHuqoRDZZmJnd8iD5sO9rnDKpQ0rN8OoIW+D/VY6TbumrUBxfyL2AkFD8lN491MlmoQUJpfPBrkCmKpD/kZp65/TXGgt2GueUqG5tF9cMYvGcQQQnQvXhfvKJuKwo3xaZsMZ945ogDlECecNXN93jW9K9tzFDFKFJZYkYLrjLsbm1Y2syFjGNxow5+/LxGlJSoRpHZpPpGr9Qh8VHs8QDkCflF+QET8UKsZPW/yQYzPXd1pnmdZEvM3TAUfNaeo+6szsgt+T0rCkCX9AerBx2DVP4swv90AlJDaZDkspRqLNmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wozJ/jMKG0UlJUd8SAweilVWWLaeuVluMvmsOH9hMaw=;
 b=B5EYW9v+u43qXT1Pb1grBUm486UgC4sOc7d/aowIKipanY/5zNkRILaC8HjB5aiDnHTkgIVIjPdHq+5orfZhxbW5JHnVzkYP4kHjRq9rpE7NF9VbqB5GJbVngAOc46L43RLX5QLFmvf5MI42e8O45mgSvnkvOff6Plc7Xvbv9ucLORnBxLuok6/izzgs6zPD9dhaR7f5lgofzuoClEj5QT2ui+ORSUlRg2S3hdpjru+MqcJSG/9yFa9q4xU9lSu02aFB6XEMsBmfYCVopokgpOjEXGtRu/GIJYb1DAjaMJzthooN8VDL7zmnGYtxdfARIc4oRBncgv1MEJU/G6s99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wozJ/jMKG0UlJUd8SAweilVWWLaeuVluMvmsOH9hMaw=;
 b=iY80aUWYU6kdAy0JuQkjt+tTfSzORceWK2UUjjkTx0gtxTaroqAZFxxtkMLCqGC8JU+4WwOAujA1l+DDoxRyUgnMgdhpu73183IGXuIQRSCsKKOF59QpyPdMslWWYc4phX7u0g11/OKW8wjsDCWTyBumtviQ6t60d7M+t6Q/nymyMhccwVBypuw+WDJDkHwrwymBqlzNGcQJQcwTGq149E7Yv3pCZHdRZiHsuZTF6A6hrq4lzTROrfaZxKb/ZPFhs5ozHMWBD/gTjh7ryLwK2mUCO6r+yoiMsnpqKWPtubFj5RZA3wn4W53B9EGJIqsf/ceKhOi98R4QNV708t1efQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Fri, 31 Dec
 2021 00:36:58 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4844.014; Fri, 31 Dec 2021
 00:36:57 +0000
Date: Thu, 30 Dec 2021 20:36:56 -0400
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 02/13] driver core: Set DMA ownership during driver
 bind/unbind
Message-ID: <20211231003656.GA2327632@nvidia.com>
References: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
 <20211217063708.1740334-3-baolu.lu@linux.intel.com>
 <YcMeZlN3798noycN@kroah.com>
 <94e37c45-abc1-c682-5adf-1cc4b6887640@linux.intel.com>
 <YcQhka64aqHJ5uE7@kroah.com>
 <2350bea8-1ca0-0945-2084-77a3c7f54f27@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <2350bea8-1ca0-0945-2084-77a3c7f54f27@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0449.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55136452-affe-4756-a167-08d9cbf5a6c9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5223:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52239583D22CFE4F59034B01C2469@BL1PR12MB5223.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LZ4uOFiCeOlTFo9SgfsHE5ppV5SM4Q4lsV9WZvgJsavy749sQBoXoGCZUDsNg9A1oRNRFBrWyPL/L8Os9MPwZNY+hGODV9cvP5driHCfIKGg/jtPW4BlptMgG9Mlt8Ev8+/IBKVcTCwLK6la0nXxTlY/fPLr8h1A3BfhT0qkoH5baUNcO46Db+MA9eNQnFL5NjQoZyQFY2BR3eajS3ksOQljLrZOjQL94+TOLNmlZQX8G3sdKPqffwJmhkcGBEtaDrvVOCVdq/re1tZx/YFBtX0PS7sTs6dwfEVBCpIyyYkE5adcsBUMVSr5vnbZSK29M9uGVcuokgql03nTxFtpDmzCVdOMlZmNd+fLrkHjd9zGroJMQVW9TnTZUEjmZ/c7Y6Snx6FehY0MfCe843C27rHZq8zkFNXkQjvMpvnOem2ct7yf+iMvsgfmtiZAlvfErVq/llWK/PzVW1EJ/Zwnr1gOTgac0Yxr4j4t4d9kepOm6zBUrYy4yXOd8rTr6IFNv5/Pw6WToGf3mxOB86T2cCmbfXQmzwVpbMm74l3oHIr2Lei+gcQHk6S136uytLFrd5C+yygcLcydQCqLfvgTA5ch7zRQrt48vV+h4dNLjGx478Qs93YFHSFsE9DotutM1ZeDqIa6gaqPrdAMg+/aHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(1076003)(83380400001)(7416002)(316002)(66946007)(26005)(66556008)(66476007)(186003)(38100700002)(2906002)(6916009)(8936002)(6506007)(6486002)(4326008)(33656002)(86362001)(36756003)(4744005)(5660300002)(2616005)(54906003)(6512007)(8676002)(508600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DWjWhN90YAVOPdSwqlqA9hHFPMXhNw8TrnWKOSTmDzl6pX4RrCGmL46o3+Yy?=
 =?us-ascii?Q?yoJwdp1EGX0PW1Io84AJzTVA7r3lZu5UAj72ZqCi8MP2LP9dHz5k6HaHZ6ko?=
 =?us-ascii?Q?UaCur7o1/1a3jY6Pmo8sztET2eSQvtTSO/G9zRamEA7tKDECZwYV74AyPrac?=
 =?us-ascii?Q?50Oye7ysSqGvrhoss4Hrr1LHXxkvYrKh5KEb61X9mVyLckgVrRFjQa3+8uEo?=
 =?us-ascii?Q?G5nN6nFkMnzKG8nZmjIvaVuH0wCLNlqsfSiWyHgdKhFZDyTFm1WafB+yr/Af?=
 =?us-ascii?Q?gOWoscDXrU08629TGksRyJiCNd9WnDOG5iOXXoN9KhyPDGBkZlRJi46GnWbB?=
 =?us-ascii?Q?Y/hgRtZoDRNsAYVxF1Xf4qcNXIjUYeVdv5ccg5NHSf+nLk+88dAHKg2aH4uT?=
 =?us-ascii?Q?qsBc63taIBYwrZ6Rc57RDopnEeUUrU9ifbZJ3yaHneGzlshKCQ5toyzx2iVe?=
 =?us-ascii?Q?wA3O9OOfL5hxdyXwyzoKr6huOGrSzy2AkfzAHrREiIRD8fL5NojYNRkgzjp2?=
 =?us-ascii?Q?V+VIdjQ0WeBrjQIqODAVQeeZh5Y4waT24dW3HSUBTNBzqnSCxAsLr4a9+HsW?=
 =?us-ascii?Q?hGtaiXPiaCO5iM26SsHWpIL4OillwMlyTmBDcmfAsXiUHh1B45FOjjO1kJn2?=
 =?us-ascii?Q?aGftMujiLFCY9ZIhzBIyTdJ82toatTLTek2Nr/2sXjKYIIHtBCVQsB2/CmbJ?=
 =?us-ascii?Q?lq7+PMqBkX3dKrhbMFAs9tkh9aWkxxL/CCYDQJqUmB2lWbDVreHs3sxx2PLN?=
 =?us-ascii?Q?a1jvVHgK7nLgkQMcchWgINsvB3TWAXL6t44HjBCi+FA7tgXWDDLVd6E5oQQD?=
 =?us-ascii?Q?IPYmaIZQjOzaNAH1fs933/wmRSA0aAzXB8SAcO40o39wCO2MS+Rc9N5waalV?=
 =?us-ascii?Q?Ch6JDWPr+ySEBsmmFdEg+olRkLYEYA+d/vHrRiwyiBtUtBsU2mc1GcYVpBtt?=
 =?us-ascii?Q?AfWp6pQD0XVdZdFw5aPawgEcBV0+t/f6/u+FSMTYlHJ9jR9kvCC+UoNJ5JFT?=
 =?us-ascii?Q?DCVrFuDWZ4q6H+XHF70a9qPBfd+qWSh8plaZwGXkZSpxC5XyWFyR7DVRQzmB?=
 =?us-ascii?Q?d2YU8myYbAR3Fd5rR66uHBmIPYk99JMH3nPETmnEgT0VVGi91NuXYvO7M/2s?=
 =?us-ascii?Q?Zfen0fuZyvoTlJWU9eraT62YNM3qNy223+Mntz0Gy1nXznv1MkEeLOb5Zn8L?=
 =?us-ascii?Q?rLhNpcVQDwYHwhCSg22f+loQ/6w+e2myaDS7KiMM2XUR5VXN+Ct+oIGVs+n8?=
 =?us-ascii?Q?NsF4d4ZQtUTAo5zdkS47Dtf5v9ifaOko16kDYTE15CCeqMhahCeJUBAGqFFg?=
 =?us-ascii?Q?hm+71g90mot/1LPjlUJ/zbCHYRQm4dEGwTQp3riSofVpeFb6MXn5Bg+UaGn2?=
 =?us-ascii?Q?a+p2Fbwqkf+0pc2687iBD7tCFjmfK6F4nwjHWnyT+tHN6eWWIlq3st19itdA?=
 =?us-ascii?Q?R5I+bHmTVVwLAC4LdKaq372iwC9VKd3aXSJbzqbGLHYQkCjbnRoXcWXKaz7A?=
 =?us-ascii?Q?n+cSYc5AEeuOynegT8Ugn33tgWVpM+1guTvy3GvaZKp9fcTCR8pIF8ommEBG?=
 =?us-ascii?Q?FnxokyyEH4NAZJ2zs7I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55136452-affe-4756-a167-08d9cbf5a6c9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2021 00:36:57.7949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VnHKTv6b/YPUysezANhLZCKj2W41qiaxjuNY+8TTIm80WBrXf5rl/RZrztSEX3L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On Thu, Dec 23, 2021 at 03:23:54PM +0800, Lu Baolu wrote:

> > If this is a bug in the existing kernel, please submit it as a separate
> > patch so that it can be properly backported to all affected kernels.
> > Never bury it in an unrelated change that will never get sent to older
> > kernels.
> 
> Sure! I will. Thank you!

I recall looking at this some time ago, and yes the ordering is not in
the strict pairwise error unwind one would expect, the extra calls
turned out to be harmless. Do check carefully..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
