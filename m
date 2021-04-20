Return-Path: <SRS0=gpU2=JR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84970C433B4
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 11:57:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1BE3613C0
	for <iommu@archiver.kernel.org>; Tue, 20 Apr 2021 11:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BE3613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9840A607E3;
	Tue, 20 Apr 2021 11:57:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sOmsgtNnqjxb; Tue, 20 Apr 2021 11:57:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66BED608BF;
	Tue, 20 Apr 2021 11:57:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E9D7C000E;
	Tue, 20 Apr 2021 11:57:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5EA5C000B
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 11:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3C6D83A56
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 11:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=oracle.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M42ehYBUMHeY for <iommu@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 11:57:04 +0000 (UTC)
X-Greylist: delayed 00:33:39 by SQLgrey-1.8.0
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4ECA83A42
 for <iommu@lists.linux-foundation.org>; Tue, 20 Apr 2021 11:57:04 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13KBMmuM012376; Tue, 20 Apr 2021 11:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=R7JGUmF3J71wLA6dPwUce8FwqmxU6JTnhs1XaoTWtpc=;
 b=mzrAyP3z3vTbOYF05fKTtm1FSfsRhaXIMtNI32junvaq2xixqdu4DFtiOEnKHMCjmDAu
 pzOmg6bFqIFulJfFAK3gAc4G1ubri2zL7y+ukl2ZTNZd4enmkHEeJ6kOxa09vXbI9Cau
 pxckDe5aQNXRp1SihBx1WvxHHU5bOAl0qwzbdRlKb6bAcGZRRvbBEvMsbe3h/AM/l6mO
 6K0B0emzos5cXJDAWeD+zogdWeN4yukpTfk465biG7Agf/JhaT7Tq2FLJjNIss62qUS9
 j74qQsLbz2k9Dn5eRznUZ+6NPhFOVGc2XKyCruqh+CG4TG6qi4y3ofFXm87t+4F6DYgG CQ== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 381bjn86tg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Apr 2021 11:22:48 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
 by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13KBKXsp006877;
 Tue, 20 Apr 2021 11:22:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by aserp3020.oracle.com with ESMTP id 3809k06m19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Apr 2021 11:22:47 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13KBKAbB005467;
 Tue, 20 Apr 2021 11:22:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 3809k06m07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Apr 2021 11:22:46 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13KBMEHV030572;
 Tue, 20 Apr 2021 11:22:18 GMT
Received: from kadam (/102.36.221.92) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 20 Apr 2021 04:22:13 -0700
Date: Tue, 20 Apr 2021 14:21:52 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC v1 PATCH 1/3] drivers: soc: add support for
 soc_device_match returning -EPROBE_DEFER
Message-ID: <20210420112151.GE1981@kadam>
References: <20210419042722.27554-1-alice.guo@oss.nxp.com>
 <20210419042722.27554-2-alice.guo@oss.nxp.com>
 <CAMuHMdUbrPxtJ9DCP0_nFrReuuO4vFY2J79LrKY82D7bCOfzRw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdUbrPxtJ9DCP0_nFrReuuO4vFY2J79LrKY82D7bCOfzRw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: e0r_GcH24oUhB4PQiI_vI2-dauff_ZRM
X-Proofpoint-ORIG-GUID: e0r_GcH24oUhB4PQiI_vI2-dauff_ZRM
Cc: ulf.hansson@linaro.org, aymen.sghaier@nxp.com, geert+renesas@glider.be,
 rafael@kernel.org, airlied@linux.ie, mturquette@baylibre.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 a.hajda@samsung.com, netdev@vger.kernel.org, linux-phy@lists.infradead.org,
 peter.ujfalusi@gmail.com, linux-clk@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, wim@linux-watchdog.org,
 herbert@gondor.apana.org.au, horia.geanta@nxp.com, khilman@baylibre.com,
 narmstrong@baylibre.com, linux-staging@lists.linux.dev,
 iommu@lists.linux-foundation.org, kishon@ti.com, tony@atomide.com,
 linux-omap@vger.kernel.org, stern@rowland.harvard.edu, kuba@kernel.org,
 linus.walleij@linaro.org, linux@roeck-us.net, linux-media@vger.kernel.org,
 linux-watchdog@vger.kernel.org, will@kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, edubezval@gmail.com, linux-gpio@vger.kernel.org,
 linux-mediatek@lists.infradead.org, ssantosh@kernel.org,
 matthias.bgg@gmail.com, linux-amlogic@lists.infradead.org, mchehab@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "Alice Guo \(OSS\)" <alice.guo@oss.nxp.com>, balbi@kernel.org,
 tomba@kernel.org, sboyd@kernel.org, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
 robert.foss@linaro.org, leoyang.li@nxp.com, linux@prisktech.co.nz,
 vkoul@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
 daniel@ffwll.ch, j-keerthy@ti.com, dmaengine@vger.kernel.org,
 Roy.Pledge@nxp.com, jyri.sarha@iki.fi, davem@davemloft.net
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

On Mon, Apr 19, 2021 at 10:20:13AM +0200, Geert Uytterhoeven wrote:
> Hi Alice,
> 
> CC Arnd (soc_device_match() author)
> 
> On Mon, Apr 19, 2021 at 6:28 AM Alice Guo (OSS) <alice.guo@oss.nxp.com> wrote:
> > From: Alice Guo <alice.guo@nxp.com>
> >
> > In i.MX8M boards, the registration of SoC device is later than caam
> > driver which needs it. Caam driver needs soc_device_match to provide
> > -EPROBE_DEFER when no SoC device is registered and no
> > early_soc_dev_attr.
> 
> I'm wondering if this is really a good idea: soc_device_match() is a
> last-resort low-level check, and IMHO should be made available early on,
> so there is no need for -EPROBE_DEFER.
> 
> >
> > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/base/soc.c
> > +++ b/drivers/base/soc.c
> > @@ -110,6 +110,7 @@ static void soc_release(struct device *dev)
> >  }
> >
> >  static struct soc_device_attribute *early_soc_dev_attr;
> > +static bool soc_dev_attr_init_done = false;
> 
> Do you need this variable?
> 
> >
> >  struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr)
> >  {
> > @@ -157,6 +158,7 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
> >                 return ERR_PTR(ret);
> >         }
> >
> > +       soc_dev_attr_init_done = true;
> >         return soc_dev;
> >
> >  out3:
> > @@ -246,6 +248,9 @@ const struct soc_device_attribute *soc_device_match(
> >         if (!matches)
> >                 return NULL;
> >
> > +       if (!soc_dev_attr_init_done && !early_soc_dev_attr)
> 
> if (!soc_bus_type.p && !early_soc_dev_attr)

There is one place checking this already.  We could wrap it in a helper
function:

static bool device_init_done(void)
{
	return soc_bus_type.p ? true : false;
}

regards,
dan carpenter
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
