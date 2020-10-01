Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE2CC4363D
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 02:54:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9473E221EF
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 02:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icsVsbr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9473E221EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4418A87293;
	Thu,  1 Oct 2020 02:54:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LxB8YJHD5nm4; Thu,  1 Oct 2020 02:54:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4D1A28728A;
	Thu,  1 Oct 2020 02:54:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 227C8C016F;
	Thu,  1 Oct 2020 02:54:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DB0CC0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 02:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8B36186789
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 02:54:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZQgkeseUke0p for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 02:54:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 26A0B8582C
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 02:54:33 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id 7so2780424pgm.11
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 19:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=KJi4ba1o7OEmQx07SGkY7nXm0TQ/hVgl3GIotn3ANWo=;
 b=icsVsbr4uO5Wp5/f5LgBnFO4SPOkAf7fycnO2bW7r8Yq6fOScvXwXoFGQhK6aTWktT
 gUiJt6FFpFygsbyRT73JYR4JZGJHE54C5JT5Vmy1XbgI3Mu8G6T5PTeFYq+uC+IBpDDP
 JHc0QqmQFjUlNKXKuGrGQf6G0XS/t5aNf+zJGPHWjU7LfHXjtwWXFGn/HWtsM1yhfCl5
 Bcu/+b5VlxlwW9TWRYVbfQCHpa/uSiMmHYaVkrZFJLquIpR6X2NSnA6z+O4ybR+FGxYJ
 OsQ251ORTZ4xBKOHPt0PZ3g7oBJi+lFsRDgoGBaptFhB2Zrnw4v515u8Z6yj/YQ07OGy
 2Y0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=KJi4ba1o7OEmQx07SGkY7nXm0TQ/hVgl3GIotn3ANWo=;
 b=sKd+71GOjUfJ2iR+NeDWunu0DjWl6b00RRt0C1esp/KXmP2BkNJUZfppoQ8f921Ndm
 t+4E/lXlS/bLq2K/P7c9wqIAnEF0ezOumqPBEpydqbR12Sl7rZbQwABt6lfseRXlVuuK
 LmflWTb0Ww1kip5o79kB3v60rOm8f5TP2bnrPuFvVxOlFLZm02SdMgJKvO25ZuOhZ4fr
 U/IMKFkMVs4VG7FT4i8OlUJwDtz9FBF6h1Az9m8oSKz9GP9Xx0ZoWQ6jQjvMPV2j5yUv
 G+jlppgzk9b/Tjr0iPBXVDg4UhE3CxDa5UHcI91dik70hhAXtd4LQx3iBDcaMV01LM4y
 iwfg==
X-Gm-Message-State: AOAM533ghTb2XBZfwpNtrapO7FTJ29rXvf4M2Mzb7OTFp1ysrs9nQZYy
 kOfydm4PywvVVU2GUZ05nbE=
X-Google-Smtp-Source: ABdhPJwnS01CLMBYPUaSVwPd6+pnekEkWjRFV6Kf726LqsVavVn2ZtKWEdaXKRzMbxDeOp7RMzL1KQ==
X-Received: by 2002:a63:6306:: with SMTP id x6mr4644910pgb.161.1601520872517; 
 Wed, 30 Sep 2020 19:54:32 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id w203sm4412626pff.0.2020.09.30.19.54.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Sep 2020 19:54:32 -0700 (PDT)
Date: Wed, 30 Sep 2020 19:48:50 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20201001024850.GA28456@Asurada-Nvidia>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <20200930153131.GB3833404@ulmo>
 <20200930203618.GC2110@Asurada-Nvidia>
 <13746922-0253-cda7-e9ac-2bd20bf1a17f@gmail.com>
 <20200930213244.GA10573@Asurada-Nvidia>
 <5945a63e-79d8-e3ae-ab53-cee8c220ac7d@gmail.com>
 <20201001012630.GA28240@Asurada-Nvidia>
 <72b11925-5857-8ce5-d084-cab01ca1b396@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <72b11925-5857-8ce5-d084-cab01ca1b396@gmail.com>
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

