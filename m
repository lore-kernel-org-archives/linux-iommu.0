Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EB3C47420
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 01:32:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A5A207C3
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 01:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPmVyKZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A5A207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A5FAE868F6;
	Thu,  1 Oct 2020 01:32:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dcaogpxO7-MK; Thu,  1 Oct 2020 01:32:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 080B2868E4;
	Thu,  1 Oct 2020 01:32:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD0F9C0889;
	Thu,  1 Oct 2020 01:32:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 783ECC0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 01:32:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 658888726A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 01:32:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I5ybfGTrUD72 for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 01:32:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A1B51865F6
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 01:32:12 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id e18so2611318pgd.4
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 18:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=z8LIhLPs0CLI8pgGxkD8y/EyOMrZ9o3X/QkFKdqYOkY=;
 b=hPmVyKZSZIWUx3U9XvhNpCdAUv3EOSbI50OUAVahggy4kboKiB5dkvCcnCaaE44K9p
 VcLL3BA+StQzYj4DsxKjJz3yLh33p/0et1CLvdfHNxmuHIs7YIoEuASZrvdHAHBOQ+bt
 hbfahfAL9NLdfXltVXPGKIY+5Yx90b0iZx0cbX8xt4K5eYSgGFgmgJqQilKRHR9hSG4M
 71lrsV/5SlX2ie7jFjAKPG2d1aW1ktENRyagnbAoHZg9efzO/OiKuxiqVC4aNWqKRoic
 LVraKaGqvIZGF0+mx69zTTopn+4cDHVg++iV4SI9zUiXI8bzlnYqvA0XZusig0FRtcXx
 TUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=z8LIhLPs0CLI8pgGxkD8y/EyOMrZ9o3X/QkFKdqYOkY=;
 b=KRt6yq1DrElKBQmr/s67GWGU/NDQlPhvCpOa4gZJF/jkyoQ7vbzKaNVya+/uRiHjOL
 Me8vVrcgCgzI3nusG3+xhS2mBJRZTidlW7yQ06b9HzrZ5BIWyO3zDY1eY7D4wE9wfxSV
 zjqiVo7nBcoa/MAA54RKp4KH1CLHqmpn6UrjPpg43XS6sPyLVdy+W2gEf1/d86UHL+Re
 ablTvueDbs2JZyZ5yw654NtBbZe3Ixp4yD4ojPbnEAya9DCfKINXcA8ZnO7MG+gOC2jm
 IrVY5Jerv4aBJkha6ArS4wkZIt6UE/IcKZkWCPYuHz34wxPHkIBC3mRQQoCDq5iARJjw
 Kbcw==
X-Gm-Message-State: AOAM532KQzI/8Co+5YD3WbpWH/Y/2GlpC+wnQ0+A8FnWB1R/p4TW5Htx
 iV0VuwSHhcVPJqmA2e0m+bk=
X-Google-Smtp-Source: ABdhPJxwlnwGtdmC3yo/+A3DVIPS7iRM1g+GOpZ6teMUos8ZoA+cxlB0PTpGBm/hnlysi09P+RI/MA==
X-Received: by 2002:a63:e802:: with SMTP id s2mr4195240pgh.350.1601515932087; 
 Wed, 30 Sep 2020 18:32:12 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id c3sm3871806pfn.23.2020.09.30.18.32.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Sep 2020 18:32:11 -0700 (PDT)
Date: Wed, 30 Sep 2020 18:26:30 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20201001012630.GA28240@Asurada-Nvidia>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <20200930153131.GB3833404@ulmo>
 <20200930203618.GC2110@Asurada-Nvidia>
 <13746922-0253-cda7-e9ac-2bd20bf1a17f@gmail.com>
 <20200930213244.GA10573@Asurada-Nvidia>
 <5945a63e-79d8-e3ae-ab53-cee8c220ac7d@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5945a63e-79d8-e3ae-ab53-cee8c220ac7d@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org
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

