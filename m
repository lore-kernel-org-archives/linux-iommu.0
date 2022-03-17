Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC928C433FE
	for <iommu@archiver.kernel.org>; Thu, 17 Mar 2022 19:13:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6388E401D8;
	Thu, 17 Mar 2022 19:13:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Bn9vIo-Y_oD; Thu, 17 Mar 2022 19:13:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2EFD0401CF;
	Thu, 17 Mar 2022 19:13:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB475C001A;
	Thu, 17 Mar 2022 19:13:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 403FEC000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 19:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2271C60AF2
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 19:13:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=microsoft.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IFQV71RQT9ia for <iommu@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 19:13:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from na01-obe.outbound.protection.outlook.com
 (mail-cusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD23660AAB
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 19:13:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVSl1mD6paGBstA1CqyGLoz8WQPEBB20iXR8jYUlTaYvZOQFs6yLlMNEpUi3KZ1lxCaQYp296+kT1pU33EvtAec7Hfo/yADeE0D0Bh8xG8bur3vKCoRn6AXFkAlrqTkR8qVWtWkvfj1/qO76I3uwmw2InWBl9xPvpq1DzrRoa95aQMvLBE33fltJFafSEoesm3Iyyqtyw4iwTc/f/+ze9Zna9fmsH1DQ17zPvv3nM+7EdYUrM9TX7SwPs1Ww0Y4kSlHLP8lTfAOvuh6G/tjemxIIkLzFakSvdkfdiDo6sJ0YEOk2lOo5jjUigZIR6a+42t/oWIHogkrZlbaAQCFIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRHHh9VbNmY2UeVUI7DQAbJtWaci2EdBAZq3Xtnqn2s=;
 b=jDWrc4cS+asA/f++GXTIcxNzF+2DMEb/G5+H577OAwRKuPyRrF5o+5D9kuOwLcLrRtv/homWcMCXZjyn58tBggg21LYEMxoUJwngKCjBQUkAFWq/+81O4uzy59s6fnSVAMePKhCBeCUWluI3GXjevhDjK1/91HKlQ6B41WdgeUBqm+RehWHxKXJQBMskUwKx6/fldfX+GU5jyum3N0kztz8GxuE5NShk+GCS/fTLfx4w733eocqPjn7e1oX52ZW4xxdzzGPyWnH78UWZI+ZWnlxzimGI8I1H/jX0R2EdWJxzILuvZ592pnYxNUbAg6k5uqViqQpvAJ3ucH4NcqF4Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRHHh9VbNmY2UeVUI7DQAbJtWaci2EdBAZq3Xtnqn2s=;
 b=KrpnoYJka13XisV6i9Ft6dz3cc91mzyOboltZINb2/THxKV70+sUPlF48OZ7NFd8rzFJaIqWX8S57p+GyQNL5449dys0e1wJFBmQqlbxVysaznY4j8Np+qiEu71cPDC6pXSbSAwBCKyy007TxHHOpIC5d1qrJgtoTJ6c63w5RIE=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by PH7PR21MB3092.namprd21.prod.outlook.com (2603:10b6:510:1d0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.13; Thu, 17 Mar
 2022 19:13:05 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::44a2:4767:f55:7f2b]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::44a2:4767:f55:7f2b%5]) with mapi id 15.20.5081.013; Thu, 17 Mar 2022
 19:13:05 +0000
To: Robin Murphy <robin.murphy@arm.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "lenb@kernel.org" <lenb@kernel.org>, "lorenzo.pieralisi@arm.com"
 <lorenzo.pieralisi@arm.com>, "robh@kernel.org" <robh@kernel.org>,
 "kw@linux.com" <kw@linux.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 2/4 RESEND] dma-mapping: Add wrapper function to set
 dma_coherent
Thread-Topic: [PATCH 2/4 RESEND] dma-mapping: Add wrapper function to set
 dma_coherent
Thread-Index: AQHYOhun4uC65iF9N0WLjvFVH12YmqzD0iIAgAAbKEA=
Date: Thu, 17 Mar 2022 19:13:05 +0000
Message-ID: <PH0PR21MB30252951848A6328E11385A4D7129@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1647534311-2349-1-git-send-email-mikelley@microsoft.com>
 <1647534311-2349-3-git-send-email-mikelley@microsoft.com>
 <d480c8ea-f047-2854-b1cf-041475b451db@arm.com>
