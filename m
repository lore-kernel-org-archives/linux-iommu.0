Return-Path: <SRS0=cE/7=NY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197E5C432BE
	for <iommu@archiver.kernel.org>; Thu,  2 Sep 2021 00:17:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B88D7610A8
	for <iommu@archiver.kernel.org>; Thu,  2 Sep 2021 00:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B88D7610A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 87DB840121;
	Thu,  2 Sep 2021 00:17:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0_lPtckNI6mj; Thu,  2 Sep 2021 00:17:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3ADED40004;
	Thu,  2 Sep 2021 00:17:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2125CC0010;
	Thu,  2 Sep 2021 00:17:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14E10C000E
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 00:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E6E5840121
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 00:17:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4XhgqEMinJSz for <iommu@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 00:17:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from outbound.mail.eo.outlook.com
 (mail-oln040093008013.outbound.protection.outlook.com [40.93.8.13])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5B5E740004
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 00:17:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfmIQHlIMHkqsDEAx8MQ1NAfCm8Ro4Ky/wpN3QRZZqC+gl24I3fBOBpaAoJ276Zn4/+W7dy3A4lBJqQ62Whv2d3K48CbNH7Rhos//THmKEOs2CH7ppX0wYO9pTwByCirxd7peIwJwAfWE5182t9MkY34906BI5iNMD6h2WrRZV194+8iA4ckgtIAgH9afbS7KEp6JUx2KXZVhvFMGdYFEU6DIaDUYaSI0WTmQzR57bo04IgRksMlZdnCmswT659u5mbwWNnKf3/v3UZtFlUGgqUemB42CjLGGy8qWMVHgPynoYB1PZ598QH60CxFJTc9m3vcNrrxayo8G3MO3gcnCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=owhgNgpehRNG4rXYBOXS5bq3vm/tUORmSSFhaZC5C1c=;
 b=J2j5p1zJj6tGbpheajl6tqdPVzbC73oG0tZiZKx1v3FPAHaRsjaUVrpBRw9iwA1npsTobm9MyZgTr9x3WIrOSosPbbar6hb8buls0dvgQlzGachFJosDiQMMwSIF+MCh/CY5Oi9SmDCM+8cbfmRSDTbMb7mHuYS0AELmkGpZX90DB6Mt4O/SZLCe/hr105Yl0c1mRR4V4riLQbDTB3TjyYMCMYMsVgmFAw9IKs6dpWnzV8vyMWyc+lqawHiGXawRyYftzdZ9JCC2/CdR3I+Pgl5RKSB/2uqti0dLVjHFpQr6yOZKPzdBh8JLBbRcVoZbga1ULR64YAqPePd42YNDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owhgNgpehRNG4rXYBOXS5bq3vm/tUORmSSFhaZC5C1c=;
 b=ZskhXqZeDDAqP6hth/AVqP2hJ6V/pcbzmclUYaXy0ADUh1saL12nGxB4dWFO/MWBYPZYCeVYgOheGEye6uf+eTrppAbd31RRqUORI3N6aLT3qWwiCOWk0qMULnCsK9RhX41zy7/2vLb7BADf+XqyPZaE+Iv/otMaNSzzRljSsKg=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by CO1PR21MB1314.namprd21.prod.outlook.com (2603:10b6:303:151::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4; Thu, 2 Sep
 2021 00:17:22 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c8b:6387:cd5:7d86]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::3c8b:6387:cd5:7d86%8]) with mapi id 15.20.4478.014; Thu, 2 Sep 2021
 00:17:22 +0000
To: Tianyu Lan <ltykernel@gmail.com>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
 <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org"
 <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "jgross@suse.com"
 <jgross@suse.com>, "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>, "davem@davemloft.net"
 <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
 "jejb@linux.ibm.com" <jejb@linux.ibm.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, "hch@lst.de"
 <hch@lst.de>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "brijesh.singh@amd.com"
 <brijesh.singh@amd.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
 Tianyu Lan <Tianyu.Lan@microsoft.com>, "pgonda@google.com"
 <pgonda@google.com>, "martin.b.radev@gmail.com" <martin.b.radev@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>, "hannes@cmpxchg.org"
 <hannes@cmpxchg.org>, "aneesh.kumar@linux.ibm.com"
 <aneesh.kumar@linux.ibm.com>, "krish.sadhukhan@oracle.com"
 <krish.sadhukhan@oracle.com>, "saravanand@fb.com" <saravanand@fb.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>, "rientjes@google.com"
 <rientjes@google.com>, "ardb@kernel.org" <ardb@kernel.org>
