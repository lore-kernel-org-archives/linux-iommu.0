Return-Path: <SRS0=3GNe=B6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEE0C433DF
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 19:51:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A62EF2075E
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 19:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVInyANV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62EF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 467EB2288E;
	Thu, 20 Aug 2020 19:51:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GFswibuBCQ4W; Thu, 20 Aug 2020 19:51:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 54387203E4;
	Thu, 20 Aug 2020 19:51:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30B7AC07FF;
	Thu, 20 Aug 2020 19:51:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55D19C0051
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 19:51:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3B7E0880DD
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 19:51:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hBcZet+zgaZs for <iommu@lists.linux-foundation.org>;
 Thu, 20 Aug 2020 19:51:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DA590880B4
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 19:51:06 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id i10so3462542ljn.2
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 12:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OniJLvMGszqKdZPfnGGPRm6yrJhAzhpZMeh8ipXlA60=;
 b=kVInyANVqA86ZsupZ+Pb7ttjo0P8NA3R0p3DEzLgJRsTMKMITZei2G3WfZlSDDDOVo
 Brozzas6ZvHEMSO6RQ7WwIfPzyZXzZCTaGO6sIRzul2WnVUcIu4qdNYnU6EQ9GWkivhM
 QTGkeebRJE/pgeW85V9eAFS/VGArzEWQd7WIUDnvijv+JOo1PxZqZIJ3N/OfFTlCMK6Q
 5lFS3LvaE9s+NfL7N0AZ0y0gja4R9roVmkZSMm/4V7djiYtKW0fMsvRVrfErEqK7D0IF
 jvYrsgGLLa5tUOsuvyse6KRWT+USoZzaP/vuWqauOYwXsCSrWIwjCcleXTCwmdlO3FOW
 8Eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OniJLvMGszqKdZPfnGGPRm6yrJhAzhpZMeh8ipXlA60=;
 b=MPI+UutY7zv1T6F3HcKYZ67bL0oSZM8MpeeoJsdfJedeW+GqfKF5FzcKVVmxK8lP59
 JEgTerACsB18FnKwEUX2/45YpxkMWajV2T2muBMq9R3jjgJGxmGmnYerOY0MFHtPVZR0
 f2X4mdWgc30wMJmq9nfvtjSWBPnqjFV4Og8WFbvhv9+FVBR3LhpnEoSiBGO+QHdMW26e
 RnKOKP4fe3F6UqZ4EN4p+kpGN3Ntb8JDMdxG0cBjiVeDhixclSdqR4bXUTyrPPh4W77H
 TBRxfxqobXwEovTWWaiRxg66sGS87Bzzf8rAh9lNqqEKnJcg8/FaGrCds54E1Yv9TUVB
 vrRg==
X-Gm-Message-State: AOAM5316wb3L9tQxb+RNeaxMcQWUmHkEdrGumVW4BE/wOLRAirrrmZyF
 6GkYg4Enq6kLah9Wde2oMiM=
X-Google-Smtp-Source: ABdhPJyvIy9bEn51zd/IbZfZTQR3N2YYlmALsIktwWFi5DNbYZ8x8ytUZs/6wT5ORieeLAv6LpyrBA==
X-Received: by 2002:a05:651c:231:: with SMTP id
 z17mr2146637ljn.109.1597953064841; 
 Thu, 20 Aug 2020 12:51:04 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id l26sm690804lfj.22.2020.08.20.12.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 12:51:03 -0700 (PDT)
Subject: Re: [PATCH 16/18] staging/media/tegra-vde: Clean up IOMMU workaround
To: Robin Murphy <robin.murphy@arm.com>, hch@lst.de, joro@8bytes.org,
 linux@armlinux.org.uk
References: <cover.1597931875.git.robin.murphy@arm.com>
 <3535c205b9bce52556abbf2f63384fb38e009df9.1597931876.git.robin.murphy@arm.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <07135a55-cbc9-83e5-60dc-731282192554@gmail.com>