In-Reply-To: <d480c8ea-f047-2854-b1cf-041475b451db@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e73d3442-4fef-4f72-9469-060e771e7504;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-17T18:56:47Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2110d7c-4007-4223-fbad-08da084a2a4f
x-ms-traffictypediagnostic: PH7PR21MB3092:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <PH7PR21MB309296C4B315D5886B6501ECD7129@PH7PR21MB3092.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HfNDm9PDKdYWyQg0R3LIKGjShRjNUUsLEG+F/pIHww4lqaaWwIDkQeXv0cpH+GVvZJNp5CCaEJv6NKrbZOYLdi8hWgoSSzmx+bmWTJL/V0ccwk3vRblMmNI8IMpj39YfmbfrxO0uLBFtCTU+6wariSsAkIHSQYlhHEJ8mrvwZgj6LuVJq2S/hMjWaai9jhP1llPj3ZIaEG2MMI5UzR4siJrKgJmqVrpAEjaBWIFaLQAp+/5rD5gU/OsXKT+UPg+nHPJNmtYt09D72YP7YZB/Y5Rm3Bxhqic4Y96QQ6D6aFWvVMyGyh1PzjHx7tjm7bqsozaJcwlXG0wVCxp19H5XJvJu+gt0P03Ibx744/9ICMVtQGQTpXlqZOR3PFjaoIU3EkY+HAmbGM1hWgJYPUs+yFpOvzaC5wLli91atl64os0iiq8DlooUdMwvt8wlJrUrrhL0lgizu2iQXJbQIjzLdGipBJX6BUbdaU0Ppiuzml8Zw8DBF3uJds0M2fr1HyL5p57kb2GSm+9wEEhxt6n/rSyCjyg0rsDuKCFcuVpNVHxICYEOkM9dMAk+Hl6i8eQRlU4iuvDJfVQfJBrKj6vMjRgqtNI7uTVmzfvNwwvfQT+0NqK/6DX1FhnDfJHmbJuIrJavremCcbjqS8IGsTZh2LEIDZfN7nidl+CgBqcYGzAzP35g+Ux1iqb0gsfdgnDWV83/IQ0a/9mn1s5H3X1EUyBe8Hnnv7vEKqyl0PLGAphsaVMA2LhfuXgN9ceOtHUjd9LGc7X35ZlnfIp0bl+wlA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR21MB3025.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(451199009)(52536014)(8936002)(186003)(26005)(8990500004)(6506007)(7416002)(7696005)(5660300002)(53546011)(38100700002)(33656002)(86362001)(9686003)(66476007)(508600001)(66946007)(122000001)(76116006)(921005)(38070700005)(10290500003)(82960400001)(110136005)(316002)(8676002)(2906002)(55016003)(66556008)(66446008)(71200400001)(64756008)(82950400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXVhRVNyUDlMRmhFSmJFK096K2pucjZ1YUNUUkpHVmRjSG9tNGxMM3kzL3lz?=
 =?utf-8?B?bXR3RGpiL1VWKytOMlhleERLMjAyYTFTM1RJY3dOMzRTK3ErWGJVNGxueVNJ?=
 =?utf-8?B?Qy84R0RUMCtuTVlxYjV4S24zSkluMGswOUFrUEpTRVorSEFac1B6WVY3QkJZ?=
 =?utf-8?B?VldhT0hpbXJWQmR4ODk5T3hDTmJUaWJ1WGd4UG4rNkhVbEV0NWg2TWlVSkRz?=
 =?utf-8?B?M3ErRjlZdUNqeURIS1dackt0OFgwWHBEcnZCWWxzY1VKN3VjME5VdmVPU0Fx?=
 =?utf-8?B?bFE1bys1c3EveWV2MzNUelNJRHVzN290MWVMWm1wNFd3MkhmTWc2aGhVWEtW?=
 =?utf-8?B?TENiV1FpcE1CenFXMEVzdC8zeld6ZGdhUFpJdFhaakZkc0srYldlTTIxWFVX?=
 =?utf-8?B?NU81Zkc1MDBrSUN1MHBkZFNWWDZWQkJseENzWjNhb0NZZGpnQnZCWC9kaDA0?=
 =?utf-8?B?Znpjb051eXFLSmVic2k5VFZCRy9YZmo0VmZRSlQ5WlNpb0xWK2JMaTVCSkcx?=
 =?utf-8?B?VTV3WjduajFKTU10cW9IaDkyL3NVamg4NlpUQkkyWnU5aFNCbjF5T0pQUUtM?=
 =?utf-8?B?MzI4dFpVS1VuOU5PMHk4aE94b1Q1N05JNSsva2t5Y0xQNTRZRkxsNHBabFli?=
 =?utf-8?B?SnhCMExmcjFIdXdveVdmYWMrSHlkNnZBZnJ0WTF2QWJuekUyRnZpMnFyTkRN?=
 =?utf-8?B?QWl1Zk14V1RPb1Y5ZW9Mc0ZsYnMvbEpmRVFlRmlBMEZjenp0QnBDeDAvaDgy?=
 =?utf-8?B?OTd1dzI2NktZTTJxdnFWNGRPTjhDeHRoM2RVY3ptdExjWkdEcFZuMm9VTW5P?=
 =?utf-8?B?WmNlWVd6alU0S2xUN29UUXp4NkR5WDR5dmhCeE1jNTVOOVUycHpGQkQ5NjdW?=
 =?utf-8?B?MkxLVVJRZVdoTHlWVFN4dlZRMVk0NGdzcnRYVnVPNE10dzZ6eDlnR0FQbFAv?=
 =?utf-8?B?M0h3NXFNUlJCbkwxdG1FQXZxZmYvbG5rTy9EM210eFl0UDZXQmJOT1lHcGhk?=
 =?utf-8?B?UHNxYkVOL1M4emZZMlhjc0ZOeElFemp2V1RoM2pnODUyMlpHVEY0VW9RVkYx?=
 =?utf-8?B?ek9uTklKTVVXZEpsLzFDYzFmQThDRE9DNi9lTDI1dStSb1B4TTVSc0l0TVFE?=
 =?utf-8?B?Y0NVRnFveTMzSThpMjJjUndsanI5TXhVOFdjc2tkZDd5VS9heUo2SVgrZ3VW?=
 =?utf-8?B?Z0w3YXRwaUJ5QjM1NDNCSlMvM2ptNFV5ZlRoSmdjV0VYUWJLOUlqaDdxM2ph?=
 =?utf-8?B?Nzh6S05SVHJRQWxuSUtaSmtDQ2pjWFg3OWFCd3lWVjFQM2NncHJyZW9rdUZp?=
 =?utf-8?B?eFl5WlFOOXZKR3dnR2phMlcvRm9wOEJnbTlvK1E0dkxjZ3A0UE52TDRXVWZU?=
 =?utf-8?B?am9xNWxwNjVtS3VwclRRNk5TdnJoRlVvSWR3RXhyS3dhUUVvTnoybEQ4MlRr?=
 =?utf-8?B?cFIxbGFKejhqcENhbTRCbU90STVQTVlZbGNpRHgybXdJejNyWERwZ3pteUx2?=
 =?utf-8?B?VUVjNituWTdrSGE1R1o3VElSb3dXTWs3VnBLVzAra29LYTNZOG9XdzFzdmFy?=
 =?utf-8?B?clFRdXNxcmhuSTBNZnlXWENLdW5MekU5azNJVHR3b0hxdjg1UjBvUmtNR0NM?=
 =?utf-8?B?ckt2bFRBS1Q1cWlSOE1wd2ZoQm05Zk1NcDFhY3NlZmtJRUlXdkJ5VVpPeE9j?=
 =?utf-8?B?YnpEMUFvZlhGTzVId2NiMVNrcG1LUEJRZ1cxamhDNGc2Rlk1azhTRzRLcEsw?=
 =?utf-8?B?S216K1QyakhOMExUQmhFQndlR2JXVmNmU1VOMVNCTGU3YnhzTzFrSURTSmpW?=
 =?utf-8?B?dU9hZ3RyN0xlVGFGSVNrUW96ckdIMFpaVjRkZGRkN2xUZGdFWjkwWjBnZTBK?=
 =?utf-8?B?VVJ1MGZmdGZ0eW1sVVJ1Ykk5TStwZU8xSmtZMkEyazhVdEZ5VW8xVytMK0Ew?=
 =?utf-8?B?cnFlbmFjUVZpeTBsOTdXT2FuY2VYM0QyRkNHYlhPUzZ1UmJZUWtlZWt6S3lv?=
 =?utf-8?B?M0hsSG90K0VnPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2110d7c-4007-4223-fbad-08da084a2a4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 19:13:05.4683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otOJQnKUffVX4rffvQFYdCtA9nyZ2CuoeFkyZ6NbMxe0svZ8CTBK/O90M862ULB1RguN5+67gbg2+CfgcT9FSH+Q8LfnfKglMJaWrZxlN1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3092
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
From: "Michael Kelley \(LINUX\) via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Michael Kelley \(LINUX\)" <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Robin Murphy <robin.murphy@arm.com> Sent: Thursday, March 17, 2022 10:20 AM
> 
> On 2022-03-17 16:25, Michael Kelley via iommu wrote:
> > Add a wrapper function to set dma_coherent, avoiding the need for
> > complex #ifdef's when setting it in architecture independent code.
> 
> No. It might happen to work out on the architectures you're looking at,
> but if Hyper-V were ever to support, say, AArch32 VMs you might see the
> problem. arch_setup_dma_ops() is the tool for this job.
>

OK.   There's currently no vIOMMU in a Hyper-V guest, so presumably the
code would call arch_setup_dma_ops() with the dma_base, size, and iommu
parameters set to 0 and NULL.  This call can then be used in Patch 3 instead
of acpi_dma_configure(), and in the Patch 4 hv_dma_configure() function
as you suggested.  arch_setup_dma_ops() is not exported, so I'd need to
wrap it in a Hyper-V specific function in built-in code that is exported.

But at some point in the future if there's a vIOMMU in Hyper-V guests,
this approach will need some rework.

Does that make sense?  Thanks for your input and suggestions ...

Michael


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
