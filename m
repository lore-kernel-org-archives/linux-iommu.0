Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2011.outbound.protection.outlook.com [40.92.103.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D021FA0
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 12:01:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrpYOffFJUQDUSO4ye6vwENlXgHZ02yeRPkhlzo2hzZRiqtcmY5LlIA8Al/95hI9WB0aCdTkth+U7EmcrjEhLQc/reK2oCfQLyviaoKjj8C35jQW8bPKdYde1ftf70OWk3qH9JAAHglKsE6kqflrc8xoH0P5bQqdLvVEjA0bkV/6szf5TYGyqT1WmOxGua5xQmZLPn8npNo0GvZDcme2rb4lQzhSxirSE5oU566KZj75fvwlgEDXt+e+0t5M017wJZCd8OY++EZ7qtxBn8/vUkwqBGBC4ynVLVqNdJpHTuLKQ2TMrb12G6uIQcJDsArpTCena7/dm8Ant/Xov0NyOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpy5no7kzVEyRnSnE37h0NWjcV6feWbHsIVQR1yNCPo=;
 b=CNsQvQBt0JpLPr/2oi/WjDXwYx4TpoTZFukJTzv12o2+QE8yBC1zYoP8vvG13Z/a77OiT6DD8fpajzBYboxMGelzF4A0p4jxIH46ZOnPKIlBmnnJyUr4L8CzlQzz2qojMvPPwbw2lV2DsxLpW9KckLZk7Se6V59QsD1qS9YDAfiJzCdKhj3rynP3sDIkmSrE//BXXt7cwqz7EOsE3Wz1S181IzFvpykGEVKN1jKaJkXArSGuKeUV8dL7FQ+Wj1d3fSOVfp99zrNLFiO0BcXFAvqMkmy8dO+ir7g8jGX6+dgrjNc46HAvGFde/DWxeSnADjzHuwXLM8NfymMSN3veqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpy5no7kzVEyRnSnE37h0NWjcV6feWbHsIVQR1yNCPo=;
 b=UPfWj0NOej853lODCIkG7avDzQAETcghhH7NoAfZZ06al4JkzoMSZYe6VLO5FhvRiPaeMZswgIWe1PKEZ5YFwOipOaYw6xv/dlNWG420sC7Kz3MNEcp6ADiBBMrd2bZtmSgF4dKT/M+UjQJl1kMmjiUy3A86RKnWHpiSVhgqZrGBdPevVWuBEK2JpZev7IH9TjuactTRnqDiXh4AM86srsxB1rtjn0UmQN2XaAeD8FacGd07tpFxi3ICb6RfNbSEA3QoxSJ7CucdwjmXcYv6MtXnwYDiFK/oZjkrbULbjns4B45LEIV011UiYeCRdAc4KDsjcjQDk7/mNKCnrUcuNw==
Received: from MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:49::5)
 by MAZPR01MB7732.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 12:00:58 +0000
Received: from MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2a26:9a6b:6c95:2cdd]) by MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2a26:9a6b:6c95:2cdd%4]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 12:00:57 +0000
Date: Tue, 15 Nov 2022 20:00:56 +0800
From: "leo-hou@hotmail.com" <leo-hou@hotmail.com>
To: robin.murphy <robin.murphy@arm.com>, 
	iommu <iommu@lists.linux.dev>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	virtualization <virtualization@lists.linux-foundation.org>
Cc: will <will@kernel.org>
Subject: Re: Re: The arm smmu driver for Linux does not support debugfs
References: <202211141141302410923@hotmail.com>, 
	<MA0PR01MB5784354703A7B446A6D85CADF6049@MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM>, 
	<9031b28f-0431-22eb-5dd3-01ae0589b940@arm.com>
X-GUID: 5A2D872E-0819-4AE5-8042-C6479B1E6F0B
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.148[cn]
Message-ID:
 <MA0PR01MB5784DE8F3A7437C3B8FB0516F6049@MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