Date: Thu, 20 Aug 2020 22:51:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3535c205b9bce52556abbf2f63384fb38e009df9.1597931876.git.robin.murphy@arm.com>
Content-Language: en-US
Cc: geert+renesas@glider.be, dri-devel@lists.freedesktop.org,
 matthias.bgg@gmail.com, thierry.reding@gmail.com,
 laurent.pinchart@ideasonboard.com, will@kernel.org,
 linux-samsung-soc@vger.kernel.org, magnus.damm@gmail.com,
 kyungmin.park@samsung.com, jonathanh@nvidia.com, agross@kernel.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 inki.dae@samsung.com, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 sw0312.kim@samsung.com, linux-kernel@vger.kernel.org, t-kristo@ti.com,
 iommu@lists.linux-foundation.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

MjAuMDguMjAyMCAxODowOCwgUm9iaW4gTXVycGh5INC/0LjRiNC10YI6Cj4gTm93IHRoYXQgYXJj
aC9hcm0gaXMgd2lyZWQgdXAgZm9yIGRlZmF1bHQgZG9tYWlucyBhbmQgaW9tbXUtZG1hLCB3ZSBu
bwo+IGxvbmdlciBuZWVkIHRvIHdvcmsgYXJvdW5kIHRoZSBhcmNoLXByaXZhdGUgbWFwcGluZy4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPgo+
IC0tLQo+ICBkcml2ZXJzL3N0YWdpbmcvbWVkaWEvdGVncmEtdmRlL2lvbW11LmMgfCAxMiAtLS0t
LS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3N0YWdpbmcvbWVkaWEvdGVncmEtdmRlL2lvbW11LmMgYi9kcml2ZXJzL3N0
YWdpbmcvbWVkaWEvdGVncmEtdmRlL2lvbW11LmMKPiBpbmRleCA2YWY4NjNkOTIxMjMuLjRmNzcw
MTg5ZWQzNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvbWVkaWEvdGVncmEtdmRlL2lv
bW11LmMKPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvbWVkaWEvdGVncmEtdmRlL2lvbW11LmMKPiBA
QCAtMTAsMTAgKzEwLDYgQEAKPiAgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPgo+ICAjaW5jbHVk
ZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+Cj4gIAo+IC0jaWYgSVNfRU5BQkxFRChDT05GSUdf
QVJNX0RNQV9VU0VfSU9NTVUpCj4gLSNpbmNsdWRlIDxhc20vZG1hLWlvbW11Lmg+Cj4gLSNlbmRp
Zgo+IC0KPiAgI2luY2x1ZGUgInZkZS5oIgo+ICAKPiAgaW50IHRlZ3JhX3ZkZV9pb21tdV9tYXAo
c3RydWN0IHRlZ3JhX3ZkZSAqdmRlLAo+IEBAIC03MCwxNCArNjYsNiBAQCBpbnQgdGVncmFfdmRl
X2lvbW11X2luaXQoc3RydWN0IHRlZ3JhX3ZkZSAqdmRlKQo+ICAJaWYgKCF2ZGUtPmdyb3VwKQo+
ICAJCXJldHVybiAwOwo+ICAKPiAtI2lmIElTX0VOQUJMRUQoQ09ORklHX0FSTV9ETUFfVVNFX0lP
TU1VKQo+IC0JaWYgKGRldi0+YXJjaGRhdGEubWFwcGluZykgewo+IC0JCXN0cnVjdCBkbWFfaW9t
bXVfbWFwcGluZyAqbWFwcGluZyA9IHRvX2RtYV9pb21tdV9tYXBwaW5nKGRldik7Cj4gLQo+IC0J
CWFybV9pb21tdV9kZXRhY2hfZGV2aWNlKGRldik7Cj4gLQkJYXJtX2lvbW11X3JlbGVhc2VfbWFw
cGluZyhtYXBwaW5nKTsKPiAtCX0KPiAtI2VuZGlmCj4gIAl2ZGUtPmRvbWFpbiA9IGlvbW11X2Rv
bWFpbl9hbGxvYygmcGxhdGZvcm1fYnVzX3R5cGUpOwo+ICAJaWYgKCF2ZGUtPmRvbWFpbikgewo+
ICAJCWVyciA9IC1FTk9NRU07Cj4gCgpIZWxsbywgUm9iaW4hIFRoYW5rIHlvdSBmb3IgeW91cnMg
d29yayEKClNvbWUgZHJpdmVycywgbGlrZSB0aGlzIFRlZ3JhIFZERSAoVmlkZW8gRGVjb2RlciBF
bmdpbmUpIGRyaXZlciBmb3IKZXhhbXBsZSwgZG8gbm90IHdhbnQgdG8gdXNlIGltcGxpY2l0IElP
TU1VIGRvbWFpbi4gVGVncmEgVkRFIGRyaXZlcgpyZWxpZXMgb24gZXhwbGljaXQgSU9NTVUgZG9t
YWluIGluIGEgY2FzZSBvZiBUZWdyYSBTTU1VIGJlY2F1c2UgVkRFCmhhcmR3YXJlIGNhbid0IGFj
Y2VzcyBsYXN0IHBhZ2Ugb2YgdGhlIEFTIGFuZCBiZWNhdXNlIGRyaXZlciB3YW50cyB0bwpyZXNl
cnZlIHNvbWUgZml4ZWQgYWRkcmVzc2VzIFsxXS4KClsxXQpodHRwczovL2VsaXhpci5ib290bGlu
LmNvbS9saW51eC92NS45LXJjMS9zb3VyY2UvZHJpdmVycy9zdGFnaW5nL21lZGlhL3RlZ3JhLXZk
ZS9pb21tdS5jI0wxMDAKClRlZ3JhMzAgU29DIHN1cHBvcnRzIHVwIHRvIDQgZG9tYWlucywgaGVu
Y2UgaXQncyBub3QgcG9zc2libGUgdG8gYWZmb3JkCndhc3RpbmcgdW51c2VkIGltcGxpY2l0IGRv
bWFpbnMuIEkgdGhpbmsgdGhpcyBuZWVkcyB0byBiZSBhZGRyZXNzZWQKYmVmb3JlIHRoaXMgcGF0
Y2ggY291bGQgYmUgYXBwbGllZC4KCldvdWxkIGl0IGJlIHBvc3NpYmxlIGZvciBJT01NVSBkcml2
ZXJzIHRvIGdhaW4gc3VwcG9ydCBmb3IgZmlsdGVyaW5nIG91dApkZXZpY2VzIGluIGlvbW11X2Rv
bWFpbl9hbGxvYyhkZXYsIHR5cGUpPyBUaGVuIHBlcmhhcHMgVGVncmEgU01NVSBkcml2ZXIKY291
bGQgc2ltcGx5IHJldHVybiBOVUxMIGluIGEgY2FzZSBvZiB0eXBlPUlPTU1VX0RPTUFJTl9ETUEg
YW5kCmRldj10ZWdyYS12ZGUuCgpBbHRlcm5hdGl2ZWx5LCB0aGUgVGVncmEgU01NVSBjb3VsZCBi
ZSBjaGFuZ2VkIHN1Y2ggdGhhdCB0aGUgZGV2aWNlcwp3aWxsIGJlIGF0dGFjaGVkIHRvIGEgZG9t
YWluIGF0IHRoZSB0aW1lIG9mIGEgZmlyc3QgSU9NTVUgbWFwcGluZwppbnZvY2F0aW9uIGluc3Rl
YWQgb2YgYXR0YWNoaW5nIGF0IHRoZSB0aW1lIG9mIGF0dGFjaF9kZXYoKSBjYWxsYmFjawppbnZv
Y2F0aW9uLgoKT3IgbWF5YmUgZXZlbiBJT01NVSBjb3JlIGNvdWxkIGJlIGNoYW5nZWQgdG8gYXR0
YWNoIGRldmljZXMgYXQgdGhlIHRpbWUKb2YgdGhlIGZpcnN0IElPTU1VIG1hcHBpbmcgaW52b2Nh
dGlvbj8gVGhpcyBjb3VsZCBiZSBhIHVuaXZlcnNhbApzb2x1dGlvbiBmb3IgYWxsIGRyaXZlcnMu
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
