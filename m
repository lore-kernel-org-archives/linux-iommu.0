Return-Path: <SRS0=BbwH=5W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D210C2BA2B
	for <iommu@archiver.kernel.org>; Mon,  6 Apr 2020 08:43:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 325C6206F8
	for <iommu@archiver.kernel.org>; Mon,  6 Apr 2020 08:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="mIcplxa4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325C6206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 02E072313D;
	Mon,  6 Apr 2020 08:43:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EweCU0CUzo9p; Mon,  6 Apr 2020 08:43:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2AB60230FE;
	Mon,  6 Apr 2020 08:43:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1194AC089E;
	Mon,  6 Apr 2020 08:43:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06C1EC0177
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 08:43:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E5D0A87C57
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 08:43:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9+Fmffm1O9wP for <iommu@lists.linux-foundation.org>;
 Mon,  6 Apr 2020 08:43:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410114.outbound.protection.outlook.com [40.107.141.114])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 37ADD87C74
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 08:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Unx4numgOYZv1osve5CLM+GbhagrNxXokhysBJR04sfa1VIKk0V4KE7gTXSzyQqtrm9I9hUAl/ceODOKasLgj9Ah6GL46129qDF7FdaxK68YKHmI1aeQSgrSF8k3N6fhKTD9URoxBMMcoRPmRUr7DF3FaUe2HOl0yyFvTAVHMHSgJGz5dlNAGsvn/fQPxcFCwOvEGxUjdzznt4qdqmsPYgBMPKXOqpMCxMFylHiNuO/7FAwTrFJTm9vaual+a4Zd0H10NR4WYSZhvFdf9aCgO0b5XymfE7/ywrlvyrqmNM1xDUguz8Py0ujFJsBE+r9ijYS2vTr/t5b/fwnVILTyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKXSIZj/5CBpL6pTeCYJd/JqqXl5u7S+OfE+24v4ZgM=;
 b=elhOjUCVcV1sOAr+vwRmFBrz4mdp12gvQKE1aM0dSApXN8pD38MDGumREKdSuQm5P8HM8OW+dOROYnzgFo1QBCOlX3kuR95OkfILtAFwo2Fr+pkSyExV4yKgs7NYGzEC5W8eVmo1wJdCL9c+SrLo3wzFkkcmPrfArjCYnp7/afegff3drr5XpIrxJw5GHJFP0zoNA3jroSCYUuZuSfwFgnOuChdV9jVVLQq0rhu8oQ0Ltno3qi4YVWiVBe/QyeC9XSFkJfrF5mvAPyXeIHl2PewXZEex7/f0LRxfXAtVDYg+g0bygFIVhhEbaeblStaKIGI/Vfcpbd6rzE4EtokByw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKXSIZj/5CBpL6pTeCYJd/JqqXl5u7S+OfE+24v4ZgM=;
 b=mIcplxa4B5ECBrtKbxCG80UvzZbo7VRTJJ2QF8x2P+Flt7HdxIRDVkuhDjQZB6+41zcEeheb6sLYCKk6j1KQSj7Le2uvTPsHtXk4ErkFpUQ+kvqmhX5U8z5pivmeN7pbuu2Zg4MXnuBuTWTMhMkPooUz6XPKV5hUH6w1dJ/Vryc=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2192.jpnprd01.prod.outlook.com (52.133.177.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.17; Mon, 6 Apr 2020 08:43:10 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2878.017; Mon, 6 Apr 2020
 08:43:10 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: John Stultz <john.stultz@linaro.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>
Subject: RE: How to fix WARN from drivers/base/dd.c in next-20200401 if
 CONFIG_MODULES=y?
Thread-Topic: How to fix WARN from drivers/base/dd.c in next-20200401 if
 CONFIG_MODULES=y?
Thread-Index: AdYI1eHeE+d8Du49RZSXfyqelir+RgAPcQ+AACaCwgAAIpzUAABtUcqg
Date: Mon, 6 Apr 2020 08:43:10 +0000
Message-ID: <TYAPR01MB45447DFE9E81D77CA867DEC8D8C20@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CALAqxLWopjCkiM=NR868DTcX-apPc1MPnONJMppm1jzCboAheg@mail.gmail.com>
 <CAMuHMdVtHhq9Nef1pBtBUKfRU2L-KgDffiOv28VqhrewR_j1Dw@mail.gmail.com>
 <CALAqxLX2AEFJxqXXXKPs8SU7Su2FqNjwbSt5BxwmQJqYQuST9A@mail.gmail.com>
In-Reply-To: <CALAqxLX2AEFJxqXXXKPs8SU7Su2FqNjwbSt5BxwmQJqYQuST9A@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cbc7ca76-420c-4016-0ba7-08d7da068944
x-ms-traffictypediagnostic: TYAPR01MB2192:
x-microsoft-antispam-prvs: <TYAPR01MB2192B1D9CEB99CDA8574C814D8C20@TYAPR01MB2192.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0365C0E14B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYAPR01MB4544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(2906002)(110136005)(316002)(54906003)(4326008)(76116006)(6506007)(186003)(33656002)(66556008)(66476007)(66946007)(53546011)(55236004)(7696005)(478600001)(52536014)(66446008)(64756008)(26005)(5660300002)(55016002)(9686003)(86362001)(81166006)(8676002)(8936002)(81156014)(71200400001);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UZOtgRaYOCWHFkNoS5wD7DBZrMZnPI9hn9AxXekqvqtBJsLyv/MTuTw8iybELh8y2vtJruTThXJDcYt4mNBu+kSaQpe7u3CSvPTGBjZqLh0BnxaRsIwI2a6KDoGJSgBjTqdynUXNg4cscQff/udifreRTENzeBU6ev6eYaUiWJPujt8hV0bdDVXkErT+er8e/d1aRau2Yh9/xg7VB06zF1ju1FBtSPqsphrKy3gr+SBPkZMtT2EHbJBjSGSDGhXhnh+2nuSVdtX3RVNR3Q5IdzL5w+gAspciPTFlsPlTeLNn9iZI6sS8BohG1T8lEt3IgJcwS2aqiAuOjjjdlLLhV7wxygm488XA35iyPyb04CrH8q9Nk/mHc6wZcis3rCPA8XPrjWQoZaZy37Hswl6E7csKqIlSGe2BNPyA0EV8toszR8KdKXpumIe8vEw4FX6N
x-ms-exchange-antispam-messagedata: YEWqd1JAMDXqUtOi2viaWq4Jf49lCTcq4GmS/z0GKN/KLuebJ4phbC+RhlKCcgdcWcrXf2pVmdZvHbXwxirfqEtBVW5fSQYGZiU3m8UG3R2pBx+cAaLSE+j55/EY6lyQjVppGcMMhRl/yZUpUwvVZA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc7ca76-420c-4016-0ba7-08d7da068944
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2020 08:43:10.2942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NQOHnE2kPwXxqalAoHc1u0wiMl5Ku6svnDiG7iSejdv/BNflIePm3oRYC7o2xNTLKXnnSIah4S0cRgQQzBjEMP1s+Cq9jM+0YET9fKf0P6Vn7On+vt6diXk8zD1aimJW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2192
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

Hi John, Geert,

> From: John Stultz, Sent: Saturday, April 4, 2020 1:19 PM
> 
> On Fri, Apr 3, 2020 at 4:47 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Apr 2, 2020 at 7:27 PM John Stultz <john.stultz@linaro.org> wrote:
> > > On Thu, Apr 2, 2020 at 3:17 AM Yoshihiro Shimoda
> > > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > >
> > > > I found an issue after applied the following patches:
> > > > ---
> > > > 64c775f driver core: Rename deferred_probe_timeout and make it global
> > > > 0e9f8d0 driver core: Remove driver_deferred_probe_check_state_continue()
> > > > bec6c0e pinctrl: Remove use of driver_deferred_probe_check_state_continue()
> > > > e2cec7d driver core: Set deferred_probe_timeout to a longer default if CONFIG_MODULES is set
> >
> > Note that just setting deferred_probe_timeout = -1 like for the
> > CONFIG_MODULES=n case doesn't help.
> 
> Yea. I can see why in that case, as we're checking
> !IS_ENABLED(CONFIG_MODULES) directly in
> driver_deferred_probe_check_state.
> 
> I guess we could switch that to checking
> (driver_deferred_probe_timeout == -1) which would have the same logic
> and at least make it consistent if someone specifies -1 on the command
> line (since now it will effectively have it EPROBE_DEFER forever in
> that case). But also having a timeout=infinity could be useful if
> folks don't want the deferring to time out.  Maybe in the !modules
> case setting it to =0 would be the most clear.
> 
> But that's sort of a further cleanup. I'm still more worried about the
> NFS failure below.
> 
> 
> > > Hey,
> > >   Terribly sorry for the trouble. So as Robin mentioned I have a patch
> > > to remove the WARN messages, but I'm a bit more concerned about why
> > > after the 30 second delay, the ethernet driver loads:
> > >   [   36.218666] ravb e6800000.ethernet eth0: Base address at
> > > 0xe6800000, 2e:09:0a:02:eb:2d, IRQ 117.
> > > but NFS fails.
> > >
> > > Is it just that the 30 second delay is too long and NFS gives up?
> >
> > I added some debug code to mount_nfs_root(), which shows that the first
> > 3 tries happen before ravb is instantiated, and the last 3 tries happen
> > after.  So NFS root should work, if the network works.
> >
> > However, it seems the Ethernet PHY is never initialized, hence the link
> > never becomes ready.  Dmesg before/after:
> >
> >      ravb e6800000.ethernet eth0: Base address at 0xe6800000,
> > 2e:09:0a:02:ea:ff, IRQ 108.
> >
> > Good.
> >
> >      ...
> >     -gpio_rcar e6052000.gpio: sense irq = 11, type = 8
> >
> > This is the GPIO the PHY IRQ is connected to.
> > Note that that GPIO controller has been instantiated before.
> >
> >      ...
> >     -Micrel KSZ9031 Gigabit PHY e6800000.ethernet-ffffffff:00:
> > attached PHY driver [Micrel KSZ9031 Gigabit PHY]
> > (mii_bus:phy_addr=e6800000.ethernet-ffffffff:00, irq=197)
> >      ...
> >     -ravb e6800000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> >
> > Oops.
> >
> >     -Sending DHCP requests .., OK
> >     -IP-Config: Got DHCP answer from ...
> >      ...
> >     +VFS: Unable to mount root fs via NFS, trying floppy.
> >     +VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
> >
> > > Does booting with deferred_probe_timeout=0 work?
> >
> > It does, as now everything using optional links (DMA and IOMMU) is now
> > instantiated on first try.
> 
> Thanks so much for helping clarify this!
> 
> So it's at least good to hear that booting with
> deferred_probe_timeout=0 is working!  But I'm bummed the NFS (or as
> you pointed out in your later mail,  ip_auto_config) falls over
> because the network isn't immediately there.
> 
> Looking a little closer at the ip_auto_config() code, I think the
> issue may be that wait_for_device_probe() is effectively returning too
> early, since the probe_defer_timeout is still active? I need to dig a
> bit more on that code, on Monday, as I don't fully understand it yet.

I think so. I also investigated this issue more and then the following
patch seems to be related because return value is changed a bit.

c8c43ce driver core: Fix driver_deferred_probe_check_state() logic

# By the way, this is other topic though, IIUC we should revise
# the deferred_probe_timeout= in Documentation/admin-guide/kernel-parameters.txt
# for the commit c8c43ce. Especially " A timeout of 0 will timeout at the end of initcalls."
# doesn't match after we applied the commit.

I'm guessing we should add the following flush_work for deferred_probe_timeout_work().
# Sorry, I didn't test this for some reasons yet though...

+       /* wait for the deferred probe timeout workqueue to finish */
+       if (driver_deferred_probe_timeout > 0)
+               flush_work(&deferred_probe_timeout_work);

> If I can't find a way to address that, I think the best course will be
> to set the driver_deferred_probe_timeout value to default to 0
> regardless of the value of CONFIG_MODULES, so we don't cause any
> apparent regression from previous behavior. That will also sort out
> the less intuitive = -1 initialization in the non-modules case.
> 
> In any case, I'll try to have a patch to send out on Monday.

Thanks!

Best regards,
Yoshihiro Shimoda

> thanks
> -john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