X-TMN: [50HqPjRj657uMwYXzpYrz6nmwGcc+LcJSSqZEtU9in0=]
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:49::5)
X-Microsoft-Original-Message-ID: <202211152000535288226@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB5784:EE_|MAZPR01MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 661bf9a0-656d-485a-a721-08dac7010e34
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m+MQHYBcYtmY6vDzKbvsJXZS7AqrElZcbP78WeF45psaN2wCYBJq2GQR6vg4eBso+cG6lg3C5xZ+1GOQGHaHbL9HzSg6D++n5fowdUsJ4np2ukYArFPe/JV/SiuJqfgGCLx7rM/xWWRVGjw7kqLXI7WyyOT8Sxku3scZt6/3Gtpk3iKSZGo+FJpYO4HKC3SeDSUhczjZZd3fBIpPfdTM+CtxK3CoapTXRMfC9wzA7iwCSzjxbQKY/XbmeAww9VeGv94fC3OjVAipLRpcQj35GwScEtggcNki4HVKKYwgT/1O8ONnfS1CsmDat4MRvR9bsbmQwiuOCJTn66IgEDpO9xkZc0COj2kX0K8C+SEhNS9lnqSw+qYDQylAYiMQBEnvehB7NDXy0ovRdf2e/Ge3lYwhYqFNNtKKyKATgML2rKy8tM+MZR1bwfFQF/4OkRZhK+yCRj2ycgt18Pb0T/neQQJ+OGvYPr06YZbAltxi/J5dJj0vpyyD8FEg7RbUq7xkri5qsDI+pE7ZlAfMVfyea2UHp9/D53pb1BdFptunlWD5F5JGsf2QmHdTtuo2/IzlwKQNDATZx5Bvyg4ZfIkVgEEy0vpnBIV0OMOA9iMA4SmgxVrmkzVCOriyfMvTTD12JRI1oWV+19xqd3Qp52OkHhumHqMBlN8sHNeeVUsLboDonznFFnrWnnHMJa479cy+4bFyEjqzgxRTzdDQmhloQY3jRtmCaCXfv2Cc82vxUx0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWY2MXlDMHdFUlBoTTJrYjYrTkJrY3JTdkVKVFJ1MHlNRURiaUhibGxacFR1?=
 =?utf-8?B?NTZGZEV0VVFNMHpKNVJEZGpxa2w3QWNOOFB1VkI2ajRsOXgrNHJYZHNjV3d2?=
 =?utf-8?B?cTVZYVcvVzJ3b3RFcDdlMEZ2ZlhLeEp2TmFnTEZnbEZDRko4MWU2NTFlaDdE?=
 =?utf-8?B?eTBuSUR1aFJEakR4YVNOK2lCd3lHMThuYUVOOTlSanBRY0Y5dSs4T2pKQnB3?=
 =?utf-8?B?eHFNcU5UUFN4M0x0ZTJWS1NkeFBFN003RDAxZXVob2NjdnYwVHVncXRXS2Q2?=
 =?utf-8?B?NURBbGlhem1zSk5UUncwUHpqYUY0YU53bzFCUENtUVlnT0lYNEFXaHowSHZz?=
 =?utf-8?B?TkRnb0FveDM0TE11NkkzUVREcGx4ZEMwYmxsMW5aYXdnczJtMEdsOG05VW5a?=
 =?utf-8?B?T3JmdFNLZzVrcWNRZUd4RU9xQnRlTjd1U1pBZW0rdk9RWUZIL0IwRTd3TmFp?=
 =?utf-8?B?NTMrczJUQzNXckk2UGpMNWNLaWpaZmc1WEVEMTZ6RVgrcjZ6ZWFZRERvY0dw?=
 =?utf-8?B?UjFkZG1ZeUdIdlJ0a0kxbzlNallDayt1SEpQV0RIUTU1TGpIOUdUSXRQSFlM?=
 =?utf-8?B?TkFnYzZ3M1NwRUtLSlhjMzExWE40Q3VERkNXS08yNUYrd1Z1NHNlazRIaCtk?=
 =?utf-8?B?SDlqUmlLaEpqMkoyODlOUFQwQkczQVdhUnpOVGJoY1BpckNwZHhweU5RUWpX?=
 =?utf-8?B?eXMzaE9LVmw1NGNzSmNRWVpzdGpDQnFsMGN2VjZya1VNWEJUdDhmbUJZNytn?=
 =?utf-8?B?UC83NFNlekx1R1B6QWhlNmo2Sk9mNGp0M0R3dUxnelUvQlBMUFA5RDR6NWtq?=
 =?utf-8?B?V2lhek9oeTFMWUpiQS9pcFk0Tk1yU2djVHVzSlp3clk3M3FyYjZjNWJwYWxO?=
 =?utf-8?B?NE1ubFJwS0hQcTlISEVxTDEzTTdPZlRRL2xaY3Z3U1hvbFhIRFBSUE5TMTNz?=
 =?utf-8?B?cGxMdS9rZ1F6RXRYblArRGxIUzZjbDJlVmJyVVZtZmxhOGdMQk1YUmN5blNr?=
 =?utf-8?B?QkdVU2xzdng4L0VkSkJsaTdXRm1LVmFCNEFsOTNpS0VESnlRTm5lZklLb1kr?=
 =?utf-8?B?aWQvMFgyb29ZcXdIZ2hLejFrMC9HMjBDaFdMbTQ5MW0ra2NoSVhZb25UNmFR?=
 =?utf-8?B?d3VGYVNzZExmOFNKYlVvcmRYVmxUTi9HTnNra3hyWkxyNWNkOXNaaUJCbG8z?=
 =?utf-8?B?SFlXQkJQU1E4Z1NxeklpbFBEaUM4TXdJY3ZHV1lnZGZzYnBoQ2NWUUUwNUlP?=
 =?utf-8?B?ZXYyaG5WcWFhOVNDSmFZcHZ0V0FWeHBuV3BKMjZpVU11TWhVanI0TXFOZGxr?=
 =?utf-8?B?ajlqLzlyMkRtZjZlWHB1bEJzMmR0MThZZG41WGV4NUZBMzhtYkFwZHBMZnI1?=
 =?utf-8?B?K3k2Ri9JbVl0eGJwUkdYanplRTNFL0pQY1dkM0dLcm0xY25NbUQvV1NGa0tT?=
 =?utf-8?B?dzRxOTZRT1EwM0ZjOVUvWU1CaFNBci9RUEI5Qzg2QjdqczluWVN5RWRlK3ls?=
 =?utf-8?B?ZkpPcmdlUzBjNFZieVgxTzRmSUs2RGtiQjMraGNtQU5jL203YVJHMW9Wc2Uz?=
 =?utf-8?B?WWk0L1BOVGFvZ2labDhha25rT25KOGxNODFzU2xNOXRjZ2xvS2t0QmVyNjVq?=
 =?utf-8?B?Uk5sNzhZUVBoM0RvSWpJS01uRGx2aWdzdHFHbTJqeVE5Mm1aV2MraG80TXJo?=
 =?utf-8?B?TTJPRGcwbHVURzhTbHZSY0tkQllMSkJmUU1jQlprRENCRGR2ZFQ3UGF3PT0=?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 661bf9a0-656d-485a-a721-08dac7010e34
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB5784.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 12:00:57.9041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7732

