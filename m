Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B17C4727C
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 14:52:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EF22145D
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 14:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w/Da72QO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EF22145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6A50286BE2;
	Thu,  1 Oct 2020 14:52:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Z1XR1rPp5Dl; Thu,  1 Oct 2020 14:52:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 17D8D86C23;
	Thu,  1 Oct 2020 14:52:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BA16C0889;
	Thu,  1 Oct 2020 14:52:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54B1DC0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 14:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 507768735B
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 14:52:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ML46Zme4H980 for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 14:52:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 169E38733F
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 14:52:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPYXPjvCqnkwXCndII+9htU3Xz7d4uKQhJ/w7gAtHtl3mRNyy1WgRU/IofdVk/DJQUXsecTY/9ufvvZ8JHJn9qbfbJFSXpQbuRYwddI1uvCYGmfGzFyoKwhhofzINeENTvED2KEr+I8BtlMc/QT1MRhq4RcLg5RU4xDzgvis6XVNQTv7lmmKKXENdR2/I7WFuqV2XEJ7tO73D44meiSrNUzBfC07+ASKTIZrnkb6AEmNw5ETno+jXAa2oidmplZiemidMJFVAJj2r8m21BYed0dNuY7Gkxh/TSp2vZQuBpx1dZGI+iLYSTDTnJcyt4f7KIHFdXrMr70FhCPvTEZhkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRzyxZf7tih2R5gpfEtHiypKsOH6G2LkVGeLYnXm4LU=;
 b=Yh4456KUNZW4uq+TcKuXZ7RxFXkttlDCN4af+RjdkbtX9ku6IkvvD84SBFIvRbJgwByrgPXLVRGnRCgJSYHpJsoJMUAXjbgLtM4EBDPSKaeQaBpb3UT9OwFLbj9sldlY3OhLxaAAuqiDPqHtXEYOscVDHXDmyu4SYjOl3A2FcmkQh4HS94AX5EQ4JTEh5oil04vobe8afCO5uTUaPYlKb+s3cXZqe1WxansxPpmBOV3C9Ddwcrum/T5JoFVipeYs7Sw3+DiKCNjZaeQvevRev2kKfE34bLIVrbOheJ39M9svXBWsv1FUG6Rz2P7uBgdoF0e57zyZc4mJtnRBBv9gkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRzyxZf7tih2R5gpfEtHiypKsOH6G2LkVGeLYnXm4LU=;
 b=w/Da72QOTB3rpMdMFmyPTLgakZ4H4M3l0A2N3SoWbwE3+9+za2iFp8MiR1BG5J0EAnWx8PvP79fAXmUq2M1+MfLaEAC9TynRbpBUU3t7F/Lfe2fEWl6jAPuzqTzdTTj9O0O7kMIec03aY+wjFhsO/qUxigt3xeNh/hcytY0wDz4=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.35; Thu, 1 Oct 2020 14:52:00 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 14:52:00 +0000
Subject: Re: [PATCH 00/13] iommu: amd: Add Generic IO Page Table Framework
 Support
To: Joerg Roedel <joro@8bytes.org>
References: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
 <20200924103448.GO27174@8bytes.org>
 <c4b95103-8c66-6a9b-af18-a7c40d9dd943@amd.com>
 <20201001125949.GG30426@8bytes.org>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <74b23968-2dfc-524e-dc2b-74b5819ad161@amd.com>
