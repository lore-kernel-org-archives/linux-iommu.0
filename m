Return-Path: <SRS0=Mf8z=KM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A04C433B4
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 12:18:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D726261241
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 12:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D726261241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99CB8404CB;
	Mon, 17 May 2021 12:18:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v60C45gMRC2C; Mon, 17 May 2021 12:17:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F5A8402D3;
	Mon, 17 May 2021 12:17:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E95CC000D;
	Mon, 17 May 2021 12:17:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5007C0001
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 12:17:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A60AD404B8
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 12:17:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jIuJcFhMBTDk for <iommu@lists.linux-foundation.org>;
 Mon, 17 May 2021 12:17:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A1F6B402D3
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 12:17:51 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 t10-20020a05683022eab0290304ed8bc759so5312470otc.12
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 05:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zEU6CzFgEsXFctNNyZP0I8tPhrQAXlBinqVRaGycqaw=;
 b=nQh/rgWDfcKxibJ1P5lnanSBbO/cAyfCxVquNA3WeP7GaaOAcSoYbw88Y0Kab281IH
 VNRvUXiWxUwVBM+JyU3M/5pUaW233FtE/mUDw3goDeePBFZ4Rwi/yq8jlSMXCMlkQZTL
 TN11iGLhiydgCxmE9Q1TS7STAeCrfyQK/9olpD4BotQCgN/Z9JYjW2/mIvqsPkHHOO9S
 WnseZxDOda5cHggwVaQFMZnQZ9ckc9tG+mJBPwVbgqZhz/biAdZq71qefsAAKOS+PgVc
 1IfxUeFA3CwccAa6NX3Av2i1B4nXlXtvbBCh5v77MyMZKMKwCq4P8vBjxl89Ma9uPpJ2
 3J7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zEU6CzFgEsXFctNNyZP0I8tPhrQAXlBinqVRaGycqaw=;
 b=L0jYRVua3+V+hZj4bH2swOSsuPbAzqsxIqDU69r0NJ9WaZJLctrHwqfL+B+0+6GNFk
 UCe1pbXV0QmGCOEYAgq92czvVLEpg5a+tftE26NdBrN3WNsvKDLiNnyvJE0CGvvGgYEx
 xMHMCgG1KZRfLowtnPz7mgNv7rdytng3ot/8zm2Gxi+zsYaB+xyN/Ujos4uLhQYqMsSP
 EIKR76ihkOrrYEg9u2kty7TvmsbUU5aSv62jzE4B77GegdQAJWpoklJQOqXp5346A+XM
 RBN0tnIT4CkUYMSp6/cIPKyRUk5vvnqjaYeMHXuBSuuGYlI6J3E9eAqKSfzKR7NUHC/X
 iRMA==
X-Gm-Message-State: AOAM5319slnSDu+OEsYcZ4+hXpLdV20mJaqGkDOexTd5EpqmmGV8U6ON
 OoRvxOp6lwBDzn7hXHuj3hC4ZjKlFoRei+GBmlA=
X-Google-Smtp-Source: ABdhPJwLn1YFkqRfXLgmIKLo5xNZffSk6I/sK/iwtQhUKND0ZTqHq9MTOqVk0U69ENPn8I9ygRoZSzHbWRW9F5WqebQ=
X-Received: by 2002:a9d:4e96:: with SMTP id v22mr31832024otk.134.1621253870688; 
 Mon, 17 May 2021 05:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <e0e9ecf4-cfd7-b31a-29b0-ead4a6c0ee40@charleswright.co>
 <1621180418@msgid.manchmal.in-ulm.de> <YKI/D64ODBUEHO9M@kroah.com>
 <1621251453@msgid.manchmal.in-ulm.de> <1621251685@msgid.manchmal.in-ulm.de>
In-Reply-To: <1621251685@msgid.manchmal.in-ulm.de>
From: Jack Wang <jack.wang.usish@gmail.com>
Date: Mon, 17 May 2021 14:17:39 +0200
Message-ID: <CA+res+RHyF22T-sGwCG5zA6EBrk_gWbnZETX_iAgdRdWaPLbfw@mail.gmail.com>
Subject: Re: 5.10.37 won't boot on my system, but 5.10.36 with same config does
To: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Cc: iommu@lists.linux-foundation.org, stable <stable@vger.kernel.org>
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

K2NjIGlvbW11IGxpc3QuCgpDaHJpc3RvcGggQmllZGwgPGxpbnV4LWtlcm5lbC5iZnJ6QG1hbmNo
bWFsLmluLXVsbS5kZT4g5LqOMjAyMeW5tDXmnIgxN+aXpeWRqOS4gCDkuIvljYgxOjUy5YaZ6YGT
77yaCj4KPiBDaHJpc3RvcGggQmllZGwgd3JvdGUuLi4KPgo+ID4gVGhhbmtzIGZvciB0YWtpbmcg
Y2FyZSwgdW5mb3J0dW5hdGVseSBubyBpbXByb3ZlbWVudCB3aXRoIDUuMTAuMzgtcmMxIGhlcmUu
Cj4KPiBTbyBpbiBjYXNlIHRoaXMgaXMgcmVsYXRlZCB0byB0aGUgLmNvbmZpZywgSSdtIGF0dGFj
aGluZyBpdC4gSGFyZHdhcmUgaXMsCj4gYXMgc2FpZCBiZWZvcmUsIGFuIG9sZCBUaGlua3BhZCB4
MjAwLCB2ZW5kb3IgQklPUyBhbmQgbm8gcGFydGljdWxhciBtb2RpZmljYXRpb25zLgo+IEFmdGVy
IGRpc2FibGluZyBhbGwgdmdhL3ZpZGVvL2ZiY29uIHBhcmFtZXRlcnMgSSBzZWUgdGhlIHN5c3Rl
bSBzdWZmZXJzCj4gYSBrZXJuZWwgcGFuaWMgYnV0IHVuZm9ydHVuYXRlbHkgb25seSB0aGUgbGFz
dCAyNSBsaW5lcyBhcmUgdmlzaWJsZS4KPiBQb3NzaWJseSAodHlwb3MgYXJlIG1pbmUpCj4KPiAg
ICAgUklQOiAwMDEwOl9fZG9tYWluX21hcHBpbmcrMHhhNy8weDNhMAo+Cj4gaXMgYSBoaW50IGlu
dG8gdGhlIHJpZ2h0IGRpcmVjdGlvbj8KVGhpcyBsb29rcyBpbnRlbF9pb21tdSByZWxhdGVkLCBj
YW4geW91IHRyeSBib290IHdpdGgKImludGVsX2lvbW11PW9mZiIgaW4ga2VybmVsIHBhcmFtZXRl
cj8KPgo+ICAgICBDaGlzdG9waAoKUmVnYXJkcywKSmFjayBXYW5nCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
