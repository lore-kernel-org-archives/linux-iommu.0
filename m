Return-Path: <SRS0=9mGv=N7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D889C4332F
	for <iommu@archiver.kernel.org>; Thu,  9 Sep 2021 13:11:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84A3611C6
	for <iommu@archiver.kernel.org>; Thu,  9 Sep 2021 13:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E84A3611C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5F3C40352;
	Thu,  9 Sep 2021 13:11:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J57nOBqePNn4; Thu,  9 Sep 2021 13:11:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AE5494034D;
	Thu,  9 Sep 2021 13:11:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87258C0011;
	Thu,  9 Sep 2021 13:11:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2112C000D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Sep 2021 13:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F18740176
 for <iommu@lists.linux-foundation.org>; Thu,  9 Sep 2021 13:11:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PgJ1E5XRo1mQ for <iommu@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 13:11:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B478E40116
 for <iommu@lists.linux-foundation.org>; Thu,  9 Sep 2021 13:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETocO9MD7awuKcvREmcFgtfAPRiX1/q762wVztU0A21EBXNxUPb2TxJXyFW116FDrIrH7n/ZudjTskpRTQMX1ukJYeCsQqc+OWJli/VyPFZeaYnZkjGDyPyUiykMct6+IPERqgI6a7D3Xvu9S8nkXFkvMA2FjjA9UaI7vP1nveIfOe1UlbpIqOAJSVCuitTG513Bhxp2UdzjNJ/fOzbrGt/HWmTLzgDMgKAO6Cwe27AirY9aiT5Yok4Q2Krm+CtS+z9kUB73uDVc1XTbaU3q2FqAVbk86dxhzSRBxNoao+jh5te6f4QWYb61fIwNChPo8aOmSp2h/jyBqxPCUp55GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=y84+NfD7FLJMoALtVzut1WPveI2uTlUXwRmcSqYr1jY=;
 b=ih2p6V4PI0nE/+7slez17tQkGw2epz7BqBALPXRKl2B1iJY4Sb+LgccBYbSCSxEDA1QKr5b0ZT5wtOZR2SL4KAdeCdxmsI7rI8tthHgNa8CpeObzRawBQ1O2/1TwB335DGG6X3yZZCJ4ewdSObHLJFeE4C0X91Uc2Y9Udq5s4gDL4bKNICCfYe+mxjCsWoRmnMiqAX//UWSXB6VGVdfGMtJpqXFsxxa+d2By7sc++1ndlpGMHOLhMQJvkl5hgkfTjkeUIe8/jjONc3FWYZWaWxmfaRSfp8/ZkozY0lndaGDSwAjMC2GVe/jWpurOMcwcW8dMRUzc52DYBovk557vbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y84+NfD7FLJMoALtVzut1WPveI2uTlUXwRmcSqYr1jY=;
 b=ig1LdEzHC+YWtCw2sgYLqwP1tGSSMS2vXfYqw8gUmIlXGQ0YYf4mpDK0EBTR7MW21ljxrNjXWqyOo705a0DSzoD86C7qtEQQBdeRQBobyLx8xAzHNTvSXzygS/nZwGItZDZ7WltBU5AAV1vexrwIpB0ctNh+twhQiMM0FjBGIug=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM8PR12MB5479.namprd12.prod.outlook.com (2603:10b6:8:38::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 9 Sep
 2021 13:10:57 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4500.017; Thu, 9 Sep 2021
 13:10:57 +0000
Subject: Re: [PATCH v3 8/8] treewide: Replace the use of mem_encrypt_active()
 with cc_platform_has()
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org,
 kvm@vger.kernel.org, linux-efi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <46a18427dc4e9dda985b10e472965e3e4c769f1d.1631141919.git.thomas.lendacky@amd.com>
 <a9d9a6a7-b3b3-570c-ef3d-2f5f0b61eb0b@csgroup.eu>
Message-ID: <76ace164-92d8-c970-f9e5-d259c3573314@amd.com>
Date: Thu, 9 Sep 2021 08:10:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <a9d9a6a7-b3b3-570c-ef3d-2f5f0b61eb0b@csgroup.eu>
Content-Language: en-US
X-ClientProxiedBy: SA9PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:806:27::10) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
Received: from [10.236.30.241] (165.204.77.1) by
 SA9PR13CA0125.namprd13.prod.outlook.com (2603:10b6:806:27::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.8 via Frontend Transport; Thu, 9 Sep 2021 13:10:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee4ebcc4-c34d-4506-688a-08d9739342f6
X-MS-TrafficTypeDiagnostic: DM8PR12MB5479:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5479A0D2B0392DD6E5F5AE49ECD59@DM8PR12MB5479.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K47tNBsaYzzuzlxXL3/vD/zxcrr1/yJ4Gvskt7vedtiQCf87xHqzY4QOah94oDRuAquR6XAP3kdNvZ0Y37vC9x8ta4MScHcRqpulefomH5L1J0tS5Uufnm634CoVOm7y9yTHDloCmNePqISnmnU1QkpjnY3SwklRIRe7RK6E0lmV+5pCQ1kY8wDfdiF2wYT5qGvUImVaBCO8bH3B+veIjq3a8xnO7jLywvu7dz25mFAzWExFjzehck3dYoR6wclHB1+2wQljopz4K79i/ccfAyNZYWdoKV6bdGstsdYQ+ReosB9j85TwkvTi+OY4cyba2tweEQNzbU7VZvWWiG0vK6PiN1hLDlq9QOl9CZPGZqL1Ut9Vq+P7oOajm7VjoZ8PurcoLmHL1bi1f1Sg9bJWiCay1IYGASWQ2djvD0cZ8uNp4U99zJoUolPef3Je60SSjXEYJwROzX2yS2qIi0VRoUN1kwdG0wjqMDCN+1o8vlHpXyF80eOpDClnWexMt52lqv6oXJZmhGJyVTqYuIrwkf/xXtHmSpPNqNZgcUpp9/khby16Jfbz7Vbu2xjzR+UGMxdS4inCGtzzIxoAveutdTbk6uQ4+hmuOsVXlH4v2/6BQQ10lr3vZUmK8rPDJgYJqiLkF3cuyvqYDmqkejlRUdY2KZCpX3EYOhWgV8y+jQTSPCWICFIoasSpV8HOAAKr8USJbnFOLETy40qfJm2g+cfCS/T5tBJ+5wmoNKdPFcasuKSP/mFu6KCo/im6sxQIvMcAmg57BR9suMwoa9k9gaV1ivpJcyk6UNMAmvs42nNBI5xPSAViRTl33OPlINJwzy6pwEeaji3cxtMGy7Kddj1Z2I50UWZ4453Y2Gg32/LFRAypwWpK5fFXf0hdmUa3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5229.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(31696002)(31686004)(86362001)(66476007)(66556008)(66946007)(8936002)(921005)(38100700002)(83380400001)(316002)(53546011)(36756003)(2906002)(16576012)(956004)(2616005)(26005)(186003)(5660300002)(8676002)(966005)(4326008)(7416002)(7406005)(478600001)(6486002)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkIvQk1IaWJxbGhFeXZZai9xNGdiQTladU1pYW9WNTREcktUY0dEc0pxeWQw?=
 =?utf-8?B?NVVEYXI4bk9KcXluY2ovNWF3ckNDQXphT1BwL3lFWDdueWgxREtEdy9nSkJO?=
 =?utf-8?B?ZEtHd0FPeGxyQmxGVXQ5UEZTTlFMVlkxY0lNbUpYaURVSllxUGtEZCtIbkdx?=
 =?utf-8?B?NTlpUE4yZzg0ei9yR0hmdnl3aUx5ajEzMnFKTTBGWStOZGEwcXQ1WGw3T3NO?=
 =?utf-8?B?MnBKby9RYjVReVJ5Ly9TOVJHV1g5ZU02VUVTcXg0ZXZHNFlxTWtYejlXWk9Q?=
 =?utf-8?B?OGRxVFk2NU5EZHpacWhydzJZSjRMMTU3eXV4cllSNmlVcFNrMjJiZzRyeWV1?=
 =?utf-8?B?UGVOdnVxMVVrdDVySzIrOVhIYU5hSHAvQjJiYTFwWDh1T1Y4T3lzSUlzWDF5?=
 =?utf-8?B?WU1RZTdHWXdFc0hZcnlLcGdqcEJoM0xhUFNEY3pSRUxWUSs2Q3VxSDRuZHJW?=
 =?utf-8?B?L0lhRlJmTEIwSGxKZXNJc2oyMmZyRDFGK25wbWtmMWtkbWIrbkVSdldsYmpP?=
 =?utf-8?B?T2haOHJpa1NwVXFJZEpadWVlVVFNUW9mcHVJMURNYUNNRTlBMEV1aGJraDZV?=
 =?utf-8?B?THBRdm5DRGhlMHJrTTNyTnlzVXZ4cUE2Ly96ZHRYZkdkVEZtVS9PdWtXRFdr?=
 =?utf-8?B?ZFBuVzd2RmREK0ZPYXQxVmZJbkVkaXZSM1RPMDJRQzAxNVlRdGhBQ2ZYL2Vl?=
 =?utf-8?B?MkJ0ZnpRejAyQ0lWdG9wdGprRm9uMk1KMWlDTFo4VEdMYUQ4eGZzYXUwK1VV?=
 =?utf-8?B?bWFIdDJLV1JpUUVYRXVCbitvUVQwb0tKQVBMdHZ6cUtVK25TRVlZM21kNW1z?=
 =?utf-8?B?TFBiWVZuUTlEbW1hTkZJM2hZNXduMWN1WW9ZTDNDWjJnRU1ESUJ5UXYwVktO?=
 =?utf-8?B?MGtXTHBVbVVLK242dWs3VlVkYkg4clo4UTV0UWZWTG02STE1RTdYTXZlQkZK?=
 =?utf-8?B?aU5BeXlaMnRrb2VEeitLeFNtS0daSXRTS29FV25hNG9OU1gzbStqSG9hVHlw?=
 =?utf-8?B?clBidWEvMHg0c3MyWk9wZ203TEtRYWd6R0c4Smh3T3pWQ1d4VWl0TnVId1BB?=
 =?utf-8?B?ZXQ4eXZac25LRGk0SVhGdFNOSWRmeVlvR3VSNG0vaytLbEpaRlJaNnoxNDJV?=
 =?utf-8?B?T1MzS2NlYzg5ajl5V3Qrd1VZWmc4MjRUdlU1ZG1ZazZLbW5OZExhNkNPUlhj?=
 =?utf-8?B?aE8ySGt3U0xyQ0lFeHVlaCs2ZkthYzE2eWdoa3A2Mkw5TXhFNFlVQkVoUmZE?=
 =?utf-8?B?ZUM3UFRyRURKeHdaYzRCWEtrazh2aTY1U29NTU5VWTRpTG5LL2ZJSDNBbUZC?=
 =?utf-8?B?YURMK0hWNWUvcWtnZFhGSEhETkxDT05tbG5FZUFBeTU2eEpKaFVRRGxHL1JF?=
 =?utf-8?B?TzJKWGZnMm90dE1RMWZ1OWN4bkEySXhHNUp4c05uWGZCODVsZWd2VWY5SjNz?=
 =?utf-8?B?UlZ3NVhJc2Y0d1ZiMGxjdXFFOFhJdHlsZGNubnVSL1Nta2xIMmhtQVJGUms5?=
 =?utf-8?B?bzhiUDNwUG55Sk9CYmhEYU53Z1pEZi9kSTFnWDlyNXp2VTBSL2hEQjBuR2l6?=
 =?utf-8?B?anRML1IyOTZaQU5VLzhjTlhDRXFxUFROcXYrSE9zSy9yS3FyR3Y5eDdINmFO?=
 =?utf-8?B?bHVESDlpZjVjTGdDR3lvVFBPa0xFMWRCS3pLay8vMzN3akFNamc4YzZWaFd0?=
 =?utf-8?B?aHdNRmNBNTVzOERpSGVBa0Y0ZUx5RnYvd2pBV3hzV1JRNUpRZitQcXNJdHJB?=
 =?utf-8?Q?8rWV+nyfWW75Hy/CbuTr7nsrSFfY7gpo462nm72?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4ebcc4-c34d-4506-688a-08d9739342f6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 13:10:57.2787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxAPyqV7mZbEtpfsm2iUdAAFImWIav2+gAszeKAjPJ9M2SQqmTftN3mymGAKltwLQ3UXedkqi2rRhaJ95bU76w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5479
Cc: Brijesh Singh <brijesh.singh@amd.com>, David Airlie <airlied@linux.ie>,
 Dave Hansen <dave.hansen@linux.intel.com>, Paul Mackerras <paulus@samba.org>,
 Will Deacon <will@kernel.org>, Andi Kleen <ak@linux.intel.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Christoph Hellwig <hch@infradead.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Young <dyoung@redhat.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, Daniel Vetter <daniel@ffwll.ch>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Thomas Zimmermann <tzimmermann@suse.de>
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
From: Tom Lendacky via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Lendacky <thomas.lendacky@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gOS85LzIxIDI6MjUgQU0sIENocmlzdG9waGUgTGVyb3kgd3JvdGU6Cj4gCj4gCj4gT24gOS84
LzIxIDEwOjU4IFBNLCBUb20gTGVuZGFja3kgd3JvdGU6Cj4+Cj4+IGRpZmYgLS1naXQgYS9hcmNo
L3Bvd2VycGMvaW5jbHVkZS9hc20vbWVtX2VuY3J5cHQuaCAKPj4gYi9hcmNoL3Bvd2VycGMvaW5j
bHVkZS9hc20vbWVtX2VuY3J5cHQuaAo+PiBpbmRleCBiYTlkYWIwN2MxYmUuLjJmMjZiOGZjOGQy
OSAxMDA2NDQKPj4gLS0tIGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL21lbV9lbmNyeXB0LmgK
Pj4gKysrIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL21lbV9lbmNyeXB0LmgKPj4gQEAgLTEw
LDExICsxMCw2IEBACj4+IMKgICNpbmNsdWRlIDxhc20vc3ZtLmg+Cj4+IC1zdGF0aWMgaW5saW5l
IGJvb2wgbWVtX2VuY3J5cHRfYWN0aXZlKHZvaWQpCj4+IC17Cj4+IC3CoMKgwqAgcmV0dXJuIGlz
X3NlY3VyZV9ndWVzdCgpOwo+PiAtfQo+PiAtCj4+IMKgIHN0YXRpYyBpbmxpbmUgYm9vbCBmb3Jj
ZV9kbWFfdW5lbmNyeXB0ZWQoc3RydWN0IGRldmljZSAqZGV2KQo+PiDCoCB7Cj4+IMKgwqDCoMKg
wqAgcmV0dXJuIGlzX3NlY3VyZV9ndWVzdCgpOwo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBj
L3BsYXRmb3Jtcy9wc2VyaWVzL3N2bS5jIAo+PiBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNl
cmllcy9zdm0uYwo+PiBpbmRleCA4N2YwMDFiNGM0ZTQuLmMwODNlY2JiYWU0ZCAxMDA2NDQKPj4g
LS0tIGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2VyaWVzL3N2bS5jCj4+ICsrKyBiL2FyY2gv
cG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9zdm0uYwo+PiBAQCAtOCw2ICs4LDcgQEAKPj4gwqAg
I2luY2x1ZGUgPGxpbnV4L21tLmg+Cj4+IMKgICNpbmNsdWRlIDxsaW51eC9tZW1ibG9jay5oPgo+
PiArI2luY2x1ZGUgPGxpbnV4L2NjX3BsYXRmb3JtLmg+Cj4+IMKgICNpbmNsdWRlIDxhc20vbWFj
aGRlcC5oPgo+PiDCoCAjaW5jbHVkZSA8YXNtL3N2bS5oPgo+PiDCoCAjaW5jbHVkZSA8YXNtL3N3
aW90bGIuaD4KPj4gQEAgLTYzLDcgKzY0LDcgQEAgdm9pZCBfX2luaXQgc3ZtX3N3aW90bGJfaW5p
dCh2b2lkKQo+PiDCoCBpbnQgc2V0X21lbW9yeV9lbmNyeXB0ZWQodW5zaWduZWQgbG9uZyBhZGRy
LCBpbnQgbnVtcGFnZXMpCj4+IMKgIHsKPj4gLcKgwqDCoCBpZiAoIW1lbV9lbmNyeXB0X2FjdGl2
ZSgpKQo+PiArwqDCoMKgIGlmICghY2NfcGxhdGZvcm1faGFzKENDX0FUVFJfTUVNX0VOQ1JZUFQp
KQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+IMKgwqDCoMKgwqAgaWYgKCFQQUdF
X0FMSUdORUQoYWRkcikpCj4+IEBAIC03Niw3ICs3Nyw3IEBAIGludCBzZXRfbWVtb3J5X2VuY3J5
cHRlZCh1bnNpZ25lZCBsb25nIGFkZHIsIGludCAKPj4gbnVtcGFnZXMpCj4+IMKgIGludCBzZXRf
bWVtb3J5X2RlY3J5cHRlZCh1bnNpZ25lZCBsb25nIGFkZHIsIGludCBudW1wYWdlcykKPj4gwqAg
ewo+PiAtwqDCoMKgIGlmICghbWVtX2VuY3J5cHRfYWN0aXZlKCkpCj4+ICvCoMKgwqAgaWYgKCFj
Y19wbGF0Zm9ybV9oYXMoQ0NfQVRUUl9NRU1fRU5DUllQVCkpCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gMDsKPj4gwqDCoMKgwqDCoCBpZiAoIVBBR0VfQUxJR05FRChhZGRyKSkKPiAKPiBU
aGlzIGNoYW5nZSB1bm5lY2Vzc2FyaWx5IGNvbXBsZXhpZmllcyB0aGUgdHdvIGZ1bmN0aW9ucy4g
VGhpcyBpcyBkdWUgdG8gCj4gY2NfcGxhdGZvcm1faGFzKCkgYmVpbmcgb3V0LWxpbmUuIEl0IHNo
b3VsZCByZWFsbHkgcmVtYWluIGlubGluZS4KClBsZWFzZSBzZWUgcHJldmlvdXMgZGlzY3Vzc2lv
bihzKSBvbiB0aGlzIHNlcmllcyBmb3Igd2h5IHRoZSBmdW5jdGlvbiBpcwppbXBsZW1lbnRlZCBv
dXQgb2YgbGluZSBhbmQgZm9yIHRoZSBuYW1pbmc6CgpWMTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGttbC9jb3Zlci4xNjI3NDI0NzczLmdpdC50aG9tYXMubGVuZGFja3lAYW1kLmNvbS8KClYy
OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL2NvdmVyLjE2Mjg4NzM5NzAuZ2l0LnRob21h
cy5sZW5kYWNreUBhbWQuY29tLwoKVGhhbmtzLApUb20KCj4gCj4gQmVmb3JlIHRoZSBjaGFuZ2Ug
d2UgZ290Ogo+IAo+IDAwMDAwMDAwMDAwMDAwMDAgPC5zZXRfbWVtb3J5X2VuY3J5cHRlZD46Cj4g
IMKgwqAgMDrCoMKgwqAgN2QgMjAgMDAgYTbCoMKgwqDCoCBtZm1zcsKgwqAgcjkKPiAgwqDCoCA0
OsKgwqDCoCA3NSAyOSAwMCA0MMKgwqDCoMKgIGFuZGlzLsKgIHI5LHI5LDY0Cj4gIMKgwqAgODrC
oMKgwqAgNDEgODIgMDAgNDjCoMKgwqDCoCBiZXHCoMKgwqDCoCA1MCA8LnNldF9tZW1vcnlfZW5j
cnlwdGVkKzB4NTA+Cj4gIMKgwqAgYzrCoMKgwqAgNzggNjkgMDQgMjDCoMKgwqDCoCBjbHJsZGnC
oCByOSxyMyw0OAo+ICDCoCAxMDrCoMKgwqAgMmMgMjkgMDAgMDDCoMKgwqDCoCBjbXBkacKgwqAg
cjksMAo+ICDCoCAxNDrCoMKgwqAgNDAgODIgMDAgNGPCoMKgwqDCoCBibmXCoMKgwqDCoCA2MCA8
LnNldF9tZW1vcnlfZW5jcnlwdGVkKzB4NjA+Cj4gIMKgIDE4OsKgwqDCoCA3YyAwOCAwMiBhNsKg
wqDCoMKgIG1mbHLCoMKgwqAgcjAKPiAgwqAgMWM6wqDCoMKgIDdjIDg1IDIzIDc4wqDCoMKgwqAg
bXLCoMKgwqDCoMKgIHI1LHI0Cj4gIMKgIDIwOsKgwqDCoCA3OCA2NCA4NSAwMsKgwqDCoMKgIHJs
ZGljbMKgIHI0LHIzLDQ4LDIwCj4gIMKgIDI0OsKgwqDCoCA2MSAyMyBmMSAzNMKgwqDCoMKgIG9y
acKgwqDCoMKgIHIzLHI5LDYxNzQ4Cj4gIMKgIDI4OsKgwqDCoCBmOCAwMSAwMCAxMMKgwqDCoMKg
IHN0ZMKgwqDCoMKgIHIwLDE2KHIxKQo+ICDCoCAyYzrCoMKgwqAgZjggMjEgZmYgOTHCoMKgwqDC
oCBzdGR1wqDCoMKgIHIxLC0xMTIocjEpCj4gIMKgIDMwOsKgwqDCoCA0OCAwMCAwMCAwMcKgwqDC
oMKgIGJswqDCoMKgwqDCoCAzMCA8LnNldF9tZW1vcnlfZW5jcnlwdGVkKzB4MzA+Cj4gIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgMzA6IFJfUFBDNjRfUkVMMjTCoMKgwqAgLnVjYWxsX25vcmV0cwo+
ICDCoCAzNDrCoMKgwqAgNjAgMDAgMDAgMDDCoMKgwqDCoCBub3AKPiAgwqAgMzg6wqDCoMKgIDM4
IDYwIDAwIDAwwqDCoMKgwqAgbGnCoMKgwqDCoMKgIHIzLDAKPiAgwqAgM2M6wqDCoMKgIDM4IDIx
IDAwIDcwwqDCoMKgwqAgYWRkacKgwqDCoCByMSxyMSwxMTIKPiAgwqAgNDA6wqDCoMKgIGU4IDAx
IDAwIDEwwqDCoMKgwqAgbGTCoMKgwqDCoMKgIHIwLDE2KHIxKQo+ICDCoCA0NDrCoMKgwqAgN2Mg
MDggMDMgYTbCoMKgwqDCoCBtdGxywqDCoMKgIHIwCj4gIMKgIDQ4OsKgwqDCoCA0ZSA4MCAwMCAy
MMKgwqDCoMKgIGJscgo+ICDCoCA1MDrCoMKgwqAgMzggNjAgMDAgMDDCoMKgwqDCoCBsacKgwqDC
oMKgwqAgcjMsMAo+ICDCoCA1NDrCoMKgwqAgNGUgODAgMDAgMjDCoMKgwqDCoCBibHIKPiAgwqAg
NjA6wqDCoMKgIDM4IDYwIGZmIGVhwqDCoMKgwqAgbGnCoMKgwqDCoMKgIHIzLC0yMgo+ICDCoCA2
NDrCoMKgwqAgNGUgODAgMDAgMjDCoMKgwqDCoCBibHIKPiAKPiBBZnRlciB0aGUgY2hhbmdlIHdl
IGdldDoKPiAKPiAwMDAwMDAwMDAwMDAwMDAwIDwuc2V0X21lbW9yeV9lbmNyeXB0ZWQ+Ogo+ICDC
oMKgIDA6wqDCoMKgIDdjIDA4IDAyIGE2wqDCoMKgwqAgbWZscsKgwqDCoCByMAo+ICDCoMKgIDQ6
wqDCoMKgIGZiIGMxIGZmIGYwwqDCoMKgwqAgc3RkwqDCoMKgwqAgcjMwLC0xNihyMSkKPiAgwqDC
oCA4OsKgwqDCoCBmYiBlMSBmZiBmOMKgwqDCoMKgIHN0ZMKgwqDCoMKgIHIzMSwtOChyMSkKPiAg
wqDCoCBjOsKgwqDCoCA3YyA3ZiAxYiA3OMKgwqDCoMKgIG1ywqDCoMKgwqDCoCByMzEscjMKPiAg
wqAgMTA6wqDCoMKgIDM4IDYwIDAwIDAwwqDCoMKgwqAgbGnCoMKgwqDCoMKgIHIzLDAKPiAgwqAg
MTQ6wqDCoMKgIDdjIDllIDIzIDc4wqDCoMKgwqAgbXLCoMKgwqDCoMKgIHIzMCxyNAo+ICDCoCAx
ODrCoMKgwqAgZjggMDEgMDAgMTDCoMKgwqDCoCBzdGTCoMKgwqDCoCByMCwxNihyMSkKPiAgwqAg
MWM6wqDCoMKgIGY4IDIxIGZmIDgxwqDCoMKgwqAgc3RkdcKgwqDCoCByMSwtMTI4KHIxKQo+ICDC
oCAyMDrCoMKgwqAgNDggMDAgMDAgMDHCoMKgwqDCoCBibMKgwqDCoMKgwqAgMjAgPC5zZXRfbWVt
b3J5X2VuY3J5cHRlZCsweDIwPgo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDIwOiBSX1BQQzY0
X1JFTDI0wqDCoMKgIC5jY19wbGF0Zm9ybV9oYXMKPiAgwqAgMjQ6wqDCoMKgIDYwIDAwIDAwIDAw
wqDCoMKgwqAgbm9wCj4gIMKgIDI4OsKgwqDCoCAyYyAyMyAwMCAwMMKgwqDCoMKgIGNtcGRpwqDC
oCByMywwCj4gIMKgIDJjOsKgwqDCoCA0MSA4MiAwMCA0NMKgwqDCoMKgIGJlccKgwqDCoMKgIDcw
IDwuc2V0X21lbW9yeV9lbmNyeXB0ZWQrMHg3MD4KPiAgwqAgMzA6wqDCoMKgIDdiIGU5IDA0IDIw
wqDCoMKgwqAgY2xybGRpwqAgcjkscjMxLDQ4Cj4gIMKgIDM0OsKgwqDCoCAyYyAyOSAwMCAwMMKg
wqDCoMKgIGNtcGRpwqDCoCByOSwwCj4gIMKgIDM4OsKgwqDCoCA0MCA4MiAwMCA1OMKgwqDCoMKg
IGJuZcKgwqDCoMKgIDkwIDwuc2V0X21lbW9yeV9lbmNyeXB0ZWQrMHg5MD4KPiAgwqAgM2M6wqDC
oMKgIDM4IDYwIDAwIDAwwqDCoMKgwqAgbGnCoMKgwqDCoMKgIHIzLDAKPiAgwqAgNDA6wqDCoMKg
IDdmIGM1IGYzIDc4wqDCoMKgwqAgbXLCoMKgwqDCoMKgIHI1LHIzMAo+ICDCoCA0NDrCoMKgwqAg
N2IgZTQgODUgMDLCoMKgwqDCoCBybGRpY2zCoCByNCxyMzEsNDgsMjAKPiAgwqAgNDg6wqDCoMKg
IDYwIDYzIGYxIDM0wqDCoMKgwqAgb3JpwqDCoMKgwqAgcjMscjMsNjE3NDgKPiAgwqAgNGM6wqDC
oMKgIDQ4IDAwIDAwIDAxwqDCoMKgwqAgYmzCoMKgwqDCoMKgIDRjIDwuc2V0X21lbW9yeV9lbmNy
eXB0ZWQrMHg0Yz4KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA0YzogUl9QUEM2NF9SRUwyNMKg
wqDCoCAudWNhbGxfbm9yZXRzCj4gIMKgIDUwOsKgwqDCoCA2MCAwMCAwMCAwMMKgwqDCoMKgIG5v
cAo+ICDCoCA1NDrCoMKgwqAgMzggNjAgMDAgMDDCoMKgwqDCoCBsacKgwqDCoMKgwqAgcjMsMAo+
ICDCoCA1ODrCoMKgwqAgMzggMjEgMDAgODDCoMKgwqDCoCBhZGRpwqDCoMKgIHIxLHIxLDEyOAo+
ICDCoCA1YzrCoMKgwqAgZTggMDEgMDAgMTDCoMKgwqDCoCBsZMKgwqDCoMKgwqAgcjAsMTYocjEp
Cj4gIMKgIDYwOsKgwqDCoCBlYiBjMSBmZiBmMMKgwqDCoMKgIGxkwqDCoMKgwqDCoCByMzAsLTE2
KHIxKQo+ICDCoCA2NDrCoMKgwqAgZWIgZTEgZmYgZjjCoMKgwqDCoCBsZMKgwqDCoMKgwqAgcjMx
LC04KHIxKQo+ICDCoCA2ODrCoMKgwqAgN2MgMDggMDMgYTbCoMKgwqDCoCBtdGxywqDCoMKgIHIw
Cj4gIMKgIDZjOsKgwqDCoCA0ZSA4MCAwMCAyMMKgwqDCoMKgIGJscgo+ICDCoCA3MDrCoMKgwqAg
MzggMjEgMDAgODDCoMKgwqDCoCBhZGRpwqDCoMKgIHIxLHIxLDEyOAo+ICDCoCA3NDrCoMKgwqAg
MzggNjAgMDAgMDDCoMKgwqDCoCBsacKgwqDCoMKgwqAgcjMsMAo+ICDCoCA3ODrCoMKgwqAgZTgg
MDEgMDAgMTDCoMKgwqDCoCBsZMKgwqDCoMKgwqAgcjAsMTYocjEpCj4gIMKgIDdjOsKgwqDCoCBl
YiBjMSBmZiBmMMKgwqDCoMKgIGxkwqDCoMKgwqDCoCByMzAsLTE2KHIxKQo+ICDCoCA4MDrCoMKg
wqAgZWIgZTEgZmYgZjjCoMKgwqDCoCBsZMKgwqDCoMKgwqAgcjMxLC04KHIxKQo+ICDCoCA4NDrC
oMKgwqAgN2MgMDggMDMgYTbCoMKgwqDCoCBtdGxywqDCoMKgIHIwCj4gIMKgIDg4OsKgwqDCoCA0
ZSA4MCAwMCAyMMKgwqDCoMKgIGJscgo+ICDCoCA5MDrCoMKgwqAgMzggNjAgZmYgZWHCoMKgwqDC
oCBsacKgwqDCoMKgwqAgcjMsLTIyCj4gIMKgIDk0OsKgwqDCoCA0YiBmZiBmZiBjNMKgwqDCoMKg
IGLCoMKgwqDCoMKgwqAgNTggPC5zZXRfbWVtb3J5X2VuY3J5cHRlZCsweDU4Pgo+IApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxp
c3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
