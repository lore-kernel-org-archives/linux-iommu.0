Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06450CCA473
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 00:37:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70B25423A9;
	Fri,  1 Jul 2022 00:37:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 70B25423A9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=oyKgnTd4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H_gs_dnejOb3; Fri,  1 Jul 2022 00:37:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A6AEC41A6E;
	Fri,  1 Jul 2022 00:37:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A6AEC41A6E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 846ACC0021;
	Fri,  1 Jul 2022 00:37:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B4C6C0011
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 00:37:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2CBF2832DB
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 00:37:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2CBF2832DB
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=oyKgnTd4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R00KlFoouPTC for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 00:37:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4590F827F0
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4590F827F0
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 00:37:52 +0000 (UTC)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-317710edb9dso9847337b3.0
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 17:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VvnQLRW3jtos30YOXCac41NBCyC2GZh1yMj7tf5Q9R0=;
 b=oyKgnTd4PpBv38WuQljuauvS82SM3dQlAPCb0vgCngpk91UWhkvTbZ51UyYbfAoPxT
 emAKlWy7SwOEebwyrY/bBlmJ7gBRqbOBdvj1P9MoQ4xxBvLVL5YPNa172XzXRY2FHp0H
 w2PV+L3bfaqtsyPtMEvIpSBAPKjV/QZNEyFmJ5sEU1kg24dtrFeUBpECBRoklWoXFZE/
 J/YZVng3McgGPZFq/KpeWHT/1N3xNE3GUH3gGkPhKBLhmrhYlOEh2+3RKVhy5pZaPEPH
 oYcoVGcU8mbLw8UZFRcEzdlq8qpnbjYWAOPuj+WSMPfq5aGJDObMbOGZGGljUFCYxDAr
 YsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VvnQLRW3jtos30YOXCac41NBCyC2GZh1yMj7tf5Q9R0=;
 b=mJ3zJD0nLKX29QGz9i1CdnNu+PbkEKYuVbg6Uw5CS8CXtPTU6nI9HwVjqQx1bpeqHG
 SK0HhJZtplvU5Ew86xr25OsJ8pd0+b+zWDe7ED37OWghbALXSRzNCyWOZMgnkqHHrGXD
 vluADv/76eyf3VRORRpQzBqxNs/Tkn1dRiFmjl0ytxP9KK6nprNB7F5+FdPFWYgkfElK
 eIX0REgCkJ6ZEJTDnSDnvCubXeajp8mLe0ZK291kS9B8NlWvxD85NCcw3/TRViZ6DwTC
 qM3h+EJqc32WnHIfzihaG39e6OlF/ehmgsgetY1XOgSbfft6NWIuNUCcW8RKNPDVuJPV
 EoEw==
X-Gm-Message-State: AJIora8APHxniNUKlHzeHYHvKa0vvoJkI5Rf0t9l9FbylkvgZIFoHVDg
 q03QmPi4XpaxfEYTLMAMfZYfY/Bn+42fkwTjiOkEsQ==
X-Google-Smtp-Source: AGRyM1umaTTvGggQULFTozCe9tetZyZETwjRyDuJ0B5d5pAN2Z0BoGkXYjkuA50JAwucoHRiSQCT/DR4v+US44sWmFM=
X-Received: by 2002:a0d:ca16:0:b0:31b:7adf:d91 with SMTP id
 m22-20020a0dca16000000b0031b7adf0d91mr13637664ywd.455.1656635871014; Thu, 30
 Jun 2022 17:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-2-saravanak@google.com> <YrFzK6EiVvXmzVG6@atomide.com>
 <4799738.LvFx2qVVIh@steina-w>
