Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF579C433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 13:31:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4DE86401B1;
	Wed,  4 May 2022 13:31:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b62YKcEddF7B; Wed,  4 May 2022 13:31:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 262AD4011B;
	Wed,  4 May 2022 13:31:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBEF2C0039;
	Wed,  4 May 2022 13:31:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9F2CC002D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 13:31:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B2A3D812BE
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 13:31:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Xx_p6a1wVE5 for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 13:31:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::614])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE2D9812BB
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 13:31:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQ12ICcfSM8qx5K7FtiVhVG7lMIHNWToLZFZ9D1YLPTkqqSP/k6DWuEUw+b1oVwW8nfqGIXMZ9Q9qIV0CLDRKU/sqPGc4krRCQ1RP3MKQW6AXUMcQC71FQPtadNUtMRsvibNtr02Eg6sZWM19vKr5ImRMnUDowDjHK0gptVtr9znE8UKtQNo5iBNtLv4eU/nxX6tMANvMgHCyxPqtQZbPcldvA/KB2AUINhqbtX0usX5DIRy/leQXhjS26ByvE8QUJpa9AggGHNlR7t8Y6svYGECnPdrUQpqKhLa8t3sD0vnKfWXgqj35dQl7QFKzkJjg14MTaltCZ9So97BKCr23g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzyfiWkaGqpvr17R/Ea3bVZIU4P2wLlHssZuuUkjlDM=;
 b=b3SIHsysRbVIJClR1YZmE3iyz/g8Lf8cbTGY2yJQlxQ6v8ME7dt194aUgwz3qESRopGlR+vYTv3K/TuzAL995+pgaZydscBBQlPL9hBmXX9K+JTnrhywAPQXvqpVDGyiSw7lNBCgBaGUifF586YOvYPbPL8B2Jw1zrr5LkHhjga9SYJQr0VH3PErCTum7fT96mMqfQU8wJO5KP11DDEpl3FFGEsGvUF85S2SdDOp802OMztjGD/rSKJOQhU2AxjGXMTgcLqCAiVKJ9TSNn8hVHdF9sYOGuihENFF03My8vbe0zwHUbjsH4LpPZe9vochnAYA1QXO4QaiBRhG88KzVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzyfiWkaGqpvr17R/Ea3bVZIU4P2wLlHssZuuUkjlDM=;
 b=jW9ppL+nYtY5fe0KX3sVkFXPcS7HppMb4oe0kLnivfPRbc3UCdU4hebAQx8ZNJPBBlV982suxmwCKKfkok9n7yf0dNSiNYn0Zjy90vA4a4W7wA3fzLY9YibIQ3y9fCchIXahlhtUEDHEWOza5vttcaiNExgNd7mMMKcDnuDWzgrz6ka2YXEiVhSY1oxWkMJPc8WKzLClEQMDLPOsOeEBD8zC8qQvSXWb9+Ingb7ebcAobKorJsgVc7K3CNrZtBZDSHEa9H0s1/LMIVceGmN69SZzuDQQiQe2gxxJdCSIwh4C2ZQTIzyCoYwtXDUerHKMtaN2GePHvS9tUSUbrl12Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 13:31:43 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 13:31:43 +0000
Date: Wed, 4 May 2022 10:31:42 -0300
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/5] iommu/vt-d: Set SNP bit only in second-level page
 table entries
Message-ID: <20220504133142.GE49344@nvidia.com>
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
 <20220501112434.874236-3-baolu.lu@linux.intel.com>
 <20220502130546.GI8364@nvidia.com>
 <74172660-e9e9-6589-7755-50bcd8b0aca6@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <74172660-e9e9-6589-7755-50bcd8b0aca6@linux.intel.com>
