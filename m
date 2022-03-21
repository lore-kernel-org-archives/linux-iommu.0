Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7D7C433EF
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 12:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF8E1402BB;
	Mon, 21 Mar 2022 12:03:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oSfK2pTBQJVi; Mon, 21 Mar 2022 12:03:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9DAFF402AD;
	Mon, 21 Mar 2022 12:03:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 748AFC001A;
	Mon, 21 Mar 2022 12:03:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 992BCC000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 12:03:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 811C880BF7
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 12:03:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vvYjleKoCtiY for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 12:03:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::603])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 597F280BCE
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 12:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYxYBOPh+zqD6/b1mz7s4p4+CKJbyH0kOYVAT3kYjxn0fDK+wwxqhD76sdnDvSpsiHo7SVKZuEibeIqDuJBDERjlBU4nXQwFpVa7lz45fy6EAkT3/qcBQQkGmwALxXfqtCiN2WgdfF7Ix/3C8lC9uaSrMiKITR5EnTqUK3n9CEeR4Azc5N0PYJSUGhAfMW3AbwKAEPKh9rCrkV24lD41kVhM5ZsPIYa03Y9/bdpUVxgSdI2ptq9GoP8qZVDqeRgvoQSCComDq11W51ILWS9TVevxDKPYw8zTM5dlIjTY//GuqFQQZML4k/4+Mb/8rH2tTJsHDaRycG16e8g42UaMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yb1TBjNL2NAW8hrQoUX9oQm46UYCgeVWlTYCIHeeDrE=;
 b=RTwFmXUBxp1JZHVIJfHqhfpqFZfTAqH2gRugH4OJ5llYHV+SmrcbXCLY8o0+nKTYzK0Oq3Hl9icRVG5Aw1d/OupUpcJ9yMkbNTT6iiaLEWj4ygYHDmwJ5F8AiD11ZMNgjNLvVHEG7rPY0pV72eH+4cZ9pBgsYTNNW4Zm6H9sXJrIrycWrr/4uzVbrLk0nQANSdNJmMx/UsElM2QzPFavM5Tm9frDYJqcxpYPLNXRhtsp2/1E869dmZONKchx/hmTBm9SiPjEr7HlMFZbG8X+zSH9LacrMddo0qavgt+n+qduAFk8gZT4UEQ7wbquXgDewKdSMtf853gFyxp44HAh/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yb1TBjNL2NAW8hrQoUX9oQm46UYCgeVWlTYCIHeeDrE=;
 b=FGsuuyrJrWtoy048879R1t6z1kTHv+E88wPTcoZW9subu+W1Noydp8UgYxUZsXxRxh7nfwymDi1R7VWlbEJHmLZDWdd6sqiSoRlF4tdu3tsEuOADEIDhJAEn1GAg5dSeR6c8nYoeWjI+y8nxoETaN1/4wKhZw1GSPCboxxIKbFhCVAsMZ0PFZK5jMvz8eskhhJMPh0hOch0xuGiJsFVxrvRgouTfZ6/nrHYOsTj6sXsGbF5CXt2LdfahmTI7VrQ2wMXNRGwxSTYmMtoBCBUJE/kbrlkwvYcUhpLOyBsQRHxPaenuLBV/SOw+jae1WyStFcqzzCU17OTOwIr6IoSxMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 12:03:38 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 12:03:38 +0000
