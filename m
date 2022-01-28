Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E539C43217
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 09:13:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3626D60597;
	Fri, 28 Jan 2022 09:13:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AwyWVFU2ltmt; Fri, 28 Jan 2022 09:13:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0EB36600D1;
	Fri, 28 Jan 2022 09:13:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D42E0C001A;
	Fri, 28 Jan 2022 09:13:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9349C000B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 09:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D5BB4813FB
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 09:13:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2ztC9nPfpnHK for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 09:13:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C605813AF
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 09:13:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbGBIp3cIrkbLiSjtFvGUqtcUGsE+KFemZWyVsogzGOhBaMqS1szRiR7uWCUbIFCEqTGxz+dLt9Dq+wvEdlzkzWb7nHA/dwVxrWQlQy6H+OUkWs71fk6f6jXKJKAmt2ZUGfC3BIP1NfywfxsvSH1g2PFEya2e7XFv58s8eHq6WewIcss/p853WRLOwmsWWfPZXMb/GrbPlj1hFIEeyodrU3Z/4JAvMMXddHKQjYSGzF3cvFiFnr5kgeS6OCsItDcZe9pL4FdagxH+m/TOuvlMrYTAJ9j63AZyVBjqV/IWXJ7C1ZwpevNiurmh2CMHwgoY2fzCl+d5auQTHnHREHm0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDDGO9l+GHDDD7OjVPtfLIcoHpug1HFQU/Kz2QCg7/A=;
 b=V7oK/nyAdrBjJ9UVE+JWq3UP56wI0FE+hZC0o8/Bgv7fCAB2bCqhkL34R3oCg8ZA4l3r7IiAgyXyl63Q83J1STfrZtJKcTIFq9ZlgoJWNohn0jtn2SoVcNUZaK9N/9vIKK+FIpZUlhWmOcjchK6Lk/dtFG5561FFkgpnK9sshn1mdqamQnZ6PyBORVDSCDQf4r8tvL5g0U1vibP36LDxcYDOocDolNR9XBaNXi8gc5rvpTaHDMYkub4I5LldLoemD86H5gok5JWHu+KhcJ56Pw7Q+T6ALfpL22PdgKrqCfYWIo+RZ7IzfTGpEl49wMuQpBY95I4dX8v79V9cAUCDEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDDGO9l+GHDDD7OjVPtfLIcoHpug1HFQU/Kz2QCg7/A=;
 b=bOmE/QbpQ8DU71VOD3WQ5Ja0ag3EqbsjK6dawh7SlztdwmmbMXAKgJnrgT+YfMXKkf2b2CVsl47edB6w9hCW+goQgQ9MtYoQfswvb0oLxPW7t3q78eR09vU8XVz63Af33/XKNfYWapNDAWHxSGFkWiC5d7ROL97YnnNCRIZSlg78gTnz2NEK/pUX6uCslt7vBcPZDC/qBndLWRQZp9S9GkX7TT9nynl7uoRnQSVeY2UMVqRdhQTR57kXDTQ24tOeDYb03CE+yh8khW0lw2OlEt4ujjIglSKDRBtD4GJqhBggVMJ/x/vZI3MguUbfhFo8VooecRcFoKHd+DG5IOu6Hg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BYAPR12MB2631.namprd12.prod.outlook.com (2603:10b6:a03:6b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 09:13:11 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%4]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 09:13:11 +0000
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v5 12/24] nvme-pci: convert to using dma_map_sgtable()
Thread-Topic: [PATCH v5 12/24] nvme-pci: convert to using dma_map_sgtable()
Thread-Index: AQHYE93DRXAPGacM40q8QY5Zypteeax4Js4A
Date: Fri, 28 Jan 2022 09:13:11 +0000
Message-ID: <8ea7b917-e8b9-2bed-40bf-276c8a0b1f2c@nvidia.com>
References: <20220128002614.6136-1-logang@deltatee.com>
 <20220128002614.6136-13-logang@deltatee.com>