T24gVGh1LCBPY3QgMDEsIDIwMjAgYXQgMTI6NTY6NDZBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDAxLjEwLjIwMjAgMDA6MzIsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
T24gVGh1LCBPY3QgMDEsIDIwMjAgYXQgMTI6MjQ6MjVBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+ID4+IC4uLgo+ID4+Pj4gSXQgbG9va3MgdG8gbWUgbGlrZSB0aGUgb25seSByZWFz
b24gd2h5IHlvdSBuZWVkIHRoaXMgbmV3IGdsb2JhbCBBUEkgaXMKPiA+Pj4+IGJlY2F1c2UgUENJ
IGRldmljZXMgbWF5IG5vdCBoYXZlIGEgZGV2aWNlIHRyZWUgbm9kZSB3aXRoIGEgcGhhbmRsZSB0
bwo+ID4+Pj4gdGhlIElPTU1VLiBIb3dldmVyLCBTTU1VIHN1cHBvcnQgZm9yIFBDSSB3aWxsIG9u
bHkgYmUgZW5hYmxlZCBpZiB0aGUKPiA+Pj4+IHJvb3QgY29tcGxleCBoYXMgYW4gaW9tbXVzIHBy
b3BlcnR5LCByaWdodD8gSW4gdGhhdCBjYXNlLCBjYW4ndCB3ZQo+ID4+Pj4gc2ltcGx5IGRvIHNv
bWV0aGluZyBsaWtlIHRoaXM6Cj4gPj4+Pgo+ID4+Pj4gCWlmIChkZXZfaXNfcGNpKGRldikpCj4g
Pj4+PiAJCW5wID0gZmluZF9ob3N0X2JyaWRnZShkZXYpLT5vZl9ub2RlOwo+ID4+Pj4gCWVsc2UK
PiA+Pj4+IAkJbnAgPSBkZXYtPm9mX25vZGU7Cj4gPj4+Pgo+ID4+Pj4gPyBJJ20gbm90IHN1cmUg
ZXhhY3RseSB3aGF0IGZpbmRfaG9zdF9icmlkZ2UoKSBpcyBjYWxsZWQsIGJ1dCBJJ20gcHJldHR5
Cj4gPj4+PiBzdXJlIHRoYXQgZXhpc3RzLgo+ID4+Pj4KPiA+Pj4+IE9uY2Ugd2UgaGF2ZSB0aGF0
IHdlIGNhbiBzdGlsbCBpdGVyYXRlIG92ZXIgdGhlIGlvbW11cyBwcm9wZXJ0eSBhbmQgZG8KPiA+
Pj4+IG5vdCBuZWVkIHRvIHJlbHkgb24gdGhpcyBnbG9iYWwgdmFyaWFibGUuCj4gPj4+Cj4gPj4+
IEkgYWdyZWUgdGhhdCBpdCdkIHdvcmsuIEJ1dCBJIHdhcyBob3BpbmcgdG8gc2ltcGxpZnkgdGhl
IGNvZGUKPiA+Pj4gaGVyZSBpZiBpdCdzIHBvc3NpYmxlLiBMb29rcyBsaWtlIHdlIGhhdmUgYW4g
YXJndW1lbnQgb24gdGhpcwo+ID4+PiBzbyBJIHdpbGwgY2hvb3NlIHRvIGdvIHdpdGggeW91ciBz
dWdnZXN0aW9uIGFib3ZlIGZvciBub3cuCj4gPj4KPiA+PiBUaGlzIHBhdGNoIHJlbW92ZWQgbW9y
ZSBsaW5lcyB0aGFuIHdlcmUgYWRkZWQuIElmIHRoaXMgd2lsbCBiZSBvcHBvc2l0ZQo+ID4+IGZv
ciB0aGUgVGhpZXJyeSdzIHN1Z2dlc3Rpb24sIHRoZW4gaXQncyBwcm9iYWJseSBub3QgYSBncmVh
dCBzdWdnZXN0aW9uLgo+ID4gCj4gPiBTb3JyeSwgSSBkb24ndCBxdWl0ZSB1bmRlcnN0YW5kIHRo
aXMgY29tbWVudHMuIFdvdWxkIHlvdSBwbGVhc2UKPiA+IGVsYWJvcmF0ZSB3aGF0J3MgdGhpcyAi
aXQiIGJlaW5nICJub3QgYSBncmVhdCBzdWdnZXN0aW9uIj8KPiA+IAo+IAo+IEkgbWVhbnQgdGhh
dCB5b3Ugc2hvdWxkIHRyeSB0byBpbXBsZW1lbnQgVGhpZXJyeSdzIHNvbHV0aW9uLCBidXQgaWYg
dGhlCj4gZW5kIHJlc3VsdCB3aWxsIGJlIHdvcnNlIHRoYW4gdGhlIGN1cnJlbnQgcGF0Y2gsIHRo
ZW4geW91IHNob3VsZG4ndCBtYWtlCj4gYSB2NCwgYnV0IGdldCBiYWNrIHRvIHRoaXMgZGlzY3Vz
c2lvbiBpbiBvcmRlciB0byBjaG9vc2UgdGhlIGJlc3Qgb3B0aW9uCj4gYW5kIG1ha2UgZXZlcnlv
bmUgYWdyZWUgb24gaXQuCgpJIHNlZS4gVGhhbmtzIGZvciB0aGUgcmVwbHkuIEFuZCBoZXJlIGlz
IGEgc2FtcGxlIGltcGxlbWVudGF0aW9uOgoKQEAgLTgxNCwxMiArODE1LDE1IEBAIHN0YXRpYyBz
dHJ1Y3QgdGVncmFfc21tdSAqdGVncmFfc21tdV9maW5kKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAp
CiB9CiAKIHN0YXRpYyBpbnQgdGVncmFfc21tdV9jb25maWd1cmUoc3RydWN0IHRlZ3JhX3NtbXUg
KnNtbXUsIHN0cnVjdCBkZXZpY2UgKmRldiwKLQkJCQlzdHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdzICph
cmdzKQorCQkJCXN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgKmFyZ3MsIHN0cnVjdCBmd25vZGVfaGFu
ZGxlICpmd25vZGUpCiB7CiAJY29uc3Qgc3RydWN0IGlvbW11X29wcyAqb3BzID0gc21tdS0+aW9t
bXUub3BzOwogCWludCBlcnI7CiAKLQllcnIgPSBpb21tdV9md3NwZWNfaW5pdChkZXYsICZkZXYt
Pm9mX25vZGUtPmZ3bm9kZSwgb3BzKTsKKwlpZiAoIWZ3bm9kZSkKKwkJcmV0dXJuIC1FTk9FTlQ7
CisKKwllcnIgPSBpb21tdV9md3NwZWNfaW5pdChkZXYsIGZ3bm9kZSwgb3BzKTsKIAlpZiAoZXJy
IDwgMCkgewogCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBpbml0aWFsaXplIGZ3c3BlYzogJWRc
biIsIGVycik7CiAJCXJldHVybiBlcnI7CkBAIC04MzUsNiArODM5LDE5IEBAIHN0YXRpYyBpbnQg
dGVncmFfc21tdV9jb25maWd1cmUoc3RydWN0IHRlZ3JhX3NtbXUgKnNtbXUsIHN0cnVjdCBkZXZp
Y2UgKmRldiwKIAlyZXR1cm4gMDsKIH0KIAorc3RhdGljIHN0cnVjdCBkZXZpY2Vfbm9kZSAqdGVn
cmFfc21tdV9maW5kX3BjaV9ucChzdHJ1Y3QgcGNpX2RldiAqcGNpX2RldikKK3sKKwlzdHJ1Y3Qg
cGNpX2J1cyAqYnVzID0gcGNpX2Rldi0+YnVzOworCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZidXMt
PmRldjsKKworCXdoaWxlICghb2ZfcHJvcGVydHlfcmVhZF9ib29sKGRldi0+b2Zfbm9kZSwgImlv
bW11cyIpICYmIGJ1cy0+cGFyZW50KSB7CisJCWRldiA9ICZidXMtPnBhcmVudC0+ZGV2OworCQli
dXMgPSBidXMtPnBhcmVudDsKKwl9CisKKwlyZXR1cm4gZGV2LT5vZl9ub2RlOworfQorCiBzdGF0
aWMgc3RydWN0IGlvbW11X2RldmljZSAqdGVncmFfc21tdV9wcm9iZV9kZXZpY2Uoc3RydWN0IGRl
dmljZSAqZGV2KQogewogCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBkZXYtPm9mX25vZGU7CkBA
IC04NDMsMTEgKzg2MCwxNCBAQCBzdGF0aWMgc3RydWN0IGlvbW11X2RldmljZSAqdGVncmFfc21t
dV9wcm9iZV9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQogCXVuc2lnbmVkIGludCBpbmRleCA9
IDA7CiAJaW50IGVycjsKIAorCWlmIChkZXZfaXNfcGNpKGRldikpCisJCW5wID0gdGVncmFfc21t
dV9maW5kX3BjaV9ucCh0b19wY2lfZGV2KGRldikpOworCiAJd2hpbGUgKG9mX3BhcnNlX3BoYW5k
bGVfd2l0aF9hcmdzKG5wLCAiaW9tbXVzIiwgIiNpb21tdS1jZWxscyIsIGluZGV4LAogCQkJCQkg
ICZhcmdzKSA9PSAwKSB7CiAJCXNtbXUgPSB0ZWdyYV9zbW11X2ZpbmQoYXJncy5ucCk7CiAJCWlm
IChzbW11KSB7Ci0JCQllcnIgPSB0ZWdyYV9zbW11X2NvbmZpZ3VyZShzbW11LCBkZXYsICZhcmdz
KTsKKwkJCWVyciA9IHRlZ3JhX3NtbXVfY29uZmlndXJlKHNtbXUsIGRldiwgJmFyZ3MsICZucC0+
Zndub2RlKTsKIAkJCW9mX25vZGVfcHV0KGFyZ3MubnApOwogCiAJCQlpZiAoZXJyIDwgMCkKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
