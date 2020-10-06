Return-Path: <SRS0=boqS=DN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22521C4363D
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 01:12:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1972084C
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 01:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkLC/GI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1972084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3243E865D0;
	Tue,  6 Oct 2020 01:12:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ip3AIPPlFJW; Tue,  6 Oct 2020 01:12:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BCF5885CF0;
	Tue,  6 Oct 2020 01:12:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A65DEC07FF;
	Tue,  6 Oct 2020 01:12:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E49C1C0051
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 01:12:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C8C89865D0
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 01:12:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J-QYC3CjdqlS for <iommu@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 01:12:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EDE3285CF0
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 01:12:18 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id m34so7037780pgl.9
 for <iommu@lists.linux-foundation.org>; Mon, 05 Oct 2020 18:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=imTCIXq15ZpJ5OmxGTdYsT7lvQK/QATisA5P9vMs8x0=;
 b=YkLC/GI/dYo71KtwLzR8kFLfW+MvUAE2BUVCxmKpasHP75UyE9bTW8Pnj5oD7qyUFf
 K61uuE0WMBsVVkpv9Ld5pgIpCQ68nFyuttpTuBG4vsa9H3JhRATp/yFiGC8sUmduHT7W
 M09VwRO7dEJ34FxLtHe9mpN4SOdoxNSbH3bQfcuQOUJkdwBkTcNBxtMJWvVMQjSTetn4
 44c4BVtyTNMwJzOmurmVqza0WpmauJV+zKFLGms4+f2YQEzFN94YcCRdgiejtQinhsdg
 CBJ91lWiCqBHfR/50soHRkQzUJBU2+1Dqc0k9cryApXffnKV+WrHGuit423vZQc+nRYh
 WcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=imTCIXq15ZpJ5OmxGTdYsT7lvQK/QATisA5P9vMs8x0=;
 b=JcXCA0EwG4UjVvb6KvWaJYJiYhoafxtaLJmtkn+ZpievQ9/E4JmjuPXwtiquEQn0Mn
 DkKEM0tB4iDO/HqFgmUTCmGcxa5N7NseYTOS8gGXWF+xiGB16inYB/6n3lkYCcXt8XKv
 ftI0MXEtwKGqdBBtV4uSuvmbc0pC8FA/50FD8uKTWG9CTRV9WMn89uCfRCEOjvOvywFp
 W1CTW7Yvs2Bks/G7T29kdCzBRDY1m5ypd4h4J2fsSI5AL8LwkZuBbE167d+if4vqF6YN
 7ht2TYdHs94RjgfHJ5hMoFia1vlHRJoT0rj9vzBCkKm/8oR9Q3yqPNewb3BCom1WYauT
 gOIg==
X-Gm-Message-State: AOAM531APUo0y0cVrcb/FpfYU/05kWUJG9I6xhVSvxSLxlwMJwusXzSi
 toAN1+niK7SsWIAqM14gC6k=
X-Google-Smtp-Source: ABdhPJzyQodL+KRlo6JhOJ13FjfVK1Cw/lwkgMZs3x1nYk7bQSdKtQS38iBW+0IDF5yfC+QTAVmRKA==
X-Received: by 2002:a63:4959:: with SMTP id y25mr1979680pgk.206.1601946738447; 
 Mon, 05 Oct 2020 18:12:18 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id w5sm899955pgf.61.2020.10.05.18.12.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 05 Oct 2020 18:12:18 -0700 (PDT)
Date: Mon, 5 Oct 2020 18:05:46 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
Message-ID: <20201006010546.GB28640@Asurada-Nvidia>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
 <5542b314-f414-1e83-8cf6-2bf22a41ae9c@gmail.com>
 <20201002185828.GC29706@Asurada-Nvidia>
 <20201005095754.GJ425362@ulmo>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201005095754.GJ425362@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>
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

