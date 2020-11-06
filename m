Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7539DC2D0A3
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 14:29:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3DD020719
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 14:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emerson.onmicrosoft.com header.i=@emerson.onmicrosoft.com header.b="yBG62P0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DD020719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emerson.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0DB1986949;
	Fri,  6 Nov 2020 14:29:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cxTy2_5TAIzt; Fri,  6 Nov 2020 14:29:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 51A9786925;
	Fri,  6 Nov 2020 14:29:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39642C0893;
	Fri,  6 Nov 2020 14:29:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AB21C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 14:29:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 55E4B20373
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 14:29:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q-lY4zruhNsh for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 14:29:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com
 [148.163.142.35])
 by silver.osuosl.org (Postfix) with ESMTPS id 40C6A2026D
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 14:29:32 +0000 (UTC)
Received: from pps.filterd (m0144092.ppops.net [127.0.0.1])
 by mx0b-00300601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A6ET0u3070602; Fri, 6 Nov 2020 14:29:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
 by mx0b-00300601.pphosted.com with ESMTP id 34n274vs98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2020 14:29:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+8xucHTOsfMsfK/hbGxgKOCgfsf8raXgJAQ/j6XtwI4QI75+ChnzoHWMMhuc16yKpaIPqMgPTRpMjo5xzsWSyv/uJPTkuedoCMrWtj4bR1QxFPPVCK76Y8VHFy6ptAMhsdxUw/YS5VXac7xBTRYuqrT1Mn6pptKl7gx6biTjUN/nJrbvtv8mT9BCCvWXbSrL/8J1hhIXClsfHGuQPhP3ae+mb/KHk0MOSAsgYL2aEBfPJngKyOCtGOQWp6pCTgLAjidItID555nvGFjqeJI3Q2GS51cC2JyjWw9fqtHSoppxDQgF5ptzux91/BaULt/c23BZx3qJGDjy6EWbKkchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44ZmEMLzz+I5KLnCdDdRSiZBqqhiTllEen9HNvbDmTw=;
 b=n7qe+7uNyUPBKdqLFnFbl+S/vo81n9m2w48eZRpobHFAelj/3qeOgDeZdiTRa6vYeU3wOpbv9FRQRab0lrtrN6RKmj7yN1bXky4KrE//VgvRJh9VFIOVh8RLz3/BdmJMNH8zfHWetaJdlnfIT/1OEEe77vJ0ulpibvflP1AfkX5REwQsW3noF1PaLLMt1KwhXJtJWD0eCKBwsdgbJ4eTVUexo8yBP4gxXFoMfQQFx7CgvKbhOJpJofSW3Edhh+kiY52xIDuwIXpfinqTdNmRtJR4UpX8ITjeYwJmbHiPUhCt0MG2T5bzcRDhZFLF9+vDX7GADR1Bt54DHYojLRBnpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emerson.com; dmarc=pass action=none header.from=emerson.com;
 dkim=pass header.d=emerson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emerson.onmicrosoft.com; s=selector2-emerson-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44ZmEMLzz+I5KLnCdDdRSiZBqqhiTllEen9HNvbDmTw=;
 b=yBG62P0bkjQG1vWt+YayiO39IjKmHkeff60lMRE5uhgl0pl+M+X2B0i6jOQOJkdLi12pvAgC0yDFf71m9sKZm70ohTh3zMkZnzYe27kMsZhyzxsT0SDzi5beQAB7Aeoh6mC79Rsk6r1kJKXftTKIKRz3EYspg3kStRgeCQ1vosQ=
Received: from MWHPR10MB1310.namprd10.prod.outlook.com (2603:10b6:300:21::18)
 by CO1PR10MB4772.namprd10.prod.outlook.com (2603:10b6:303:94::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 14:28:27 +0000
Received: from MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e]) by MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e%12]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 14:28:27 +0000
From: "Merger, Edgar [AUTOSOL/MAS/AUGS]" <Edgar.Merger@emerson.com>
To: "jroedel@suse.de" <jroedel@suse.de>
Subject: RE: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled
Thread-Topic: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled
Thread-Index: Adaux7yL4OYKNrMETgKrPGK8SdhnWADwCzYAAADVBeAAAgZUAAAHYTJQAAGocXAAKw/AQAABvexwAAFDxYAAJDqaYAANk5QAAAF+N6AAAkOogAAAvS+w
Date: Fri, 6 Nov 2020 14:28:27 +0000
Message-ID: <MWHPR10MB131028067DF3AB908DEFC08689ED0@MWHPR10MB1310.namprd10.prod.outlook.com>
References: <MWHPR10MB13109574BDA0F1D8219A225C89EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201104101454.GR22179@suse.de>
 <MWHPR10MB13108FAFDAD3D33132B6593489EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MWHPR10MB13106AFEA3B68E666DD9CA6089EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MWHPR10MB13107C8A602FD7EE065F4E3D89EE0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <MWHPR10MB1310AA6CDF577A1535600F7089EE0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201105123245.GS22179@suse.de>
 <MWHPR10MB1310C1E8308484E2F7F967E889ED0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201106121850.GT22179@suse.de>
 <MWHPR10MB1310A315F2AB752DC789D4E689ED0@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201106140625.GU22179@suse.de>
