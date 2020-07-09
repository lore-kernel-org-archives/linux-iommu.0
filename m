Return-Path: <SRS0=szPT=AU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF528C433DF
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 22:46:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C399206E2
	for <iommu@archiver.kernel.org>; Thu,  9 Jul 2020 22:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="jDoXx873";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="IintuHGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C399206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 42F482DC02;
	Thu,  9 Jul 2020 22:46:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YZUTFvaVlV5s; Thu,  9 Jul 2020 22:46:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C9AF92D433;
	Thu,  9 Jul 2020 22:46:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5BD5C0865;
	Thu,  9 Jul 2020 22:46:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 096B3C016F
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 22:46:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 00F94881ED
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 22:46:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yiuxa4G3vLrY for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jul 2020 22:45:58 +0000 (UTC)
X-Greylist: delayed 01:46:23 by SQLgrey-1.7.6
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D31BE8808C
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jul 2020 22:45:58 +0000 (UTC)
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 069Kqfm4003628; Thu, 9 Jul 2020 16:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=cYIa1YP9vY7FM8/3P7OYKUaihRU3mUcPGWF0yR/Ul3o=;
 b=jDoXx873AOh3FIZ/8cNHCp6+MgyMLU5t45NNNHVB8P95aBb8K6+ZbG6NGWrJ6nOLDjZ8
 WqaoH+DNjRgl1Z0+uZRjQRaklrI3/oeANkrNTw+8I7TbyTjX8kcc/wNsdRyX15MzTjHt
 xrIFWrLUcmXWSuEjdqhz1wF92R09sP9Y9zPMs61TaN1migD2yOP0bXjmz2628xkAA7DK
 XpzIfgyvMUPiumjeSel5JJ+LNPG8RTpbOk9f0r0rahqPIDbgeb/W6WiBCnxSm7oJl+vt
 0aKzY931WyuL08cdDDw0Irl7hYbgFYv9kPeizs6tRyWdPMI6M2HJSY0wF9WcpMDZe86b 4A== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 325k13mhqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2020 16:58:22 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 069KrP5J043427; Thu, 9 Jul 2020 16:58:22 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com
 (mail-bl2nam02lp2053.outbound.protection.outlook.com [104.47.38.53])
 by mx0a-00154901.pphosted.com with ESMTP id 326anr01s0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Jul 2020 16:58:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqIFmBshMO1SadOwtgWMx01fnTISILmd0m9q0hTLS0JKQRTeH4lhCeQPjUybkmoy+Hw7EcD8Bl3vbb0WlzwSJY545cnZYxDWKMGshG1uHBO3s12LOJEUdSVdPiGY9dJmvzTKAG41zvV+orqvH3IULaN0vNcl2vC0JRBTi2xkH3CTDCQ7YpuTQdSk6sE+FTZyqxdfISsEhgoeUXSGYcxyeYY2jU4uHe2ECMh+lHniPs2+3iLJZ+jB4pIy6JgRkeFJtMkkYhk2lVLk4RBziOgwVI7CbYw/7/0WIAowXLWtWYpaKvrqSgq2J6tNdlD7d2LqHQnIs/CSNczbyocZjaT2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYIa1YP9vY7FM8/3P7OYKUaihRU3mUcPGWF0yR/Ul3o=;
 b=ZVhc27qWjHSk1FfY0fkFu0hM9Xu/O+eJ5l10ukuv8XaMg6C2Hof0O71jjYrN0WYb+r5SNgn8BUPMgMihZ8V9EEHovRgX5WL0xOf9xTEWTtJjEtyfrQiuVdT6ii+GUTB5COtntARRhhVNS53BAbktSykF1UPyClRlzgQtUXYmAXTZTJ+UPug8bKjixVnI9x/t7mqx4y0BS57QPd0gHF4XNPb52bkbiPmLKKUEbAGZJH3oL9MmVn3A8Alxb9Tf+Fw76x+ApyutMGsA0xbKeXrruuPsWEqK3+S49P1Il8pD7ni3EN/KoQ0fV8hCk6FNtV+45uyr33pAeCt75fekV8U7lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYIa1YP9vY7FM8/3P7OYKUaihRU3mUcPGWF0yR/Ul3o=;
 b=IintuHGSJ2ZMqcyBrmu7mX0n8LyVQOfMdEK9FGfrR/V11w6mpOnc+I4+HuQrOFsDgU1sTRBKlSKz4GBdBha06uRA7FIn0wIIOXcdrD6sOyB/TSc+N5npHhHZyIk2umkaOdiK8wy7poV9CQOlnilRE6wSiI7ZnOf2H/G+ApIff7Y=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM6PR19MB2570.namprd19.prod.outlook.com (2603:10b6:5:186::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 9 Jul
 2020 20:58:19 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::f1c7:5bf4:a3b:ff40]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::f1c7:5bf4:a3b:ff40%6]) with mapi id 15.20.3153.029; Thu, 9 Jul 2020
 20:58:19 +0000
From: "Limonciello, Mario" <Mario.Limonciello@dell.com>
To: Koba Ko <koba.ko@canonical.com>, David Woodhouse <dwmw2@infradead.org>, Lu
 Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
Subject: RE: [Issue]platform/x86: iommu: System can't shutdown because iommu
 driver keeps checking the status of DMA_GSTS_TES
Thread-Topic: [Issue]platform/x86: iommu: System can't shutdown because iommu
 driver keeps checking the status of DMA_GSTS_TES
