Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF38C433EF
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 10:29:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 453F74171B;
	Mon, 27 Jun 2022 10:29:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 453F74171B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qkFBK08F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2-dCmJ-zJCBB; Mon, 27 Jun 2022 10:29:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8DB25415C9;
	Mon, 27 Jun 2022 10:29:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8DB25415C9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69E9FC0032;
	Mon, 27 Jun 2022 10:29:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E7C2C002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 10:29:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C905582871
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 10:29:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C905582871
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=qkFBK08F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dPjTCm3FDsLf for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 10:29:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9FE30827C5
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9FE30827C5
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 10:29:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTKtIkROwSiMzgX162A9WIsDUZJWRyM38FK+ynOGLuqn5D8r7wpNKTJf9BgRm/GpwoashTrBLUzcWkWRdZU5J6y1kd5i4DaDBX3nR7A/i2D2hr+++iuXKKxDq1jaagM2PBNKtXcsiC55afvm2eP9QWY+yNl+RuNgFGNYpXbmpCSgN5W88oOJm/sg67qpXTrF0JwV9+O18+50J11XJsy8viqxMciUOF5vCykTEXb3/x9Coe8TcLNsX7zg0PF90LNFqQT8crCfeOLve8KrMiWARFZMJQxGRwigkhc2Fx/MRQn7+C0pGJWWpZlz/5GIT5V4ocoku5iNMPKqbYeSYmF+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/V4q8OHAV6lKUfbQjXTmIjn1WCfQgjySQ7+Emu75Tc=;
 b=hT/tssd3z7y+fudDIJm8G9P53E+W5pdGAkONvZeiZt+pdd6ViDBSK90Yd6KGtTFHb2eNoDFV4dUJcxGt18FsgsLmbht4JJm/M/iMraO1PwMNdRx61WExwai++b2Fl9FrbSZ9IQpnZfExVUXmwG9CZbnyAAEEypXcI0s3OjLLc6r0ryjuVkUn7GCSbkd4I9SrBtM1CXs7rHDhBZjKPgpYZAf0B1NwQu6SCkFBbiaOmP0FcxGFTvBwByMO9nNhhuHx0st7CZSgeKM6zZNRAWJRNmGcpjw9S+TCawQRf+30Zs2CghgYTb6g76nerGLlbI3wcMx2T+vuiBQ/TXdiXEpTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/V4q8OHAV6lKUfbQjXTmIjn1WCfQgjySQ7+Emu75Tc=;
 b=qkFBK08FX28FxShUMcCHfoHWA8SbIL9zHpYXtV3SNrKlK4tn2Zdwo9mJ4p+mPBpvghlfV+nIF4uTzI9QX/dZo3CbMM7HOJ0jdBtOGMQ2twqI7ea34WUILXFgU4UfMHCeXz0O0n77+p4bo8hTBfcM1ZBn0rcl0NRGjMWrL21NGNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN6PR12MB2798.namprd12.prod.outlook.com (2603:10b6:805:69::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15; Mon, 27 Jun 2022 10:29:33 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::447f:59a0:eb30:ec26]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::447f:59a0:eb30:ec26%9]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 10:29:33 +0000
Message-ID: <403e6853-86ac-a81f-42a0-2d896163ab81@amd.com>
Date: Mon, 27 Jun 2022 15:59:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 3/7] iommu/amd: Fix sparse warning
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
References: <20220603112107.8603-1-vasant.hegde@amd.com>
 <20220603112107.8603-4-vasant.hegde@amd.com> <YrQeXdR8yPOyv957@8bytes.org>
 <82767d0d-a04b-4432-0e7e-77bcca095e09@arm.com>