T24gMjAyMi0xMS0xNSAxOToyMCArMDgwMCwgIFJvYmluIE11cnBoeTxyb2Jpbi5tdXJwaHlAYXJt
LmNvbT4gIHdyb3RlOgoKCgo+T24gMjAyMi0xMS0xNSAwMjoyOCwgbGVvLWhvdUBob3RtYWlsLmNv
bSB3cm90ZToKCj4KCj4+Cj4+Cj4+IEhpLAo+Pgo+PsKgIMKgwqDCoMKgIFdoeSBkb2Vzbid0IHRo
ZSBhcm0gc21tdSBkcml2ZXIgZm9yIExpbnV4IHN1cHBvcnQgZGVidWdmcyA/Cgo+Cj5CZWNhdXNl
IG5vYm9keSdzIGV2ZXIgd3JpdHRlbiBhbnkgZGVidWdmcyBjb2RlIGZvciBpdC4KCj4KPj4gQXJl
IHRoZXJlIGFueSBoaXN0b3JpY2FsIHJlYXNvbnM/Cgo+Cj5Pbmx5IHRoYXQgc28gZmFyIG5vYm9k
eSdzIG5lZWRlZCB0by4KCj4KPlRCSCwgYXJtLXNtbXUgaXMgYWN0dWFsbHkgcXVpdGUgc3RyYWln
aHRmb3J3YXJkLCBhbmQgbm9uZSBvZiB0aGUKCj5pbnRlcm5hbCBkcml2ZXIgc3RhdGUgaXMgcmVh
bGx5IGFsbCB0aGF0IGludGVyZXN0aW5nIChvdGhlciB0aGFuIHRoZQoKPnNwZWNpYWwgcHJpdmF0
ZSBBZHJlbm8gc3R1ZmYsIGJ1dCB3ZSBsZWF2ZSBpdCB1cCB0byBSb2IgdG8gaW1wbGVtZW50Cj53
aGF0ZXZlciBoZSBuZWVkcyB0aGVyZSkuIEdpdmVuIHRoZSBrZXJuZWwgY29uZmlnLCBtb2R1bGUg
cGFyYW1ldGVycywKPmFuZCB0aGUgZmVhdHVyZXMgbG9nZ2VkIGF0IHByb2JlLCB5b3UgY2FuIGFs
cmVhZHkgaW5mZXIgaG93IGl0IHdpbGwgc2V0Cgo+dXAgY29udGV4dCBiYW5rcyBldGMuIGZvciBy
ZWd1bGFyIElPTU1VIEFQSSB3b3JrOyB0aGVyZSB3b24ndCBiZSBhbnkKCj5zdXJwcmlzZXMuIEF0
IHRoaXMgcG9pbnQgdGhlcmUgc2hvdWxkbid0IGJlIGFueSBuZWVkIHRvIGRlYnVnIHRoZSBkcml2
ZXIKCj5pdHNlbGYsIGl0J3MgbWF0dXJlIGFuZCBzdGFibGUuIEZvciBkZWJ1Z2dpbmcgKnVzZXJz
KiBvZiB0aGUgZHJpdmVyLAoKPkkndmUgb25seSBkZWFsdCB3aXRoIHRoZSBETUEgbGF5ZXIsIHdo
ZXJlIGEgY29tYmluYXRpb24gb2YgdGhlIElPTU1VIEFQSQoKPnRyYWNlcG9pbnRzLCBDT05GSUdf
RE1BX0FQSV9ERUJVRywgYW5kIG15IG93biBoYWNrcyB0byBpb21tdS1kbWEgaGF2ZQoKPmFsd2F5
cyBwcm92ZWQgc3VmZmljaWVudCB0byBnZXQgZW5vdWdoIGluc2lnaHQgaW50byB3aGF0J3MgYmVp
bmcgbWFwcGVkCgo+d2hlcmUuCgo+Cj5JIHRoaW5rIGEgY291cGxlIG9mIHBlb3BsZSBoYXZlIHBy
ZXZpb3VzbHkgcmFpc2VkIHRoZSBpZGVhIG9mCgo+aW1wbGVtZW50aW5nIHNvbWUga2luZCBvZiBk
ZWJ1Z2ZzIGR1bXBpbmcgZm9yIGlvLXBndGFibGUsIGJ1dCBub3RoaW5nJ3MKCj5ldmVyIGNvbWUg
b2YgaXQuIEFzIGFib3ZlLCBpdCBvZnRlbiB0dXJucyBvdXQgdGhhdCB5b3UgY2FuIGZpbmQgdGhl
Cgo+aW5mb3JtYXRpb24geW91IG5lZWQgZnJvbSBvdGhlciBleGlzdGluZyBzb3VyY2VzLCB0aHVz
IHRoZSBlZmZvcnQgb2YKCj5pbXBsZW1lbnRpbmcgYW5kIG1haW50YWluaW5nIGEgbG9hZCBvZiBz
cGVjaWFsLXB1cnBvc2UgZGVidWcgY29kZSBjYW4gYmUKCj5zYXZlZC4gSW4gcGFydGljdWxhciBp
dCB3b3VsZCBub3QgYmUgd29ydGggaGF2aW5nIGRyaXZlci1zcGVjaWZpYyBjb2RlCgo+dGhhdCBv
bmx5IGhlbHBzIGRlYnVnIGdlbmVyaWMgSU9NTVUgQVBJIHVzYWdlIC0gdGhhdCB3b3VsZCBiZSBt
dWNoCgo+YmV0dGVyIGltcGxlbWVudGVkIGF0IHRoZSBnZW5lcmljIElPTU1VIEFQSSBsZXZlbC4K
CgoKClRoYW5rcyBmb3IgeW91ciByZXBseSwgbGV0IG1lIGtub3cgdGhhdC4KCgoKTGVvLgoKCg==
