Return-Path: <SRS0=TkeE=TO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49354C04AB4
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 14:55:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 193EB2084E
	for <iommu@archiver.kernel.org>; Tue, 14 May 2019 14:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Ie1FW8t/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193EB2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E6CDDD95;
	Tue, 14 May 2019 14:55:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 71548D8C
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 14:55:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
	[209.85.222.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EED97896
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 14:55:48 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id a132so10367663qkb.13
	for <iommu@lists.linux-foundation.org>;
	Tue, 14 May 2019 07:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=7kGY/UxYYLr+YI89dChLQwq+Sl4QElIXlRa9KLaAqLc=;
	b=Ie1FW8t/zgtSHMLE2lv6OkWmsD0oHrb8dnkzxez9BUMpQYX4t445sRjeAKgrjA7gNq
	WZ+YK+yyNYBGivt+XlQQ0/ID8fRy14jEYu/8aGAM5rft2MiqJH6UfW2XSfA1rJ9EH9VU
	oNJrwWHJU3YNPOJaAq0LTm9px6raXtNI79sLYOu686Yg4euDvJ3lIePTNVKPqrMDG/0t
	pdecmTsjtjsMD1DGa8Ynj3tu+Oo6MZfqLnX8+iccbLm0GEXBQqjsEa4x7oxY3k8XhKeg
	rC9ZW9jRKt3+aUCnp1hidNEQG50mtkTRoJinWF+6rgMSvDuVjhdiFV5dP4GLYc5Vl0tF
	sRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=7kGY/UxYYLr+YI89dChLQwq+Sl4QElIXlRa9KLaAqLc=;
	b=a1TexgZJ3zaRY187qoKkAUMAYzbAIpgYejBrJ0q9OP+WGgdp8GbDCa9zG8NpGUGm7/
	eUYvQ+uerzBpxg0h6V9E3UxPufN2FI/5r2Jx95Md9aQdvOnVYFZSBOa2VZ/h0Gq2ATAD
	Qnj9OC4UTKKTB8+oK3vDTzla0J1fE6YeNtKtIcLIPIMD2dpBD1hacW4vty9yC+htWtO2
	k2Xg+WWSrazZls0rJlXjCOH3Vi/2KiABQq2a479P+10hVZpAWugru0/P6GhabO6uk/rE
	YjWMKYw8aqIy95NCuy/c2l6jgH6KeX/M2Gx/qIRmr3iJos7BmiIjdm060hNTf6e2VeSh
	1Bvg==
X-Gm-Message-State: APjAAAX2xgEn9PuXP4qSkdASBXcYcH0Snpj3hFIDrBmyLpVwosjJmaJ8
	pd8Rn9frthHQMVs2qmzhNTt0oQ==
X-Google-Smtp-Source: APXvYqyyouR/emlU+oGf1TyeVSV5Y8Cb0m/ABHv93umiARSns7lGaXQJkvikuj3dJnQac8uYNBfw3Q==
X-Received: by 2002:a37:508a:: with SMTP id
	e132mr27875371qkb.281.1557845748158; 
	Tue, 14 May 2019 07:55:48 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
	[66.187.233.206]) by smtp.gmail.com with ESMTPSA id
	r143sm546809qke.62.2019.05.14.07.55.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 07:55:47 -0700 (PDT)
Message-ID: <1557845746.6132.27.camel@lca.pw>
Subject: Re: [PATCH] iommu/amd: print out "tag" in INVALID_PPR_REQUEST
From: Qian Cai <cai@lca.pw>
To: Gary R Hook <ghook@amd.com>, "jroedel@suse.de" <jroedel@suse.de>
Date: Tue, 14 May 2019 10:55:46 -0400
In-Reply-To: <ea379dc8-dd6b-f204-0abc-7b6fe87a851b@amd.com>
References: <20190506041106.29167-1-cai@lca.pw>
	<ea379dc8-dd6b-f204-0abc-7b6fe87a851b@amd.com>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gVHVlLCAyMDE5LTA1LTA3IGF0IDEzOjQ3ICswMDAwLCBHYXJ5IFIgSG9vayB3cm90ZToKPiBP