In-Reply-To: <82767d0d-a04b-4432-0e7e-77bcca095e09@arm.com>
X-ClientProxiedBy: PN3PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 786885c0-8bbd-4b8c-1ccc-08da5827ecd1
X-MS-TrafficTypeDiagnostic: SN6PR12MB2798:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gF0oE1YS5aByBWtQVx/jTZTNLkZ5ox/dHzRn5Fu0wDcl46pY4EY8zB2uLyp+8QiIX2DDoCWFGQSnBfMUqSlwqpHeR0HOXbO1PJ3Gy9bhCxnYzh2IpKwcAStQpI+8OnTQw7E0r3QGh+Bo8VBOgW4xvoORIvmz1YwCLEpyV0WqkilE46atbcdTaZG6Cet4JYkKkdphpik+5kiY6Zl3G74nrRiRGDTXpFgGbfh2d+FXR787iLbwpnHLTq9wK6uRoWADSGKQycnkNyy0AtV1Cuvmi7B/8zHQMkseIM+3UN8U6/f7vME0IyxRJpdFfk7zC/kx5xGtswwJ2lyByafI3kyIps68DW53ysb1c+F3aT6IKn6F6I4XXK6giAR6P1AEuhs/U6sL/45Lhd5zsWEGDKbTBNiMfdZtOFiLHelyfxno0tZGUlhk3I1HQUpXRyi9sVZpSJmx1U/Gh4+pvtzxGUbDckVxaUEpVZiiDLfF1Jfw0KCS2YlLuLBAzUstEYhFr+35xt8JJOHR9xLhA0w7RxFwKOcBEkO/yUs3ez3xcxRhhIWZWJ3bx7uyy1kxWCZLIN24cE8yXAW9pNJivgsRipanf1ErNDGL7xQ0Z6mVUbCW+sOq9kq/eb0mK/VOxFRMcW4VExYjtalWek/7knhEVuG8Crq5pJ4GCI+Vr4akOe6Wi0jaQAMi7xfOeAAipHNOnEiay2X3qrt6g6J/SRKOicuOVU0JuH+xadVmyEGJDzdMVw1hB6uZwi351GM7PhLAhnDoHZgMMSl8UWfZIV6iadrypcjsJ/Y7fID+ZYZL3tnRAcIP4F5vY+QD7S2vYl5k0Tiv1OUwFC/uiqjojiwvTToakg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(6512007)(66476007)(478600001)(86362001)(41300700001)(6666004)(6486002)(5660300002)(2906002)(31686004)(44832011)(6506007)(53546011)(8936002)(83380400001)(26005)(66946007)(186003)(2616005)(8676002)(38100700002)(110136005)(4326008)(66556008)(36756003)(31696002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXB1NFlvN0ZScnlzbFBJVStuV3V3U29BSGVGWWJQQW1kRURlR2FGdnZnTDJl?=
 =?utf-8?B?dllSNVhnRXVJYjFmdEEzQUREVXhFU0Q4VXdxaEJaRnZSdTI0bDJCb2JHYkha?=
 =?utf-8?B?QUdibXp1eUlDajhTd01uc3laRDM1OVk3Mk5YQjNaSGE0c09nSEx1U0tGc01u?=
 =?utf-8?B?em15Y3JTbmdZQ0kxamI0WXcyek9ZRjd2ZXlNVllTSFMwQXNWaHNYdU0rOFgw?=
 =?utf-8?B?bitYUzZqdXV3VFdIT2wzOEU5dHlKMU1CME5XV1dLRWgvSjgxQkxOMGtJdXdJ?=
 =?utf-8?B?d3FjMjdVR2lUN3VveGtvb2hvcDVMTGJQbnlpUElCa0ozelROMFdxaFJiTXM5?=
 =?utf-8?B?T0QzOGxtNU16VDMzMTVGRHA1dEhKcm0zelFRRjh0c2JSSStYOFhwU3E2QVA3?=
 =?utf-8?B?azZOS0JrNEpNT1ZxdVNqazZmK2g1SEJ4RDBjWkltMG51SVB0dVFDelZSM1VK?=
 =?utf-8?B?cVZUa3FEaXlhdkNRdmVPZHh4Y0xQVUxKOG44dnk5K3puWStMS1RzUE44Sm9U?=
 =?utf-8?B?eTNzSWlKME5iTHB0S0hZbXE3Wk8vQ21DTEVDT2lNOEpkbEhYUU1vSzFFS0M3?=
 =?utf-8?B?bDRYVVg2U3BmUE1IcHZySmJlTHFYUE1LNU1sWWVNS254OWZrcjZvblhrVjVY?=
 =?utf-8?B?eVhucDhtZTMwQnRCa1ZpbjFKSEJoZTRTUzVzOUJVOVg3aGxXeE40QjVXTjJB?=
 =?utf-8?B?WTlkL2tGNVZtcytuOWFOSjZYTVNBM0pUN3NmUGJDZnBEMk1iSXJKbUtQZlp2?=
 =?utf-8?B?dHNuVm02QzEycHlZd0UzTGNaN2diTGgxcUM2TlRPMERqN2Qya2x3TUUxNmdH?=
 =?utf-8?B?Uktna3NLN0tQNXlWc3Zsb2VDL2hSNzhkTUtwTmJDTU5hbEJBZU1EeGZXRDUy?=
 =?utf-8?B?NlpyTmg5S3NDSzZGRi8yWkRMYnlabU1wbnE1NVZpMUpLa1oyWWR0dU90cVBK?=
 =?utf-8?B?YzdkNmdtUDkwMDZISUdXekN1K0JCOGhrYlFLWFdnMEdiVWlkcFhJcHdDc0lp?=
 =?utf-8?B?OUJXaVRNVzlMbWtFRXFCcTJBT3l1eUhJUUJCSEVKVHp0NHVFOFlpUmgzNVRa?=
 =?utf-8?B?a2Z0TjBuZWc4cUZjVFVxWEQvVVdEK1pTK004MTdjV1ExU2pLRG40dHZwZzhZ?=
 =?utf-8?B?c3orellyK0IvSTJBWTEvZUtrc3pzME9XcmFoUk5NaGxIUUc0bmJoNm5kNklM?=
 =?utf-8?B?ei9PdVZPQUhReGpMaVd6T0E5YXAwZ2VXZTFsWGNvUys5blhCaEkwcTJyVmMv?=
 =?utf-8?B?ZDlpZlBSUVJ3Zi9JYWVSYUZKbDRHQzJpS2pTMlhRM2RYb1BvY20rZ3VkSXNr?=
 =?utf-8?B?ZHFTV005UlNJRGtHRVV6TjR1TmdEUzlRUWFaT3JtR1Q4dGUrbzF2SHRUNllT?=
 =?utf-8?B?M3Q0OGZtcENkVFpkekFyUXEzUnJpaDBYbUtqaEdSVEQ2WHBuQXo2OXBNR2wv?=
 =?utf-8?B?bWRyOUtoNlQxOENVZW0zbVMxcytQbUdCTTNQR0paTVVYdkcyWjhWYnhmV1hL?=
 =?utf-8?B?ak56Y2prNk03STFGVjJmRytkUVBOZWtxbUdiK3NENVF2VzJuWnk4QzBuSHFn?=
 =?utf-8?B?T2hHa2VNdXNVOFdqVlRMbno4eFpHYXpkc3JUWHRXZGJDbHhLeVVPUldkMkl0?=
 =?utf-8?B?ejNxY3ZwWUtoZElOdDZ2OVNpZERobkxBTnhsUTYwSkxubXBFYkNXaUFvWmc5?=
 =?utf-8?B?STBZU0x3SnlGWUFDdzVBcmFwQzM4VjNraTA2aHIwZnJWQ1FHemMrcTJNRktT?=
 =?utf-8?B?dlJpRldZcVVOZzZobDQ4elZoc1lheGpFMWtpYU1MMTlFRmlSYmhXd0NmZmpH?=
 =?utf-8?B?RkYrY0MwdEF6WEJhczZBVjYzNGp5VVM2UXFSMFJVaEJ3UlBySFMvdmpDelpZ?=
 =?utf-8?B?NmRYWG9Lc1dyQUhhR3hFSVJBbmZwQXh2Um1vM0RrQ2FsUVI5dTlLeUJkbEJ6?=
 =?utf-8?B?Y0kxV2dBQjlzUk9JSDY1L2RDY05OaVJzOVp1dFZtVUg5aGVHL3R4RWRsR3hs?=
 =?utf-8?B?SWdrc25pNll3S2NMNGtSWG05bjAvc2E0d3NSbUpXUmc0WGVtWU11WjBIeDRI?=
 =?utf-8?B?YzFwaE5tbHRDa1JkQW5TbkJaTUduTllKZzl4a1VRVmdKZzVTQkNrZU9KM1pH?=
 =?utf-8?Q?COmh6bNvyR+/y7kWoz+3DEmH9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786885c0-8bbd-4b8c-1ccc-08da5827ecd1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 10:29:33.0036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHX1OOUeZbT0sKrHcPPJYf/3yu7NzdKcb9b63x3W2mi4as1ROkU2MicUptmPGIgfXx3MbmoleUCY6me+MngEVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2798
Cc: iommu@lists.linux-foundation.org
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
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiA2LzIzLzIwMjIgMzoxMiBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjItMDYt
MjMgMDk6MDMsIEpvZXJnIFJvZWRlbCB3cm90ZToKPj4gT24gRnJpLCBKdW4gMDMsIDIwMjIgYXQg
MDQ6NTE6MDNQTSArMDUzMCwgVmFzYW50IEhlZ2RlIHdyb3RlOgo+Pj4gRml4IGJlbG93IHNwYXJz
ZSB3YXJuaW5nOgo+Pj4gwqDCoCBDSEVDS8KgwqAgZHJpdmVycy9pb21tdS9hbWQvaW9tbXUuYwo+
Pj4gwqDCoCBkcml2ZXJzL2lvbW11L2FtZC9pb21tdS5jOjczOjI0OiB3YXJuaW5nOiBzeW1ib2wg
J2FtZF9pb21tdV9vcHMnIHdhcyBub3QgZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/Cj4+
Pgo+Pj4gQWxzbyB3ZSBhcmUgZ29pbmcgdG8gaW50cm9kdWNlIHYyIHBhZ2UgdGFibGUgd2hpY2gg
aGFzIGRpZmZlcmVudAo+Pj4gcGdzaXplX2JpdG1hcHMuIEhlbmNlIHJlbW92ZSAnY29uc3QnIHF1
YWxpZmllci4KPj4KPj4gSSBhbSBub3QgYSBmYW4gb2YgcmVtb3ZpbmcgdGhlIGNvbnN0cy4gUGxl
YXNlIHVzZSBzZXBhcmF0ZSBvcHMKPj4gc3RydWN0dXJlcyBmb3IgdjIgcGFnZS10YWJsZXMgYW5k
IG1ha2UgdGhlbiBjb25zdCBhcyB3ZWxsLiBUaGlzIHByb2JhYmx5Cj4+IGFsc28gaGFzIHNvbWUg
b3B0aW1pemF0aW9uIHBvdGVudGlhbCBpbiB0aGUgZnV0dXJlIHdoZW4gd2UgY2FuIG1ha2UgdGhl
Cj4+IG9wcyBjYWxsLWJhY2sgZnVuY3Rpb25zIHBhZ2UtdGFibGUgc3BlY2lmaWMuCj4gCj4gVEJI
IGl0J3MgcHJvYmFibHkgdGltZSB0byByZXRpcmUgaW9tbXVfb3BzLT5wZ3NpemVfYml0bWFwIGFu
eXdheS4gQXQgdGhlIHZlcnkgbGVhc3QgaXQgd291bGQgYmUgbG9naWNhbCB0byBtb3ZlIGl0IHRv
IGlvbW11X2RvbWFpbl9vcHMgbm93LCBidXQgbWF5YmUgd2UgY291bGQgc2tpcCBhaGVhZCBhbmQg
anVzdCByZWx5IG9uIGRyaXZlcnMgaW5pdGlhbGlzaW5nIGRvbWFpbi0+cGdzaXplX2JpdG1hcCBk
aXJlY3RseSBpbiB0aGVpciAuZG9tYWluX2FsbG9jPwo+IAoKUm9iaW4sCgpTb21ldGhpbmcgbGlr
ZSBiZWxvdz8gSWYgeWVzLCBJIHdpbGwgY2xlYW51cCBhbmQgZ2V0IHByb3BlciBmaXguCgoKLVZh
c2FudAoKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FtZC9pb21tdS5jIGIvZHJpdmVycy9p
b21tdS9hbWQvaW9tbXUuYwppbmRleCA4NDA4MzFkNWQyYWQuLjMyZGQ4NGE3YzFkYSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9pb21tdS9hbWQvaW9tbXUuYworKysgYi9kcml2ZXJzL2lvbW11L2FtZC9p
b21tdS5jCkBAIC0xOTE2LDYgKzE5MTYsNyBAQCBzdGF0aWMgaW50IHByb3RlY3Rpb25fZG9tYWlu
X2luaXRfdjEoc3RydWN0IHByb3RlY3Rpb25fZG9tYWluICpkb21haW4sIGludCBtb2RlKQogCQkJ
cmV0dXJuIC1FTk9NRU07CiAJfQogCisJZG9tYWluLT5kb21haW4ucGdzaXplX2JpdG1hcAk9IEFN
RF9JT01NVV9QR1NJWkVTOwogCWFtZF9pb21tdV9kb21haW5fc2V0X3BndGFibGUoZG9tYWluLCBw
dF9yb290LCBtb2RlKTsKIAogCXJldHVybiAwOwpAQCAtMjI4Miw3ICsyMjgzLDYgQEAgY29uc3Qg
c3RydWN0IGlvbW11X29wcyBhbWRfaW9tbXVfb3BzID0gewogCS5nZXRfcmVzdl9yZWdpb25zID0g
YW1kX2lvbW11X2dldF9yZXN2X3JlZ2lvbnMsCiAJLnB1dF9yZXN2X3JlZ2lvbnMgPSBnZW5lcmlj
X2lvbW11X3B1dF9yZXN2X3JlZ2lvbnMsCiAJLmlzX2F0dGFjaF9kZWZlcnJlZCA9IGFtZF9pb21t
dV9pc19hdHRhY2hfZGVmZXJyZWQsCi0JLnBnc2l6ZV9iaXRtYXAJPSBBTURfSU9NTVVfUEdTSVpF
UywKIAkuZGVmX2RvbWFpbl90eXBlID0gYW1kX2lvbW11X2RlZl9kb21haW5fdHlwZSwKIAkuZGVm
YXVsdF9kb21haW5fb3BzID0gJihjb25zdCBzdHJ1Y3QgaW9tbXVfZG9tYWluX29wcykgewogCQku
YXR0YWNoX2Rldgk9IGFtZF9pb21tdV9hdHRhY2hfZGV2aWNlLApkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCmluZGV4IDg0N2FkNDdhMmRm
ZC4uNzNjZmJhNmE2NzI4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lvbW11L2lvbW11LmMKKysrIGIv
ZHJpdmVycy9pb21tdS9pb21tdS5jCkBAIC0xOTE1LDggKzE5MTUsNiBAQCBzdGF0aWMgc3RydWN0
IGlvbW11X2RvbWFpbiAqX19pb21tdV9kb21haW5fYWxsb2Moc3RydWN0IGJ1c190eXBlICpidXMs
CiAJCXJldHVybiBOVUxMOwogCiAJZG9tYWluLT50eXBlID0gdHlwZTsKLQkvKiBBc3N1bWUgYWxs
IHNpemVzIGJ5IGRlZmF1bHQ7IHRoZSBkcml2ZXIgbWF5IG92ZXJyaWRlIHRoaXMgbGF0ZXIgKi8K
LQlkb21haW4tPnBnc2l6ZV9iaXRtYXAgPSBidXMtPmlvbW11X29wcy0+cGdzaXplX2JpdG1hcDsK
IAlpZiAoIWRvbWFpbi0+b3BzKQogCQlkb21haW4tPm9wcyA9IGJ1cy0+aW9tbXVfb3BzLT5kZWZh
dWx0X2RvbWFpbl9vcHM7CiAKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaW9tbXUuaCBiL2lu
Y2x1ZGUvbGludXgvaW9tbXUuaAppbmRleCA1ZTFhZmUxNjk1NDkuLjBjMDI4YWE3MWI5NiAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9saW51eC9pb21tdS5oCisrKyBiL2luY2x1ZGUvbGludXgvaW9tbXUu
aApAQCAtMjU1LDcgKzI1NSw2IEBAIHN0cnVjdCBpb21tdV9vcHMgewogCWludCAoKmRlZl9kb21h
aW5fdHlwZSkoc3RydWN0IGRldmljZSAqZGV2KTsKIAogCWNvbnN0IHN0cnVjdCBpb21tdV9kb21h
aW5fb3BzICpkZWZhdWx0X2RvbWFpbl9vcHM7Ci0JdW5zaWduZWQgbG9uZyBwZ3NpemVfYml0bWFw
OwogCXN0cnVjdCBtb2R1bGUgKm93bmVyOwogfTsKIAoKCj4gKGFuZCBGV0lXIEknbSBsZWFuaW5n
IHRvd2FyZHMgdGhlIHNhbWUgZm9yIHRoZSBkb21haW4tPm9wcyBhcyB3ZWxsOyB0aGUgbW9yZSBJ
IGxvb2sgYXQgb3BzLT5kZWZhdWx0X2RvbWFpbl9vcHMsIHRoZSBtb3JlIGl0IHN0YXJ0cyBsb29r
aW5nIGxpa2UgYSBzdHVwaWQgbWVzcy4uLiBteSBzdHVwaWQgbWVzcy4uLiBzb3JyeSBhYm91dCB0
aGF0KQo+IAo+IFJvYmluLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9t
bXU=
