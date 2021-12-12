Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E325FC433F5
	for <iommu@archiver.kernel.org>; Sun, 12 Dec 2021 23:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 771A060EDE;
	Sun, 12 Dec 2021 23:34:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IeoK6VRWLbii; Sun, 12 Dec 2021 23:34:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6181560A8E;
	Sun, 12 Dec 2021 23:34:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25E0BC001E;
	Sun, 12 Dec 2021 23:34:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93EAEC0012
 for <iommu@lists.linux-foundation.org>; Sun, 12 Dec 2021 23:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B365402DC
 for <iommu@lists.linux-foundation.org>; Sun, 12 Dec 2021 23:34:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w-09eKo98B26 for <iommu@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 23:34:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::627])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 77041402D3
 for <iommu@lists.linux-foundation.org>; Sun, 12 Dec 2021 23:34:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIVQkiHGhwTzCGqmw6NDN02BbP1tdOo8ccsuZmM6n78S+ZBu54uSpPzNTRrwarOKXkfXmDk/BtW+ODGdPL0molGsrwl6dHEHcMTnOftE79CeCgkLvkYBCAMVVEy7qGxzWc4fdC0xFFPxzdkNSI4x4Nw49hAczpWzBDcE9YG41sthx99Lnq3EavTNxVdLxWU0p2O1yvxHmhChkjpsfM0N97Gib8Scea90fAt+eKvXcsljms3SPr09JZNbPjQL2vm/jwf9cL6iwQL4Dlgm76jUt4sqG1Kfo/UWxC1zbgQoeBdvhi87tSZ5XeWhnfRR0GRXBwmOh68ZkEIED/0KKw7p3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSXm3V4EUDq6ippmmJvI2c2rchvv0sU9WxGskmACnd4=;
 b=nBFaqQO5vd32e2K2v6RwKWFysUIzZaUh7yLAKyEtgOc3jRrB+tFEH/mdBVbISZSAGyUjnzeP9AttVrGqph1m9tr+uEoI+ajnzh0Up6flsTLzUkLBYT3JLZsBIvyY4MrZHPmxMWrjwBPBvQGgJXp0gCS28vbxCxMixBf8KIT+RgWljXmCPKGrE+xtMrIcanYbXSaWIXWBc9bH3x2Cm3INIZKGQgzlVbwVQyJ9g4f8VUJgplvAniUkFHJY+yd2D/XeC+DURRT1/oKVsTVf9jqhBINYMU+w0TEVbk2CkOkrI0Pfj9XAKT1Zsb+m7Ha/SXUoPozoTE3M3GM+8PD1OYo+6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSXm3V4EUDq6ippmmJvI2c2rchvv0sU9WxGskmACnd4=;
 b=q3+5EBNg2NHYLtHnhDJpAT16w2YKmmaWfIw88PrnIZN/925mi+i3sNsEY7+IODheKOVki2sBxXOud/7SDaE/jiiFc0fllGTpziR4iSHHpnYOKrb76ypzUBsE1r03BdnWZgD48OflJC9EqZLHHt8+oBDqzJoNeVFN06q0HwCSRuKBXBS1iDsxuFvHxJliHdcLNc9uLBvCCGVdk3QN7/XmuG6Ex92SoAT87CoU2/3iA+qQnsMHXDwaynBpTI7X152gHe/sufGL4yaV+cnPkUcvSo90ztSxDp9OmpP6QVVTbZesREiC1XSuW1ywAKkQ0u/PE344sqjMA/QnbBSwbm4Gog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Sun, 12 Dec
 2021 23:34:31 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.017; Sun, 12 Dec 2021
 23:34:31 +0000
Date: Sun, 12 Dec 2021 19:34:28 -0400
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 1/4] ioasid: Reserve a global PASID for in-kernel DMA
Message-ID: <20211212233428.GM6385@nvidia.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <YbHie/Z4bIXwTInx@myrica> <20211209101404.6aefbe1c@jacob-builder>
 <YbMYkKZBktlrB2CR@myrica> <20211210123109.GE6385@nvidia.com>
 <20211210100545.373c30d1@jacob-builder>
 <BN9PR11MB5276CDA4303C18369178DECF8C729@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276CDA4303C18369178DECF8C729@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BYAPR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40fe12c8-d9ff-4e4f-4649-08d9bdc7f239