In-Reply-To: <20220128002614.6136-13-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a97b3ac-8f71-4d97-c878-08d9e23e6828
x-ms-traffictypediagnostic: BYAPR12MB2631:EE_
x-microsoft-antispam-prvs: <BYAPR12MB263176D6DCF808CBBF261045A3229@BYAPR12MB2631.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FxNC72RfPCPnBNfX67COYfQRDLVZj0GWWwPThisBQgjqfwNZEIW8ZKvyuvPXlsvyg36DMEI2C0c9gAVId5lBE54RK8vfFFq4PkSb2lhVjOyjG/IYqeyKGWRa9ZNwtm8ZlARN39Go2e+Zf97QkcejH5lVnxzoKKnDMd80ylCUsSeN2AhRqvwY185j2V1LW+AUJR0cn/244TVk5QtfY9HAEw0g5SwIZvgJp7NSzqNihtzWhWrb932p4fP6mAqHttlPfUyoR0ZT6U3nYg+m+NGFlWYCydMGZMTlpAVh9PyXjpLn6wi4RScZAphelAjmUN6OzY/H9FgwAi41lGz5plL5ftkHCI5UAax5YgwZ/Fmr4hn9dTIvaf8u5n7DDUIwZ1re9CaIO2hWjUG7Rl+LWQrMe+nlv8NREwEmwzvzLFGamlLmiO35K4ZxgqcZLy2+0yGbZyxBfJdt6kr5dd6XFweW4bTj6SRndBv555dIe3XmdK3RHF23WL7V0An2t4XNfoIfynN9nmz6MKY7oNDM//7BAWPyNzMtn+RityXU6DUM6KKH7dDTfCx40KIwiBG+YesDAdw+5ZvV668W+npSq2HlnSrtjQdAftcYtaTMLeJsvv971E5ibxwCoFTz9ILjmn6NIz4KnX3ZeFTN6OWa2clD7S/6gxN+L4/lko+DupqWSmrXZI3A63vbaVK+DnH7APoQA/S8Lf1XUxCb1Ab6+uEXYve+ycGakN4XkaClYqw+hDxc2VuqToZQLzGLXWOfXQVTNq7/okYFOJq8/SgXEpZ3mw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(76116006)(4744005)(2616005)(6512007)(6486002)(53546011)(5660300002)(91956017)(71200400001)(508600001)(6506007)(66556008)(36756003)(2906002)(31686004)(38100700002)(186003)(122000001)(6916009)(54906003)(38070700005)(316002)(26005)(66446008)(66476007)(83380400001)(8676002)(64756008)(8936002)(4326008)(86362001)(31696002)(45980500001)(43740500002)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEo5RmxWbUxsbmgrcHdvNVlnZFZNMm5yM1pxamtuWWR1TldIejEwU0NIZ2RI?=
 =?utf-8?B?VXAyQmptV2loK0NpaGNieUhiTEFFd1BCZE9RaDg1b2lISmtUdTJzS2l6cXky?=
 =?utf-8?B?dWN6MlFNM21raVc5MExkeVNkNkxad3dVdzdKdGZwV0pWYVFvTVUrL0VTK3BV?=
 =?utf-8?B?ek5HNldVVk9IRGVXN1A3R0ZwWmg3c2gvZXZSMnk2eVI2M2FXWlN1dmlhWm9h?=
 =?utf-8?B?a0Y4cnVsZk9VR25mUnlEREFBRVdBNm1qbDQ0NHU0aGtPbEhWR0RFTVVVNkMv?=
 =?utf-8?B?WWFYcUNnMlViVHI2TlRQWVc4RE1lV2lTOWJDOGtjQzRhZzZYVnc4U1l4VDZx?=
 =?utf-8?B?ZlZwT1hGVkpUWlArS2V6R1dobDcvNEo5ZmJkWHlaT0EvcE00S3lERlNvSjZu?=
 =?utf-8?B?dS80K3laY2N1YThXS01uV0F5a1FTNGk1SjhBUTJqNVJpcjFKaDFoSnQraUk5?=
 =?utf-8?B?VmNyMUpQSGhvd293NmJRc3lZRmNRdGZ0NTdKeEVqWmozeFpUMEhtVUFKM3F2?=
 =?utf-8?B?alJXYndsRFN6VmNYTkpoQzZzZStXVHdSYU00OXNYWUVzbE9FZEJXVTRIS1U5?=
 =?utf-8?B?ejF5UUY5MExXWkUycnphZnBtRVNhYmxicjBoMy9EcnhpNDNvaFF6QjUrNFZY?=
 =?utf-8?B?T0hOWjl3cFVXYXZhbkpUemNyaWoxbldzZEE4cmQ4T1BRM2lxNkNHa3BRemdC?=
 =?utf-8?B?cU5JRHQxWHBXVnc3Q09QOWQxNkV5dXV0UnNheXVVVzh1c2p5S0QyYnJmTENy?=
 =?utf-8?B?Qkl1NTJIWk1DMVl0cVBlK3JLaUFLdjR5amtSMUVNNFB1QWpOMWpPSVJOd3Ns?=
 =?utf-8?B?T041VW16U2h6MzF1QnArMHIrVDJid2JKZFJ6N0RZV2ZEVUlWMFRHQVRMOUdN?=
 =?utf-8?B?RnZ4WXROQndSZnJaVlE3bytXV0tmeGZiQVFEWDFxRlFuaFNUd2xFdkpDUCty?=
 =?utf-8?B?L2pUdWQ1ckJ0NkExdEg3Smlxc2VmVUY5V0RrdnhIVjkyWkNQZ3FGTkVFaDR3?=
 =?utf-8?B?a3pBazE0bXgxdnRJczB0NTBXWm5EeUlmaFFLaExvb1k0RWdoVHp3bVdkbitS?=
 =?utf-8?B?Z3kxN2RPa3VSUmhSTUl4cEc1R01EYVBFQlBBSVBOVmRTYzBXOHU5dWVTOGhw?=
 =?utf-8?B?TzFrYXcxbXBtTTlTTnlhV0JRclorVk5GbzJGQU5kRVZ0cGhUSU10K0tVRHdE?=
 =?utf-8?B?NEV1Z3ZSUXR1T0t5SzllUXJqcGRNVWlYaXFBWCt3TDlTaFVjbDVIVjFXWHlL?=
 =?utf-8?B?OFppOHpWQXlQQjNOTkVCT0xiVkViczFGZkVjdDgrNEx0aHgwcmxFcVAyeE5B?=
 =?utf-8?B?Tks4MHpzKzFWSVM2VXVUMXRKYnVVQjhLRVVoNm9nUlN5dUt6K0hZMWgrZThl?=
 =?utf-8?B?K2RsRFIza01pZWNCWEk3V3VsUVVaekhDMC9jL2lOUjRneTZGbTVhMTQwdU5t?=
 =?utf-8?B?MWN6QTNOc1pkbGt4MUdYOUZlR3hVYmJ6QmVtQ3hhcmd5U2RkUE1aM0xVNjF0?=
 =?utf-8?B?SFlLaWI0QVJZNFEvcGRselZQZnpoalZxSUYzbk1MOS9MRVpXaTkwNEFBcW1N?=
 =?utf-8?B?blAyOTJCaXFNUGFQbG5Pb2NpVHRUdlBEeFdDTzQ2NnpQS0ZlRW5Va241Y1VN?=
 =?utf-8?B?d0R6S0M2MUQrMkhENUpIUjZDS0pMNjkxOTUwTFA2R2hiZ0tqamdEalZRVVpv?=
 =?utf-8?B?VWZHQ2pqWmRzTGJJTm84L3RXY0lkeWN4UnZDSkhnOUs3UUhwenNML09nMFJO?=
 =?utf-8?B?MVFiaXNvU093NjlHWHAvN3o1N0srVFJWNDd0OUVQTThteVBTRkJhL2lDVWhj?=
 =?utf-8?B?Mk1QWllIZHB5aGtrRkMyUnZ6QVVWTkdjbVRRRG9zNVJwbVNSekw2cHd1aU5F?=
 =?utf-8?B?b1p6Y28xSEF4ZGVYZjhPYyswcDV3MzFBcGhJRXpncDVtYmY1SStvVW1PWnQ5?=
 =?utf-8?B?Z2NVbUt6YVZhZGxvZEptRXJWZnBTMWZDeWVZYUFqZzIwbC82eUxNT2hBSkFP?=
 =?utf-8?B?K2JKbTRsd3ZxeHppdFZXOUlIb1IwUGZrTzB0a1FwblhPWk5SZHV4bUFqUkR0?=
 =?utf-8?B?eGNUYm5XRGgvK09SRG9GMDZHQjJFeEw1YStJcVRTNlpmSURLZWx1R2s1MXBj?=
 =?utf-8?B?dVZnUThRdGVCSVk1b2s5a3Viajl2UmVpaWQrQlhxdGQwYUlHSW1xMHZDTkNI?=
 =?utf-8?B?bEE9PQ==?=
Content-ID: <B315B704E0242243970070E55F91CF40@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a97b3ac-8f71-4d97-c878-08d9e23e6828
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 09:13:11.1738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f0hTNwwnRDK0aLpuKmNMZtks21K5zltKtcQ8BI6+1cvTfGCzGeUCHuz/1iRddoNVuaxb/ByY36lRTW2WV7pLTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2631
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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
From: Chaitanya Kulkarni via iommu <iommu@lists.linux-foundation.org>
Reply-To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 1/27/22 4:26 PM, Logan Gunthorpe wrote:
> External email: Use caution opening links or attachments
> 
> 
> The dma_map operations now support P2PDMA pages directly. So remove
> the calls to pci_p2pdma_[un]map_sg_attrs() and replace them with calls
> to dma_map_sgtable().
> 
> dma_map_sgtable() returns more complete error codes than dma_map_sg()
> and allows differentiating EREMOTEIO errors in case an unsupported
> P2PDMA transfer is requested. When this happens, return BLK_STS_TARGET
> so the request isn't retried.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
