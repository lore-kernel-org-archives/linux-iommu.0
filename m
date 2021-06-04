Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732ACC47082
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 01:29:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244AA613FF
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 01:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244AA613FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D94B9400F3;
	Fri,  4 Jun 2021 01:29:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cE5_MQBiFHi7; Fri,  4 Jun 2021 01:29:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id CFD37405F3;
	Fri,  4 Jun 2021 01:29:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC6B1C000E;
	Fri,  4 Jun 2021 01:29:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59995C0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 01:29:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3AC984068E
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 01:29:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IskoZByQ-Zz4 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 01:29:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 45A104068F
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 01:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622770158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/MGaP9q9f0JKQhqX62iqN0ZP08JFP5du6nrkmNfcZI=;
 b=K/HQSMU4LBVYpz00V1PPKjKhDMrTDf3NbQeokcJY/KZ1gwFMnyQsSZVRHXvKCYQMHwRpwM
 HxrpXfWZjLstkN++epmqAL2GWEw0KWUuwsCvIJhLeLCREABiej2cCjKpeeHsjE4VSxWC2J
 lBZ/h+FnIFWli49CMH7Eq7lm5nEu4RM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-2m6haamyNhuoWhxt81Maog-1; Thu, 03 Jun 2021 21:29:17 -0400
X-MC-Unique: 2m6haamyNhuoWhxt81Maog-1
Received: by mail-pf1-f200.google.com with SMTP id
 j206-20020a6280d70000b02902e9e02e1654so4462928pfd.6
 for <iommu@lists.linux-foundation.org>; Thu, 03 Jun 2021 18:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=T/MGaP9q9f0JKQhqX62iqN0ZP08JFP5du6nrkmNfcZI=;
 b=WNi0YP7nmOl4PPIKIGjrsQGFpMk7CT9ZYNvGF9H+Wy1nKQ19Wd7do3lmq+Z4S29tzW
 Xy41U6lKOubUCOnFxW3B/5gk8YFDM09U0YU6ZTDgEga0OkCkdYryq4gDexts+o9H3azk
 9V+cZAcoYuPlwUL+PTpXQODzXBlCIU4DWtRobFFTSHDSW1F9Jwm/aDAUVMksryb+NiOx
 r+NDz+RqukpF4imz7lccou5IY54/HMOsl6FDQx+J4NvS62iV4oyH74WdCm2hOIAlEvx9
 R6i4hVQmPEsnGtmsaMZA/5NLVaKvqRw8TjZSqM9cHyEWKWzh8Xhc+DWOjg8a5DOrbTgD
 ElBg==
X-Gm-Message-State: AOAM5304oiN2wVSRDgKR1ai/gbkzz1J4QCNTJr0ZFVUHPQKmoJnfXzo4
 Ie+XTqzRvnWF6xIXi2HJ4su2fBwq7gqiTk4ST7/ZEe6Isq3oyrf5UaImmQBCoJ+wlCNAJJQFdeE
 DSmk3FDuh2j2RSLqI+Jo3+5y1Cd4t4w==
X-Received: by 2002:a17:90b:1b4f:: with SMTP id
 nv15mr14342926pjb.56.1622770156274; 
 Thu, 03 Jun 2021 18:29:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwux6m9f0rUpQpP+RF5uS/fzFDKk5OPQIJa3aqTa1QYQjfa9K3fazTvsDkqAod+yFl7P/Fs/Q==
X-Received: by 2002:a17:90b:1b4f:: with SMTP id
 nv15mr14342903pjb.56.1622770155986; 
 Thu, 03 Jun 2021 18:29:15 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id h12sm289129pgn.54.2021.06.03.18.29.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 18:29:15 -0700 (PDT)
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To: Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
 <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4b071a9f-3683-b990-ddc2-450ac5a10388@redhat.com>
Date: Fri, 4 Jun 2021 09:29:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 jpoimboe@redhat.com, robin.murphy@arm.com, hch@lst.de
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzYvNCDkuIrljYgyOjAwLCBBbmRpIEtsZWVuIOWGmemBkzoKPgo+IE9uIDYvMy8y
MDIxIDEwOjMzIEFNLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6Cj4+IE9uIDYvMi8yMSA1OjQxIFBN
LCBBbmRpIEtsZWVuIHdyb3RlOgo+Pj4gT25seSBhbGxvdyBzcGxpdCBtb2RlIHdoZW4gaW4gYSBw
cm90ZWN0ZWQgZ3Vlc3QuIEZvbGxvd29uCj4+PiBwYXRjaGVzIGhhcmRlbiB0aGUgc3BsaXQgbW9k
ZSBjb2RlIHBhdGhzLCBhbmQgd2UgZG9uJ3Qgd2FudAo+Pj4gYW4gbWFsaWNpb3VzIGhvc3QgdG8g
Zm9yY2UgYW55dGhpbmcgZWxzZS4gQWxzbyBkaXNhbGxvdwo+Pj4gaW5kaXJlY3QgbW9kZSBmb3Ig
c2ltaWxhciByZWFzb25zLgo+PiBJIHJlYWQgdGhpcyBhcyAidGhlIHZpcnRpbyBkcml2ZXIgaXMg
YnVnZ3kuwqAgTGV0J3MgZGlzYWJsZSBtb3N0IG9mIHRoZQo+PiBidWdneSBjb2RlIGluIG9uZSBz
cGVjaWFsIGNhc2UgaW4gd2hpY2ggd2UgbmVlZCBhIGRyaXZlciB3aXRob3V0IGJ1Z3MuCj4+IElu
IGFsbCB0aGUgb3RoZXIgY2FzZXMgKGUuZy4gaGFyZHdhcmUgdmlydGlvIGRldmljZSBjb25uZWN0
ZWQgb3Zlcgo+PiBVU0ItQyksIGRyaXZlciBidWdzIGFyZSBzdGlsbCBhbGxvd2VkLiIKPgo+IE15
IHVuZGVyc3RhbmRpbmcgaXMgbW9zdCBvZiB0aGUgb3RoZXIgbW9kZXMgKGV4Y2VwdCBmb3Igc3Bs
aXQgd2l0aCAKPiBzZXBhcmF0ZSBkZXNjcmlwdG9ycykgYXJlIG9ic29sZXRlIGFuZCBqdXN0IHRo
ZXJlIGZvciBjb21wYXRpYmlsaXR5LiAKPiBBcyBsb25nIGFzIHRoZXkncmUgZGVwcmVjYXRlZCB0
aGV5IHdvbid0IGhhcm0gYW55b25lLgo+Cj4gLUFuZGkKPgoKRm9yICJtb2RlIiBkbyB5b3UgcGFj
a2VkIHZzIHNwbGl0PyBJZiB5ZXMsIGl0J3Mgbm90IGp1c3QgZm9yIApjb21wYXRpYmlsaXR5LiBU
aG91Z2ggcGFja2VkIHZpcnRxdWV1ZSBpcyBkZXNpZ25lZCB0byBiZSBtb3JlIGhhcmR3YXJlIApm
cmllbmRseSwgbW9zdCBoYXJkd2FyZSB2ZW5kb3JzIGNob29zZSB0byBzdGFydCBmcm9tIHNwbGl0
LgoKVGhhbmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