Thread-Index: AQE6LD2bQSo7R/55QN/bxAqAAD8XOKo4DH2w
Date: Thu, 9 Jul 2020 20:58:19 +0000
Message-ID: <DM6PR19MB2636E5A28FB655C2F657FDF8FA640@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <CAJB-X+VcHvYWngtMVHw5f_XaqA4i4T61yt=h7YvuD=eo3y7Rog@mail.gmail.com>
In-Reply-To: <CAJB-X+VcHvYWngtMVHw5f_XaqA4i4T61yt=h7YvuD=eo3y7Rog@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-07-09T20:57:29.6395961Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=e4a9b2ff-26ab-4323-87ae-923884b2b7be;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0472b241-1689-410f-ef0c-08d8244acf3f
x-ms-traffictypediagnostic: DM6PR19MB2570:
x-microsoft-antispam-prvs: <DM6PR19MB2570AD4B640074C9B0C6CF6BFA640@DM6PR19MB2570.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mLUJgU505p6dnGaiul5cGI3Z/mlPcdlTBVPDMvNudheAVjDXqgLbHmTcZpAr070rtT9ooe6MymOfKOaonWnapBpkVdNGheUTxxRtcEHPNj/HMD9nyldhEbAqXKH6PmYx7Zqzs5wxthfHInxkaY+5fJ5aRAOGLagHVo0MnwJxlDnsxxJDdTxdPPauUneuZXpu4Cqoma8oORSnbhjArp7sY1c4sA6v2445l9/pk5rwkJfY9ifSAycyrEpLQhFTFhNiYL+bxIrfKsWixbM6+a8Kr5/PUE5EQPX5QmKOwNawIrYV6kQnZXKyLyqZB1ukvCKIXEH2t2zBQAcGJrqgMt8WbJSuFQmjAV9fVA7hKdeMeB2zfYW45urWK97NJ/Gh/1fMdtQG6P0HtjG0R7HUCuNm5Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB2636.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(39860400002)(346002)(136003)(366004)(396003)(110136005)(66946007)(4326008)(9686003)(66476007)(55016002)(66446008)(76116006)(64756008)(66556008)(966005)(86362001)(83380400001)(478600001)(7696005)(33656002)(8676002)(53546011)(5660300002)(6506007)(8936002)(26005)(186003)(54906003)(786003)(316002)(71200400001)(2906002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: knrXPM7xG4YWvfHK986PBmzmPfNjKGHpXbHbqEH2Mcwae2gn2wnx8WjGs+HfklR/lhHOZq9B3De0BTPnC7Du7zztXb4qZACU5QLSNt/dBQlpL69ZsALRG5eMGKc5a2rgtzbfD+53F/SvQCMhHQcozzTBaw6dxk8dex8kKi31VCuZ7xJUyAFFQt0ehLkZUp06/XBqdh2C11CnkjhIYKb8scsRCx5TaPKXf2VyURyy34Upa0ADU6cokNUHpJIbJdb82UyqBRaA5Ud9Dek8fomyvezEZj9Rw2TrthBoUNTuIMuT2/SBayOW89SuFQJGk9fopczXA6yHyhyE3Va2QyJkx5c9i+WbueV84dCB0EDqksxyRpbGKrtoHkVi3MXLzV/T07zxYBmVY/dRB1c08kjkNnEYUrI3eGv3EtUT0op0sHBqbzQuwGCliIuOH3S45Hb2uy5zmxtwtC/drEUiuR5DCllNeSBZvTmh1ibtOQFJJgcWpsleP+brz7TzBvYv7EfM
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0472b241-1689-410f-ef0c-08d8244acf3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 20:58:19.5029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IrBj2azgjtT76QmuX06vbOllZaN9M1GFPv4x+L9gyY4dusLp0hsA8bugTbsrPuh+no+UxLgQ7szy99jHY1kQICLEkVSlJCIrPVXO2A03soM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2570
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-09_11:2020-07-09,
 2020-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 mlxlogscore=999
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007090142
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007090142
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Kai Heng Feng <kai.heng.feng@canonical.com>,
 Christian Kellner <ckellner@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> -----Original Message-----
> From: iommu <iommu-bounces@lists.linux-foundation.org> On Behalf Of Koba Ko
> Sent: Sunday, June 14, 2020 10:47 PM
> To: David Woodhouse; Lu Baolu; Joerg Roedel
> Cc: iommu@lists.linux-foundation.org; Kai Heng Feng; Linux Kernel Mailing
> List
> Subject: [Issue]platform/x86: iommu: System can't shutdown because iommu
> driver keeps checking the status of DMA_GSTS_TES
> 
> hi All,
> I have a machine and there's only intel gpu.
> the secureboot and vt-d is enabled in BIOS.
> On the Ubuntu desktop, I do s2idle first and restart the machine.
> The machine can't restart successfully, so I need to press the power
> button to shutdown.
> I tried  each of the following and the issue can't be triggered.
> 1. disable secure boot in BIOS.

Just to explain why this happens, on many of Dell's systems VT-d is only enabled
when secure boot is enabled.

> 2. intel_iommu=off.
> 3. intel_iomm=igfx_off.
> 4. nomodeset
> 5. i915.modeset=0.
> 
> After I investigate further, find inte_iommu keeps checking the status
> of DMA_GSTS_TES.
> During the procedure of restart, the driver would disable iommu translation
> and
> check the status of DMA_GSTS_TES until status of DMA_GSTS_TES is 0.
> 
> If you need more information, I can provide it.
> 
> Thanks
> Koba Ko
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

This is reported on TGL pre-production system, but actually same symptom is also
happening in ICL production systems such as XPS 7390 2-in-1 and XPS 9300.

Details for the ICL issue are available here:
https://bugzilla.kernel.org/show_bug.cgi?id=206571

A user did bisect it back to commit 6c3a44ed3c553c324845744f30bcd1d3b07d61fd in
5.5.  Glancing through the code and comparing the suspend case, I would ask is it
just a case of missing a flush at shutdown (IE iommu_flush_all)?

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