Date: Mon, 21 Mar 2022 09:03:37 -0300
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC 06/11] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Message-ID: <20220321120337.GM11336@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-7-baolu.lu@linux.intel.com>
 <BL1PR11MB52714F57E430FCBE97DDAB478C169@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ec863d22-b79c-2e50-5897-7f1ab5381e44@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <ec863d22-b79c-2e50-5897-7f1ab5381e44@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1733d04-317e-4554-6b4d-08da0b32d55c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4381:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4381E6006A3C94EAC0BA1992C2169@SA0PR12MB4381.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZiMMHyBbihgkiq4v6Lv9eJWq4W02vIAqXfYsygIoohlev1dXkhr/vzXzfspY69qpGg8nEKIfX8ky9rPvTlWxzJBABKnia6SEPySPRtfOlKU6J6Pa5rnf6PGvapaju/t0DPo6/ClwqyTcQMg7ljsCCRa0vfCmbwYMsxozzC4zQ5iwdui3JWkymDfijuR3mDBdyU9fxV7d5YLo/9mj4jMQOI6s/i+yU9Ws+wZEMPEnVj6tQN88firghWTY2UkFKowDTveBCAyD0rSkmlkY99H+2K7yDVD7sGfSaimQ6tUuPMpbYW49lR6Tq3U5V6G8OLUzrvj0J2xJ4lIzTi8mETHti75wIPdNLN/EtpuVy1+rZDqzl/nysmm3aMDNDAheP0s48ltQLcfpTZ737bp/77Q/crWFnYNdvJINKkkqvJdHFtYGx8ofC/4DIDSLQ+iYl10RoST/hrWxxlqOrVpimi66IyfvtmlfGz1Fjtj0k+P6qqfirgXtLM7cv91lDmvhJc+AGWCNf7HCby1Aj7YgWoi7a3CBL7QvRZxSsby40YXipqT8YyU+qNJSOHGpivF56833Md6Z1LZmrBhZWONF0++YYSN0l0Yg3CjNHsp5KMNl3u+ZWfNInHMhWHq6JhXYqqHcJT0/wnKd9e7sNrNO9+TuIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(2616005)(1076003)(6512007)(6506007)(508600001)(33656002)(186003)(36756003)(6486002)(4744005)(54906003)(7416002)(5660300002)(8936002)(4326008)(316002)(38100700002)(86362001)(6916009)(66556008)(2906002)(66476007)(66946007)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZpTbNBCG55XqmHGqbwGmQOoPOGjLdEQEFMBjyWHXO0+PIYNgQeBRi8eaUakT?=
 =?us-ascii?Q?i2N9r6FydjEmIiHBTQPunilvqbyTH79c9YH7sxDRWPVoMtay7DY7gam6Qujs?=
 =?us-ascii?Q?uMkQRnKTMSHsjddkHbXqMHsrJvATtCm3mQQQnzTmKeXhfj0jfLfZiOLuPt/B?=
 =?us-ascii?Q?vdwqE1TBbuEXE4jsGKURGE8Vwa8r/IgFc4kKV1syzFfRB2tLkVVu2sQ6tJQQ?=
 =?us-ascii?Q?C0Sr8lb1yfsfueWhaMmED+7PGU0Qe3n6iuG7qRNX/Wyk5g/UZre+6bpew+vq?=
 =?us-ascii?Q?2YXGdIcdc06d+GkM+ZVgd+g0fRVK3UaNv8zJ2fLMgSr/F3nyxbrkHbK+SnmF?=
 =?us-ascii?Q?gGy/xjQPhzRdMi1v5nJNOOG3uJq/HFFcploFomvrd+VB2rrEsj5m+U2sRAic?=
 =?us-ascii?Q?Dyj2hbNNx5JuMSAtSh9Y1Y0GdLyP+u4rpnUzG/ZZjDChoy4781ZyXcX/gXiu?=
 =?us-ascii?Q?1PbaRX+v93MR26mLRPQbpgL1AmGw6xgPwCNwfK6SKvU43GvFIvhAINH40J2r?=
 =?us-ascii?Q?ugJJi67yxmHiS4F98/wCz7qLSDtv04IdYcjVA0VcaXDTYgPOlH0bYjnMAE7c?=
 =?us-ascii?Q?AbJc3ZNXgUyiKsQ+i1pW21NnDH1NrFudaXAqfYO8A16ofj76DntCfVIM+ToH?=
 =?us-ascii?Q?v+8wyosBir59CSmvjJ+9Tg+DUL/dabqeZX59IFa0wItGRXRYpvBCMQ/wKwbj?=
 =?us-ascii?Q?FwFTjwZz5FdevuwATtJXE/dLM6hFbhLXd/nmwtjy8VkAWIWp4lSNZpkUEjMv?=
 =?us-ascii?Q?IKuB9TA+TT5wMUP8OUQ2Yy1RqJkT5UFw2RhSI+KfiHpYIh3dnxW9wNkGK12A?=
 =?us-ascii?Q?Qwa1RTGCjeEdBJCJ8v73N4vVXc1oQFy/pzSJ5d/DjCjS61A+4iDde+RQlobI?=
 =?us-ascii?Q?0y4Ehw33ambGYtM30mc2VMiAjfSNaNp9l/PrGGTsylV5T30qrRoJgTrSyf4B?=
 =?us-ascii?Q?NnIZv28WyxEa5IULE5WAtNThAnzSo6bCp8v4tfHaJaAqhaIqkwRwnMeq0+SC?=
 =?us-ascii?Q?seBXlV9bnyv7OokvulvXzMFw9xMUH4JOvNloDeazIULwlLiFtboOfEcSfL4E?=
 =?us-ascii?Q?xnITUwhM0M6Pb5/uVc65FWgkOXlLtuTGSwt+8bdjxLN6zZqheGvwAh8uvN0i?=
 =?us-ascii?Q?5WJZUdt9yUueQo/EmdE+lGjFq1izppp0LvnmLVEYejvM/L0J16Hu2pS+PNvZ?=
 =?us-ascii?Q?qNlJ8VFES1lpGG/FY1C+09Ja7qqUnD5zlbZJYXfCPt+puTFwMeyjR/3aqMB8?=
 =?us-ascii?Q?o0+Sa65TZoL1JGfEo91cy2/tfSp1CDnwpqKranh82/sppq/W6KXh+9HYst9F?=
 =?us-ascii?Q?XCHR08m9xEVKNeScNOmKOuHpwuRP9/WwVDMCQxJTvFD3a164vkM5QBGwDxUW?=
 =?us-ascii?Q?9FubQ2ofSZL/d9IQlh9FWDiJMd2SxGGvaZiARM91H4PneNljtsfbvWIk/eym?=
 =?us-ascii?Q?gANoXp50Le6+6ASAdgnTGREUsoGM5Elm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1733d04-317e-4554-6b4d-08da0b32d55c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 12:03:38.3314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xn7UHJASbRTqt6jESMw4OYe2iY+P1pTgpfpWO2tlNDFUhcGK5kBIia0k0s4j6XBT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Mar 21, 2022 at 07:01:45PM +0800, Lu Baolu wrote:

> > one domain can be attached by multiple devices, so this should not be
> > a blind alloc.
> 
> Indeed. Perhaps we could associate the SVA domain with the mm->pasid and
> add a user counter inside the domain.

This has the same problem as VFIO it needs to keep a list of
automatically created iommu domains in the mm_struct and try to re-use
them every time a device is bound.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