Date: Thu, 1 Oct 2020 21:51:51 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <20201001125949.GG30426@8bytes.org>
Content-Language: en-US
X-Originating-IP: [124.121.138.118]
X-ClientProxiedBy: SG2PR0401CA0011.apcprd04.prod.outlook.com
 (2603:1096:3:1::21) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (124.121.138.118) by
 SG2PR0401CA0011.apcprd04.prod.outlook.com (2603:1096:3:1::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.36 via Frontend Transport; Thu, 1 Oct 2020 14:51:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a2ccaf5-f429-40ab-c0f8-08d866198d0a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4297:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42972BDDF331B9264900797AF3300@DM6PR12MB4297.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wz0GRnqtso9IeCAJdxwCLrDura3In6NZMYa5598yp1EChUbxXIz1qhYswESX3o//M0IyaNTf/f0QriaJ5nUkzWrj7Zi6dRwUJdZ3+J3vD8aHQEVLJ4H0wIpq5OSiwGf+IZYCPp4cbXQzUhcLKz1pLGLWWBoulJfFhAozbXDuNbg1gwUQyYLH5P3d7KRhcgSpasVl8MRyQL8+TwVUnVUYHBn/4HmWYmwdICLGuciOtIT5fnZwryIFUhBJFLSmXON/bz69ojKjntmf6DZDqqMaUAgdvvFzhYT2SnovtDZqSbmzv9Q5wQX4gRwy7snuZUu4Rb3V+VSX4kouo9bIJXbRhGYvINbPIFCSRLkbENQXW1f7RkAwpXpz4t7i04Dz/iKCJpMXTJ/gZ8OP0vnl37M9Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(53546011)(6486002)(6666004)(956004)(2616005)(5660300002)(8676002)(31686004)(4326008)(478600001)(8936002)(66946007)(66476007)(36756003)(66556008)(44832011)(316002)(31696002)(6916009)(186003)(4744005)(6512007)(2906002)(52116002)(16526019)(86362001)(6506007)(26005)(41533002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: XoNoLz6t0kuK9V4JRlFywAHGFgARsbDXCFq+HprDChaz+RKEK2IX+jPwg+4jhR5JO2PvkM0e6RQ/nnV0l3wn5ZmUpzK779bujqnAooodAexAcWwkaebE+ZyRpIAS66qrLBjK7qCKx6Y/Fm0EmIdcOpjR7rvVPYmDJLefQFRouzuyGsu4XexlJXfgsQEgW52euaVQXZHyXHkNOliRdGoXLUBXFHviz26D1JF4dIP6uWd1z2CmYg+kUgTHMpYFJo6pttDJWc64f5aTZAHVusZeFhGIdmogQkCs2Lrfr+jRDi99SEMBDJN5kQKJaPE09NwEQPN7uF7YnwIYSIKTgYmc2FfgrCqZpkOge8Pg87IHNhk9whXSqr+aOEs83sWbtw+FYG+dnlWxsOvmgO2ESPlj+kvKCNJHCzNZgSRWC36g7YfxpTyN86tce4xDWYOqiGyY7EHi8aQZ2UPiSQvgw3qyRekCqVM4WY/vEI1Xgc8EBpWU49dCLCbr0a3K4Dr0jAikuZKHt+CiJbb5pPkK+BR+PS1YanuUvsQyBxD2lzIciwqwl5BWRemRhaKh6BKJtVNOj129v+OQxdCsXTuEZlaDpDKnvytGs96MygnEays3GGvvFN/N/rNXzbuaEXWa4UHpO6AxQaIinsQtlA0V1+cALg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2ccaf5-f429-40ab-c0f8-08d866198d0a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 14:52:00.3271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFZpDINvf5I46VBy8mswD8UCNa9esR6HvakKGFpKY2b/shQZVJTQjE7tf3Rqlf87o+plGewTRW1r33MXd5b0RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Joerg,

On 10/1/20 7:59 PM, Joerg Roedel wrote:
> On Thu, Sep 24, 2020 at 05:50:37PM +0700, Suravee Suthikulpanit wrote:
>>
>>
>> On 9/24/20 5:34 PM, Joerg Roedel wrote:
>>> Hi Suravee,
>>>
>>> On Wed, Sep 23, 2020 at 10:14:29AM +0000, Suravee Suthikulpanit wrote:
>>>> The framework allows callable implementation of IO page table.
>>>> This allows AMD IOMMU driver to switch between different types
>>>> of AMD IOMMU page tables (e.g. v1 vs. v2).
>>>
>>> Is there a reason you created your own framework, there is already an
>>> io-pgtable framework for ARM, maybe that can be reused?
>>>
>>
>> Actually, this is the same framework used by ARM codes.
>> Sorry if the description is not clear.
> 
> Ah, right, thanks. I think this should spend some time in linux-next
> before going upstream. Can you please remind me after the next merge
> window to pick it up?
> 
> Thanks,
> 
> 	Joerg
> 

Sure. Let me send out v2 for this with some more clean up.

Thanks,
Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