X-ClientProxiedBy: MN2PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:208:e8::36) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c1307d9-d386-4a8f-5a86-08da2dd26d9e
X-MS-TrafficTypeDiagnostic: BY5PR12MB4113:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4113C943E6350E8B9F2BC2B5C2C39@BY5PR12MB4113.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQ528q/FvAtcNa434ecWHHzbJ4rx257X1IYbIF8atM/5R22RNnsc6XG8auhQY+Hgc05ugVmkRBoLWr7tuqhVzIjpQXf3+P4nuqSc0PHVyQbS2l1r1aZbsKI7YRMAJGa2eiq4LflslzjLNSwUXaAMIoWAak7Jyrt8zxUcCFIDExgwsbnvsbujzd7XOFwbVa5FYSbyJaBz9hhlOTGDW/rQZeUJjO+dZHl0F2YUB1GB3M3ZY7fywu9t9cdvOCFuHGgPSv5MnMliehkkbVea4Kmsxvzr0UsyfZDeaO/sLK8zOtzTawCCSgCiP9E7GmUtu2ivLPizQ5nPRCN35qNbrdlQeBSn/dCvqPiYaxGy+RTOaNpTpmaOmdZcYNnu71WJ+/HVRF7ZcxkJ/EIGOQtbRL3Y+sj//ThifFO23s8WNODkoX77pKJ6dquQy8ToRNbl6o68XWyxACttcdlMdwIJP+RNwzStcObAe6Zr7ZnQgSCGLCa0h7ApDpJHbXMvCy0WXIQXWtPjFMwf975NR55w4oA7PKd61O3Kw2MX6Ui9yUQDNyfbPiHlnuaxHFmjmah2ElAKov6cMO/dCB4diVnoqxfWlFAu5iF6W/faOrFB5XwhVu0nN89qtxaMFcmpRyEP3S26Scr1BkeMJEy+5o8REyLI8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(8936002)(4744005)(38100700002)(4326008)(8676002)(186003)(33656002)(6512007)(6506007)(1076003)(2616005)(53546011)(508600001)(66556008)(66476007)(6486002)(316002)(66946007)(36756003)(86362001)(2906002)(54906003)(6916009)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eb5BnRjJkiOUBQI3klf33D7NkS4wY6gXbcBphsDW5V46xNi301AFct+litxD?=
 =?us-ascii?Q?wjTSjQXPCA9uK6ht5sn8rRuIwQ2khhiaBB//o5ldMRswN3ekdF8rjdq2DMb8?=
 =?us-ascii?Q?MuDeLYUAs61mfx7OIVG8GhWbO/GysSgB3Cee3GTLgzDG7hi4YvZo0XuR1M5m?=
 =?us-ascii?Q?XD9fw0dKW2eq9/kBYit7RZcDnuxCzzG+FMUD20iJwt7rQhfzCAkQRO7hS2T5?=
 =?us-ascii?Q?h0XzGqYYBKVn0o9+M61vwv/583tixVStodumoPMhVnCait5hNR42VzC/Mfus?=
 =?us-ascii?Q?lbai1VUmH6lJSLk0KyTiPb7viPkPdbfUAhJthFzrXRrT1YRI7FCYr3LNh7Zf?=
 =?us-ascii?Q?uArxGc4N/yuNX/yIMH7hsg8iFoJI0IVqIT3Kq8iDOZyiZdxf1TWTKL9TUh7d?=
 =?us-ascii?Q?+yA8/JQC523zBxF05v2HhwuzokKYRLoAhINh+dq1llCGx9QKYOCrDsTNrCeR?=
 =?us-ascii?Q?J23NYVdOme/acwnKevIk+9E87JsC4xJnwhbZrCJdRTpH880E4XjkkxQv2LH5?=
 =?us-ascii?Q?1ngGe81Zg/B5nD5mStpMXV2P7UjMEtNKok+15+HNZ0G6fVKkEiTtJQ283m2Q?=
 =?us-ascii?Q?AoyxVXJq8EIX+m/d57bRDZ0ouKkng7ufEVV1/aKdCl3rIaCic20oJpRcbN3b?=
 =?us-ascii?Q?SUQ4dlXNFqD3iegRviP3dnW8GZCgE64m9SbNnVfFmaGne9gid2KyPWtWn/22?=
 =?us-ascii?Q?1AIDvnk8DyTKDg4Rkphfbi3V3wBP98D73Fe0y9kXlFFFyUQlclM0/sYvxaxe?=
 =?us-ascii?Q?rT2w243ViwF4YOvO5CwKz4JH2W+0RNgVngZy6KD4DPlgb5pQgqRSAfhX8dFn?=
 =?us-ascii?Q?LrkSen/pIO8OEQ1krYVhcLm4Ahb5ALHYJShnT/yIYuUu9AJj6SKWLatMiyfl?=
 =?us-ascii?Q?VN3Z5JxtampJxhVU6zgLVHHqgAbtZleypafrouDee3CSahdaMx08QpxpL8ag?=
 =?us-ascii?Q?176mFcRWfhudqUfexvd+WMDJyndqzibg0C1jbPeD7ZfcXMShanX6451RLPOq?=
 =?us-ascii?Q?s4DaZwzfZdIuPjI5Kk9ESUJjHydAhIC6wny28ML99oLjoh793Qf/lDWo3EDt?=
 =?us-ascii?Q?5skafRYMwUalB6eGZAm1XFyXMBIXixrlfYaT9njgZAi+C51SmC5bgsBQc92q?=
 =?us-ascii?Q?rbgWjNuzhHAuFCjQqsmDjTTf9UJB0cu0JvoZbX9lqFUS9vAgMpZTxuagykBw?=
 =?us-ascii?Q?MKSsUgFx1E2xqc/R7ozVt/iQIhBwr0/WCa/aVDPFibJ82WXa+Uq0dj/E/o5x?=
 =?us-ascii?Q?570W9D4BY8uASeogQWZVILyd3hJA2hREEpURZ1UD3OOoSFnvAQJaIth6/gzV?=
 =?us-ascii?Q?Ohdtoe50Xa9Sy1z9iMZaPTeEVMuBMENbvNY18u7JgVHSOMvKqjjhT85QOVEz?=
 =?us-ascii?Q?Oj3eUREqZgvZxfddMNG1H3g94XnrUXYCvpjbfPjW3UzYv+GrLWWzSfiMFbUj?=
 =?us-ascii?Q?G//5oKP6tj4MbvL2t3V2N/9uHm3Gx3cBgFpdgcmOQJ+ILXIQ+7fFYE5FRLw/?=
 =?us-ascii?Q?Z5I2Ngv4mk3dwCNLnoB/bnF+zjTe5PP6Nbsd6wgLVNU/9k1VtGcPqxj7e3fA?=
 =?us-ascii?Q?TcwyPPao/SU78tUYxzZjCIAkAs36Xx+1cltXeYLzTZdkrD3mO4woE7/7jT0S?=
 =?us-ascii?Q?csTFykWr4jFBxEcOnPC/MAlsO2XVQZJTHmN72BGJcss/IIV70zm59JoRBvI1?=
 =?us-ascii?Q?OvE+q8zAWqluVHRP5RwRfwb3atBhPxJLuDBSVDGXDIPzofW6iAjiG7eriy2I?=
 =?us-ascii?Q?YVgR7PWtBA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1307d9-d386-4a8f-5a86-08da2dd26d9e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 13:31:43.4023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sAcbz0ymhjxi3k+xzlIQsRkUWw9Sx4R515xb+SQ4DXpeMS9P1keQ/zU8fwd5Po7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

On Wed, May 04, 2022 at 03:25:50PM +0800, Baolu Lu wrote:
> Hi Jason,
> 
> On 2022/5/2 21:05, Jason Gunthorpe wrote:
> > On Sun, May 01, 2022 at 07:24:31PM +0800, Lu Baolu wrote:
> > > The SNP bit is only valid for second-level PTEs. Setting this bit in the
> > > first-level PTEs has no functional impact because the Intel IOMMU always
> > > ignores the same bit in first-level PTEs. Anyway, let's check the page
> > > table type before setting SNP bit in PTEs to make the code more readable.
> > Shouldn't this be tested before setting force_snooping and not during
> > every map?
> 
> The check is in the following patch. This just makes sure that SNP is
> only set in second-level page table entries.

I think you should add a 2nd flag to indicate 'set SNP bit in PTEs'
and take care of computing that flag in the enforce_no_snoop function

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
