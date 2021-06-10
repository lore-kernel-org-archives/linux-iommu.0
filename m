Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2EEC48BDF
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 19:41:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D771613BD
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 19:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D771613BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFE094066B;
	Thu, 10 Jun 2021 19:41:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VlGAj7ArWQ6Y; Thu, 10 Jun 2021 19:41:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7213D4065F;
	Thu, 10 Jun 2021 19:41:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B015C000D;
	Thu, 10 Jun 2021 19:41:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F234CC000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 19:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD33540662
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 19:41:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YbnjTVZZhKvh for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 19:41:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C6DA4065F
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 19:41:49 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id x14so6497192ljp.7
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 12:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ubXcbWgPRSI/FTTW821ibjosi1m1kp9EFIWEYpojr7U=;
 b=bZ1vnoT4gwchAfrORftPU/AdkdJzWMgCfShdVVXXijvp8wDeUduK7IBl//RUT2Ulm6
 XHwuXVz/fsjsDcz4/BqhCamb74xI5Th27omkUefoltHlyZNm8IN025o/5HJtRgCTEN5C
 XqraxBQxk3IbfMlBbb/rG1fSyDxIiTuTaPetc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ubXcbWgPRSI/FTTW821ibjosi1m1kp9EFIWEYpojr7U=;
 b=LfPZH/n0ZiNYcQucuf+hvv7cqH4QyxxJMqsubYmzoJBwXweztn5PFg+uXWVaSwdzwp
 Wc4CWnk5A5+l9FSCSp6wxH6NoJfLihm92AY4nEBOkCjIiCAXSWvb3BXQpEGloJfUNYzn
 DGfxgiEuNhUl9bc4Rp/vFopnYZftbPw3HcFRq2AL6jfeakdz8dooy8aE4rtlYWHR0D7M
 WgijdhV41yv5plH59hQigZHVJUhoGmwc1pYyWMIkG+D+4a7Lg3W9vQT/B5mMSuY66bKF
 /FvNQlU1FUMhXmh6WRoCHCvYF4W47X+AcNqbbw2T0ry++2frZiLkbwqLSGw/oGXypizb
 MIHw==
X-Gm-Message-State: AOAM531545OVrfTawfYZOTPna+ujQkh+2EhQNmHohH6hFSWRW73ghu8t
 BET/+VAap+4tgKjQVSI+/c/zsvUz7URdwDfrcfLXVQ==
X-Google-Smtp-Source: ABdhPJyXZsYThPbsKXZcV4XjpwuMnBdUX7hLFwYclKW8NbTOAu4Fqo5ExyYyGMHlgDaYROWM+b1CYw==
X-Received: by 2002:a2e:155e:: with SMTP id 30mr166945ljv.316.1623354106721;
 Thu, 10 Jun 2021 12:41:46 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com.
 [209.85.208.172])
 by smtp.gmail.com with ESMTPSA id v138sm386254lfa.63.2021.06.10.12.41.43
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jun 2021 12:41:43 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 131so6529902ljj.3
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 12:41:43 -0700 (PDT)
X-Received: by 2002:a05:651c:383:: with SMTP id
 e3mr174508ljp.220.1623354103227; 
 Thu, 10 Jun 2021 12:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <YDkbCHHBUOmfI59K@Konrads-MacBook-Pro.local>
 <YL7XXNOnbaDgmTB9@atmark-techno.com>
 <2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com>
In-Reply-To: <2e899de2-4b69-c4b6-33a6-09fb8949d2fd@nxp.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 10 Jun 2021 12:41:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKAdWpSav4+qYT4_LDSQm=7pO8RqKEoQoJsyDVtTCk3Q@mail.gmail.com>
Message-ID: <CAHk-=wiKAdWpSav4+qYT4_LDSQm=7pO8RqKEoQoJsyDVtTCk3Q@mail.gmail.com>
Subject: Re: swiotlb/caamjr regression (Was: [GIT PULL] (swiotlb)
 stable/for-linus-5.12)
To: =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, 
 Christoph Hellwig <hch@lst.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Content-Type: multipart/mixed; boundary="000000000000ab0cc405c46e9439"