In-Reply-To: <4799738.LvFx2qVVIh@steina-w>
Date: Thu, 30 Jun 2022 17:37:14 -0700
Message-ID: <CAGETcx_1qa=gGT4LVkyPpcA1vFM9FzuJE+0DhL_nFyg5cbFjVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of
 driver_deferred_probe_check_state()
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Content-Type: multipart/mixed; boundary="0000000000009dba6c05e2b398fc"
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, kernel-team@android.com,
 Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Heiner Kallweit <hkallweit1@gmail.com>
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
From: Saravana Kannan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Saravana Kannan <saravanak@google.com>
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--0000000000009dba6c05e2b398fc
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 23, 2022 at 5:08 AM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi,
>
> Am Dienstag, 21. Juni 2022, 09:28:43 CEST schrieb Tony Lindgren:
> > Hi,
> >
> > * Saravana Kannan <saravanak@google.com> [700101 02:00]:
> > > Now that fw_devlink=on by default and fw_devlink supports
> > > "power-domains" property, the execution will never get to the point
> > > where driver_deferred_probe_check_state() is called before the supplier
> > > has probed successfully or before deferred probe timeout has expired.
> > >
> > > So, delete the call and replace it with -ENODEV.
> >
> > Looks like this causes omaps to not boot in Linux next. With this
> > simple-pm-bus fails to probe initially as the power-domain is not
> > yet available. On platform_probe() genpd_get_from_provider() returns
> > -ENOENT.
> >
> > Seems like other stuff is potentially broken too, any ideas on
> > how to fix this?
>
> I think I'm hit by this as well, although I do not get a lockup.
> In my case I'm using arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dts
> and probing of 38320000.blk-ctrl fails as the power-domain is not (yet)
> registed.

Ok, took a look.

The problem is that there are two drivers for the same device and they
both initialize this device.

    gpc: gpc@303a0000 {
        compatible = "fsl,imx8mq-gpc";
    }

$ git grep -l "fsl,imx7d-gpc" -- drivers/
drivers/irqchip/irq-imx-gpcv2.c
drivers/soc/imx/gpcv2.c

IMHO, this is a bad/broken design.

So what's happening is that fw_devlink will block the probe of
38320000.blk-ctrl until 303a0000.gpc is initialized. And it stops
blocking the probe of 38320000.blk-ctrl as soon as the first driver
initializes the device. In this case, it's the irqchip driver.

I'd recommend combining these drivers into one. Something like the
patch I'm attaching (sorry for the attachment, copy-paste is mangling
the tabs). Can you give it a shot please?

-Saravana

--0000000000009dba6c05e2b398fc
Content-Type: application/x-patch; name="0001-combine-drivers.patch"
Content-Disposition: attachment; filename="0001-combine-drivers.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l51q58ij0>
X-Attachment-Id: f_l51q58ij0

