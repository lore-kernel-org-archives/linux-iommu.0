Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C827C433EF
	for <iommu@archiver.kernel.org>; Wed, 20 Apr 2022 05:32:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2AA8E400D6;
	Wed, 20 Apr 2022 05:32:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BD030SMBtjMb; Wed, 20 Apr 2022 05:32:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BD6BD4011D;
	Wed, 20 Apr 2022 05:32:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EDFEC0033;
	Wed, 20 Apr 2022 05:32:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72580C002C
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 05:32:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E4F383E00
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 05:32:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4fXwOj66ULGr for <iommu@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 05:32:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2199483DEE
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 05:32:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UL4kPgPe+IfZLQkeAhUWHMA44PZpTHJ/j9Vz5DZJLE1EDETN7ewxUHd//LycUR4N1osiKwEElTNVqZVTPlvIZynCOtskYBDJ+ci8yUc/FTk3CJREamsKmyiqZdBxb1YAvfycPFFmOYwonBIVH7DnJ0MnlPGXgawalE6q/5f6EynTHCqRMNaYd+v4rG4ukrgWr0U4NT/+4WixRcz46mRvu+fBY+wjo3TRVKIjDCeaowo0pe2FAGZ3L3k9uAfcUFFE50i597D/CEB14pCl/PYb4wwbogPPac1UC38ix+8fBxutw6pnXv9RQNxoCU1g31uYuLkbMfRDvbYBF8QTCNxM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/yibClq7gykEmzpjNZZjY8WKSm5G8WhrlHQylLN/CA=;
 b=aJooSVWRIwehLX8iRZnVJ51lnJpN+bhgREjae8nv3sfOf9HpQnmgYtrFuGplBgAagsroOXWC/cKPL+qatfLc8FTEAj75MB2bsHTEEJRz36JDnoPdTfvmmxy6GHggAV8QFhTASz5cWQE/sPU9Acjv2Iyml34Rr2aApIzjCHKYKRxqLkjdznez/469TvVurLppMRyT9uOWAPH19fv0tHq+dpM7Aph8c0eHSNFXTFfRQPXtCD9lY3WsjZgzKkyFOWpi/TbBBhJNlYQp7pH9h++o81fHnQclnD7vRLlrMvLCN/LFH2QURmK+A7B80Nad0paRRcwFFKF40Fq6XUNxNNPbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/yibClq7gykEmzpjNZZjY8WKSm5G8WhrlHQylLN/CA=;
 b=ps6UHEKdijlaTaCUaO3Aw1CADpfjeu48jSfSyHF5dgodWEB7NC2I1ozZbrqPNgv2RXg4uMaEdA/b9Riw4LiJYnByb6+zteLSTkK7UHf6EEw/+QIx/hsDNNnL+m3gzmRPQ9cD9G4aRNIPw4AEZ15lynOuzt2hN/NNa4ydElgQb8u2khETEWi0G/v6uiSajBNMjUeHRBlHOKDqdi+mziu63TnRhfOTb8KgvV6+ypKxOTvKk72tTEpYB8EdGblXtcjz2eyq5AVhP4ujL3DdPr8p+HCfuUE733UkDXqKWtpMicc/yif/qEU/5gw71r+Xa+1s0cvUSnjK7eu+bkQBY5B6iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by BN8PR12MB2979.namprd12.prod.outlook.com (2603:10b6:408:66::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 05:32:24 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e15c:41ca:1c76:2ef%3]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 05:32:24 +0000
Message-ID: <9b6b65ed-180b-ed33-43c3-7042ec895cff@nvidia.com>
Date: Wed, 20 Apr 2022 11:02:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [Patch v1] iommu: arm-smmu: disable large page mappings for
 Nvidia arm-smmu
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, thierry.reding@gmail.com,
 vdumpa@nvidia.com, will@kernel.org, joro@8bytes.org, jonathanh@nvidia.com,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220417090432.21110-1-amhetre@nvidia.com>
 <52df6c79-3ee7-35e2-b72a-44ee9cb48c34@arm.com>