Cc: Dominique MARTINET <dominique.martinet@atmark-techno.com>,
 Aymen Sghaier <aymen.sghaier@nxp.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Lukas Hartmann <lukas@mntmn.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jianxiong Gao <jxgao@google.com>
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--000000000000ab0cc405c46e9439
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 10, 2021 at 7:52 AM Horia Geant=C4=83 <horia.geanta@nxp.com> wr=
ote:
>
> Documentation/core-api/dma-api.rst explicitly allows for partial syncs:
> Synchronise a single contiguous or scatter/gather mapping for the CPU
> and device. With the sync_sg API, all the parameters must be the same
> as those passed into the single mapping API. With the sync_single API,
> you can use dma_handle and size parameters that aren't identical to
> those passed into the single mapping API to do a partial sync.
>
> AFAICS commit 16fc3cef33a0 ("swiotlb: don't modify orig_addr in swiotlb_t=
bl_sync_single")
> is breaking this functionality.

How about a patch like the attached? Does that fix things for you.

Christoph? Comments - that commit removed the offset calculation
entirely, because the old

        (unsigned long)tlb_addr & (IO_TLB_SIZE - 1)

was wrong, but instead of removing it, I think it should have just
fixed it to be

        (tlb_addr - mem->start) & (IO_TLB_SIZE - 1);

instead. That way the slot offset always matches the slot index calculation=
.

I also made it then take the offset into account for the alloc_size checks.

Does this UNTESTED patch perhaps do the right thing?

                    Linus

--000000000000ab0cc405c46e9439
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_kprb3vx00>
X-Attachment-Id: f_kprb3vx00

IGtlcm5lbC9kbWEvc3dpb3RsYi5jIHwgOSArKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9rZXJuZWwvZG1hL3N3aW90bGIuYyBiL2tlcm5lbC9k
bWEvc3dpb3RsYi5jCmluZGV4IDhjYTdkNTA1ZDYxYy4uZjYzZDE1ZTk0ZDM1IDEwMDY0NAotLS0g
YS9rZXJuZWwvZG1hL3N3aW90bGIuYworKysgYi9rZXJuZWwvZG1hL3N3aW90bGIuYwpAQCAtMzQy
LDYgKzM0Miw3IEBAIHN0YXRpYyB2b2lkIHN3aW90bGJfYm91bmNlKHN0cnVjdCBkZXZpY2UgKmRl
diwgcGh5c19hZGRyX3QgdGxiX2FkZHIsIHNpemVfdCBzaXplCiB7CiAJc3RydWN0IGlvX3RsYl9t
ZW0gKm1lbSA9IGlvX3RsYl9kZWZhdWx0X21lbTsKIAlpbnQgaW5kZXggPSAodGxiX2FkZHIgLSBt
ZW0tPnN0YXJ0KSA+PiBJT19UTEJfU0hJRlQ7CisJdW5zaWduZWQgbG9uZyBvZmZzZXQgPSAodGxi
X2FkZHIgLSBtZW0tPnN0YXJ0KSAmIChJT19UTEJfU0laRSAtIDEpOwogCXBoeXNfYWRkcl90IG9y
aWdfYWRkciA9IG1lbS0+c2xvdHNbaW5kZXhdLm9yaWdfYWRkcjsKIAlzaXplX3QgYWxsb2Nfc2l6
ZSA9IG1lbS0+c2xvdHNbaW5kZXhdLmFsbG9jX3NpemU7CiAJdW5zaWduZWQgbG9uZyBwZm4gPSBQ
Rk5fRE9XTihvcmlnX2FkZHIpOwpAQCAtMzUwLDYgKzM1MSwxNCBAQCBzdGF0aWMgdm9pZCBzd2lv
dGxiX2JvdW5jZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHBoeXNfYWRkcl90IHRsYl9hZGRyLCBzaXpl
X3Qgc2l6ZQogCWlmIChvcmlnX2FkZHIgPT0gSU5WQUxJRF9QSFlTX0FERFIpCiAJCXJldHVybjsK
IAorCWlmIChvZmZzZXQgPiBhbGxvY19zaXplKSB7CisJCWRldl9XQVJOX09OQ0UoZGV2LCAxLAor
CQkJIkJ1ZmZlciBvdmVyZmxvdyBkZXRlY3RlZC4gT2Zmc2V0OiAlbHUuIE1hcHBpbmcgc2l6ZTog
JXp1LlxuIiwKKwkJCW9mZnNldCwgc2l6ZSk7CisJCXJldHVybjsKKwl9CisJYWxsb2Nfc2l6ZSAt
PSBvZmZzZXQ7CisJb3JpZ19hZGRyICs9IG9mZnNldDsKIAlpZiAoc2l6ZSA+IGFsbG9jX3NpemUp
IHsKIAkJZGV2X1dBUk5fT05DRShkZXYsIDEsCiAJCQkiQnVmZmVyIG92ZXJmbG93IGRldGVjdGVk
LiBBbGxvY2F0aW9uIHNpemU6ICV6dS4gTWFwcGluZyBzaXplOiAlenUuXG4iLAo=
--000000000000ab0cc405c46e9439
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--000000000000ab0cc405c46e9439--