Subject: RE: [PATCH V4 04/13] hyperv: Mark vmbus ring buffer visible to host
 in Isolation VM
Thread-Topic: [PATCH V4 04/13] hyperv: Mark vmbus ring buffer visible to host
 in Isolation VM
Thread-Index: AQHXm2gHOMlvw7enDEWSDoli9Xi0FquJEt7Q
Date: Thu, 2 Sep 2021 00:17:21 +0000
Message-ID: <MWHPR21MB1593907C65C249D00F1A5717D7CE9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210827172114.414281-1-ltykernel@gmail.com>
 <20210827172114.414281-5-ltykernel@gmail.com>
In-Reply-To: <20210827172114.414281-5-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8b920a56-6992-44f3-a51e-d6ed365110c4;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-28T15:53:27Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cf4ec66-38f2-483e-19b0-08d96da708a2
x-ms-traffictypediagnostic: CO1PR21MB1314:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CO1PR21MB131475BC7B28CED23E9D2903D7CE9@CO1PR21MB1314.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:56;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JS2keamfM0jx37N7WlgsOSbQHuA0Wn2B+meaecDh668t0uFHu1b6F9vaDvTBLx2VKFqIXQux4S7RdVg5kLwZAzhkddRHN09fdW0rHMs/zwus14Ri4c2uJZAjZNiJJxon53OVVyCnwptUWdC3djGkubA5Iufw+jkPnEqoh2bcjvVZwaJ3a/Spocbf0Z/3W+RTTnAph5VpUoFZW7YcPIUrJe/SdC+L54R1e+bf+r1PkjfCmpcyRDbOZWqSiQSuxWVcbOjJCizQpivEiGiZn3Z0/wpe/hEqtsUKigJRtrud00EoMtoOe7Rew3IEzgVp3SFOzaJaS2L8FQG64zrGBx0ZjbkSn7g5GZYkw4onVe2qtl7nIpkwZC5NAanU2BykM9Zw9nOUzo6RYgFKKtHaEJRJigK8FZccbFPztem2qGOaY+1MJTbSTAragATuoKZ+sz0OhzdupvCIZSb2WBMVG2MbmBGBjhZIjrq8oFj7vNxrPq+8Ad9DzLBivoyGQwKcybt7VHCSw8WwnfKpIc4kczVKYt2owMPsBvIxAoRS9dCpAbMxBVb3GZ3+NmD3iTXbDH8fptRTaCRYgnxB7Hgl4YNWId9Zc77Gcz9Oxk15pklkdCcwpAHlccCF8LsWK4fCFdEN98mOTflZE9UBbLCfDdBWEQuIa/E1jXCYSHt5xDO0T5gHlrFIQcoqLGXCmogNYVv5l0fDox/iMA7wNJEnBou53cOPq2lw5w8WxLGfarsrFWY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR21MB1593.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(10290500003)(7696005)(186003)(66946007)(6506007)(76116006)(38100700002)(8676002)(110136005)(9686003)(316002)(54906003)(71200400001)(38070700005)(8990500004)(86362001)(55016002)(2906002)(122000001)(508600001)(8936002)(4326008)(7406005)(5660300002)(7416002)(7366002)(33656002)(52536014)(83380400001)(82950400001)(30864003)(66556008)(82960400001)(921005)(66476007)(66446008)(64756008)(579004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?myQ8QsXlfAfVc23WymszcgcfUlIfJShxhHjbJ2Aib3aynOpa5jp1m09TdBOP?=
 =?us-ascii?Q?44/cyx/EUsQn02ziq8stvkYyA2AH219MYTbHgkZ0PQO4uphUjo+EoK/6jX93?=
 =?us-ascii?Q?/8+oVNcd0ZzfI8oDPDi4KFFKM+NFIB79Ft6rQpuGGERSF2M9GJajNTIRyu+L?=
 =?us-ascii?Q?1uRGT6XJsA9+5xtqvTSffvm6KHvwD/L0Fk+XLjyzzqBJITEn01Ut/oB8ragL?=
 =?us-ascii?Q?Pe+gfGJlxHYB2GRd1yhJIESJhcX9jO9rIHeeNHguyzgosvuXiY5Kk98mKfqD?=
 =?us-ascii?Q?jnnrbNrvyu1KAQSh3O43imVdxYZVhcmTXw36md5kdZJr0BOJI5J2a+Bnzutj?=
 =?us-ascii?Q?x8Bcqs2PRM2nLaRVLxbU4VHAwd1Oc/pZLE1NimqV1Hrk+G18FlP7b6Hcg1iT?=
 =?us-ascii?Q?B41PuTjVN0HgdNDwzLbtAMjdpYkTYqKRX9Wu0NZnPgAboV8jKSZ8y55xPb9J?=
 =?us-ascii?Q?jYifbwG3d/3ObjcplK7DZIks7DZHsJmRKD7ZTD0L3ESwUMPRS5x9q1jSKUvu?=
 =?us-ascii?Q?IxPHYsR3u2mUH83T4g3F9l47fKXzRGyGB0kHvXiAEU+osfPJh4qGiKiKKLoB?=
 =?us-ascii?Q?u8PO4EDKyBxifNj43NynqQrRaivVnclmt1pvmGeMOOa6v/2c9zVQv4FSXWtK?=
 =?us-ascii?Q?96kaxaam2QlwCfG0kkO51XU7gyKY75KQWnCcntCuK1ONzTJY/8xBXxjw6LDG?=
 =?us-ascii?Q?R9mp2ZsMDUfoJ6pZuMGsczXz5TO1MqYX+ctwvqAMehPtgzigJ4mlXnfkdl+q?=
 =?us-ascii?Q?fG7LSyRXQtKq+gv5Gt2z+BmRgKLPMySLDihIpPqGVdsgh9hNuiwkv9C3bEbI?=
 =?us-ascii?Q?bhNdVeGjZVjKE0408/GwvocD2kymDt0j/+0DIfZu70ZcNoewYNPugEh9fNDG?=
 =?us-ascii?Q?Pi5QQZ8MRjqAlYBk/P2E6/pkwjIxxqLcbK2Oe6c1RqUaK0n2ix/F3e8OydKm?=
 =?us-ascii?Q?i/8FgDCGm+x2AIodelpK2kJlusSYbi9Sg4Y1Ti66LnG1si8mM3wf4V5R5U7w?=
 =?us-ascii?Q?AfqyAEhVwXJgTlZP7ckgQREkdKmpqp4qdott4zlHCxVYQAieh28g+Q17pEfC?=
 =?us-ascii?Q?lYm8rmVfpgxTLCJfM/8I1pOCLh0Nxj/Z6K9ThcY4wmqlKE3pbayzJ6+rwXrN?=
 =?us-ascii?Q?iiY+Ke6HBCWlHS4ZiYUsdqGGDFmZcqRBYEggP4RvI2NfsHaX8jBpzEY5XJOV?=
 =?us-ascii?Q?ZN7D50242CoX0WGg5ksLuGhXcTQo3GUnn1qwBft1qVmXW7hQVqUDMfG7Tufz?=
 =?us-ascii?Q?K+KjAfUJpRQucjdmLeoeEv3zKMTw1x5vYTkgAmexLc43Sko03RTL7tY3S3Z1?=
 =?us-ascii?Q?nvWdQTsTDtPen+Cxg/Z9ym3o?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf4ec66-38f2-483e-19b0-08d96da708a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2021 00:17:21.8744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RvDiBlbiojDhzzfcbdOFBQye/Pw0hBMnWGLgEzVinucglU+0phNLl1XfUwN/S83lBQSENW2MEid4+ZQm1OH2Wai4GCLnrqZil8MQ9Y0w9dU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR21MB1314
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 vkuznets <vkuznets@redhat.com>
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
From: Michael Kelley via iommu <iommu@lists.linux-foundation.org>
Reply-To: Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Tianyu Lan <ltykernel@gmail.com> Sent: Friday, August 27, 2021 10:21 AM
> 
> Mark vmbus ring buffer visible with set_memory_decrypted() when
> establish gpadl handle.
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> Change since v3:
>        * Change vmbus_teardown_gpadl() parameter and put gpadl handle,
>        buffer and buffer size in the struct vmbus_gpadl.
> ---
>  drivers/hv/channel.c            | 36 ++++++++++++++++++++++++++++-----
>  drivers/net/hyperv/hyperv_net.h |  1 +
>  drivers/net/hyperv/netvsc.c     | 16 +++++++++++----
>  drivers/uio/uio_hv_generic.c    | 14 +++++++++++--
>  include/linux/hyperv.h          |  8 +++++++-
>  5 files changed, 63 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index f3761c73b074..82650beb3af0 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -17,6 +17,7 @@
>  #include <linux/hyperv.h>
>  #include <linux/uio.h>
>  #include <linux/interrupt.h>
> +#include <linux/set_memory.h>
>  #include <asm/page.h>
>  #include <asm/mshyperv.h>
> 
> @@ -474,6 +475,13 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
>  	if (ret)
>  		return ret;
> 
> +	ret = set_memory_decrypted((unsigned long)kbuffer,
> +				   HVPFN_UP(size));
> +	if (ret) {
> +		pr_warn("Failed to set host visibility for new GPADL %d.\n", ret);
> +		return ret;
> +	}
> +
>  	init_completion(&msginfo->waitevent);
>  	msginfo->waiting_channel = channel;
> 
> @@ -549,6 +557,11 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
>  	}
> 
>  	kfree(msginfo);
> +
> +	if (ret)
> +		set_memory_encrypted((unsigned long)kbuffer,
> +				     HVPFN_UP(size));
> +
>  	return ret;
>  }
> 
> @@ -639,6 +652,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
>  	struct vmbus_channel_open_channel *open_msg;
>  	struct vmbus_channel_msginfo *open_info = NULL;
>  	struct page *page = newchannel->ringbuffer_page;
> +	struct vmbus_gpadl gpadl;
>  	u32 send_pages, recv_pages;
>  	unsigned long flags;
>  	int err;
> @@ -759,7 +773,10 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
>  error_free_info:
>  	kfree(open_info);
>  error_free_gpadl:
> -	vmbus_teardown_gpadl(newchannel, newchannel->ringbuffer_gpadlhandle);
> +	gpadl.gpadl_handle = newchannel->ringbuffer_gpadlhandle;
> +	gpadl.buffer = page_address(newchannel->ringbuffer_page);
> +	gpadl.size = (send_pages + recv_pages) << PAGE_SHIFT;
> +	vmbus_teardown_gpadl(newchannel, &gpadl);
>  	newchannel->ringbuffer_gpadlhandle = 0;
>  error_clean_ring:
>  	hv_ringbuffer_cleanup(&newchannel->outbound);
> @@ -806,7 +823,7 @@ EXPORT_SYMBOL_GPL(vmbus_open);
>  /*
>   * vmbus_teardown_gpadl -Teardown the specified GPADL handle
>   */
> -int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32 gpadl_handle)
> +int vmbus_teardown_gpadl(struct vmbus_channel *channel, struct vmbus_gpadl *gpadl)
>  {
>  	struct vmbus_channel_gpadl_teardown *msg;
>  	struct vmbus_channel_msginfo *info;
> @@ -825,7 +842,7 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32 gpadl_handle)
> 
>  	msg->header.msgtype = CHANNELMSG_GPADL_TEARDOWN;
>  	msg->child_relid = channel->offermsg.child_relid;
> -	msg->gpadl = gpadl_handle;
> +	msg->gpadl = gpadl->gpadl_handle;
> 
>  	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
>  	list_add_tail(&info->msglistentry,
> @@ -859,6 +876,12 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32 gpadl_handle)
>  	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
> 
>  	kfree(info);
> +
> +	ret = set_memory_encrypted((unsigned long)gpadl->buffer,
> +				   HVPFN_UP(gpadl->size));
> +	if (ret)
> +		pr_warn("Fail to set mem host visibility in GPADL teardown %d.\n", ret);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(vmbus_teardown_gpadl);
> @@ -896,6 +919,7 @@ void vmbus_reset_channel_cb(struct vmbus_channel *channel)
>  static int vmbus_close_internal(struct vmbus_channel *channel)
>  {
>  	struct vmbus_channel_close_channel *msg;
> +	struct vmbus_gpadl gpadl;
>  	int ret;
> 
>  	vmbus_reset_channel_cb(channel);
> @@ -934,8 +958,10 @@ static int vmbus_close_internal(struct vmbus_channel *channel)
> 
>  	/* Tear down the gpadl for the channel's ring buffer */
>  	else if (channel->ringbuffer_gpadlhandle) {
> -		ret = vmbus_teardown_gpadl(channel,
> -					   channel->ringbuffer_gpadlhandle);
> +		gpadl.gpadl_handle = channel->ringbuffer_gpadlhandle;
> +		gpadl.buffer = page_address(channel->ringbuffer_page);
> +		gpadl.size = channel->ringbuffer_pagecount;
> +		ret = vmbus_teardown_gpadl(channel, &gpadl);
>  		if (ret) {
>  			pr_err("Close failed: teardown gpadl return %d\n", ret);
>  			/*
> diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
> index bc48855dff10..aa7c9962dbd8 100644
> --- a/drivers/net/hyperv/hyperv_net.h
> +++ b/drivers/net/hyperv/hyperv_net.h
> @@ -1082,6 +1082,7 @@ struct netvsc_device {
> 
>  	/* Send buffer allocated by us */
>  	void *send_buf;
> +	u32 send_buf_size;
>  	u32 send_buf_gpadl_handle;
>  	u32 send_section_cnt;
>  	u32 send_section_size;
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 7bd935412853..f19bffff6a63 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -276,11 +276,14 @@ static void netvsc_teardown_recv_gpadl(struct hv_device *device,
>  				       struct netvsc_device *net_device,
>  				       struct net_device *ndev)
>  {
> +	struct vmbus_gpadl gpadl;
>  	int ret;
> 
>  	if (net_device->recv_buf_gpadl_handle) {
> -		ret = vmbus_teardown_gpadl(device->channel,
> -					   net_device->recv_buf_gpadl_handle);
> +		gpadl.gpadl_handle = net_device->recv_buf_gpadl_handle;
> +		gpadl.buffer = net_device->recv_buf;
> +		gpadl.size = net_device->recv_buf_size;
> +		ret = vmbus_teardown_gpadl(device->channel, &gpadl);
> 
>  		/* If we failed here, we might as well return and have a leak
>  		 * rather than continue and a bugchk
> @@ -298,11 +301,15 @@ static void netvsc_teardown_send_gpadl(struct hv_device *device,
>  				       struct netvsc_device *net_device,
>  				       struct net_device *ndev)
>  {
> +	struct vmbus_gpadl gpadl;
>  	int ret;
> 
>  	if (net_device->send_buf_gpadl_handle) {
> -		ret = vmbus_teardown_gpadl(device->channel,
> -					   net_device->send_buf_gpadl_handle);
> +		gpadl.gpadl_handle = net_device->send_buf_gpadl_handle;
> +		gpadl.buffer = net_device->send_buf;
> +		gpadl.size = net_device->send_buf_size;
> +
> +		ret = vmbus_teardown_gpadl(device->channel, &gpadl);
> 
>  		/* If we failed here, we might as well return and have a leak
>  		 * rather than continue and a bugchk
> @@ -463,6 +470,7 @@ static int netvsc_init_buf(struct hv_device *device,
>  		ret = -ENOMEM;
>  		goto cleanup;
>  	}
> +	net_device->send_buf_size = buf_size;
> 
>  	/* Establish the gpadl handle for this buffer on this
>  	 * channel.  Note: This call uses the vmbus connection rather
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index 652fe2547587..13c5df8dd11d 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -179,14 +179,24 @@ hv_uio_new_channel(struct vmbus_channel *new_sc)
>  static void
>  hv_uio_cleanup(struct hv_device *dev, struct hv_uio_private_data *pdata)
>  {
> +	struct vmbus_gpadl gpadl;
> +
>  	if (pdata->send_gpadl) {
> -		vmbus_teardown_gpadl(dev->channel, pdata->send_gpadl);
> +		gpadl.gpadl_handle = pdata->send_gpadl;
> +		gpadl.buffer = pdata->send_buf;
> +		gpadl.size = SEND_BUFFER_SIZE;
> +
> +		vmbus_teardown_gpadl(dev->channel, &gpadl);
>  		pdata->send_gpadl = 0;
>  		vfree(pdata->send_buf);
>  	}
> 
>  	if (pdata->recv_gpadl) {
> -		vmbus_teardown_gpadl(dev->channel, pdata->recv_gpadl);
> +		gpadl.gpadl_handle = pdata->recv_gpadl;
> +		gpadl.buffer = pdata->recv_buf;
> +		gpadl.size = RECV_BUFFER_SIZE;
> +
> +		vmbus_teardown_gpadl(dev->channel, &gpadl);
>  		pdata->recv_gpadl = 0;
>  		vfree(pdata->recv_buf);
>  	}
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index ddc8713ce57b..757e09606fd3 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -803,6 +803,12 @@ struct vmbus_device {
> 
>  #define VMBUS_DEFAULT_MAX_PKT_SIZE 4096
> 
> +struct vmbus_gpadl {
> +	u32 gpadl_handle;
> +	u32 size;
> +	void *buffer;
> +};
> +
>  struct vmbus_channel {
>  	struct list_head listentry;
> 
> @@ -1195,7 +1201,7 @@ extern int vmbus_establish_gpadl(struct vmbus_channel *channel,
>  				      u32 *gpadl_handle);
> 
>  extern int vmbus_teardown_gpadl(struct vmbus_channel *channel,
> -				     u32 gpadl_handle);
> +				     struct vmbus_gpadl *gpadl);
> 
>  void vmbus_reset_channel_cb(struct vmbus_channel *channel);
> 
> --
> 2.25.1

This isn't quite what I had in mind in my comments on v3 of this
patch series.  My idea is to store the full struct vmbus_gpadl
data structure in places where previously just the
u32 gpadl_handle was stored.  Then pass around a pointer to the
struct vmbus_gpadl where previously just the gpadl_handle (or a
pointer to it) was passed. This lets __vmbus_establish_gpadl()
fill in the actual handle value as well the other info (buffer pointer
and size) that vmbus_teardown_gpadl() needs.  Callers of the
gpadl functions don't need to worry about saving or finding
the right info.  Most of the changes are just tweaking the references
to what is now a struct instead of a u32.  

Here's a diff of what I had in mind.  My version also has
vmbus_teardown_gpadl() set the handle field to zero, rather than
each caller having to do it.  The code compiles, but I
have not done a runtime test.  This diff is a net +21 lines of code,
whereas your v3 and v4 patches were both +51 lines of code.

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index f3761c7..fc041ae 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -17,6 +17,7 @@
 #include <linux/hyperv.h>
 #include <linux/uio.h>
 #include <linux/interrupt.h>
+#include <linux/set_memory.h>
 #include <asm/page.h>
 #include <asm/mshyperv.h>
 
@@ -456,7 +457,7 @@ static int create_gpadl_header(enum hv_gpadl_type type, void *kbuffer,
 static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 				   enum hv_gpadl_type type, void *kbuffer,
 				   u32 size, u32 send_offset,
-				   u32 *gpadl_handle)
+				   struct vmbus_gpadl *gpadl_handle)
 {
 	struct vmbus_channel_gpadl_header *gpadlmsg;
 	struct vmbus_channel_gpadl_body *gpadl_body;
@@ -474,6 +475,13 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	if (ret)
 		return ret;
 
+	ret = set_memory_decrypted((unsigned long)kbuffer,
+				   HVPFN_UP(size));
+	if (ret) {
+		pr_warn("Failed to set host visibility for new GPADL %d.\n", ret);
+		return ret;
+	}
+
 	init_completion(&msginfo->waitevent);
 	msginfo->waiting_channel = channel;
 
@@ -537,7 +545,9 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	}
 
 	/* At this point, we received the gpadl created msg */
-	*gpadl_handle = gpadlmsg->gpadl;
+	gpadl_handle->handle = gpadlmsg->gpadl;
+	gpadl_handle->buffer = kbuffer;
+	gpadl_handle->size = size;
 
 cleanup:
 	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
@@ -549,6 +559,11 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	}
 
 	kfree(msginfo);
+
+	if (ret)
+		set_memory_encrypted((unsigned long)kbuffer,
+				     HVPFN_UP(size));
+
 	return ret;
 }
 
@@ -561,7 +576,7 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
  * @gpadl_handle: some funky thing
  */
 int vmbus_establish_gpadl(struct vmbus_channel *channel, void *kbuffer,
-			  u32 size, u32 *gpadl_handle)
+			  u32 size, struct vmbus_gpadl *gpadl_handle)
 {
 	return __vmbus_establish_gpadl(channel, HV_GPADL_BUFFER, kbuffer, size,
 				       0U, gpadl_handle);
@@ -675,7 +690,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 		goto error_clean_ring;
 
 	/* Establish the gpadl for the ring buffer */
-	newchannel->ringbuffer_gpadlhandle = 0;
+	newchannel->ringbuffer_gpadlhandle.handle = 0;
 
 	err = __vmbus_establish_gpadl(newchannel, HV_GPADL_RING,
 				      page_address(newchannel->ringbuffer_page),
@@ -701,7 +716,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 	open_msg->header.msgtype = CHANNELMSG_OPENCHANNEL;
 	open_msg->openid = newchannel->offermsg.child_relid;
 	open_msg->child_relid = newchannel->offermsg.child_relid;
-	open_msg->ringbuffer_gpadlhandle = newchannel->ringbuffer_gpadlhandle;
+	open_msg->ringbuffer_gpadlhandle = newchannel->ringbuffer_gpadlhandle.handle;
 	/*
 	 * The unit of ->downstream_ringbuffer_pageoffset is HV_HYP_PAGE and
 	 * the unit of ->ringbuffer_send_offset (i.e. send_pages) is PAGE, so
@@ -759,8 +774,7 @@ static int __vmbus_open(struct vmbus_channel *newchannel,
 error_free_info:
 	kfree(open_info);
 error_free_gpadl:
-	vmbus_teardown_gpadl(newchannel, newchannel->ringbuffer_gpadlhandle);
-	newchannel->ringbuffer_gpadlhandle = 0;
+	vmbus_teardown_gpadl(newchannel, &newchannel->ringbuffer_gpadlhandle);
 error_clean_ring:
 	hv_ringbuffer_cleanup(&newchannel->outbound);
 	hv_ringbuffer_cleanup(&newchannel->inbound);
@@ -806,7 +820,7 @@ int vmbus_open(struct vmbus_channel *newchannel,
 /*
  * vmbus_teardown_gpadl -Teardown the specified GPADL handle
  */
-int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32 gpadl_handle)
+int vmbus_teardown_gpadl(struct vmbus_channel *channel, struct vmbus_gpadl *gpadl)
 {
 	struct vmbus_channel_gpadl_teardown *msg;
 	struct vmbus_channel_msginfo *info;
@@ -825,7 +839,7 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32 gpadl_handle)
 
 	msg->header.msgtype = CHANNELMSG_GPADL_TEARDOWN;
 	msg->child_relid = channel->offermsg.child_relid;
-	msg->gpadl = gpadl_handle;
+	msg->gpadl = gpadl->handle;
 
 	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
 	list_add_tail(&info->msglistentry,
@@ -844,6 +858,7 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32 gpadl_handle)
 		goto post_msg_err;
 
 	wait_for_completion(&info->waitevent);
+	gpadl->handle = 0;
 
 post_msg_err:
 	/*
@@ -859,6 +874,12 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32 gpadl_handle)
 	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
 
 	kfree(info);
+
+	ret = set_memory_encrypted((unsigned long)gpadl->buffer,
+				   HVPFN_UP(gpadl->size));
+	if (ret)
+		pr_warn("Fail to set mem host visibility in GPADL teardown %d.\n", ret);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(vmbus_teardown_gpadl);
@@ -933,9 +954,9 @@ static int vmbus_close_internal(struct vmbus_channel *channel)
 	}
 
 	/* Tear down the gpadl for the channel's ring buffer */
-	else if (channel->ringbuffer_gpadlhandle) {
+	else if (channel->ringbuffer_gpadlhandle.handle) {
 		ret = vmbus_teardown_gpadl(channel,
-					   channel->ringbuffer_gpadlhandle);
+					   &channel->ringbuffer_gpadlhandle);
 		if (ret) {
 			pr_err("Close failed: teardown gpadl return %d\n", ret);
 			/*
@@ -943,8 +964,6 @@ static int vmbus_close_internal(struct vmbus_channel *channel)
 			 * it is perhaps better to leak memory.
 			 */
 		}
-
-		channel->ringbuffer_gpadlhandle = 0;
 	}
 
 	if (!ret)
diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index bc48855..54cbce1 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -1075,14 +1075,14 @@ struct netvsc_device {
 	/* Receive buffer allocated by us but manages by NetVSP */
 	void *recv_buf;
 	u32 recv_buf_size; /* allocated bytes */
-	u32 recv_buf_gpadl_handle;
+	struct vmbus_gpadl recv_buf_gpadl_handle;
 	u32 recv_section_cnt;
 	u32 recv_section_size;
 	u32 recv_completion_cnt;
 
 	/* Send buffer allocated by us */
 	void *send_buf;
-	u32 send_buf_gpadl_handle;
+	struct vmbus_gpadl send_buf_gpadl_handle;
 	u32 send_section_cnt;
 	u32 send_section_size;
 	unsigned long *send_section_map;
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 7bd9354..585974c 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -278,9 +278,9 @@ static void netvsc_teardown_recv_gpadl(struct hv_device *device,
 {
 	int ret;
 
-	if (net_device->recv_buf_gpadl_handle) {
+	if (net_device->recv_buf_gpadl_handle.handle) {
 		ret = vmbus_teardown_gpadl(device->channel,
-					   net_device->recv_buf_gpadl_handle);
+					   &net_device->recv_buf_gpadl_handle);
 
 		/* If we failed here, we might as well return and have a leak
 		 * rather than continue and a bugchk
@@ -290,7 +290,6 @@ static void netvsc_teardown_recv_gpadl(struct hv_device *device,
 				   "unable to teardown receive buffer's gpadl\n");
 			return;
 		}
-		net_device->recv_buf_gpadl_handle = 0;
 	}
 }
 
@@ -300,9 +299,9 @@ static void netvsc_teardown_send_gpadl(struct hv_device *device,
 {
 	int ret;
 
-	if (net_device->send_buf_gpadl_handle) {
+	if (net_device->send_buf_gpadl_handle.handle) {
 		ret = vmbus_teardown_gpadl(device->channel,
-					   net_device->send_buf_gpadl_handle);
+					   &net_device->send_buf_gpadl_handle);
 
 		/* If we failed here, we might as well return and have a leak
 		 * rather than continue and a bugchk
@@ -312,7 +311,6 @@ static void netvsc_teardown_send_gpadl(struct hv_device *device,
 				   "unable to teardown send buffer's gpadl\n");
 			return;
 		}
-		net_device->send_buf_gpadl_handle = 0;
 	}
 }
 
@@ -380,7 +378,7 @@ static int netvsc_init_buf(struct hv_device *device,
 	memset(init_packet, 0, sizeof(struct nvsp_message));
 	init_packet->hdr.msg_type = NVSP_MSG1_TYPE_SEND_RECV_BUF;
 	init_packet->msg.v1_msg.send_recv_buf.
-		gpadl_handle = net_device->recv_buf_gpadl_handle;
+		gpadl_handle = net_device->recv_buf_gpadl_handle.handle;
 	init_packet->msg.v1_msg.
 		send_recv_buf.id = NETVSC_RECEIVE_BUFFER_ID;
 
@@ -482,7 +480,7 @@ static int netvsc_init_buf(struct hv_device *device,
 	memset(init_packet, 0, sizeof(struct nvsp_message));
 	init_packet->hdr.msg_type = NVSP_MSG1_TYPE_SEND_SEND_BUF;
 	init_packet->msg.v1_msg.send_send_buf.gpadl_handle =
-		net_device->send_buf_gpadl_handle;
+		net_device->send_buf_gpadl_handle.handle;
 	init_packet->msg.v1_msg.send_send_buf.id = NETVSC_SEND_BUFFER_ID;
 
 	trace_nvsp_send(ndev, init_packet);
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 652fe25..97e08e7 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -58,11 +58,11 @@ struct hv_uio_private_data {
 	atomic_t refcnt;
 
 	void	*recv_buf;
-	u32	recv_gpadl;
+	struct vmbus_gpadl recv_gpadl;
 	char	recv_name[32];	/* "recv_4294967295" */
 
 	void	*send_buf;
-	u32	send_gpadl;
+	struct vmbus_gpadl send_gpadl;
 	char	send_name[32];
 };
 
@@ -179,15 +179,13 @@ static int hv_uio_ring_mmap(struct file *filp, struct kobject *kobj,
 static void
 hv_uio_cleanup(struct hv_device *dev, struct hv_uio_private_data *pdata)
 {
-	if (pdata->send_gpadl) {
-		vmbus_teardown_gpadl(dev->channel, pdata->send_gpadl);
-		pdata->send_gpadl = 0;
+	if (pdata->send_gpadl.handle) {
+		vmbus_teardown_gpadl(dev->channel, &pdata->send_gpadl);
 		vfree(pdata->send_buf);
 	}
 
-	if (pdata->recv_gpadl) {
-		vmbus_teardown_gpadl(dev->channel, pdata->recv_gpadl);
-		pdata->recv_gpadl = 0;
+	if (pdata->recv_gpadl.handle) {
+		vmbus_teardown_gpadl(dev->channel, &pdata->recv_gpadl);
 		vfree(pdata->recv_buf);
 	}
 }
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 2e859d2..a0d64c3 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -809,6 +809,12 @@ struct vmbus_device {
 
 #define VMBUS_DEFAULT_MAX_PKT_SIZE 4096
 
+struct vmbus_gpadl {
+	u32 handle;
+	u32 size;
+	void *buffer;
+};
+
 struct vmbus_channel {
 	struct list_head listentry;
 
@@ -828,7 +834,7 @@ struct vmbus_channel {
 	bool rescind_ref; /* got rescind msg, got channel reference */
 	struct completion rescind_event;
 
-	u32 ringbuffer_gpadlhandle;
+	struct vmbus_gpadl ringbuffer_gpadlhandle;
 
 	/* Allocated memory for ring buffer */
 	struct page *ringbuffer_page;
@@ -1208,10 +1214,10 @@ extern int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 extern int vmbus_establish_gpadl(struct vmbus_channel *channel,
 				      void *kbuffer,
 				      u32 size,
-				      u32 *gpadl_handle);
+				      struct vmbus_gpadl *gpadl_handle);
 
 extern int vmbus_teardown_gpadl(struct vmbus_channel *channel,
-				     u32 gpadl_handle);
+				     struct vmbus_gpadl *gpadl);
 
 void vmbus_reset_channel_cb(struct vmbus_channel *channel);

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