RnJvbSAwOGI4Nzk1YjYzMDBkZTg5NTAyYTI2YmEzMzQ3YjJlNTRkNDMzODFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYXJhdmFuYSBLYW5uYW4gPHNhcmF2YW5ha0Bnb29nbGUuY29t
PgpEYXRlOiBUaHUsIDMwIEp1biAyMDIyIDE3OjA0OjI2IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0g
Y29tYmluZSBkcml2ZXJzCgotLS0KIGRyaXZlcnMvaXJxY2hpcC9pcnEtaW14LWdwY3YyLmMgfCAx
OSArKysrLS0tLS0tLS0tLS0tLS0tCiBkcml2ZXJzL3NvYy9pbXgvZ3BjdjIuYyAgICAgICAgIHwg
MTAgKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxNSBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAvaXJxLWlteC1ncGN2Mi5jIGIv
ZHJpdmVycy9pcnFjaGlwL2lycS1pbXgtZ3BjdjIuYwppbmRleCBiOWMyMmY3NjRiNGQuLjYyMTIx
MWU1ODAwYSAxMDA2NDQKLS0tIGEvZHJpdmVycy9pcnFjaGlwL2lycS1pbXgtZ3BjdjIuYworKysg
Yi9kcml2ZXJzL2lycWNoaXAvaXJxLWlteC1ncGN2Mi5jCkBAIC0xOTksMTMgKzE5OSwxMyBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBncGN2Ml9vZl9tYXRjaFtdID0gewogCXsg
LyogRU5EICovIH0KIH07CiAKLXN0YXRpYyBpbnQgX19pbml0IGlteF9ncGN2Ml9pcnFjaGlwX2lu
aXQoc3RydWN0IGRldmljZV9ub2RlICpub2RlLAotCQkJICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9k
ZSAqcGFyZW50KQoraW50IGlteF9ncGN2Ml9pcnFjaGlwX2luaXQoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldiwKKwkJCSAgIHVuc2lnbmVkIGxvbmcgY29yZV9udW0pCiB7CisJc3RydWN0IGRl
dmljZV9ub2RlICpub2RlID0gcGRldi0+ZGV2Lm9mX25vZGU7CisJc3RydWN0IGRldmljZV9ub2Rl
ICpwYXJlbnQgPSBvZl9pcnFfZmluZF9wYXJlbnQobm9kZSk7CiAJc3RydWN0IGlycV9kb21haW4g
KnBhcmVudF9kb21haW4sICpkb21haW47CiAJc3RydWN0IGdwY3YyX2lycWNoaXBfZGF0YSAqY2Q7
Ci0JY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqaWQ7Ci0JdW5zaWduZWQgbG9uZyBjb3JlX251
bTsKIAlpbnQgaTsKIAogCWlmICghcGFyZW50KSB7CkBAIC0yMTMsMTQgKzIxMyw2IEBAIHN0YXRp
YyBpbnQgX19pbml0IGlteF9ncGN2Ml9pcnFjaGlwX2luaXQoc3RydWN0IGRldmljZV9ub2RlICpu
b2RlLAogCQlyZXR1cm4gLUVOT0RFVjsKIAl9CiAKLQlpZCA9IG9mX21hdGNoX25vZGUoZ3BjdjJf
b2ZfbWF0Y2gsIG5vZGUpOwotCWlmICghaWQpIHsKLQkJcHJfZXJyKCIlcE9GOiB1bmtub3duIGNv
bXBhdGliaWxpdHkgc3RyaW5nXG4iLCBub2RlKTsKLQkJcmV0dXJuIC1FTk9ERVY7Ci0JfQotCi0J
Y29yZV9udW0gPSAodW5zaWduZWQgbG9uZylpZC0+ZGF0YTsKLQogCXBhcmVudF9kb21haW4gPSBp
cnFfZmluZF9ob3N0KHBhcmVudCk7CiAJaWYgKCFwYXJlbnRfZG9tYWluKSB7CiAJCXByX2Vycigi
JXBPRjogdW5hYmxlIHRvIGdldCBwYXJlbnQgZG9tYWluXG4iLCBub2RlKTsKQEAgLTI4NSw2ICsy
NzcsMyBAQCBzdGF0aWMgaW50IF9faW5pdCBpbXhfZ3BjdjJfaXJxY2hpcF9pbml0KHN0cnVjdCBk
ZXZpY2Vfbm9kZSAqbm9kZSwKIAlvZl9ub2RlX2NsZWFyX2ZsYWcobm9kZSwgT0ZfUE9QVUxBVEVE
KTsKIAlyZXR1cm4gMDsKIH0KLQotSVJRQ0hJUF9ERUNMQVJFKGlteF9ncGN2Ml9pbXg3ZCwgImZz
bCxpbXg3ZC1ncGMiLCBpbXhfZ3BjdjJfaXJxY2hpcF9pbml0KTsKLUlSUUNISVBfREVDTEFSRShp
bXhfZ3BjdjJfaW14OG1xLCAiZnNsLGlteDhtcS1ncGMiLCBpbXhfZ3BjdjJfaXJxY2hpcF9pbml0
KTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2lteC9ncGN2Mi5jIGIvZHJpdmVycy9zb2MvaW14
L2dwY3YyLmMKaW5kZXggODVhYTg2ZTEzMzhhLi4zY2E1MzgyZmY1ZDMgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvc29jL2lteC9ncGN2Mi5jCisrKyBiL2RyaXZlcnMvc29jL2lteC9ncGN2Mi5jCkBAIC0z
MDUsNiArMzA1LDcgQEAgc3RydWN0IGlteF9wZ2NfZG9tYWluX2RhdGEgewogCXNpemVfdCBkb21h
aW5zX251bTsKIAljb25zdCBzdHJ1Y3QgcmVnbWFwX2FjY2Vzc190YWJsZSAqcmVnX2FjY2Vzc190
YWJsZTsKIAljb25zdCBzdHJ1Y3QgaW14X3BnY19yZWdzICpwZ2NfcmVnczsKKwl1bnNpZ25lZCBs
b25nIGlycV9jb3JlX251bTsKIH07CiAKIHN0YXRpYyBpbmxpbmUgc3RydWN0IGlteF9wZ2NfZG9t
YWluICoKQEAgLTU0OSw2ICs1NTAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteF9wZ2NfZG9t
YWluX2RhdGEgaW14N19wZ2NfZG9tYWluX2RhdGEgPSB7CiAJLmRvbWFpbnNfbnVtID0gQVJSQVlf
U0laRShpbXg3X3BnY19kb21haW5zKSwKIAkucmVnX2FjY2Vzc190YWJsZSA9ICZpbXg3X2FjY2Vz
c190YWJsZSwKIAkucGdjX3JlZ3MgPSAmaW14N19wZ2NfcmVncywKKwkuaXJxX2NvcmVfbnVtID0g
MiwKIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaW14X3BnY19kb21haW4gaW14OG1fcGdjX2Rv
bWFpbnNbXSA9IHsKQEAgLTcxOCw2ICs3MjAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteF9w
Z2NfZG9tYWluX2RhdGEgaW14OG1fcGdjX2RvbWFpbl9kYXRhID0gewogCS5kb21haW5zX251bSA9
IEFSUkFZX1NJWkUoaW14OG1fcGdjX2RvbWFpbnMpLAogCS5yZWdfYWNjZXNzX3RhYmxlID0gJmlt
eDhtX2FjY2Vzc190YWJsZSwKIAkucGdjX3JlZ3MgPSAmaW14N19wZ2NfcmVncywKKwkuaXJxX2Nv
cmVfbnVtID0gNCwKIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaW14X3BnY19kb21haW4gaW14
OG1tX3BnY19kb21haW5zW10gPSB7CkBAIC0xNDI1LDYgKzE0MjgsOSBAQCBzdGF0aWMgc3RydWN0
IHBsYXRmb3JtX2RyaXZlciBpbXhfcGdjX2RvbWFpbl9kcml2ZXIgPSB7CiB9OwogYnVpbHRpbl9w
bGF0Zm9ybV9kcml2ZXIoaW14X3BnY19kb21haW5fZHJpdmVyKQogCitleHRlcm4gaW50IGlteF9n
cGN2Ml9pcnFjaGlwX2luaXQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwKKwkJCQkgIHVu
c2lnbmVkIGxvbmcgY29yZV9udW0pOworCiBzdGF0aWMgaW50IGlteF9ncGN2Ml9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogewogCWNvbnN0IHN0cnVjdCBpbXhfcGdjX2RvbWFp
bl9kYXRhICpkb21haW5fZGF0YSA9CkBAIC0xNDQ0LDYgKzE0NTAsMTAgQEAgc3RhdGljIGludCBp
bXhfZ3BjdjJfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAl2b2lkIF9faW9t
ZW0gKmJhc2U7CiAJaW50IHJldDsKIAorCXJldCA9IGlteF9ncGN2Ml9pcnFjaGlwX2luaXQocGRl
diwgZG9tYWluX2RhdGEtPmlycV9jb3JlX251bSk7CisJaWYgKHJldCkKKwkJcmV0dXJuIHJldDsK
KwogCXBnY19ucCA9IG9mX2dldF9jaGlsZF9ieV9uYW1lKGRldi0+b2Zfbm9kZSwgInBnYyIpOwog
CWlmICghcGdjX25wKSB7CiAJCWRldl9lcnIoZGV2LCAiTm8gcG93ZXIgZG9tYWlucyBzcGVjaWZp
ZWQgaW4gRFRcbiIpOwotLSAKMi4zNy4wLnJjMC4xNjEuZzEwZjM3YmVkOTAtZ29vZwoK
--0000000000009dba6c05e2b398fc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--0000000000009dba6c05e2b398fc--
