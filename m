Return-Path: <SRS0=BbwH=5W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9185FC2BA80
	for <iommu@archiver.kernel.org>; Mon,  6 Apr 2020 10:02:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A972072A
	for <iommu@archiver.kernel.org>; Mon,  6 Apr 2020 10:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="KxaaQIbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A972072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 295E087D77;
	Mon,  6 Apr 2020 10:02:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id etYgthaP09O5; Mon,  6 Apr 2020 10:02:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3F25586061;
	Mon,  6 Apr 2020 10:02:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AF05C1AE2;
	Mon,  6 Apr 2020 10:02:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 253E7C0177
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 10:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0A2912306F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 10:01:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RjF+lTqA6ziF for <iommu@lists.linux-foundation.org>;
 Mon,  6 Apr 2020 10:01:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400108.outbound.protection.outlook.com [40.107.140.108])
 by silver.osuosl.org (Postfix) with ESMTPS id 951EE207A2
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 10:01:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKclT8SSW6xUw9or9LUyOec48tuwvzOnzubgTBKeiREX2o3rO+vzh3rvK4uVnDmXfzadUQYsW+KeV1zE1kYjwYKWRhxxUoTDJAfhu88LtKF1nhUUFGPweUpjEjGr+LfU5LieDwL6Vjbu27xpej9FHBTf3iWrv+Yki85gmv23pWkjAItt2nU/wRZbEhcWUcE3t9AU2o552sRYIcIawrjcu/Bm5vdeZrki2YLycNobM4jmh2eO+dMKGR89Sm99BMEMQE7Vvk9NRS9t6dxnHRG/mpjei/wpyiLnocV/xiV3J02tDFlbhqA0D8V+BX+cMrsZJUDlzwpbwMVPLAE2sqpXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuxuSojrTZ5mrYPsKKNEW1NuQt6W3hfYbPkPqQ6lCdM=;
 b=FMWlQn3fc1/5yiM9KM4PJ5h6lPSLGV2A0qSNtw0389Gdd/appHnB+W1nECv1zBptFWioYBuLsf/sK6XRXKCen9yQbizsp4qF5vVNCPXHzwQUSiDPSsEfhGAbpfvQmJA+xwwvfXlkSLzPbNJ6NJkLJDNeY8V/shJKqpk9S0sLcXykR80HFsxxvW1gQOs4dqqknlzB9iNyrUS8ti56qPZHQHNoLhrW1gECmYrB3Uyi35kMUTmYXFoTxSazavVAHrfPqfo8RcZ6id+tIMzXSEo9p+8sJQJo6FKoK4Z5n6m20al3jq/G10siFsLFFdcFFquIS29lHXvr/+52AeIM+biqJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuxuSojrTZ5mrYPsKKNEW1NuQt6W3hfYbPkPqQ6lCdM=;
 b=KxaaQIbtQw9284Sw/VARVf/MUo4Irfa0/n3HzO6qYBgy7WMbY/ZSAY92ob7ew7ZjSPCHh+U9Rk4CClFpSz4PsZw4vzxHyxbPFNDpx27vnvQX4NWllM2iT0WQfCX6e5sGWYPTEzZkPv8YqCadHrHdVuhmuQeAVXkq/AS4bODcnRs=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB3856.jpnprd01.prod.outlook.com (20.178.140.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.17; Mon, 6 Apr 2020 10:01:54 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2878.017; Mon, 6 Apr 2020
 10:01:54 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: John Stultz <john.stultz@linaro.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>
Subject: RE: How to fix WARN from drivers/base/dd.c in next-20200401 if
 CONFIG_MODULES=y?
Thread-Topic: How to fix WARN from drivers/base/dd.c in next-20200401 if
 CONFIG_MODULES=y?
Thread-Index: AdYI1eHeE+d8Du49RZSXfyqelir+RgAPcQ+AACaCwgAAIpzUAABtUcqgAAMnEZA=
Date: Mon, 6 Apr 2020 10:01:54 +0000
Message-ID: <TYAPR01MB45443FA43152C0091D6EBF9AD8C20@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CALAqxLWopjCkiM=NR868DTcX-apPc1MPnONJMppm1jzCboAheg@mail.gmail.com>
 <CAMuHMdVtHhq9Nef1pBtBUKfRU2L-KgDffiOv28VqhrewR_j1Dw@mail.gmail.com>
 <CALAqxLX2AEFJxqXXXKPs8SU7Su2FqNjwbSt5BxwmQJqYQuST9A@mail.gmail.com>
 <TYAPR01MB45447DFE9E81D77CA867DEC8D8C20@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB45447DFE9E81D77CA867DEC8D8C20@TYAPR01MB4544.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04893ba5-4c5b-4ce4-c177-08d7da1188e1
x-ms-traffictypediagnostic: TYAPR01MB3856:
x-microsoft-antispam-prvs: <TYAPR01MB38563D264B942DA6C6B27FC0D8C20@TYAPR01MB3856.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0365C0E14B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYAPR01MB4544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(2940100002)(54906003)(2906002)(8936002)(7696005)(5660300002)(55016002)(66556008)(66476007)(64756008)(110136005)(66446008)(9686003)(52536014)(86362001)(33656002)(76116006)(4744005)(478600001)(66946007)(71200400001)(8676002)(81166006)(81156014)(6506007)(4326008)(316002)(186003)(55236004)(26005);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mlai7qN/Z0vAZR072P+hQbZnvEBxwrx/SNyOPurdKT6AR0CJuzhY4USEYzNITl0FEECdWNmNdz28Q46QCh17JSOqSKW5yzvXN9rOpMk1aWdgCGoavRvwKDDLAT/QhAFyoFhvfxhL/6rOvD3zhDKQs5dJ/LF81lB92WqxJL/MSh2gxoleBxyoyjXq0u+42+eWmhA3PWNzaumYTsr+hitC71evIiZMtZIU4ZSBWOXWrUbwGJAlF2bwfSad8k0DEQfFqco4o4WYXakk+AVJT5ZBK71mtHWnBjup50oZuEZPw6R8x3Utb9Cs4Wgggvcf/JCLdVFQ6/pwrRllhv5Naoq7nfZ1ENb1XG6z00jH6dEJADSDLSFoEpyNzUc3b0XzF3UzZUQDg7pfKRKgHKlvVfIquQJQkkFwMAbxhiCGvOs5rk9XCLupR+tJQmvSwfEkE1w1
x-ms-exchange-antispam-messagedata: syDBZF21Si1AS472cmz891iQdvDcJivLnEl0JTJvDbErvxiTkSLbApAYq6fG2e3nCDRb9lSOGfwXgmBh+8YeGodtaeiudl3LTxjMq8IaECOriiI5gxd3KnUDemeqNZmxeQUcePY+bvVAKdHw/vSfZA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04893ba5-4c5b-4ce4-c177-08d7da1188e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2020 10:01:54.0820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lSTa1cBryjOlJMrAhIT/X8bCGujjGH6hKb50T5ntCI5h8A62/PM93miU9XlonwhaCcr9tp4cZ+AXM/fXQO04IADZvHolxsOrec9e5b6UWvFLLPvaBkYHJQDEvB8StXXt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3856
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>
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

Hi again,

<snip>
> I'm guessing we should add the following flush_work for deferred_probe_timeout_work().
> # Sorry, I didn't test this for some reasons yet though...
> 
> +       /* wait for the deferred probe timeout workqueue to finish */
> +       if (driver_deferred_probe_timeout > 0)
> +               flush_work(&deferred_probe_timeout_work);

I'm sorry. This code caused build error because the deferred_probe_timeout_work
is struct delayed_work. Also, I don't think using flush_delayed_work() is
my expectation (wait until the timeout of deferred)...

Best regards,
Yoshihiro Shimoda

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
