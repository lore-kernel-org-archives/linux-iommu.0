Return-Path: <SRS0=3kXM=IU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B693C433DB
	for <iommu@archiver.kernel.org>; Mon, 22 Mar 2021 12:03:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE9D76191D
	for <iommu@archiver.kernel.org>; Mon, 22 Mar 2021 12:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9D76191D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8A0B64020B;
	Mon, 22 Mar 2021 12:03:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y-ig3QdmQd0x; Mon, 22 Mar 2021 12:03:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 615E040209;
	Mon, 22 Mar 2021 12:03:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D751C000B;
	Mon, 22 Mar 2021 12:03:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A070AC0001
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 12:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8ABC582E90
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 12:03:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eYfuuKN8t1Af for <iommu@lists.linux-foundation.org>;
 Mon, 22 Mar 2021 12:03:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF63782D03
 for <iommu@lists.linux-foundation.org>; Mon, 22 Mar 2021 12:03:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwYPGpkj44TYv+dg3xJbDWHMrNAgK7Ld3qNgEMUifygEIzlBcTbTN7v6xMp6NPXmYBd5tfKLoeEty6QOQwliVr7PA3R+th673EV1wImMGlCJKevlvTcYrz2lDOl71yloALG4TpjsHrC/pzGkA0T00KADeahSfXv0sLAkNzuuB09co0WexeYlzJWH2mmADKr2WfjuGISnAAoIg/xd1fnUN5612gFm7nOMzCxB4k+1ySc2vPizYXdt611+jS8kv3AXjTC6TuOG4HevWrwN308FdiQNA1TJb+okkMUd9R2G2RJryLwaElVjA1Qo/cWJd8Kxk3+izM1pnDtnFnkFjhLI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nzn01HrZRrwKwV0UIRm7mXB+Hx5h/+0Svn2iOOF3wM=;
 b=kE8K9sB1tnmz6/UGryrcpMPjWrklJF8LnXoZgoB7lUElGEZIdoSeAI/72BNy/oQ5pzaG2HGs3itHSrVqhPr2ko0vaQXKlTB2ulFN2WVej9KgVrVuGUR5At9cqG/eORjoAoUk9JGbss8+k18c5IDz8NcnworKKjKN8Ra0VdEdf6mNfLxU3E+kFWyByH4Gf1rwxSgs6Owxs6DVUCWJO8Yrr6BeOzvbo0Y+yvtE+Cu6LVJdl7H3Iry1VxMQMpKWLBMhulSs5V7V2Eqerr+Qlu+b7b432lYuP2MzIGkL6eYXqohMPAYnv1oQW01FfXwf6HXMN2dYMM0ogfqwRSGHk3IHOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nzn01HrZRrwKwV0UIRm7mXB+Hx5h/+0Svn2iOOF3wM=;
 b=Awv7I16VB9PBbqCllrddC1HBoNjg/I7JnRN5KKKk6C12wdfMr0NBkl1ylMJhyMHZnAvKMVJ9QooxDmQ0GF7jhFauFPB2Ao5Uft+VpXHxkKFf5TRbYWBtaFGa0K9PmhhjzeyFtc+ODR3AG9Fw3TTtmXJDk6eRNnTHToupP/divexZknR9ATV5WN4HoZDxlKAXTCAzwVXe9BX07M8GLDXX2SRqsFI1HULxIWOXlnkMKUj5+qbETvkZdu7JTn6O55zd9DCTBv38ZX8YDoQkQw6tqHEBGgkPVYdtO6P6qwVZ+aeBfyLFcIci16R6DCra7+ARXB5fFQzL6ruf5I/SLiSwnw==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none; linux.intel.com; dmarc=none action=none header.from=nvidia.com; 
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2811.namprd12.prod.outlook.com (2603:10b6:5:45::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 12:03:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 12:03:03 +0000
Date: Mon, 22 Mar 2021 09:03:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210322120300.GU2356281@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder> <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com>
 <20210319112221.5123b984@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20210319112221.5123b984@jacob-builder>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR16CA0006.namprd16.prod.outlook.com
 (2603:10b6:208:134::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 MN2PR16CA0006.namprd16.prod.outlook.com (2603:10b6:208:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Mon, 22 Mar 2021 12:03:02 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lOJGu-000vZZ-UJ; Mon, 22 Mar 2021 09:03:00 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ebaba6d-589a-452d-5466-08d8ed2a718f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2811:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2811A39541451A9096F68FCBC2659@DM6PR12MB2811.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQjcTGUxPWDxE53ckoXtH6M4cjcM2pfUymA1OktBoKm3QC4KlkHZuhN07MV6eN6XNDRagGo8vW5UFzfee1NjH0JMNPUIu2exN2QbtsO5Xi2dyNT2XFMgL3lkZF5orCJkp6nYhfoEQ2mmFjym+1o66sFOp1gkPHV+9MtqqjuXROf8kg9YlY4NaG8CQUNDp6/W/CRuswqOFhwpHa6qg/9GIKAwZvg7XO6bkcr52C3bHIUgYUD/a4nnccSgODovVQljWRmpFA0x10LNz0QoujgjLBSiYgjoiDcCkx/7w/4UJP6oTZwOKwDl8gNqcm7cClRTklCkOHfC2YuI6RMUKg+NSlUakcLPxp4KLhYuPshOyXyLpPb7+4uzSVRHOKlevAhPIT2hBbj1Gpq0/ASdbFQTejaIILsW1cQ6ZEHzTIs6vZLuImoRlMcveM6SILUWY6bq/MHlwXIovtETgI8fCgJo5ty07gOTuA6fQ0T1+Jf14ef2hJhLWSDypSbms1a4kyU8z3HQpQOE7xvE5ux/E7l5G6ZZJZNls6ozpbo06yzcsHjZKL2N7AucBj3iAKMXvJYSbD9t7VWP/bIfNrz6pdUKAoqgsqaerWig0OZLLNXAetWVWd7nDxWU4vsSPItgxL3W2ITQBH2Q8rD6cNT0mzb2FsaZFuyfQ3yZoP/tPNnHPzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(478600001)(33656002)(66476007)(8936002)(86362001)(9746002)(5660300002)(26005)(186003)(9786002)(83380400001)(4326008)(1076003)(54906003)(66556008)(316002)(2906002)(2616005)(36756003)(38100700001)(66946007)(426003)(6916009)(7416002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cHlYcUIvTitSUHIwZE9iU3dGZS82RzFXbUpuV0dyOXZqSEhOQlowZEdWSHVu?=
 =?utf-8?B?eWIrcjI0bVVzb3ZkVDZyWHBIZkFRa2twb2dkbTQwN2Y1VEtXeXc2NUliQ04r?=
 =?utf-8?B?Z3kwZ1A4V2pNMTNWdUl0RzJqQkNqMUdkZEo0Mkx2QVl3RCs3OHZmTDhVRXZ4?=
 =?utf-8?B?RGJxdklza0Y3Y0ZoUmJRbWc2MWs2elh3aFpPVWZaajRqdC9laWtCUWFybThh?=
 =?utf-8?B?UEhuMkluVldBK3dhUjgveDM3L0JCMEY5b1A2OUpQWWRxb2VHTXdBWmJpRktW?=
 =?utf-8?B?YTAzODRKbDV2RFpxTVREbWlkYnQvdm91NkJjWXFUYWJWTTM5L1oxdVU0QVBO?=
 =?utf-8?B?aERwVGNNNldFMXhYd0djT0dFWmlZSHlRT2JtRlh4bDE2aGJvN0ZkcHYxM1hm?=
 =?utf-8?B?TU5ZMUlyckdMa2czRWJGd21XajR4bkJsdTJhL0MxMytudDQ1d2FHdWtKR1BD?=
 =?utf-8?B?K2V6c3ZmaWlvYUhwTXFwRFN2c3pEdnd0L1pzZm42bVpicEN5TnJxZTVXbXE5?=
 =?utf-8?B?MEVtNWZCUU41cGZUY1g1bUtLNGxTSnRBdzhQbVpwWDdvYWVCMlZ2QkkvSUZk?=
 =?utf-8?B?MHRPMVdRZFB4QWYxQTFoMTR5OUJremNnck5RK2V6TXpKZjB0b1crMVZWSzBJ?=
 =?utf-8?B?amVCMm5vNjh4eWFHUEtMY1IxSHV2NlltbDVLa0RJVVpMMlo0OGtxZGxxemhP?=
 =?utf-8?B?RE9WWXNOSjBaK3dJRjJ6bWg3ZVlGeW5XWHBadDhZQmVVUlA5Y0lyOGlxQWlM?=
 =?utf-8?B?SjRzRUxEcVdFRlRybExzRlN1QU8zbU5YSXBSK3Z4dzB5ajhselJackxtTzNq?=
 =?utf-8?B?ZGF1a253RFpXTmJIM3h6eERZWXZmb1R0N1dvRjlGU0s5bjcwUFNHSnRjM3dt?=
 =?utf-8?B?SXRSa2l0VzJzaU5YeVdTcHdBVGlETklsaXc2Vm1ZdnVqa054NzhBRCtlYUYx?=
 =?utf-8?B?VE5mQzBFK2JDeW4vQnA2MG5ZbFkzVndLZU5RQ1pDMEtIMHRyUzh4c3ZjN1l5?=
 =?utf-8?B?K0dEVUNRYW5sMUxFbjhFZmFsQnY3TVM1QkwvMGxjWVNhQzg0dEZGVmtKV21F?=
 =?utf-8?B?bnp5WWJaNmN0OWsySWJ4ZHpOaGpLdEVvMk41R2kxWjV6Q0F4VllZZU5XaVph?=
 =?utf-8?B?ck4xQWY3UndCWnVjQU41UDVDVVNnVWY3dENRUVdCVC8vakNEWVdIWm5CV2xo?=
 =?utf-8?B?YzQ1MURyb2lrRWlCRndYRWZTTGZMK0daQlFtNEJNbDIxN3FoMzNyTFZaZmxi?=
 =?utf-8?B?ZDZ3STdrcHY5ZXFaWVVIWG9sU3M2WXF3RFRxbENDRCtabzJOZzE4MnNtOGVV?=
 =?utf-8?B?elVGbk9FYXRzTmNoMW85dDRHc2g3WTAxaTUvYk5UWUVhenZadGhVSUNLU3I3?=
 =?utf-8?B?RjhEUVQ0WENpZjZIeGFUNGxKZTIrQVNuaGF6N2pWOFI2Ynl3ZTRJODI4cFNJ?=
 =?utf-8?B?ZGhSaUxqem96ZmUyR3J3QTB3cVRZSm9qRlhmQmJBbm9oODZzUktkeUpLbTR4?=
 =?utf-8?B?TndJUG9nMlRFRjlxMlRQd2pJczR4VGZ3SmhCYVprK0NqNngwUlFtVlpuNU5X?=
 =?utf-8?B?cjc2ajNJdHM0aFgxTG5QVnIyeFV0ZEdxMGFaN09ZdkVkREZaUnQwYTM1ZHFV?=
 =?utf-8?B?UnE2QTJzVStUTEZodmlOckIzdEZ3SHprOW1hODdYblRod0tLQmJ3Q1NSNlE1?=
 =?utf-8?B?b2hEWE5TcFp0eFdlM0wvc0FVL1d3dFdKT1BnWStNREp4MVh3UVhhKzNncW9l?=
 =?utf-8?Q?Jlvu7oBAlUNr0dtn1aC9kT0b1VZFdd2pmV3B8bi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebaba6d-589a-452d-5466-08d8ed2a718f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 12:03:03.0568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrkWhgGN6D+mqitpSgiz5ACxHaqjL+EoUhwwYZ1Rc1oUw1bbKWfUd6dhpX5HVKUk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Li Zefan <lizefan@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 cgroups@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gRnJpLCBNYXIgMTksIDIwMjEgYXQgMTE6MjI6MjFBTSAtMDcwMCwgSmFjb2IgUGFuIHdyb3Rl
Ogo+IEhpIEphc29uLAo+IAo+IE9uIEZyaSwgMTkgTWFyIDIwMjEgMTA6NTQ6MzIgLTAzMDAsIEph
c29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+IHdyb3RlOgo+IAo+ID4gT24gRnJpLCBNYXIg
MTksIDIwMjEgYXQgMDI6NDE6MzJQTSArMDEwMCwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3Rl
Ogo+ID4gPiBPbiBGcmksIE1hciAxOSwgMjAyMSBhdCAwOTo0Njo0NUFNIC0wMzAwLCBKYXNvbiBH
dW50aG9ycGUgd3JvdGU6ICAKPiA+ID4gPiBPbiBGcmksIE1hciAxOSwgMjAyMSBhdCAxMDo1ODo0
MUFNICswMTAwLCBKZWFuLVBoaWxpcHBlIEJydWNrZXIgd3JvdGU6Cj4gPiA+ID4gICAKPiA+ID4g
PiA+IEFsdGhvdWdoIHRoZXJlIGlzIG5vIHVzZSBmb3IgaXQgYXQgdGhlIG1vbWVudCAob25seSB0
d28gdXBzdHJlYW0KPiA+ID4gPiA+IHVzZXJzIGFuZCBpdCBsb29rcyBsaWtlIGFtZGtmZCBhbHdh
eXMgdXNlcyBjdXJyZW50IHRvbyksIEkgcXVpdGUKPiA+ID4gPiA+IGxpa2UgdGhlIGNsaWVudC1z
ZXJ2ZXIgbW9kZWwgd2hlcmUgdGhlIHByaXZpbGVnZWQgcHJvY2VzcyBkb2VzCj4gPiA+ID4gPiBi
aW5kKCkgYW5kIHByb2dyYW1zIHRoZSBoYXJkd2FyZSBxdWV1ZSBvbiBiZWhhbGYgb2YgdGhlIGNs
aWVudAo+ID4gPiA+ID4gcHJvY2Vzcy4gIAo+ID4gPiA+IAo+ID4gPiA+IFRoaXMgY3JlYXRlcyBh
IGxvdCBjb21wbGV4aXR5LCBob3cgZG8gZG9lcyBwcm9jZXNzIEEgZ2V0IGEgc2VjdXJlCj4gPiA+
ID4gcmVmZXJlbmNlIHRvIEI/IEhvdyBkb2VzIGl0IGFjY2VzcyB0aGUgbWVtb3J5IGluIEIgdG8g
c2V0dXAgdGhlIEhXPyAgCj4gPiA+IAo+ID4gPiBtbV9hY2Nlc3MoKSBmb3IgZXhhbXBsZSwgYW5k
IHBhc3NpbmcgYWRkcmVzc2VzIHZpYSBJUEMgIAo+ID4gCj4gPiBJJ2QgcmF0aGVyIHRoZSBzb3Vy
Y2UgcHJvY2VzcyBlc3RhYmxpc2ggaXRzIG93biBQQVNJRCBhbmQgdGhlbiBwYXNzCj4gPiB0aGUg
cmlnaHRzIHRvIHVzZSBpdCB0byBzb21lIG90aGVyIHByb2Nlc3MgdmlhIEZEIHBhc3NpbmcgdGhh
biB0cnkgdG8KPiA+IGdvIHRoZSBvdGhlciB3YXkuIFRoZXJlIGFyZSBsb3RzIG9mIHNlY3VyaXR5
IHF1ZXN0aW9ucyB3aXRoIHNvbWV0aGluZwo+ID4gbGlrZSBtbV9hY2Nlc3MuCj4gPiAKPiAKPiBU
aGFuayB5b3UgYWxsIGZvciB0aGUgaW5wdXQsIGl0IHNvdW5kcyBsaWtlIHdlIGFyZSBPSyB0byBy
ZW1vdmUgbW0gYXJndW1lbnQKPiBmcm9tIGlvbW11X3N2YV9iaW5kX2RldmljZSgpIGFuZCBpb21t
dV9zdmFfYWxsb2NfcGFzaWQoKSBmb3Igbm93Pwo+IAo+IExldCBtZSB0cnkgdG8gc3VtbWFyaXpl
IFBBU0lEIGFsbG9jYXRpb24gYXMgYmVsb3c6Cj4gCj4gSW50ZXJmYWNlcwl8IFVzYWdlCXwgIExp
bWl0CXwgYmluZMK5IHxVc2VyIHZpc2libGUKPiAvZGV2L2lvYXNpZMKyCXwgRy1TVkEvSU9WQQl8
ICBjZ3JvdXAJfCBObwl8WWVzCj4gY2hhciBkZXbCswl8IFNWQQkJfCAgY2dyb3VwCXwgWWVzCXxO
bwo+IGlvbW11IGRyaXZlcgl8IGRlZmF1bHQgUEFTSUR8ICBubwkJfCBObwl8Tm8KPiBrZXJuZWwJ
CXwgc3VwZXIgU1ZBCXwgbm8JCXwgeWVzICAgfE5vCj4gCj4gwrkgQWxsb2NhdGVkIGR1cmluZyBT
VkEgYmluZAo+IMKyIFBBU0lEcyBhbGxvY2F0ZWQgdmlhIC9kZXYvaW9hc2lkIGFyZSBub3QgYm91
bmQgdG8gYW55IG1tLiBCdXQgaXRzCj4gICBvd25lcnNoaXAgaXMgYXNzaWduZWQgdG8gdGhlIHBy
b2Nlc3MgdGhhdCBkb2VzIHRoZSBhbGxvY2F0aW9uLgoKV2hhdCBkb2VzICJub3QgYm91bmQgdG8g
YSBtbSIgbWVhbj8KCklNSE8gYSB1c2UgY3JlYXRlZCBQQVNJRCBpcyBlaXRoZXIgYm91bmQgdG8g
YSBtbSAoY3VycmVudCkgYXQgY3JlYXRpb24KdGltZSwgb3IgaXQgd2lsbCBuZXZlciBiZSBib3Vu
ZCB0byBhIG1tIGFuZCBpdHMgcGFnZSB0YWJsZSBpcyB1bmRlcgp1c2VyIGNvbnRyb2wgdmlhIC9k
ZXYvaW9hc2lkLgoKSSB0aG91Z2h0IHRoZSB3aG9sZSBwb2ludCBvZiBzb21ldGhpbmcgbGlrZSBh
IC9kZXYvaW9hc2lkIHdhcyB0byBnZXQKYXdheSBmcm9tIGVhY2ggYW5kIGV2ZXJ5IGRldmljZSBj
cmVhdGluZyBpdHMgb3duIFBBU0lEIGludGVyZmFjZT8KCkl0IG1heWJlIHNvbWV3aGF0IHJlYXNv
bmFibGUgdGhhdCBzb21lIGRldmljZXMgY291bGQgaGF2ZSBzb21lIGVhc3kKJ21ha2UgYSBTVkEg
UEFTSUQgb24gY3VycmVudCcgaW50ZXJmYWNlIGJ1aWx0IGluLCBidXQgYW55dGhpbmcgbW9yZQpj
b21wbGljYXRlZCBzaG91bGQgdXNlIC9kZXYvaW9hc2lkLCBhbmQgYW55dGhpbmcgY29uc3VtaW5n
IFBBU0lECnNob3VsZCBhbHNvIGhhdmUgYW4gQVBJIHRvIGltcG9ydCBhbmQgYXR0YWNoIGEgUEFT
SUQgZnJvbSAvZGV2L2lvYXNpZC4KCj4gQ3VycmVudGx5LCB0aGUgcHJvcG9zZWQgL2Rldi9pb2Fz
aWQgaW50ZXJmYWNlIGRvZXMgbm90IG1hcCBpbmRpdmlkdWFsIFBBU0lECj4gd2l0aCBhbiBGRC4g
VGhlIEZEIGlzIGF0IHRoZSBpb2FzaWRfc2V0IGdyYW51bGFyaXR5IGFuZCBib25kIHRvIHRoZSBj
dXJyZW50Cj4gbW0uIFdlIGNvdWxkIGV4dGVuZCB0aGUgSU9DVExzIHRvIGNvdmVyIGluZGl2aWR1
YWwgUEFTSUQtRkQgcGFzc2luZyBjYXNlCj4gd2hlbiB1c2UgY2FzZXMgYXJpc2UuIFdvdWxkIHRo
aXMgd29yaz8KCklzIGl0IGEgZ29vZCBpZGVhIHRoYXQgdGhlIEZEIGlzIHBlciBpb2FzaWRfc2V0
ID8gV2hhdCBpcyB0aGUgc2V0IHVzZWQKZm9yPwoKVXN1YWxseSBrZXJuZWwgaW50ZXJmYWNlcyB3
b3JrIG5pY2VyIHdpdGggYSBvbmUgZmQvb25lIG9iamVjdCBtb2RlbC4KCkJ1dCBldmVuIGlmIGl0
IGlzIGEgc2V0LCB5b3UgY291bGQgcGFzcyB0aGUgc2V0IGJldHdlZW4gY28tb3BlcmF0aW5nCnBy
b2Nlc3NlcyBhbmQgdGhlIFBBU0lEIGNhbiBiZSBjcmVhdGVkIGluIHRoZSBjb3JyZWN0ICdjdXJy
ZW50Jy4gQnV0CnRoZXJlIGlzIGFsbCBraW5kcyBvZiBzZWN1cml0eSBxdWVzdHNpb25zIGFzIHNv
b24gYXMgeW91IHN0YXJ0IGRvaW5nCmFueXRoaW5nIGxpa2UgdGhpcyAtIGlzIHRoZXJlIHJlYWxs
eSBhIHVzZSBjYXNlPwoKSmFzb24KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