T24gVGh1LCBPY3QgMDEsIDIwMjAgYXQgMDU6MDY6MTlBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDAxLjEwLjIwMjAgMDQ6MjYsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
T24gVGh1LCBPY3QgMDEsIDIwMjAgYXQgMTI6NTY6NDZBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+ID4+IDAxLjEwLjIwMjAgMDA6MzIsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+
ID4+PiBPbiBUaHUsIE9jdCAwMSwgMjAyMCBhdCAxMjoyNDoyNUFNICswMzAwLCBEbWl0cnkgT3Np
cGVua28gd3JvdGU6Cj4gPj4+PiAuLi4KPiA+Pj4+Pj4gSXQgbG9va3MgdG8gbWUgbGlrZSB0aGUg
b25seSByZWFzb24gd2h5IHlvdSBuZWVkIHRoaXMgbmV3IGdsb2JhbCBBUEkgaXMKPiA+Pj4+Pj4g
YmVjYXVzZSBQQ0kgZGV2aWNlcyBtYXkgbm90IGhhdmUgYSBkZXZpY2UgdHJlZSBub2RlIHdpdGgg
YSBwaGFuZGxlIHRvCj4gPj4+Pj4+IHRoZSBJT01NVS4gSG93ZXZlciwgU01NVSBzdXBwb3J0IGZv
ciBQQ0kgd2lsbCBvbmx5IGJlIGVuYWJsZWQgaWYgdGhlCj4gPj4+Pj4+IHJvb3QgY29tcGxleCBo
YXMgYW4gaW9tbXVzIHByb3BlcnR5LCByaWdodD8gSW4gdGhhdCBjYXNlLCBjYW4ndCB3ZQo+ID4+
Pj4+PiBzaW1wbHkgZG8gc29tZXRoaW5nIGxpa2UgdGhpczoKPiA+Pj4+Pj4KPiA+Pj4+Pj4gCWlm
IChkZXZfaXNfcGNpKGRldikpCj4gPj4+Pj4+IAkJbnAgPSBmaW5kX2hvc3RfYnJpZGdlKGRldikt
Pm9mX25vZGU7Cj4gPj4+Pj4+IAllbHNlCj4gPj4+Pj4+IAkJbnAgPSBkZXYtPm9mX25vZGU7Cj4g
Pj4+Pj4+Cj4gPj4+Pj4+ID8gSSdtIG5vdCBzdXJlIGV4YWN0bHkgd2hhdCBmaW5kX2hvc3RfYnJp
ZGdlKCkgaXMgY2FsbGVkLCBidXQgSSdtIHByZXR0eQo+ID4+Pj4+PiBzdXJlIHRoYXQgZXhpc3Rz
Lgo+ID4+Pj4+Pgo+ID4+Pj4+PiBPbmNlIHdlIGhhdmUgdGhhdCB3ZSBjYW4gc3RpbGwgaXRlcmF0
ZSBvdmVyIHRoZSBpb21tdXMgcHJvcGVydHkgYW5kIGRvCj4gPj4+Pj4+IG5vdCBuZWVkIHRvIHJl
bHkgb24gdGhpcyBnbG9iYWwgdmFyaWFibGUuCj4gPj4+Pj4KPiA+Pj4+PiBJIGFncmVlIHRoYXQg
aXQnZCB3b3JrLiBCdXQgSSB3YXMgaG9waW5nIHRvIHNpbXBsaWZ5IHRoZSBjb2RlCj4gPj4+Pj4g
aGVyZSBpZiBpdCdzIHBvc3NpYmxlLiBMb29rcyBsaWtlIHdlIGhhdmUgYW4gYXJndW1lbnQgb24g
dGhpcwo+ID4+Pj4+IHNvIEkgd2lsbCBjaG9vc2UgdG8gZ28gd2l0aCB5b3VyIHN1Z2dlc3Rpb24g
YWJvdmUgZm9yIG5vdy4KPiA+Pj4+Cj4gPj4+PiBUaGlzIHBhdGNoIHJlbW92ZWQgbW9yZSBsaW5l
cyB0aGFuIHdlcmUgYWRkZWQuIElmIHRoaXMgd2lsbCBiZSBvcHBvc2l0ZQo+ID4+Pj4gZm9yIHRo
ZSBUaGllcnJ5J3Mgc3VnZ2VzdGlvbiwgdGhlbiBpdCdzIHByb2JhYmx5IG5vdCBhIGdyZWF0IHN1
Z2dlc3Rpb24uCj4gPj4+Cj4gPj4+IFNvcnJ5LCBJIGRvbid0IHF1aXRlIHVuZGVyc3RhbmQgdGhp
cyBjb21tZW50cy4gV291bGQgeW91IHBsZWFzZQo+ID4+PiBlbGFib3JhdGUgd2hhdCdzIHRoaXMg
Iml0IiBiZWluZyAibm90IGEgZ3JlYXQgc3VnZ2VzdGlvbiI/Cj4gPj4+Cj4gPj4KPiA+PiBJIG1l
YW50IHRoYXQgeW91IHNob3VsZCB0cnkgdG8gaW1wbGVtZW50IFRoaWVycnkncyBzb2x1dGlvbiwg
YnV0IGlmIHRoZQo+ID4+IGVuZCByZXN1bHQgd2lsbCBiZSB3b3JzZSB0aGFuIHRoZSBjdXJyZW50
IHBhdGNoLCB0aGVuIHlvdSBzaG91bGRuJ3QgbWFrZQo+ID4+IGEgdjQsIGJ1dCBnZXQgYmFjayB0
byB0aGlzIGRpc2N1c3Npb24gaW4gb3JkZXIgdG8gY2hvb3NlIHRoZSBiZXN0IG9wdGlvbgo+ID4+
IGFuZCBtYWtlIGV2ZXJ5b25lIGFncmVlIG9uIGl0Lgo+ID4gCj4gPiBJIHNlZS4gVGhhbmtzIGZv
ciB0aGUgcmVwbHkuIEFuZCBoZXJlIGlzIGEgc2FtcGxlIGltcGxlbWVudGF0aW9uOgo+IAo+IFRo
YXQncyB3aGF0IEkgc3VwcG9zZWQgdG8gaGFwcGVuIDopIFRoZSBuZXcgdmFyaWFudCBhZGRzIGNv
ZGUgYW5kCj4gY29tcGxleGl0eSwgd2hpbGUgb2xkIGRpZCB0aGUgb3Bwb3NpdGUuIEhlbmNlIHRo
ZSBvbGQgdmFyaWFudCBpcyBjbGVhcmx5Cj4gbW9yZSBhdHRyYWN0aXZlLCBJTU8uCgpJIHBlcnNv
bmFsbHkgYW0gbm90IGEgZmFuIG9mIGFkZGluZyBhIHBhdGggZm9yIFBDSSBkZXZpY2UgZWl0aGVy
LApzaW5jZSBQQ0kvSU9NTVUgY29yZXMgY291bGQgaGF2ZSB0YWtlbiBjYXJlIG9mIGl0IHdoaWxl
IHRoZSBzYW1lCnBhdGggY2FuJ3QgYmUgdXNlZCBmb3Igb3RoZXIgYnVzZXMuCgpJZiB3ZSBjYW4n
dCBjb21lIHRvIGFuIGFncmVlbWVudCBvbiBnbG9iYWxpemluZyBtYyBwb2ludGVyLCB3b3VsZApp
dCBiZSBwb3NzaWJsZSB0byBwYXNzIHRlZ3JhX21jX2RyaXZlciB0aHJvdWdoIHRlZ3JhX3NtbXVf
cHJvYmUoKQpzbyB3ZSBjYW4gY29udGludWUgdG8gdXNlIGRyaXZlcl9maW5kX2RldmljZV9ieV9m
d25vZGUoKSBhcyB2MT8KCnYxOiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC85LzI2LzY4Cl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
