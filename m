Return-Path: <SRS0=GIAn=JY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E788C433B4
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 20:34:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F7B613FB
	for <iommu@archiver.kernel.org>; Tue, 27 Apr 2021 20:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F7B613FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9209A83ABA;
	Tue, 27 Apr 2021 20:34:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J_LjoKO3fFUZ; Tue, 27 Apr 2021 20:34:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 617EA83A91;
	Tue, 27 Apr 2021 20:34:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48760C001C;
	Tue, 27 Apr 2021 20:34:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1942C0001
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 20:21:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A0F2D403E5
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 20:21:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xqmTQ4qjs9pu for <iommu@lists.linux-foundation.org>;
 Tue, 27 Apr 2021 20:21:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700054.outbound.protection.outlook.com [40.107.70.54])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A3EDF400AF
 for <iommu@lists.linux-foundation.org>; Tue, 27 Apr 2021 20:21:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZBJ/MAcBHZhEP8a6pLGpLWA4Hsva+6tNEzoK0v1m7HvxKXRogS0tzlrq9hbeWuiOXT6E05aRFN+Ian1FjUWsBeGDX9+LnqdafU3q9kl6+bVoHGOmNuq5n7K+9YwHkvJKgxQ8xP1VaewKxvQ5+uyhTB9eHmpBCg6v6OYvhk8HcXjUdGLXiNN0j4i/eDLXQzV09XUTw+vOeZwSWa2K3ZU2qtadTXcbiRY01ESgdOuoZYt6K6tEneUou5Ye+hNZg8MEpMnC7dUnI8PqOsJ+SuqG6vUed1PVH79CcTtwFI+IxP2jx4CvsVp+HHH6ZTCPyIP5Q4AOCiTDkFlJmDgiUFMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiaYlcoLb3O9H9MAJq8qvDAm+vShn4NgsspG8l0T0SE=;
 b=WUCAWc7eklT0N+HHN2liR14NwEUisDaRtUzn/rZxL8vc9tfiD9a3SEX/d2MyI53dFqYMJjqTYzKL9zPjmur4Yh5as8pKvx67PfuvBWwFe8G5y/Y8m/IR5qE6Pe7OgFo0UjkZ4fVEwXbgrZEHNYsv9s1NDFy4jOAxWDVK8TCqF/D+UKSVfwdHG6mYjC3i/oFpJDYeBxw+5i7H1LmF6oWHwRapVmnrqg0Mdt6sGmTHeQcz+jgHRfF/CW9rxcfByHuI4QkLORC1zhpsyvdCy9+rVTooDTSNniAvBtFRfLPoNQ2hzAMp7qceG8vjx6nNZI6WVc3szPDlNV7X65aSFGMMEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiaYlcoLb3O9H9MAJq8qvDAm+vShn4NgsspG8l0T0SE=;
 b=f1cLjDgUlJbPee3oc1owW4qJzOYw2drYOVLgBGG7CgWCfOlcbV6dojR9oa6/GZYYq3CSjd2v8qsNwQ1VJMXIj6M2FM3Q+9puzdrAmLhIMKaWc9oNv++w6be/wv2H8/OOL2Dnd6oEHnrUwqsFm3to5GEAYgY/wz6+eIvHCZSsRDUlfzkhsPrkYw5EEog3VOhME2loK1fVBnMyimEQQRW8rIvQaYbpzquVkd1I24R+d2T3uDkUaF6B1MEA68mty5Jsp0KPIdsGvn9ma750ibjFMNBSj3aoBSLJV/7+GE43y9FovhtYSGntCbuThGlSxQChmU1e1U8AxRGB318wOLbPHA==