biA1LzUvMTkgMTE6MTEgUE0sIFFpYW4gQ2FpIHdyb3RlOgo+ID4gW0NBVVRJT046IEV4dGVybmFs
IEVtYWlsXQo+ID4gCj4gPiBUaGUgY29tbWl0IGU3ZjYzZmZjMWJmMSAoImlvbW11L2FtZDogVXBk
YXRlIGxvZ2dpbmcgaW5mb3JtYXRpb24gZm9yIG5ldwo+ID4gZXZlbnQgdHlwZSIpIGludHJvZHVj
ZWQgYSB2YXJpYWJsZSAidGFnIiBidXQgaGFkIG5ldmVyIHVzZWQgaXQgd2hpY2gKPiA+IGdlbmVy
YXRlcyBhIHdhcm5pbmcgYmVsb3csCj4gPiAKPiA+IGRyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmM6
IEluIGZ1bmN0aW9uICdpb21tdV9wcmludF9ldmVudCc6Cj4gPiBkcml2ZXJzL2lvbW11L2FtZF9p
b21tdS5jOjU2NzozMzogd2FybmluZzogdmFyaWFibGUgJ3RhZycgc2V0IGJ1dCBub3QKPiA+IHVz
ZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCj4gPiDCoMKgwqBpbnQgdHlwZSwgZGV2aWQs
IHBhc2lkLCBmbGFncywgdGFnOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBefn4KPiA+IHNvIGp1c3QgdXNlIGl0
IGR1cmluZyB0aGUgbG9nZ2luZy4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogUWlhbiBDYWkgPGNh
aUBsY2EucHc+Cj4gPiAtLS0KPiA+IMKgIGRyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmMgfCA0ICsr
LS0KPiA+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
Cj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jIGIvZHJpdmVy
cy9pb21tdS9hbWRfaW9tbXUuYwo+ID4gaW5kZXggZjdjZGQyYWI3ZjExLi41MmY0MTM2OWM1YjMg
MTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jCj4gPiArKysgYi9kcml2
ZXJzL2lvbW11L2FtZF9pb21tdS5jCj4gPiBAQCAtNjMxLDkgKzYzMSw5IEBAIHN0YXRpYyB2b2lk
IGlvbW11X3ByaW50X2V2ZW50KHN0cnVjdCBhbWRfaW9tbXUgKmlvbW11LAo+ID4gdm9pZCAqX19l
dnQpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGFzaWQgPSAoKGV2ZW50
WzBdID4+IDE2KSAmIDB4RkZGRikKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgfCAoKGV2ZW50WzFdIDw8IDYpICYgMHhGMDAwMCk7Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdGFnID0gZXZlbnRbMV0gJiAweDAzRkY7Cj4g
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2VycihkZXYsICJFdmVudCBsb2dn
ZWQgW0lOVkFMSURfUFBSX1JFUVVFU1QKPiA+IGRldmljZT0lMDJ4OiUwMnguJXggcGFzaWQ9MHgl
MDV4IGFkZHJlc3M9MHglbGx4IGZsYWdzPTB4JTA0eF1cbiIsCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZGV2X2VycihkZXYsICJFdmVudCBsb2dnZWQgW0lOVkFMSURfUFBSX1JF
UVVFU1QKPiA+IGRldmljZT0lMDJ4OiUwMnguJXggcGFzaWQ9MHglMDV4IHRhZz0weCUwNHggYWRk
cmVzcz0weCVsbHggZmxhZ3M9MHglMDR4XVxuIiwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgUENJX0JVU19OVU0oZGV2aWQpLCBQQ0lfU0xPVChk
ZXZpZCksCj4gPiBQQ0lfRlVOQyhkZXZpZCksCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBhc2lkLCBhZGRyZXNzLCBmbGFncyk7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBhc2lkLCB0YWcsIGFkZHJl
c3MsIGZsYWdzKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoGRlZmF1bHQ6Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZGV2X2VycihkZXYsICJFdmVudCBsb2dnZWQgW1VOS05PV04gZXZlbnRbMF09
MHglMDh4Cj4gPiBldmVudFsxXT0weCUwOHggZXZlbnRbMl09MHglMDh4IGV2ZW50WzNdPTB4JTA4
eFxuIiwKPiAKPiBJIGRpZCBtYW5hZ2UgdG8gb3Zlcmxvb2sgdGhhdCB2YXJpYWJsZSB3aGVuIEkg
cG9zdGVkIHRoZSBvcmlnaW5hbCBwYXRjaC7CoAo+IEJ1dCBpdCBsb29rcyB0byBtZSBsaWtlIDQx
ZTU5YTQxZmM1ZDEgKGlvbW11IHRyZWUpIGFscmVhZHkgZml4ZWQgdGhpcy4uLsKgCj4gSSdtIG5v
dCBzdXJlIHdoeSBpdCBuZXZlciBnb3QgcHVzaGVkIHRvIHRoZSBtYWluIHRyZWUuCgpKcm9lZGVs
LCBJIGFtIHdvbmRlcmluZyB3aGF0IHRoZSBwbGFuIGZvciA0MWU1OWE0MWZjNWQxIChpb21tdSB0
cmVlKSBvciB0aGlzCnBhdGNoIHRvIGJlIHB1c2hlZCB0byB0aGUgbGludXgtbmV4dCBvciBtYWlu
bGluZS4uLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
