Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC41C4332F
	for <iommu@archiver.kernel.org>; Sat, 19 Feb 2022 18:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67629402E1;
	Sat, 19 Feb 2022 18:49:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HHqmjFYGkBS4; Sat, 19 Feb 2022 18:49:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 35536402CA;
	Sat, 19 Feb 2022 18:49:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB997C0035;
	Sat, 19 Feb 2022 18:49:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 340C6C0033
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 18:49:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 222FB813D5
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 18:49:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QGFdpW9WRLM1 for <iommu@lists.linux-foundation.org>;
 Sat, 19 Feb 2022 18:49:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6D3CF80CD0
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 18:49:14 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id p22so11345032lfu.5
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 10:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=7YhVG8Dy+S1k40YAXhEZryTJrbvkmx9GiFs6+GPhuaQ=;
 b=H2eafIb0d+gnPTeQfQp3hdpbyrFDjuxHlgGunCA2MiiBccQeIlixC6yWs5I08xT0nN
 Xdxjxk6Mzk8p+BE7e+dKuSRT5dolF+XjEsJlja7p0ETEvEEvuH8Yh4dlWKRoZ4iZ8OXR
 U2uMxEimT2NduF42uHLQHUyEfjdv17in99/lWPBlj/UL2FNWAnSXBzrBQJDMu+DCgkAH
 rM5Bvsb9e5s2clBjZTXORVVjUxCWI1VNQIWotvuonsawBYM+5GZBhOaAS/1YLepiFidN
 FhhGEihUOKgcKs01grZCKhcxkiknAkYyU1UNow5+2vpKdwOxLKw3yYdKAJcq9QIwFmjy
 ZvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=7YhVG8Dy+S1k40YAXhEZryTJrbvkmx9GiFs6+GPhuaQ=;
 b=Jgtl+SeMOAUFKVnvnGDbvNJ1WTFdg1qobhRjgsA5daa6qsk8COcygavMuS5PHget9r
 FurFQXRi3Lo7rx+4SM8toks9wX3eh/pne36TCiVzCCY0sSHfvL0Q6vbgE58HdcJy1HNf
 9b1/roRbjzBBDAtsvSk7s2Uj7mlIArdAwcIdCrd0cpiwbsyx1QT/fMh6/CPYJbZ5r8XL
 kmUxh5oU6ZP3oZNEGUpY81MC7lVgntuMVuoKuowR1eVHUzVxso5r5ocTMIoW70kwH4hb
 7jfoG1IulXRAvGGsCYz/cFPZk7IiHc9jRYwNPxztpIRxi0j7lMOEPTXQE53ZqDTJd1A6
 iT/A==
X-Gm-Message-State: AOAM533GXcBfildMNjblXymJNw1EfRL6hy+EQ6CRInVuQQkSipb6vne5
 /LY3YjCnZUVUxXiVF+WI0kw=
X-Google-Smtp-Source: ABdhPJxu4c7EAYfGM/Z+Iq7ORPC+Om71HaUK4ew3FTkSHXyN9PFMoo+/wBKUzofOsjvEek347LaSWQ==
X-Received: by 2002:a05:6512:3f91:b0:43e:da3e:464b with SMTP id
 x17-20020a0565123f9100b0043eda3e464bmr9015660lfa.673.1645296552456; 
 Sat, 19 Feb 2022 10:49:12 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru.
 [109.252.138.165])
 by smtp.googlemail.com with ESMTPSA id y18sm737447ljd.13.2022.02.19.10.49.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Feb 2022 10:49:12 -0800 (PST)
Message-ID: <b1df816b-6838-c435-1a23-5029144e4cfe@gmail.com>
Date: Sat, 19 Feb 2022 21:49:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 8/9] drm/tegra: vic: Implement get_streamid_offset
Content-Language: en-US
To: Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
 jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
 robin.murphy@arm.com
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-9-mperttunen@nvidia.com>
From: Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220218113952.3077606-9-mperttunen@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

MTguMDIuMjAyMiAxNDozOSwgTWlra28gUGVydHR1bmVuINC/0LjRiNC10YI6Cj4gK3N0YXRpYyBp
bnQgdmljX2dldF9zdHJlYW1pZF9vZmZzZXQoc3RydWN0IHRlZ3JhX2RybV9jbGllbnQgKmNsaWVu
dCkKPiArewo+ICsJc3RydWN0IHZpYyAqdmljID0gdG9fdmljKGNsaWVudCk7Cj4gKwlpbnQgZXJy
Owo+ICsKPiArCWVyciA9IHZpY19sb2FkX2Zpcm13YXJlKHZpYyk7CgpZb3UgY2FuJ3QgaW52b2tl
IHZpY19sb2FkX2Zpcm13YXJlKCkgd2hpbGUgUlBNIGlzIHN1c3BlbmRlZC4gRWl0aGVyCnJlcGxh
Y2UgdGhpcyB3aXRoIFJQTSBnZXQvcHV0IG9yIGRvIHNvbWV0aGluZyBlbHNlLgoKPiArCWlmIChl
cnIgPCAwKQo+ICsJCXJldHVybiBlcnI7Cj4gKwo+ICsJaWYgKHZpYy0+Y2FuX3VzZV9jb250ZXh0
KQo+ICsJCXJldHVybiAweDMwOwo+ICsJZWxzZQo+ICsJCXJldHVybiAtRU5PVFNVUFA7CgpJZiAo
IXZpYy0+Y2FuX3VzZV9jb250ZXh0KQoJcmV0dXJuIC1FTk9UU1VQUDsKCnJldHVybiAweDMwOwpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
