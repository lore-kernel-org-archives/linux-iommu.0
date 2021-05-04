Return-Path: <SRS0=4008=J7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B249EC433ED
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 00:27:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 446DB61283
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 00:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446DB61283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0448C60BA7;
	Tue,  4 May 2021 00:27:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qqK2uVLFx7wA; Tue,  4 May 2021 00:27:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9D8F60B9E;
	Tue,  4 May 2021 00:27:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2F79C000D;
	Tue,  4 May 2021 00:27:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0675C0001
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 00:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8A10E83ECD
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 00:27:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aKWqWcFYhSUB for <iommu@lists.linux-foundation.org>;
 Tue,  4 May 2021 00:27:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF5C883ECE
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 00:27:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eju4+1uWY4+EECtMXWn1hUVIfmRxieGAYD1Xf9n8/onO3SoPVP2sNowmXs1UZ+4XNSDC3E7cnB50u65mDvUxXmx40RUbXDmN8TkkZhq1E4j3TWusOVxDxX4AlGTDDnTxxBX/3LJkFRIBSQyWupT5RN0ObvjKVPmiCTxzvDSvbcZ6Y0MyVfgg/7dScf2lIpGoSUEKB4QxfrJO2KcrztDGDDP5PkA080ivJwneUJpBAaL+zQ0Cdmpr+3CKWlRW8pNNDAPgFjvy+Cwa3N2xnFtq5FIotB8A3B9UF4yMendt/zMDiWxNX/eEPPYt3+gqU9NRgc/Il/Htdtt3jVbo17bLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGp8LDVwPEkeP1qX3UNu7KB3YNwPZhXxNhF/+jO7gkQ=;
 b=NREzPW0Vpcqpkz5yd/ovfj54t2GqM2X+ot3NMpIlN4FAW3QWW2LlWMAVLwKcc2goDBM17rM/AxvmK9HY0mMyQCN5IpAAZg1KHrSKEy7eS6G/PAXM8EHkmmSTRznb5Xe6uuF4hTm45If4AzSD/nbPOU8vfrytlx3/t1OfY0BOqDkByTJHNVC/myBueS1WwIvPlBbWmNxV3te0vua/ANMvY73xqQaXUB6SdFOff8xA0nIqMhc7Q97AscVOH1N5nl2iq9uM53V4g8zmxMYcYa4g5Ezc/vB4txyuCEb0S9IngQWXzJWNik1c1yfAIPcGPHBzpFcg7i2d6QKnSvoSBleQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGp8LDVwPEkeP1qX3UNu7KB3YNwPZhXxNhF/+jO7gkQ=;
 b=DVYY0JX+rUGwu6dQ9xBDWC5FjlqnR8JcUCjTbzwGtw/qv2fmlc71bWFr56wdugnCUwLx67hEiopmhgY/xjNcYt5WVIGjKNFG4FVqYr5nFfqX6julQ5H0kWjKZdvRGCl+JRGzot0Gjf+s8n0q+e16b+8Vgf5XKNx1uz4q/CJo5k4ZGasYD61sLA14+74XkxU2z4624UpzOuY2u/0gluoVyR7asW+pYw5Cd5Owa8SOQ4siMSchMVV3r8j/t83cVL/Onm4S+h/ChNpEpEwC6RVALxh1drVlM9m8BM2OZhNzpYsYMB4Mjibou7Hhg/F3ENdSciR7dRz8ugoEiqdJjHoyMw==