In-Reply-To: <20201106140625.GU22179@suse.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=emerson.com;
x-originating-ip: [194.140.115.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf1c129b-c493-4564-7b41-08d882603a06
x-ms-traffictypediagnostic: CO1PR10MB4772:
x-microsoft-antispam-prvs: <CO1PR10MB4772E54696B1DFB2F27FB4EB89ED0@CO1PR10MB4772.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DbcXrSsBdo0O/bl1MqjaAurf36iQcLzI6iuN+0fsPkhXemzMhx/hRuVYWI75XiraGMFC0OvbngrZQjjNTZk8ZfaYVI1q/SENHjDxjjwwAHHHb4BN7Y68AmtRzpksRXOXxcCikw4Z+u4QawBE8AmMgIYoD4zNF8VhtqdTJndAyCCb42eoJlcz3zD7N8vs9OxxdMplVELT395PBNxFS11ChCIfRspz8byZ1GQ2Y98JV2U1fizfulVVZqM4nJVhOj/VUlYBkj8UT3kgGLnuUJpJ/RHUwcGjwXQ7g2fkkwhCtGMC2h78UUHOYnTwD0s+7R8QJyQT1OoroFgh0Y/b5Xiqog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR10MB1310.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(366004)(396003)(39860400002)(136003)(6506007)(9686003)(55016002)(186003)(478600001)(4326008)(8936002)(76116006)(7696005)(53546011)(86362001)(71200400001)(26005)(316002)(33656002)(66476007)(6916009)(64756008)(2906002)(5660300002)(52536014)(66446008)(8676002)(66946007)(66556008)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: XAzFa438ZWLI5kWqCtyZo7jwQ/bJrIp0icoZQB6ugKF2BBMrFOfzJ9FSPe2own1t2GF4VxfJp3xT2RrojqOkB2bdcYWPS8s12jCKwrZrIBlDaYoL+qc/BnpylY1rEZsDP6TktnemBcB/zCYUR4ofvUvroA8+sWDDizp44spf9rNHFVAJYIGfBMlRCepKPWHcNIsk2H9D79jSnwRzBjwcrZouB0tejOvnexG3mC1EkHYjSNTTsd0ojXb9DZem09G/bDzVcvsRI1w/0TWRFo2D5zYNGStYTp8i41VUXdoQjLIgye/t+dpeMLISu8er3PXLsLnLsEesoeUmzzqAoZILC1aIkOeSgMob1oOxa8BwmxCFkV4sqpok9iN9c+oHTulrbeVPGYD+8Xd2/fWLc75S3LIVavlNY57gUa78T20CVfqdeV/kYQU8AKnUlXUtBT1Ad60MWTLysVU67+H4mEPeikJiC7SHbykj5x+Mv8OIcOTbj+FCf8nuyVnOKqH4hAcAOX1Xv1/Ue6ylFRQYpEdoSC7d3uuu8DhqMlyEqrwtl0G7YG5KPEBvwf+1AQS2MJRmiMQb8DfFnvX/PhopDzkCW2Aq7bomSTFXnl97KvNNu0sQbG0bg7HFrfZG6L4B7MwdM7bEKGZfhtsDspiSdBAztA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Emerson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1310.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1c129b-c493-4564-7b41-08d882603a06
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 14:28:27.4330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb06985d-06ca-4a17-81da-629ab99f6505
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NUpgm0xqa3pWNumfCH+2NgodxOiruAEzlZHTGTf/Crvh5fCW4wweglvrVRJjZZ2bb1GYihMUQrUzhDqqdBzSQEUs1lvrf5UEDoxiT0FSq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4772
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-06_06:2020-11-05,
 2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060103
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

Alright, so is this going to make it into an upstream-Kernel?

-----Original Message-----
From: jroedel@suse.de <jroedel@suse.de> 
Sent: Freitag, 6. November 2020 15:06
To: Merger, Edgar [AUTOSOL/MAS/AUGS] <Edgar.Merger@emerson.com>
Cc: iommu@lists.linux-foundation.org
Subject: Re: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled

On Fri, Nov 06, 2020 at 01:03:22PM +0000, Merger, Edgar [AUTOSOL/MAS/AUGS] wrote:
> Thank you. I do think that this is the GPU. Would you please elaborate 
> on what that quirk would be?

The GPU seems to have broken ATS, or require driver setup to make ATS work. Anyhow, ATS is unstable for Linux to use, so it must not be enabled.

This diff to the kernel should do that:

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index f70692ac79c5..3911b0ec57ba 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5176,6 +5176,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_ats);
 /* AMD Navi14 dGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
+/* AMD Raven platform iGPU */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, 
+quirk_amd_harvest_no_ats);
 #endif /* CONFIG_PCI_ATS */
 
 /* Freescale PCIe doesn't support MSI in RC mode */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