Received: from MWHPR14CA0037.namprd14.prod.outlook.com (2603:10b6:300:12b::23)
 by MN2PR12MB4814.namprd12.prod.outlook.com (2603:10b6:208:1b6::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Tue, 27 Apr
 2021 20:21:52 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::2e) by MWHPR14CA0037.outlook.office365.com
 (2603:10b6:300:12b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Tue, 27 Apr 2021 20:21:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 20:21:51 +0000
Received: from [10.2.60.58] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 27 Apr
 2021 20:21:51 +0000
Subject: Re: [PATCH 00/16] Add new DMA mapping operation for P2PDMA
To: Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210427192838.GP2047089@ziepe.ca>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <52f14602-94bc-fa98-0b97-5f4084d808a0@nvidia.com>
Date: Tue, 27 Apr 2021 13:21:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210427192838.GP2047089@ziepe.ca>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 594ef245-3cb7-44f5-5081-08d909ba17f2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4814:
X-Microsoft-Antispam-PRVS: <MN2PR12MB481497BFED71E349C1972892A8419@MN2PR12MB4814.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LdEM32LL+68YQ/yivUq8issFecE2lGG4Tk4FXqIzbX2qmLvmDqzOx1LDDEjAB5pAT9RuzvCb95J9bhN2Z6cJQ+PD9Q3J9A0sAE5XMDSyWHo2QuNEgVEusZrLjje9JbJtgBW8rLbVQGUJet77NmgadXx+DKdECITVEtsccbVDWhY8su0dC2+Pa7hjf6Y1vXzxjCQB6kFzskVUClQxamW5ACJ1Y8FqNOxXz2Lq3/Z4K2fBevP5y8ljuqg7jTM8ksax9bf/BdSMQzCdNTooc8bHRZMiovfNWeT1jB04ZgljfJKkIEQeWYR5MD5bsQ9Lh4g17HYrl/14jtvY0TYvJdHoZ7ZkOkqgSqMKvhKjnLNyhalXY+EeE4m2Ry1ywgZYstl81k98gOCOvJDJKyjbidj5k1WwHtG5ZEGpPPg0PHHbEUv2HlQ/RpBUAQz6+XFIoIkqU6RswmYfPJyFDcKfxBugAAvUBiwkaM7nrUcmQ6Jc+2yWC+cmebNs015pf4dxnjKNsb7PvZ2dMoO/0f0M7ruEgNWT97ySnnjCshC1DmBBjvbibRLVD06uP8LLQ1eL8FG61n9bSIWjww4fx7qtly+chduVXkHrJ1RE3UAYz5rkTSuEskDTa+ZoWwQt1THigT9uH0TUmS1rmfy2yzLO9CuSawkIg8vonoDzg8J7qrm1sd2r33ZUVgEkdcPZjXATNiPE
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966006)(36840700001)(2906002)(31686004)(31696002)(4326008)(54906003)(70206006)(426003)(2616005)(53546011)(82310400003)(83380400001)(478600001)(336012)(7416002)(47076005)(36860700001)(82740400003)(356005)(7636003)(5660300002)(8676002)(8936002)(36756003)(70586007)(86362001)(16526019)(26005)(316002)(110136005)(16576012)(186003)(36906005)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 20:21:51.8999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 594ef245-3cb7-44f5-5081-08d909ba17f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4814
X-Mailman-Approved-At: Tue, 27 Apr 2021 20:34:38 +0000
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, linux-block@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>, Jason Ekstrand <jason@jlekstrand.net>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Bjorn Helgaas <helgaas@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Robin Murphy <robin.murphy@arm.com>
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

On 4/27/21 12:28 PM, Jason Gunthorpe wrote:
> On Thu, Apr 08, 2021 at 11:01:07AM -0600, Logan Gunthorpe wrote:
>> Hi,
>>
>> This patchset continues my work to to add P2PDMA support to the common
>> dma map operations. This allows for creating SGLs that have both P2PDMA
>> and regular pages which is a necessary step to allowing P2PDMA pages in
>> userspace.
>>
>> The earlier RFC[1] generated a lot of great feedback and I heard no show
>> stopping objections. Thus, I've incorporated all the feedback and have
>> decided to post this as a proper patch series with hopes of eventually
>> getting it in mainline.
>>
>> I'm happy to do a few more passes if anyone has any further feedback
>> or better ideas.
> 
> For the user of the DMA API the idea seems reasonable enough, the next
> steps to integrate with pin_user_pages() seem fairly straightfoward
> too
> 
> Was there no feedback on this at all?
> 

oops, I meant to review this a lot sooner, because this whole p2pdma thing is
actually very interesting and important...somehow it slipped but I'll take
a look now.

thanks,
-- 
John Hubbard
NVIDIA
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