T24gTW9uLCBPY3QgMDUsIDIwMjAgYXQgMTE6NTc6NTRBTSArMDIwMCwgVGhpZXJyeSBSZWRpbmcg
d3JvdGU6Cj4gT24gRnJpLCBPY3QgMDIsIDIwMjAgYXQgMTE6NTg6MjlBTSAtMDcwMCwgTmljb2xp
biBDaGVuIHdyb3RlOgo+ID4gT24gRnJpLCBPY3QgMDIsIDIwMjAgYXQgMDY6MDI6MThQTSArMDMw
MCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+ID4gPiAwMi4xMC4yMDIwIDA5OjA4LCBOaWNvbGlu
IENoZW4g0L/QuNGI0LXRgjoKPiA+ID4gPiAgc3RhdGljIGludCB0ZWdyYV9zbW11X29mX3hsYXRl
KHN0cnVjdCBkZXZpY2UgKmRldiwKPiA+ID4gPiAgCQkJICAgICAgIHN0cnVjdCBvZl9waGFuZGxl
X2FyZ3MgKmFyZ3MpCj4gPiA+ID4gIHsKPiA+ID4gPiArCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KmlvbW11X3BkZXYgPSBvZl9maW5kX2RldmljZV9ieV9ub2RlKGFyZ3MtPm5wKTsKPiA+ID4gPiAr
CXN0cnVjdCB0ZWdyYV9tYyAqbWMgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShpb21tdV9wZGV2KTsK
PiA+ID4gPiAgCXUzMiBpZCA9IGFyZ3MtPmFyZ3NbMF07Cj4gPiA+ID4gIAo+ID4gPiA+ICsJb2Zf
bm9kZV9wdXQoYXJncy0+bnApOwo+ID4gPiAKPiA+ID4gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZSgp
IHRha2VzIGRldmljZSByZWZlcmVuY2UgYW5kIG5vdCB0aGUgbnAKPiA+ID4gcmVmZXJlbmNlLiBU
aGlzIGlzIGEgYnVnLCBwbGVhc2UgcmVtb3ZlIG9mX25vZGVfcHV0KCkuCj4gPiAKPiA+IExvb2tz
IGxpa2Ugc28uIFJlcGxhY2luZyBpdCB3aXRoIHB1dF9kZXZpY2UoJmlvbW11X3BkZXYtPmRldik7
Cj4gCj4gUHV0dGluZyB0aGUgcHV0X2RldmljZSgpIGhlcmUgaXMgd3JvbmcsIHRob3VnaC4gWW91
IG5lZWQgdG8gbWFrZSBzdXJlCj4geW91IGtlZXAgYSByZWZlcmVuY2UgdG8gaXQgYXMgbG9uZyBh
cyB5b3Uga2VlcCBhY2Nlc3NpbmcgdGhlIGRhdGEgdGhhdAo+IGlzIG93bmVkIGJ5IGl0LgoKSSBh
bSBjb25mdXNlZC4gWW91IHNhaWQgaW4gdGhlIG90aGVyIHJlcGx5ICh0byBEbWl0cnkpIHRoYXQg
d2UgZG8KbmVlZCB0byBwdXRfZGV2aWNlKG1jLT5kZXYpLCB3aGVyZSBtYy0+ZGV2IHNob3VsZCBi
ZSB0aGUgc2FtZSBhcwppb21tdV9wZGV2LT5kZXYuIEJ1dCBoZXJlIHlvdXIgY29tbWVudHMgc291
bmRzIHRoYXQgd2Ugc2hvdWxkIG5vdApwdXRfZGV2aWNlIGF0IGFsbCBzaW5jZSAtPnByb2JlX2Rl
dmljZS9ncm91cF9kZXZpY2UvYXR0YWNoX2RldigpCndpbGwgdXNlIGl0IGxhdGVyLgoKPiBMaWtl
IEkgc2FpZCBlYXJsaWVyLCB0aGlzIGlzIGEgYml0IHdlaXJkIGluIHRoaXMgY2FzZSBiZWNhdXNl
IHdlJ3JlCj4gc2VsZi1yZWZlcmVuY2luZywgc28gaW9tbXVfcGRldi0+ZGV2IGlzIGdvaW5nIHRv
IHN0YXkgYXJvdW5kIGFzIGxvbmcgYXMKPiB0aGUgU01NVSBpcy4gSG93ZXZlciwgaXQgbWlnaHQg
YmUgd29ydGggdG8gcHJvcGVybHkgdHJhY2sgdGhlIGxpZmV0aW1lCj4gYW55d2F5IGp1c3Qgc28g
dGhhdCB0aGUgY29kZSBjYW4gc2VydmUgYXMgYSBnb29kIGV4YW1wbGUgb2YgaG93IHRvIGRvCj4g
dGhpbmdzLgoKV2hhdCdzIHRoaXMgInRyYWNrLXRoZS1saWZldGltZSI/Cgo+IElmIHlvdSBkZWNp
ZGUgdG8gZ28gZm9yIHRoZSBzaG9ydGN1dCBhbmQgbm90IHRyYWNrIHRoaXMgcmVmZXJlbmNlCj4g
cHJvcGVybHksIHRoZW4gYXQgbGVhc3QgeW91IG5lZWQgdG8gYWRkIGEgY29tbWVudCBhcyB0byB3
aHkgaXQgaXMgc2FmZQo+IHRvIGRvIGluIHRoaXMgY2FzZS4gVGhpcyBlbnN1cmVzIHRoYXQgcmVh
ZGVycyBhcmUgYXdheSBvZiB0aGUKPiBjaXJjdW1zdGFuY2VzIGFuZCBkb24ndCBjb3B5IHRoaXMg
YmFkIGNvZGUgaW50byBhIGNvbnRleHQgd2hlcmUgdGhlCj4gY2lyY3Vtc3RhbmNlcyBhcmUgZGlm
ZmVyZW50LgoKSSBkb24ndCBxdWl0ZSBnZXQgdGhpcyAic2hvcnRjdXQiIGhlcmUgZWl0aGVyLi4u
bWluZCBlbGFib3JhdGluZz8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