In-Reply-To: <52df6c79-3ee7-35e2-b72a-44ee9cb48c34@arm.com>
X-ClientProxiedBy: MA1PR0101CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::32) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ddbcca7-4093-49a0-d220-08da228f2630
X-MS-TrafficTypeDiagnostic: BN8PR12MB2979:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2979C970F7082F05A1C10ADCCAF59@BN8PR12MB2979.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7JqmURINwGXor6yurXLPEejlBytVH/N2nJRBlDSsDSOcGMATidtUcc5xnirB+rOzrPCyybHA6LjXuENlG48I8VT6ZU8lOscvPMZGMH7LAIwhpFuau0ZT2gGZ8r57xZl6poOTHWV9AtYCwinR0gfUAbEAclLKempPH25grXGfdHpEYO1EYDP1WZNgDNT2ATBZrtj9sjk8+55diXJgZhFdN6aP6t3odBwLfltsbkO7mCIvlKfcWra6ktuDxvACw+4m73l5yeBL+tkByBDd8sjRdgni9tJ+rVPFfQTBlOShy1ZOJRopAAuQxsvE2KbJt0oFcuRBhTPr55aorcUCuTsWrx8WTLZHLZ5xovcTJZyabJ518NRT+j19vUoqchdFFy7yjMmdMHbTN/Z/SLgKaa5DGdmy3Asa/A5pwRWMrh2dHBjqL1jeL8qwhuxpekHr5Fhy7lL+VdAOwaHAD1rTU5AOxTnRE7A4p3ZucFoItQStfxec4X3FNOjzs1JvTwXbJ71sbcPhqNFrblos+N+ZfCLVLXLtIFgHzKOkKbPoipVTq/QByPLEyNdi0rL76vOrywZX1Rvy0dzoN4Ukuel6HACbW/kvy1Y8AdRfDHAbH1EusLWMv/jA8IrLU7sPcCNPmWw0+BS4vWe1WjFqqRljI7O7ByiSqL3nPXlu0myKH4ZE6wqo3M6pcu1/5ih7CHxLgj4h7nLANc2tZQYIJCIfSwBPrtr6s+6dd4KHJu2VNczi9oaIYdyqlp/RTbRPqgOgEgS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(508600001)(186003)(86362001)(107886003)(6512007)(6486002)(8936002)(2616005)(2906002)(5660300002)(53546011)(55236004)(83380400001)(6506007)(31696002)(6666004)(66946007)(66476007)(36756003)(31686004)(4326008)(66556008)(8676002)(921005)(316002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGdxKzdrSWtuK0w1ajB5c2N2V1VZN0NiWGRlcnJ5TGE4QUcyRnhUTmtIL2Yw?=
 =?utf-8?B?c291ZWFwYUlBQUxldVFnZFdlMmRqMDVUZExnSnVPRVNyajN0TlVqeWh1eGlG?=
 =?utf-8?B?dHVoYlVyWXM2MEtWN2JQL3ZWanVyZlhLYWM2V3BPMjFPaVhrL3NOcUI1RGx5?=
 =?utf-8?B?dUdkazRkQ2NJRmxPelZOSXhjOUJ6N2ZLTEhVY1orOWFTTDlFZ0lhTlhnTlh1?=
 =?utf-8?B?UHpuUk43dUs1bUhuMmhDcmx5cVp1WHRRZzNZdUdKTnJ1b3d3YlJHZ2paaXlm?=
 =?utf-8?B?a2d4TWo5SVNuNitNWGtOeFBjdTJCdkRSMlQzVUJ6QnU4bUVITjNQSE9EWTkr?=
 =?utf-8?B?Wm9lc3AraEs5eWtWUkY0QjZxMEFTVk9HdXl1NXljMFF0amtDbVdUdm1yZ0pL?=
 =?utf-8?B?b2o0bVBvYUFIS1l2QUZHS1g0UmhWUHRaNE9vK2hSUVdoeWxkMG1sZWp3c0hR?=
 =?utf-8?B?cFRRTE5iZ2Z2WE51OEJoSzRTUGtCelAwYWNDK0M2QXFpQ0p0K29uUDRBSDk3?=
 =?utf-8?B?cGFUNVBqT2hZMEpSeTBUcy9VKyswMUI4RU9oMVRlY3hoT09lYVFsOEVGMWly?=
 =?utf-8?B?Sk1BaFRENGo0R012dTU5bU0zK1lUNGpUSmgzenhYNnZzZGpCQUxDdFgxY1RK?=
 =?utf-8?B?blMwZVRoSUpobDZPZENESXdQeFB0MUdQY1VRWlVmampEaE80K0k5L3VPQlBw?=
 =?utf-8?B?WWppNVhKNHIwMTBIYTZYMTYzVHFuMUZkSnA3a291b2p1bXdrQmZZWTY5UDE5?=
 =?utf-8?B?bS9rU2JPK0M2QnNzOTFxZVIvWGk2WHdFYkxuS1hFSjBBN1hFRlBCRHRITzR6?=
 =?utf-8?B?ZHZGT044SmRnTEZVOTkxUWE2Z21xUFdNSW82NDZhMUljaHdjcEh4K2VkcWtm?=
 =?utf-8?B?Mkl1VFNjLzBETGR1VkhnTnk3SElicFVuZVBEOTY4NEd3dnpvZlRDQW0rMnlw?=
 =?utf-8?B?RHR3UjQyZTFJZ3Jqai9ZYmpGZjJvTGQ4K0ZpaVRreW1VQW9CalZscHpLdlNt?=
 =?utf-8?B?RzFHb21XTUJFMnZBcFZUcTEzYWVzZHczL21maWxCd0NuOCtsYXlYNXlGdVk1?=
 =?utf-8?B?allpcDRJOUNBSUEybDQ4cUlvS1QxdmJjdmREbVBXb0FNUzF0STZLT1JGNFI1?=
 =?utf-8?B?RHpTdkxqYnUrWXNtRjM2Q1BSTEFEU245TlphL1B3ajlnMnc0Y1V2QmV5Qm5D?=
 =?utf-8?B?d2FJSXFiV1NNWjA4K1dYQUl5TmlqS0o2Mm5VZkt4YWVVV056YUZnQVZjUDF4?=
 =?utf-8?B?NkhCTXFzUjRpcTd2bUNvNXBCa2lxdDFHV1pyQTFmR2dLczZUN0VLbXM3WTdI?=
 =?utf-8?B?VWpYUlVhV3hUN3lXTWh4aFhvQmo1ZFVjbVh0UTRVUmF3czdITEdLTjVJYWti?=
 =?utf-8?B?aGllb3d5WnVPaGFhL296TlpLZngrOSt5bHFwTEFVUHJuRCt0Y0tXLzZKd1Z5?=
 =?utf-8?B?UUtrRUQ4VXYvVy9QMSttZkFNaXVXOUJmd25MM0x5TFBCRHJ0MFFTVnNUTDhy?=
 =?utf-8?B?VUtzMnNiRmU4eWhHVE5rdVl1eXVEa1pzOTBUaVJzZVVkSFMrMEg5MHlWamQ0?=
 =?utf-8?B?V2MyV0tOK3l1RnhZQnQ1OXp2OWkvWE5jaWphcVcydUZCRmxqR2t1aC8xVjZB?=
 =?utf-8?B?VzltVkNqREdSbE5VMVFvOXp5ajJuU1NvZ0dtRDlUcUpQZmlsd1JYVVlEdytk?=
 =?utf-8?B?NTlueGExNWlkdU9wQUZNeCtkMThvN0R4dXc4c3kzZ05FU2pwUEw1MnVKM2g5?=
 =?utf-8?B?OTBMTkxCaFpyZ09NRzE2NW0vNGl4YUpLVWM1a0V0bGFVa0FIVEZTWDBwZTZW?=
 =?utf-8?B?eEUxQ0k3cHRPMSt5c3ZRYmZUYzJZbDdLa0ZyQkhxR3pYSlRrT2RQNE1uUmhy?=
 =?utf-8?B?MURMTWIva0dSVHhnandWbFlveEhwS2RIYlRSUDRnNFplV3FkbkJyd09LZHVR?=
 =?utf-8?B?a3lxd2Jnd2s1dTMvbHYzbERFRjkrZ1ZzMllsU2tXOExYdzN2d0VHc3NqYjlS?=
 =?utf-8?B?bkZUaTg5UTNwUTcrSTJKYktqaWg4eHlFQXc4cS9pTHRlWDhLSG5tcE5FSStF?=
 =?utf-8?B?YVBhdmZjdnpPNkJtZnViK2xTcmR1Rm5kWTV3dFppTWkzb1N6dzFsZ0I0Vjdv?=
 =?utf-8?B?cWZxTjNGWWMrWitXTThwS05YbmlDSE14R0YvdS82aENxUnNtandWUHNTWUZh?=
 =?utf-8?B?RldlYzZqejE5QU56VXRxejhKeEJWaXljVTIwV1VoS2l6N2VpeHpBbllOcWpJ?=
 =?utf-8?B?YktXTkdoNWNDOWV6RmR1SWZZQStVT0xsbnBvWlZEZjJpR3FLdkpjR0dpaEZF?=
 =?utf-8?B?QmdscVk1dEJOcE0reDdIQU9kUWs5d3E4Q04rNWNLTE1YVHMzRGd5UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddbcca7-4093-49a0-d220-08da228f2630
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 05:32:24.6028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80okRS9fZ4EU8No8KimrNLsvw6ZK3MlCwlinetesTtB7BOsJPjWO8+GZfrzHIMri7tlVSJay4qotaEW554EHmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2979
Cc: Snikam@nvidia.com, Pritesh Raithatha <praithatha@nvidia.com>
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
From: Ashish Mhetre via iommu <iommu@lists.linux-foundation.org>
Reply-To: Ashish Mhetre <amhetre@nvidia.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiA0LzIwLzIwMjIgMTo1NyBBTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IEV4dGVybmFsIGVt
YWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzCj4gCj4gCj4gT24g
MjAyMi0wNC0xNyAxMDowNCwgQXNoaXNoIE1oZXRyZSB3cm90ZToKPj4gVGVncmExOTQgYW5kIFRl
Z3JhMjM0IFNvQ3MgaGF2ZSB0aGUgZXJyYXR1bSB0aGF0IGNhdXNlcyB3YWxrIGNhY2hlCj4+IGVu
dHJpZXMgdG8gbm90IGJlIGludmFsaWRhdGVkIGNvcnJlY3RseS4gVGhlIHByb2JsZW0gaXMgdGhh
dCB0aGUgd2Fsawo+PiBjYWNoZSBpbmRleCBnZW5lcmF0ZWQgZm9yIElPVkEgaXMgbm90IHNhbWUg
YWNyb3NzIHRyYW5zbGF0aW9uIGFuZAo+PiBpbnZhbGlkYXRpb24gcmVxdWVzdHMuIFRoaXMgaXMg
bGVhZGluZyB0byBwYWdlIGZhdWx0cyB3aGVuIFBNRCBlbnRyeSBpcwo+PiByZWxlYXNlZCBkdXJp
bmcgdW5tYXAgYW5kIHBvcHVsYXRlZCB3aXRoIG5ldyBQVEUgdGFibGUgZHVyaW5nIHN1YnNlcXVl
bnQKPj4gbWFwIHJlcXVlc3QuIERpc2FibGluZyBsYXJnZSBwYWdlIG1hcHBpbmdzIGF2b2lkcyB0
aGUgcmVsZWFzZSBvZiBQTUQKPj4gZW50cnkgYW5kIGF2b2lkIHRyYW5zbGF0aW9ucyBzZWVpbmcg
c3RhbGUgUE1EIGVudHJ5IGluIHdhbGsgY2FjaGUuCj4+IEZpeCB0aGlzIGJ5IGxpbWl0aW5nIHRo
ZSBwYWdlIG1hcHBpbmdzIHRvIFBBR0VfU0laRSBmb3IgVGVncmExOTQgYW5kCj4+IFRlZ3JhMjM0
IGRldmljZXMuIFRoaXMgaXMgcmVjb21tZW5kZWQgZml4IGZyb20gVGVncmEgaGFyZHdhcmUgZGVz
aWduCj4+IHRlYW0uCj4gCj4gSXMgdGhpcyByZWxhdGVkIHRvIGFueSBvZiB0aGUgc2V2ZXJhbCBr
bm93biBNTVUtNTAwIGludmFsaWRhdGlvbiBlcnJhdGEsCj4gb3IgaXMgaXQgZGVmaW5pdGVseSBz
cGVjaWZpYyB0byBzb21ldGhpbmcgTlZJRElBIGhhdmUgZG9uZSB3aXRoIHRoZWlyCj4gaW50ZWdy
YXRpb24/Cj4gCkl0J3Mgbm90IGEga25vd24gTU1VLTUwMCBlcnJhdGEuIEl0IGlzIHNwZWNpZmlj
IHRvIE5WSURJQS4KCj4+IENvLWRldmVsb3BlZC1ieTogUHJpdGVzaCBSYWl0aGF0aGEgPHByYWl0
aGF0aGFAbnZpZGlhLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogUHJpdGVzaCBSYWl0aGF0aGEgPHBy
YWl0aGF0aGFAbnZpZGlhLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogQXNoaXNoIE1oZXRyZSA8YW1o
ZXRyZUBudmlkaWEuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUv
YXJtLXNtbXUtbnZpZGlhLmMgfCAyMyArKysrKysrKysrKysrKysrKysrKwo+PiDCoCBkcml2ZXJz
L2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jwqDCoMKgwqDCoMKgwqAgfMKgIDMgKysrCj4+
IMKgIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LmjCoMKgwqDCoMKgwqDCoCB8
wqAgMSArCj4+IMKgIDMgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUtbnZpZGlhLmMgCj4+
IGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUtbnZpZGlhLmMKPj4gaW5kZXgg
MDFlOWI1MGIxMGExLi5iN2EzZDA2ZGEyZjQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUv
YXJtL2FybS1zbW11L2FybS1zbW11LW52aWRpYS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJt
L2FybS1zbW11L2FybS1zbW11LW52aWRpYS5jCj4+IEBAIC0yNTgsNiArMjU4LDI3IEBAIHN0YXRp
YyB2b2lkIG52aWRpYV9zbW11X3Byb2JlX2ZpbmFsaXplKHN0cnVjdCAKPj4gYXJtX3NtbXVfZGV2
aWNlICpzbW11LCBzdHJ1Y3QgZGV2aQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZGV2X25hbWUoZGV2KSwgZXJyKTsKPj4gwqAgfQo+Pgo+PiArc3RhdGljIHZv
aWQgbnZpZGlhX3NtbXVfY2ZnX3Bnc2l6ZV9iaXRtYXAoc3RydWN0IGFybV9zbW11X2RldmljZSAq
c21tdSkKPj4gK3sKPj4gK8KgwqDCoMKgIGNvbnN0IHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBz
bW11LT5kZXYtPm9mX25vZGU7Cj4+ICsKPj4gK8KgwqDCoMKgIC8qCj4+ICvCoMKgwqDCoMKgICog
VGVncmExOTQgYW5kIFRlZ3JhMjM0IFNvQ3MgaGF2ZSB0aGUgZXJyYXR1bSB0aGF0IGNhdXNlcyB3
YWxrIAo+PiBjYWNoZQo+PiArwqDCoMKgwqDCoCAqIGVudHJpZXMgdG8gbm90IGJlIGludmFsaWRh
dGVkIGNvcnJlY3RseS4gVGhlIHByb2JsZW0gaXMgdGhhdCAKPj4gdGhlIHdhbGsKPj4gK8KgwqDC
oMKgwqAgKiBjYWNoZSBpbmRleCBnZW5lcmF0ZWQgZm9yIElPVkEgaXMgbm90IHNhbWUgYWNyb3Nz
IHRyYW5zbGF0aW9uIAo+PiBhbmQKPj4gK8KgwqDCoMKgwqAgKiBpbnZhbGlkYXRpb24gcmVxdWVz
dHMuIFRoaXMgaXMgbGVhZGluZyB0byBwYWdlIGZhdWx0cyB3aGVuIAo+PiBQTUQgZW50cnkKPj4g
K8KgwqDCoMKgwqAgKiBpcyByZWxlYXNlZCBkdXJpbmcgdW5tYXAgYW5kIHBvcHVsYXRlZCB3aXRo
IG5ldyBQVEUgdGFibGUgZHVyaW5nCj4+ICvCoMKgwqDCoMKgICogc3Vic2VxdWVudCBtYXAgcmVx
dWVzdC4gRGlzYWJsaW5nIGxhcmdlIHBhZ2UgbWFwcGluZ3MgYXZvaWRzIHRoZQo+PiArwqDCoMKg
wqDCoCAqIHJlbGVhc2Ugb2YgUE1EIGVudHJ5IGFuZCBhdm9pZCB0cmFuc2xhdGlvbnMgc2VlaW5n
IHN0YWxlIFBNRCAKPj4gZW50cnkgaW4KPj4gK8KgwqDCoMKgwqAgKiB3YWxrIGNhY2hlLgo+PiAr
wqDCoMKgwqDCoCAqIEZpeCB0aGlzIGJ5IGxpbWl0aW5nIHRoZSBwYWdlIG1hcHBpbmdzIHRvIFBB
R0VfU0laRSBvbiAKPj4gVGVncmExOTQgYW5kCj4+ICvCoMKgwqDCoMKgICogVGVncmEyMzQuCj4+
ICvCoMKgwqDCoMKgICovCj4+ICvCoMKgwqDCoCBpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUo
bnAsICJudmlkaWEsdGVncmEyMzQtc21tdSIpIHx8Cj4+ICvCoMKgwqDCoMKgwqDCoMKgIG9mX2Rl
dmljZV9pc19jb21wYXRpYmxlKG5wLCAibnZpZGlhLHRlZ3JhMTk0LXNtbXUiKSkKPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzbW11LT5wZ3NpemVfYml0bWFwID0gUEFHRV9TSVpFOwo+PiAr
fQo+PiArCj4+IMKgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXJtX3NtbXVfaW1wbCBudmlkaWFfc21t
dV9pbXBsID0gewo+PiDCoMKgwqDCoMKgIC5yZWFkX3JlZyA9IG52aWRpYV9zbW11X3JlYWRfcmVn
LAo+PiDCoMKgwqDCoMKgIC53cml0ZV9yZWcgPSBudmlkaWFfc21tdV93cml0ZV9yZWcsCj4+IEBA
IC0yNjgsMTAgKzI4OSwxMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFybV9zbW11X2ltcGwgCj4+
IG52aWRpYV9zbW11X2ltcGwgPSB7Cj4+IMKgwqDCoMKgwqAgLmdsb2JhbF9mYXVsdCA9IG52aWRp
YV9zbW11X2dsb2JhbF9mYXVsdCwKPj4gwqDCoMKgwqDCoCAuY29udGV4dF9mYXVsdCA9IG52aWRp
YV9zbW11X2NvbnRleHRfZmF1bHQsCj4+IMKgwqDCoMKgwqAgLnByb2JlX2ZpbmFsaXplID0gbnZp
ZGlhX3NtbXVfcHJvYmVfZmluYWxpemUsCj4+ICvCoMKgwqDCoCAuY2ZnX3Bnc2l6ZV9iaXRtYXAg
PSBudmlkaWFfc21tdV9jZmdfcGdzaXplX2JpdG1hcCwKPj4gwqAgfTsKPj4KPj4gwqAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBhcm1fc21tdV9pbXBsIG52aWRpYV9zbW11X3NpbmdsZV9pbXBsID0gewo+
PiDCoMKgwqDCoMKgIC5wcm9iZV9maW5hbGl6ZSA9IG52aWRpYV9zbW11X3Byb2JlX2ZpbmFsaXpl
LAo+PiArwqDCoMKgwqAgLmNmZ19wZ3NpemVfYml0bWFwID0gbnZpZGlhX3NtbXVfY2ZnX3Bnc2l6
ZV9iaXRtYXAsCj4+IMKgIH07Cj4+Cj4+IMKgIHN0cnVjdCBhcm1fc21tdV9kZXZpY2UgKm52aWRp
YV9zbW11X2ltcGxfaW5pdChzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNlIAo+PiAqc21tdSkKPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LmMgCj4+IGIvZHJp
dmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuYwo+PiBpbmRleCA1NjhjY2U1OTBjY2Mu
LjM2OTJhMTlhNTg4YSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUv
YXJtLXNtbXUuYwo+PiArKysgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5j
Cj4+IEBAIC0xODcyLDYgKzE4NzIsOSBAQCBzdGF0aWMgaW50IGFybV9zbW11X2RldmljZV9jZmdf
cHJvYmUoc3RydWN0IAo+PiBhcm1fc21tdV9kZXZpY2UgKnNtbXUpCj4+IMKgwqDCoMKgwqAgaWYg
KHNtbXUtPmZlYXR1cmVzICYgQVJNX1NNTVVfRkVBVF9GTVRfQUFSQ0g2NF82NEspCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNtbXUtPnBnc2l6ZV9iaXRtYXAgfD0gU1pfNjRLIHwgU1pf
NTEyTTsKPj4KPj4gK8KgwqDCoMKgIGlmIChzbW11LT5pbXBsICYmIHNtbXUtPmltcGwtPmNmZ19w
Z3NpemVfYml0bWFwKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNtbXUtPmltcGwtPmNm
Z19wZ3NpemVfYml0bWFwKHNtbXUpOwo+IAo+IEknbSBub3QgdGhlIGJpZ2dlc3QgZmFuIG9mIGFk
ZGluZyBhIHN1cGVyLXNwZWNpZmljIGhvb2sgZm9yIHRoaXMsIHdoZW4KPiBpdCBzZWVtcyBsaWtl
IGl0IGNvdWxkIGp1c3QgYXMgZWFzaWx5IGJlIGhhbmRsZWQgaW4gdGhlIGluaXRfY29udGV4dAo+
IGhvb2ssIHdoaWNoIGlzIHdoZXJlIGl0IGlzIHByZWNpc2VseSBmb3IgdGhlIHB1cnBvc2Ugb2Yg
bWFuZ2xpbmcgdGhlCj4gcGd0YWJsZV9jZmcgdG8gaW5mbHVlbmNlIGlvLXBndGFibGUncyBiZWhh
dmlvdXIuCj4gClllcywgd2UgY2FuIHVzZSBpbml0X2NvbnRleHQoKSB0byBvdmVycmlkZSBwZ3Np
emVfYml0bWFwLiBJJ2xsIHVwZGF0ZQp0aGF0IGluIG5leHQgdmVyc2lvbi4KCj4gVGhhbmtzLAo+
IFJvYmluLgo+IAo+PiArCj4+IMKgwqDCoMKgwqAgaWYgKGFybV9zbW11X29wcy5wZ3NpemVfYml0
bWFwID09IC0xVUwpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFybV9zbW11X29wcy5w
Z3NpemVfYml0bWFwID0gc21tdS0+cGdzaXplX2JpdG1hcDsKPj4gwqDCoMKgwqDCoCBlbHNlCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5oIAo+PiBi
L2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LmgKPj4gaW5kZXggMmI5YjQyZmI2
ZjMwLi41ZDliMDMwMjQ5NjkgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1z
bW11L2FybS1zbW11LmgKPj4gKysrIGIvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNt
bXUuaAo+PiBAQCAtNDQyLDYgKzQ0Miw3IEBAIHN0cnVjdCBhcm1fc21tdV9pbXBsIHsKPj4gwqDC
oMKgwqDCoCB2b2lkICgqd3JpdGVfczJjcikoc3RydWN0IGFybV9zbW11X2RldmljZSAqc21tdSwg
aW50IGlkeCk7Cj4+IMKgwqDCoMKgwqAgdm9pZCAoKndyaXRlX3NjdGxyKShzdHJ1Y3QgYXJtX3Nt
bXVfZGV2aWNlICpzbW11LCBpbnQgaWR4LCB1MzIgCj4+IHJlZyk7Cj4+IMKgwqDCoMKgwqAgdm9p
ZCAoKnByb2JlX2ZpbmFsaXplKShzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNlICpzbW11LCBzdHJ1Y3Qg
Cj4+IGRldmljZSAqZGV2KTsKPj4gK8KgwqDCoMKgIHZvaWQgKCpjZmdfcGdzaXplX2JpdG1hcCko
c3RydWN0IGFybV9zbW11X2RldmljZSAqc21tdSk7Cj4+IMKgIH07Cj4+Cj4+IMKgICNkZWZpbmUg
SU5WQUxJRF9TTUVORFjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LTEKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