Received: from DM5PR2001CA0001.namprd20.prod.outlook.com (2603:10b6:4:16::11)
 by CH2PR12MB3767.namprd12.prod.outlook.com (2603:10b6:610:26::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Tue, 4 May
 2021 00:26:58 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::d1) by DM5PR2001CA0001.outlook.office365.com
 (2603:10b6:4:16::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Tue, 4 May 2021 00:26:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Tue, 4 May 2021 00:26:58 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 4 May
 2021 00:26:58 +0000
Subject: Re: [PATCH 13/16] nvme-pci: Convert to using dma_map_sg_p2pdma for
 p2pdma pages
To: Logan Gunthorpe <logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-mm@kvack.org>,
 <iommu@lists.linux-foundation.org>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-14-logang@deltatee.com>
 <78a165e1-657b-c284-d31a-adc8c9ded55d@nvidia.com>
 <4ad9c1d9-ec2a-1fe1-c5d9-19d2053da912@deltatee.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <92116e67-7388-aa31-cff3-71a7da82a731@nvidia.com>
Date: Mon, 3 May 2021 17:26:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <4ad9c1d9-ec2a-1fe1-c5d9-19d2053da912@deltatee.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 167a9abe-a59e-4567-3a56-08d90e93544b
X-MS-TrafficTypeDiagnostic: CH2PR12MB3767:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3767847B085E0E95A01296E8A85A9@CH2PR12MB3767.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DnY0Ti2ApVjbohXgjKZf5i9ILOPc+0mnQIOPLX7OyiYIsgFzlhqQhl1cwdvbDAOOvsXQCut18T+LdVLiSUt5tPi1GnEsHB3L0u0jwD9iggXp2yP7IoEGY1Kk7jbuSl+Jfkv8lO7ANV1THTMKFmD2XftwwK3+KnWcOgu4zAfRL+Be3p1/8a6cOE6tK7Te7rCaKC6a8OXFH7+pOLp7M3OaIiSWcVQcpMdTTw30gr2Td3gzjqNuh2hw4TmcSMEz6XcSHF9r5+IUk14A+HLaPWR1CaOY+xSRiD0UOytqJuVdIccgEqYeOCmbdBvi9SZEc/EBlG6kh0LmuSakQ+S/yS4AG33r1r94wwVWT1S0By3ewryo6kMDJyNKVbMQBdnAI7yyjJwdsie2gyHvJWJf5jeI3yWdPr8c/D/1G9jAGox7/XDSS7a7PlBvbwYYU01D8kaNAYiIkvtd4wtfDnC47VEe0Gn1OXcXwEAZIuictO3fYxyIHGalrH351UKayS9IBZJRWhPEmosjvwHJRuOvK8SzZ1RPqhwJ6gjL9HszYTW4vditsNkJGbc02cVh1l/a3pbmkKaP1hx2Y4qK0bqE0cewOmJREInXpR5SLYZ61Wc2/LIhOcWZChP6vWZTTWNjphZcsV5rTGQfpuSXcJbWoIQ+PJ7ffzcrXQPmVkPQ7aG5fJehVTbuF9+8Gr6fnX8eYUB5CXL3cAxuG9BGwpCyAKtIYA==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(36840700001)(46966006)(53546011)(478600001)(16526019)(82740400003)(54906003)(186003)(36756003)(70586007)(36860700001)(36906005)(2616005)(4744005)(31686004)(356005)(70206006)(316002)(47076005)(82310400003)(336012)(426003)(2906002)(8936002)(31696002)(8676002)(7636003)(5660300002)(16576012)(110136005)(86362001)(4326008)(26005)(7416002)(43740500002)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 00:26:58.5694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 167a9abe-a59e-4567-3a56-08d90e93544b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3767
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jason Ekstrand <jason@jlekstrand.net>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

On 5/3/21 10:19 AM, Logan Gunthorpe wrote:
...
>>> +	nr_mapped = dma_map_sg_p2pdma_attrs(dev->dev, iod->sg, iod->nents,
>>> +				     rq_dma_dir(req), DMA_ATTR_NO_WARN);
>>> +	if (nr_mapped < 0) {
>>> +		if (nr_mapped != -ENOMEM)
>>> +			ret = BLK_STS_TARGET;
>>>    		goto out_free_sg;
>>> +	}
>>
>> But now the "nr_mapped == 0" case is no longer doing an early out_free_sg.
>> Is that OK?
> 
> dma_map_sg_p2pdma_attrs() never returns zero. It will return -ENOMEM in
> the same situation and results in the same goto out_free_sg.
> 

OK...that's true, it doesn't return zero. A comment or WARN or something
might be nice, to show that the zero case hasn't been overlooked. It's
true that the dma_map_sg_p2pdma_attrs() documentation sort of says
that (although not quite out loud).

thanks,
-- 
John Hubbard
NVIDIA
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
