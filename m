Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2535C2D0A8
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 06:33:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CF32075F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 06:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCNo5Ppl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CF32075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BA5F4846BF;
	Wed, 30 Sep 2020 06:33:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OtQ6bXhVBF8T; Wed, 30 Sep 2020 06:33:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 955E1842EA;
	Wed, 30 Sep 2020 06:33:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81D49C0889;
	Wed, 30 Sep 2020 06:33:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9283C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 06:33:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B547885087
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 06:33:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kN3EF7UlO1bI for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 06:33:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
 [209.85.167.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C0CA485039
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 06:33:39 +0000 (UTC)
Received: by mail-lf1-f66.google.com with SMTP id y11so756308lfl.5
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 23:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cTva/fInjcmUyKGUHD5UOEzgklOiXw7AjHa/QF4Vx2o=;
 b=CCNo5PplUtPPi6hvkBl6F9bub4USTbO5JvgHVgT1X5BVj3LGff7Dfx0zVE36yF6jsk
 EevUSHH76pmO9GHACimTSPiepjdECfbF+FSph4NY4SsWItrN3mMq/E3ISASD8YqB7mes
 bfBPJoYq9jnKrJ5topoPVjTcVDFvIn67JgvNKBsTDjWwoZtqrNIZBS4dkr7f2hKvgT1l
 Vh3eX2twDk6BoYYdJO2bf2CR96XuspruFSnno5A5Rw0pgL710/ULvgtl6EqlwHFMSotf
 7Kf87PN001Cys7rpolS5q6notSIu4yz/07tReFBJsWdZ/vyRpfaLJj4IImLV6sKnB3tp
 3nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cTva/fInjcmUyKGUHD5UOEzgklOiXw7AjHa/QF4Vx2o=;
 b=DiBJ5C7J4UlHDORC/rqpcBT+vgOhkdXWc2sXfjqxQjldsfyb0fGUdWpbvx9v5A/dao
 xmOkYDH/lqlAnua6YsECvBAz+MBJh9von1DqtOgECsDaTtgOcAJhJdu/fZq32u8jZ6K4
 /GLvCHSfL7Ein0a9bWNhZv7waIANQumyj0fQ+8xcXfzs/4Fna4WnXBz4EA8VSzPPDnql
 LHfoxigaQx0N6Ufi6kaqY6C5ODfS4wVegG/3M0EJ888ILNh6QCEt9hIlj8vLGXdw1wZI
 VxPJoLGhbxG0Pu0KAdLZryb4GkzL+/gEBM7FZjGXvH7Dge6KeZ+m6sTG/fpGdDij02VE
 vblw==
X-Gm-Message-State: AOAM531lniin8Gft3Uuf/oqwBQ7xH6MW+HREJAgJZY131YVdRFOHCgpV
 TOqW7wohdMsbzVChSorcwRY=
X-Google-Smtp-Source: ABdhPJyGj5pQos1peHaz/TXt7sAbZCOpMQN/7F0sL/YA0v9CsfRem6gaONh+yqpGtmMVtcROh44VZg==
X-Received: by 2002:ac2:5dd4:: with SMTP id x20mr304525lfq.593.1601447618031; 
 Tue, 29 Sep 2020 23:33:38 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id m13sm73838lfl.269.2020.09.29.23.33.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 23:33:37 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-3-nicoleotsuka@gmail.com>
 <75514da5-e63a-9e51-8376-abbd12c324d1@gmail.com>
 <20200930054900.GG31821@Asurada-Nvidia>
 <b74f96cf-0edc-c7f2-3a0e-2a4fe51e3b2e@gmail.com>
 <20200930061351.GA16460@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9a1ec0bf-3020-2045-229c-a350c9c9fc2e@gmail.com>
Date: Wed, 30 Sep 2020 09:33:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930061351.GA16460@Asurada-Nvidia>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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

MzAuMDkuMjAyMCAwOToxMywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gV2VkLCBTZXAg
MzAsIDIwMjAgYXQgMDk6MTA6MzhBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAz
MC4wOS4yMDIwIDA4OjQ5LCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+IE9uIFdlZCwgU2Vw
IDMwLCAyMDIwIGF0IDA4OjExOjUyQU0gKzAzMDAsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPj4+
PiAzMC4wOS4yMDIwIDAzOjMwLCBOaWNvbGluIENoZW4g0L/QuNGI0LXRgjoKPj4+Pj4gKwkvKiBB
biBpbnZhbGlkIG1jIHBvaW50ZXIgbWVhbnMgbWMgYW5kIHNtbXUgZHJpdmVycyBhcmUgbm90IHJl
YWR5ICovCj4+Pj4+ICsJaWYgKElTX0VSUl9PUl9OVUxMKG1jKSkKPj4+Pgo+Pj4+IHRlZ3JhX2dl
dF9tZW1vcnlfY29udHJvbGxlcigpIGRvZXNuJ3QgcmV0dXJuIE5VTEwuCj4+Pgo+Pj4gV2VsbCwg
SSBkb24ndCB3YW50IHRvIGFzc3VtZSB0aGF0IGl0J2QgZG8gdGhhdCBmb3JldmVyLCBhbmQgdGhl
Cj4+PiBOVUxMIGNoZWNrIG9mIElTX0VSUl9PUl9OVUxMIGlzIG1hcmtlZCAidW5saWtlbHkiIHNv
IGl0IGRvZXNuJ3QKPj4+IGh1cnQgdG8gaGF2ZS4KPj4+Cj4+Cj4+IEkgZG9uJ3Qgc2VlIGFueSBy
ZWFzb25zIHdoeSBpdCB3b24ndCBkbyB0aGF0IGZvcmV2ZXIuCj4+Cj4+IFNlY29uZGx5LCBwdWJs
aWMgZnVuY3Rpb24gY2FuJ3QgYmUgY2hhbmdlZCByYW5kb21seSB3aXRob3V0IHVwZGF0aW5nIGFs
bAo+PiB0aGUgY2FsbGVycy4KPj4KPj4gSGVuY2UgdGhlcmUgaXMgbm8gbmVlZCB0byBoYW5kbGUg
Y2FzZXMgdGhhdCBjYW4ndCBldmVyIGhhcHBlbiBhbmQgaXQKPj4gaHVydHMgcmVhZGFiaWxpdHkg
b2YgdGhlIGNvZGUgKyBvcmlnaW5hbCBlcnJvciBjb2RlIGlzIG1pc3NlZC4KPiAKPiBJIGRvbid0
IHF1aXRlIHVuZGVyc3RhbmQgd2h5IGFuIGV4dHJhICJfT1JfTlVMTCIgd291bGQgaHVydAo+IHJl
YWRhYmlsaXR5Li4uLmJ1dCBJJ2QgdGFrZSBhIHN0ZXAgYmFjayBhbmQgdXNlIElTX0VSUigpLgo+
IAoKVGhlIHRlZ3JhX2dldF9tZW1vcnlfY29udHJvbGxlcigpIGRvZXNuJ3QgcmV0dXJuIE5VTEws
IGhlbmNlIHRoZQpOVUxMLWNoZWNrIGlzIG1pc2xlYWRpbmcuCgpJZiBJIHdhcyByZWFkaW5nIHRo
YXQgY29kZSBmb3IgdGhlIGZpcnN0IHRpbWUgYW5kIG5vdGljZSBzdWNoIGEgdGhpbmcsCnRoZW4g
aW5zdGFudGx5IEknZCBoYXZlIGEgbXVjaCBsb3dlciBjcmVkaWJpbGl0eSB0byB0aGUgd2hvbGUg
Y29kZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