X-MS-TrafficTypeDiagnostic: BL1PR12MB5157:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5157DB83AC9DA7CC2266C042C2739@BL1PR12MB5157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMO1+FPw30kAnVj/ge9gwO2D8VBz5AI4VZOklVOfd0EGLsRA4bM8XAiP4Bt12CbOZNkXwmnR4YdwAAfrL5kVjEBXGUyFRFXsqyDdzK9x/+S0/sA099P2mf67/XGso9TN6cQ9ymjqQpzvsISb/d8d/nW6CsTgVax9cj+PaiJOAfqB+0zfccZ+5HQPlZG8dE9RL13TNlIsHoNEK0A04eKou0BdD63BNzKCkH2pw3H2C+jM9TOj2/5YQc3Mzl1ykVSRR5ttY8dqob4SVLz2PHD3PVK3efZKEIS/iWkqXnL1n5ixEQ0gsn9Ahj7ME1UAoLj1EwpEh2bmZnt/ivuPjfW+W4ZuvlMHdF13FnWzuleBbYTceJrBhdtavzQzThe2BuK8ThK69oqqBdylVRszVn6+Qwsg1nQ4sfX+xXh7t35HZPffQPxyw0UyPukNkZpL2czu8hQX/dql8Y5gCkr0VJN9h3YLttt7TuTvjSkkpziSdIFgDnJNXwioAJaU8NCCYMao8bX6ya48MWZl9wm9h/vxxEdbRHnP6OvyFk38de19YDavATX9toX3bcZ4FNujgOdjDDWLxm1W3HFtdL+jDkWZMRNUmBzRgz7iWBmFu8wQcgkJIyRLXK/fiB2E4PthFjaD1DOPiwTBJLNBUS6n/AE4KQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(66556008)(186003)(26005)(66946007)(66476007)(6486002)(6916009)(2616005)(4744005)(5660300002)(6666004)(1076003)(33656002)(6512007)(83380400001)(8936002)(54906003)(86362001)(36756003)(8676002)(7416002)(316002)(38100700002)(508600001)(2906002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk52bkpsQStpenFCdEliQTRDUkFZL2pKdnhSakR0SngwL0o1V29rdzB4WlZI?=
 =?utf-8?B?UHc1bVlZOVkvUmphT09jbTR6R2gzY1FKT2psRzVRbXBYSDhiclg3UzJMOHQ1?=
 =?utf-8?B?UTZrQmVhRjYrQks1aXlRS3IzZ3paZXVWTnJ4aFIwMlYvZ2FnTDBWc0RSYkdV?=
 =?utf-8?B?c3pyOE9UVExOUWVoQkJycmFJTUtzYXErN0VpaElrU0g1djNNbms0UUEzQkp6?=
 =?utf-8?B?bERlT0xIUlBIN1JmUjhFRllZdXdiYlNKZHFFVjROWHpDUG9iSEF4aHNOMVFw?=
 =?utf-8?B?eWg0NjhiZXdaZjlKYXRXNTl6WmlzY2s3NVdhK3ZmazFIS1ZYQnpxZndoVS9O?=
 =?utf-8?B?VjNQakMvTGYzWEkvUnN0SDY4OFZ0YlVKdnkyLzlJcjlYZWpOK3NxNk5PWHAx?=
 =?utf-8?B?QkV5S1ZPNWU1YWoxemZBQmlxY0llbmVVRkpleVZpWUMrZFJIaDhuK0tOZWtT?=
 =?utf-8?B?ZFZ3VzRpQnJJTFRGeFRmRWdQU292bVlQSCtxRjNLRHZwTzFyNXZTd3NYVUQv?=
 =?utf-8?B?VFltMUNmakg4emFsM1IrQXRkbE8vWnJMNE1lR01Gekxsd1IrRnRZUklFN0U2?=
 =?utf-8?B?MllvOWU4akNFR3FBNFFhdHVmdGdnN3h3aVJJK2hQajB3ZXNobXRzWTlONkRL?=
 =?utf-8?B?N1M5WWVwMDg3bXpFS0lzUnJLYlc0MWRGU21VeGtEaU1LSGpza21JYUNNemxP?=
 =?utf-8?B?dGx2M1NkVGJSNGlZNEQ4SnptVTdsQ3Jpc0hyTmlCcVRsTDJhVSs1aU5yaWhY?=
 =?utf-8?B?bGRCLzhDMnQ5c3JQclpCN281RzZqZ2l0QTl4VkVMUUZQR3NCbG1NMTUyQ0Vt?=
 =?utf-8?B?TTMydUJnK2REQndmRVpreDNGT3FvOTZhSkczZVV4UXV6ZmMxblVtZWhpU2dK?=
 =?utf-8?B?Nzc4bFBaeDh6QXJxTmNBM0hVcGIvZUdRaWdzVUEwWS9tREFCYzEvQUd6R2pS?=
 =?utf-8?B?STVWbEVPTlJnamFhcmNzbDd4dGY5ZXA4ZUlMSXcvaW9XTXNFZ205M3NhUFpj?=
 =?utf-8?B?OW5DblMxK1FRSC91OXkwdC82Wm9ES2NidzhmZm1kNXBQcWs4a1M1TUZRMGlC?=
 =?utf-8?B?RkpiLzVFdkl5ZWJLUVdQdEFYWm5KRmQwZWR2a1NwOHBlOVd0YWQ4amNlT1hF?=
 =?utf-8?B?VHJkNkI3dStTZmUxbnNPRWptVTF4dC8vWEFaTXNzQWdwTVdBVFV4SG9Nc2Fl?=
 =?utf-8?B?SUVOVy9SMHF1K3JQUEJuUjdaNUxWQ2lZbzkrdXJnNnhrSG41cFExOUZNdnFi?=
 =?utf-8?B?aEZjK0xLbjFvVUFWc3NGK3BZMmlZNjZlOTlaMDA4K0hDMkUzRng5OFptcEFk?=
 =?utf-8?B?UlR2bU9GUDh5cUoyNVlZa1M5Rld2V3hCQWladFl4VnVWcUcveDJ5dEpLL2VD?=
 =?utf-8?B?MG5pTk5HTHp5dXVmR2NibFBENTZ4clhCMEZHV1l6U3FRK3VPd3hhaERkdUFa?=
 =?utf-8?B?dEdTTFg2N1JRcEErQTNTUEE4ZHNSYkgvQ1VRaXR0eEtiRTJvQVlnUThCQlRB?=
 =?utf-8?B?eHhXTzMzbzU3VWZGQTAwRlp1TTJWREhYcVc0V2loYzdTL05yS0xDc212MzZh?=
 =?utf-8?B?bnhQNmxEcFN3czRhSmJTVVFWdzRkVk4zeXZmOEJEY1FqOVNuRWxoU1RUS1h2?=
 =?utf-8?B?MnpNOURyU1dRRklKUUVFdE1nN05hMk52QXBWRENwcWRWVHdyMWtERlBXV3lE?=
 =?utf-8?B?aWFORlljT0JCNitiNlBkUVRXSEpyMnRnbUhFK3N6YUVuOXcxZW5xZ01LcGpo?=
 =?utf-8?B?QmhZWjBFQlFLTUVIUXVFZnFqVzdaT1dQbTc4QTVlVjVDcWxzTzdnR1Z6dU55?=
 =?utf-8?B?OENvNzBxTXZ2Z0pvbGI1VElMQ3NpWEY5Z0haY2ZEdHdyV1lIMGlZRERBTkJE?=
 =?utf-8?B?ME5qRVdneWJWY2djaWV4TnRoa3huQjJkLzJCRkkwMEIveTY3NGdHRzlQZUlH?=
 =?utf-8?B?T0dtMjdYWTJHMnBDTndGMkErRU1hUnVVbTFhNUdVNkhyUEpBQ1Z0UXM4MEpV?=
 =?utf-8?B?QWI1bDcrTThVc05paFMvTjN1UmU0dFhQVytuTjBndUFFWlVMdnh6UStOMDlI?=
 =?utf-8?B?UEt3Z1YyeWFrRmtEVG0yUXFDNnpON1FXSWFRL3F1M295NFBTaEQ3RDFUTmdv?=
 =?utf-8?Q?L6GM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fe12c8-d9ff-4e4f-4649-08d9bdc7f239
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2021 23:34:31.1491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p77fnnE5tx/5TZGE2x6PZhCD3L91wI+8AM2P/dAFWtoYZA4Q9aKBVtoEPPeX3vdI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Luck,
 Tony" <tony.luck@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
 Barry Song <21cnbao@gmail.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gU2F0LCBEZWMgMTEsIDIwMjEgYXQgMDg6Mzk6MTJBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3Jv
dGU6Cgo+IFVuaXF1ZW5lc3MgaXMgbm90IHRoZSBtYWluIGFyZ3VtZW50IG9mIHVzaW5nIGdsb2Jh
bCBQQVNJRHMgZm9yCj4gU1dRLCBzaW5jZSBpdCBjYW4gYmUgZGVmaW5lZCBlaXRoZXIgaW4gcGVy
LVJJRCBvciBpbiBnbG9iYWwgUEFTSUQKPiBzcGFjZS4gTm8gU1ZBIGFyY2hpdGVjdHVyZSBjYW4g
YWxsb3cgdHdvIHByb2Nlc3NlcyB0byB1c2UgdGhlCj4gc2FtZSBQQVNJRCB0byBzdWJtaXQgd29y
ayB1bmxlc3MgdGhleSBzaGFyZSBtbSEg8J+Yigo+IAo+IElNTyB0aGUgcmVhbCByZWFzb24gaXMg
dGhhdCBTV1EgZm9yIHVzZXIgU1ZBIG11c3QgYmUgYWNjZXNzZWQgCj4gdmlhIEVOUUNNRCBpbnN0
cnVjdGlvbiB3aGljaCBmZXRjaGVzIHRoZSBQQVNJRCBmcm9tIGEgQ1BVIE1TUgoKVGhpcyByZWFs
bHkgc2hvdWxkIGhhdmUgYmVlbiBpbnNpZGUgYSBjb21tZW50IGluIHRoZSBzdHJ1Y3QgbW0KCiJw
YXNpZCBpcyB0aGUgdmFsdWUgdXNlZCBieSB4ODYgRU5RQ01EIgoKKGFuZCBpZiB3ZSBwaHJhc2Ug
aXQgdGhhdCB3YXkgSSB3b25kZXIgd2h5IGl0IGlzIGluIGEgc3RydWN0IG1tIG5vdApzb21lIHBy
b2Nlc3Mgb3IgdGFzayByZWxhdGVkIHN0cnVjdCwgc2luY2UgaXQgaGFzIG5vdGhpbmcgdG8gZG8g
d2l0aApwYWdlIHRhYmxlcykKCkFuZCwgSU1ITywgdGhlIElPTU1VIHBhcnQgb2YgdGhlIGNvZGUg
c2hvdWxkIGF2b2lkIHVzaW5nIHRoaXMKZmllbGQuIElPTU1VIHNob3VsZCBiZSBhYmxlIHRvIGNy
ZWF0ZSBhcmJpdGFyaWx5IG1hbnkgIlNWQSIKaW9tbXVfZG9tYWlucyBmb3IgdXNlIGJ5IFBBU0lE
IGV2ZW4gaWYgdGhleSBjYW4ndCBiZSB1c2VkIHdpdGgKRU5RQ01ELiBTdWNoIGlzIHByb3BlciBs
YXllcmluZy4KCkphc29uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
