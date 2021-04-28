Return-Path: <SRS0=OzJ+=JZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B75C433ED
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 20:46:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 685D3613CE
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 20:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685D3613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE24A84418;
	Wed, 28 Apr 2021 20:46:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A2Pa84OIkHqy; Wed, 28 Apr 2021 20:46:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDB4684319;
	Wed, 28 Apr 2021 20:46:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B944C000D;
	Wed, 28 Apr 2021 20:46:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AACF5C0001
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 20:46:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C18160723
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 20:46:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1JCAIwJfNR4A for <iommu@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 20:46:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe46::60f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3BD1605CF
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 20:46:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2D9tPDKMugaIFPrRbGp25O5k1H/Kp2cavKEpCFkQ35WYjgAUze2q7UWWiYIaAYN6/3ZiYoOMRB+DiayTRCTHuoNkvR47MegnRKJsL/cLG2v08636uHjTs/OTAUYxbHIaf54gAmcbFPNqcIetnEdobgEzpqfdYZt7g9f/ZmNVGFBAuIBaVyYSmR9qNdRiDDuBQY58N/TtgcGz4qBbtU8gC/uApgWoVzQ0fTvHrnLJSVap4dv2NTKB1FvUCnzwJ/FsZfPOU7pHwNQWCWNp+/t/IVgqYgQ5tp9TS0dIkzgROL2xN0Ls7yvU6EvGGHHjbRtTj9boSwEiqjXFEDAW2N03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fKpv9xAO7yDUmDQhi8eE8dYVFyldocMXHvUmN6E/Mc=;
 b=Z2Md2itxfePyUmCyen7btdCSZzWHhxWEcupd7DyzgAlIRmak4HI24MEQLtq1zegxk3UM6km4lLVRq6z45ZqzKKYq7/fNN8ORTq1AONuKkNEkGJpdvuSa0ZFs/hqXLug5Ry3d6DyBWl9PHC7GtQaJNvYuXU0pVPYcEJp662DLWifklEDxqrMP1SxEgMHC98U75DHJLTGUG1IopIKZNIakV2R6SSGfkngfvg5GqYelHIibSxadvBmgJ/BcsBUn+stRMZkPCPufgs+S5fA8YyeRDUWa6/pkj+cgX6LLjVM1yXnUkcE7dekk+s+7JehmEctBswynvPAPGN2oSSDaduDVYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fKpv9xAO7yDUmDQhi8eE8dYVFyldocMXHvUmN6E/Mc=;
 b=dWUZedCa9MtKeKcKPCiXEQkNS/LHsw1r8ZBTtkRhU33wV7yZYwpbROnaCgmdP27dVqgl5iepVrK7QmRjaB5aNz7Z53OktyBK4rkztkyhMosn5VgNBRzOfWSVg/u+j0YxDC4/1yT+3caWKAPeH+THRSp35+2511/Z3r45gAjvZqbZgi5qfAu5ei2Yz4zzZ18ueJBSkZf7zOYAtHjCD0lGBxENRpGIvTMsOPNdwXnvjAvBlc51A+KC/TbZVWPwXjNY3X/xGBXBk+BTCLOF6OZ7+qQEDvXRqY5+KQkz18P4yE6UAMILhyQlPtxc2+XT5ns0K5n/VXWPlwB/S+fR9O6BDA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1547.namprd12.prod.outlook.com (2603:10b6:4:c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21; Wed, 28 Apr 2021 20:46:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 20:46:09 +0000
Date: Wed, 28 Apr 2021 17:46:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210428204606.GX1370958@nvidia.com>
References: <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
 <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210423114944.GF1370958@nvidia.com>
 <MWHPR11MB18861FE6982D73AFBF173E048C439@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210426123817.GQ1370958@nvidia.com>
 <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <MWHPR11MB188625137D5B7423822396C88C409@MWHPR11MB1886.namprd11.prod.outlook.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: SJ0PR05CA0144.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by
 SJ0PR05CA0144.namprd05.prod.outlook.com (2603:10b6:a03:33d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.17 via Frontend
 Transport; Wed, 28 Apr 2021 20:46:08 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lbr4Q-00E89B-Jn; Wed, 28 Apr 2021 17:46:06 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2fc2089-2c69-4f03-c2e4-08d90a86a6b2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1547:
X-Microsoft-Antispam-PRVS: <DM5PR12MB154718E83A3B72560BDB85F2C2409@DM5PR12MB1547.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DXV2ttneIwH8M95RwucNI+B5U/wNThfioCLm5Qcrkh29Xv1xjbEvAMX87ryhw5FUNAMJlPqSzf0eSmBcRe6CKudel3USs4cKHMEtaie9qvk2V7u1gdt5C4PZIReCiDaIMtD6HnypXNyS+qAkUUTu90B0xD/b5lWHg2/JNQg2WVteblNILj3OjTnk1C/yZan14At5kBq+k1f+j5nlI0z42bn1KvIa9csEtQ4XVuScL1gZcrV3Icj1aJuzSX6EfWrEeHrRZBUuX7Lnbhlze3Hs8RkZR23wTQkCYrTTbs6I832znhQBY53PTMJm27aFL80iMIcQyZTKqqvnydolnqVwx6GZnjPPiQKKMg/JwrXvpmW1mU5Y4wsW5sV5X81wNZ01hgdgZpghCcnN0t7xSkQUhNZV13siO7564frXLBfEozA320WMcM4lPz89MyMnfz3qtXiUgr7Fy/Ys3iY9TqqAwzLHRxtEF6TSqAa4zv8PhOwlOaOKcJRStRrKWm7pB+mRSO2xgBA90zH7FJNIx0LjeDr/WYQTxvL9q6G8nwOZ0AVv9u4uv+b2YRxPM1inWWfBJEjLSUMx/wamKF0gAUVLjU8VOL/6xBSGjRJJ4PFmRrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(6916009)(426003)(1076003)(7416002)(83380400001)(66556008)(26005)(316002)(66476007)(186003)(54906003)(66946007)(2906002)(478600001)(38100700002)(33656002)(36756003)(8676002)(9786002)(5660300002)(8936002)(86362001)(9746002)(4326008)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YmFTSWw1UFo1cFhFZ0Q5UkhJbXRYUmhZSjlJWkJINXo4aXVGbloyTzZ0Q3cr?=
 =?utf-8?B?bHJ4VVlGYkh0MEsxa3ZCZlpKcXFMWkxXRjE0TjZZUEJ6bWM0ZzJpQ2dCVDh1?=
 =?utf-8?B?S1NNaGhpMGU2RHV5OVp2ek45NnJwemp0UEVBWVovVW5mS1NjK1hMWStXK3RP?=
 =?utf-8?B?UFFkMUZGTm5CRm5JU20va0pmSjFWWDFUbWhneHVqSkkvSVREYjB5YmhCZmE1?=
 =?utf-8?B?MkRuQktCRjRtaGxyT2FBSFpGdFhnTXJiU0FRSWNObklSLy9iZ2xDZVkvT3pm?=
 =?utf-8?B?ZEpvaHhNL2tTY3dWczZFQWVaYllYOUNZeG9LczZCdDVZRjNYUGYzcXp3UXNw?=
 =?utf-8?B?QWVXc0gxOUZkOGpkbDgyK0VWd1lxYmlubm1vaERmc2h1QjdsbHlCaHlVQUhU?=
 =?utf-8?B?RXZDaEo2bnpCMzh6RHZMUDNGVHZaRGFqQUthYkRDaitpTUdTU2lWVEpsTGI3?=
 =?utf-8?B?RlhsbmdNV3ErTHdyU1hYMnptY1M1N0RiUGNSZ0dpRkhXNVoxTU1UcElDSHEx?=
 =?utf-8?B?ajBEa1Z6d1RycXRleUtjUlh5dHNnOFJPdkladVpIb0VadzFod1h5Rmo2c1h1?=
 =?utf-8?B?T1JLcGNDWXg5STNMdEdBTmJYUXJaQ0hDU1dhbFcraEtIR0djVUJBcTFtU1dW?=
 =?utf-8?B?dTVYZ3I2STlHcTJ4cnBuajdENXlwN2ZVNEMzM3R0RE8vY29Va0wxNHpuVmpT?=
 =?utf-8?B?c2RNMGhoVlpySU1zaVZtZ2NxMHZNT211YWhOMzdIYXR0QTlxdkpCbXd3RTI1?=
 =?utf-8?B?T1F4SGJScjhZNXZxb2ozOGkxS3BTSXQ3Sk51VEtvcDhSNTdZLzdaSnd4Y0dU?=
 =?utf-8?B?RmVDODZlYisvbXY5MjZza1p5a1NMUzZtUXExMlQ4Q2RmcmJ6NHBtUnJHRlVM?=
 =?utf-8?B?NmFFWTRDbDZPMFgxR3g1bXJwWDV2YnBwZVhRelI3Sk9ZNlRFSFFrRnpkVXY5?=
 =?utf-8?B?SzVMcm9GVGJkbE1iaUJweXQyY0l3RkNQVmxBdXhIbGo4VWRoU3ZVZGpoRzI4?=
 =?utf-8?B?NXFaOGtiMG4vWWNsUnBTdlZ5TklUZHZVSkRQTVo5Q3BmWnJrSDJzSWh6YXZJ?=
 =?utf-8?B?UEpFWjR6VGdaRkEzQjM5S3hmeGtPcXQ4N1o1WFVNUE5UTlJRUjZhRjBaK0Zj?=
 =?utf-8?B?RzZocXZsbUJNTkQ4TmthbnY2aVNYanAwSDNMcXE2eHYvcGlWTWhaSmpmMVJa?=
 =?utf-8?B?Rng1c3RldUpBWm5veS9iQ2JVV0R6TWtrbEw3QWNMeFg3ZHoxTzhERUsxWlQz?=
 =?utf-8?B?MUM0QTNla09MbmcvbWpyWG81MWFTRG5Zc2ZkRis3c3BuMURkcit5d2JVKzRW?=
 =?utf-8?B?b0ZadjQzSVd2alRDR3FSZTdJK1BFY1dqOVJPbzR4SFBzTWxXM3pRNmwwaTJE?=
 =?utf-8?B?UC9EZnhpZ3pIUTIxMW9mVk81bzB2OGphSzBUS2UxOU0xOU05Vi9iMElHa2Zu?=
 =?utf-8?B?akxIMU1kd0xSUHloMHAxVy8xTzhTdmdobjVQZGE3WVI3Wm1vT0lUeGFLSmRR?=
 =?utf-8?B?aGdNSnUrWUxnUE1Sek90WU1kak9wRWxldUJkZmlMVnRXZExLZHd6MXZvUW84?=
 =?utf-8?B?SzFnM1lHUlE1eWxmN0VEeDduNTM3akVvWEV1VFJnRDNWNDMrem5uNlpCMCta?=
 =?utf-8?B?QTRZSTArZ2hsYWZwaTJNRU50SmN5bWRoRjQ4Vnl4cXU0ZWtBOEpFNXBlaTdm?=
 =?utf-8?B?VEEydmtGTEhKTldaSkhzWVRPc3Y3NktRNHVERXFLT0hRM2xVaThHUnhrcXpP?=
 =?utf-8?Q?2e1iBr31dWte5XoX2ySV9XpyIfhfUPynGRCg0bL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fc2089-2c69-4f03-c2e4-08d90a86a6b2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 20:46:09.2971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdjcX7ybbIeXgsZjrWSqG1AeDQxG6ujYTHHbdq+8ZmOYA17KPLiymF8f0X696yjv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1547
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Li Zefan <lizefan@huawei.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu,
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

T24gV2VkLCBBcHIgMjgsIDIwMjEgYXQgMDY6MzQ6MTFBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3Jv
dGU6Cgo+ID4gSWYgL2Rldi9pb2FzaWQgaXMgc2luZ2xlIEhXIHBhZ2UgdGFibGUgb25seSB0aGVu
IEkgd291bGQgZm9jdXMgb24gdGhhdAo+ID4gaW1wbGVtZW50YXRpb24gYW5kIGxlYXZlIGl0IHRv
IHVzZXJzcGFjZSB0byBzcGFuIGRpZmZlcmVudAo+ID4gL2Rldi9pb2FzaWRzIGlmIG5lZWRlZC4K
PiA+IAo+ID4gPiBPSywgbm93IEkgc2VlIHdoZXJlIHRoZSBkaXNjb25uZWN0aW9uIGNvbWVzIGZy
b20uIEluIG15IGNvbnRleHQgaW9hc2lkCj4gPiA+IGlzIHRoZSBpZGVudGlmaWVyIHRoYXQgaXMg
YWN0dWFsbHkgdXNlZCBpbiB0aGUgd2lyZSwgYnV0IHNlZW1zIHlvdSB0cmVhdCBpdCBhcwo+ID4g
PiBhIHN3LWRlZmluZWQgbmFtZXNwYWNlIHB1cmVseSBmb3IgcmVwcmVzZW50aW5nIHBhZ2UgdGFi
bGVzLiBXZSBzaG91bGQKPiA+ID4gY2xlYXIgdGhpcyBjb25jZXB0IGZpcnN0IGJlZm9yZSBmdXJ0
aGVyIGRpc2N1c3Npbmcgb3RoZXIgZGV0YWlscy4g8J+Yigo+ID4gCj4gPiBUaGVyZSBpcyBubyBn
ZW5lcmFsIEhXIHJlcXVpcmVtZW50IHRoYXQgZXZlcnkgSU8gcGFnZSB0YWJsZSBiZQo+ID4gcmVm
ZXJyZWQgdG8gYnkgdGhlIHNhbWUgUEFTSUQgYW5kIHRoaXMgQVBJIHdvdWxkIGhhdmUgdG8gc3Vw
cG9ydAo+IAo+IFllcywgYnV0IHdoYXQgaXMgdGhlIHZhbHVlIG9mIGFsbG93aW5nIG11bHRpcGxl
IFBBU0lEcyByZWZlcnJpbmcgdG8gdGhlCj4gdGhlIHNhbWUgSS9PIHBhZ2UgdGFibGUgKGV4Y2Vw
dCB0aGUgbmVzdGluZyBwZ3RhYmxlIGNhc2UpPyBEb2Vzbid0IGl0IAo+IGxlYWQgdG8gcG9vciBp
b3RsYiBlZmZpY2llbmN5IGlzc3VlIHNpbWlsYXIgdG8gbXVsdGlwbGUgaW9tbXUgZG9tYWlucyAK
PiByZWZlcnJpbmcgdG8gdGhlIHNhbWUgcGFnZSB0YWJsZT8KCkkgdGhpbmsgaW90bGIgZWZmaWNp
ZW5jeSBpcyB1cCB0byB0aGUgcGxhdGZvcm0uCgpUaGUgZ2VuZXJhbCB1c2UgY2FzZSBpcyB0byBt
YWtlIGFuIElPQVNJRCBmb3Igc29tZXRoaW5nIGxpa2UgdGhlIEdQQQphbmQgdXNlIGl0IGNvbmN1
cnJlbnRseSB3aXRoIHRocmVlIHNheSB0aHJlZSBkZXZpY2VzOgogLSBWRklPIChub3QgUEFTSUQp
CiAtIFZEUEEgKFBBU0lEIGNhcGFibGUgSFcpCiAtICdGdXR1cmUgVkRQQSBzdG9yYWdlJyAoUEFT
SUQgY2FwYWJsZSBIVykKClRoZSB1QVBJIGZvciB0aGlzIHNob3VsZCBiZSB2ZXJ5IGdlbmVyYWwg
YW5kIHRoZSBrZXJuZWwgc2hvdWxkIGRlY2lkZQp0aGUgb3B0aW1hbCB3YXkgdG8gY29uZmlndXJl
IHRoZSBIVy4gTWF5YmUgaXQgaXMgb25lIHBhZ2UgdGFibGUgYW5kCm9uZSBQQVNJRCwgb3IgbWF5
YmUgaXQgaXMgc29tZXRoaW5nIGVsc2UuCgpBbGxvd2luZyB0aGUga2VybmVsIHRvIGNob29zZSB0
aGUgUEFTSUQgb25jZSBpdCBrbm93cyB0aGUgUklEIGlzIHRoZQpoaWdoZXN0IGdlbmVyYWxpdHku
Cgo+ID4gbm9uLVBBU0lEIElPIHBhZ2UgdGFibGVzIGFzIHdlbGwuIFNvIEknZCBrZWVwIHRoZSB0
d28gdGhpbmdzCj4gPiBzZXBhcmF0ZWQgaW4gdGhlIHVBUEkgLSBldmVuIHRob3VnaCB0aGUga2Vy
bmVsIHRvZGF5IGhhcyBhIGdsb2JhbAo+ID4gUEFTSUQgcG9vbC4KPiAKPiBmb3Igbm9uLVBBU0lE
IHVzYWdlcyB0aGUgYWxsb2NhdGVkIFBBU0lEIHdpbGwgYmUgd2FzdGVkIGlmIHdlIGRvbid0Cj4g
c2VwYXJhdGUgaW9hc2lkIGZyb20gcGFzaWQuIEJ1dCBpdCBtYXkgYmUgd29ydGh3aGlsZSBnaXZl
biAxbSBhdmFpbGFibGUgCj4gcGFzaWRzIGFuZCB0aGUgc2ltcGxpZmljYXRpb24gaW4gdGhlIHVB
UEkgd2hpY2ggb25seSBuZWVkcyB0byBjYXJlIGFib3V0IAo+IG9uZSBpZCBzcGFjZSB0aGVuLgoK
SSdkIHByZWZlciB0aGlzIGJlIGEgcGxhdGZvcm0gY2hvaWNlIGFuZCBub3QgZm9yY2VkIGluIHRo
ZSB1QVBJLApiZWNhdXNlIHdlIGNhbiBuZXZlciBnbyBiYWNrIG9uIGl0IGlmIHdlIHNlZSB0aGF0
IHllcyB3ZSBuZWVkIHRvCm9wdGltaXplIGhlcmUuIEkgdW5kZXJzdGFuZCBtYW55IHBsYXRmb3Jt
cyBoYXZlIGRpZmZlcmVudCBhdmFpbGFibGUKUEFTSUQgc3BhY2VzIGFscmVhZHkuCgo+ID4gU2lt
cGxlIHRoaW5ncyBsaWtlIERQREsgY2FuIHVzZSAjMiBhbmQgcG90ZW50aWFsbHkgaGF2ZSBiZXR0
ZXIgUEFTSUQKPiA+IGxpbWl0cy4gaHlwZXJ2aXNvcnMgd2lsbCBtb3N0IGxpa2VseSBoYXZlIHRv
IHVzZSAjMSwgYnV0IGl0IGRlcGVuZHMgb24KPiA+IGhvdyB0aGVpciB2SU9NTVUgaW50ZXJmYWNl
IHdvcmtzLgo+IAo+IENhbiB5b3UgZWxhYm9yYXRlIHdoeSBEUERLIHdhbnRzIHRvIHVzZSAjMiBp
LmUuIG5vdCB1c2luZyBhIGdsb2JhbAo+IFBBU0lEPwoKSXQgZ2l2ZXMgdGhlIGtlcm5lbCBhbiBv
cHRpb24gdG8gbWFrZSB0aGUgZGVjaXNpb24gYWJvdXQgdGhlIFBBU0lECndoZW4gaXQgaGFzIHRo
ZSBmdWxsIGluZm9ybWF0aW9uLCBpbmNsdWRpbmcgdGhlIFJJRC4KCj4gPiBJIHRoaW5rIHRoZSBu
YW1lIElPQVNJRCBpcyBmaW5lIGZvciB0aGUgdUFQSSwgdGhlIGtlcm5lbCB2ZXJzaW9uIGNhbgo+
ID4gYmUgY2FsbGVkIGlvYXNpZF9pZCBvciBzb21ldGhpbmcuCj4gCj4gaW9hc2lkIGlzIGFscmVh
ZHkgYW4gaWQgYW5kIHRoZW4gaW9hc2lkX2lkIGp1c3QgYWRkcyBjb25mdXNpb24uIEFub3RoZXIK
PiBwb2ludCBpcyB0aGF0IGlvYXNpZCBpcyBjdXJyZW50bHkgdXNlZCB0byByZXByZXNlbnQgYm90
aCBQQ0kgUEFTSUQgYW5kCj4gQVJNIHN1YnN0cmVhbSBJRCBpbiB0aGUga2VybmVsLiBJdCBpbXBs
aWVzIHRoYXQgaWYgd2Ugd2FudCB0byBzZXBhcmF0ZQo+IGlvYXNpZCBhbmQgcGFzaWQgaW4gdGhl
IHVBUEkgdGhlICdwYXNpZCcgYWxzbyBuZWVkcyB0byBiZSByZXBsYWNlZCB3aXRoCj4gYW5vdGhl
ciBnZW5lcmFsIHRlcm0gdXNhYmxlIGZvciBzdWJzdHJlYW0gSUQuIEFyZSB3ZSBtYWtpbmcgdGhl
Cj4gdGVybXMgdG9vIGNvbmZ1c2luZyBoZXJlPwoKVGhpcyBpcyB3aHkgSSBhbHNvIGFtIG5vdCBz
byBzdXJlIGFib3V0IGV4cG9zaW5nIHRoZSBQQVNJRCBpbiB0aGUgQVBJCmJlY2F1c2UgaXQgaXMg
dWx0aW1hdGVseSBhIEhXIHNwZWNpZmljIGl0ZW0uCgpBcyBJIHNhaWQgdG8gRGF2aWQsIG9uZSBh
dmVudWUgaXMgdG8gaGF2ZSBzb21lIGdlbmVyaWMgdUFQSSB0aGF0IGlzCnZlcnkgZ2VuZXJhbCBh
bmQga2VlcCBhbGwgdGhpcyBkZWVwbHkgZGV0YWlsZWQgc3R1ZmYsIHRoYXQgcmVhbGx5IG9ubHkK
bWF0dGVycyBmb3IgcWVtdSwgYXMgcGFydCBvZiBhIG1vcmUgSFcgc3BlY2lmaWMgdklPTU1VIGRy
aXZlcgppbnRlcmZhY2UuCgpKYXNvbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
